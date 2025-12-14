/**
 * 用户 DEK 管理 Edge Function
 * 
 * 功能:
 * - 创建用户 DEK (注册时)
 * - 恢复用户 DEK (登录时)
 * - 重新加密 DEK (修改密码时)
 * - 使用 DEK 加密/解密数据
 */

import { serve } from 'https://deno.land/std@0.168.0/http/server.ts'
import { corsHeaders } from '../_shared/cors.ts'
import { createClient } from 'https://esm.sh/@supabase/supabase-js@2'
import {
  createUserDEK,
  recoverUserDEK,
  reencryptDEK,
  encryptWithDEK,
  decryptWithDEK,
  UserDEKInfo,
  bytesToBase64,
  base64ToBytes
} from '../_shared/envelope-crypto.ts'
import { encrypt as encryptWithMasterKey } from '../_shared/crypto.ts'

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
    const { action, password, newPassword, data } = body

    const supabaseAdmin = createClient(
      Deno.env.get('SUPABASE_URL') ?? '',
      Deno.env.get('SUPABASE_SERVICE_ROLE_KEY') ?? Deno.env.get('SERVICE_ROLE_KEY') ?? ''
    )

    switch (action) {
      case 'get': {
        // 获取用户 DEK 信息 (不含解密后的 DEK，仅加密信息用于前端解密)
        const { data: profile, error: profileError } = await supabaseAdmin
          .from('profiles')
          .select('encrypted_dek, dek_salt, dek_iv')
          .eq('id', user.id)
          .single()

        if (profileError) {
          throw new Error('Failed to fetch user profile')
        }

        if (!profile?.encrypted_dek) {
          return new Response(JSON.stringify({
            error: 'DEK not found',
            message: 'User has no DEK. Create one first.'
          }), {
            status: 404,
            headers: { ...corsHeaders, 'Content-Type': 'application/json' }
          })
        }

        return new Response(JSON.stringify({
          encryptedDEK: profile.encrypted_dek,
          salt: profile.dek_salt,
          iv: profile.dek_iv
        }), {
          headers: { ...corsHeaders, 'Content-Type': 'application/json' }
        })
      }

      case 'create': {
        // 创建新 DEK (用于新用户注册)
        if (!password) {
          throw new Error('Password required for creating DEK')
        }

        // 检查用户是否已有 DEK
        const { data: profile } = await supabaseAdmin
          .from('profiles')
          .select('encrypted_dek')
          .eq('id', user.id)
          .single()

        if (profile?.encrypted_dek) {
          throw new Error('User already has a DEK')
        }

        // 创建 DEK
        const { dek, info } = await createUserDEK(password)

        // 用 Master Key 创建服务端可解密的备份
        const masterKey = Deno.env.get('MASTER_ENCRYPTION_KEY')
        let serverEncryptedDek: string | null = null
        if (masterKey && masterKey !== 'your-master-key-here-if-needed') {
          // 将 DEK 用 Master Key 加密存储
          serverEncryptedDek = await encryptWithMasterKey(bytesToBase64(dek), masterKey)
        }

        // 保存到数据库
        const updateData: any = {
          encrypted_dek: info.encryptedDEK,
          dek_salt: info.salt,
          dek_iv: info.dekIV
        }
        if (serverEncryptedDek) {
          updateData.server_encrypted_dek = serverEncryptedDek
        }

        const { error: updateError } = await supabaseAdmin
          .from('profiles')
          .update(updateData)
          .eq('id', user.id)

        if (updateError) throw updateError

        return new Response(JSON.stringify({
          success: true,
          message: 'DEK created successfully'
        }), {
          headers: { ...corsHeaders, 'Content-Type': 'application/json' }
        })
      }

      case 'encrypt': {
        // 使用用户 DEK 加密数据
        if (!password || !data) {
          throw new Error('Password and data required for encryption')
        }

        // 获取用户 DEK 信息
        const { data: profile, error: profileError } = await supabaseAdmin
          .from('profiles')
          .select('encrypted_dek, dek_salt, dek_iv')
          .eq('id', user.id)
          .single()

        if (profileError || !profile?.encrypted_dek) {
          throw new Error('No DEK found for user. Please create one first.')
        }

        // 恢复 DEK
        const dekInfo: UserDEKInfo = {
          encryptedDEK: profile.encrypted_dek,
          salt: profile.dek_salt,
          dekIV: profile.dek_iv
        }
        const dek = await recoverUserDEK(dekInfo, password)

        // 加密数据
        const encryptedData = await encryptWithDEK(data, dek)

        return new Response(JSON.stringify({
          success: true,
          encryptedData
        }), {
          headers: { ...corsHeaders, 'Content-Type': 'application/json' }
        })
      }

      case 'decrypt': {
        // 使用用户 DEK 解密数据
        if (!password || !data) {
          throw new Error('Password and encrypted data required for decryption')
        }

        // 获取用户 DEK 信息
        const { data: profile, error: profileError } = await supabaseAdmin
          .from('profiles')
          .select('encrypted_dek, dek_salt, dek_iv')
          .eq('id', user.id)
          .single()

        if (profileError || !profile?.encrypted_dek) {
          throw new Error('No DEK found for user.')
        }

        // 恢复 DEK
        const dekInfo: UserDEKInfo = {
          encryptedDEK: profile.encrypted_dek,
          salt: profile.dek_salt,
          dekIV: profile.dek_iv
        }
        const dek = await recoverUserDEK(dekInfo, password)

        // 解密数据
        const decryptedData = await decryptWithDEK(data, dek)

        return new Response(JSON.stringify({
          success: true,
          decryptedData
        }), {
          headers: { ...corsHeaders, 'Content-Type': 'application/json' }
        })
      }

      case 'change-password': {
        // 修改密码时重新加密 DEK
        if (!password || !newPassword) {
          throw new Error('Current password and new password required')
        }

        // 获取用户 DEK 信息
        const { data: profile, error: profileError } = await supabaseAdmin
          .from('profiles')
          .select('encrypted_dek, dek_salt, dek_iv')
          .eq('id', user.id)
          .single()

        if (profileError || !profile?.encrypted_dek) {
          throw new Error('No DEK found for user.')
        }

        // 用旧密码恢复 DEK
        const dekInfo: UserDEKInfo = {
          encryptedDEK: profile.encrypted_dek,
          salt: profile.dek_salt,
          dekIV: profile.dek_iv
        }
        
        let dek: Uint8Array
        try {
          dek = await recoverUserDEK(dekInfo, password)
        } catch {
          throw new Error('Invalid current password')
        }

        // 用新密码重新加密 DEK
        const newInfo = await reencryptDEK(dek, newPassword)

        // 同时用 Master Key 重新加密（确保 server_encrypted_dek 也是最新的）
        const masterKey = Deno.env.get('MASTER_ENCRYPTION_KEY')
        let serverEncryptedDek: string | null = null
        if (masterKey && masterKey !== 'your-master-key-here-if-needed') {
          serverEncryptedDek = await encryptWithMasterKey(bytesToBase64(dek), masterKey)
        }

        // 更新数据库
        const updateData: any = {
          encrypted_dek: newInfo.encryptedDEK,
          dek_salt: newInfo.salt,
          dek_iv: newInfo.dekIV
        }
        if (serverEncryptedDek) {
          updateData.server_encrypted_dek = serverEncryptedDek
        }

        const { error: updateError } = await supabaseAdmin
          .from('profiles')
          .update(updateData)
          .eq('id', user.id)

        if (updateError) throw updateError

        return new Response(JSON.stringify({
          success: true,
          message: 'DEK re-encrypted with new password'
        }), {
          headers: { ...corsHeaders, 'Content-Type': 'application/json' }
        })
      }

      case 'update-server-dek': {
        // 为已有 DEK 的用户生成/更新 server_encrypted_dek
        // 需要用户密码来解密现有 DEK，然后用 Master Key 重新加密
        // 每次登录都会调用此函数，确保 server_encrypted_dek 使用当前的 Master Key
        if (!password) {
          throw new Error('Password required')
        }

        // 获取用户现有的 DEK 信息
        const { data: profile, error: profileError } = await supabaseAdmin
          .from('profiles')
          .select('encrypted_dek, dek_salt, dek_iv, server_encrypted_dek')
          .eq('id', user.id)
          .single()

        if (profileError || !profile?.encrypted_dek) {
          throw new Error('User has no DEK')
        }

        // 用密码解密 DEK
        const dekInfo: UserDEKInfo = {
          encryptedDEK: profile.encrypted_dek,
          salt: profile.dek_salt,
          dekIV: profile.dek_iv
        }
        
        let dek: Uint8Array
        try {
          dek = await recoverUserDEK(dekInfo, password)
        } catch {
          throw new Error('Invalid password')
        }

        // 用 Master Key 加密 DEK
        const masterKey = Deno.env.get('MASTER_ENCRYPTION_KEY')
        if (!masterKey || masterKey === 'your-master-key-here-if-needed') {
          throw new Error('MASTER_ENCRYPTION_KEY not configured')
        }

        const serverEncryptedDek = await encryptWithMasterKey(bytesToBase64(dek), masterKey)

        // 更新数据库（始终更新，确保使用当前的 Master Key）
        const { error: updateError } = await supabaseAdmin
          .from('profiles')
          .update({ server_encrypted_dek: serverEncryptedDek })
          .eq('id', user.id)

        if (updateError) throw updateError

        return new Response(JSON.stringify({
          success: true,
          message: 'server_encrypted_dek updated successfully'
        }), {
          headers: { ...corsHeaders, 'Content-Type': 'application/json' }
        })
      }

      default:
        throw new Error(`Unknown action: ${action}`)
    }

  } catch (error: any) {
    console.error('User DEK Error:', error)
    return new Response(JSON.stringify({ error: error.message || 'Unknown error' }), {
      status: 400,
      headers: { ...corsHeaders, 'Content-Type': 'application/json' }
    })
  }
})
