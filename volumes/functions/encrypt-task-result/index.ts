/**
 * 加密任务结果 Edge Function
 * 
 * 参与者提交任务结果时，使用研究员的 DEK 加密数据
 * 这样研究员可以解密查看评分数据
 */

import { serve } from 'https://deno.land/std@0.168.0/http/server.ts'
import { corsHeaders } from '../_shared/cors.ts'
import { createClient } from 'https://esm.sh/@supabase/supabase-js@2'
import { decrypt as decryptWithMasterKey } from '../_shared/crypto.ts'
import { encryptWithDEK, base64ToBytes } from '../_shared/envelope-crypto.ts'

serve(async (req) => {
  if (req.method === 'OPTIONS') {
    return new Response('ok', { headers: corsHeaders })
  }

  try {
    // 获取认证用户（参与者）
    const authHeader = req.headers.get('Authorization')
    if (!authHeader) {
      throw new Error('Missing Authorization header')
    }

    const supabaseClient = createClient(
      Deno.env.get('SUPABASE_URL') ?? '',
      Deno.env.get('SUPABASE_ANON_KEY') ?? '',
      { global: { headers: { Authorization: authHeader } } }
    )

    const { data: { user }, error: authError } = await supabaseClient.auth.getUser()
    if (authError || !user) {
      throw new Error('Unauthorized')
    }

    const body = await req.json()
    const { session_id, node_id, input_data, output_data } = body

    if (!session_id || !node_id) {
      throw new Error('Missing session_id or node_id')
    }

    const supabaseAdmin = createClient(
      Deno.env.get('SUPABASE_URL') ?? '',
      Deno.env.get('SUPABASE_SERVICE_ROLE_KEY') ?? ''
    )

    // 获取 session 信息，验证参与者权限并获取实验的研究员 ID
    const { data: session, error: sessionError } = await supabaseAdmin
      .from('experiment_sessions')
      .select('experiment_id, participant_id')
      .eq('session_id', session_id)
      .single()

    if (sessionError || !session) {
      throw new Error('Session not found')
    }

    // 验证当前用户是该 session 的参与者
    if (session.participant_id !== user.id) {
      throw new Error('Access denied: Not the session participant')
    }

    // 获取实验的研究员 ID
    const { data: experiment, error: expError } = await supabaseAdmin
      .from('experiments')
      .select('researcher_id')
      .eq('experiment_id', session.experiment_id)
      .single()

    if (expError || !experiment) {
      throw new Error('Experiment not found')
    }

    // 获取研究员的 server_encrypted_dek
    const { data: researcherProfile, error: profileError } = await supabaseAdmin
      .from('profiles')
      .select('server_encrypted_dek')
      .eq('id', experiment.researcher_id)
      .single()

    if (profileError) {
      throw new Error('Failed to fetch researcher profile')
    }

    let encryptedInputData = input_data
    let encryptedOutputData = output_data

    // 如果研究员有 server_encrypted_dek，使用它加密数据
    if (researcherProfile?.server_encrypted_dek) {
      const masterKey = Deno.env.get('MASTER_ENCRYPTION_KEY')
      if (!masterKey) {
        throw new Error('MASTER_ENCRYPTION_KEY not configured')
      }

      try {
        // 用 Master Key 解密研究员的 DEK
        const dekBase64 = await decryptWithMasterKey(researcherProfile.server_encrypted_dek, masterKey)
        const researcherDEK = base64ToBytes(dekBase64)

        // 用研究员的 DEK 加密数据
        if (input_data) {
          const inputJson = typeof input_data === 'string' ? input_data : JSON.stringify(input_data)
          encryptedInputData = await encryptWithDEK(inputJson, researcherDEK)
        }

        if (output_data) {
          const outputJson = typeof output_data === 'string' ? output_data : JSON.stringify(output_data)
          encryptedOutputData = await encryptWithDEK(outputJson, researcherDEK)
        }
      } catch (e) {
        console.error('Failed to encrypt with researcher DEK:', e)
        // 如果加密失败，保存未加密数据
      }
    }

    // 保存到数据库
    const { data: result, error: insertError } = await supabaseAdmin
      .from('task_results')
      .insert({
        session_id,
        node_id,
        input_data: encryptedInputData,
        output_data: encryptedOutputData,
      })
      .select('result_id')
      .single()

    if (insertError) {
      throw new Error('Failed to save task result: ' + insertError.message)
    }

    return new Response(JSON.stringify({
      success: true,
      result_id: result?.result_id
    }), {
      headers: { ...corsHeaders, 'Content-Type': 'application/json' }
    })

  } catch (error: any) {
    console.error('Encrypt Task Result Error:', error)
    return new Response(JSON.stringify({ error: error.message }), {
      status: 400,
      headers: { ...corsHeaders, 'Content-Type': 'application/json' }
    })
  }
})
