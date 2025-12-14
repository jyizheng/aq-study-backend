import { serve } from 'https://deno.land/std@0.168.0/http/server.ts'
import { corsHeaders } from '../_shared/cors.ts'
import { createClient } from 'https://esm.sh/@supabase/supabase-js@2'
import { decrypt } from '../_shared/crypto.ts'

serve(async (req) => {
  console.log('run-coze-workflow invoked', req.method, req.url)
  if (req.method === 'OPTIONS') {
    return new Response('ok', { headers: corsHeaders })
  }

  // --- DEBUG: Return immediately to test connectivity ---
  // return new Response(JSON.stringify({ message: "Debug: Function is reachable" }), {
  //   headers: { ...corsHeaders, 'Content-Type': 'application/json' }
  // })
  // -----------------------------------------------------

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
    const { workflow_id, parameters } = body
    if (!workflow_id || !parameters) {
      throw new Error('Missing "workflow_id" or "parameters"')
    }

    console.log('Connecting to Supabase Admin...')
    const supabaseUrl = Deno.env.get('SUPABASE_URL') ?? ''
    const serviceRoleKey = Deno.env.get('SUPABASE_SERVICE_ROLE_KEY') ?? ''
    const supabaseAdmin = createClient(supabaseUrl, serviceRoleKey)

    console.log('Querying workflow...')
    const { data: workflowRow, error: workflowError } = await supabaseAdmin
      .from('coze_workflows')
      .select('api_key, ep_url')
      .eq('workflow_id', workflow_id)
      .maybeSingle()

    if (workflowError) {
      console.error('Failed to load workflow credentials:', workflowError.message)
      throw new Error('Failed to load workflow credentials')
    }

    let cozeApiKey: string | null = null

    if (workflowRow?.api_key) {
      try {
        cozeApiKey = await decrypt(workflowRow.api_key, masterKey)
      } catch (decryptError) {
        console.error('Failed to decrypt workflow API key:', decryptError)
        throw new Error('Failed to decrypt workflow API key')
      }
    }

    if (!cozeApiKey) {
      const fallbackKey = Deno.env.get('COZE_API_KEY')
      if (!fallbackKey) {
        throw new Error('No API key available for the requested workflow')
      }
      cozeApiKey = fallbackKey
    }

    console.log('Using Coze API Key:', cozeApiKey)

    if (!workflowRow?.ep_url) {
      throw new Error('Configuration error: "ep_url" is not set for this workflow. Please configure it in the dashboard.')
    }

    const url = `${workflowRow.ep_url}/v1/workflow/run`
    
    const headers = {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Authorization': `Bearer ${cozeApiKey}`,
    }
    const payload = {
      workflow_id,
      is_async: false,
      parameters,
    }

    const signal = AbortSignal.timeout(600000)

    console.log('Fetching from Coze:', url)
    const cozeResponse = await fetch(url, {
      method: 'POST',
      headers,
      body: JSON.stringify(payload),
      signal,
    })
    console.log('Coze response status:', cozeResponse.status)

    if (!cozeResponse.ok) {
      const errorDetails = await cozeResponse.text()
      console.error('Coze API Error:', errorDetails)
      return new Response(JSON.stringify({
        error: 'Coze API request failed',
        status: cozeResponse.status,
        details: errorDetails,
      }), {
        status: cozeResponse.status,
        headers: { ...corsHeaders, 'Content-Type': 'application/json' },
      })
    }

    return new Response(cozeResponse.body, {
      headers: { ...corsHeaders, 'Content-Type': 'application/json' },
      status: cozeResponse.status,
    })

  } catch (error: any) {
    console.error('Edge Function Error:', error)
    return new Response(JSON.stringify({ error: error.message || 'Unknown error' }), {
      status: 500,
      headers: { ...corsHeaders, 'Content-Type': 'application/json' },
    })
  }
})

