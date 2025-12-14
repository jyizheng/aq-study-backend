import { serve } from 'https://deno.land/std@0.168.0/http/server.ts'
import { corsHeaders } from '../_shared/cors.ts'
import { createClient } from 'https://esm.sh/@supabase/supabase-js@2'
import { decrypt } from '../_shared/crypto.ts'

serve(async (req) => {
  console.log('run-coze-bot invoked', req.method, req.url)
  if (req.method === 'OPTIONS') {
    return new Response('ok', { headers: corsHeaders })
  }

  try {
    const masterKey = Deno.env.get('MASTER_ENCRYPTION_KEY')
    if (!masterKey) {
      throw new Error('Server configuration error: MASTER_ENCRYPTION_KEY is not set')
    }

    console.log('Reading request body...')
    let body;
    try {
      body = await req.json()
    } catch (e) {
      console.error('Failed to parse JSON:', e)
      throw new Error('Invalid JSON body')
    }
    console.log('Request body read:', body)

    const { bot_id, user_id, message, conversation_id } = body
    if (!bot_id || !message) {
      throw new Error('Missing "bot_id" or "message"')
    }

    console.log('Connecting to Supabase Admin...')
    const supabaseUrl = Deno.env.get('SUPABASE_URL') ?? ''
    const serviceRoleKey = Deno.env.get('SUPABASE_SERVICE_ROLE_KEY') ?? ''
    const supabaseAdmin = createClient(supabaseUrl, serviceRoleKey)

    // 查询 bot 配置（复用 coze_workflows 表，type='bot'）
    console.log('Querying bot config...')
    const { data: botRow, error: botError } = await supabaseAdmin
      .from('coze_workflows')
      .select('api_key, ep_url')
      .eq('workflow_id', bot_id)
      .eq('type', 'bot')
      .maybeSingle()

    if (botError) {
      console.error('Failed to load bot credentials:', botError.message)
      throw new Error('Failed to load bot credentials')
    }

    let cozeApiKey: string | null = null

    if (botRow?.api_key) {
      try {
        cozeApiKey = await decrypt(botRow.api_key, masterKey)
      } catch (decryptError) {
        console.error('Failed to decrypt bot API key:', decryptError)
        throw new Error('Failed to decrypt bot API key')
      }
    }

    if (!cozeApiKey) {
      const fallbackKey = Deno.env.get('COZE_API_KEY')
      if (!fallbackKey) {
        throw new Error('No API key available for the requested bot')
      }
      cozeApiKey = fallbackKey
    }

    console.log('Using Coze API Key for bot')

    if (!botRow?.ep_url) {
      throw new Error('Configuration error: "ep_url" is not set for this bot. Please configure it in the dashboard.')
    }

    // 构造 Coze Bot Chat API 请求
    const url = `${botRow.ep_url}/v3/chat`
    const headers = {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Authorization': `Bearer ${cozeApiKey}`,
    }

    const payload: Record<string, any> = {
      bot_id,
      user_id: user_id || bot_id, // 如果没有提供 user_id，使用 bot_id
      stream: true,
      auto_save_history: true,
      additional_messages: [
        {
          role: "user",
          content: message,
          content_type: "text"
        }
      ]
    }

    // 如果提供了 conversation_id，加入请求体以保持上下文
    if (conversation_id) {
      payload.conversation_id = conversation_id
    }

    const signal = AbortSignal.timeout(600000) // 10 分钟超时

    console.log('Fetching from Coze Bot API:', url)
    const cozeResponse = await fetch(url, {
      method: 'POST',
      headers,
      body: JSON.stringify(payload),
      signal,
    })
    console.log('Coze Bot response status:', cozeResponse.status)

    if (!cozeResponse.ok) {
      const errorDetails = await cozeResponse.text()
      console.error('Coze Bot API Error:', errorDetails)
      return new Response(JSON.stringify({
        error: 'Coze Bot API request failed',
        status: cozeResponse.status,
        details: errorDetails,
      }), {
        status: cozeResponse.status,
        headers: { ...corsHeaders, 'Content-Type': 'application/json' },
      })
    }

    // 处理流式响应，收集完整回复
    const reader = cozeResponse.body?.getReader()
    if (!reader) {
      throw new Error('Failed to get response reader')
    }

    const decoder = new TextDecoder()
    let fullContent = ''
    let resultConversationId: string | null = null
    let chatId: string | null = null
    let buffer = ''
    let currentEvent = ''
    let streamError: string | null = null

    try {
      while (true) {
        const { done, value } = await reader.read()
        
        if (done) {
          // Process any remaining buffer
          if (buffer.trim()) {
             console.log('Processing remaining buffer:', buffer)
             const lines = buffer.split('\n')
             for (const line of lines) {
                processLine(line)
             }
          }
          break
        }

        const chunk = decoder.decode(value, { stream: true })
        buffer += chunk
        const lines = buffer.split('\n')
        // Keep the last part in the buffer as it might be incomplete
        buffer = lines.pop() ?? ''

        for (const line of lines) {
            processLine(line)
        }
      }
    } finally {
      reader.releaseLock()
    }

    function processLine(line: string) {
          if (line.startsWith('event:')) {
            currentEvent = line.substring(6).trim()
            // console.log('Event:', currentEvent)
          } else if (line.startsWith('data:')) {
            const dataStr = line.substring(5).trim()
            if (!dataStr) return

            try {
              const eventData = JSON.parse(dataStr)

              // 捕获 conversation_id 和 chat_id
              if (eventData.conversation_id && !resultConversationId) {
                resultConversationId = eventData.conversation_id
              }
              if (eventData.id && !chatId) {
                chatId = eventData.id
              }

              // 处理消息增量
              if (currentEvent === 'conversation.message.delta') {
                const content = eventData.content || ''
                fullContent += content
                // console.log('Received content:', content)
              } else if (currentEvent === 'conversation.message.completed') {
                 // console.log('Message completed')
              }

              // 处理错误
              if (currentEvent === 'error') {
                console.error('Coze Bot stream error:', eventData)
                streamError = eventData.msg || JSON.stringify(eventData)
              }

            } catch (parseError) {
              // 忽略 JSON 解析错误，可能是不完整的数据
              console.log('Parse error (may be incomplete):', parseError)
            }
          }
    }

    console.log('Bot response collected, length:', fullContent.length)

    if (streamError) {
      return new Response(JSON.stringify({
        success: false,
        error: streamError,
        details: 'Error received from Coze stream'
      }), {
        headers: { ...corsHeaders, 'Content-Type': 'application/json' },
      })
    }

    // 返回结果
    return new Response(JSON.stringify({
      success: true,
      data: fullContent,
      conversation_id: resultConversationId,
      chat_id: chatId,
    }), {
      headers: { ...corsHeaders, 'Content-Type': 'application/json' },
      status: 200,
    })

  } catch (error: any) {
    console.error('Edge Function Error:', error)
    return new Response(JSON.stringify({ error: error.message || 'Unknown error' }), {
      status: 500,
      headers: { ...corsHeaders, 'Content-Type': 'application/json' },
    })
  }
})
