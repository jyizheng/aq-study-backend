// supabase/functions/_shared/cors.ts
export const corsHeaders = {
  'Access-Control-Allow-Origin': '*', // 生产环境中应限制为您的域名
  'Access-Control-Allow-Headers': 'authorization, x-client-info, apikey, content-type',
};

