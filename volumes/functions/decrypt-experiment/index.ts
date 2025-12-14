/**
 * 实验数据解密 Edge Function
 * 
 * 用于参与者获取解密后的实验数据
 * 使用研究员的 DEK（服务端备份）解密 workflow_json 和 evaluation_config
 * 
 * 架构:
 * 1. 研究员创建实验时，用自己的 DEK 加密敏感数据
 * 2. 研究员的 DEK 有一个用 Master Key 加密的备份 (server_encrypted_dek)
 * 3. 参与者请求实验数据时，服务端用 Master Key 解密研究员的 DEK
 * 4. 然后用研究员的 DEK 解密实验数据返回给参与者
 */

import { serve } from 'https://deno.land/std@0.168.0/http/server.ts'
import { corsHeaders } from '../_shared/cors.ts'
import { createClient } from 'https://esm.sh/@supabase/supabase-js@2'
import { decrypt as decryptWithMasterKey } from '../_shared/crypto.ts'
import { decryptWithDEK, base64ToBytes } from '../_shared/envelope-crypto.ts'

serve(async (req) => {
  if (req.method === 'OPTIONS') {
    return new Response('ok', { headers: corsHeaders })
  }

  try {
    // 获取认证用户
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
    const { action, experiment_id, data: encryptedData } = body

    const supabaseAdmin = createClient(
      Deno.env.get('SUPABASE_URL') ?? '',
      Deno.env.get('SUPABASE_SERVICE_ROLE_KEY') ?? Deno.env.get('SERVICE_ROLE_KEY') ?? ''
    )

    const masterKey = Deno.env.get('MASTER_ENCRYPTION_KEY')
    if (!masterKey) {
      throw new Error('MASTER_ENCRYPTION_KEY not configured')
    }

    switch (action) {
      case 'get-experiment': {
        // 获取解密后的实验数据
        if (!experiment_id) {
          throw new Error('experiment_id required')
        }

        // 获取实验数据
        const { data: experiment, error: expError } = await supabaseAdmin
          .from('experiments')
          .select('*')
          .eq('experiment_id', experiment_id)
          .single()

        if (expError || !experiment) {
          throw new Error('Experiment not found')
        }

        // 检查用户是否有权限访问（通过 experiment_sessions 或是研究员）
        const { data: session } = await supabaseAdmin
          .from('experiment_sessions')
          .select('session_id')
          .eq('experiment_id', experiment_id)
          .eq('participant_id', user.id)
          .limit(1)
          .maybeSingle()

        const isResearcher = experiment.researcher_id === user.id
        const isParticipant = !!session

        if (!isResearcher && !isParticipant) {
          throw new Error('Access denied: You are not authorized to view this experiment')
        }

        // 获取研究员的 server_encrypted_dek
        const { data: researcherProfile } = await supabaseAdmin
          .from('profiles')
          .select('server_encrypted_dek')
          .eq('id', experiment.researcher_id)
          .single()

        let researcherDEK: Uint8Array | null = null
        if (researcherProfile?.server_encrypted_dek && masterKey) {
          try {
            // 用 Master Key 解密研究员的 DEK
            const dekBase64 = await decryptWithMasterKey(researcherProfile.server_encrypted_dek, masterKey)
            researcherDEK = base64ToBytes(dekBase64)
          } catch (e) {
            console.error('Failed to decrypt researcher DEK:', e)
          }
        }

        // 解密 workflow_json 和 evaluation_config
        let workflow_json = experiment.workflow_json
        let evaluation_config = experiment.evaluation_config

        // 如果有研究员的 DEK，尝试用它解密
        if (researcherDEK) {
          if (typeof workflow_json === 'string' && isLikelyEncrypted(workflow_json)) {
            try {
              const decrypted = await decryptWithDEK(workflow_json, researcherDEK)
              workflow_json = JSON.parse(decrypted)
            } catch (e) {
              console.error('Failed to decrypt workflow_json with DEK:', e)
            }
          }

          if (typeof evaluation_config === 'string' && isLikelyEncrypted(evaluation_config)) {
            try {
              const decrypted = await decryptWithDEK(evaluation_config, researcherDEK)
              evaluation_config = JSON.parse(decrypted)
            } catch (e) {
              console.error('Failed to decrypt evaluation_config with DEK:', e)
            }
          }
        }

        // 如果还是字符串，尝试解析为 JSON（可能是未加密的 JSON 字符串）
        if (typeof workflow_json === 'string') {
          try {
            workflow_json = JSON.parse(workflow_json)
          } catch {
            // 保持原样
          }
        }

        if (typeof evaluation_config === 'string') {
          try {
            evaluation_config = JSON.parse(evaluation_config)
          } catch {
            // 保持原样
          }
        }

        return new Response(JSON.stringify({
          success: true,
          experiment: {
            ...experiment,
            workflow_json,
            evaluation_config
          }
        }), {
          headers: { ...corsHeaders, 'Content-Type': 'application/json' }
        })
      }

      case 'decrypt': {
        // 通用解密接口
        if (!encryptedData) {
          throw new Error('data required for decryption')
        }

        try {
          const decrypted = await decrypt(encryptedData, masterKey)
          // 尝试解析为 JSON
          let result
          try {
            result = JSON.parse(decrypted)
          } catch {
            result = decrypted
          }

          return new Response(JSON.stringify({
            success: true,
            data: result
          }), {
            headers: { ...corsHeaders, 'Content-Type': 'application/json' }
          })
        } catch (e: any) {
          throw new Error('Decryption failed: ' + e.message)
        }
      }

      case 'decrypt-task-results': {
        // 解密任务结果 - 用于参与者查看实验结果
        const { session_id, researcher_id } = body
        if (!session_id) {
          throw new Error('session_id required')
        }

        // 获取任务结果
        const { data: taskResults, error: trError } = await supabaseAdmin
          .from('task_results')
          .select('*')
          .eq('session_id', session_id)
          .order('created_at', { ascending: true })

        if (trError) {
          throw new Error('Failed to fetch task results: ' + trError.message)
        }

        if (!taskResults || taskResults.length === 0) {
          return new Response(JSON.stringify({
            success: true,
            results: []
          }), {
            headers: { ...corsHeaders, 'Content-Type': 'application/json' }
          })
        }

        // 获取研究员的 DEK
        let researcherDEK: Uint8Array | null = null
        if (researcher_id) {
          const { data: researcherProfile } = await supabaseAdmin
            .from('profiles')
            .select('server_encrypted_dek')
            .eq('id', researcher_id)
            .single()

          if (researcherProfile?.server_encrypted_dek && masterKey) {
            try {
              const dekBase64 = await decryptWithMasterKey(researcherProfile.server_encrypted_dek, masterKey)
              researcherDEK = base64ToBytes(dekBase64)
            } catch (e) {
              console.error('Failed to decrypt researcher DEK:', e)
            }
          }
        }

        // 解密每个任务结果的 input_data 和 output_data
        const decryptedResults = await Promise.all(taskResults.map(async (result: any) => {
          let input_data = result.input_data
          let output_data = result.output_data

          if (researcherDEK) {
            // 解密 input_data
            if (typeof input_data === 'string' && isLikelyEncrypted(input_data)) {
              try {
                const decrypted = await decryptWithDEK(input_data, researcherDEK)
                try {
                  input_data = JSON.parse(decrypted)
                } catch {
                  input_data = decrypted
                }
              } catch (e) {
                console.error('Failed to decrypt input_data:', e)
              }
            }

            // 解密 output_data
            if (typeof output_data === 'string' && isLikelyEncrypted(output_data)) {
              try {
                const decrypted = await decryptWithDEK(output_data, researcherDEK)
                try {
                  output_data = JSON.parse(decrypted)
                } catch {
                  output_data = decrypted
                }
              } catch (e) {
                console.error('Failed to decrypt output_data:', e)
              }
            }
          }

          return {
            ...result,
            input_data,
            output_data
          }
        }))

        return new Response(JSON.stringify({
          success: true,
          results: decryptedResults
        }), {
          headers: { ...corsHeaders, 'Content-Type': 'application/json' }
        })
      }

      default:
        throw new Error(`Unknown action: ${action}`)
    }

  } catch (error: any) {
    console.error('Decrypt Experiment Error:', error)
    return new Response(JSON.stringify({ error: error.message }), {
      status: 400,
      headers: { ...corsHeaders, 'Content-Type': 'application/json' }
    })
  }
})

function isLikelyEncrypted(value: string): boolean {
  if (!value || value.length < 20) return false
  
  // Base64 字符集检查
  const base64Regex = /^[A-Za-z0-9+/]+=*$/
  if (!base64Regex.test(value)) return false
  
  // 如果包含中文或明显的 JSON 结构，未加密
  if (/[\u4e00-\u9fa5]/.test(value)) return false
  if (value.startsWith('{') || value.startsWith('[')) return false
  
  return true
}
