

docker compose exec -T db psql -U supabase_admin -d postgres -c "
  DROP SCHEMA IF EXISTS public CASCADE;
  DROP SCHEMA IF EXISTS auth CASCADE;
  DROP SCHEMA IF EXISTS storage CASCADE;
  DROP SCHEMA IF EXISTS graphql CASCADE;
  DROP SCHEMA IF EXISTS realtime CASCADE;
  CREATE SCHEMA public;
  CREATE SCHEMA auth;
  CREATE SCHEMA storage;
  CREATE SCHEMA graphql;
  CREATE SCHEMA realtime;
  GRANT ALL ON SCHEMA public TO postgres;
  GRANT ALL ON SCHEMA public TO anon;
  GRANT ALL ON SCHEMA public TO authenticated;
  GRANT ALL ON SCHEMA public TO service_role;
"

