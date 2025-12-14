import { serve } from 'https://deno.land/std@0.168.0/http/server.ts'
import { corsHeaders } from '../_shared/cors.ts'
import { createClient } from 'https://esm.sh/@supabase/supabase-js@2'
import { encrypt } from '../_shared/crypto.ts'

serve(async (req) => {
  if (req.method === 'OPTIONS') {
    return new Response('ok', { headers: corsHeaders })
  }

  try {
    // 1. Get the Master Key from environment
    const masterKey = Deno.env.get('MASTER_ENCRYPTION_KEY');
    if (!masterKey) {
      console.error('MASTER_ENCRYPTION_KEY is not set');
      throw new Error('MASTER_ENCRYPTION_KEY is not set');
    }

    // 2. Authenticate User
    const authHeader = req.headers.get('Authorization');
    if (!authHeader) {
      throw new Error('Missing Authorization header');
    }
    console.log('Auth Header received:', authHeader.substring(0, 20) + '...');

    const supabaseClient = createClient(
      Deno.env.get('SUPABASE_URL') ?? '',
      Deno.env.get('SUPABASE_ANON_KEY') ?? '',
      { global: { headers: { Authorization: authHeader } } }
    );
    const { data: { user }, error: authError } = await supabaseClient.auth.getUser();
    if (authError || !user) {
      console.error('Auth error:', authError);
      throw new Error('Unauthorized');
    }

    // 3. Get data from the client
    const { name, coze_workflow_id, plain_api_key, description, type, ep_url } = await req.json();
    
    if (!name || !coze_workflow_id || !plain_api_key || !ep_url) {
      throw new Error('Missing name, coze_workflow_id, plain_api_key, or ep_url');
    }

    // Validate type if provided
    const validTypes = ['workflow', 'bot'];
    const workflowType = validTypes.includes(type) ? type : 'workflow';

    // 4. Encrypt the API key
    const encrypted_api_key = await encrypt(plain_api_key, masterKey);

    // 5. Create a Supabase admin client (to bypass RLS)
    const supabaseAdmin = createClient(
      Deno.env.get('SUPABASE_URL') ?? '',
      Deno.env.get('SUPABASE_SERVICE_ROLE_KEY') ?? ''
    );

    // 6. Check if workflow exists to handle owner_id and researcher_ids
    const { data: existingWorkflow, error: fetchError } = await supabaseAdmin
      .from('coze_workflows')
      .select('id, owner_id, researcher_ids')
      .eq('workflow_id', coze_workflow_id)
      .maybeSingle();
    
    if (fetchError) {
        console.error('Error fetching existing workflow:', fetchError);
    }

    let nextOwnerId = user.id;
    let nextResearcherIds = [user.id];

    if (existingWorkflow) {
      // If workflow exists, ensure the current user is the owner
      if (existingWorkflow.owner_id && existingWorkflow.owner_id !== user.id) {
        throw new Error('Unauthorized: Only the owner can modify this workflow.');
      }
      
      // Preserve existing owner (though it should match user.id per check above)
      nextOwnerId = existingWorkflow.owner_id;
      
      // Preserve existing researchers, ensure owner is in the list (optional but good for consistency)
      const currentIds = new Set(existingWorkflow.researcher_ids || []);
      currentIds.add(user.id);
      nextResearcherIds = Array.from(currentIds);
    }

    // 7. Upsert (update or insert) the workflow
    const { data, error } = await supabaseAdmin
      .from('coze_workflows')
      .upsert({
        name: name,
        workflow_id: coze_workflow_id,
        api_key: encrypted_api_key,
        description: description ?? null,
        type: workflowType,
        ep_url: ep_url ?? null,
        owner_id: nextOwnerId,
        researcher_ids: nextResearcherIds,
      }, {
        onConflict: 'workflow_id',
      })
  .select('id, workflow_id, name, description, type, ep_url, created_at, owner_id');

    if (error) {
        console.error('Upsert error:', error);
        throw error;
    }

    return new Response(JSON.stringify({ success: true, data: data }), {
      headers: { ...corsHeaders, 'Content-Type': 'application/json' },
    });

  } catch (error) {
    console.error('Handler error:', error);
    return new Response(JSON.stringify({ error: error.message }), {
      status: 400,
      headers: { ...corsHeaders, 'Content-Type': 'application/json' },
    });
  }
})


