--
-- PostgreSQL database dump
--


-- Dumped from database version 17.6
-- Dumped by pg_dump version 17.6

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET transaction_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;

DROP EVENT TRIGGER IF EXISTS pgrst_drop_watch;
DROP EVENT TRIGGER IF EXISTS pgrst_ddl_watch;
DROP EVENT TRIGGER IF EXISTS issue_pg_net_access;
DROP EVENT TRIGGER IF EXISTS issue_pg_graphql_access;
DROP EVENT TRIGGER IF EXISTS issue_pg_cron_access;
DROP EVENT TRIGGER IF EXISTS issue_graphql_placeholder;
DROP PUBLICATION IF EXISTS supabase_realtime;
DROP POLICY IF EXISTS "View workflows" ON public.coze_workflows;
DROP POLICY IF EXISTS "Users can view their own profile" ON public.profiles;
DROP POLICY IF EXISTS "Users can update their own profile" ON public.profiles;
DROP POLICY IF EXISTS "Update workflows" ON public.coze_workflows;
DROP POLICY IF EXISTS "Researchers manage sessions for their experiments" ON public.experiment_sessions;
DROP POLICY IF EXISTS "Researchers manage evaluations" ON public.session_evaluations;
DROP POLICY IF EXISTS "Researchers can view results for their experiments" ON public.task_results;
DROP POLICY IF EXISTS "Researchers can manage their own experiments" ON public.experiments;
DROP POLICY IF EXISTS "Researchers and assigned participants can view experiments" ON public.experiments;
DROP POLICY IF EXISTS "Participants view their evaluations" ON public.session_evaluations;
DROP POLICY IF EXISTS "Participants can view their own sessions" ON public.experiment_sessions;
DROP POLICY IF EXISTS "Participants can update their own sessions" ON public.experiment_sessions;
DROP POLICY IF EXISTS "Participants can manage results for their sessions" ON public.task_results;
DROP POLICY IF EXISTS "Delete workflows" ON public.coze_workflows;
DROP POLICY IF EXISTS "Create workflows" ON public.coze_workflows;
DROP POLICY IF EXISTS "Allow users to view profiles" ON public.profiles;
DROP POLICY IF EXISTS "Allow users to insert their own profile" ON public.profiles;
DROP POLICY IF EXISTS "Allow researchers to view results for their experiments" ON public.task_results;
DROP POLICY IF EXISTS "Allow researchers to create sessions for their own experiments" ON public.experiment_sessions;
DROP POLICY IF EXISTS "Allow participants to manage results for their own sessions" ON public.task_results;
ALTER TABLE IF EXISTS ONLY storage.vector_indexes DROP CONSTRAINT IF EXISTS vector_indexes_bucket_id_fkey;
ALTER TABLE IF EXISTS ONLY storage.s3_multipart_uploads_parts DROP CONSTRAINT IF EXISTS s3_multipart_uploads_parts_upload_id_fkey;
ALTER TABLE IF EXISTS ONLY storage.s3_multipart_uploads_parts DROP CONSTRAINT IF EXISTS s3_multipart_uploads_parts_bucket_id_fkey;
ALTER TABLE IF EXISTS ONLY storage.s3_multipart_uploads DROP CONSTRAINT IF EXISTS s3_multipart_uploads_bucket_id_fkey;
ALTER TABLE IF EXISTS ONLY storage.prefixes DROP CONSTRAINT IF EXISTS "prefixes_bucketId_fkey";
ALTER TABLE IF EXISTS ONLY storage.objects DROP CONSTRAINT IF EXISTS "objects_bucketId_fkey";
ALTER TABLE IF EXISTS ONLY storage.iceberg_tables DROP CONSTRAINT IF EXISTS iceberg_tables_namespace_id_fkey;
ALTER TABLE IF EXISTS ONLY storage.iceberg_tables DROP CONSTRAINT IF EXISTS iceberg_tables_catalog_id_fkey;
ALTER TABLE IF EXISTS ONLY storage.iceberg_namespaces DROP CONSTRAINT IF EXISTS iceberg_namespaces_catalog_id_fkey;
ALTER TABLE IF EXISTS ONLY public.task_results DROP CONSTRAINT IF EXISTS task_results_session_id_fkey;
ALTER TABLE IF EXISTS ONLY public.session_evaluations DROP CONSTRAINT IF EXISTS session_evaluations_session_id_fkey;
ALTER TABLE IF EXISTS ONLY public.session_evaluations DROP CONSTRAINT IF EXISTS session_evaluations_experiment_id_fkey;
ALTER TABLE IF EXISTS ONLY public.session_evaluations DROP CONSTRAINT IF EXISTS session_evaluations_evaluator_id_fkey;
ALTER TABLE IF EXISTS ONLY public.profiles DROP CONSTRAINT IF EXISTS profiles_id_fkey;
ALTER TABLE IF EXISTS ONLY public.experiments DROP CONSTRAINT IF EXISTS experiments_researcher_id_fkey;
ALTER TABLE IF EXISTS ONLY public.experiment_sessions DROP CONSTRAINT IF EXISTS experiment_sessions_participant_id_fkey;
ALTER TABLE IF EXISTS ONLY public.experiment_sessions DROP CONSTRAINT IF EXISTS experiment_sessions_experiment_id_fkey;
ALTER TABLE IF EXISTS ONLY public.coze_workflows DROP CONSTRAINT IF EXISTS coze_workflows_owner_id_fkey;
ALTER TABLE IF EXISTS ONLY auth.sso_domains DROP CONSTRAINT IF EXISTS sso_domains_sso_provider_id_fkey;
ALTER TABLE IF EXISTS ONLY auth.sessions DROP CONSTRAINT IF EXISTS sessions_user_id_fkey;
ALTER TABLE IF EXISTS ONLY auth.sessions DROP CONSTRAINT IF EXISTS sessions_oauth_client_id_fkey;
ALTER TABLE IF EXISTS ONLY auth.saml_relay_states DROP CONSTRAINT IF EXISTS saml_relay_states_sso_provider_id_fkey;
ALTER TABLE IF EXISTS ONLY auth.saml_relay_states DROP CONSTRAINT IF EXISTS saml_relay_states_flow_state_id_fkey;
ALTER TABLE IF EXISTS ONLY auth.saml_providers DROP CONSTRAINT IF EXISTS saml_providers_sso_provider_id_fkey;
ALTER TABLE IF EXISTS ONLY auth.refresh_tokens DROP CONSTRAINT IF EXISTS refresh_tokens_session_id_fkey;
ALTER TABLE IF EXISTS ONLY auth.one_time_tokens DROP CONSTRAINT IF EXISTS one_time_tokens_user_id_fkey;
ALTER TABLE IF EXISTS ONLY auth.oauth_consents DROP CONSTRAINT IF EXISTS oauth_consents_user_id_fkey;
ALTER TABLE IF EXISTS ONLY auth.oauth_consents DROP CONSTRAINT IF EXISTS oauth_consents_client_id_fkey;
ALTER TABLE IF EXISTS ONLY auth.oauth_authorizations DROP CONSTRAINT IF EXISTS oauth_authorizations_user_id_fkey;
ALTER TABLE IF EXISTS ONLY auth.oauth_authorizations DROP CONSTRAINT IF EXISTS oauth_authorizations_client_id_fkey;
ALTER TABLE IF EXISTS ONLY auth.mfa_factors DROP CONSTRAINT IF EXISTS mfa_factors_user_id_fkey;
ALTER TABLE IF EXISTS ONLY auth.mfa_challenges DROP CONSTRAINT IF EXISTS mfa_challenges_auth_factor_id_fkey;
ALTER TABLE IF EXISTS ONLY auth.mfa_amr_claims DROP CONSTRAINT IF EXISTS mfa_amr_claims_session_id_fkey;
ALTER TABLE IF EXISTS ONLY auth.identities DROP CONSTRAINT IF EXISTS identities_user_id_fkey;
ALTER TABLE IF EXISTS ONLY _realtime.extensions DROP CONSTRAINT IF EXISTS extensions_tenant_external_id_fkey;
DROP TRIGGER IF EXISTS update_objects_updated_at ON storage.objects;
DROP TRIGGER IF EXISTS prefixes_delete_hierarchy ON storage.prefixes;
DROP TRIGGER IF EXISTS prefixes_create_hierarchy ON storage.prefixes;
DROP TRIGGER IF EXISTS objects_update_create_prefix ON storage.objects;
DROP TRIGGER IF EXISTS objects_insert_create_prefix ON storage.objects;
DROP TRIGGER IF EXISTS objects_delete_delete_prefix ON storage.objects;
DROP TRIGGER IF EXISTS enforce_bucket_name_length_trigger ON storage.buckets;
DROP TRIGGER IF EXISTS tr_check_filters ON realtime.subscription;
DROP TRIGGER IF EXISTS on_auth_user_created ON auth.users;
DROP INDEX IF EXISTS supabase_functions.supabase_functions_hooks_request_id_idx;
DROP INDEX IF EXISTS supabase_functions.supabase_functions_hooks_h_table_id_h_name_idx;
DROP INDEX IF EXISTS storage.vector_indexes_name_bucket_id_idx;
DROP INDEX IF EXISTS storage.objects_bucket_id_level_idx;
DROP INDEX IF EXISTS storage.name_prefix_search;
DROP INDEX IF EXISTS storage.idx_prefixes_lower_name;
DROP INDEX IF EXISTS storage.idx_objects_lower_name;
DROP INDEX IF EXISTS storage.idx_objects_bucket_id_name;
DROP INDEX IF EXISTS storage.idx_name_bucket_level_unique;
DROP INDEX IF EXISTS storage.idx_multipart_uploads_list;
DROP INDEX IF EXISTS storage.idx_iceberg_tables_namespace_id;
DROP INDEX IF EXISTS storage.idx_iceberg_tables_location;
DROP INDEX IF EXISTS storage.idx_iceberg_namespaces_bucket_id;
DROP INDEX IF EXISTS storage.buckets_analytics_unique_name_idx;
DROP INDEX IF EXISTS storage.bucketid_objname;
DROP INDEX IF EXISTS storage.bname;
DROP INDEX IF EXISTS realtime.subscription_subscription_id_entity_filters_key;
DROP INDEX IF EXISTS realtime.messages_inserted_at_topic_index;
DROP INDEX IF EXISTS realtime.ix_realtime_subscription_entity;
DROP INDEX IF EXISTS auth.users_is_anonymous_idx;
DROP INDEX IF EXISTS auth.users_instance_id_idx;
DROP INDEX IF EXISTS auth.users_instance_id_email_idx;
DROP INDEX IF EXISTS auth.users_email_partial_key;
DROP INDEX IF EXISTS auth.user_id_created_at_idx;
DROP INDEX IF EXISTS auth.unique_phone_factor_per_user;
DROP INDEX IF EXISTS auth.sso_providers_resource_id_pattern_idx;
DROP INDEX IF EXISTS auth.sso_providers_resource_id_idx;
DROP INDEX IF EXISTS auth.sso_domains_sso_provider_id_idx;
DROP INDEX IF EXISTS auth.sso_domains_domain_idx;
DROP INDEX IF EXISTS auth.sessions_user_id_idx;
DROP INDEX IF EXISTS auth.sessions_oauth_client_id_idx;
DROP INDEX IF EXISTS auth.sessions_not_after_idx;
DROP INDEX IF EXISTS auth.saml_relay_states_sso_provider_id_idx;
DROP INDEX IF EXISTS auth.saml_relay_states_for_email_idx;
DROP INDEX IF EXISTS auth.saml_relay_states_created_at_idx;
DROP INDEX IF EXISTS auth.saml_providers_sso_provider_id_idx;
DROP INDEX IF EXISTS auth.refresh_tokens_updated_at_idx;
DROP INDEX IF EXISTS auth.refresh_tokens_session_id_revoked_idx;
DROP INDEX IF EXISTS auth.refresh_tokens_parent_idx;
DROP INDEX IF EXISTS auth.refresh_tokens_instance_id_user_id_idx;
DROP INDEX IF EXISTS auth.refresh_tokens_instance_id_idx;
DROP INDEX IF EXISTS auth.recovery_token_idx;
DROP INDEX IF EXISTS auth.reauthentication_token_idx;
DROP INDEX IF EXISTS auth.one_time_tokens_user_id_token_type_key;
DROP INDEX IF EXISTS auth.one_time_tokens_token_hash_hash_idx;
DROP INDEX IF EXISTS auth.one_time_tokens_relates_to_hash_idx;
DROP INDEX IF EXISTS auth.oauth_consents_user_order_idx;
DROP INDEX IF EXISTS auth.oauth_consents_active_user_client_idx;
DROP INDEX IF EXISTS auth.oauth_consents_active_client_idx;
DROP INDEX IF EXISTS auth.oauth_clients_deleted_at_idx;
DROP INDEX IF EXISTS auth.oauth_auth_pending_exp_idx;
DROP INDEX IF EXISTS auth.mfa_factors_user_id_idx;
DROP INDEX IF EXISTS auth.mfa_factors_user_friendly_name_unique;
DROP INDEX IF EXISTS auth.mfa_challenge_created_at_idx;
DROP INDEX IF EXISTS auth.idx_user_id_auth_method;
DROP INDEX IF EXISTS auth.idx_auth_code;
DROP INDEX IF EXISTS auth.identities_user_id_idx;
DROP INDEX IF EXISTS auth.identities_email_idx;
DROP INDEX IF EXISTS auth.flow_state_created_at_idx;
DROP INDEX IF EXISTS auth.factor_id_created_at_idx;
DROP INDEX IF EXISTS auth.email_change_token_new_idx;
DROP INDEX IF EXISTS auth.email_change_token_current_idx;
DROP INDEX IF EXISTS auth.confirmation_token_idx;
DROP INDEX IF EXISTS auth.audit_logs_instance_id_idx;
DROP INDEX IF EXISTS _realtime.tenants_external_id_index;
DROP INDEX IF EXISTS _realtime.extensions_tenant_external_id_type_index;
DROP INDEX IF EXISTS _realtime.extensions_tenant_external_id_index;
ALTER TABLE IF EXISTS ONLY supabase_functions.migrations DROP CONSTRAINT IF EXISTS migrations_pkey;
ALTER TABLE IF EXISTS ONLY supabase_functions.hooks DROP CONSTRAINT IF EXISTS hooks_pkey;
ALTER TABLE IF EXISTS ONLY storage.vector_indexes DROP CONSTRAINT IF EXISTS vector_indexes_pkey;
ALTER TABLE IF EXISTS ONLY storage.s3_multipart_uploads DROP CONSTRAINT IF EXISTS s3_multipart_uploads_pkey;
ALTER TABLE IF EXISTS ONLY storage.s3_multipart_uploads_parts DROP CONSTRAINT IF EXISTS s3_multipart_uploads_parts_pkey;
ALTER TABLE IF EXISTS ONLY storage.prefixes DROP CONSTRAINT IF EXISTS prefixes_pkey;
ALTER TABLE IF EXISTS ONLY storage.objects DROP CONSTRAINT IF EXISTS objects_pkey;
ALTER TABLE IF EXISTS ONLY storage.migrations DROP CONSTRAINT IF EXISTS migrations_pkey;
ALTER TABLE IF EXISTS ONLY storage.migrations DROP CONSTRAINT IF EXISTS migrations_name_key;
ALTER TABLE IF EXISTS ONLY storage.iceberg_tables DROP CONSTRAINT IF EXISTS iceberg_tables_pkey;
ALTER TABLE IF EXISTS ONLY storage.iceberg_namespaces DROP CONSTRAINT IF EXISTS iceberg_namespaces_pkey;
ALTER TABLE IF EXISTS ONLY storage.buckets_vectors DROP CONSTRAINT IF EXISTS buckets_vectors_pkey;
ALTER TABLE IF EXISTS ONLY storage.buckets DROP CONSTRAINT IF EXISTS buckets_pkey;
ALTER TABLE IF EXISTS ONLY storage.buckets_analytics DROP CONSTRAINT IF EXISTS buckets_analytics_pkey;
ALTER TABLE IF EXISTS ONLY realtime.schema_migrations DROP CONSTRAINT IF EXISTS schema_migrations_pkey;
ALTER TABLE IF EXISTS ONLY realtime.subscription DROP CONSTRAINT IF EXISTS pk_subscription;
ALTER TABLE IF EXISTS ONLY realtime.messages_2025_12_05 DROP CONSTRAINT IF EXISTS messages_2025_12_05_pkey;
ALTER TABLE IF EXISTS ONLY realtime.messages_2025_12_04 DROP CONSTRAINT IF EXISTS messages_2025_12_04_pkey;
ALTER TABLE IF EXISTS ONLY realtime.messages_2025_12_03 DROP CONSTRAINT IF EXISTS messages_2025_12_03_pkey;
ALTER TABLE IF EXISTS ONLY realtime.messages_2025_12_02 DROP CONSTRAINT IF EXISTS messages_2025_12_02_pkey;
ALTER TABLE IF EXISTS ONLY realtime.messages_2025_12_01 DROP CONSTRAINT IF EXISTS messages_2025_12_01_pkey;
ALTER TABLE IF EXISTS ONLY realtime.messages_2025_11_29 DROP CONSTRAINT IF EXISTS messages_2025_11_29_pkey;
ALTER TABLE IF EXISTS ONLY realtime.messages DROP CONSTRAINT IF EXISTS messages_pkey;
ALTER TABLE IF EXISTS ONLY public.task_results DROP CONSTRAINT IF EXISTS task_results_pkey;
ALTER TABLE IF EXISTS ONLY public.session_evaluations DROP CONSTRAINT IF EXISTS session_evaluations_session_id_key;
ALTER TABLE IF EXISTS ONLY public.session_evaluations DROP CONSTRAINT IF EXISTS session_evaluations_pkey;
ALTER TABLE IF EXISTS ONLY public.profiles DROP CONSTRAINT IF EXISTS profiles_pkey;
ALTER TABLE IF EXISTS ONLY public.experiments DROP CONSTRAINT IF EXISTS experiments_pkey;
ALTER TABLE IF EXISTS ONLY public.experiment_sessions DROP CONSTRAINT IF EXISTS experiment_sessions_pkey;
ALTER TABLE IF EXISTS ONLY public.experiment_sessions DROP CONSTRAINT IF EXISTS experiment_sessions_experiment_id_participant_id_key;
ALTER TABLE IF EXISTS ONLY public.coze_workflows DROP CONSTRAINT IF EXISTS coze_workflows_workflow_id_key;
ALTER TABLE IF EXISTS ONLY public.coze_workflows DROP CONSTRAINT IF EXISTS coze_workflows_pkey;
ALTER TABLE IF EXISTS ONLY auth.users DROP CONSTRAINT IF EXISTS users_pkey;
ALTER TABLE IF EXISTS ONLY auth.users DROP CONSTRAINT IF EXISTS users_phone_key;
ALTER TABLE IF EXISTS ONLY auth.sso_providers DROP CONSTRAINT IF EXISTS sso_providers_pkey;
ALTER TABLE IF EXISTS ONLY auth.sso_domains DROP CONSTRAINT IF EXISTS sso_domains_pkey;
ALTER TABLE IF EXISTS ONLY auth.sessions DROP CONSTRAINT IF EXISTS sessions_pkey;
ALTER TABLE IF EXISTS ONLY auth.schema_migrations DROP CONSTRAINT IF EXISTS schema_migrations_pkey;
ALTER TABLE IF EXISTS ONLY auth.saml_relay_states DROP CONSTRAINT IF EXISTS saml_relay_states_pkey;
ALTER TABLE IF EXISTS ONLY auth.saml_providers DROP CONSTRAINT IF EXISTS saml_providers_pkey;
ALTER TABLE IF EXISTS ONLY auth.saml_providers DROP CONSTRAINT IF EXISTS saml_providers_entity_id_key;
ALTER TABLE IF EXISTS ONLY auth.refresh_tokens DROP CONSTRAINT IF EXISTS refresh_tokens_token_unique;
ALTER TABLE IF EXISTS ONLY auth.refresh_tokens DROP CONSTRAINT IF EXISTS refresh_tokens_pkey;
ALTER TABLE IF EXISTS ONLY auth.one_time_tokens DROP CONSTRAINT IF EXISTS one_time_tokens_pkey;
ALTER TABLE IF EXISTS ONLY auth.oauth_consents DROP CONSTRAINT IF EXISTS oauth_consents_user_client_unique;
ALTER TABLE IF EXISTS ONLY auth.oauth_consents DROP CONSTRAINT IF EXISTS oauth_consents_pkey;
ALTER TABLE IF EXISTS ONLY auth.oauth_clients DROP CONSTRAINT IF EXISTS oauth_clients_pkey;
ALTER TABLE IF EXISTS ONLY auth.oauth_authorizations DROP CONSTRAINT IF EXISTS oauth_authorizations_pkey;
ALTER TABLE IF EXISTS ONLY auth.oauth_authorizations DROP CONSTRAINT IF EXISTS oauth_authorizations_authorization_id_key;
ALTER TABLE IF EXISTS ONLY auth.oauth_authorizations DROP CONSTRAINT IF EXISTS oauth_authorizations_authorization_code_key;
ALTER TABLE IF EXISTS ONLY auth.mfa_factors DROP CONSTRAINT IF EXISTS mfa_factors_pkey;
ALTER TABLE IF EXISTS ONLY auth.mfa_factors DROP CONSTRAINT IF EXISTS mfa_factors_last_challenged_at_key;
ALTER TABLE IF EXISTS ONLY auth.mfa_challenges DROP CONSTRAINT IF EXISTS mfa_challenges_pkey;
ALTER TABLE IF EXISTS ONLY auth.mfa_amr_claims DROP CONSTRAINT IF EXISTS mfa_amr_claims_session_id_authentication_method_pkey;
ALTER TABLE IF EXISTS ONLY auth.instances DROP CONSTRAINT IF EXISTS instances_pkey;
ALTER TABLE IF EXISTS ONLY auth.identities DROP CONSTRAINT IF EXISTS identities_provider_id_provider_unique;
ALTER TABLE IF EXISTS ONLY auth.identities DROP CONSTRAINT IF EXISTS identities_pkey;
ALTER TABLE IF EXISTS ONLY auth.flow_state DROP CONSTRAINT IF EXISTS flow_state_pkey;
ALTER TABLE IF EXISTS ONLY auth.audit_log_entries DROP CONSTRAINT IF EXISTS audit_log_entries_pkey;
ALTER TABLE IF EXISTS ONLY auth.mfa_amr_claims DROP CONSTRAINT IF EXISTS amr_id_pk;
ALTER TABLE IF EXISTS ONLY _realtime.tenants DROP CONSTRAINT IF EXISTS tenants_pkey;
ALTER TABLE IF EXISTS ONLY _realtime.schema_migrations DROP CONSTRAINT IF EXISTS schema_migrations_pkey;
ALTER TABLE IF EXISTS ONLY _realtime.extensions DROP CONSTRAINT IF EXISTS extensions_pkey;
ALTER TABLE IF EXISTS supabase_functions.hooks ALTER COLUMN id DROP DEFAULT;
ALTER TABLE IF EXISTS public.experiments ALTER COLUMN experiment_id DROP DEFAULT;
ALTER TABLE IF EXISTS auth.refresh_tokens ALTER COLUMN id DROP DEFAULT;
DROP TABLE IF EXISTS supabase_functions.migrations;
DROP SEQUENCE IF EXISTS supabase_functions.hooks_id_seq;
DROP TABLE IF EXISTS supabase_functions.hooks;
DROP TABLE IF EXISTS storage.vector_indexes;
DROP TABLE IF EXISTS storage.s3_multipart_uploads_parts;
DROP TABLE IF EXISTS storage.s3_multipart_uploads;
DROP TABLE IF EXISTS storage.prefixes;
DROP TABLE IF EXISTS storage.objects;
DROP TABLE IF EXISTS storage.migrations;
DROP TABLE IF EXISTS storage.iceberg_tables;
DROP TABLE IF EXISTS storage.iceberg_namespaces;
DROP TABLE IF EXISTS storage.buckets_vectors;
DROP TABLE IF EXISTS storage.buckets_analytics;
DROP TABLE IF EXISTS storage.buckets;
DROP TABLE IF EXISTS realtime.subscription;
DROP TABLE IF EXISTS realtime.schema_migrations;
DROP TABLE IF EXISTS realtime.messages_2025_12_05;
DROP TABLE IF EXISTS realtime.messages_2025_12_04;
DROP TABLE IF EXISTS realtime.messages_2025_12_03;
DROP TABLE IF EXISTS realtime.messages_2025_12_02;
DROP TABLE IF EXISTS realtime.messages_2025_12_01;
DROP TABLE IF EXISTS realtime.messages_2025_11_29;
DROP TABLE IF EXISTS realtime.messages;
DROP TABLE IF EXISTS public.task_results;
DROP TABLE IF EXISTS public.session_evaluations;
DROP TABLE IF EXISTS public.profiles;
DROP SEQUENCE IF EXISTS public.experiments_experiment_id_seq;
DROP TABLE IF EXISTS public.experiments;
DROP TABLE IF EXISTS public.experiment_sessions;
DROP TABLE IF EXISTS public.coze_workflows;
DROP TABLE IF EXISTS auth.users;
DROP TABLE IF EXISTS auth.sso_providers;
DROP TABLE IF EXISTS auth.sso_domains;
DROP TABLE IF EXISTS auth.sessions;
DROP TABLE IF EXISTS auth.schema_migrations;
DROP TABLE IF EXISTS auth.saml_relay_states;
DROP TABLE IF EXISTS auth.saml_providers;
DROP SEQUENCE IF EXISTS auth.refresh_tokens_id_seq;
DROP TABLE IF EXISTS auth.refresh_tokens;
DROP TABLE IF EXISTS auth.one_time_tokens;
DROP TABLE IF EXISTS auth.oauth_consents;
DROP TABLE IF EXISTS auth.oauth_clients;
DROP TABLE IF EXISTS auth.oauth_authorizations;
DROP TABLE IF EXISTS auth.mfa_factors;
DROP TABLE IF EXISTS auth.mfa_challenges;
DROP TABLE IF EXISTS auth.mfa_amr_claims;
DROP TABLE IF EXISTS auth.instances;
DROP TABLE IF EXISTS auth.identities;
DROP TABLE IF EXISTS auth.flow_state;
DROP TABLE IF EXISTS auth.audit_log_entries;
DROP TABLE IF EXISTS _realtime.tenants;
DROP TABLE IF EXISTS _realtime.schema_migrations;
DROP TABLE IF EXISTS _realtime.extensions;
DROP FUNCTION IF EXISTS supabase_functions.http_request();
DROP FUNCTION IF EXISTS storage.update_updated_at_column();
DROP FUNCTION IF EXISTS storage.search_v2(prefix text, bucket_name text, limits integer, levels integer, start_after text, sort_order text, sort_column text, sort_column_after text);
DROP FUNCTION IF EXISTS storage.search_v1_optimised(prefix text, bucketname text, limits integer, levels integer, offsets integer, search text, sortcolumn text, sortorder text);
DROP FUNCTION IF EXISTS storage.search_legacy_v1(prefix text, bucketname text, limits integer, levels integer, offsets integer, search text, sortcolumn text, sortorder text);
DROP FUNCTION IF EXISTS storage.search(prefix text, bucketname text, limits integer, levels integer, offsets integer, search text, sortcolumn text, sortorder text);
DROP FUNCTION IF EXISTS storage.prefixes_insert_trigger();
DROP FUNCTION IF EXISTS storage.prefixes_delete_cleanup();
DROP FUNCTION IF EXISTS storage.operation();
DROP FUNCTION IF EXISTS storage.objects_update_prefix_trigger();
DROP FUNCTION IF EXISTS storage.objects_update_level_trigger();
DROP FUNCTION IF EXISTS storage.objects_update_cleanup();
DROP FUNCTION IF EXISTS storage.objects_insert_prefix_trigger();
DROP FUNCTION IF EXISTS storage.objects_delete_cleanup();
DROP FUNCTION IF EXISTS storage.lock_top_prefixes(bucket_ids text[], names text[]);
DROP FUNCTION IF EXISTS storage.list_objects_with_delimiter(bucket_id text, prefix_param text, delimiter_param text, max_keys integer, start_after text, next_token text);
DROP FUNCTION IF EXISTS storage.list_multipart_uploads_with_delimiter(bucket_id text, prefix_param text, delimiter_param text, max_keys integer, next_key_token text, next_upload_token text);
DROP FUNCTION IF EXISTS storage.get_size_by_bucket();
DROP FUNCTION IF EXISTS storage.get_prefixes(name text);
DROP FUNCTION IF EXISTS storage.get_prefix(name text);
DROP FUNCTION IF EXISTS storage.get_level(name text);
DROP FUNCTION IF EXISTS storage.foldername(name text);
DROP FUNCTION IF EXISTS storage.filename(name text);
DROP FUNCTION IF EXISTS storage.extension(name text);
DROP FUNCTION IF EXISTS storage.enforce_bucket_name_length();
DROP FUNCTION IF EXISTS storage.delete_prefix_hierarchy_trigger();
DROP FUNCTION IF EXISTS storage.delete_prefix(_bucket_id text, _name text);
DROP FUNCTION IF EXISTS storage.delete_leaf_prefixes(bucket_ids text[], names text[]);
DROP FUNCTION IF EXISTS storage.can_insert_object(bucketid text, name text, owner uuid, metadata jsonb);
DROP FUNCTION IF EXISTS storage.add_prefixes(_bucket_id text, _name text);
DROP FUNCTION IF EXISTS realtime.topic();
DROP FUNCTION IF EXISTS realtime.to_regrole(role_name text);
DROP FUNCTION IF EXISTS realtime.subscription_check_filters();
DROP FUNCTION IF EXISTS realtime.send(payload jsonb, event text, topic text, private boolean);
DROP FUNCTION IF EXISTS realtime.quote_wal2json(entity regclass);
DROP FUNCTION IF EXISTS realtime.list_changes(publication name, slot_name name, max_changes integer, max_record_bytes integer);
DROP FUNCTION IF EXISTS realtime.is_visible_through_filters(columns realtime.wal_column[], filters realtime.user_defined_filter[]);
DROP FUNCTION IF EXISTS realtime.check_equality_op(op realtime.equality_op, type_ regtype, val_1 text, val_2 text);
DROP FUNCTION IF EXISTS realtime."cast"(val text, type_ regtype);
DROP FUNCTION IF EXISTS realtime.build_prepared_statement_sql(prepared_statement_name text, entity regclass, columns realtime.wal_column[]);
DROP FUNCTION IF EXISTS realtime.broadcast_changes(topic_name text, event_name text, operation text, table_name text, table_schema text, new record, old record, level text);
DROP FUNCTION IF EXISTS realtime.apply_rls(wal jsonb, max_record_bytes integer);
DROP FUNCTION IF EXISTS public.is_researcher_for_experiment(exp_id bigint, user_id uuid);
DROP FUNCTION IF EXISTS public.is_participant_in_experiment(exp_id bigint, user_id uuid);
DROP FUNCTION IF EXISTS public.handle_new_user();
DROP FUNCTION IF EXISTS pgbouncer.get_auth(p_usename text);
DROP FUNCTION IF EXISTS extensions.set_graphql_placeholder();
DROP FUNCTION IF EXISTS extensions.pgrst_drop_watch();
DROP FUNCTION IF EXISTS extensions.pgrst_ddl_watch();
DROP FUNCTION IF EXISTS extensions.grant_pg_net_access();
DROP FUNCTION IF EXISTS extensions.grant_pg_graphql_access();
DROP FUNCTION IF EXISTS extensions.grant_pg_cron_access();
DROP FUNCTION IF EXISTS auth.uid();
DROP FUNCTION IF EXISTS auth.role();
DROP FUNCTION IF EXISTS auth.jwt();
DROP FUNCTION IF EXISTS auth.email();
DROP TYPE IF EXISTS storage.buckettype;
DROP TYPE IF EXISTS realtime.wal_rls;
DROP TYPE IF EXISTS realtime.wal_column;
DROP TYPE IF EXISTS realtime.user_defined_filter;
DROP TYPE IF EXISTS realtime.equality_op;
DROP TYPE IF EXISTS realtime.action;
DROP TYPE IF EXISTS auth.one_time_token_type;
DROP TYPE IF EXISTS auth.oauth_response_type;
DROP TYPE IF EXISTS auth.oauth_registration_type;
DROP TYPE IF EXISTS auth.oauth_client_type;
DROP TYPE IF EXISTS auth.oauth_authorization_status;
DROP TYPE IF EXISTS auth.factor_type;
DROP TYPE IF EXISTS auth.factor_status;
DROP TYPE IF EXISTS auth.code_challenge_method;
DROP TYPE IF EXISTS auth.aal_level;
DROP EXTENSION IF EXISTS "uuid-ossp";
DROP EXTENSION IF EXISTS supabase_vault;
DROP EXTENSION IF EXISTS pgcrypto;
DROP EXTENSION IF EXISTS pg_stat_statements;
DROP EXTENSION IF EXISTS pg_graphql;
DROP SCHEMA IF EXISTS vault;
DROP SCHEMA IF EXISTS supabase_functions;
DROP SCHEMA IF EXISTS storage;
DROP SCHEMA IF EXISTS realtime;
DROP SCHEMA IF EXISTS pgbouncer;
DROP EXTENSION IF EXISTS pg_net;
DROP SCHEMA IF EXISTS graphql_public;
DROP SCHEMA IF EXISTS graphql;
DROP SCHEMA IF EXISTS extensions;
DROP SCHEMA IF EXISTS auth;
DROP SCHEMA IF EXISTS _realtime;
--
-- Name: _realtime; Type: SCHEMA; Schema: -; Owner: -
--

CREATE SCHEMA _realtime;


--
-- Name: auth; Type: SCHEMA; Schema: -; Owner: -
--

CREATE SCHEMA auth;


--
-- Name: extensions; Type: SCHEMA; Schema: -; Owner: -
--

CREATE SCHEMA extensions;


--
-- Name: graphql; Type: SCHEMA; Schema: -; Owner: -
--

CREATE SCHEMA graphql;


--
-- Name: graphql_public; Type: SCHEMA; Schema: -; Owner: -
--

CREATE SCHEMA graphql_public;


--
-- Name: pg_net; Type: EXTENSION; Schema: -; Owner: -
--

CREATE EXTENSION IF NOT EXISTS pg_net WITH SCHEMA extensions;


--
-- Name: EXTENSION pg_net; Type: COMMENT; Schema: -; Owner: -
--

COMMENT ON EXTENSION pg_net IS 'Async HTTP';


--
-- Name: pgbouncer; Type: SCHEMA; Schema: -; Owner: -
--

CREATE SCHEMA pgbouncer;


--
-- Name: realtime; Type: SCHEMA; Schema: -; Owner: -
--

CREATE SCHEMA realtime;


--
-- Name: storage; Type: SCHEMA; Schema: -; Owner: -
--

CREATE SCHEMA storage;


--
-- Name: supabase_functions; Type: SCHEMA; Schema: -; Owner: -
--

CREATE SCHEMA supabase_functions;


--
-- Name: vault; Type: SCHEMA; Schema: -; Owner: -
--

CREATE SCHEMA vault;


--
-- Name: pg_graphql; Type: EXTENSION; Schema: -; Owner: -
--

CREATE EXTENSION IF NOT EXISTS pg_graphql WITH SCHEMA graphql;


--
-- Name: EXTENSION pg_graphql; Type: COMMENT; Schema: -; Owner: -
--

COMMENT ON EXTENSION pg_graphql IS 'pg_graphql: GraphQL support';


--
-- Name: pg_stat_statements; Type: EXTENSION; Schema: -; Owner: -
--

CREATE EXTENSION IF NOT EXISTS pg_stat_statements WITH SCHEMA extensions;


--
-- Name: EXTENSION pg_stat_statements; Type: COMMENT; Schema: -; Owner: -
--

COMMENT ON EXTENSION pg_stat_statements IS 'track planning and execution statistics of all SQL statements executed';


--
-- Name: pgcrypto; Type: EXTENSION; Schema: -; Owner: -
--

CREATE EXTENSION IF NOT EXISTS pgcrypto WITH SCHEMA extensions;


--
-- Name: EXTENSION pgcrypto; Type: COMMENT; Schema: -; Owner: -
--

COMMENT ON EXTENSION pgcrypto IS 'cryptographic functions';


--
-- Name: supabase_vault; Type: EXTENSION; Schema: -; Owner: -
--

CREATE EXTENSION IF NOT EXISTS supabase_vault WITH SCHEMA vault;


--
-- Name: EXTENSION supabase_vault; Type: COMMENT; Schema: -; Owner: -
--

COMMENT ON EXTENSION supabase_vault IS 'Supabase Vault Extension';


--
-- Name: uuid-ossp; Type: EXTENSION; Schema: -; Owner: -
--

CREATE EXTENSION IF NOT EXISTS "uuid-ossp" WITH SCHEMA extensions;


--
-- Name: EXTENSION "uuid-ossp"; Type: COMMENT; Schema: -; Owner: -
--

COMMENT ON EXTENSION "uuid-ossp" IS 'generate universally unique identifiers (UUIDs)';


--
-- Name: aal_level; Type: TYPE; Schema: auth; Owner: -
--

CREATE TYPE auth.aal_level AS ENUM (
    'aal1',
    'aal2',
    'aal3'
);


--
-- Name: code_challenge_method; Type: TYPE; Schema: auth; Owner: -
--

CREATE TYPE auth.code_challenge_method AS ENUM (
    's256',
    'plain'
);


--
-- Name: factor_status; Type: TYPE; Schema: auth; Owner: -
--

CREATE TYPE auth.factor_status AS ENUM (
    'unverified',
    'verified'
);


--
-- Name: factor_type; Type: TYPE; Schema: auth; Owner: -
--

CREATE TYPE auth.factor_type AS ENUM (
    'totp',
    'webauthn',
    'phone'
);


--
-- Name: oauth_authorization_status; Type: TYPE; Schema: auth; Owner: -
--

CREATE TYPE auth.oauth_authorization_status AS ENUM (
    'pending',
    'approved',
    'denied',
    'expired'
);


--
-- Name: oauth_client_type; Type: TYPE; Schema: auth; Owner: -
--

CREATE TYPE auth.oauth_client_type AS ENUM (
    'public',
    'confidential'
);


--
-- Name: oauth_registration_type; Type: TYPE; Schema: auth; Owner: -
--

CREATE TYPE auth.oauth_registration_type AS ENUM (
    'dynamic',
    'manual'
);


--
-- Name: oauth_response_type; Type: TYPE; Schema: auth; Owner: -
--

CREATE TYPE auth.oauth_response_type AS ENUM (
    'code'
);


--
-- Name: one_time_token_type; Type: TYPE; Schema: auth; Owner: -
--

CREATE TYPE auth.one_time_token_type AS ENUM (
    'confirmation_token',
    'reauthentication_token',
    'recovery_token',
    'email_change_token_new',
    'email_change_token_current',
    'phone_change_token'
);


--
-- Name: action; Type: TYPE; Schema: realtime; Owner: -
--

CREATE TYPE realtime.action AS ENUM (
    'INSERT',
    'UPDATE',
    'DELETE',
    'TRUNCATE',
    'ERROR'
);


--
-- Name: equality_op; Type: TYPE; Schema: realtime; Owner: -
--

CREATE TYPE realtime.equality_op AS ENUM (
    'eq',
    'neq',
    'lt',
    'lte',
    'gt',
    'gte',
    'in'
);


--
-- Name: user_defined_filter; Type: TYPE; Schema: realtime; Owner: -
--

CREATE TYPE realtime.user_defined_filter AS (
	column_name text,
	op realtime.equality_op,
	value text
);


--
-- Name: wal_column; Type: TYPE; Schema: realtime; Owner: -
--

CREATE TYPE realtime.wal_column AS (
	name text,
	type_name text,
	type_oid oid,
	value jsonb,
	is_pkey boolean,
	is_selectable boolean
);


--
-- Name: wal_rls; Type: TYPE; Schema: realtime; Owner: -
--

CREATE TYPE realtime.wal_rls AS (
	wal jsonb,
	is_rls_enabled boolean,
	subscription_ids uuid[],
	errors text[]
);


--
-- Name: buckettype; Type: TYPE; Schema: storage; Owner: -
--

CREATE TYPE storage.buckettype AS ENUM (
    'STANDARD',
    'ANALYTICS',
    'VECTOR'
);


--
-- Name: email(); Type: FUNCTION; Schema: auth; Owner: -
--

CREATE FUNCTION auth.email() RETURNS text
    LANGUAGE sql STABLE
    AS $$
  select 
  coalesce(
    nullif(current_setting('request.jwt.claim.email', true), ''),
    (nullif(current_setting('request.jwt.claims', true), '')::jsonb ->> 'email')
  )::text
$$;


--
-- Name: FUNCTION email(); Type: COMMENT; Schema: auth; Owner: -
--

COMMENT ON FUNCTION auth.email() IS 'Deprecated. Use auth.jwt() -> ''email'' instead.';


--
-- Name: jwt(); Type: FUNCTION; Schema: auth; Owner: -
--

CREATE FUNCTION auth.jwt() RETURNS jsonb
    LANGUAGE sql STABLE
    AS $$
  select 
    coalesce(
        nullif(current_setting('request.jwt.claim', true), ''),
        nullif(current_setting('request.jwt.claims', true), '')
    )::jsonb
$$;


--
-- Name: role(); Type: FUNCTION; Schema: auth; Owner: -
--

CREATE FUNCTION auth.role() RETURNS text
    LANGUAGE sql STABLE
    AS $$
  select 
  coalesce(
    nullif(current_setting('request.jwt.claim.role', true), ''),
    (nullif(current_setting('request.jwt.claims', true), '')::jsonb ->> 'role')
  )::text
$$;


--
-- Name: FUNCTION role(); Type: COMMENT; Schema: auth; Owner: -
--

COMMENT ON FUNCTION auth.role() IS 'Deprecated. Use auth.jwt() -> ''role'' instead.';


--
-- Name: uid(); Type: FUNCTION; Schema: auth; Owner: -
--

CREATE FUNCTION auth.uid() RETURNS uuid
    LANGUAGE sql STABLE
    AS $$
  select 
  coalesce(
    nullif(current_setting('request.jwt.claim.sub', true), ''),
    (nullif(current_setting('request.jwt.claims', true), '')::jsonb ->> 'sub')
  )::uuid
$$;


--
-- Name: FUNCTION uid(); Type: COMMENT; Schema: auth; Owner: -
--

COMMENT ON FUNCTION auth.uid() IS 'Deprecated. Use auth.jwt() -> ''sub'' instead.';


--
-- Name: grant_pg_cron_access(); Type: FUNCTION; Schema: extensions; Owner: -
--

CREATE FUNCTION extensions.grant_pg_cron_access() RETURNS event_trigger
    LANGUAGE plpgsql
    AS $$
BEGIN
  IF EXISTS (
    SELECT
    FROM pg_event_trigger_ddl_commands() AS ev
    JOIN pg_extension AS ext
    ON ev.objid = ext.oid
    WHERE ext.extname = 'pg_cron'
  )
  THEN
    grant usage on schema cron to postgres with grant option;

    alter default privileges in schema cron grant all on tables to postgres with grant option;
    alter default privileges in schema cron grant all on functions to postgres with grant option;
    alter default privileges in schema cron grant all on sequences to postgres with grant option;

    alter default privileges for user supabase_admin in schema cron grant all
        on sequences to postgres with grant option;
    alter default privileges for user supabase_admin in schema cron grant all
        on tables to postgres with grant option;
    alter default privileges for user supabase_admin in schema cron grant all
        on functions to postgres with grant option;

    grant all privileges on all tables in schema cron to postgres with grant option;
    revoke all on table cron.job from postgres;
    grant select on table cron.job to postgres with grant option;
  END IF;
END;
$$;


--
-- Name: FUNCTION grant_pg_cron_access(); Type: COMMENT; Schema: extensions; Owner: -
--

COMMENT ON FUNCTION extensions.grant_pg_cron_access() IS 'Grants access to pg_cron';


--
-- Name: grant_pg_graphql_access(); Type: FUNCTION; Schema: extensions; Owner: -
--

CREATE FUNCTION extensions.grant_pg_graphql_access() RETURNS event_trigger
    LANGUAGE plpgsql
    AS $_$
DECLARE
    func_is_graphql_resolve bool;
BEGIN
    func_is_graphql_resolve = (
        SELECT n.proname = 'resolve'
        FROM pg_event_trigger_ddl_commands() AS ev
        LEFT JOIN pg_catalog.pg_proc AS n
        ON ev.objid = n.oid
    );

    IF func_is_graphql_resolve
    THEN
        -- Update public wrapper to pass all arguments through to the pg_graphql resolve func
        DROP FUNCTION IF EXISTS graphql_public.graphql;
        create or replace function graphql_public.graphql(
            "operationName" text default null,
            query text default null,
            variables jsonb default null,
            extensions jsonb default null
        )
            returns jsonb
            language sql
        as $$
            select graphql.resolve(
                query := query,
                variables := coalesce(variables, '{}'),
                "operationName" := "operationName",
                extensions := extensions
            );
        $$;

        -- This hook executes when `graphql.resolve` is created. That is not necessarily the last
        -- function in the extension so we need to grant permissions on existing entities AND
        -- update default permissions to any others that are created after `graphql.resolve`
        grant usage on schema graphql to postgres, anon, authenticated, service_role;
        grant select on all tables in schema graphql to postgres, anon, authenticated, service_role;
        grant execute on all functions in schema graphql to postgres, anon, authenticated, service_role;
        grant all on all sequences in schema graphql to postgres, anon, authenticated, service_role;
        alter default privileges in schema graphql grant all on tables to postgres, anon, authenticated, service_role;
        alter default privileges in schema graphql grant all on functions to postgres, anon, authenticated, service_role;
        alter default privileges in schema graphql grant all on sequences to postgres, anon, authenticated, service_role;

        -- Allow postgres role to allow granting usage on graphql and graphql_public schemas to custom roles
        grant usage on schema graphql_public to postgres with grant option;
        grant usage on schema graphql to postgres with grant option;
    END IF;

END;
$_$;


--
-- Name: FUNCTION grant_pg_graphql_access(); Type: COMMENT; Schema: extensions; Owner: -
--

COMMENT ON FUNCTION extensions.grant_pg_graphql_access() IS 'Grants access to pg_graphql';


--
-- Name: grant_pg_net_access(); Type: FUNCTION; Schema: extensions; Owner: -
--

CREATE FUNCTION extensions.grant_pg_net_access() RETURNS event_trigger
    LANGUAGE plpgsql
    AS $$
BEGIN
  IF EXISTS (
    SELECT 1
    FROM pg_event_trigger_ddl_commands() AS ev
    JOIN pg_extension AS ext
    ON ev.objid = ext.oid
    WHERE ext.extname = 'pg_net'
  )
  THEN
    GRANT USAGE ON SCHEMA net TO supabase_functions_admin, postgres, anon, authenticated, service_role;

    ALTER function net.http_get(url text, params jsonb, headers jsonb, timeout_milliseconds integer) SECURITY DEFINER;
    ALTER function net.http_post(url text, body jsonb, params jsonb, headers jsonb, timeout_milliseconds integer) SECURITY DEFINER;

    ALTER function net.http_get(url text, params jsonb, headers jsonb, timeout_milliseconds integer) SET search_path = net;
    ALTER function net.http_post(url text, body jsonb, params jsonb, headers jsonb, timeout_milliseconds integer) SET search_path = net;

    REVOKE ALL ON FUNCTION net.http_get(url text, params jsonb, headers jsonb, timeout_milliseconds integer) FROM PUBLIC;
    REVOKE ALL ON FUNCTION net.http_post(url text, body jsonb, params jsonb, headers jsonb, timeout_milliseconds integer) FROM PUBLIC;

    GRANT EXECUTE ON FUNCTION net.http_get(url text, params jsonb, headers jsonb, timeout_milliseconds integer) TO supabase_functions_admin, postgres, anon, authenticated, service_role;
    GRANT EXECUTE ON FUNCTION net.http_post(url text, body jsonb, params jsonb, headers jsonb, timeout_milliseconds integer) TO supabase_functions_admin, postgres, anon, authenticated, service_role;
  END IF;
END;
$$;


--
-- Name: FUNCTION grant_pg_net_access(); Type: COMMENT; Schema: extensions; Owner: -
--

COMMENT ON FUNCTION extensions.grant_pg_net_access() IS 'Grants access to pg_net';


--
-- Name: pgrst_ddl_watch(); Type: FUNCTION; Schema: extensions; Owner: -
--

CREATE FUNCTION extensions.pgrst_ddl_watch() RETURNS event_trigger
    LANGUAGE plpgsql
    AS $$
DECLARE
  cmd record;
BEGIN
  FOR cmd IN SELECT * FROM pg_event_trigger_ddl_commands()
  LOOP
    IF cmd.command_tag IN (
      'CREATE SCHEMA', 'ALTER SCHEMA'
    , 'CREATE TABLE', 'CREATE TABLE AS', 'SELECT INTO', 'ALTER TABLE'
    , 'CREATE FOREIGN TABLE', 'ALTER FOREIGN TABLE'
    , 'CREATE VIEW', 'ALTER VIEW'
    , 'CREATE MATERIALIZED VIEW', 'ALTER MATERIALIZED VIEW'
    , 'CREATE FUNCTION', 'ALTER FUNCTION'
    , 'CREATE TRIGGER'
    , 'CREATE TYPE', 'ALTER TYPE'
    , 'CREATE RULE'
    , 'COMMENT'
    )
    -- don't notify in case of CREATE TEMP table or other objects created on pg_temp
    AND cmd.schema_name is distinct from 'pg_temp'
    THEN
      NOTIFY pgrst, 'reload schema';
    END IF;
  END LOOP;
END; $$;


--
-- Name: pgrst_drop_watch(); Type: FUNCTION; Schema: extensions; Owner: -
--

CREATE FUNCTION extensions.pgrst_drop_watch() RETURNS event_trigger
    LANGUAGE plpgsql
    AS $$
DECLARE
  obj record;
BEGIN
  FOR obj IN SELECT * FROM pg_event_trigger_dropped_objects()
  LOOP
    IF obj.object_type IN (
      'schema'
    , 'table'
    , 'foreign table'
    , 'view'
    , 'materialized view'
    , 'function'
    , 'trigger'
    , 'type'
    , 'rule'
    )
    AND obj.is_temporary IS false -- no pg_temp objects
    THEN
      NOTIFY pgrst, 'reload schema';
    END IF;
  END LOOP;
END; $$;


--
-- Name: set_graphql_placeholder(); Type: FUNCTION; Schema: extensions; Owner: -
--

CREATE FUNCTION extensions.set_graphql_placeholder() RETURNS event_trigger
    LANGUAGE plpgsql
    AS $_$
    DECLARE
    graphql_is_dropped bool;
    BEGIN
    graphql_is_dropped = (
        SELECT ev.schema_name = 'graphql_public'
        FROM pg_event_trigger_dropped_objects() AS ev
        WHERE ev.schema_name = 'graphql_public'
    );

    IF graphql_is_dropped
    THEN
        create or replace function graphql_public.graphql(
            "operationName" text default null,
            query text default null,
            variables jsonb default null,
            extensions jsonb default null
        )
            returns jsonb
            language plpgsql
        as $$
            DECLARE
                server_version float;
            BEGIN
                server_version = (SELECT (SPLIT_PART((select version()), ' ', 2))::float);

                IF server_version >= 14 THEN
                    RETURN jsonb_build_object(
                        'errors', jsonb_build_array(
                            jsonb_build_object(
                                'message', 'pg_graphql extension is not enabled.'
                            )
                        )
                    );
                ELSE
                    RETURN jsonb_build_object(
                        'errors', jsonb_build_array(
                            jsonb_build_object(
                                'message', 'pg_graphql is only available on projects running Postgres 14 onwards.'
                            )
                        )
                    );
                END IF;
            END;
        $$;
    END IF;

    END;
$_$;


--
-- Name: FUNCTION set_graphql_placeholder(); Type: COMMENT; Schema: extensions; Owner: -
--

COMMENT ON FUNCTION extensions.set_graphql_placeholder() IS 'Reintroduces placeholder function for graphql_public.graphql';


--
-- Name: get_auth(text); Type: FUNCTION; Schema: pgbouncer; Owner: -
--

CREATE FUNCTION pgbouncer.get_auth(p_usename text) RETURNS TABLE(username text, password text)
    LANGUAGE plpgsql SECURITY DEFINER
    AS $_$
begin
    raise debug 'PgBouncer auth request: %', p_usename;

    return query
    select 
        rolname::text, 
        case when rolvaliduntil < now() 
            then null 
            else rolpassword::text 
        end 
    from pg_authid 
    where rolname=$1 and rolcanlogin;
end;
$_$;


--
-- Name: handle_new_user(); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION public.handle_new_user() RETURNS trigger
    LANGUAGE plpgsql SECURITY DEFINER
    AS $$
BEGIN
  INSERT INTO public.profiles (id, email, role, full_name)
  VALUES (
    new.id,
    new.email,
    new.raw_user_meta_data->>'role',
    new.raw_user_meta_data->>'full_name'
  );
  RETURN new;
END;
$$;


--
-- Name: is_participant_in_experiment(bigint, uuid); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION public.is_participant_in_experiment(exp_id bigint, user_id uuid) RETURNS boolean
    LANGUAGE sql SECURITY DEFINER
    SET search_path TO 'public'
    AS $$
  SELECT EXISTS (
    SELECT 1
    FROM public.experiment_sessions
    WHERE experiment_id = exp_id
      AND participant_id = user_id
  );
$$;


--
-- Name: is_researcher_for_experiment(bigint, uuid); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION public.is_researcher_for_experiment(exp_id bigint, user_id uuid) RETURNS boolean
    LANGUAGE sql SECURITY DEFINER
    SET search_path TO 'public'
    AS $$
  SELECT EXISTS (
    SELECT 1
    FROM public.experiments
    WHERE experiment_id = exp_id
      AND researcher_id = user_id
  );
$$;


--
-- Name: apply_rls(jsonb, integer); Type: FUNCTION; Schema: realtime; Owner: -
--

CREATE FUNCTION realtime.apply_rls(wal jsonb, max_record_bytes integer DEFAULT (1024 * 1024)) RETURNS SETOF realtime.wal_rls
    LANGUAGE plpgsql
    AS $$
declare
-- Regclass of the table e.g. public.notes
entity_ regclass = (quote_ident(wal ->> 'schema') || '.' || quote_ident(wal ->> 'table'))::regclass;

-- I, U, D, T: insert, update ...
action realtime.action = (
    case wal ->> 'action'
        when 'I' then 'INSERT'
        when 'U' then 'UPDATE'
        when 'D' then 'DELETE'
        else 'ERROR'
    end
);

-- Is row level security enabled for the table
is_rls_enabled bool = relrowsecurity from pg_class where oid = entity_;

subscriptions realtime.subscription[] = array_agg(subs)
    from
        realtime.subscription subs
    where
        subs.entity = entity_;

-- Subscription vars
roles regrole[] = array_agg(distinct us.claims_role::text)
    from
        unnest(subscriptions) us;

working_role regrole;
claimed_role regrole;
claims jsonb;

subscription_id uuid;
subscription_has_access bool;
visible_to_subscription_ids uuid[] = '{}';

-- structured info for wal's columns
columns realtime.wal_column[];
-- previous identity values for update/delete
old_columns realtime.wal_column[];

error_record_exceeds_max_size boolean = octet_length(wal::text) > max_record_bytes;

-- Primary jsonb output for record
output jsonb;

begin
perform set_config('role', null, true);

columns =
    array_agg(
        (
            x->>'name',
            x->>'type',
            x->>'typeoid',
            realtime.cast(
                (x->'value') #>> '{}',
                coalesce(
                    (x->>'typeoid')::regtype, -- null when wal2json version <= 2.4
                    (x->>'type')::regtype
                )
            ),
            (pks ->> 'name') is not null,
            true
        )::realtime.wal_column
    )
    from
        jsonb_array_elements(wal -> 'columns') x
        left join jsonb_array_elements(wal -> 'pk') pks
            on (x ->> 'name') = (pks ->> 'name');

old_columns =
    array_agg(
        (
            x->>'name',
            x->>'type',
            x->>'typeoid',
            realtime.cast(
                (x->'value') #>> '{}',
                coalesce(
                    (x->>'typeoid')::regtype, -- null when wal2json version <= 2.4
                    (x->>'type')::regtype
                )
            ),
            (pks ->> 'name') is not null,
            true
        )::realtime.wal_column
    )
    from
        jsonb_array_elements(wal -> 'identity') x
        left join jsonb_array_elements(wal -> 'pk') pks
            on (x ->> 'name') = (pks ->> 'name');

for working_role in select * from unnest(roles) loop

    -- Update `is_selectable` for columns and old_columns
    columns =
        array_agg(
            (
                c.name,
                c.type_name,
                c.type_oid,
                c.value,
                c.is_pkey,
                pg_catalog.has_column_privilege(working_role, entity_, c.name, 'SELECT')
            )::realtime.wal_column
        )
        from
            unnest(columns) c;

    old_columns =
            array_agg(
                (
                    c.name,
                    c.type_name,
                    c.type_oid,
                    c.value,
                    c.is_pkey,
                    pg_catalog.has_column_privilege(working_role, entity_, c.name, 'SELECT')
                )::realtime.wal_column
            )
            from
                unnest(old_columns) c;

    if action <> 'DELETE' and count(1) = 0 from unnest(columns) c where c.is_pkey then
        return next (
            jsonb_build_object(
                'schema', wal ->> 'schema',
                'table', wal ->> 'table',
                'type', action
            ),
            is_rls_enabled,
            -- subscriptions is already filtered by entity
            (select array_agg(s.subscription_id) from unnest(subscriptions) as s where claims_role = working_role),
            array['Error 400: Bad Request, no primary key']
        )::realtime.wal_rls;

    -- The claims role does not have SELECT permission to the primary key of entity
    elsif action <> 'DELETE' and sum(c.is_selectable::int) <> count(1) from unnest(columns) c where c.is_pkey then
        return next (
            jsonb_build_object(
                'schema', wal ->> 'schema',
                'table', wal ->> 'table',
                'type', action
            ),
            is_rls_enabled,
            (select array_agg(s.subscription_id) from unnest(subscriptions) as s where claims_role = working_role),
            array['Error 401: Unauthorized']
        )::realtime.wal_rls;

    else
        output = jsonb_build_object(
            'schema', wal ->> 'schema',
            'table', wal ->> 'table',
            'type', action,
            'commit_timestamp', to_char(
                ((wal ->> 'timestamp')::timestamptz at time zone 'utc'),
                'YYYY-MM-DD"T"HH24:MI:SS.MS"Z"'
            ),
            'columns', (
                select
                    jsonb_agg(
                        jsonb_build_object(
                            'name', pa.attname,
                            'type', pt.typname
                        )
                        order by pa.attnum asc
                    )
                from
                    pg_attribute pa
                    join pg_type pt
                        on pa.atttypid = pt.oid
                where
                    attrelid = entity_
                    and attnum > 0
                    and pg_catalog.has_column_privilege(working_role, entity_, pa.attname, 'SELECT')
            )
        )
        -- Add "record" key for insert and update
        || case
            when action in ('INSERT', 'UPDATE') then
                jsonb_build_object(
                    'record',
                    (
                        select
                            jsonb_object_agg(
                                -- if unchanged toast, get column name and value from old record
                                coalesce((c).name, (oc).name),
                                case
                                    when (c).name is null then (oc).value
                                    else (c).value
                                end
                            )
                        from
                            unnest(columns) c
                            full outer join unnest(old_columns) oc
                                on (c).name = (oc).name
                        where
                            coalesce((c).is_selectable, (oc).is_selectable)
                            and ( not error_record_exceeds_max_size or (octet_length((c).value::text) <= 64))
                    )
                )
            else '{}'::jsonb
        end
        -- Add "old_record" key for update and delete
        || case
            when action = 'UPDATE' then
                jsonb_build_object(
                        'old_record',
                        (
                            select jsonb_object_agg((c).name, (c).value)
                            from unnest(old_columns) c
                            where
                                (c).is_selectable
                                and ( not error_record_exceeds_max_size or (octet_length((c).value::text) <= 64))
                        )
                    )
            when action = 'DELETE' then
                jsonb_build_object(
                    'old_record',
                    (
                        select jsonb_object_agg((c).name, (c).value)
                        from unnest(old_columns) c
                        where
                            (c).is_selectable
                            and ( not error_record_exceeds_max_size or (octet_length((c).value::text) <= 64))
                            and ( not is_rls_enabled or (c).is_pkey ) -- if RLS enabled, we can't secure deletes so filter to pkey
                    )
                )
            else '{}'::jsonb
        end;

        -- Create the prepared statement
        if is_rls_enabled and action <> 'DELETE' then
            if (select 1 from pg_prepared_statements where name = 'walrus_rls_stmt' limit 1) > 0 then
                deallocate walrus_rls_stmt;
            end if;
            execute realtime.build_prepared_statement_sql('walrus_rls_stmt', entity_, columns);
        end if;

        visible_to_subscription_ids = '{}';

        for subscription_id, claims in (
                select
                    subs.subscription_id,
                    subs.claims
                from
                    unnest(subscriptions) subs
                where
                    subs.entity = entity_
                    and subs.claims_role = working_role
                    and (
                        realtime.is_visible_through_filters(columns, subs.filters)
                        or (
                          action = 'DELETE'
                          and realtime.is_visible_through_filters(old_columns, subs.filters)
                        )
                    )
        ) loop

            if not is_rls_enabled or action = 'DELETE' then
                visible_to_subscription_ids = visible_to_subscription_ids || subscription_id;
            else
                -- Check if RLS allows the role to see the record
                perform
                    -- Trim leading and trailing quotes from working_role because set_config
                    -- doesn't recognize the role as valid if they are included
                    set_config('role', trim(both '"' from working_role::text), true),
                    set_config('request.jwt.claims', claims::text, true);

                execute 'execute walrus_rls_stmt' into subscription_has_access;

                if subscription_has_access then
                    visible_to_subscription_ids = visible_to_subscription_ids || subscription_id;
                end if;
            end if;
        end loop;

        perform set_config('role', null, true);

        return next (
            output,
            is_rls_enabled,
            visible_to_subscription_ids,
            case
                when error_record_exceeds_max_size then array['Error 413: Payload Too Large']
                else '{}'
            end
        )::realtime.wal_rls;

    end if;
end loop;

perform set_config('role', null, true);
end;
$$;


--
-- Name: broadcast_changes(text, text, text, text, text, record, record, text); Type: FUNCTION; Schema: realtime; Owner: -
--

CREATE FUNCTION realtime.broadcast_changes(topic_name text, event_name text, operation text, table_name text, table_schema text, new record, old record, level text DEFAULT 'ROW'::text) RETURNS void
    LANGUAGE plpgsql
    AS $$
DECLARE
    -- Declare a variable to hold the JSONB representation of the row
    row_data jsonb := '{}'::jsonb;
BEGIN
    IF level = 'STATEMENT' THEN
        RAISE EXCEPTION 'function can only be triggered for each row, not for each statement';
    END IF;
    -- Check the operation type and handle accordingly
    IF operation = 'INSERT' OR operation = 'UPDATE' OR operation = 'DELETE' THEN
        row_data := jsonb_build_object('old_record', OLD, 'record', NEW, 'operation', operation, 'table', table_name, 'schema', table_schema);
        PERFORM realtime.send (row_data, event_name, topic_name);
    ELSE
        RAISE EXCEPTION 'Unexpected operation type: %', operation;
    END IF;
EXCEPTION
    WHEN OTHERS THEN
        RAISE EXCEPTION 'Failed to process the row: %', SQLERRM;
END;

$$;


--
-- Name: build_prepared_statement_sql(text, regclass, realtime.wal_column[]); Type: FUNCTION; Schema: realtime; Owner: -
--

CREATE FUNCTION realtime.build_prepared_statement_sql(prepared_statement_name text, entity regclass, columns realtime.wal_column[]) RETURNS text
    LANGUAGE sql
    AS $$
      /*
      Builds a sql string that, if executed, creates a prepared statement to
      tests retrive a row from *entity* by its primary key columns.
      Example
          select realtime.build_prepared_statement_sql('public.notes', '{"id"}'::text[], '{"bigint"}'::text[])
      */
          select
      'prepare ' || prepared_statement_name || ' as
          select
              exists(
                  select
                      1
                  from
                      ' || entity || '
                  where
                      ' || string_agg(quote_ident(pkc.name) || '=' || quote_nullable(pkc.value #>> '{}') , ' and ') || '
              )'
          from
              unnest(columns) pkc
          where
              pkc.is_pkey
          group by
              entity
      $$;


--
-- Name: cast(text, regtype); Type: FUNCTION; Schema: realtime; Owner: -
--

CREATE FUNCTION realtime."cast"(val text, type_ regtype) RETURNS jsonb
    LANGUAGE plpgsql IMMUTABLE
    AS $$
    declare
      res jsonb;
    begin
      execute format('select to_jsonb(%L::'|| type_::text || ')', val)  into res;
      return res;
    end
    $$;


--
-- Name: check_equality_op(realtime.equality_op, regtype, text, text); Type: FUNCTION; Schema: realtime; Owner: -
--

CREATE FUNCTION realtime.check_equality_op(op realtime.equality_op, type_ regtype, val_1 text, val_2 text) RETURNS boolean
    LANGUAGE plpgsql IMMUTABLE
    AS $$
      /*
      Casts *val_1* and *val_2* as type *type_* and check the *op* condition for truthiness
      */
      declare
          op_symbol text = (
              case
                  when op = 'eq' then '='
                  when op = 'neq' then '!='
                  when op = 'lt' then '<'
                  when op = 'lte' then '<='
                  when op = 'gt' then '>'
                  when op = 'gte' then '>='
                  when op = 'in' then '= any'
                  else 'UNKNOWN OP'
              end
          );
          res boolean;
      begin
          execute format(
              'select %L::'|| type_::text || ' ' || op_symbol
              || ' ( %L::'
              || (
                  case
                      when op = 'in' then type_::text || '[]'
                      else type_::text end
              )
              || ')', val_1, val_2) into res;
          return res;
      end;
      $$;


--
-- Name: is_visible_through_filters(realtime.wal_column[], realtime.user_defined_filter[]); Type: FUNCTION; Schema: realtime; Owner: -
--

CREATE FUNCTION realtime.is_visible_through_filters(columns realtime.wal_column[], filters realtime.user_defined_filter[]) RETURNS boolean
    LANGUAGE sql IMMUTABLE
    AS $_$
    /*
    Should the record be visible (true) or filtered out (false) after *filters* are applied
    */
        select
            -- Default to allowed when no filters present
            $2 is null -- no filters. this should not happen because subscriptions has a default
            or array_length($2, 1) is null -- array length of an empty array is null
            or bool_and(
                coalesce(
                    realtime.check_equality_op(
                        op:=f.op,
                        type_:=coalesce(
                            col.type_oid::regtype, -- null when wal2json version <= 2.4
                            col.type_name::regtype
                        ),
                        -- cast jsonb to text
                        val_1:=col.value #>> '{}',
                        val_2:=f.value
                    ),
                    false -- if null, filter does not match
                )
            )
        from
            unnest(filters) f
            join unnest(columns) col
                on f.column_name = col.name;
    $_$;


--
-- Name: list_changes(name, name, integer, integer); Type: FUNCTION; Schema: realtime; Owner: -
--

CREATE FUNCTION realtime.list_changes(publication name, slot_name name, max_changes integer, max_record_bytes integer) RETURNS SETOF realtime.wal_rls
    LANGUAGE sql
    SET log_min_messages TO 'fatal'
    AS $$
      with pub as (
        select
          concat_ws(
            ',',
            case when bool_or(pubinsert) then 'insert' else null end,
            case when bool_or(pubupdate) then 'update' else null end,
            case when bool_or(pubdelete) then 'delete' else null end
          ) as w2j_actions,
          coalesce(
            string_agg(
              realtime.quote_wal2json(format('%I.%I', schemaname, tablename)::regclass),
              ','
            ) filter (where ppt.tablename is not null and ppt.tablename not like '% %'),
            ''
          ) w2j_add_tables
        from
          pg_publication pp
          left join pg_publication_tables ppt
            on pp.pubname = ppt.pubname
        where
          pp.pubname = publication
        group by
          pp.pubname
        limit 1
      ),
      w2j as (
        select
          x.*, pub.w2j_add_tables
        from
          pub,
          pg_logical_slot_get_changes(
            slot_name, null, max_changes,
            'include-pk', 'true',
            'include-transaction', 'false',
            'include-timestamp', 'true',
            'include-type-oids', 'true',
            'format-version', '2',
            'actions', pub.w2j_actions,
            'add-tables', pub.w2j_add_tables
          ) x
      )
      select
        xyz.wal,
        xyz.is_rls_enabled,
        xyz.subscription_ids,
        xyz.errors
      from
        w2j,
        realtime.apply_rls(
          wal := w2j.data::jsonb,
          max_record_bytes := max_record_bytes
        ) xyz(wal, is_rls_enabled, subscription_ids, errors)
      where
        w2j.w2j_add_tables <> ''
        and xyz.subscription_ids[1] is not null
    $$;


--
-- Name: quote_wal2json(regclass); Type: FUNCTION; Schema: realtime; Owner: -
--

CREATE FUNCTION realtime.quote_wal2json(entity regclass) RETURNS text
    LANGUAGE sql IMMUTABLE STRICT
    AS $$
      select
        (
          select string_agg('' || ch,'')
          from unnest(string_to_array(nsp.nspname::text, null)) with ordinality x(ch, idx)
          where
            not (x.idx = 1 and x.ch = '"')
            and not (
              x.idx = array_length(string_to_array(nsp.nspname::text, null), 1)
              and x.ch = '"'
            )
        )
        || '.'
        || (
          select string_agg('' || ch,'')
          from unnest(string_to_array(pc.relname::text, null)) with ordinality x(ch, idx)
          where
            not (x.idx = 1 and x.ch = '"')
            and not (
              x.idx = array_length(string_to_array(nsp.nspname::text, null), 1)
              and x.ch = '"'
            )
          )
      from
        pg_class pc
        join pg_namespace nsp
          on pc.relnamespace = nsp.oid
      where
        pc.oid = entity
    $$;


--
-- Name: send(jsonb, text, text, boolean); Type: FUNCTION; Schema: realtime; Owner: -
--

CREATE FUNCTION realtime.send(payload jsonb, event text, topic text, private boolean DEFAULT true) RETURNS void
    LANGUAGE plpgsql
    AS $$
DECLARE
  generated_id uuid;
  final_payload jsonb;
BEGIN
  BEGIN
    -- Generate a new UUID for the id
    generated_id := gen_random_uuid();

    -- Check if payload has an 'id' key, if not, add the generated UUID
    IF payload ? 'id' THEN
      final_payload := payload;
    ELSE
      final_payload := jsonb_set(payload, '{id}', to_jsonb(generated_id));
    END IF;

    -- Set the topic configuration
    EXECUTE format('SET LOCAL realtime.topic TO %L', topic);

    -- Attempt to insert the message
    INSERT INTO realtime.messages (id, payload, event, topic, private, extension)
    VALUES (generated_id, final_payload, event, topic, private, 'broadcast');
  EXCEPTION
    WHEN OTHERS THEN
      -- Capture and notify the error
      RAISE WARNING 'ErrorSendingBroadcastMessage: %', SQLERRM;
  END;
END;
$$;


--
-- Name: subscription_check_filters(); Type: FUNCTION; Schema: realtime; Owner: -
--

CREATE FUNCTION realtime.subscription_check_filters() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
    /*
    Validates that the user defined filters for a subscription:
    - refer to valid columns that the claimed role may access
    - values are coercable to the correct column type
    */
    declare
        col_names text[] = coalesce(
                array_agg(c.column_name order by c.ordinal_position),
                '{}'::text[]
            )
            from
                information_schema.columns c
            where
                format('%I.%I', c.table_schema, c.table_name)::regclass = new.entity
                and pg_catalog.has_column_privilege(
                    (new.claims ->> 'role'),
                    format('%I.%I', c.table_schema, c.table_name)::regclass,
                    c.column_name,
                    'SELECT'
                );
        filter realtime.user_defined_filter;
        col_type regtype;

        in_val jsonb;
    begin
        for filter in select * from unnest(new.filters) loop
            -- Filtered column is valid
            if not filter.column_name = any(col_names) then
                raise exception 'invalid column for filter %', filter.column_name;
            end if;

            -- Type is sanitized and safe for string interpolation
            col_type = (
                select atttypid::regtype
                from pg_catalog.pg_attribute
                where attrelid = new.entity
                      and attname = filter.column_name
            );
            if col_type is null then
                raise exception 'failed to lookup type for column %', filter.column_name;
            end if;

            -- Set maximum number of entries for in filter
            if filter.op = 'in'::realtime.equality_op then
                in_val = realtime.cast(filter.value, (col_type::text || '[]')::regtype);
                if coalesce(jsonb_array_length(in_val), 0) > 100 then
                    raise exception 'too many values for `in` filter. Maximum 100';
                end if;
            else
                -- raises an exception if value is not coercable to type
                perform realtime.cast(filter.value, col_type);
            end if;

        end loop;

        -- Apply consistent order to filters so the unique constraint on
        -- (subscription_id, entity, filters) can't be tricked by a different filter order
        new.filters = coalesce(
            array_agg(f order by f.column_name, f.op, f.value),
            '{}'
        ) from unnest(new.filters) f;

        return new;
    end;
    $$;


--
-- Name: to_regrole(text); Type: FUNCTION; Schema: realtime; Owner: -
--

CREATE FUNCTION realtime.to_regrole(role_name text) RETURNS regrole
    LANGUAGE sql IMMUTABLE
    AS $$ select role_name::regrole $$;


--
-- Name: topic(); Type: FUNCTION; Schema: realtime; Owner: -
--

CREATE FUNCTION realtime.topic() RETURNS text
    LANGUAGE sql STABLE
    AS $$
select nullif(current_setting('realtime.topic', true), '')::text;
$$;


--
-- Name: add_prefixes(text, text); Type: FUNCTION; Schema: storage; Owner: -
--

CREATE FUNCTION storage.add_prefixes(_bucket_id text, _name text) RETURNS void
    LANGUAGE plpgsql SECURITY DEFINER
    AS $$
DECLARE
    prefixes text[];
BEGIN
    prefixes := "storage"."get_prefixes"("_name");

    IF array_length(prefixes, 1) > 0 THEN
        INSERT INTO storage.prefixes (name, bucket_id)
        SELECT UNNEST(prefixes) as name, "_bucket_id" ON CONFLICT DO NOTHING;
    END IF;
END;
$$;


--
-- Name: can_insert_object(text, text, uuid, jsonb); Type: FUNCTION; Schema: storage; Owner: -
--

CREATE FUNCTION storage.can_insert_object(bucketid text, name text, owner uuid, metadata jsonb) RETURNS void
    LANGUAGE plpgsql
    AS $$
BEGIN
  INSERT INTO "storage"."objects" ("bucket_id", "name", "owner", "metadata") VALUES (bucketid, name, owner, metadata);
  -- hack to rollback the successful insert
  RAISE sqlstate 'PT200' using
  message = 'ROLLBACK',
  detail = 'rollback successful insert';
END
$$;


--
-- Name: delete_leaf_prefixes(text[], text[]); Type: FUNCTION; Schema: storage; Owner: -
--

CREATE FUNCTION storage.delete_leaf_prefixes(bucket_ids text[], names text[]) RETURNS void
    LANGUAGE plpgsql SECURITY DEFINER
    AS $$
DECLARE
    v_rows_deleted integer;
BEGIN
    LOOP
        WITH candidates AS (
            SELECT DISTINCT
                t.bucket_id,
                unnest(storage.get_prefixes(t.name)) AS name
            FROM unnest(bucket_ids, names) AS t(bucket_id, name)
        ),
        uniq AS (
             SELECT
                 bucket_id,
                 name,
                 storage.get_level(name) AS level
             FROM candidates
             WHERE name <> ''
             GROUP BY bucket_id, name
        ),
        leaf AS (
             SELECT
                 p.bucket_id,
                 p.name,
                 p.level
             FROM storage.prefixes AS p
                  JOIN uniq AS u
                       ON u.bucket_id = p.bucket_id
                           AND u.name = p.name
                           AND u.level = p.level
             WHERE NOT EXISTS (
                 SELECT 1
                 FROM storage.objects AS o
                 WHERE o.bucket_id = p.bucket_id
                   AND o.level = p.level + 1
                   AND o.name COLLATE "C" LIKE p.name || '/%'
             )
             AND NOT EXISTS (
                 SELECT 1
                 FROM storage.prefixes AS c
                 WHERE c.bucket_id = p.bucket_id
                   AND c.level = p.level + 1
                   AND c.name COLLATE "C" LIKE p.name || '/%'
             )
        )
        DELETE
        FROM storage.prefixes AS p
            USING leaf AS l
        WHERE p.bucket_id = l.bucket_id
          AND p.name = l.name
          AND p.level = l.level;

        GET DIAGNOSTICS v_rows_deleted = ROW_COUNT;
        EXIT WHEN v_rows_deleted = 0;
    END LOOP;
END;
$$;


--
-- Name: delete_prefix(text, text); Type: FUNCTION; Schema: storage; Owner: -
--

CREATE FUNCTION storage.delete_prefix(_bucket_id text, _name text) RETURNS boolean
    LANGUAGE plpgsql SECURITY DEFINER
    AS $$
BEGIN
    -- Check if we can delete the prefix
    IF EXISTS(
        SELECT FROM "storage"."prefixes"
        WHERE "prefixes"."bucket_id" = "_bucket_id"
          AND level = "storage"."get_level"("_name") + 1
          AND "prefixes"."name" COLLATE "C" LIKE "_name" || '/%'
        LIMIT 1
    )
    OR EXISTS(
        SELECT FROM "storage"."objects"
        WHERE "objects"."bucket_id" = "_bucket_id"
          AND "storage"."get_level"("objects"."name") = "storage"."get_level"("_name") + 1
          AND "objects"."name" COLLATE "C" LIKE "_name" || '/%'
        LIMIT 1
    ) THEN
    -- There are sub-objects, skip deletion
    RETURN false;
    ELSE
        DELETE FROM "storage"."prefixes"
        WHERE "prefixes"."bucket_id" = "_bucket_id"
          AND level = "storage"."get_level"("_name")
          AND "prefixes"."name" = "_name";
        RETURN true;
    END IF;
END;
$$;


--
-- Name: delete_prefix_hierarchy_trigger(); Type: FUNCTION; Schema: storage; Owner: -
--

CREATE FUNCTION storage.delete_prefix_hierarchy_trigger() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
DECLARE
    prefix text;
BEGIN
    prefix := "storage"."get_prefix"(OLD."name");

    IF coalesce(prefix, '') != '' THEN
        PERFORM "storage"."delete_prefix"(OLD."bucket_id", prefix);
    END IF;

    RETURN OLD;
END;
$$;


--
-- Name: enforce_bucket_name_length(); Type: FUNCTION; Schema: storage; Owner: -
--

CREATE FUNCTION storage.enforce_bucket_name_length() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
begin
    if length(new.name) > 100 then
        raise exception 'bucket name "%" is too long (% characters). Max is 100.', new.name, length(new.name);
    end if;
    return new;
end;
$$;


--
-- Name: extension(text); Type: FUNCTION; Schema: storage; Owner: -
--

CREATE FUNCTION storage.extension(name text) RETURNS text
    LANGUAGE plpgsql IMMUTABLE
    AS $$
DECLARE
    _parts text[];
    _filename text;
BEGIN
    SELECT string_to_array(name, '/') INTO _parts;
    SELECT _parts[array_length(_parts,1)] INTO _filename;
    RETURN reverse(split_part(reverse(_filename), '.', 1));
END
$$;


--
-- Name: filename(text); Type: FUNCTION; Schema: storage; Owner: -
--

CREATE FUNCTION storage.filename(name text) RETURNS text
    LANGUAGE plpgsql
    AS $$
DECLARE
_parts text[];
BEGIN
	select string_to_array(name, '/') into _parts;
	return _parts[array_length(_parts,1)];
END
$$;


--
-- Name: foldername(text); Type: FUNCTION; Schema: storage; Owner: -
--

CREATE FUNCTION storage.foldername(name text) RETURNS text[]
    LANGUAGE plpgsql IMMUTABLE
    AS $$
DECLARE
    _parts text[];
BEGIN
    -- Split on "/" to get path segments
    SELECT string_to_array(name, '/') INTO _parts;
    -- Return everything except the last segment
    RETURN _parts[1 : array_length(_parts,1) - 1];
END
$$;


--
-- Name: get_level(text); Type: FUNCTION; Schema: storage; Owner: -
--

CREATE FUNCTION storage.get_level(name text) RETURNS integer
    LANGUAGE sql IMMUTABLE STRICT
    AS $$
SELECT array_length(string_to_array("name", '/'), 1);
$$;


--
-- Name: get_prefix(text); Type: FUNCTION; Schema: storage; Owner: -
--

CREATE FUNCTION storage.get_prefix(name text) RETURNS text
    LANGUAGE sql IMMUTABLE STRICT
    AS $_$
SELECT
    CASE WHEN strpos("name", '/') > 0 THEN
             regexp_replace("name", '[\/]{1}[^\/]+\/?$', '')
         ELSE
             ''
        END;
$_$;


--
-- Name: get_prefixes(text); Type: FUNCTION; Schema: storage; Owner: -
--

CREATE FUNCTION storage.get_prefixes(name text) RETURNS text[]
    LANGUAGE plpgsql IMMUTABLE STRICT
    AS $$
DECLARE
    parts text[];
    prefixes text[];
    prefix text;
BEGIN
    -- Split the name into parts by '/'
    parts := string_to_array("name", '/');
    prefixes := '{}';

    -- Construct the prefixes, stopping one level below the last part
    FOR i IN 1..array_length(parts, 1) - 1 LOOP
            prefix := array_to_string(parts[1:i], '/');
            prefixes := array_append(prefixes, prefix);
    END LOOP;

    RETURN prefixes;
END;
$$;


--
-- Name: get_size_by_bucket(); Type: FUNCTION; Schema: storage; Owner: -
--

CREATE FUNCTION storage.get_size_by_bucket() RETURNS TABLE(size bigint, bucket_id text)
    LANGUAGE plpgsql STABLE
    AS $$
BEGIN
    return query
        select sum((metadata->>'size')::bigint) as size, obj.bucket_id
        from "storage".objects as obj
        group by obj.bucket_id;
END
$$;


--
-- Name: list_multipart_uploads_with_delimiter(text, text, text, integer, text, text); Type: FUNCTION; Schema: storage; Owner: -
--

CREATE FUNCTION storage.list_multipart_uploads_with_delimiter(bucket_id text, prefix_param text, delimiter_param text, max_keys integer DEFAULT 100, next_key_token text DEFAULT ''::text, next_upload_token text DEFAULT ''::text) RETURNS TABLE(key text, id text, created_at timestamp with time zone)
    LANGUAGE plpgsql
    AS $_$
BEGIN
    RETURN QUERY EXECUTE
        'SELECT DISTINCT ON(key COLLATE "C") * from (
            SELECT
                CASE
                    WHEN position($2 IN substring(key from length($1) + 1)) > 0 THEN
                        substring(key from 1 for length($1) + position($2 IN substring(key from length($1) + 1)))
                    ELSE
                        key
                END AS key, id, created_at
            FROM
                storage.s3_multipart_uploads
            WHERE
                bucket_id = $5 AND
                key ILIKE $1 || ''%'' AND
                CASE
                    WHEN $4 != '''' AND $6 = '''' THEN
                        CASE
                            WHEN position($2 IN substring(key from length($1) + 1)) > 0 THEN
                                substring(key from 1 for length($1) + position($2 IN substring(key from length($1) + 1))) COLLATE "C" > $4
                            ELSE
                                key COLLATE "C" > $4
                            END
                    ELSE
                        true
                END AND
                CASE
                    WHEN $6 != '''' THEN
                        id COLLATE "C" > $6
                    ELSE
                        true
                    END
            ORDER BY
                key COLLATE "C" ASC, created_at ASC) as e order by key COLLATE "C" LIMIT $3'
        USING prefix_param, delimiter_param, max_keys, next_key_token, bucket_id, next_upload_token;
END;
$_$;


--
-- Name: list_objects_with_delimiter(text, text, text, integer, text, text); Type: FUNCTION; Schema: storage; Owner: -
--

CREATE FUNCTION storage.list_objects_with_delimiter(bucket_id text, prefix_param text, delimiter_param text, max_keys integer DEFAULT 100, start_after text DEFAULT ''::text, next_token text DEFAULT ''::text) RETURNS TABLE(name text, id uuid, metadata jsonb, updated_at timestamp with time zone)
    LANGUAGE plpgsql
    AS $_$
BEGIN
    RETURN QUERY EXECUTE
        'SELECT DISTINCT ON(name COLLATE "C") * from (
            SELECT
                CASE
                    WHEN position($2 IN substring(name from length($1) + 1)) > 0 THEN
                        substring(name from 1 for length($1) + position($2 IN substring(name from length($1) + 1)))
                    ELSE
                        name
                END AS name, id, metadata, updated_at
            FROM
                storage.objects
            WHERE
                bucket_id = $5 AND
                name ILIKE $1 || ''%'' AND
                CASE
                    WHEN $6 != '''' THEN
                    name COLLATE "C" > $6
                ELSE true END
                AND CASE
                    WHEN $4 != '''' THEN
                        CASE
                            WHEN position($2 IN substring(name from length($1) + 1)) > 0 THEN
                                substring(name from 1 for length($1) + position($2 IN substring(name from length($1) + 1))) COLLATE "C" > $4
                            ELSE
                                name COLLATE "C" > $4
                            END
                    ELSE
                        true
                END
            ORDER BY
                name COLLATE "C" ASC) as e order by name COLLATE "C" LIMIT $3'
        USING prefix_param, delimiter_param, max_keys, next_token, bucket_id, start_after;
END;
$_$;


--
-- Name: lock_top_prefixes(text[], text[]); Type: FUNCTION; Schema: storage; Owner: -
--

CREATE FUNCTION storage.lock_top_prefixes(bucket_ids text[], names text[]) RETURNS void
    LANGUAGE plpgsql SECURITY DEFINER
    AS $$
DECLARE
    v_bucket text;
    v_top text;
BEGIN
    FOR v_bucket, v_top IN
        SELECT DISTINCT t.bucket_id,
            split_part(t.name, '/', 1) AS top
        FROM unnest(bucket_ids, names) AS t(bucket_id, name)
        WHERE t.name <> ''
        ORDER BY 1, 2
        LOOP
            PERFORM pg_advisory_xact_lock(hashtextextended(v_bucket || '/' || v_top, 0));
        END LOOP;
END;
$$;


--
-- Name: objects_delete_cleanup(); Type: FUNCTION; Schema: storage; Owner: -
--

CREATE FUNCTION storage.objects_delete_cleanup() RETURNS trigger
    LANGUAGE plpgsql SECURITY DEFINER
    AS $$
DECLARE
    v_bucket_ids text[];
    v_names      text[];
BEGIN
    IF current_setting('storage.gc.prefixes', true) = '1' THEN
        RETURN NULL;
    END IF;

    PERFORM set_config('storage.gc.prefixes', '1', true);

    SELECT COALESCE(array_agg(d.bucket_id), '{}'),
           COALESCE(array_agg(d.name), '{}')
    INTO v_bucket_ids, v_names
    FROM deleted AS d
    WHERE d.name <> '';

    PERFORM storage.lock_top_prefixes(v_bucket_ids, v_names);
    PERFORM storage.delete_leaf_prefixes(v_bucket_ids, v_names);

    RETURN NULL;
END;
$$;


--
-- Name: objects_insert_prefix_trigger(); Type: FUNCTION; Schema: storage; Owner: -
--

CREATE FUNCTION storage.objects_insert_prefix_trigger() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
BEGIN
    PERFORM "storage"."add_prefixes"(NEW."bucket_id", NEW."name");
    NEW.level := "storage"."get_level"(NEW."name");

    RETURN NEW;
END;
$$;


--
-- Name: objects_update_cleanup(); Type: FUNCTION; Schema: storage; Owner: -
--

CREATE FUNCTION storage.objects_update_cleanup() RETURNS trigger
    LANGUAGE plpgsql SECURITY DEFINER
    AS $$
DECLARE
    -- NEW - OLD (destinations to create prefixes for)
    v_add_bucket_ids text[];
    v_add_names      text[];

    -- OLD - NEW (sources to prune)
    v_src_bucket_ids text[];
    v_src_names      text[];
BEGIN
    IF TG_OP <> 'UPDATE' THEN
        RETURN NULL;
    END IF;

    -- 1) Compute NEW−OLD (added paths) and OLD−NEW (moved-away paths)
    WITH added AS (
        SELECT n.bucket_id, n.name
        FROM new_rows n
        WHERE n.name <> '' AND position('/' in n.name) > 0
        EXCEPT
        SELECT o.bucket_id, o.name FROM old_rows o WHERE o.name <> ''
    ),
    moved AS (
         SELECT o.bucket_id, o.name
         FROM old_rows o
         WHERE o.name <> ''
         EXCEPT
         SELECT n.bucket_id, n.name FROM new_rows n WHERE n.name <> ''
    )
    SELECT
        -- arrays for ADDED (dest) in stable order
        COALESCE( (SELECT array_agg(a.bucket_id ORDER BY a.bucket_id, a.name) FROM added a), '{}' ),
        COALESCE( (SELECT array_agg(a.name      ORDER BY a.bucket_id, a.name) FROM added a), '{}' ),
        -- arrays for MOVED (src) in stable order
        COALESCE( (SELECT array_agg(m.bucket_id ORDER BY m.bucket_id, m.name) FROM moved m), '{}' ),
        COALESCE( (SELECT array_agg(m.name      ORDER BY m.bucket_id, m.name) FROM moved m), '{}' )
    INTO v_add_bucket_ids, v_add_names, v_src_bucket_ids, v_src_names;

    -- Nothing to do?
    IF (array_length(v_add_bucket_ids, 1) IS NULL) AND (array_length(v_src_bucket_ids, 1) IS NULL) THEN
        RETURN NULL;
    END IF;

    -- 2) Take per-(bucket, top) locks: ALL prefixes in consistent global order to prevent deadlocks
    DECLARE
        v_all_bucket_ids text[];
        v_all_names text[];
    BEGIN
        -- Combine source and destination arrays for consistent lock ordering
        v_all_bucket_ids := COALESCE(v_src_bucket_ids, '{}') || COALESCE(v_add_bucket_ids, '{}');
        v_all_names := COALESCE(v_src_names, '{}') || COALESCE(v_add_names, '{}');

        -- Single lock call ensures consistent global ordering across all transactions
        IF array_length(v_all_bucket_ids, 1) IS NOT NULL THEN
            PERFORM storage.lock_top_prefixes(v_all_bucket_ids, v_all_names);
        END IF;
    END;

    -- 3) Create destination prefixes (NEW−OLD) BEFORE pruning sources
    IF array_length(v_add_bucket_ids, 1) IS NOT NULL THEN
        WITH candidates AS (
            SELECT DISTINCT t.bucket_id, unnest(storage.get_prefixes(t.name)) AS name
            FROM unnest(v_add_bucket_ids, v_add_names) AS t(bucket_id, name)
            WHERE name <> ''
        )
        INSERT INTO storage.prefixes (bucket_id, name)
        SELECT c.bucket_id, c.name
        FROM candidates c
        ON CONFLICT DO NOTHING;
    END IF;

    -- 4) Prune source prefixes bottom-up for OLD−NEW
    IF array_length(v_src_bucket_ids, 1) IS NOT NULL THEN
        -- re-entrancy guard so DELETE on prefixes won't recurse
        IF current_setting('storage.gc.prefixes', true) <> '1' THEN
            PERFORM set_config('storage.gc.prefixes', '1', true);
        END IF;

        PERFORM storage.delete_leaf_prefixes(v_src_bucket_ids, v_src_names);
    END IF;

    RETURN NULL;
END;
$$;


--
-- Name: objects_update_level_trigger(); Type: FUNCTION; Schema: storage; Owner: -
--

CREATE FUNCTION storage.objects_update_level_trigger() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
BEGIN
    -- Ensure this is an update operation and the name has changed
    IF TG_OP = 'UPDATE' AND (NEW."name" <> OLD."name" OR NEW."bucket_id" <> OLD."bucket_id") THEN
        -- Set the new level
        NEW."level" := "storage"."get_level"(NEW."name");
    END IF;
    RETURN NEW;
END;
$$;


--
-- Name: objects_update_prefix_trigger(); Type: FUNCTION; Schema: storage; Owner: -
--

CREATE FUNCTION storage.objects_update_prefix_trigger() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
DECLARE
    old_prefixes TEXT[];
BEGIN
    -- Ensure this is an update operation and the name has changed
    IF TG_OP = 'UPDATE' AND (NEW."name" <> OLD."name" OR NEW."bucket_id" <> OLD."bucket_id") THEN
        -- Retrieve old prefixes
        old_prefixes := "storage"."get_prefixes"(OLD."name");

        -- Remove old prefixes that are only used by this object
        WITH all_prefixes as (
            SELECT unnest(old_prefixes) as prefix
        ),
        can_delete_prefixes as (
             SELECT prefix
             FROM all_prefixes
             WHERE NOT EXISTS (
                 SELECT 1 FROM "storage"."objects"
                 WHERE "bucket_id" = OLD."bucket_id"
                   AND "name" <> OLD."name"
                   AND "name" LIKE (prefix || '%')
             )
         )
        DELETE FROM "storage"."prefixes" WHERE name IN (SELECT prefix FROM can_delete_prefixes);

        -- Add new prefixes
        PERFORM "storage"."add_prefixes"(NEW."bucket_id", NEW."name");
    END IF;
    -- Set the new level
    NEW."level" := "storage"."get_level"(NEW."name");

    RETURN NEW;
END;
$$;


--
-- Name: operation(); Type: FUNCTION; Schema: storage; Owner: -
--

CREATE FUNCTION storage.operation() RETURNS text
    LANGUAGE plpgsql STABLE
    AS $$
BEGIN
    RETURN current_setting('storage.operation', true);
END;
$$;


--
-- Name: prefixes_delete_cleanup(); Type: FUNCTION; Schema: storage; Owner: -
--

CREATE FUNCTION storage.prefixes_delete_cleanup() RETURNS trigger
    LANGUAGE plpgsql SECURITY DEFINER
    AS $$
DECLARE
    v_bucket_ids text[];
    v_names      text[];
BEGIN
    IF current_setting('storage.gc.prefixes', true) = '1' THEN
        RETURN NULL;
    END IF;

    PERFORM set_config('storage.gc.prefixes', '1', true);

    SELECT COALESCE(array_agg(d.bucket_id), '{}'),
           COALESCE(array_agg(d.name), '{}')
    INTO v_bucket_ids, v_names
    FROM deleted AS d
    WHERE d.name <> '';

    PERFORM storage.lock_top_prefixes(v_bucket_ids, v_names);
    PERFORM storage.delete_leaf_prefixes(v_bucket_ids, v_names);

    RETURN NULL;
END;
$$;


--
-- Name: prefixes_insert_trigger(); Type: FUNCTION; Schema: storage; Owner: -
--

CREATE FUNCTION storage.prefixes_insert_trigger() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
BEGIN
    PERFORM "storage"."add_prefixes"(NEW."bucket_id", NEW."name");
    RETURN NEW;
END;
$$;


--
-- Name: search(text, text, integer, integer, integer, text, text, text); Type: FUNCTION; Schema: storage; Owner: -
--

CREATE FUNCTION storage.search(prefix text, bucketname text, limits integer DEFAULT 100, levels integer DEFAULT 1, offsets integer DEFAULT 0, search text DEFAULT ''::text, sortcolumn text DEFAULT 'name'::text, sortorder text DEFAULT 'asc'::text) RETURNS TABLE(name text, id uuid, updated_at timestamp with time zone, created_at timestamp with time zone, last_accessed_at timestamp with time zone, metadata jsonb)
    LANGUAGE plpgsql
    AS $$
declare
    can_bypass_rls BOOLEAN;
begin
    SELECT rolbypassrls
    INTO can_bypass_rls
    FROM pg_roles
    WHERE rolname = coalesce(nullif(current_setting('role', true), 'none'), current_user);

    IF can_bypass_rls THEN
        RETURN QUERY SELECT * FROM storage.search_v1_optimised(prefix, bucketname, limits, levels, offsets, search, sortcolumn, sortorder);
    ELSE
        RETURN QUERY SELECT * FROM storage.search_legacy_v1(prefix, bucketname, limits, levels, offsets, search, sortcolumn, sortorder);
    END IF;
end;
$$;


--
-- Name: search_legacy_v1(text, text, integer, integer, integer, text, text, text); Type: FUNCTION; Schema: storage; Owner: -
--

CREATE FUNCTION storage.search_legacy_v1(prefix text, bucketname text, limits integer DEFAULT 100, levels integer DEFAULT 1, offsets integer DEFAULT 0, search text DEFAULT ''::text, sortcolumn text DEFAULT 'name'::text, sortorder text DEFAULT 'asc'::text) RETURNS TABLE(name text, id uuid, updated_at timestamp with time zone, created_at timestamp with time zone, last_accessed_at timestamp with time zone, metadata jsonb)
    LANGUAGE plpgsql STABLE
    AS $_$
declare
    v_order_by text;
    v_sort_order text;
begin
    case
        when sortcolumn = 'name' then
            v_order_by = 'name';
        when sortcolumn = 'updated_at' then
            v_order_by = 'updated_at';
        when sortcolumn = 'created_at' then
            v_order_by = 'created_at';
        when sortcolumn = 'last_accessed_at' then
            v_order_by = 'last_accessed_at';
        else
            v_order_by = 'name';
        end case;

    case
        when sortorder = 'asc' then
            v_sort_order = 'asc';
        when sortorder = 'desc' then
            v_sort_order = 'desc';
        else
            v_sort_order = 'asc';
        end case;

    v_order_by = v_order_by || ' ' || v_sort_order;

    return query execute
        'with folders as (
           select path_tokens[$1] as folder
           from storage.objects
             where objects.name ilike $2 || $3 || ''%''
               and bucket_id = $4
               and array_length(objects.path_tokens, 1) <> $1
           group by folder
           order by folder ' || v_sort_order || '
     )
     (select folder as "name",
            null as id,
            null as updated_at,
            null as created_at,
            null as last_accessed_at,
            null as metadata from folders)
     union all
     (select path_tokens[$1] as "name",
            id,
            updated_at,
            created_at,
            last_accessed_at,
            metadata
     from storage.objects
     where objects.name ilike $2 || $3 || ''%''
       and bucket_id = $4
       and array_length(objects.path_tokens, 1) = $1
     order by ' || v_order_by || ')
     limit $5
     offset $6' using levels, prefix, search, bucketname, limits, offsets;
end;
$_$;


--
-- Name: search_v1_optimised(text, text, integer, integer, integer, text, text, text); Type: FUNCTION; Schema: storage; Owner: -
--

CREATE FUNCTION storage.search_v1_optimised(prefix text, bucketname text, limits integer DEFAULT 100, levels integer DEFAULT 1, offsets integer DEFAULT 0, search text DEFAULT ''::text, sortcolumn text DEFAULT 'name'::text, sortorder text DEFAULT 'asc'::text) RETURNS TABLE(name text, id uuid, updated_at timestamp with time zone, created_at timestamp with time zone, last_accessed_at timestamp with time zone, metadata jsonb)
    LANGUAGE plpgsql STABLE
    AS $_$
declare
    v_order_by text;
    v_sort_order text;
begin
    case
        when sortcolumn = 'name' then
            v_order_by = 'name';
        when sortcolumn = 'updated_at' then
            v_order_by = 'updated_at';
        when sortcolumn = 'created_at' then
            v_order_by = 'created_at';
        when sortcolumn = 'last_accessed_at' then
            v_order_by = 'last_accessed_at';
        else
            v_order_by = 'name';
        end case;

    case
        when sortorder = 'asc' then
            v_sort_order = 'asc';
        when sortorder = 'desc' then
            v_sort_order = 'desc';
        else
            v_sort_order = 'asc';
        end case;

    v_order_by = v_order_by || ' ' || v_sort_order;

    return query execute
        'with folders as (
           select (string_to_array(name, ''/''))[level] as name
           from storage.prefixes
             where lower(prefixes.name) like lower($2 || $3) || ''%''
               and bucket_id = $4
               and level = $1
           order by name ' || v_sort_order || '
     )
     (select name,
            null as id,
            null as updated_at,
            null as created_at,
            null as last_accessed_at,
            null as metadata from folders)
     union all
     (select path_tokens[level] as "name",
            id,
            updated_at,
            created_at,
            last_accessed_at,
            metadata
     from storage.objects
     where lower(objects.name) like lower($2 || $3) || ''%''
       and bucket_id = $4
       and level = $1
     order by ' || v_order_by || ')
     limit $5
     offset $6' using levels, prefix, search, bucketname, limits, offsets;
end;
$_$;


--
-- Name: search_v2(text, text, integer, integer, text, text, text, text); Type: FUNCTION; Schema: storage; Owner: -
--

CREATE FUNCTION storage.search_v2(prefix text, bucket_name text, limits integer DEFAULT 100, levels integer DEFAULT 1, start_after text DEFAULT ''::text, sort_order text DEFAULT 'asc'::text, sort_column text DEFAULT 'name'::text, sort_column_after text DEFAULT ''::text) RETURNS TABLE(key text, name text, id uuid, updated_at timestamp with time zone, created_at timestamp with time zone, last_accessed_at timestamp with time zone, metadata jsonb)
    LANGUAGE plpgsql STABLE
    AS $_$
DECLARE
    sort_col text;
    sort_ord text;
    cursor_op text;
    cursor_expr text;
    sort_expr text;
BEGIN
    -- Validate sort_order
    sort_ord := lower(sort_order);
    IF sort_ord NOT IN ('asc', 'desc') THEN
        sort_ord := 'asc';
    END IF;

    -- Determine cursor comparison operator
    IF sort_ord = 'asc' THEN
        cursor_op := '>';
    ELSE
        cursor_op := '<';
    END IF;
    
    sort_col := lower(sort_column);
    -- Validate sort column  
    IF sort_col IN ('updated_at', 'created_at') THEN
        cursor_expr := format(
            '($5 = '''' OR ROW(date_trunc(''milliseconds'', %I), name COLLATE "C") %s ROW(COALESCE(NULLIF($6, '''')::timestamptz, ''epoch''::timestamptz), $5))',
            sort_col, cursor_op
        );
        sort_expr := format(
            'COALESCE(date_trunc(''milliseconds'', %I), ''epoch''::timestamptz) %s, name COLLATE "C" %s',
            sort_col, sort_ord, sort_ord
        );
    ELSE
        cursor_expr := format('($5 = '''' OR name COLLATE "C" %s $5)', cursor_op);
        sort_expr := format('name COLLATE "C" %s', sort_ord);
    END IF;

    RETURN QUERY EXECUTE format(
        $sql$
        SELECT * FROM (
            (
                SELECT
                    split_part(name, '/', $4) AS key,
                    name,
                    NULL::uuid AS id,
                    updated_at,
                    created_at,
                    NULL::timestamptz AS last_accessed_at,
                    NULL::jsonb AS metadata
                FROM storage.prefixes
                WHERE name COLLATE "C" LIKE $1 || '%%'
                    AND bucket_id = $2
                    AND level = $4
                    AND %s
                ORDER BY %s
                LIMIT $3
            )
            UNION ALL
            (
                SELECT
                    split_part(name, '/', $4) AS key,
                    name,
                    id,
                    updated_at,
                    created_at,
                    last_accessed_at,
                    metadata
                FROM storage.objects
                WHERE name COLLATE "C" LIKE $1 || '%%'
                    AND bucket_id = $2
                    AND level = $4
                    AND %s
                ORDER BY %s
                LIMIT $3
            )
        ) obj
        ORDER BY %s
        LIMIT $3
        $sql$,
        cursor_expr,    -- prefixes WHERE
        sort_expr,      -- prefixes ORDER BY
        cursor_expr,    -- objects WHERE
        sort_expr,      -- objects ORDER BY
        sort_expr       -- final ORDER BY
    )
    USING prefix, bucket_name, limits, levels, start_after, sort_column_after;
END;
$_$;


--
-- Name: update_updated_at_column(); Type: FUNCTION; Schema: storage; Owner: -
--

CREATE FUNCTION storage.update_updated_at_column() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
BEGIN
    NEW.updated_at = now();
    RETURN NEW; 
END;
$$;


--
-- Name: http_request(); Type: FUNCTION; Schema: supabase_functions; Owner: -
--

CREATE FUNCTION supabase_functions.http_request() RETURNS trigger
    LANGUAGE plpgsql SECURITY DEFINER
    SET search_path TO 'supabase_functions'
    AS $$
  DECLARE
    request_id bigint;
    payload jsonb;
    url text := TG_ARGV[0]::text;
    method text := TG_ARGV[1]::text;
    headers jsonb DEFAULT '{}'::jsonb;
    params jsonb DEFAULT '{}'::jsonb;
    timeout_ms integer DEFAULT 1000;
  BEGIN
    IF url IS NULL OR url = 'null' THEN
      RAISE EXCEPTION 'url argument is missing';
    END IF;

    IF method IS NULL OR method = 'null' THEN
      RAISE EXCEPTION 'method argument is missing';
    END IF;

    IF TG_ARGV[2] IS NULL OR TG_ARGV[2] = 'null' THEN
      headers = '{"Content-Type": "application/json"}'::jsonb;
    ELSE
      headers = TG_ARGV[2]::jsonb;
    END IF;

    IF TG_ARGV[3] IS NULL OR TG_ARGV[3] = 'null' THEN
      params = '{}'::jsonb;
    ELSE
      params = TG_ARGV[3]::jsonb;
    END IF;

    IF TG_ARGV[4] IS NULL OR TG_ARGV[4] = 'null' THEN
      timeout_ms = 1000;
    ELSE
      timeout_ms = TG_ARGV[4]::integer;
    END IF;

    CASE
      WHEN method = 'GET' THEN
        SELECT http_get INTO request_id FROM net.http_get(
          url,
          params,
          headers,
          timeout_ms
        );
      WHEN method = 'POST' THEN
        payload = jsonb_build_object(
          'old_record', OLD,
          'record', NEW,
          'type', TG_OP,
          'table', TG_TABLE_NAME,
          'schema', TG_TABLE_SCHEMA
        );

        SELECT http_post INTO request_id FROM net.http_post(
          url,
          payload,
          params,
          headers,
          timeout_ms
        );
      ELSE
        RAISE EXCEPTION 'method argument % is invalid', method;
    END CASE;

    INSERT INTO supabase_functions.hooks
      (hook_table_id, hook_name, request_id)
    VALUES
      (TG_RELID, TG_NAME, request_id);

    RETURN NEW;
  END
$$;


SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- Name: extensions; Type: TABLE; Schema: _realtime; Owner: -
--

CREATE TABLE _realtime.extensions (
    id uuid NOT NULL,
    type text,
    settings jsonb,
    tenant_external_id text,
    inserted_at timestamp(0) without time zone NOT NULL,
    updated_at timestamp(0) without time zone NOT NULL
);


--
-- Name: schema_migrations; Type: TABLE; Schema: _realtime; Owner: -
--

CREATE TABLE _realtime.schema_migrations (
    version bigint NOT NULL,
    inserted_at timestamp(0) without time zone
);


--
-- Name: tenants; Type: TABLE; Schema: _realtime; Owner: -
--

CREATE TABLE _realtime.tenants (
    id uuid NOT NULL,
    name text,
    external_id text,
    jwt_secret text,
    max_concurrent_users integer DEFAULT 200 NOT NULL,
    inserted_at timestamp(0) without time zone NOT NULL,
    updated_at timestamp(0) without time zone NOT NULL,
    max_events_per_second integer DEFAULT 100 NOT NULL,
    postgres_cdc_default text DEFAULT 'postgres_cdc_rls'::text,
    max_bytes_per_second integer DEFAULT 100000 NOT NULL,
    max_channels_per_client integer DEFAULT 100 NOT NULL,
    max_joins_per_second integer DEFAULT 500 NOT NULL,
    suspend boolean DEFAULT false,
    jwt_jwks jsonb,
    notify_private_alpha boolean DEFAULT false,
    private_only boolean DEFAULT false NOT NULL,
    migrations_ran integer DEFAULT 0,
    broadcast_adapter character varying(255) DEFAULT 'gen_rpc'::character varying,
    max_presence_events_per_second integer DEFAULT 1000,
    max_payload_size_in_kb integer DEFAULT 3000
);


--
-- Name: audit_log_entries; Type: TABLE; Schema: auth; Owner: -
--

CREATE TABLE auth.audit_log_entries (
    instance_id uuid,
    id uuid NOT NULL,
    payload json,
    created_at timestamp with time zone,
    ip_address character varying(64) DEFAULT ''::character varying NOT NULL
);


--
-- Name: TABLE audit_log_entries; Type: COMMENT; Schema: auth; Owner: -
--

COMMENT ON TABLE auth.audit_log_entries IS 'Auth: Audit trail for user actions.';


--
-- Name: flow_state; Type: TABLE; Schema: auth; Owner: -
--

CREATE TABLE auth.flow_state (
    id uuid NOT NULL,
    user_id uuid,
    auth_code text NOT NULL,
    code_challenge_method auth.code_challenge_method NOT NULL,
    code_challenge text NOT NULL,
    provider_type text NOT NULL,
    provider_access_token text,
    provider_refresh_token text,
    created_at timestamp with time zone,
    updated_at timestamp with time zone,
    authentication_method text NOT NULL,
    auth_code_issued_at timestamp with time zone
);


--
-- Name: TABLE flow_state; Type: COMMENT; Schema: auth; Owner: -
--

COMMENT ON TABLE auth.flow_state IS 'stores metadata for pkce logins';


--
-- Name: identities; Type: TABLE; Schema: auth; Owner: -
--

CREATE TABLE auth.identities (
    provider_id text NOT NULL,
    user_id uuid NOT NULL,
    identity_data jsonb NOT NULL,
    provider text NOT NULL,
    last_sign_in_at timestamp with time zone,
    created_at timestamp with time zone,
    updated_at timestamp with time zone,
    email text GENERATED ALWAYS AS (lower((identity_data ->> 'email'::text))) STORED,
    id uuid DEFAULT gen_random_uuid() NOT NULL
);


--
-- Name: TABLE identities; Type: COMMENT; Schema: auth; Owner: -
--

COMMENT ON TABLE auth.identities IS 'Auth: Stores identities associated to a user.';


--
-- Name: COLUMN identities.email; Type: COMMENT; Schema: auth; Owner: -
--

COMMENT ON COLUMN auth.identities.email IS 'Auth: Email is a generated column that references the optional email property in the identity_data';


--
-- Name: instances; Type: TABLE; Schema: auth; Owner: -
--

CREATE TABLE auth.instances (
    id uuid NOT NULL,
    uuid uuid,
    raw_base_config text,
    created_at timestamp with time zone,
    updated_at timestamp with time zone
);


--
-- Name: TABLE instances; Type: COMMENT; Schema: auth; Owner: -
--

COMMENT ON TABLE auth.instances IS 'Auth: Manages users across multiple sites.';


--
-- Name: mfa_amr_claims; Type: TABLE; Schema: auth; Owner: -
--

CREATE TABLE auth.mfa_amr_claims (
    session_id uuid NOT NULL,
    created_at timestamp with time zone NOT NULL,
    updated_at timestamp with time zone NOT NULL,
    authentication_method text NOT NULL,
    id uuid NOT NULL
);


--
-- Name: TABLE mfa_amr_claims; Type: COMMENT; Schema: auth; Owner: -
--

COMMENT ON TABLE auth.mfa_amr_claims IS 'auth: stores authenticator method reference claims for multi factor authentication';


--
-- Name: mfa_challenges; Type: TABLE; Schema: auth; Owner: -
--

CREATE TABLE auth.mfa_challenges (
    id uuid NOT NULL,
    factor_id uuid NOT NULL,
    created_at timestamp with time zone NOT NULL,
    verified_at timestamp with time zone,
    ip_address inet NOT NULL,
    otp_code text,
    web_authn_session_data jsonb
);


--
-- Name: TABLE mfa_challenges; Type: COMMENT; Schema: auth; Owner: -
--

COMMENT ON TABLE auth.mfa_challenges IS 'auth: stores metadata about challenge requests made';


--
-- Name: mfa_factors; Type: TABLE; Schema: auth; Owner: -
--

CREATE TABLE auth.mfa_factors (
    id uuid NOT NULL,
    user_id uuid NOT NULL,
    friendly_name text,
    factor_type auth.factor_type NOT NULL,
    status auth.factor_status NOT NULL,
    created_at timestamp with time zone NOT NULL,
    updated_at timestamp with time zone NOT NULL,
    secret text,
    phone text,
    last_challenged_at timestamp with time zone,
    web_authn_credential jsonb,
    web_authn_aaguid uuid,
    last_webauthn_challenge_data jsonb
);


--
-- Name: TABLE mfa_factors; Type: COMMENT; Schema: auth; Owner: -
--

COMMENT ON TABLE auth.mfa_factors IS 'auth: stores metadata about factors';


--
-- Name: COLUMN mfa_factors.last_webauthn_challenge_data; Type: COMMENT; Schema: auth; Owner: -
--

COMMENT ON COLUMN auth.mfa_factors.last_webauthn_challenge_data IS 'Stores the latest WebAuthn challenge data including attestation/assertion for customer verification';


--
-- Name: oauth_authorizations; Type: TABLE; Schema: auth; Owner: -
--

CREATE TABLE auth.oauth_authorizations (
    id uuid NOT NULL,
    authorization_id text NOT NULL,
    client_id uuid NOT NULL,
    user_id uuid,
    redirect_uri text NOT NULL,
    scope text NOT NULL,
    state text,
    resource text,
    code_challenge text,
    code_challenge_method auth.code_challenge_method,
    response_type auth.oauth_response_type DEFAULT 'code'::auth.oauth_response_type NOT NULL,
    status auth.oauth_authorization_status DEFAULT 'pending'::auth.oauth_authorization_status NOT NULL,
    authorization_code text,
    created_at timestamp with time zone DEFAULT now() NOT NULL,
    expires_at timestamp with time zone DEFAULT (now() + '00:03:00'::interval) NOT NULL,
    approved_at timestamp with time zone,
    CONSTRAINT oauth_authorizations_authorization_code_length CHECK ((char_length(authorization_code) <= 255)),
    CONSTRAINT oauth_authorizations_code_challenge_length CHECK ((char_length(code_challenge) <= 128)),
    CONSTRAINT oauth_authorizations_expires_at_future CHECK ((expires_at > created_at)),
    CONSTRAINT oauth_authorizations_redirect_uri_length CHECK ((char_length(redirect_uri) <= 2048)),
    CONSTRAINT oauth_authorizations_resource_length CHECK ((char_length(resource) <= 2048)),
    CONSTRAINT oauth_authorizations_scope_length CHECK ((char_length(scope) <= 4096)),
    CONSTRAINT oauth_authorizations_state_length CHECK ((char_length(state) <= 4096))
);


--
-- Name: oauth_clients; Type: TABLE; Schema: auth; Owner: -
--

CREATE TABLE auth.oauth_clients (
    id uuid NOT NULL,
    client_secret_hash text,
    registration_type auth.oauth_registration_type NOT NULL,
    redirect_uris text NOT NULL,
    grant_types text NOT NULL,
    client_name text,
    client_uri text,
    logo_uri text,
    created_at timestamp with time zone DEFAULT now() NOT NULL,
    updated_at timestamp with time zone DEFAULT now() NOT NULL,
    deleted_at timestamp with time zone,
    client_type auth.oauth_client_type DEFAULT 'confidential'::auth.oauth_client_type NOT NULL,
    CONSTRAINT oauth_clients_client_name_length CHECK ((char_length(client_name) <= 1024)),
    CONSTRAINT oauth_clients_client_uri_length CHECK ((char_length(client_uri) <= 2048)),
    CONSTRAINT oauth_clients_logo_uri_length CHECK ((char_length(logo_uri) <= 2048))
);


--
-- Name: oauth_consents; Type: TABLE; Schema: auth; Owner: -
--

CREATE TABLE auth.oauth_consents (
    id uuid NOT NULL,
    user_id uuid NOT NULL,
    client_id uuid NOT NULL,
    scopes text NOT NULL,
    granted_at timestamp with time zone DEFAULT now() NOT NULL,
    revoked_at timestamp with time zone,
    CONSTRAINT oauth_consents_revoked_after_granted CHECK (((revoked_at IS NULL) OR (revoked_at >= granted_at))),
    CONSTRAINT oauth_consents_scopes_length CHECK ((char_length(scopes) <= 2048)),
    CONSTRAINT oauth_consents_scopes_not_empty CHECK ((char_length(TRIM(BOTH FROM scopes)) > 0))
);


--
-- Name: one_time_tokens; Type: TABLE; Schema: auth; Owner: -
--

CREATE TABLE auth.one_time_tokens (
    id uuid NOT NULL,
    user_id uuid NOT NULL,
    token_type auth.one_time_token_type NOT NULL,
    token_hash text NOT NULL,
    relates_to text NOT NULL,
    created_at timestamp without time zone DEFAULT now() NOT NULL,
    updated_at timestamp without time zone DEFAULT now() NOT NULL,
    CONSTRAINT one_time_tokens_token_hash_check CHECK ((char_length(token_hash) > 0))
);


--
-- Name: refresh_tokens; Type: TABLE; Schema: auth; Owner: -
--

CREATE TABLE auth.refresh_tokens (
    instance_id uuid,
    id bigint NOT NULL,
    token character varying(255),
    user_id character varying(255),
    revoked boolean,
    created_at timestamp with time zone,
    updated_at timestamp with time zone,
    parent character varying(255),
    session_id uuid
);


--
-- Name: TABLE refresh_tokens; Type: COMMENT; Schema: auth; Owner: -
--

COMMENT ON TABLE auth.refresh_tokens IS 'Auth: Store of tokens used to refresh JWT tokens once they expire.';


--
-- Name: refresh_tokens_id_seq; Type: SEQUENCE; Schema: auth; Owner: -
--

CREATE SEQUENCE auth.refresh_tokens_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: refresh_tokens_id_seq; Type: SEQUENCE OWNED BY; Schema: auth; Owner: -
--

ALTER SEQUENCE auth.refresh_tokens_id_seq OWNED BY auth.refresh_tokens.id;


--
-- Name: saml_providers; Type: TABLE; Schema: auth; Owner: -
--

CREATE TABLE auth.saml_providers (
    id uuid NOT NULL,
    sso_provider_id uuid NOT NULL,
    entity_id text NOT NULL,
    metadata_xml text NOT NULL,
    metadata_url text,
    attribute_mapping jsonb,
    created_at timestamp with time zone,
    updated_at timestamp with time zone,
    name_id_format text,
    CONSTRAINT "entity_id not empty" CHECK ((char_length(entity_id) > 0)),
    CONSTRAINT "metadata_url not empty" CHECK (((metadata_url = NULL::text) OR (char_length(metadata_url) > 0))),
    CONSTRAINT "metadata_xml not empty" CHECK ((char_length(metadata_xml) > 0))
);


--
-- Name: TABLE saml_providers; Type: COMMENT; Schema: auth; Owner: -
--

COMMENT ON TABLE auth.saml_providers IS 'Auth: Manages SAML Identity Provider connections.';


--
-- Name: saml_relay_states; Type: TABLE; Schema: auth; Owner: -
--

CREATE TABLE auth.saml_relay_states (
    id uuid NOT NULL,
    sso_provider_id uuid NOT NULL,
    request_id text NOT NULL,
    for_email text,
    redirect_to text,
    created_at timestamp with time zone,
    updated_at timestamp with time zone,
    flow_state_id uuid,
    CONSTRAINT "request_id not empty" CHECK ((char_length(request_id) > 0))
);


--
-- Name: TABLE saml_relay_states; Type: COMMENT; Schema: auth; Owner: -
--

COMMENT ON TABLE auth.saml_relay_states IS 'Auth: Contains SAML Relay State information for each Service Provider initiated login.';


--
-- Name: schema_migrations; Type: TABLE; Schema: auth; Owner: -
--

CREATE TABLE auth.schema_migrations (
    version character varying(255) NOT NULL
);


--
-- Name: TABLE schema_migrations; Type: COMMENT; Schema: auth; Owner: -
--

COMMENT ON TABLE auth.schema_migrations IS 'Auth: Manages updates to the auth system.';


--
-- Name: sessions; Type: TABLE; Schema: auth; Owner: -
--

CREATE TABLE auth.sessions (
    id uuid NOT NULL,
    user_id uuid NOT NULL,
    created_at timestamp with time zone,
    updated_at timestamp with time zone,
    factor_id uuid,
    aal auth.aal_level,
    not_after timestamp with time zone,
    refreshed_at timestamp without time zone,
    user_agent text,
    ip inet,
    tag text,
    oauth_client_id uuid,
    refresh_token_hmac_key text,
    refresh_token_counter bigint
);


--
-- Name: TABLE sessions; Type: COMMENT; Schema: auth; Owner: -
--

COMMENT ON TABLE auth.sessions IS 'Auth: Stores session data associated to a user.';


--
-- Name: COLUMN sessions.not_after; Type: COMMENT; Schema: auth; Owner: -
--

COMMENT ON COLUMN auth.sessions.not_after IS 'Auth: Not after is a nullable column that contains a timestamp after which the session should be regarded as expired.';


--
-- Name: COLUMN sessions.refresh_token_hmac_key; Type: COMMENT; Schema: auth; Owner: -
--

COMMENT ON COLUMN auth.sessions.refresh_token_hmac_key IS 'Holds a HMAC-SHA256 key used to sign refresh tokens for this session.';


--
-- Name: COLUMN sessions.refresh_token_counter; Type: COMMENT; Schema: auth; Owner: -
--

COMMENT ON COLUMN auth.sessions.refresh_token_counter IS 'Holds the ID (counter) of the last issued refresh token.';


--
-- Name: sso_domains; Type: TABLE; Schema: auth; Owner: -
--

CREATE TABLE auth.sso_domains (
    id uuid NOT NULL,
    sso_provider_id uuid NOT NULL,
    domain text NOT NULL,
    created_at timestamp with time zone,
    updated_at timestamp with time zone,
    CONSTRAINT "domain not empty" CHECK ((char_length(domain) > 0))
);


--
-- Name: TABLE sso_domains; Type: COMMENT; Schema: auth; Owner: -
--

COMMENT ON TABLE auth.sso_domains IS 'Auth: Manages SSO email address domain mapping to an SSO Identity Provider.';


--
-- Name: sso_providers; Type: TABLE; Schema: auth; Owner: -
--

CREATE TABLE auth.sso_providers (
    id uuid NOT NULL,
    resource_id text,
    created_at timestamp with time zone,
    updated_at timestamp with time zone,
    disabled boolean,
    CONSTRAINT "resource_id not empty" CHECK (((resource_id = NULL::text) OR (char_length(resource_id) > 0)))
);


--
-- Name: TABLE sso_providers; Type: COMMENT; Schema: auth; Owner: -
--

COMMENT ON TABLE auth.sso_providers IS 'Auth: Manages SSO identity provider information; see saml_providers for SAML.';


--
-- Name: COLUMN sso_providers.resource_id; Type: COMMENT; Schema: auth; Owner: -
--

COMMENT ON COLUMN auth.sso_providers.resource_id IS 'Auth: Uniquely identifies a SSO provider according to a user-chosen resource ID (case insensitive), useful in infrastructure as code.';


--
-- Name: users; Type: TABLE; Schema: auth; Owner: -
--

CREATE TABLE auth.users (
    instance_id uuid,
    id uuid NOT NULL,
    aud character varying(255),
    role character varying(255),
    email character varying(255),
    encrypted_password character varying(255),
    email_confirmed_at timestamp with time zone,
    invited_at timestamp with time zone,
    confirmation_token character varying(255),
    confirmation_sent_at timestamp with time zone,
    recovery_token character varying(255),
    recovery_sent_at timestamp with time zone,
    email_change_token_new character varying(255),
    email_change character varying(255),
    email_change_sent_at timestamp with time zone,
    last_sign_in_at timestamp with time zone,
    raw_app_meta_data jsonb,
    raw_user_meta_data jsonb,
    is_super_admin boolean,
    created_at timestamp with time zone,
    updated_at timestamp with time zone,
    phone text DEFAULT NULL::character varying,
    phone_confirmed_at timestamp with time zone,
    phone_change text DEFAULT ''::character varying,
    phone_change_token character varying(255) DEFAULT ''::character varying,
    phone_change_sent_at timestamp with time zone,
    confirmed_at timestamp with time zone GENERATED ALWAYS AS (LEAST(email_confirmed_at, phone_confirmed_at)) STORED,
    email_change_token_current character varying(255) DEFAULT ''::character varying,
    email_change_confirm_status smallint DEFAULT 0,
    banned_until timestamp with time zone,
    reauthentication_token character varying(255) DEFAULT ''::character varying,
    reauthentication_sent_at timestamp with time zone,
    is_sso_user boolean DEFAULT false NOT NULL,
    deleted_at timestamp with time zone,
    is_anonymous boolean DEFAULT false NOT NULL,
    CONSTRAINT users_email_change_confirm_status_check CHECK (((email_change_confirm_status >= 0) AND (email_change_confirm_status <= 2)))
);


--
-- Name: TABLE users; Type: COMMENT; Schema: auth; Owner: -
--

COMMENT ON TABLE auth.users IS 'Auth: Stores user login data within a secure schema.';


--
-- Name: COLUMN users.is_sso_user; Type: COMMENT; Schema: auth; Owner: -
--

COMMENT ON COLUMN auth.users.is_sso_user IS 'Auth: Set this column to true when the account comes from SSO. These accounts can have duplicate emails.';


--
-- Name: coze_workflows; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.coze_workflows (
    id bigint NOT NULL,
    workflow_id text NOT NULL,
    name text NOT NULL,
    description text,
    created_at timestamp with time zone DEFAULT now(),
    api_key text,
    researcher_ids uuid[] DEFAULT '{}'::uuid[],
    owner_id uuid,
    type text DEFAULT 'workflow'::text,
    ep_url text
);

GRANT SELECT, INSERT, UPDATE, DELETE ON TABLE public.coze_workflows TO authenticated;
GRANT ALL ON TABLE public.coze_workflows TO service_role;


--
-- Name: TABLE coze_workflows; Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON TABLE public.coze_workflows IS 'Stores Coze workflow configurations.';


--
-- Name: COLUMN coze_workflows.workflow_id; Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON COLUMN public.coze_workflows.workflow_id IS 'The unique identifier for the Coze workflow.';


--
-- Name: COLUMN coze_workflows.name; Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON COLUMN public.coze_workflows.name IS 'A user-friendly name for the workflow.';


--
-- Name: COLUMN coze_workflows.researcher_ids; Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON COLUMN public.coze_workflows.researcher_ids IS 'List of researcher IDs who have access to manage this workflow.';


--
-- Name: COLUMN coze_workflows.type; Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON COLUMN public.coze_workflows.type IS 'The type of Coze resource: workflow, bot, or other types';


--
-- Name: coze_workflows_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

ALTER TABLE public.coze_workflows ALTER COLUMN id ADD GENERATED BY DEFAULT AS IDENTITY (
    SEQUENCE NAME public.coze_workflows_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- Name: experiment_sessions; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.experiment_sessions (
    session_id bigint NOT NULL,
    experiment_id bigint NOT NULL,
    participant_id uuid NOT NULL,
    status text DEFAULT 'not_started'::text NOT NULL,
    current_node_id text,
    created_at timestamp with time zone DEFAULT now(),
    updated_at timestamp with time zone DEFAULT now()
);

GRANT SELECT, INSERT, UPDATE, DELETE ON TABLE public.experiment_sessions TO authenticated;
GRANT ALL ON TABLE public.experiment_sessions TO service_role;


--
-- Name: TABLE experiment_sessions; Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON TABLE public.experiment_sessions IS 'Tracks a participant''s session and progress in an experiment.';


--
-- Name: COLUMN experiment_sessions.status; Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON COLUMN public.experiment_sessions.status IS 'The current status of the participant''s session.';


--
-- Name: COLUMN experiment_sessions.current_node_id; Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON COLUMN public.experiment_sessions.current_node_id IS 'The ID of the current task node in the workflow.';


--
-- Name: experiment_sessions_session_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

ALTER TABLE public.experiment_sessions ALTER COLUMN session_id ADD GENERATED BY DEFAULT AS IDENTITY (
    SEQUENCE NAME public.experiment_sessions_session_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- Name: experiments; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.experiments (
    experiment_id integer NOT NULL,
    title text,
    workflow_json jsonb,
    researcher_id uuid,
    evaluation_config jsonb DEFAULT '{"dimensions": [], "overallFeedback": {"prompt": "", "enabled": false}}'::jsonb
);

GRANT SELECT, INSERT, UPDATE, DELETE ON TABLE public.experiments TO authenticated;
GRANT ALL ON TABLE public.experiments TO service_role;


--
-- Name: COLUMN experiments.evaluation_config; Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON COLUMN public.experiments.evaluation_config IS 'Stores evaluation rubric details and automated assessment settings for an experiment.';


--
-- Name: experiments_experiment_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.experiments_experiment_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: experiments_experiment_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.experiments_experiment_id_seq OWNED BY public.experiments.experiment_id;


--
-- Name: profiles; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.profiles (
    id uuid NOT NULL,
    email text,
    role text,
    full_name text,
    encrypted_dek text,
    dek_salt text,
    dek_iv text,
    server_encrypted_dek text
);

GRANT SELECT, INSERT, UPDATE, DELETE ON TABLE public.profiles TO authenticated;
GRANT SELECT ON TABLE public.profiles TO anon;
GRANT ALL ON TABLE public.profiles TO service_role;


--
-- Name: session_evaluations; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.session_evaluations (
    evaluation_id bigint NOT NULL,
    experiment_id bigint NOT NULL,
    session_id bigint NOT NULL,
    evaluator_id uuid,
    scores jsonb NOT NULL,
    overall_feedback text,
    created_at timestamp with time zone DEFAULT now(),
    updated_at timestamp with time zone DEFAULT now(),
    task_scores jsonb DEFAULT '[]'::jsonb
);

GRANT SELECT, INSERT, UPDATE, DELETE ON TABLE public.session_evaluations TO authenticated;
GRANT ALL ON TABLE public.session_evaluations TO service_role;


--
-- Name: TABLE session_evaluations; Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON TABLE public.session_evaluations IS 'Stores rubric-based scores for each participant session.';


--
-- Name: COLUMN session_evaluations.scores; Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON COLUMN public.session_evaluations.scores IS 'Array of dimension scores and metadata for the evaluation.';


--
-- Name: COLUMN session_evaluations.task_scores; Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON COLUMN public.session_evaluations.task_scores IS 'Per-step evaluation entries for a session.';


--
-- Name: session_evaluations_evaluation_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

ALTER TABLE public.session_evaluations ALTER COLUMN evaluation_id ADD GENERATED BY DEFAULT AS IDENTITY (
    SEQUENCE NAME public.session_evaluations_evaluation_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- Name: task_results; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.task_results (
    result_id bigint NOT NULL,
    session_id bigint NOT NULL,
    node_id text NOT NULL,
    output_data jsonb,
    created_at timestamp with time zone DEFAULT now(),
    input_data jsonb
);

GRANT SELECT, INSERT, UPDATE, DELETE ON TABLE public.task_results TO authenticated;
GRANT ALL ON TABLE public.task_results TO service_role;


--
-- Name: TABLE task_results; Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON TABLE public.task_results IS 'Stores the output data for each completed task in a session.';


--
-- Name: COLUMN task_results.output_data; Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON COLUMN public.task_results.output_data IS 'The data produced by the participant or agent for a specific task.';


--
-- Name: COLUMN task_results.input_data; Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON COLUMN public.task_results.input_data IS 'The inputs (context or previous outputs) the participant/agent saw before responding.';


--
-- Name: task_results_result_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

ALTER TABLE public.task_results ALTER COLUMN result_id ADD GENERATED BY DEFAULT AS IDENTITY (
    SEQUENCE NAME public.task_results_result_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- Name: messages; Type: TABLE; Schema: realtime; Owner: -
--

CREATE TABLE realtime.messages (
    topic text NOT NULL,
    extension text NOT NULL,
    payload jsonb,
    event text,
    private boolean DEFAULT false,
    updated_at timestamp without time zone DEFAULT now() NOT NULL,
    inserted_at timestamp without time zone DEFAULT now() NOT NULL,
    id uuid DEFAULT gen_random_uuid() NOT NULL
)
PARTITION BY RANGE (inserted_at);


--
-- Name: messages_2025_11_29; Type: TABLE; Schema: realtime; Owner: -
--

CREATE TABLE realtime.messages_2025_11_29 (
    topic text NOT NULL,
    extension text NOT NULL,
    payload jsonb,
    event text,
    private boolean DEFAULT false,
    updated_at timestamp without time zone DEFAULT now() NOT NULL,
    inserted_at timestamp without time zone DEFAULT now() NOT NULL,
    id uuid DEFAULT gen_random_uuid() NOT NULL
);


--
-- Name: messages_2025_12_01; Type: TABLE; Schema: realtime; Owner: -
--

CREATE TABLE realtime.messages_2025_12_01 (
    topic text NOT NULL,
    extension text NOT NULL,
    payload jsonb,
    event text,
    private boolean DEFAULT false,
    updated_at timestamp without time zone DEFAULT now() NOT NULL,
    inserted_at timestamp without time zone DEFAULT now() NOT NULL,
    id uuid DEFAULT gen_random_uuid() NOT NULL
);


--
-- Name: messages_2025_12_02; Type: TABLE; Schema: realtime; Owner: -
--

CREATE TABLE realtime.messages_2025_12_02 (
    topic text NOT NULL,
    extension text NOT NULL,
    payload jsonb,
    event text,
    private boolean DEFAULT false,
    updated_at timestamp without time zone DEFAULT now() NOT NULL,
    inserted_at timestamp without time zone DEFAULT now() NOT NULL,
    id uuid DEFAULT gen_random_uuid() NOT NULL
);


--
-- Name: messages_2025_12_03; Type: TABLE; Schema: realtime; Owner: -
--

CREATE TABLE realtime.messages_2025_12_03 (
    topic text NOT NULL,
    extension text NOT NULL,
    payload jsonb,
    event text,
    private boolean DEFAULT false,
    updated_at timestamp without time zone DEFAULT now() NOT NULL,
    inserted_at timestamp without time zone DEFAULT now() NOT NULL,
    id uuid DEFAULT gen_random_uuid() NOT NULL
);


--
-- Name: messages_2025_12_04; Type: TABLE; Schema: realtime; Owner: -
--

CREATE TABLE realtime.messages_2025_12_04 (
    topic text NOT NULL,
    extension text NOT NULL,
    payload jsonb,
    event text,
    private boolean DEFAULT false,
    updated_at timestamp without time zone DEFAULT now() NOT NULL,
    inserted_at timestamp without time zone DEFAULT now() NOT NULL,
    id uuid DEFAULT gen_random_uuid() NOT NULL
);


--
-- Name: messages_2025_12_05; Type: TABLE; Schema: realtime; Owner: -
--

CREATE TABLE realtime.messages_2025_12_05 (
    topic text NOT NULL,
    extension text NOT NULL,
    payload jsonb,
    event text,
    private boolean DEFAULT false,
    updated_at timestamp without time zone DEFAULT now() NOT NULL,
    inserted_at timestamp without time zone DEFAULT now() NOT NULL,
    id uuid DEFAULT gen_random_uuid() NOT NULL
);


--
-- Name: schema_migrations; Type: TABLE; Schema: realtime; Owner: -
--

CREATE TABLE realtime.schema_migrations (
    version bigint NOT NULL,
    inserted_at timestamp(0) without time zone
);


--
-- Name: subscription; Type: TABLE; Schema: realtime; Owner: -
--

CREATE TABLE realtime.subscription (
    id bigint NOT NULL,
    subscription_id uuid NOT NULL,
    entity regclass NOT NULL,
    filters realtime.user_defined_filter[] DEFAULT '{}'::realtime.user_defined_filter[] NOT NULL,
    claims jsonb NOT NULL,
    claims_role regrole GENERATED ALWAYS AS (realtime.to_regrole((claims ->> 'role'::text))) STORED NOT NULL,
    created_at timestamp without time zone DEFAULT timezone('utc'::text, now()) NOT NULL
);


--
-- Name: subscription_id_seq; Type: SEQUENCE; Schema: realtime; Owner: -
--

ALTER TABLE realtime.subscription ALTER COLUMN id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME realtime.subscription_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- Name: buckets; Type: TABLE; Schema: storage; Owner: -
--

CREATE TABLE storage.buckets (
    id text NOT NULL,
    name text NOT NULL,
    owner uuid,
    created_at timestamp with time zone DEFAULT now(),
    updated_at timestamp with time zone DEFAULT now(),
    public boolean DEFAULT false,
    avif_autodetection boolean DEFAULT false,
    file_size_limit bigint,
    allowed_mime_types text[],
    owner_id text,
    type storage.buckettype DEFAULT 'STANDARD'::storage.buckettype NOT NULL
);


--
-- Name: COLUMN buckets.owner; Type: COMMENT; Schema: storage; Owner: -
--

COMMENT ON COLUMN storage.buckets.owner IS 'Field is deprecated, use owner_id instead';


--
-- Name: buckets_analytics; Type: TABLE; Schema: storage; Owner: -
--

CREATE TABLE storage.buckets_analytics (
    name text NOT NULL,
    type storage.buckettype DEFAULT 'ANALYTICS'::storage.buckettype NOT NULL,
    format text DEFAULT 'ICEBERG'::text NOT NULL,
    created_at timestamp with time zone DEFAULT now() NOT NULL,
    updated_at timestamp with time zone DEFAULT now() NOT NULL,
    id uuid DEFAULT gen_random_uuid() NOT NULL,
    deleted_at timestamp with time zone
);


--
-- Name: buckets_vectors; Type: TABLE; Schema: storage; Owner: -
--

CREATE TABLE storage.buckets_vectors (
    id text NOT NULL,
    type storage.buckettype DEFAULT 'VECTOR'::storage.buckettype NOT NULL,
    created_at timestamp with time zone DEFAULT now() NOT NULL,
    updated_at timestamp with time zone DEFAULT now() NOT NULL
);


--
-- Name: iceberg_namespaces; Type: TABLE; Schema: storage; Owner: -
--

CREATE TABLE storage.iceberg_namespaces (
    id uuid DEFAULT gen_random_uuid() NOT NULL,
    bucket_name text NOT NULL,
    name text NOT NULL COLLATE pg_catalog."C",
    created_at timestamp with time zone DEFAULT now() NOT NULL,
    updated_at timestamp with time zone DEFAULT now() NOT NULL,
    metadata jsonb DEFAULT '{}'::jsonb NOT NULL,
    catalog_id uuid NOT NULL
);


--
-- Name: iceberg_tables; Type: TABLE; Schema: storage; Owner: -
--

CREATE TABLE storage.iceberg_tables (
    id uuid DEFAULT gen_random_uuid() NOT NULL,
    namespace_id uuid NOT NULL,
    bucket_name text NOT NULL,
    name text NOT NULL COLLATE pg_catalog."C",
    location text NOT NULL,
    created_at timestamp with time zone DEFAULT now() NOT NULL,
    updated_at timestamp with time zone DEFAULT now() NOT NULL,
    remote_table_id text,
    shard_key text,
    shard_id text,
    catalog_id uuid NOT NULL
);


--
-- Name: migrations; Type: TABLE; Schema: storage; Owner: -
--

CREATE TABLE storage.migrations (
    id integer NOT NULL,
    name character varying(100) NOT NULL,
    hash character varying(40) NOT NULL,
    executed_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP
);


--
-- Name: objects; Type: TABLE; Schema: storage; Owner: -
--

CREATE TABLE storage.objects (
    id uuid DEFAULT gen_random_uuid() NOT NULL,
    bucket_id text,
    name text,
    owner uuid,
    created_at timestamp with time zone DEFAULT now(),
    updated_at timestamp with time zone DEFAULT now(),
    last_accessed_at timestamp with time zone DEFAULT now(),
    metadata jsonb,
    path_tokens text[] GENERATED ALWAYS AS (string_to_array(name, '/'::text)) STORED,
    version text,
    owner_id text,
    user_metadata jsonb,
    level integer
);


--
-- Name: COLUMN objects.owner; Type: COMMENT; Schema: storage; Owner: -
--

COMMENT ON COLUMN storage.objects.owner IS 'Field is deprecated, use owner_id instead';


--
-- Name: prefixes; Type: TABLE; Schema: storage; Owner: -
--

CREATE TABLE storage.prefixes (
    bucket_id text NOT NULL,
    name text NOT NULL COLLATE pg_catalog."C",
    level integer GENERATED ALWAYS AS (storage.get_level(name)) STORED NOT NULL,
    created_at timestamp with time zone DEFAULT now(),
    updated_at timestamp with time zone DEFAULT now()
);


--
-- Name: s3_multipart_uploads; Type: TABLE; Schema: storage; Owner: -
--

CREATE TABLE storage.s3_multipart_uploads (
    id text NOT NULL,
    in_progress_size bigint DEFAULT 0 NOT NULL,
    upload_signature text NOT NULL,
    bucket_id text NOT NULL,
    key text NOT NULL COLLATE pg_catalog."C",
    version text NOT NULL,
    owner_id text,
    created_at timestamp with time zone DEFAULT now() NOT NULL,
    user_metadata jsonb
);


--
-- Name: s3_multipart_uploads_parts; Type: TABLE; Schema: storage; Owner: -
--

CREATE TABLE storage.s3_multipart_uploads_parts (
    id uuid DEFAULT gen_random_uuid() NOT NULL,
    upload_id text NOT NULL,
    size bigint DEFAULT 0 NOT NULL,
    part_number integer NOT NULL,
    bucket_id text NOT NULL,
    key text NOT NULL COLLATE pg_catalog."C",
    etag text NOT NULL,
    owner_id text,
    version text NOT NULL,
    created_at timestamp with time zone DEFAULT now() NOT NULL
);


--
-- Name: vector_indexes; Type: TABLE; Schema: storage; Owner: -
--

CREATE TABLE storage.vector_indexes (
    id text DEFAULT gen_random_uuid() NOT NULL,
    name text NOT NULL COLLATE pg_catalog."C",
    bucket_id text NOT NULL,
    data_type text NOT NULL,
    dimension integer NOT NULL,
    distance_metric text NOT NULL,
    metadata_configuration jsonb,
    created_at timestamp with time zone DEFAULT now() NOT NULL,
    updated_at timestamp with time zone DEFAULT now() NOT NULL
);


--
-- Name: hooks; Type: TABLE; Schema: supabase_functions; Owner: -
--

CREATE TABLE supabase_functions.hooks (
    id bigint NOT NULL,
    hook_table_id integer NOT NULL,
    hook_name text NOT NULL,
    created_at timestamp with time zone DEFAULT now() NOT NULL,
    request_id bigint
);


--
-- Name: TABLE hooks; Type: COMMENT; Schema: supabase_functions; Owner: -
--

COMMENT ON TABLE supabase_functions.hooks IS 'Supabase Functions Hooks: Audit trail for triggered hooks.';


--
-- Name: hooks_id_seq; Type: SEQUENCE; Schema: supabase_functions; Owner: -
--

CREATE SEQUENCE supabase_functions.hooks_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: hooks_id_seq; Type: SEQUENCE OWNED BY; Schema: supabase_functions; Owner: -
--

ALTER SEQUENCE supabase_functions.hooks_id_seq OWNED BY supabase_functions.hooks.id;


--
-- Name: migrations; Type: TABLE; Schema: supabase_functions; Owner: -
--

CREATE TABLE supabase_functions.migrations (
    version text NOT NULL,
    inserted_at timestamp with time zone DEFAULT now() NOT NULL
);


--
-- Name: messages_2025_11_29; Type: TABLE ATTACH; Schema: realtime; Owner: -
--

ALTER TABLE ONLY realtime.messages ATTACH PARTITION realtime.messages_2025_11_29 FOR VALUES FROM ('2025-11-29 00:00:00') TO ('2025-11-30 00:00:00');


--
-- Name: messages_2025_12_01; Type: TABLE ATTACH; Schema: realtime; Owner: -
--

ALTER TABLE ONLY realtime.messages ATTACH PARTITION realtime.messages_2025_12_01 FOR VALUES FROM ('2025-12-01 00:00:00') TO ('2025-12-02 00:00:00');


--
-- Name: messages_2025_12_02; Type: TABLE ATTACH; Schema: realtime; Owner: -
--

ALTER TABLE ONLY realtime.messages ATTACH PARTITION realtime.messages_2025_12_02 FOR VALUES FROM ('2025-12-02 00:00:00') TO ('2025-12-03 00:00:00');


--
-- Name: messages_2025_12_03; Type: TABLE ATTACH; Schema: realtime; Owner: -
--

ALTER TABLE ONLY realtime.messages ATTACH PARTITION realtime.messages_2025_12_03 FOR VALUES FROM ('2025-12-03 00:00:00') TO ('2025-12-04 00:00:00');


--
-- Name: messages_2025_12_04; Type: TABLE ATTACH; Schema: realtime; Owner: -
--

ALTER TABLE ONLY realtime.messages ATTACH PARTITION realtime.messages_2025_12_04 FOR VALUES FROM ('2025-12-04 00:00:00') TO ('2025-12-05 00:00:00');


--
-- Name: messages_2025_12_05; Type: TABLE ATTACH; Schema: realtime; Owner: -
--

ALTER TABLE ONLY realtime.messages ATTACH PARTITION realtime.messages_2025_12_05 FOR VALUES FROM ('2025-12-05 00:00:00') TO ('2025-12-06 00:00:00');


--
-- Name: refresh_tokens id; Type: DEFAULT; Schema: auth; Owner: -
--

ALTER TABLE ONLY auth.refresh_tokens ALTER COLUMN id SET DEFAULT nextval('auth.refresh_tokens_id_seq'::regclass);


--
-- Name: experiments experiment_id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.experiments ALTER COLUMN experiment_id SET DEFAULT nextval('public.experiments_experiment_id_seq'::regclass);


--
-- Name: hooks id; Type: DEFAULT; Schema: supabase_functions; Owner: -
--

ALTER TABLE ONLY supabase_functions.hooks ALTER COLUMN id SET DEFAULT nextval('supabase_functions.hooks_id_seq'::regclass);


--
-- Data for Name: extensions; Type: TABLE DATA; Schema: _realtime; Owner: -
--

COPY _realtime.extensions (id, type, settings, tenant_external_id, inserted_at, updated_at) FROM stdin;
18b3f8f4-7842-4921-b6fe-eda792533284	postgres_cdc_rls	{"region": "us-east-1", "db_host": "jojNM5epTA6mHrc9dSyLoBfwQquSOUGKnnY9wJLnX68=", "db_name": "sWBpZNdjggEPTQVlI52Zfw==", "db_port": "+enMDFi1J/3IrrquHHwUmA==", "db_user": "uxbEq/zz8DXVD53TOI1zmw==", "slot_name": "supabase_realtime_replication_slot", "db_password": "sWBpZNdjggEPTQVlI52Zfw==", "publication": "supabase_realtime", "ssl_enforced": false, "poll_interval_ms": 100, "poll_max_changes": 100, "poll_max_record_bytes": 1048576}	realtime-dev	2025-12-02 00:04:20	2025-12-02 00:04:20
\.


--
-- Data for Name: schema_migrations; Type: TABLE DATA; Schema: _realtime; Owner: -
--

COPY _realtime.schema_migrations (version, inserted_at) FROM stdin;
20210706140551	2025-11-18 07:44:31
20220329161857	2025-11-18 07:44:31
20220410212326	2025-11-18 07:44:31
20220506102948	2025-11-18 07:44:31
20220527210857	2025-11-18 07:44:31
20220815211129	2025-11-18 07:44:31
20220815215024	2025-11-18 07:44:31
20220818141501	2025-11-18 07:44:31
20221018173709	2025-11-18 07:44:31
20221102172703	2025-11-18 07:44:31
20221223010058	2025-11-18 07:44:31
20230110180046	2025-11-18 07:44:31
20230810220907	2025-11-18 07:44:31
20230810220924	2025-11-18 07:44:31
20231024094642	2025-11-18 07:44:31
20240306114423	2025-11-18 07:44:31
20240418082835	2025-11-18 07:44:31
20240625211759	2025-11-18 07:44:31
20240704172020	2025-11-18 07:44:31
20240902173232	2025-11-18 07:44:31
20241106103258	2025-11-18 07:44:31
20250424203323	2025-11-18 07:44:31
20250613072131	2025-11-18 07:44:31
20250711044927	2025-11-18 07:44:31
20250811121559	2025-11-18 07:44:31
20250926223044	2025-11-18 07:44:31
\.


--
-- Data for Name: tenants; Type: TABLE DATA; Schema: _realtime; Owner: -
--

COPY _realtime.tenants (id, name, external_id, jwt_secret, max_concurrent_users, inserted_at, updated_at, max_events_per_second, postgres_cdc_default, max_bytes_per_second, max_channels_per_client, max_joins_per_second, suspend, jwt_jwks, notify_private_alpha, private_only, migrations_ran, broadcast_adapter, max_presence_events_per_second, max_payload_size_in_kb) FROM stdin;
87946011-b46f-425e-bb79-48e6204898e9	realtime-dev	realtime-dev	iNjicxc4+llvc9wovDvqymwfnj9teWMlyOIbJ8Fh6j2WNU8CIJ2ZgjR6MUIKqSmeDmvpsKLsZ9jgXJmQPpwL8w==	200	2025-12-02 00:04:20	2025-12-02 00:04:20	100	postgres_cdc_rls	100000	100	100	f	{"keys": [{"k": "c3VwZXItc2VjcmV0LWp3dC10b2tlbi13aXRoLWF0LWxlYXN0LTMyLWNoYXJhY3RlcnMtbG9uZw", "kty": "oct"}]}	f	f	65	gen_rpc	1000	3000
\.


--
-- Data for Name: audit_log_entries; Type: TABLE DATA; Schema: auth; Owner: -
--

COPY auth.audit_log_entries (instance_id, id, payload, created_at, ip_address) FROM stdin;
00000000-0000-0000-0000-000000000000	c95dd842-eca9-4210-819e-187ce433e2c6	{"action":"user_signedup","actor_id":"cd296610-acc6-4a27-bc44-62d7e5d18a9b","actor_name":"ds@ds123.com","actor_username":"ds@ds123.com","actor_via_sso":false,"log_type":"team","traits":{"provider":"email"}}	2025-11-18 09:21:09.043153+00	
00000000-0000-0000-0000-000000000000	83eed7a9-d172-4880-927e-22783e2e3744	{"action":"login","actor_id":"cd296610-acc6-4a27-bc44-62d7e5d18a9b","actor_name":"ds@ds123.com","actor_username":"ds@ds123.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-11-18 09:21:09.056504+00	
00000000-0000-0000-0000-000000000000	f4bbb27d-c976-4257-aea8-ffb987f615f7	{"action":"login","actor_id":"cd296610-acc6-4a27-bc44-62d7e5d18a9b","actor_name":"ds@ds123.com","actor_username":"ds@ds123.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-11-18 09:21:26.915485+00	
00000000-0000-0000-0000-000000000000	9133234b-4025-4755-8a1d-523bc72d88bd	{"action":"user_signedup","actor_id":"ff478eba-be0c-4e5b-af9a-ae5308d5ca3b","actor_name":"han","actor_username":"yizheng@h.com","actor_via_sso":false,"log_type":"team","traits":{"provider":"email"}}	2025-11-19 05:20:41.481014+00	
00000000-0000-0000-0000-000000000000	fabf56bc-e45a-44d3-8878-3c4732ec2266	{"action":"login","actor_id":"ff478eba-be0c-4e5b-af9a-ae5308d5ca3b","actor_name":"han","actor_username":"yizheng@h.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-11-19 05:20:41.500464+00	
00000000-0000-0000-0000-000000000000	ace6066a-316f-4075-90cd-61cf34c1f367	{"action":"user_signedup","actor_id":"4c162250-6d2a-491c-9ea6-5f96332dd929","actor_name":"yingjie","actor_username":"yingjie@design.com","actor_via_sso":false,"log_type":"team","traits":{"provider":"email"}}	2025-11-19 05:40:40.4067+00	
00000000-0000-0000-0000-000000000000	9f4b8644-23cc-45a0-b7cc-e0593cdb8cd6	{"action":"login","actor_id":"4c162250-6d2a-491c-9ea6-5f96332dd929","actor_name":"yingjie","actor_username":"yingjie@design.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-11-19 05:40:40.419054+00	
00000000-0000-0000-0000-000000000000	68fc743e-95cc-4cc9-ae2f-0a30d790a922	{"action":"logout","actor_id":"ff478eba-be0c-4e5b-af9a-ae5308d5ca3b","actor_name":"han","actor_username":"yizheng@h.com","actor_via_sso":false,"log_type":"account"}	2025-11-19 05:57:30.016639+00	
00000000-0000-0000-0000-000000000000	4d43a6f5-3a17-47ad-907d-843e70f9e922	{"action":"login","actor_id":"f64611ca-6a4d-42dd-ac81-c2c91b190dd0","actor_name":"andy","actor_username":"yizheng@ds.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-11-19 05:57:44.787331+00	
00000000-0000-0000-0000-000000000000	c71c1a7e-bca9-4c67-a04d-8380133fe60f	{"action":"user_signedup","actor_id":"0399fa1a-4045-425b-b514-dfd8fb44f233","actor_name":"朱伟章Allen","actor_username":"wadezhuhk@gmail.com","actor_via_sso":false,"log_type":"team","traits":{"provider":"email"}}	2025-11-19 06:29:57.564815+00	
00000000-0000-0000-0000-000000000000	70fe1ab3-a69d-4797-965a-83fab41c6f8f	{"action":"login","actor_id":"0399fa1a-4045-425b-b514-dfd8fb44f233","actor_name":"朱伟章Allen","actor_username":"wadezhuhk@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-11-19 06:29:57.580284+00	
00000000-0000-0000-0000-000000000000	e6c3961f-1100-4af2-8865-5ed2b0c0bdc3	{"action":"login","actor_id":"f64611ca-6a4d-42dd-ac81-c2c91b190dd0","actor_name":"andy","actor_username":"yizheng@ds.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-11-23 17:25:02.59167+00	
00000000-0000-0000-0000-000000000000	4ed0d248-282d-4f03-bd3a-9a8274ca3ee0	{"action":"logout","actor_id":"f64611ca-6a4d-42dd-ac81-c2c91b190dd0","actor_name":"andy","actor_username":"yizheng@ds.com","actor_via_sso":false,"log_type":"account"}	2025-11-23 17:25:06.771581+00	
00000000-0000-0000-0000-000000000000	e22be106-8e51-4d84-bdf7-2513d9004b28	{"action":"user_repeated_signup","actor_id":"ff478eba-be0c-4e5b-af9a-ae5308d5ca3b","actor_name":"han","actor_username":"yizheng@h.com","actor_via_sso":false,"log_type":"user","traits":{"provider":"email"}}	2025-11-23 17:25:36.346368+00	
00000000-0000-0000-0000-000000000000	d2b9d859-5f78-45f9-a8e6-fd3d42e384ca	{"action":"user_signedup","actor_id":"7dd0e9a0-75de-40fd-8998-d387885178d7","actor_name":"hu1","actor_username":"yizheng@h1.com","actor_via_sso":false,"log_type":"team","traits":{"provider":"email"}}	2025-11-23 17:25:49.344103+00	
00000000-0000-0000-0000-000000000000	b1c59104-941e-47a2-b0f7-a39918ec4002	{"action":"login","actor_id":"7dd0e9a0-75de-40fd-8998-d387885178d7","actor_name":"hu1","actor_username":"yizheng@h1.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-11-23 17:25:49.354969+00	
00000000-0000-0000-0000-000000000000	2663d46b-80e8-4453-aa49-e6d604166816	{"action":"logout","actor_id":"7dd0e9a0-75de-40fd-8998-d387885178d7","actor_name":"hu1","actor_username":"yizheng@h1.com","actor_via_sso":false,"log_type":"account"}	2025-11-23 17:25:57.448658+00	
00000000-0000-0000-0000-000000000000	6cbcd3eb-2074-4cda-b57b-d1ae989f9e9b	{"action":"user_signedup","actor_id":"420f8270-af9a-41ce-87b2-3143037c9237","actor_name":"yun","actor_username":"yizheng@yun.com","actor_via_sso":false,"log_type":"team","traits":{"provider":"email"}}	2025-11-23 17:26:40.614176+00	
00000000-0000-0000-0000-000000000000	d145ac19-6997-46aa-8b6b-c9c223c16f46	{"action":"user_repeated_signup","actor_id":"420f8270-af9a-41ce-87b2-3143037c9237","actor_name":"yun","actor_username":"yizheng@yun.com","actor_via_sso":false,"log_type":"user","traits":{"provider":"email"}}	2025-11-23 17:26:41.010897+00	
00000000-0000-0000-0000-000000000000	6a1440b6-66f2-40af-8615-e5870dce18ee	{"action":"user_signedup","actor_id":"d524f2e6-27d4-4f1b-b171-e96df36ec23e","actor_name":"yun","actor_username":"yizheng@y6.com","actor_via_sso":false,"log_type":"team","traits":{"provider":"email"}}	2025-11-23 17:26:50.874943+00	
00000000-0000-0000-0000-000000000000	c5986ed5-190f-4505-b643-16ea792ffa79	{"action":"login","actor_id":"d524f2e6-27d4-4f1b-b171-e96df36ec23e","actor_name":"yun","actor_username":"yizheng@y6.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-11-23 17:26:50.888433+00	
00000000-0000-0000-0000-000000000000	b2359df4-5eab-42af-a08c-de300e47f8e6	{"action":"logout","actor_id":"d524f2e6-27d4-4f1b-b171-e96df36ec23e","actor_name":"yun","actor_username":"yizheng@y6.com","actor_via_sso":false,"log_type":"account"}	2025-11-23 19:48:35.614501+00	
00000000-0000-0000-0000-000000000000	071e3cb8-6aac-497b-9a38-8f52ad6a1574	{"action":"user_repeated_signup","actor_id":"03224804-4c7f-4807-b40e-565de27bb5f5","actor_name":"andy","actor_username":"jyizheng@gmail.com","actor_via_sso":false,"log_type":"user","traits":{"provider":"email"}}	2025-11-23 19:49:06.708081+00	
00000000-0000-0000-0000-000000000000	c89fda1e-2820-4468-88a0-c79c5ddc8c9f	{"action":"user_signedup","actor_id":"eae2c683-0eb3-4cda-b879-5faee87564fa","actor_name":"joe","actor_username":"yizheng@cs.unc.edu","actor_via_sso":false,"log_type":"team","traits":{"provider":"email"}}	2025-11-23 19:49:25.822855+00	
00000000-0000-0000-0000-000000000000	26a4e7c1-4640-44f6-90aa-9f46d3bfe61c	{"action":"user_repeated_signup","actor_id":"eae2c683-0eb3-4cda-b879-5faee87564fa","actor_name":"joe","actor_username":"yizheng@cs.unc.edu","actor_via_sso":false,"log_type":"user","traits":{"provider":"email"}}	2025-11-23 19:49:26.426245+00	
00000000-0000-0000-0000-000000000000	4df6900e-afde-4b8d-82a2-2502771ccc5e	{"action":"login","actor_id":"f64611ca-6a4d-42dd-ac81-c2c91b190dd0","actor_name":"andy","actor_username":"yizheng@ds.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-11-23 23:50:25.824197+00	
00000000-0000-0000-0000-000000000000	75ab1154-2073-42fb-93ae-63a550336e20	{"action":"logout","actor_id":"f64611ca-6a4d-42dd-ac81-c2c91b190dd0","actor_name":"andy","actor_username":"yizheng@ds.com","actor_via_sso":false,"log_type":"account"}	2025-11-23 23:59:05.32066+00	
00000000-0000-0000-0000-000000000000	eae2fb0b-c3b6-4833-852f-71c618ac54bb	{"action":"user_repeated_signup","actor_id":"03224804-4c7f-4807-b40e-565de27bb5f5","actor_name":"andy","actor_username":"jyizheng@gmail.com","actor_via_sso":false,"log_type":"user","traits":{"provider":"email"}}	2025-11-23 23:59:27.076696+00	
00000000-0000-0000-0000-000000000000	3f5a1be4-20f8-40ad-8a4c-34153a1614c3	{"action":"user_deleted","actor_id":"00000000-0000-0000-0000-000000000000","actor_username":"service_role","actor_via_sso":false,"log_type":"team","traits":{"user_email":"jyizheng@gmail.com","user_id":"03224804-4c7f-4807-b40e-565de27bb5f5","user_phone":""}}	2025-11-24 00:00:09.723788+00	
00000000-0000-0000-0000-000000000000	c2736b45-08a2-45d4-ba88-6a987c14383e	{"action":"user_signedup","actor_id":"d0d1f66c-27d1-4bdd-a633-c6c8db1e125e","actor_name":"jim","actor_username":"jyizheng@gmail.com","actor_via_sso":false,"log_type":"team","traits":{"provider":"email"}}	2025-11-24 00:00:14.989215+00	
00000000-0000-0000-0000-000000000000	8aa1471f-05a3-48b1-ab39-4fd2b07fd474	{"action":"login","actor_id":"d0d1f66c-27d1-4bdd-a633-c6c8db1e125e","actor_name":"jim","actor_username":"jyizheng@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-11-24 00:00:14.998898+00	
00000000-0000-0000-0000-000000000000	a2758e43-4d78-4f8f-aa9f-753c637d817e	{"action":"logout","actor_id":"d0d1f66c-27d1-4bdd-a633-c6c8db1e125e","actor_name":"jim","actor_username":"jyizheng@gmail.com","actor_via_sso":false,"log_type":"account"}	2025-11-24 03:05:42.050841+00	
00000000-0000-0000-0000-000000000000	3f73d5fc-9c24-426b-8265-c78c35c366bf	{"action":"user_repeated_signup","actor_id":"d0d1f66c-27d1-4bdd-a633-c6c8db1e125e","actor_name":"jim","actor_username":"jyizheng@gmail.com","actor_via_sso":false,"log_type":"user","traits":{"provider":"email"}}	2025-11-24 03:06:02.182494+00	
00000000-0000-0000-0000-000000000000	8b433592-3da5-458f-a17f-ec4fecf3115f	{"action":"user_deleted","actor_id":"00000000-0000-0000-0000-000000000000","actor_username":"service_role","actor_via_sso":false,"log_type":"team","traits":{"user_email":"jyizheng@gmail.com","user_id":"d0d1f66c-27d1-4bdd-a633-c6c8db1e125e","user_phone":""}}	2025-11-24 03:08:39.021455+00	
00000000-0000-0000-0000-000000000000	647bb003-7db0-46fd-953a-fdf7173ee073	{"action":"user_deleted","actor_id":"00000000-0000-0000-0000-000000000000","actor_username":"service_role","actor_via_sso":false,"log_type":"team","traits":{"user_email":"yizheng@cs.unc.edu","user_id":"eae2c683-0eb3-4cda-b879-5faee87564fa","user_phone":""}}	2025-11-24 03:12:32.919407+00	
00000000-0000-0000-0000-000000000000	c82326d1-9595-4aa9-a447-da2ebf65b40c	{"action":"login","actor_id":"f64611ca-6a4d-42dd-ac81-c2c91b190dd0","actor_name":"andy","actor_username":"yizheng@ds.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-11-24 03:13:11.870873+00	
00000000-0000-0000-0000-000000000000	72844e1f-c19b-449f-a831-bbae2a1f6484	{"action":"logout","actor_id":"f64611ca-6a4d-42dd-ac81-c2c91b190dd0","actor_name":"andy","actor_username":"yizheng@ds.com","actor_via_sso":false,"log_type":"account"}	2025-11-24 03:25:50.155326+00	
00000000-0000-0000-0000-000000000000	52352f63-b5bc-40a8-96c5-b153991f992a	{"action":"user_confirmation_requested","actor_id":"b8b372b5-bd93-48fe-8afa-5a35480330da","actor_name":"test","actor_username":"test@ds.com","actor_via_sso":false,"log_type":"user","traits":{"provider":"email"}}	2025-11-24 04:28:43.177348+00	
00000000-0000-0000-0000-000000000000	70cd6c14-0721-4112-97b1-a08a97d0bbba	{"action":"user_confirmation_requested","actor_id":"b8b372b5-bd93-48fe-8afa-5a35480330da","actor_name":"test","actor_username":"test@ds.com","actor_via_sso":false,"log_type":"user","traits":{"provider":"email"}}	2025-11-24 04:35:00.804447+00	
00000000-0000-0000-0000-000000000000	b1c412da-4da5-4f7e-ab3f-4792e4e242d5	{"action":"user_confirmation_requested","actor_id":"b8b372b5-bd93-48fe-8afa-5a35480330da","actor_name":"test","actor_username":"test@ds.com","actor_via_sso":false,"log_type":"user","traits":{"provider":"email"}}	2025-11-24 04:35:17.52986+00	
00000000-0000-0000-0000-000000000000	e793c3f2-d7b4-4988-9143-7bdce62add0d	{"action":"user_confirmation_requested","actor_id":"dff299c1-c9c2-4035-9f2e-107d46ae3c5e","actor_name":"test","actor_username":"wanghaipeng@dsdigitalgroup.com","actor_via_sso":false,"log_type":"user","traits":{"provider":"email"}}	2025-11-24 04:42:25.278418+00	
00000000-0000-0000-0000-000000000000	88c5c4e7-54f5-48d4-9416-68a7377473d5	{"action":"user_confirmation_requested","actor_id":"dff299c1-c9c2-4035-9f2e-107d46ae3c5e","actor_name":"test","actor_username":"wanghaipeng@dsdigitalgroup.com","actor_via_sso":false,"log_type":"user","traits":{"provider":"email"}}	2025-11-24 04:43:53.052277+00	
00000000-0000-0000-0000-000000000000	0db3e5a1-4ce6-4cce-a438-edcacfe93578	{"action":"user_confirmation_requested","actor_id":"dff299c1-c9c2-4035-9f2e-107d46ae3c5e","actor_name":"test","actor_username":"wanghaipeng@dsdigitalgroup.com","actor_via_sso":false,"log_type":"user","traits":{"provider":"email"}}	2025-11-24 06:18:02.860442+00	
00000000-0000-0000-0000-000000000000	2a9e1280-76f7-457e-ab0c-47d7cd6a8891	{"action":"user_confirmation_requested","actor_id":"dff299c1-c9c2-4035-9f2e-107d46ae3c5e","actor_name":"test","actor_username":"wanghaipeng@dsdigitalgroup.com","actor_via_sso":false,"log_type":"user","traits":{"provider":"email"}}	2025-11-24 07:01:04.14764+00	
00000000-0000-0000-0000-000000000000	71bb3181-dff8-4be0-9fce-e035161df9ed	{"action":"user_confirmation_requested","actor_id":"dff299c1-c9c2-4035-9f2e-107d46ae3c5e","actor_name":"test","actor_username":"wanghaipeng@dsdigitalgroup.com","actor_via_sso":false,"log_type":"user","traits":{"provider":"email"}}	2025-11-24 07:01:21.484439+00	
00000000-0000-0000-0000-000000000000	5c5936f1-1708-4f90-9171-0591b229d7bc	{"action":"user_confirmation_requested","actor_id":"dff299c1-c9c2-4035-9f2e-107d46ae3c5e","actor_name":"test","actor_username":"wanghaipeng@dsdigitalgroup.com","actor_via_sso":false,"log_type":"user","traits":{"provider":"email"}}	2025-11-24 07:01:37.449549+00	
00000000-0000-0000-0000-000000000000	abb43ada-e4e5-4ea4-9493-650c6e8185da	{"action":"login","actor_id":"0399fa1a-4045-425b-b514-dfd8fb44f233","actor_name":"朱伟章Allen","actor_username":"wadezhuhk@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-11-25 02:06:49.412628+00	
00000000-0000-0000-0000-000000000000	67bc6a94-a3a5-4e1e-8e86-aeaf2c8aa506	{"action":"login","actor_id":"0399fa1a-4045-425b-b514-dfd8fb44f233","actor_name":"朱伟章Allen","actor_username":"wadezhuhk@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-11-25 02:07:28.795078+00	
00000000-0000-0000-0000-000000000000	c7526c4b-2222-4994-a0aa-2696185b48d8	{"action":"user_signedup","actor_id":"4398b7ca-ef2c-4b26-b426-d69340b4c15c","actor_name":"FC","actor_username":"fc13303752056@163.com","actor_via_sso":false,"log_type":"team","traits":{"provider":"email"}}	2025-11-25 03:53:20.365823+00	
00000000-0000-0000-0000-000000000000	b450e64d-d7c2-4e7c-a921-364ee2aa94be	{"action":"login","actor_id":"4398b7ca-ef2c-4b26-b426-d69340b4c15c","actor_name":"FC","actor_username":"fc13303752056@163.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-11-25 03:53:20.377857+00	
00000000-0000-0000-0000-000000000000	f491e778-fb33-4bb9-b353-8deafed3ef4b	{"action":"login","actor_id":"f64611ca-6a4d-42dd-ac81-c2c91b190dd0","actor_name":"andy","actor_username":"yizheng@ds.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-11-25 04:09:59.399246+00	
00000000-0000-0000-0000-000000000000	2acfcf29-8f1a-49e3-8b68-a5a035bd7beb	{"action":"logout","actor_id":"f64611ca-6a4d-42dd-ac81-c2c91b190dd0","actor_name":"andy","actor_username":"yizheng@ds.com","actor_via_sso":false,"log_type":"account"}	2025-11-25 07:12:55.111322+00	
00000000-0000-0000-0000-000000000000	1e0b22e7-e043-4e10-9b21-db268d12a146	{"action":"logout","actor_id":"0399fa1a-4045-425b-b514-dfd8fb44f233","actor_name":"朱伟章Allen","actor_username":"wadezhuhk@gmail.com","actor_via_sso":false,"log_type":"account"}	2025-11-25 10:26:32.634236+00	
00000000-0000-0000-0000-000000000000	91a8df85-ca40-4a05-a592-89b1e8409b62	{"action":"user_signedup","actor_id":"6cdba011-5883-4b7d-89f4-ea9a1bcacc55","actor_name":"wade_test_1","actor_username":"wadezhuhk_test_1@gmail.com","actor_via_sso":false,"log_type":"team","traits":{"provider":"email"}}	2025-11-25 10:27:12.349228+00	
00000000-0000-0000-0000-000000000000	6cfe43f8-b059-42bd-873b-798dce51c54d	{"action":"login","actor_id":"6cdba011-5883-4b7d-89f4-ea9a1bcacc55","actor_name":"wade_test_1","actor_username":"wadezhuhk_test_1@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-11-25 10:27:12.370697+00	
00000000-0000-0000-0000-000000000000	2605ac20-44a5-458a-bd14-eb03c422f29d	{"action":"logout","actor_id":"6cdba011-5883-4b7d-89f4-ea9a1bcacc55","actor_name":"wade_test_1","actor_username":"wadezhuhk_test_1@gmail.com","actor_via_sso":false,"log_type":"account"}	2025-11-25 10:27:22.087668+00	
00000000-0000-0000-0000-000000000000	c3bbaaa1-efe7-489a-be31-8a28605c4bb9	{"action":"user_signedup","actor_id":"ce008f4b-dfe9-4301-a844-fe7d337dd1c5","actor_name":"wadezhuhk_test_2","actor_username":"wadezhuhk_test_2@gmail.com","actor_via_sso":false,"log_type":"team","traits":{"provider":"email"}}	2025-11-25 10:27:34.759173+00	
00000000-0000-0000-0000-000000000000	c41ff662-89d6-47fd-800b-286487efa33e	{"action":"login","actor_id":"ce008f4b-dfe9-4301-a844-fe7d337dd1c5","actor_name":"wadezhuhk_test_2","actor_username":"wadezhuhk_test_2@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-11-25 10:27:34.77327+00	
00000000-0000-0000-0000-000000000000	e13a7365-ce4b-42ea-9541-75a8906ca671	{"action":"logout","actor_id":"ce008f4b-dfe9-4301-a844-fe7d337dd1c5","actor_name":"wadezhuhk_test_2","actor_username":"wadezhuhk_test_2@gmail.com","actor_via_sso":false,"log_type":"account"}	2025-11-25 10:27:39.115154+00	
00000000-0000-0000-0000-000000000000	cc610e0a-48fb-4af4-a592-719c39a7129a	{"action":"user_signedup","actor_id":"5acbb4bd-563e-4a64-a674-edda518cfaf0","actor_name":"wadezhuhk_test_3","actor_username":"wadezhuhk_test_3@gmail.com","actor_via_sso":false,"log_type":"team","traits":{"provider":"email"}}	2025-11-25 10:27:52.171769+00	
00000000-0000-0000-0000-000000000000	497fdfb7-211d-41be-8f2c-297c8c226d74	{"action":"login","actor_id":"5acbb4bd-563e-4a64-a674-edda518cfaf0","actor_name":"wadezhuhk_test_3","actor_username":"wadezhuhk_test_3@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-11-25 10:27:52.187017+00	
00000000-0000-0000-0000-000000000000	79da10d1-725f-48dc-804c-95595a299744	{"action":"logout","actor_id":"5acbb4bd-563e-4a64-a674-edda518cfaf0","actor_name":"wadezhuhk_test_3","actor_username":"wadezhuhk_test_3@gmail.com","actor_via_sso":false,"log_type":"account"}	2025-11-25 10:27:55.215757+00	
00000000-0000-0000-0000-000000000000	4ede4ac7-2b48-4df0-92c3-ea7e5f08a9de	{"action":"user_signedup","actor_id":"d35ed0e7-12b8-4f0d-9d72-e72125816810","actor_name":"wadezhuhk_test_4","actor_username":"wadezhuhk_test_4@gmail.com","actor_via_sso":false,"log_type":"team","traits":{"provider":"email"}}	2025-11-25 10:28:13.263982+00	
00000000-0000-0000-0000-000000000000	595117b1-4b1b-48f6-86a2-719211b68848	{"action":"login","actor_id":"d35ed0e7-12b8-4f0d-9d72-e72125816810","actor_name":"wadezhuhk_test_4","actor_username":"wadezhuhk_test_4@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-11-25 10:28:13.277114+00	
00000000-0000-0000-0000-000000000000	51f6b4cd-f334-4cc1-b6c2-922894f0555f	{"action":"logout","actor_id":"d35ed0e7-12b8-4f0d-9d72-e72125816810","actor_name":"wadezhuhk_test_4","actor_username":"wadezhuhk_test_4@gmail.com","actor_via_sso":false,"log_type":"account"}	2025-11-25 10:28:16.555983+00	
00000000-0000-0000-0000-000000000000	25775a11-10d4-4e36-a771-c73ab1981757	{"action":"user_signedup","actor_id":"f5f0f0a1-0672-4673-ae01-cdd187fcc4cd","actor_name":"wadezhuhk_test_5","actor_username":"wadezhuhk_test_5@gmail.com","actor_via_sso":false,"log_type":"team","traits":{"provider":"email"}}	2025-11-25 10:28:24.68193+00	
00000000-0000-0000-0000-000000000000	c04e05dd-4222-47e1-ae2f-4a49d64e1d24	{"action":"login","actor_id":"f5f0f0a1-0672-4673-ae01-cdd187fcc4cd","actor_name":"wadezhuhk_test_5","actor_username":"wadezhuhk_test_5@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-11-25 10:28:24.695924+00	
00000000-0000-0000-0000-000000000000	e8a67ac2-7690-4c86-ae08-83a8e05e7c41	{"action":"logout","actor_id":"f5f0f0a1-0672-4673-ae01-cdd187fcc4cd","actor_name":"wadezhuhk_test_5","actor_username":"wadezhuhk_test_5@gmail.com","actor_via_sso":false,"log_type":"account"}	2025-11-25 10:28:28.447033+00	
00000000-0000-0000-0000-000000000000	48ae8fd4-6143-49a6-b3c6-a47a1e7be4ce	{"action":"login","actor_id":"0399fa1a-4045-425b-b514-dfd8fb44f233","actor_name":"朱伟章Allen","actor_username":"wadezhuhk@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-11-26 02:27:33.908335+00	
00000000-0000-0000-0000-000000000000	11e87fe7-e5fb-437b-b0d2-713a6ff554ef	{"action":"user_signedup","actor_id":"c3ed6099-2c74-44c9-bdaf-ba9091766d62","actor_name":"wadezhuhk_test_6","actor_username":"wadezhuhk_test_6@gmail.com","actor_via_sso":false,"log_type":"team","traits":{"provider":"email"}}	2025-11-25 10:28:40.740597+00	
00000000-0000-0000-0000-000000000000	a88bcb1a-f208-4c67-85f9-27765cad9113	{"action":"login","actor_id":"c3ed6099-2c74-44c9-bdaf-ba9091766d62","actor_name":"wadezhuhk_test_6","actor_username":"wadezhuhk_test_6@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-11-25 10:28:40.755296+00	
00000000-0000-0000-0000-000000000000	f1b2937c-016e-4634-b5ea-f0ed259319ef	{"action":"logout","actor_id":"c3ed6099-2c74-44c9-bdaf-ba9091766d62","actor_name":"wadezhuhk_test_6","actor_username":"wadezhuhk_test_6@gmail.com","actor_via_sso":false,"log_type":"account"}	2025-11-25 10:28:43.72251+00	
00000000-0000-0000-0000-000000000000	7cc56252-8bb5-4e24-bf10-0cede36b937f	{"action":"login","actor_id":"0399fa1a-4045-425b-b514-dfd8fb44f233","actor_name":"朱伟章Allen","actor_username":"wadezhuhk@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-11-25 10:28:47.143377+00	
00000000-0000-0000-0000-000000000000	3236a32e-d951-46c8-926a-f25373428725	{"action":"login","actor_id":"f64611ca-6a4d-42dd-ac81-c2c91b190dd0","actor_name":"andy","actor_username":"yizheng@ds.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-11-25 10:32:22.088545+00	
00000000-0000-0000-0000-000000000000	4893e0d5-fc76-48bb-8226-86c175396e02	{"action":"logout","actor_id":"0399fa1a-4045-425b-b514-dfd8fb44f233","actor_name":"朱伟章Allen","actor_username":"wadezhuhk@gmail.com","actor_via_sso":false,"log_type":"account"}	2025-11-25 11:15:52.002414+00	
00000000-0000-0000-0000-000000000000	8ca0317f-8d01-4f1e-a7c5-1f068df60be4	{"action":"login","actor_id":"0399fa1a-4045-425b-b514-dfd8fb44f233","actor_name":"朱伟章Allen","actor_username":"wadezhuhk@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-11-25 11:16:02.870931+00	
00000000-0000-0000-0000-000000000000	4fc89035-9b37-4041-b4a1-fecd62973c89	{"action":"logout","actor_id":"0399fa1a-4045-425b-b514-dfd8fb44f233","actor_name":"朱伟章Allen","actor_username":"wadezhuhk@gmail.com","actor_via_sso":false,"log_type":"account"}	2025-11-25 11:16:09.99879+00	
00000000-0000-0000-0000-000000000000	741c7139-145d-44a1-8d77-23a7fd738361	{"action":"login","actor_id":"ce008f4b-dfe9-4301-a844-fe7d337dd1c5","actor_name":"wadezhuhk_test_2","actor_username":"wadezhuhk_test_2@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-11-25 11:16:23.745284+00	
00000000-0000-0000-0000-000000000000	efae2cfc-e669-4b20-994f-b280b65233a6	{"action":"logout","actor_id":"ce008f4b-dfe9-4301-a844-fe7d337dd1c5","actor_name":"wadezhuhk_test_2","actor_username":"wadezhuhk_test_2@gmail.com","actor_via_sso":false,"log_type":"account"}	2025-11-25 11:16:43.622965+00	
00000000-0000-0000-0000-000000000000	9c3ca632-160c-41c7-bc6d-1ea89ba2e051	{"action":"login","actor_id":"0399fa1a-4045-425b-b514-dfd8fb44f233","actor_name":"朱伟章Allen","actor_username":"wadezhuhk@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-11-25 11:16:45.978237+00	
00000000-0000-0000-0000-000000000000	684cd468-98d9-41f8-be80-6030b0d0af3f	{"action":"logout","actor_id":"0399fa1a-4045-425b-b514-dfd8fb44f233","actor_name":"朱伟章Allen","actor_username":"wadezhuhk@gmail.com","actor_via_sso":false,"log_type":"account"}	2025-11-25 11:17:12.600181+00	
00000000-0000-0000-0000-000000000000	3980ebca-262f-4604-a5ca-cf908849503d	{"action":"login","actor_id":"f5f0f0a1-0672-4673-ae01-cdd187fcc4cd","actor_name":"wadezhuhk_test_5","actor_username":"wadezhuhk_test_5@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-11-25 11:17:25.529044+00	
00000000-0000-0000-0000-000000000000	7688ace8-c670-4b58-b3ec-62a610ce99f3	{"action":"logout","actor_id":"f5f0f0a1-0672-4673-ae01-cdd187fcc4cd","actor_name":"wadezhuhk_test_5","actor_username":"wadezhuhk_test_5@gmail.com","actor_via_sso":false,"log_type":"account"}	2025-11-25 11:17:54.013314+00	
00000000-0000-0000-0000-000000000000	e79fab96-28c5-4a3e-8f38-e1e978ace268	{"action":"login","actor_id":"0399fa1a-4045-425b-b514-dfd8fb44f233","actor_name":"朱伟章Allen","actor_username":"wadezhuhk@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-11-25 11:17:56.09173+00	
00000000-0000-0000-0000-000000000000	a9bc9f1d-1949-448a-9a80-2465dda62a12	{"action":"logout","actor_id":"0399fa1a-4045-425b-b514-dfd8fb44f233","actor_name":"朱伟章Allen","actor_username":"wadezhuhk@gmail.com","actor_via_sso":false,"log_type":"account"}	2025-11-25 11:37:17.377751+00	
00000000-0000-0000-0000-000000000000	7c028414-7fb3-4d18-bdc2-4adfd170ca67	{"action":"login","actor_id":"0399fa1a-4045-425b-b514-dfd8fb44f233","actor_name":"朱伟章Allen","actor_username":"wadezhuhk@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-11-25 11:37:25.095115+00	
00000000-0000-0000-0000-000000000000	3f7b5cbe-b0bc-4509-9fd7-935317060063	{"action":"logout","actor_id":"f64611ca-6a4d-42dd-ac81-c2c91b190dd0","actor_name":"andy","actor_username":"yizheng@ds.com","actor_via_sso":false,"log_type":"account"}	2025-11-25 11:39:12.547793+00	
00000000-0000-0000-0000-000000000000	c3c56689-fe20-4e96-8355-ead3445b109b	{"action":"login","actor_id":"0399fa1a-4045-425b-b514-dfd8fb44f233","actor_name":"朱伟章Allen","actor_username":"wadezhuhk@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-11-25 11:40:33.445568+00	
00000000-0000-0000-0000-000000000000	1bf3004d-5501-4433-9342-be702a5e6b27	{"action":"login","actor_id":"0399fa1a-4045-425b-b514-dfd8fb44f233","actor_name":"朱伟章Allen","actor_username":"wadezhuhk@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-11-25 11:43:37.214568+00	
00000000-0000-0000-0000-000000000000	690d9f94-d810-45f2-be08-cae3fc6b3e45	{"action":"logout","actor_id":"0399fa1a-4045-425b-b514-dfd8fb44f233","actor_name":"朱伟章Allen","actor_username":"wadezhuhk@gmail.com","actor_via_sso":false,"log_type":"account"}	2025-11-25 12:05:50.274624+00	
00000000-0000-0000-0000-000000000000	7c1dfbcb-e2ad-4e61-ba35-a1b61f007727	{"action":"login","actor_id":"f64611ca-6a4d-42dd-ac81-c2c91b190dd0","actor_name":"andy","actor_username":"yizheng@ds.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-11-25 12:06:00.434945+00	
00000000-0000-0000-0000-000000000000	ccb41bc9-8501-4deb-b238-8b49c48f6bca	{"action":"login","actor_id":"f64611ca-6a4d-42dd-ac81-c2c91b190dd0","actor_name":"andy","actor_username":"yizheng@ds.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-11-25 12:27:27.618136+00	
00000000-0000-0000-0000-000000000000	9031d157-1e64-4fb7-a6f9-9413034f8916	{"action":"login","actor_id":"f64611ca-6a4d-42dd-ac81-c2c91b190dd0","actor_name":"andy","actor_username":"yizheng@ds.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-11-25 12:27:31.483852+00	
00000000-0000-0000-0000-000000000000	7120706e-6af6-4780-b186-5c3c8fdb4870	{"action":"login","actor_id":"f64611ca-6a4d-42dd-ac81-c2c91b190dd0","actor_name":"andy","actor_username":"yizheng@ds.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-11-25 12:27:58.604023+00	
00000000-0000-0000-0000-000000000000	5c85ffe8-8370-4131-9677-acbb78c72c4f	{"action":"login","actor_id":"f64611ca-6a4d-42dd-ac81-c2c91b190dd0","actor_name":"andy","actor_username":"yizheng@ds.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-11-25 12:28:02.68092+00	
00000000-0000-0000-0000-000000000000	45f50062-75ff-40ff-882f-ced0db8ebf80	{"action":"logout","actor_id":"f64611ca-6a4d-42dd-ac81-c2c91b190dd0","actor_name":"andy","actor_username":"yizheng@ds.com","actor_via_sso":false,"log_type":"account"}	2025-11-26 00:08:49.774112+00	
00000000-0000-0000-0000-000000000000	2a7d45b8-8d0a-4d4e-8101-8fc09c124f63	{"action":"login","actor_id":"0399fa1a-4045-425b-b514-dfd8fb44f233","actor_name":"朱伟章Allen","actor_username":"wadezhuhk@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-11-26 00:09:36.681689+00	
00000000-0000-0000-0000-000000000000	1e93f40b-acc3-4cf7-af1f-900adce797f0	{"action":"login","actor_id":"0399fa1a-4045-425b-b514-dfd8fb44f233","actor_name":"朱伟章Allen","actor_username":"wadezhuhk@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-11-26 02:21:15.310226+00	
00000000-0000-0000-0000-000000000000	6602f6ad-0385-410a-ba6d-40a536b391b8	{"action":"logout","actor_id":"0399fa1a-4045-425b-b514-dfd8fb44f233","actor_name":"朱伟章Allen","actor_username":"wadezhuhk@gmail.com","actor_via_sso":false,"log_type":"account"}	2025-11-26 03:15:14.750659+00	
00000000-0000-0000-0000-000000000000	d5b9218a-175e-4e1e-9851-9cac5dfdb73a	{"action":"login","actor_id":"0399fa1a-4045-425b-b514-dfd8fb44f233","actor_name":"朱伟章Allen","actor_username":"wadezhuhk@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-11-26 03:15:23.585721+00	
00000000-0000-0000-0000-000000000000	9a205987-1b04-4cce-900b-5d4e341a1980	{"action":"logout","actor_id":"0399fa1a-4045-425b-b514-dfd8fb44f233","actor_name":"朱伟章Allen","actor_username":"wadezhuhk@gmail.com","actor_via_sso":false,"log_type":"account"}	2025-11-26 03:16:10.938902+00	
00000000-0000-0000-0000-000000000000	9a3fba08-9260-4064-b5ab-701e9e23d46a	{"action":"login","actor_id":"6cdba011-5883-4b7d-89f4-ea9a1bcacc55","actor_name":"wade_test_1","actor_username":"wadezhuhk_test_1@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-11-26 03:16:21.087991+00	
00000000-0000-0000-0000-000000000000	fc5c7db8-ab29-4570-bba0-d7af6501bc34	{"action":"login","actor_id":"f64611ca-6a4d-42dd-ac81-c2c91b190dd0","actor_name":"andy","actor_username":"yizheng@ds.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-11-26 03:36:56.10354+00	
00000000-0000-0000-0000-000000000000	7f86cf8a-1f54-4081-b0e4-ccce9ace1fe4	{"action":"login","actor_id":"f64611ca-6a4d-42dd-ac81-c2c91b190dd0","actor_name":"andy","actor_username":"yizheng@ds.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-11-26 03:59:55.442077+00	
00000000-0000-0000-0000-000000000000	3dd747ae-837f-43e8-9d2b-9eeec457f506	{"action":"login","actor_id":"f64611ca-6a4d-42dd-ac81-c2c91b190dd0","actor_name":"andy","actor_username":"yizheng@ds.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-11-26 04:00:58.80691+00	
00000000-0000-0000-0000-000000000000	c76ac29d-8aee-4b4e-988f-8eef387e28a3	{"action":"login","actor_id":"f64611ca-6a4d-42dd-ac81-c2c91b190dd0","actor_name":"andy","actor_username":"yizheng@ds.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-11-26 04:02:20.921537+00	
00000000-0000-0000-0000-000000000000	29709fa6-54c2-432a-b7fe-495c408819cf	{"action":"login","actor_id":"f64611ca-6a4d-42dd-ac81-c2c91b190dd0","actor_name":"andy","actor_username":"yizheng@ds.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-11-26 04:09:08.25957+00	
00000000-0000-0000-0000-000000000000	1a39970e-9288-45fc-a1a8-cca0966303e4	{"action":"logout","actor_id":"4398b7ca-ef2c-4b26-b426-d69340b4c15c","actor_name":"FC","actor_username":"fc13303752056@163.com","actor_via_sso":false,"log_type":"account"}	2025-11-26 04:16:40.848177+00	
00000000-0000-0000-0000-000000000000	f6d0c603-a0f2-4a99-bd45-78e04bbe4c30	{"action":"login","actor_id":"6cdba011-5883-4b7d-89f4-ea9a1bcacc55","actor_name":"wade_test_1","actor_username":"wadezhuhk_test_1@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-11-26 04:17:02.615404+00	
00000000-0000-0000-0000-000000000000	0495bbce-f6ff-47e0-9fb5-2e691a705955	{"action":"login","actor_id":"f64611ca-6a4d-42dd-ac81-c2c91b190dd0","actor_name":"andy","actor_username":"yizheng@ds.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-11-26 04:38:01.468264+00	
00000000-0000-0000-0000-000000000000	f9e7ecc3-165f-4f89-91ab-22614973b99c	{"action":"logout","actor_id":"f64611ca-6a4d-42dd-ac81-c2c91b190dd0","actor_name":"andy","actor_username":"yizheng@ds.com","actor_via_sso":false,"log_type":"account"}	2025-11-26 06:03:22.727707+00	
00000000-0000-0000-0000-000000000000	5c79f2e5-1fae-4502-973d-6d12fa129463	{"action":"login","actor_id":"f64611ca-6a4d-42dd-ac81-c2c91b190dd0","actor_name":"andy","actor_username":"yizheng@ds.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-11-26 06:03:30.300721+00	
00000000-0000-0000-0000-000000000000	40331ec5-22aa-4d22-b0cf-a8000332a581	{"action":"login","actor_id":"f64611ca-6a4d-42dd-ac81-c2c91b190dd0","actor_name":"andy","actor_username":"yizheng@ds.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-11-26 06:17:56.159055+00	
00000000-0000-0000-0000-000000000000	7ef824f4-7f5a-454c-9a16-dd78e0600095	{"action":"logout","actor_id":"6cdba011-5883-4b7d-89f4-ea9a1bcacc55","actor_name":"wade_test_1","actor_username":"wadezhuhk_test_1@gmail.com","actor_via_sso":false,"log_type":"account"}	2025-11-26 06:44:03.072727+00	
00000000-0000-0000-0000-000000000000	17c0646a-6f0c-425f-b6f0-15e448bc4e25	{"action":"user_signedup","actor_id":"fdb2e0d6-01ca-422a-84bb-ed841c9480e6","actor_name":"FC","actor_username":"2994390156@qq.com","actor_via_sso":false,"log_type":"team","traits":{"provider":"email"}}	2025-11-26 06:44:41.438605+00	
00000000-0000-0000-0000-000000000000	17c48a91-12a2-4a2b-9960-ec113145ebd8	{"action":"login","actor_id":"fdb2e0d6-01ca-422a-84bb-ed841c9480e6","actor_name":"FC","actor_username":"2994390156@qq.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-11-26 06:44:41.448485+00	
00000000-0000-0000-0000-000000000000	9ef89710-804d-4efc-b10d-14c4aa19eeca	{"action":"logout","actor_id":"fdb2e0d6-01ca-422a-84bb-ed841c9480e6","actor_name":"FC","actor_username":"2994390156@qq.com","actor_via_sso":false,"log_type":"account"}	2025-11-26 06:49:47.747933+00	
00000000-0000-0000-0000-000000000000	fff0a501-9ee5-42e4-adc3-74023d52871e	{"action":"login","actor_id":"4398b7ca-ef2c-4b26-b426-d69340b4c15c","actor_name":"FC","actor_username":"fc13303752056@163.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-11-26 06:50:01.887158+00	
00000000-0000-0000-0000-000000000000	061eea9f-b505-49dd-a1a6-952da92a702b	{"action":"logout","actor_id":"4398b7ca-ef2c-4b26-b426-d69340b4c15c","actor_name":"FC","actor_username":"fc13303752056@163.com","actor_via_sso":false,"log_type":"account"}	2025-11-26 07:00:07.699311+00	
00000000-0000-0000-0000-000000000000	3886c060-0bc3-43de-a102-5182f686a6f7	{"action":"login","actor_id":"fdb2e0d6-01ca-422a-84bb-ed841c9480e6","actor_name":"FC","actor_username":"2994390156@qq.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-11-26 07:00:11.261382+00	
00000000-0000-0000-0000-000000000000	a1d94c12-1fd7-406c-9b2d-a1e30e42a0c6	{"action":"logout","actor_id":"fdb2e0d6-01ca-422a-84bb-ed841c9480e6","actor_name":"FC","actor_username":"2994390156@qq.com","actor_via_sso":false,"log_type":"account"}	2025-11-26 07:07:06.178742+00	
00000000-0000-0000-0000-000000000000	0f640663-2f42-4d64-95f9-59a0f33aaac4	{"action":"login","actor_id":"4398b7ca-ef2c-4b26-b426-d69340b4c15c","actor_name":"FC","actor_username":"fc13303752056@163.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-11-26 07:07:09.776199+00	
00000000-0000-0000-0000-000000000000	244f8640-39f6-49bd-943b-42ee87d7d8a4	{"action":"logout","actor_id":"4398b7ca-ef2c-4b26-b426-d69340b4c15c","actor_name":"FC","actor_username":"fc13303752056@163.com","actor_via_sso":false,"log_type":"account"}	2025-11-26 07:11:44.030835+00	
00000000-0000-0000-0000-000000000000	68758b6e-d667-495c-9b84-d90ee1f63167	{"action":"login","actor_id":"fdb2e0d6-01ca-422a-84bb-ed841c9480e6","actor_name":"FC","actor_username":"2994390156@qq.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-11-26 07:11:50.320507+00	
00000000-0000-0000-0000-000000000000	2dd8e3c7-5430-4a4c-8e82-5ab9adaac32c	{"action":"logout","actor_id":"fdb2e0d6-01ca-422a-84bb-ed841c9480e6","actor_name":"FC","actor_username":"2994390156@qq.com","actor_via_sso":false,"log_type":"account"}	2025-11-26 07:17:46.009269+00	
00000000-0000-0000-0000-000000000000	20c7b0c8-1bfe-4c3a-afd6-1c68914783fc	{"action":"login","actor_id":"4398b7ca-ef2c-4b26-b426-d69340b4c15c","actor_name":"FC","actor_username":"fc13303752056@163.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-11-26 07:17:49.622396+00	
00000000-0000-0000-0000-000000000000	4159dd87-1c5e-4c58-9506-5f1bb147e1a1	{"action":"logout","actor_id":"bcdaa16c-9e2d-41da-8d71-992255b8d8f9","actor_name":"孙天澍","actor_username":"userr8_1111@outlook.com","actor_via_sso":false,"log_type":"account"}	2025-12-07 02:00:53.756598+00	
00000000-0000-0000-0000-000000000000	fd053777-d2b7-46b7-91c8-2ad07e65b39f	{"action":"login","actor_id":"4398b7ca-ef2c-4b26-b426-d69340b4c15c","actor_name":"FC","actor_username":"fc13303752056@163.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-11-26 08:03:49.731531+00	
00000000-0000-0000-0000-000000000000	82a62553-5283-40e3-8ea6-f3d9ccec7f3f	{"action":"logout","actor_id":"4398b7ca-ef2c-4b26-b426-d69340b4c15c","actor_name":"FC","actor_username":"fc13303752056@163.com","actor_via_sso":false,"log_type":"account"}	2025-11-26 08:25:53.144631+00	
00000000-0000-0000-0000-000000000000	311e4378-ad9c-454f-acf6-82f67ec150d0	{"action":"login","actor_id":"fdb2e0d6-01ca-422a-84bb-ed841c9480e6","actor_name":"FC","actor_username":"2994390156@qq.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-11-26 08:25:56.875117+00	
00000000-0000-0000-0000-000000000000	c51d0533-661b-4804-834b-5655afe05998	{"action":"logout","actor_id":"fdb2e0d6-01ca-422a-84bb-ed841c9480e6","actor_name":"FC","actor_username":"2994390156@qq.com","actor_via_sso":false,"log_type":"account"}	2025-11-26 08:31:31.735643+00	
00000000-0000-0000-0000-000000000000	3c53674c-23ae-4017-b57f-9db117cc3c39	{"action":"login","actor_id":"4398b7ca-ef2c-4b26-b426-d69340b4c15c","actor_name":"FC","actor_username":"fc13303752056@163.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-11-26 08:31:34.768888+00	
00000000-0000-0000-0000-000000000000	d1cc7db2-504d-40c2-a40b-a3add3f72d2c	{"action":"logout","actor_id":"f64611ca-6a4d-42dd-ac81-c2c91b190dd0","actor_name":"andy","actor_username":"yizheng@ds.com","actor_via_sso":false,"log_type":"account"}	2025-11-26 08:54:12.302714+00	
00000000-0000-0000-0000-000000000000	f7ce22f6-5542-4a87-bea2-79796eaac82b	{"action":"login","actor_id":"f64611ca-6a4d-42dd-ac81-c2c91b190dd0","actor_name":"andy","actor_username":"yizheng@ds.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-11-26 08:54:19.413444+00	
00000000-0000-0000-0000-000000000000	32c44ca5-3ac7-450b-bcf6-75c1d049d444	{"action":"logout","actor_id":"f64611ca-6a4d-42dd-ac81-c2c91b190dd0","actor_name":"andy","actor_username":"yizheng@ds.com","actor_via_sso":false,"log_type":"account"}	2025-11-28 05:51:37.535149+00	
00000000-0000-0000-0000-000000000000	938d1b4b-a986-49ad-ae87-4750d62f345d	{"action":"login","actor_id":"0399fa1a-4045-425b-b514-dfd8fb44f233","actor_name":"朱伟章Allen","actor_username":"wadezhuhk@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-11-28 05:51:43.392899+00	
00000000-0000-0000-0000-000000000000	329f5fe2-6274-442a-ae07-5bd17d16d39c	{"action":"logout","actor_id":"0399fa1a-4045-425b-b514-dfd8fb44f233","actor_name":"朱伟章Allen","actor_username":"wadezhuhk@gmail.com","actor_via_sso":false,"log_type":"account"}	2025-11-28 06:42:09.225995+00	
00000000-0000-0000-0000-000000000000	42a06eb3-f737-488d-9e15-7fd22e5c1f40	{"action":"login","actor_id":"f64611ca-6a4d-42dd-ac81-c2c91b190dd0","actor_name":"andy","actor_username":"yizheng@ds.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-11-28 06:45:47.370891+00	
00000000-0000-0000-0000-000000000000	9e70cbf3-5aa7-4028-8365-92ed64a74eb6	{"action":"logout","actor_id":"f64611ca-6a4d-42dd-ac81-c2c91b190dd0","actor_name":"andy","actor_username":"yizheng@ds.com","actor_via_sso":false,"log_type":"account"}	2025-11-28 06:46:13.919621+00	
00000000-0000-0000-0000-000000000000	171c11cb-27da-4dec-a275-4868c13c1107	{"action":"login","actor_id":"525d29ed-3bcf-41f4-9d81-f3ab5f038122","actor_name":"Bob","actor_username":"yizheng@b.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-11-28 06:46:25.386529+00	
00000000-0000-0000-0000-000000000000	dd31a4b6-f2ad-4b98-9b8e-d4f5305127f2	{"action":"logout","actor_id":"525d29ed-3bcf-41f4-9d81-f3ab5f038122","actor_name":"Bob","actor_username":"yizheng@b.com","actor_via_sso":false,"log_type":"account"}	2025-11-28 09:18:29.336807+00	
00000000-0000-0000-0000-000000000000	6a757a59-693f-46cd-a18e-f022039b17e6	{"action":"login","actor_id":"f64611ca-6a4d-42dd-ac81-c2c91b190dd0","actor_name":"andy","actor_username":"yizheng@ds.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-11-28 09:18:38.25931+00	
00000000-0000-0000-0000-000000000000	7f8fe5be-7422-45c8-b389-1442761f515b	{"action":"logout","actor_id":"f64611ca-6a4d-42dd-ac81-c2c91b190dd0","actor_name":"andy","actor_username":"yizheng@ds.com","actor_via_sso":false,"log_type":"account"}	2025-11-28 09:19:14.161562+00	
00000000-0000-0000-0000-000000000000	a8bde4bb-9754-4bfc-a4a3-74313271b849	{"action":"login","actor_id":"525d29ed-3bcf-41f4-9d81-f3ab5f038122","actor_name":"Bob","actor_username":"yizheng@b.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-11-28 09:19:19.934711+00	
00000000-0000-0000-0000-000000000000	a2b7bb43-9227-4b16-bf49-c3511b11b256	{"action":"logout","actor_id":"525d29ed-3bcf-41f4-9d81-f3ab5f038122","actor_name":"Bob","actor_username":"yizheng@b.com","actor_via_sso":false,"log_type":"account"}	2025-11-28 09:21:06.781152+00	
00000000-0000-0000-0000-000000000000	4c9bb890-5928-4b7e-b0b2-90da580ca49c	{"action":"login","actor_id":"f64611ca-6a4d-42dd-ac81-c2c91b190dd0","actor_name":"andy","actor_username":"yizheng@ds.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-11-28 09:21:12.71206+00	
00000000-0000-0000-0000-000000000000	a7e6d0cd-666f-4bcd-8945-65d4b7d57eef	{"action":"logout","actor_id":"f64611ca-6a4d-42dd-ac81-c2c91b190dd0","actor_name":"andy","actor_username":"yizheng@ds.com","actor_via_sso":false,"log_type":"account"}	2025-11-28 09:21:45.819208+00	
00000000-0000-0000-0000-000000000000	cf281704-268e-4e66-8e00-ae900b68601b	{"action":"login","actor_id":"525d29ed-3bcf-41f4-9d81-f3ab5f038122","actor_name":"Bob","actor_username":"yizheng@b.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-11-28 09:21:54.701204+00	
00000000-0000-0000-0000-000000000000	ff85dda5-d143-4233-8f39-3d24ad2ce3eb	{"action":"logout","actor_id":"525d29ed-3bcf-41f4-9d81-f3ab5f038122","actor_name":"Bob","actor_username":"yizheng@b.com","actor_via_sso":false,"log_type":"account"}	2025-11-28 09:23:40.048315+00	
00000000-0000-0000-0000-000000000000	68a4050f-fed2-4b2c-8b25-e5eec9a29507	{"action":"login","actor_id":"f64611ca-6a4d-42dd-ac81-c2c91b190dd0","actor_name":"andy","actor_username":"yizheng@ds.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-11-28 09:23:45.750228+00	
00000000-0000-0000-0000-000000000000	5b1ffa6e-1dda-4b10-a33d-2d47a83ba117	{"action":"logout","actor_id":"f64611ca-6a4d-42dd-ac81-c2c91b190dd0","actor_name":"andy","actor_username":"yizheng@ds.com","actor_via_sso":false,"log_type":"account"}	2025-11-28 09:24:12.158336+00	
00000000-0000-0000-0000-000000000000	a6fe4950-5109-42ff-9334-ac7d9b8cc5e6	{"action":"login","actor_id":"525d29ed-3bcf-41f4-9d81-f3ab5f038122","actor_name":"Bob","actor_username":"yizheng@b.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-11-28 09:24:18.218956+00	
00000000-0000-0000-0000-000000000000	7676bc55-1291-4907-92d5-5cacac9cba26	{"action":"logout","actor_id":"525d29ed-3bcf-41f4-9d81-f3ab5f038122","actor_name":"Bob","actor_username":"yizheng@b.com","actor_via_sso":false,"log_type":"account"}	2025-11-28 09:24:57.18628+00	
00000000-0000-0000-0000-000000000000	466c34e9-8030-46a5-8b78-0307f72febac	{"action":"login","actor_id":"f64611ca-6a4d-42dd-ac81-c2c91b190dd0","actor_name":"andy","actor_username":"yizheng@ds.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-11-28 09:25:04.702112+00	
00000000-0000-0000-0000-000000000000	295de3cd-3ec7-469e-95c3-19d67b58680d	{"action":"logout","actor_id":"f64611ca-6a4d-42dd-ac81-c2c91b190dd0","actor_name":"andy","actor_username":"yizheng@ds.com","actor_via_sso":false,"log_type":"account"}	2025-11-29 22:58:40.085299+00	
00000000-0000-0000-0000-000000000000	c1f6b571-e5f5-4cb8-b102-ef7315bd03fc	{"action":"login","actor_id":"0399fa1a-4045-425b-b514-dfd8fb44f233","actor_name":"朱伟章Allen","actor_username":"wadezhuhk@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-11-29 22:58:46.494726+00	
00000000-0000-0000-0000-000000000000	951abbe5-df94-4e61-a1ab-87a5fefaf02c	{"action":"logout","actor_id":"0399fa1a-4045-425b-b514-dfd8fb44f233","actor_name":"朱伟章Allen","actor_username":"wadezhuhk@gmail.com","actor_via_sso":false,"log_type":"account"}	2025-11-29 22:59:02.436396+00	
00000000-0000-0000-0000-000000000000	a74486ab-764b-4af9-ae07-5745bb44a32e	{"action":"login","actor_id":"f64611ca-6a4d-42dd-ac81-c2c91b190dd0","actor_name":"andy","actor_username":"yizheng@ds.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-11-29 23:07:06.939316+00	
00000000-0000-0000-0000-000000000000	f42a13c4-81d2-4305-8d35-3467630bea76	{"action":"logout","actor_id":"f64611ca-6a4d-42dd-ac81-c2c91b190dd0","actor_name":"andy","actor_username":"yizheng@ds.com","actor_via_sso":false,"log_type":"account"}	2025-11-29 23:07:22.897757+00	
00000000-0000-0000-0000-000000000000	20ae5aca-52a3-452f-8cf5-92c0d6f4f4b2	{"action":"login","actor_id":"525d29ed-3bcf-41f4-9d81-f3ab5f038122","actor_name":"Bob","actor_username":"yizheng@b.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-11-30 01:36:50.333501+00	
00000000-0000-0000-0000-000000000000	7a11622f-9bd5-4364-8f5d-a8f57b037278	{"action":"login","actor_id":"0399fa1a-4045-425b-b514-dfd8fb44f233","actor_name":"朱伟章Allen","actor_username":"wadezhuhk@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-11-30 08:28:04.374572+00	
00000000-0000-0000-0000-000000000000	aa0c81eb-bc4c-4ecf-ae52-1a441f2e1c0e	{"action":"logout","actor_id":"4398b7ca-ef2c-4b26-b426-d69340b4c15c","actor_name":"FC","actor_username":"fc13303752056@163.com","actor_via_sso":false,"log_type":"account"}	2025-12-01 03:07:48.385283+00	
00000000-0000-0000-0000-000000000000	3b8e99e3-c538-494c-b896-b5c7745bb84d	{"action":"login","actor_id":"fdb2e0d6-01ca-422a-84bb-ed841c9480e6","actor_name":"FC","actor_username":"2994390156@qq.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-12-01 03:07:51.293271+00	
00000000-0000-0000-0000-000000000000	fe5d7c3d-367a-406e-b7f5-caf736d99170	{"action":"logout","actor_id":"fdb2e0d6-01ca-422a-84bb-ed841c9480e6","actor_name":"FC","actor_username":"2994390156@qq.com","actor_via_sso":false,"log_type":"account"}	2025-12-01 03:16:25.905777+00	
00000000-0000-0000-0000-000000000000	43ba4012-7da8-4a29-b615-e20dd400bfc9	{"action":"login","actor_id":"4398b7ca-ef2c-4b26-b426-d69340b4c15c","actor_name":"FC","actor_username":"fc13303752056@163.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-12-01 03:16:28.946455+00	
00000000-0000-0000-0000-000000000000	83d7af50-2fa8-48b4-88cc-247272b2ccba	{"action":"logout","actor_id":"4398b7ca-ef2c-4b26-b426-d69340b4c15c","actor_name":"FC","actor_username":"fc13303752056@163.com","actor_via_sso":false,"log_type":"account"}	2025-12-01 03:23:03.456756+00	
00000000-0000-0000-0000-000000000000	34fdd0fa-7272-4398-848c-670d82c4f830	{"action":"login","actor_id":"fdb2e0d6-01ca-422a-84bb-ed841c9480e6","actor_name":"FC","actor_username":"2994390156@qq.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-12-01 03:24:45.554545+00	
00000000-0000-0000-0000-000000000000	34297d8c-fa37-4a7c-8b8e-141e28436453	{"action":"logout","actor_id":"fdb2e0d6-01ca-422a-84bb-ed841c9480e6","actor_name":"FC","actor_username":"2994390156@qq.com","actor_via_sso":false,"log_type":"account"}	2025-12-01 03:25:34.75281+00	
00000000-0000-0000-0000-000000000000	892d7cf5-7e1a-47cf-b67a-7b83c9e7faf0	{"action":"login","actor_id":"4398b7ca-ef2c-4b26-b426-d69340b4c15c","actor_name":"FC","actor_username":"fc13303752056@163.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-12-01 03:25:38.112978+00	
00000000-0000-0000-0000-000000000000	02959e3a-2263-4304-9993-407285286948	{"action":"logout","actor_id":"525d29ed-3bcf-41f4-9d81-f3ab5f038122","actor_name":"Bob","actor_username":"yizheng@b.com","actor_via_sso":false,"log_type":"account"}	2025-12-01 21:24:53.992703+00	
00000000-0000-0000-0000-000000000000	01ac0245-f3f6-43cc-916b-66809df0fbb2	{"action":"login","actor_id":"f64611ca-6a4d-42dd-ac81-c2c91b190dd0","actor_name":"andy","actor_username":"yizheng@ds.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-12-01 21:25:04.194507+00	
00000000-0000-0000-0000-000000000000	336f6b80-89cb-44d7-819a-6a403388bbcc	{"action":"logout","actor_id":"f64611ca-6a4d-42dd-ac81-c2c91b190dd0","actor_name":"andy","actor_username":"yizheng@ds.com","actor_via_sso":false,"log_type":"account"}	2025-12-01 22:58:06.266154+00	
00000000-0000-0000-0000-000000000000	6aa929ab-3cab-4fc1-a34c-239491d1b8f2	{"action":"login","actor_id":"0399fa1a-4045-425b-b514-dfd8fb44f233","actor_name":"朱伟章Allen","actor_username":"wadezhuhk@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-12-01 22:58:12.21273+00	
00000000-0000-0000-0000-000000000000	212296c7-c614-4d9f-af48-8376b87cdd0b	{"action":"logout","actor_id":"0399fa1a-4045-425b-b514-dfd8fb44f233","actor_name":"朱伟章Allen","actor_username":"wadezhuhk@gmail.com","actor_via_sso":false,"log_type":"account"}	2025-12-02 00:04:56.187107+00	
00000000-0000-0000-0000-000000000000	d7a9734e-0308-4ea5-a851-d00daf32220b	{"action":"login","actor_id":"f64611ca-6a4d-42dd-ac81-c2c91b190dd0","actor_name":"andy","actor_username":"yizheng@ds.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-12-02 00:05:02.557719+00	
00000000-0000-0000-0000-000000000000	7fb22da4-ce24-45d8-9de0-405e3f290279	{"action":"logout","actor_id":"4398b7ca-ef2c-4b26-b426-d69340b4c15c","actor_name":"FC","actor_username":"fc13303752056@163.com","actor_via_sso":false,"log_type":"account"}	2025-12-02 06:35:07.615091+00	
00000000-0000-0000-0000-000000000000	fdffb566-9880-4a24-9577-1fcb636788dc	{"action":"login","actor_id":"fdb2e0d6-01ca-422a-84bb-ed841c9480e6","actor_name":"FC","actor_username":"2994390156@qq.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-12-02 06:35:11.55638+00	
00000000-0000-0000-0000-000000000000	ba515101-74dd-49a3-b258-36df8f813677	{"action":"logout","actor_id":"fdb2e0d6-01ca-422a-84bb-ed841c9480e6","actor_name":"FC","actor_username":"2994390156@qq.com","actor_via_sso":false,"log_type":"account"}	2025-12-02 06:42:22.10904+00	
00000000-0000-0000-0000-000000000000	286128b8-a06a-4cd3-a3dd-926c25177365	{"action":"login","actor_id":"4398b7ca-ef2c-4b26-b426-d69340b4c15c","actor_name":"FC","actor_username":"fc13303752056@163.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-12-02 06:42:25.939149+00	
00000000-0000-0000-0000-000000000000	1f6f273a-b3ff-409b-a1a6-c7420a79b63c	{"action":"logout","actor_id":"4398b7ca-ef2c-4b26-b426-d69340b4c15c","actor_name":"FC","actor_username":"fc13303752056@163.com","actor_via_sso":false,"log_type":"account"}	2025-12-02 07:05:29.73502+00	
00000000-0000-0000-0000-000000000000	76b1884e-7013-4025-a282-1d25ad7106a2	{"action":"login","actor_id":"fdb2e0d6-01ca-422a-84bb-ed841c9480e6","actor_name":"FC","actor_username":"2994390156@qq.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-12-02 07:05:32.769829+00	
00000000-0000-0000-0000-000000000000	5a0e1c4f-04ac-4240-b336-c08f0326aba1	{"action":"logout","actor_id":"fdb2e0d6-01ca-422a-84bb-ed841c9480e6","actor_name":"FC","actor_username":"2994390156@qq.com","actor_via_sso":false,"log_type":"account"}	2025-12-02 07:09:25.280306+00	
00000000-0000-0000-0000-000000000000	92ed3404-eef2-4c3b-bebc-ca7f0eba9af2	{"action":"login","actor_id":"4398b7ca-ef2c-4b26-b426-d69340b4c15c","actor_name":"FC","actor_username":"fc13303752056@163.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-12-02 07:09:50.830128+00	
00000000-0000-0000-0000-000000000000	03b0f3fe-b17f-4fde-b03c-fd500b6d83a4	{"action":"logout","actor_id":"4398b7ca-ef2c-4b26-b426-d69340b4c15c","actor_name":"FC","actor_username":"fc13303752056@163.com","actor_via_sso":false,"log_type":"account"}	2025-12-02 09:57:32.495507+00	
00000000-0000-0000-0000-000000000000	5539c42e-76d9-448e-8720-08b0b2a85371	{"action":"login","actor_id":"fdb2e0d6-01ca-422a-84bb-ed841c9480e6","actor_name":"FC","actor_username":"2994390156@qq.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-12-02 09:57:36.662862+00	
00000000-0000-0000-0000-000000000000	f71c48e4-94d0-4751-8ffe-79b9e6cd84d4	{"action":"logout","actor_id":"f64611ca-6a4d-42dd-ac81-c2c91b190dd0","actor_name":"andy","actor_username":"yizheng@ds.com","actor_via_sso":false,"log_type":"account"}	2025-12-04 01:17:22.887156+00	
00000000-0000-0000-0000-000000000000	5c6b1d6f-6d1e-49e0-b3bc-1343cc90aafe	{"action":"login","actor_id":"0399fa1a-4045-425b-b514-dfd8fb44f233","actor_name":"朱伟章Allen","actor_username":"wadezhuhk@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-12-04 01:17:32.786871+00	
00000000-0000-0000-0000-000000000000	a8d29292-d8e6-4aa9-9b73-5551aafd8058	{"action":"login","actor_id":"0399fa1a-4045-425b-b514-dfd8fb44f233","actor_name":"朱伟章Allen","actor_username":"wadezhuhk@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-12-04 01:21:47.592011+00	
00000000-0000-0000-0000-000000000000	4a239b3c-fdfd-4433-9604-e800c7f9a5b3	{"action":"logout","actor_id":"fdb2e0d6-01ca-422a-84bb-ed841c9480e6","actor_name":"FC","actor_username":"2994390156@qq.com","actor_via_sso":false,"log_type":"account"}	2025-12-04 02:26:39.97746+00	
00000000-0000-0000-0000-000000000000	2c43b0db-46e9-4004-b268-a311c60ea295	{"action":"login","actor_id":"4398b7ca-ef2c-4b26-b426-d69340b4c15c","actor_name":"FC","actor_username":"fc13303752056@163.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-12-04 02:34:59.881584+00	
00000000-0000-0000-0000-000000000000	f8a1354d-63a9-45c9-9396-89cca7818dad	{"action":"login","actor_id":"0399fa1a-4045-425b-b514-dfd8fb44f233","actor_name":"朱伟章Allen","actor_username":"wadezhuhk@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-12-04 07:47:20.981951+00	
00000000-0000-0000-0000-000000000000	dbc48684-ccd8-47e2-b4b9-b1a4805e7b51	{"action":"login","actor_id":"0399fa1a-4045-425b-b514-dfd8fb44f233","actor_name":"朱伟章Allen","actor_username":"wadezhuhk@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-12-04 07:57:22.112608+00	
00000000-0000-0000-0000-000000000000	72a061a5-0790-40d3-9c4a-52e5790dd1e4	{"action":"user_signedup","actor_id":"1608ba80-8e25-4424-b7ad-5fecacedf81d","actor_name":"曾思棚","actor_username":"userr1_4940@163.com","actor_via_sso":false,"log_type":"team","traits":{"provider":"email"}}	2025-12-04 08:37:46.372291+00	
00000000-0000-0000-0000-000000000000	b8f7590d-d4b3-492e-b5aa-fa04bbe361c7	{"action":"login","actor_id":"1608ba80-8e25-4424-b7ad-5fecacedf81d","actor_name":"曾思棚","actor_username":"userr1_4940@163.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-12-04 08:37:46.386593+00	
00000000-0000-0000-0000-000000000000	a4fe1d23-7c6f-4b4a-bb82-aa9a06a1e9f2	{"action":"user_signedup","actor_id":"01941460-10a5-4fd1-87f3-8d19625e4f04","actor_name":"lzx","actor_username":"userr2_7026@163.com","actor_via_sso":false,"log_type":"team","traits":{"provider":"email"}}	2025-12-04 08:39:28.964445+00	
00000000-0000-0000-0000-000000000000	3a531532-e234-43cc-817e-bff3014cb988	{"action":"login","actor_id":"01941460-10a5-4fd1-87f3-8d19625e4f04","actor_name":"lzx","actor_username":"userr2_7026@163.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-12-04 08:39:28.978206+00	
00000000-0000-0000-0000-000000000000	a2f8efe7-e2f7-4c74-8c8f-0eb6c9bb79dc	{"action":"logout","actor_id":"4398b7ca-ef2c-4b26-b426-d69340b4c15c","actor_name":"FC","actor_username":"fc13303752056@163.com","actor_via_sso":false,"log_type":"account"}	2025-12-04 11:37:38.596151+00	
00000000-0000-0000-0000-000000000000	5693981c-1157-416c-b1cb-56cb7c699f40	{"action":"login","actor_id":"4398b7ca-ef2c-4b26-b426-d69340b4c15c","actor_name":"FC","actor_username":"fc13303752056@163.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-12-04 11:40:43.800374+00	
00000000-0000-0000-0000-000000000000	d024e168-469c-4c5c-941c-3630023fcef2	{"action":"logout","actor_id":"4398b7ca-ef2c-4b26-b426-d69340b4c15c","actor_name":"FC","actor_username":"fc13303752056@163.com","actor_via_sso":false,"log_type":"account"}	2025-12-04 11:42:42.197261+00	
00000000-0000-0000-0000-000000000000	2905ab77-9f82-40be-98f9-326576d7fd0d	{"action":"login","actor_id":"4398b7ca-ef2c-4b26-b426-d69340b4c15c","actor_name":"FC","actor_username":"fc13303752056@163.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-12-04 11:43:17.741466+00	
00000000-0000-0000-0000-000000000000	31ec14cf-e36c-4090-bd08-99d58250a3c6	{"action":"logout","actor_id":"4398b7ca-ef2c-4b26-b426-d69340b4c15c","actor_name":"FC","actor_username":"fc13303752056@163.com","actor_via_sso":false,"log_type":"account"}	2025-12-04 11:50:05.416315+00	
00000000-0000-0000-0000-000000000000	8b464aa0-3f09-4582-b37c-69c5a2f478d9	{"action":"login","actor_id":"4398b7ca-ef2c-4b26-b426-d69340b4c15c","actor_name":"FC","actor_username":"fc13303752056@163.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-12-04 11:50:33.4022+00	
00000000-0000-0000-0000-000000000000	7ac5bde1-159b-496b-b2f4-7b4d33112b82	{"action":"logout","actor_id":"4398b7ca-ef2c-4b26-b426-d69340b4c15c","actor_name":"FC","actor_username":"fc13303752056@163.com","actor_via_sso":false,"log_type":"account"}	2025-12-04 11:55:07.775802+00	
00000000-0000-0000-0000-000000000000	a6a2bb09-04ef-469f-8a43-795e7ed62ae9	{"action":"login","actor_id":"4398b7ca-ef2c-4b26-b426-d69340b4c15c","actor_name":"FC","actor_username":"fc13303752056@163.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-12-04 11:55:31.104427+00	
00000000-0000-0000-0000-000000000000	2ec13f74-4a8d-47b1-9ae4-ff3e7dc22b5e	{"action":"logout","actor_id":"4398b7ca-ef2c-4b26-b426-d69340b4c15c","actor_name":"FC","actor_username":"fc13303752056@163.com","actor_via_sso":false,"log_type":"account"}	2025-12-05 02:43:43.064301+00	
00000000-0000-0000-0000-000000000000	180b803d-5c41-450f-b754-10a84245d485	{"action":"login","actor_id":"4398b7ca-ef2c-4b26-b426-d69340b4c15c","actor_name":"FC","actor_username":"fc13303752056@163.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-12-05 02:45:01.487457+00	
00000000-0000-0000-0000-000000000000	3db120ad-dd32-465b-8c30-a0753ab187ff	{"action":"logout","actor_id":"4398b7ca-ef2c-4b26-b426-d69340b4c15c","actor_name":"FC","actor_username":"fc13303752056@163.com","actor_via_sso":false,"log_type":"account"}	2025-12-05 02:53:44.045431+00	
00000000-0000-0000-0000-000000000000	4b3b83d6-8863-4325-a2e1-a66d29360174	{"action":"login","actor_id":"4398b7ca-ef2c-4b26-b426-d69340b4c15c","actor_name":"FC","actor_username":"fc13303752056@163.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-12-05 02:55:12.375217+00	
00000000-0000-0000-0000-000000000000	22426088-24b4-4bce-92a9-969d7b7b409c	{"action":"logout","actor_id":"0399fa1a-4045-425b-b514-dfd8fb44f233","actor_name":"朱伟章Allen","actor_username":"wadezhuhk@gmail.com","actor_via_sso":false,"log_type":"account"}	2025-12-05 07:23:37.153935+00	
00000000-0000-0000-0000-000000000000	a228d325-7c46-4d31-9402-0ef7ca8ca01e	{"action":"login","actor_id":"6cdba011-5883-4b7d-89f4-ea9a1bcacc55","actor_name":"wade_test_1","actor_username":"wadezhuhk_test_1@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-12-05 07:23:58.107341+00	
00000000-0000-0000-0000-000000000000	1f0ba0d2-e514-429e-8aea-8d3209daca45	{"action":"user_signedup","actor_id":"4e14ad80-ed09-4db5-9add-fbba2ce1004b","actor_name":"Allen Zhu","actor_username":"wadezhuhk3@gmail.com","actor_via_sso":false,"log_type":"team","traits":{"provider":"email"}}	2025-12-05 09:16:23.801756+00	
00000000-0000-0000-0000-000000000000	441065d1-9bd1-43c1-8eee-059a5d013ea7	{"action":"login","actor_id":"4e14ad80-ed09-4db5-9add-fbba2ce1004b","actor_name":"Allen Zhu","actor_username":"wadezhuhk3@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-12-05 09:16:23.815967+00	
00000000-0000-0000-0000-000000000000	b6fb8c2b-0662-4174-bdf2-7455008013b1	{"action":"logout","actor_id":"4e14ad80-ed09-4db5-9add-fbba2ce1004b","actor_name":"Allen Zhu","actor_username":"wadezhuhk3@gmail.com","actor_via_sso":false,"log_type":"account"}	2025-12-05 09:16:42.013819+00	
00000000-0000-0000-0000-000000000000	321824fe-e220-4d71-bbf8-700bdf452e99	{"action":"login","actor_id":"0399fa1a-4045-425b-b514-dfd8fb44f233","actor_name":"朱伟章Allen","actor_username":"wadezhuhk@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-12-05 09:17:10.751959+00	
00000000-0000-0000-0000-000000000000	c3ca5ad2-f5ea-476a-a994-5e3bad8cc4bd	{"action":"logout","actor_id":"4398b7ca-ef2c-4b26-b426-d69340b4c15c","actor_name":"FC","actor_username":"fc13303752056@163.com","actor_via_sso":false,"log_type":"account"}	2025-12-05 10:59:52.597319+00	
00000000-0000-0000-0000-000000000000	bbf9a042-58fe-400a-9f6f-40a53da73f27	{"action":"user_signedup","actor_id":"a50e4c18-7e6f-46a5-b8e5-7d4a4db179bb","actor_name":"袁僮璐","actor_username":"userr4_8070@foxmail.com","actor_via_sso":false,"log_type":"team","traits":{"provider":"email"}}	2025-12-05 11:00:24.42629+00	
00000000-0000-0000-0000-000000000000	d73d532c-6fbd-4f59-ab17-9ebde8fc66f4	{"action":"login","actor_id":"a50e4c18-7e6f-46a5-b8e5-7d4a4db179bb","actor_name":"袁僮璐","actor_username":"userr4_8070@foxmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-12-05 11:00:24.438593+00	
00000000-0000-0000-0000-000000000000	a440fe9e-3a1b-4f28-b80e-c4c14595ab1b	{"action":"logout","actor_id":"a50e4c18-7e6f-46a5-b8e5-7d4a4db179bb","actor_name":"袁僮璐","actor_username":"userr4_8070@foxmail.com","actor_via_sso":false,"log_type":"account"}	2025-12-05 11:00:34.624489+00	
00000000-0000-0000-0000-000000000000	a40a6522-dfdd-4d57-ab8b-6c7191dcc750	{"action":"login","actor_id":"a50e4c18-7e6f-46a5-b8e5-7d4a4db179bb","actor_name":"袁僮璐","actor_username":"userr4_8070@foxmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-12-05 11:04:58.773111+00	
00000000-0000-0000-0000-000000000000	216371ed-6891-44f9-8fa3-a1c23fabea72	{"action":"logout","actor_id":"6cdba011-5883-4b7d-89f4-ea9a1bcacc55","actor_name":"wade_test_1","actor_username":"wadezhuhk_test_1@gmail.com","actor_via_sso":false,"log_type":"account"}	2025-12-05 11:25:31.831613+00	
00000000-0000-0000-0000-000000000000	82788df8-c274-40f6-aa6e-4d0610b34102	{"action":"login","actor_id":"5acbb4bd-563e-4a64-a674-edda518cfaf0","actor_name":"wadezhuhk_test_3","actor_username":"wadezhuhk_test_3@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-12-05 11:27:36.191891+00	
00000000-0000-0000-0000-000000000000	d0de414b-008d-4915-8278-647fdb04c897	{"action":"logout","actor_id":"5acbb4bd-563e-4a64-a674-edda518cfaf0","actor_name":"wadezhuhk_test_3","actor_username":"wadezhuhk_test_3@gmail.com","actor_via_sso":false,"log_type":"account"}	2025-12-06 12:36:45.387554+00	
00000000-0000-0000-0000-000000000000	7d7c5ec0-a864-4b7f-b9cf-60f511a8ab4a	{"action":"login","actor_id":"0399fa1a-4045-425b-b514-dfd8fb44f233","actor_name":"朱伟章Allen","actor_username":"wadezhuhk@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-12-06 12:36:47.419739+00	
00000000-0000-0000-0000-000000000000	ca4e6fa9-a63f-4735-b2ba-b64d490706a4	{"action":"user_repeated_signup","actor_id":"4e14ad80-ed09-4db5-9add-fbba2ce1004b","actor_name":"Allen Zhu","actor_username":"wadezhuhk3@gmail.com","actor_via_sso":false,"log_type":"user","traits":{"provider":"email"}}	2025-12-06 12:37:38.915071+00	
00000000-0000-0000-0000-000000000000	2c81bba7-02d2-4525-b784-834cce00c783	{"action":"user_repeated_signup","actor_id":"4e14ad80-ed09-4db5-9add-fbba2ce1004b","actor_name":"Allen Zhu","actor_username":"wadezhuhk3@gmail.com","actor_via_sso":false,"log_type":"user","traits":{"provider":"email"}}	2025-12-06 12:37:44.939418+00	
00000000-0000-0000-0000-000000000000	6d23be23-1bf9-46f5-be8e-7c4212e33abf	{"action":"user_signedup","actor_id":"83cf7ae9-fd96-426c-9e26-effd554cc8c9","actor_name":"Wade Zhu","actor_username":"819028551@qq.com","actor_via_sso":false,"log_type":"team","traits":{"provider":"email"}}	2025-12-06 12:37:58.917158+00	
00000000-0000-0000-0000-000000000000	d3bbde11-d68c-4019-9636-9c50ea54fc3f	{"action":"login","actor_id":"83cf7ae9-fd96-426c-9e26-effd554cc8c9","actor_name":"Wade Zhu","actor_username":"819028551@qq.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-12-06 12:37:58.929344+00	
00000000-0000-0000-0000-000000000000	27c84804-38d1-4993-8698-a541ab18b97d	{"action":"logout","actor_id":"83cf7ae9-fd96-426c-9e26-effd554cc8c9","actor_name":"Wade Zhu","actor_username":"819028551@qq.com","actor_via_sso":false,"log_type":"account"}	2025-12-06 12:38:04.74947+00	
00000000-0000-0000-0000-000000000000	99c73cf9-2fe6-4869-a586-5dbafed6d792	{"action":"login","actor_id":"83cf7ae9-fd96-426c-9e26-effd554cc8c9","actor_name":"Wade Zhu","actor_username":"819028551@qq.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-12-06 12:38:24.762361+00	
00000000-0000-0000-0000-000000000000	f4157a29-b603-423e-826d-80008c85949a	{"action":"logout","actor_id":"83cf7ae9-fd96-426c-9e26-effd554cc8c9","actor_name":"Wade Zhu","actor_username":"819028551@qq.com","actor_via_sso":false,"log_type":"account"}	2025-12-06 14:48:16.301381+00	
00000000-0000-0000-0000-000000000000	36a472f7-7912-4688-9e25-e4ec21dc16b1	{"action":"login","actor_id":"ce008f4b-dfe9-4301-a844-fe7d337dd1c5","actor_name":"wadezhuhk_test_2","actor_username":"wadezhuhk_test_2@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-12-06 14:48:26.596618+00	
00000000-0000-0000-0000-000000000000	4a2724b4-db59-4a43-9bbf-d1378c0ce3f4	{"action":"logout","actor_id":"ce008f4b-dfe9-4301-a844-fe7d337dd1c5","actor_name":"wadezhuhk_test_2","actor_username":"wadezhuhk_test_2@gmail.com","actor_via_sso":false,"log_type":"account"}	2025-12-06 14:49:13.373777+00	
00000000-0000-0000-0000-000000000000	2ff50f7a-9e56-4e71-8bbd-b5833bcff7b3	{"action":"login","actor_id":"f5f0f0a1-0672-4673-ae01-cdd187fcc4cd","actor_name":"wadezhuhk_test_5","actor_username":"wadezhuhk_test_5@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-12-06 14:49:23.551909+00	
00000000-0000-0000-0000-000000000000	776e04e1-e717-4ac6-bed0-f328a50289da	{"action":"logout","actor_id":"f5f0f0a1-0672-4673-ae01-cdd187fcc4cd","actor_name":"wadezhuhk_test_5","actor_username":"wadezhuhk_test_5@gmail.com","actor_via_sso":false,"log_type":"account"}	2025-12-06 15:11:48.874954+00	
00000000-0000-0000-0000-000000000000	92ba26fb-84c6-4dc5-ae20-7472b8f9d860	{"action":"login","actor_id":"0399fa1a-4045-425b-b514-dfd8fb44f233","actor_name":"朱伟章Allen","actor_username":"wadezhuhk@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-12-06 15:11:51.940806+00	
00000000-0000-0000-0000-000000000000	addfc4ee-26bf-40f9-80e7-90b3ae250fd5	{"action":"logout","actor_id":"0399fa1a-4045-425b-b514-dfd8fb44f233","actor_name":"朱伟章Allen","actor_username":"wadezhuhk@gmail.com","actor_via_sso":false,"log_type":"account"}	2025-12-06 15:12:41.538425+00	
00000000-0000-0000-0000-000000000000	4f1e2af0-3bb7-4cb7-a68c-2d2d4eed7bf9	{"action":"login","actor_id":"f5f0f0a1-0672-4673-ae01-cdd187fcc4cd","actor_name":"wadezhuhk_test_5","actor_username":"wadezhuhk_test_5@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-12-06 15:13:20.674068+00	
00000000-0000-0000-0000-000000000000	ec7c5793-8a0e-4f82-8fdf-28a5d2bd7162	{"action":"login","actor_id":"83cf7ae9-fd96-426c-9e26-effd554cc8c9","actor_name":"Wade Zhu","actor_username":"819028551@qq.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-12-06 15:13:50.925039+00	
00000000-0000-0000-0000-000000000000	364bff72-7a56-4e2b-bddd-44714eb7d2b9	{"action":"logout","actor_id":"f5f0f0a1-0672-4673-ae01-cdd187fcc4cd","actor_name":"wadezhuhk_test_5","actor_username":"wadezhuhk_test_5@gmail.com","actor_via_sso":false,"log_type":"account"}	2025-12-06 15:14:30.731367+00	
00000000-0000-0000-0000-000000000000	3dfee7ed-36df-4a19-b1ab-d190d87fca6d	{"action":"login","actor_id":"d35ed0e7-12b8-4f0d-9d72-e72125816810","actor_name":"wadezhuhk_test_4","actor_username":"wadezhuhk_test_4@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-12-06 15:14:39.802722+00	
00000000-0000-0000-0000-000000000000	771b7e37-86d7-4111-b7f1-c72560d2b8ba	{"action":"logout","actor_id":"d35ed0e7-12b8-4f0d-9d72-e72125816810","actor_name":"wadezhuhk_test_4","actor_username":"wadezhuhk_test_4@gmail.com","actor_via_sso":false,"log_type":"account"}	2025-12-06 15:16:21.082517+00	
00000000-0000-0000-0000-000000000000	d16f4cf9-adac-490b-ac9e-cbe940602459	{"action":"login","actor_id":"ce008f4b-dfe9-4301-a844-fe7d337dd1c5","actor_name":"wadezhuhk_test_2","actor_username":"wadezhuhk_test_2@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-12-06 15:16:26.374852+00	
00000000-0000-0000-0000-000000000000	0f0387c8-c8ca-443b-b155-e146336d0062	{"action":"user_signedup","actor_id":"bcdaa16c-9e2d-41da-8d71-992255b8d8f9","actor_name":"孙天澍","actor_username":"userr8_1111@outlook.com","actor_via_sso":false,"log_type":"team","traits":{"provider":"email"}}	2025-12-07 02:00:49.500388+00	
00000000-0000-0000-0000-000000000000	b6b75c8a-f54b-443f-99fc-324b63c811fa	{"action":"login","actor_id":"bcdaa16c-9e2d-41da-8d71-992255b8d8f9","actor_name":"孙天澍","actor_username":"userr8_1111@outlook.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-12-07 02:00:49.548906+00	
00000000-0000-0000-0000-000000000000	18c180eb-b8e2-4e7f-9c1a-87138ab85300	{"action":"user_signedup","actor_id":"fe96e8e5-9e67-4c02-9ff4-1ddcbbc4ee89","actor_name":"Frank.Li","actor_username":"userr9_1111@outlook.com","actor_via_sso":false,"log_type":"team","traits":{"provider":"email"}}	2025-12-07 02:27:24.388578+00	
00000000-0000-0000-0000-000000000000	1a86f707-8f54-494a-972d-ff37c296edb9	{"action":"login","actor_id":"fe96e8e5-9e67-4c02-9ff4-1ddcbbc4ee89","actor_name":"Frank.Li","actor_username":"userr9_1111@outlook.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-12-07 02:27:24.398652+00	
00000000-0000-0000-0000-000000000000	6a7bb293-810f-47dc-87e4-1e6f74828bad	{"action":"logout","actor_id":"fe96e8e5-9e67-4c02-9ff4-1ddcbbc4ee89","actor_name":"Frank.Li","actor_username":"userr9_1111@outlook.com","actor_via_sso":false,"log_type":"account"}	2025-12-07 02:38:08.266889+00	
00000000-0000-0000-0000-000000000000	eafb95d1-3bea-47c6-a85c-147a292cf4b9	{"action":"user_signedup","actor_id":"1a1b09cb-aa1b-4fb9-a83c-871eb9675be4","actor_name":"Gavin.Wang","actor_username":"userr10_1111@outlook.com","actor_via_sso":false,"log_type":"team","traits":{"provider":"email"}}	2025-12-07 02:38:54.498443+00	
00000000-0000-0000-0000-000000000000	652c5d89-dda0-4786-87bc-0f99d8f08492	{"action":"login","actor_id":"1a1b09cb-aa1b-4fb9-a83c-871eb9675be4","actor_name":"Gavin.Wang","actor_username":"userr10_1111@outlook.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-12-07 02:38:54.508684+00	
00000000-0000-0000-0000-000000000000	c65cddab-21c1-4f9d-85e9-e21e6bc798e9	{"action":"logout","actor_id":"1a1b09cb-aa1b-4fb9-a83c-871eb9675be4","actor_name":"Gavin.Wang","actor_username":"userr10_1111@outlook.com","actor_via_sso":false,"log_type":"account"}	2025-12-07 02:39:02.135721+00	
00000000-0000-0000-0000-000000000000	2179b332-1904-4d80-924e-35d802a2f9c5	{"action":"user_signedup","actor_id":"7867d1c5-9496-485c-bf4e-f5e80b3386d3","actor_name":"Wang.Jin","actor_username":"userr11_1111@outlook.com","actor_via_sso":false,"log_type":"team","traits":{"provider":"email"}}	2025-12-07 02:39:26.902111+00	
00000000-0000-0000-0000-000000000000	f00ed776-9b39-436c-9c90-0430c450ffc7	{"action":"login","actor_id":"7867d1c5-9496-485c-bf4e-f5e80b3386d3","actor_name":"Wang.Jin","actor_username":"userr11_1111@outlook.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-12-07 02:39:26.91355+00	
00000000-0000-0000-0000-000000000000	210cd2cc-60d0-4cbc-9eaf-1b887a168bad	{"action":"logout","actor_id":"ce008f4b-dfe9-4301-a844-fe7d337dd1c5","actor_name":"wadezhuhk_test_2","actor_username":"wadezhuhk_test_2@gmail.com","actor_via_sso":false,"log_type":"account"}	2025-12-07 02:53:57.516094+00	
00000000-0000-0000-0000-000000000000	4af48f30-43a7-41ab-baf2-a7bf43652906	{"action":"login","actor_id":"bcdaa16c-9e2d-41da-8d71-992255b8d8f9","actor_name":"孙天澍","actor_username":"userr8_1111@outlook.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-12-07 02:54:04.264128+00	
00000000-0000-0000-0000-000000000000	25f34226-b266-4f53-b481-930748da5c46	{"action":"login","actor_id":"f64611ca-6a4d-42dd-ac81-c2c91b190dd0","actor_name":"andy","actor_username":"yizheng@ds.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-12-07 10:23:39.638126+00	
00000000-0000-0000-0000-000000000000	44e08123-040b-44cd-95ac-c0a226dfef75	{"action":"logout","actor_id":"83cf7ae9-fd96-426c-9e26-effd554cc8c9","actor_name":"Wade Zhu","actor_username":"819028551@qq.com","actor_via_sso":false,"log_type":"account"}	2025-12-07 10:24:14.898189+00	
00000000-0000-0000-0000-000000000000	94b5d8ce-3032-41ed-abeb-96d3eb7abceb	{"action":"login","actor_id":"f64611ca-6a4d-42dd-ac81-c2c91b190dd0","actor_name":"andy","actor_username":"yizheng@ds.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-12-07 10:24:21.274258+00	
00000000-0000-0000-0000-000000000000	380cd062-97fd-4083-89ce-7cfb4cc6ed81	{"action":"logout","actor_id":"f64611ca-6a4d-42dd-ac81-c2c91b190dd0","actor_name":"andy","actor_username":"yizheng@ds.com","actor_via_sso":false,"log_type":"account"}	2025-12-07 10:27:38.962863+00	
00000000-0000-0000-0000-000000000000	2d642c99-1be6-47b0-a73f-1a3807908f48	{"action":"login","actor_id":"0399fa1a-4045-425b-b514-dfd8fb44f233","actor_name":"朱伟章Allen","actor_username":"wadezhuhk@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-12-07 10:27:42.030068+00	
00000000-0000-0000-0000-000000000000	c95c4a99-859c-4983-82c8-fd0f442c17b1	{"action":"logout","actor_id":"0399fa1a-4045-425b-b514-dfd8fb44f233","actor_name":"朱伟章Allen","actor_username":"wadezhuhk@gmail.com","actor_via_sso":false,"log_type":"account"}	2025-12-07 10:29:35.958229+00	
00000000-0000-0000-0000-000000000000	54aa5afe-c0ac-4239-8622-d820e32e6904	{"action":"login","actor_id":"4398b7ca-ef2c-4b26-b426-d69340b4c15c","actor_name":"FC","actor_username":"fc13303752056@163.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-12-07 10:29:41.128866+00	
00000000-0000-0000-0000-000000000000	382f9e6a-4ea5-408a-8d2d-26ed177edbdb	{"action":"logout","actor_id":"4398b7ca-ef2c-4b26-b426-d69340b4c15c","actor_name":"FC","actor_username":"fc13303752056@163.com","actor_via_sso":false,"log_type":"account"}	2025-12-07 10:30:19.674234+00	
00000000-0000-0000-0000-000000000000	488fa5fd-f686-49d5-a45b-8a6e1ea950ae	{"action":"login","actor_id":"0399fa1a-4045-425b-b514-dfd8fb44f233","actor_name":"朱伟章Allen","actor_username":"wadezhuhk@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-12-07 10:30:21.966061+00	
00000000-0000-0000-0000-000000000000	9c81c42a-5c5d-4ca3-ab30-07928c425fa0	{"action":"logout","actor_id":"0399fa1a-4045-425b-b514-dfd8fb44f233","actor_name":"朱伟章Allen","actor_username":"wadezhuhk@gmail.com","actor_via_sso":false,"log_type":"account"}	2025-12-07 10:30:40.813103+00	
00000000-0000-0000-0000-000000000000	94fc5289-e9dc-417a-838a-9f6092fc1b69	{"action":"login","actor_id":"f64611ca-6a4d-42dd-ac81-c2c91b190dd0","actor_name":"andy","actor_username":"yizheng@ds.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-12-07 10:31:01.574245+00	
00000000-0000-0000-0000-000000000000	4441c7c6-ee63-4141-93cc-3769032be0f6	{"action":"logout","actor_id":"f64611ca-6a4d-42dd-ac81-c2c91b190dd0","actor_name":"andy","actor_username":"yizheng@ds.com","actor_via_sso":false,"log_type":"account"}	2025-12-07 10:50:49.810199+00	
00000000-0000-0000-0000-000000000000	a2ae00ff-fdb6-44df-b601-80ae71e8770b	{"action":"login","actor_id":"0399fa1a-4045-425b-b514-dfd8fb44f233","actor_name":"朱伟章Allen","actor_username":"wadezhuhk@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-12-07 10:50:52.422198+00	
00000000-0000-0000-0000-000000000000	374f29dc-9165-4fda-86ca-d3cc157b8419	{"action":"logout","actor_id":"0399fa1a-4045-425b-b514-dfd8fb44f233","actor_name":"朱伟章Allen","actor_username":"wadezhuhk@gmail.com","actor_via_sso":false,"log_type":"account"}	2025-12-07 10:55:09.218639+00	
00000000-0000-0000-0000-000000000000	b9046e47-ab4f-4b1f-bbd8-3ac7d8a58262	{"action":"login","actor_id":"f64611ca-6a4d-42dd-ac81-c2c91b190dd0","actor_name":"andy","actor_username":"yizheng@ds.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-12-07 10:55:21.634278+00	
\.


--
-- Data for Name: flow_state; Type: TABLE DATA; Schema: auth; Owner: -
--

COPY auth.flow_state (id, user_id, auth_code, code_challenge_method, code_challenge, provider_type, provider_access_token, provider_refresh_token, created_at, updated_at, authentication_method, auth_code_issued_at) FROM stdin;
\.


--
-- Data for Name: identities; Type: TABLE DATA; Schema: auth; Owner: -
--

COPY auth.identities (provider_id, user_id, identity_data, provider, last_sign_in_at, created_at, updated_at, id) FROM stdin;
cd296610-acc6-4a27-bc44-62d7e5d18a9b	cd296610-acc6-4a27-bc44-62d7e5d18a9b	{"sub": "cd296610-acc6-4a27-bc44-62d7e5d18a9b", "role": "researcher", "email": "ds@ds123.com", "full_name": "ds@ds123.com", "email_verified": false, "phone_verified": false}	email	2025-11-18 09:21:09.038814+00	2025-11-18 09:21:09.038842+00	2025-11-18 09:21:09.038842+00	5a539d1c-09d7-40fb-bf71-ce95e202e42e
ff478eba-be0c-4e5b-af9a-ae5308d5ca3b	ff478eba-be0c-4e5b-af9a-ae5308d5ca3b	{"sub": "ff478eba-be0c-4e5b-af9a-ae5308d5ca3b", "role": "researcher", "email": "yizheng@h.com", "full_name": "han", "email_verified": false, "phone_verified": false}	email	2025-11-19 05:20:41.477397+00	2025-11-19 05:20:41.47744+00	2025-11-19 05:20:41.47744+00	197f69a2-d607-456c-8f71-c737bb049aa1
4c162250-6d2a-491c-9ea6-5f96332dd929	4c162250-6d2a-491c-9ea6-5f96332dd929	{"sub": "4c162250-6d2a-491c-9ea6-5f96332dd929", "role": "researcher", "email": "yingjie@design.com", "full_name": "yingjie", "email_verified": false, "phone_verified": false}	email	2025-11-19 05:40:40.404692+00	2025-11-19 05:40:40.404779+00	2025-11-19 05:40:40.404779+00	38354b80-8b6a-4d55-86cf-b26a6fdb27bc
0399fa1a-4045-425b-b514-dfd8fb44f233	0399fa1a-4045-425b-b514-dfd8fb44f233	{"sub": "0399fa1a-4045-425b-b514-dfd8fb44f233", "role": "researcher", "email": "wadezhuhk@gmail.com", "full_name": "朱伟章Allen", "email_verified": false, "phone_verified": false}	email	2025-11-19 06:29:57.561954+00	2025-11-19 06:29:57.562029+00	2025-11-19 06:29:57.562029+00	93d6f1d3-7684-4408-aa01-7fdd0b3d96f8
7dd0e9a0-75de-40fd-8998-d387885178d7	7dd0e9a0-75de-40fd-8998-d387885178d7	{"sub": "7dd0e9a0-75de-40fd-8998-d387885178d7", "role": "participant", "email": "yizheng@h1.com", "full_name": "hu1", "email_verified": false, "phone_verified": false}	email	2025-11-23 17:25:49.34139+00	2025-11-23 17:25:49.341448+00	2025-11-23 17:25:49.341448+00	7f3a19d0-c7bf-44ee-8091-8180fe722bd6
420f8270-af9a-41ce-87b2-3143037c9237	420f8270-af9a-41ce-87b2-3143037c9237	{"sub": "420f8270-af9a-41ce-87b2-3143037c9237", "role": "researcher", "email": "yizheng@yun.com", "full_name": "yun", "email_verified": false, "phone_verified": false}	email	2025-11-23 17:26:40.61207+00	2025-11-23 17:26:40.612113+00	2025-11-23 17:26:40.612113+00	b32ab044-eaa9-4978-b419-b48ad69379e7
d524f2e6-27d4-4f1b-b171-e96df36ec23e	d524f2e6-27d4-4f1b-b171-e96df36ec23e	{"sub": "d524f2e6-27d4-4f1b-b171-e96df36ec23e", "role": "researcher", "email": "yizheng@y6.com", "full_name": "yun", "email_verified": false, "phone_verified": false}	email	2025-11-23 17:26:50.872428+00	2025-11-23 17:26:50.872481+00	2025-11-23 17:26:50.872481+00	009bdf24-154e-49cb-9cb4-d6a40188c883
b8b372b5-bd93-48fe-8afa-5a35480330da	b8b372b5-bd93-48fe-8afa-5a35480330da	{"sub": "b8b372b5-bd93-48fe-8afa-5a35480330da", "role": "participant", "email": "test@ds.com", "full_name": "test", "email_verified": false, "phone_verified": false}	email	2025-11-24 04:28:43.174611+00	2025-11-24 04:28:43.174666+00	2025-11-24 04:28:43.174666+00	b146d69c-a19d-4fa4-a499-45e7977fe8ef
dff299c1-c9c2-4035-9f2e-107d46ae3c5e	dff299c1-c9c2-4035-9f2e-107d46ae3c5e	{"sub": "dff299c1-c9c2-4035-9f2e-107d46ae3c5e", "role": "participant", "email": "wanghaipeng@dsdigitalgroup.com", "full_name": "test", "email_verified": false, "phone_verified": false}	email	2025-11-24 04:42:25.274423+00	2025-11-24 04:42:25.274559+00	2025-11-24 04:42:25.274559+00	5ade75c6-5969-4d85-8588-d9862d17db09
4398b7ca-ef2c-4b26-b426-d69340b4c15c	4398b7ca-ef2c-4b26-b426-d69340b4c15c	{"sub": "4398b7ca-ef2c-4b26-b426-d69340b4c15c", "role": "researcher", "email": "fc13303752056@163.com", "full_name": "FC", "email_verified": false, "phone_verified": false}	email	2025-11-25 03:53:20.363622+00	2025-11-25 03:53:20.363672+00	2025-11-25 03:53:20.363672+00	296ed956-bd32-4975-8a42-60198bdd9ef3
6cdba011-5883-4b7d-89f4-ea9a1bcacc55	6cdba011-5883-4b7d-89f4-ea9a1bcacc55	{"sub": "6cdba011-5883-4b7d-89f4-ea9a1bcacc55", "role": "participant", "email": "wadezhuhk_test_1@gmail.com", "full_name": "wade_test_1", "email_verified": false, "phone_verified": false}	email	2025-11-25 10:27:12.347511+00	2025-11-25 10:27:12.347548+00	2025-11-25 10:27:12.347548+00	5a74fb1e-e692-4321-9f64-3033b756ebf8
ce008f4b-dfe9-4301-a844-fe7d337dd1c5	ce008f4b-dfe9-4301-a844-fe7d337dd1c5	{"sub": "ce008f4b-dfe9-4301-a844-fe7d337dd1c5", "role": "participant", "email": "wadezhuhk_test_2@gmail.com", "full_name": "wadezhuhk_test_2", "email_verified": false, "phone_verified": false}	email	2025-11-25 10:27:34.747073+00	2025-11-25 10:27:34.747147+00	2025-11-25 10:27:34.747147+00	aed560e5-34ce-4d05-84e0-5d889b6653c4
5acbb4bd-563e-4a64-a674-edda518cfaf0	5acbb4bd-563e-4a64-a674-edda518cfaf0	{"sub": "5acbb4bd-563e-4a64-a674-edda518cfaf0", "role": "participant", "email": "wadezhuhk_test_3@gmail.com", "full_name": "wadezhuhk_test_3", "email_verified": false, "phone_verified": false}	email	2025-11-25 10:27:52.168701+00	2025-11-25 10:27:52.168749+00	2025-11-25 10:27:52.168749+00	4d4b9095-aa79-4e25-a9e3-214cedf231bc
d35ed0e7-12b8-4f0d-9d72-e72125816810	d35ed0e7-12b8-4f0d-9d72-e72125816810	{"sub": "d35ed0e7-12b8-4f0d-9d72-e72125816810", "role": "participant", "email": "wadezhuhk_test_4@gmail.com", "full_name": "wadezhuhk_test_4", "email_verified": false, "phone_verified": false}	email	2025-11-25 10:28:13.261153+00	2025-11-25 10:28:13.26121+00	2025-11-25 10:28:13.26121+00	724d430b-219d-45e2-924b-92fa4f49ab4c
f5f0f0a1-0672-4673-ae01-cdd187fcc4cd	f5f0f0a1-0672-4673-ae01-cdd187fcc4cd	{"sub": "f5f0f0a1-0672-4673-ae01-cdd187fcc4cd", "role": "participant", "email": "wadezhuhk_test_5@gmail.com", "full_name": "wadezhuhk_test_5", "email_verified": false, "phone_verified": false}	email	2025-11-25 10:28:24.67686+00	2025-11-25 10:28:24.676919+00	2025-11-25 10:28:24.676919+00	3c63b2f3-00fa-4108-87a6-c5a4ec006097
c3ed6099-2c74-44c9-bdaf-ba9091766d62	c3ed6099-2c74-44c9-bdaf-ba9091766d62	{"sub": "c3ed6099-2c74-44c9-bdaf-ba9091766d62", "role": "participant", "email": "wadezhuhk_test_6@gmail.com", "full_name": "wadezhuhk_test_6", "email_verified": false, "phone_verified": false}	email	2025-11-25 10:28:40.737836+00	2025-11-25 10:28:40.737897+00	2025-11-25 10:28:40.737897+00	5dd58b59-708c-42b6-8185-8a235b3493e6
fdb2e0d6-01ca-422a-84bb-ed841c9480e6	fdb2e0d6-01ca-422a-84bb-ed841c9480e6	{"sub": "fdb2e0d6-01ca-422a-84bb-ed841c9480e6", "role": "participant", "email": "2994390156@qq.com", "full_name": "FC", "email_verified": false, "phone_verified": false}	email	2025-11-26 06:44:41.436653+00	2025-11-26 06:44:41.436688+00	2025-11-26 06:44:41.436688+00	5c55a4ed-449b-499d-a962-82cd347c3ab1
1608ba80-8e25-4424-b7ad-5fecacedf81d	1608ba80-8e25-4424-b7ad-5fecacedf81d	{"sub": "1608ba80-8e25-4424-b7ad-5fecacedf81d", "role": "researcher", "email": "userr1_4940@163.com", "full_name": "曾思棚", "email_verified": false, "phone_verified": false}	email	2025-12-04 08:37:46.368795+00	2025-12-04 08:37:46.368868+00	2025-12-04 08:37:46.368868+00	acfcc583-f9bf-47c4-80f4-c5cc368b1ccc
01941460-10a5-4fd1-87f3-8d19625e4f04	01941460-10a5-4fd1-87f3-8d19625e4f04	{"sub": "01941460-10a5-4fd1-87f3-8d19625e4f04", "role": "researcher", "email": "userr2_7026@163.com", "full_name": "lzx", "email_verified": false, "phone_verified": false}	email	2025-12-04 08:39:28.961977+00	2025-12-04 08:39:28.962032+00	2025-12-04 08:39:28.962032+00	fe1ce022-18bc-4fb1-bd32-84ecc70a9c05
4e14ad80-ed09-4db5-9add-fbba2ce1004b	4e14ad80-ed09-4db5-9add-fbba2ce1004b	{"sub": "4e14ad80-ed09-4db5-9add-fbba2ce1004b", "role": "researcher", "email": "wadezhuhk3@gmail.com", "full_name": "Allen Zhu", "email_verified": false, "phone_verified": false}	email	2025-12-05 09:16:23.799312+00	2025-12-05 09:16:23.799369+00	2025-12-05 09:16:23.799369+00	7680c6a5-c40e-41d1-a416-8d4cc6f97927
a50e4c18-7e6f-46a5-b8e5-7d4a4db179bb	a50e4c18-7e6f-46a5-b8e5-7d4a4db179bb	{"sub": "a50e4c18-7e6f-46a5-b8e5-7d4a4db179bb", "role": "researcher", "email": "userr4_8070@foxmail.com", "full_name": "袁僮璐", "email_verified": false, "phone_verified": false}	email	2025-12-05 11:00:24.423602+00	2025-12-05 11:00:24.423698+00	2025-12-05 11:00:24.423698+00	b0585deb-3af1-47da-91d6-24ca710275d5
83cf7ae9-fd96-426c-9e26-effd554cc8c9	83cf7ae9-fd96-426c-9e26-effd554cc8c9	{"sub": "83cf7ae9-fd96-426c-9e26-effd554cc8c9", "role": "researcher", "email": "819028551@qq.com", "full_name": "Wade Zhu", "email_verified": false, "phone_verified": false}	email	2025-12-06 12:37:58.914333+00	2025-12-06 12:37:58.914393+00	2025-12-06 12:37:58.914393+00	47e3f565-3449-4a7b-a1c1-9b0eba24f3d2
bcdaa16c-9e2d-41da-8d71-992255b8d8f9	bcdaa16c-9e2d-41da-8d71-992255b8d8f9	{"sub": "bcdaa16c-9e2d-41da-8d71-992255b8d8f9", "role": "researcher", "email": "userr8_1111@outlook.com", "full_name": "孙天澍", "email_verified": false, "phone_verified": false}	email	2025-12-07 02:00:49.498387+00	2025-12-07 02:00:49.498417+00	2025-12-07 02:00:49.498417+00	81958456-19d0-4c54-94ea-bddfc1843219
fe96e8e5-9e67-4c02-9ff4-1ddcbbc4ee89	fe96e8e5-9e67-4c02-9ff4-1ddcbbc4ee89	{"sub": "fe96e8e5-9e67-4c02-9ff4-1ddcbbc4ee89", "role": "researcher", "email": "userr9_1111@outlook.com", "full_name": "Frank.Li", "email_verified": false, "phone_verified": false}	email	2025-12-07 02:27:24.386436+00	2025-12-07 02:27:24.386475+00	2025-12-07 02:27:24.386475+00	58195db9-beef-469b-a087-098bc85b1420
1a1b09cb-aa1b-4fb9-a83c-871eb9675be4	1a1b09cb-aa1b-4fb9-a83c-871eb9675be4	{"sub": "1a1b09cb-aa1b-4fb9-a83c-871eb9675be4", "role": "researcher", "email": "userr10_1111@outlook.com", "full_name": "Gavin.Wang", "email_verified": false, "phone_verified": false}	email	2025-12-07 02:38:54.496462+00	2025-12-07 02:38:54.496506+00	2025-12-07 02:38:54.496506+00	3c519be4-7f4b-4653-93c9-6c346538675f
7867d1c5-9496-485c-bf4e-f5e80b3386d3	7867d1c5-9496-485c-bf4e-f5e80b3386d3	{"sub": "7867d1c5-9496-485c-bf4e-f5e80b3386d3", "role": "researcher", "email": "userr11_1111@outlook.com", "full_name": "Wang.Jin", "email_verified": false, "phone_verified": false}	email	2025-12-07 02:39:26.898835+00	2025-12-07 02:39:26.898868+00	2025-12-07 02:39:26.898868+00	be5171e6-6306-4422-9104-cab4e4bb4a0c
\.


--
-- Data for Name: instances; Type: TABLE DATA; Schema: auth; Owner: -
--

COPY auth.instances (id, uuid, raw_base_config, created_at, updated_at) FROM stdin;
\.


--
-- Data for Name: mfa_amr_claims; Type: TABLE DATA; Schema: auth; Owner: -
--

COPY auth.mfa_amr_claims (session_id, created_at, updated_at, authentication_method, id) FROM stdin;
5b81e087-9e06-402d-9014-9aed2a2babd9	2025-11-18 09:21:09.063377+00	2025-11-18 09:21:09.063377+00	password	1d5314cd-1d78-4af1-af63-dcc44f20260f
0e912811-91e9-453b-8963-2a07d0c08072	2025-11-18 09:21:26.922195+00	2025-11-18 09:21:26.922195+00	password	0210dc7e-ce77-44d3-97d0-cb660662c99b
51788888-55a5-4783-9e64-99e2f01c2910	2025-11-19 05:40:40.423693+00	2025-11-19 05:40:40.423693+00	password	28039720-30c2-4f33-b459-aef9ae9aa7da
cb523e54-6f13-4d20-9415-dd50d153819d	2025-12-07 02:39:26.918454+00	2025-12-07 02:39:26.918454+00	password	7507483f-dc12-425d-96ef-dc3b72a97464
5280316f-a54c-48ee-af20-7fa9959e9ca8	2025-12-07 02:54:04.268809+00	2025-12-07 02:54:04.268809+00	password	79ec7a6f-c30f-42f9-982f-96146d9de8b4
7197c9d4-6f33-41dc-b04f-f96e655ad4f1	2025-12-07 10:55:21.673387+00	2025-12-07 10:55:21.673387+00	password	2683a64c-d2cd-415f-930d-b045cabbbec2
f3071184-23dd-4a54-8eed-0f40a539cbfa	2025-12-04 08:37:46.392986+00	2025-12-04 08:37:46.392986+00	password	5da82f34-8f00-4772-88b5-5ea31694b2e8
a8c72d4c-65ce-4f30-9ab4-bba2139c4832	2025-12-04 08:39:28.982727+00	2025-12-04 08:39:28.982727+00	password	5910fcbc-f827-42a6-8983-3640dc0fd277
16b65cd9-6200-479e-91da-765b58109d45	2025-12-05 11:04:58.779465+00	2025-12-05 11:04:58.779465+00	password	f951d553-878b-4959-8f8a-0487dc65494b
\.


--
-- Data for Name: mfa_challenges; Type: TABLE DATA; Schema: auth; Owner: -
--

COPY auth.mfa_challenges (id, factor_id, created_at, verified_at, ip_address, otp_code, web_authn_session_data) FROM stdin;
\.


--
-- Data for Name: mfa_factors; Type: TABLE DATA; Schema: auth; Owner: -
--

COPY auth.mfa_factors (id, user_id, friendly_name, factor_type, status, created_at, updated_at, secret, phone, last_challenged_at, web_authn_credential, web_authn_aaguid, last_webauthn_challenge_data) FROM stdin;
\.


--
-- Data for Name: oauth_authorizations; Type: TABLE DATA; Schema: auth; Owner: -
--

COPY auth.oauth_authorizations (id, authorization_id, client_id, user_id, redirect_uri, scope, state, resource, code_challenge, code_challenge_method, response_type, status, authorization_code, created_at, expires_at, approved_at) FROM stdin;
\.


--
-- Data for Name: oauth_clients; Type: TABLE DATA; Schema: auth; Owner: -
--

COPY auth.oauth_clients (id, client_secret_hash, registration_type, redirect_uris, grant_types, client_name, client_uri, logo_uri, created_at, updated_at, deleted_at, client_type) FROM stdin;
\.


--
-- Data for Name: oauth_consents; Type: TABLE DATA; Schema: auth; Owner: -
--

COPY auth.oauth_consents (id, user_id, client_id, scopes, granted_at, revoked_at) FROM stdin;
\.


--
-- Data for Name: one_time_tokens; Type: TABLE DATA; Schema: auth; Owner: -
--

COPY auth.one_time_tokens (id, user_id, token_type, token_hash, relates_to, created_at, updated_at) FROM stdin;
2a03dbfa-bc2c-4984-9a18-54a9734f4128	b8b372b5-bd93-48fe-8afa-5a35480330da	confirmation_token	9cf160df18cf5d89015d7bd578b224584f15227ef2626183722e85e8	test@ds.com	2025-11-24 04:35:17.53683	2025-11-24 04:35:17.53683
cba6a1e7-6b63-49ae-91b9-f05020515b1e	dff299c1-c9c2-4035-9f2e-107d46ae3c5e	confirmation_token	7e904381a35ee0b5f530ec546a04f55c4d6fa0115a8150454029bdb9	wanghaipeng@dsdigitalgroup.com	2025-11-24 07:01:37.457479	2025-11-24 07:01:37.457479
\.


--
-- Data for Name: refresh_tokens; Type: TABLE DATA; Schema: auth; Owner: -
--

COPY auth.refresh_tokens (instance_id, id, token, user_id, revoked, created_at, updated_at, parent, session_id) FROM stdin;
00000000-0000-0000-0000-000000000000	1	rogj5oqmh6qb	cd296610-acc6-4a27-bc44-62d7e5d18a9b	f	2025-11-18 09:21:09.060891+00	2025-11-18 09:21:09.060891+00	\N	5b81e087-9e06-402d-9014-9aed2a2babd9
00000000-0000-0000-0000-000000000000	2	cat5ze7y5xl6	cd296610-acc6-4a27-bc44-62d7e5d18a9b	f	2025-11-18 09:21:26.919861+00	2025-11-18 09:21:26.919861+00	\N	0e912811-91e9-453b-8963-2a07d0c08072
00000000-0000-0000-0000-000000000000	142	mdbpulmqdzuh	4c162250-6d2a-491c-9ea6-5f96332dd929	f	2025-11-19 05:40:40.422105+00	2025-11-19 05:40:40.422105+00	\N	51788888-55a5-4783-9e64-99e2f01c2910
00000000-0000-0000-0000-000000000000	259	fthq4qx2bzct	7867d1c5-9496-485c-bf4e-f5e80b3386d3	f	2025-12-07 02:39:26.917016+00	2025-12-07 02:39:26.917016+00	\N	cb523e54-6f13-4d20-9415-dd50d153819d
00000000-0000-0000-0000-000000000000	260	ezlmpjquqbcr	bcdaa16c-9e2d-41da-8d71-992255b8d8f9	f	2025-12-07 02:54:04.267326+00	2025-12-07 02:54:04.267326+00	\N	5280316f-a54c-48ee-af20-7fa9959e9ca8
00000000-0000-0000-0000-000000000000	268	nifwo6daozve	f64611ca-6a4d-42dd-ac81-c2c91b190dd0	f	2025-12-07 10:55:21.658073+00	2025-12-07 10:55:21.658073+00	\N	7197c9d4-6f33-41dc-b04f-f96e655ad4f1
00000000-0000-0000-0000-000000000000	232	orlodpwe3rq4	1608ba80-8e25-4424-b7ad-5fecacedf81d	f	2025-12-04 08:37:46.390918+00	2025-12-04 08:37:46.390918+00	\N	f3071184-23dd-4a54-8eed-0f40a539cbfa
00000000-0000-0000-0000-000000000000	233	kl6pnvkhodkw	01941460-10a5-4fd1-87f3-8d19625e4f04	f	2025-12-04 08:39:28.981102+00	2025-12-04 08:39:28.981102+00	\N	a8c72d4c-65ce-4f30-9ab4-bba2139c4832
00000000-0000-0000-0000-000000000000	244	t2o5b2tiauba	a50e4c18-7e6f-46a5-b8e5-7d4a4db179bb	f	2025-12-05 11:04:58.777833+00	2025-12-05 11:04:58.777833+00	\N	16b65cd9-6200-479e-91da-765b58109d45
\.


--
-- Data for Name: saml_providers; Type: TABLE DATA; Schema: auth; Owner: -
--

COPY auth.saml_providers (id, sso_provider_id, entity_id, metadata_xml, metadata_url, attribute_mapping, created_at, updated_at, name_id_format) FROM stdin;
\.


--
-- Data for Name: saml_relay_states; Type: TABLE DATA; Schema: auth; Owner: -
--

COPY auth.saml_relay_states (id, sso_provider_id, request_id, for_email, redirect_to, created_at, updated_at, flow_state_id) FROM stdin;
\.


--
-- Data for Name: schema_migrations; Type: TABLE DATA; Schema: auth; Owner: -
--

COPY auth.schema_migrations (version) FROM stdin;
20171026211738
20171026211808
20171026211834
20180103212743
20180108183307
20180119214651
20180125194653
00
20210710035447
20210722035447
20210730183235
20210909172000
20210927181326
20211122151130
20211124214934
20211202183645
20220114185221
20220114185340
20220224000811
20220323170000
20220429102000
20220531120530
20220614074223
20220811173540
20221003041349
20221003041400
20221011041400
20221020193600
20221021073300
20221021082433
20221027105023
20221114143122
20221114143410
20221125140132
20221208132122
20221215195500
20221215195800
20221215195900
20230116124310
20230116124412
20230131181311
20230322519590
20230402418590
20230411005111
20230508135423
20230523124323
20230818113222
20230914180801
20231027141322
20231114161723
20231117164230
20240115144230
20240214120130
20240306115329
20240314092811
20240427152123
20240612123726
20240729123726
20240802193726
20240806073726
20241009103726
20250717082212
20250731150234
20250804100000
20250901200500
20250903112500
20250904133000
20250925093508
20251007112900
\.


--
-- Data for Name: sessions; Type: TABLE DATA; Schema: auth; Owner: -
--

COPY auth.sessions (id, user_id, created_at, updated_at, factor_id, aal, not_after, refreshed_at, user_agent, ip, tag, oauth_client_id, refresh_token_hmac_key, refresh_token_counter) FROM stdin;
5b81e087-9e06-402d-9014-9aed2a2babd9	cd296610-acc6-4a27-bc44-62d7e5d18a9b	2025-11-18 09:21:09.058126+00	2025-11-18 09:21:09.058126+00	\N	aal1	\N	\N	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36	115.206.151.34	\N	\N	\N	\N
0e912811-91e9-453b-8963-2a07d0c08072	cd296610-acc6-4a27-bc44-62d7e5d18a9b	2025-11-18 09:21:26.917401+00	2025-11-18 09:21:26.917401+00	\N	aal1	\N	\N	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36	115.206.151.34	\N	\N	\N	\N
51788888-55a5-4783-9e64-99e2f01c2910	4c162250-6d2a-491c-9ea6-5f96332dd929	2025-11-19 05:40:40.42036+00	2025-11-19 05:40:40.42036+00	\N	aal1	\N	\N	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36	106.120.124.109	\N	\N	\N	\N
cb523e54-6f13-4d20-9415-dd50d153819d	7867d1c5-9496-485c-bf4e-f5e80b3386d3	2025-12-07 02:39:26.914879+00	2025-12-07 02:39:26.914879+00	\N	aal1	\N	\N	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36 Edg/142.0.0.0	36.21.147.133	\N	\N	\N	\N
5280316f-a54c-48ee-af20-7fa9959e9ca8	bcdaa16c-9e2d-41da-8d71-992255b8d8f9	2025-12-07 02:54:04.265365+00	2025-12-07 02:54:04.265365+00	\N	aal1	\N	\N	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/143.0.0.0 Safari/537.36	36.24.100.210	\N	\N	\N	\N
7197c9d4-6f33-41dc-b04f-f96e655ad4f1	f64611ca-6a4d-42dd-ac81-c2c91b190dd0	2025-12-07 10:55:21.646122+00	2025-12-07 10:55:21.646122+00	\N	aal1	\N	\N	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/143.0.0.0 Safari/537.36 Edg/143.0.0.0	36.24.100.210	\N	\N	\N	\N
f3071184-23dd-4a54-8eed-0f40a539cbfa	1608ba80-8e25-4424-b7ad-5fecacedf81d	2025-12-04 08:37:46.388444+00	2025-12-04 08:37:46.388444+00	\N	aal1	\N	\N	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36	115.205.37.66	\N	\N	\N	\N
a8c72d4c-65ce-4f30-9ab4-bba2139c4832	01941460-10a5-4fd1-87f3-8d19625e4f04	2025-12-04 08:39:28.979382+00	2025-12-04 08:39:28.979382+00	\N	aal1	\N	\N	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36 Edg/142.0.0.0	115.205.37.66	\N	\N	\N	\N
16b65cd9-6200-479e-91da-765b58109d45	a50e4c18-7e6f-46a5-b8e5-7d4a4db179bb	2025-12-05 11:04:58.774931+00	2025-12-05 11:04:58.774931+00	\N	aal1	\N	\N	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/124.0.0.0 Safari/537.36 SLBrowser/9.0.6.8151 SLBChan/103 SLBVPV/64-bit	115.205.37.66	\N	\N	\N	\N
\.


--
-- Data for Name: sso_domains; Type: TABLE DATA; Schema: auth; Owner: -
--

COPY auth.sso_domains (id, sso_provider_id, domain, created_at, updated_at) FROM stdin;
\.


--
-- Data for Name: sso_providers; Type: TABLE DATA; Schema: auth; Owner: -
--

COPY auth.sso_providers (id, resource_id, created_at, updated_at, disabled) FROM stdin;
\.


--
-- Data for Name: users; Type: TABLE DATA; Schema: auth; Owner: -
--

COPY auth.users (instance_id, id, aud, role, email, encrypted_password, email_confirmed_at, invited_at, confirmation_token, confirmation_sent_at, recovery_token, recovery_sent_at, email_change_token_new, email_change, email_change_sent_at, last_sign_in_at, raw_app_meta_data, raw_user_meta_data, is_super_admin, created_at, updated_at, phone, phone_confirmed_at, phone_change, phone_change_token, phone_change_sent_at, email_change_token_current, email_change_confirm_status, banned_until, reauthentication_token, reauthentication_sent_at, is_sso_user, deleted_at, is_anonymous) FROM stdin;
00000000-0000-0000-0000-000000000000	4c162250-6d2a-491c-9ea6-5f96332dd929	authenticated	authenticated	yingjie@design.com	$2a$10$bO14UnGTTfz9ib.AUm6MxOf0V4I916LqhmRqguXERqO1gQ4j.1T/2	2025-11-19 05:40:40.407204+00	\N		\N		\N			\N	2025-11-19 05:40:40.420255+00	{"provider": "email", "providers": ["email"]}	{"sub": "4c162250-6d2a-491c-9ea6-5f96332dd929", "role": "researcher", "email": "yingjie@design.com", "full_name": "yingjie", "email_verified": true, "phone_verified": false}	\N	2025-11-19 05:40:40.398206+00	2025-11-19 05:40:40.423134+00	\N	\N			\N		0	\N		\N	f	\N	f
00000000-0000-0000-0000-000000000000	ff478eba-be0c-4e5b-af9a-ae5308d5ca3b	authenticated	authenticated	yizheng@h.com	$2a$10$zNenzv.XI1D3q5Ygsvhj3OQpvUCMtIxefzEbUTG3UhoLBAEaTChSG	2025-11-19 05:20:41.481567+00	\N		\N		\N			\N	2025-11-19 05:20:41.501882+00	{"provider": "email", "providers": ["email"]}	{"sub": "ff478eba-be0c-4e5b-af9a-ae5308d5ca3b", "role": "researcher", "email": "yizheng@h.com", "full_name": "han", "email_verified": true, "phone_verified": false}	\N	2025-11-19 05:20:41.470333+00	2025-11-19 05:20:41.505715+00	\N	\N			\N		0	\N		\N	f	\N	f
00000000-0000-0000-0000-000000000000	cd296610-acc6-4a27-bc44-62d7e5d18a9b	authenticated	authenticated	ds@ds123.com	$2a$10$1nBYwpZugK3en6fMv6nDeeSyOlwC0IuWsyXKO33tMYpfQapULxQpy	2025-11-18 09:21:09.044266+00	\N		\N		\N			\N	2025-11-18 09:21:26.917277+00	{"provider": "email", "providers": ["email"]}	{"sub": "cd296610-acc6-4a27-bc44-62d7e5d18a9b", "role": "researcher", "email": "ds@ds123.com", "full_name": "ds@ds123.com", "email_verified": true, "phone_verified": false}	\N	2025-11-18 09:21:09.002153+00	2025-11-18 09:21:26.921481+00	\N	\N			\N		0	\N		\N	f	\N	f
00000000-0000-0000-0000-000000000000	f6f69b2b-d1f3-4349-8d2b-3fe31aa30bae	authenticated	authenticated	yizheng@a.com	$2a$10$8sx591I1agA9l/NOHaiaYOc508cP/kIsVxX0JgpVdfkZme5X5UNrO	2025-11-15 22:46:13.736898+00	\N		\N		\N			\N	2025-11-17 07:51:58.900869+00	{"provider": "email", "providers": ["email"]}	{"sub": "f6f69b2b-d1f3-4349-8d2b-3fe31aa30bae", "role": "participant", "email": "yizheng@a.com", "full_name": "Ace", "email_verified": true, "phone_verified": false}	\N	2025-11-15 22:46:13.696935+00	2025-11-17 07:51:58.905222+00	\N	\N			\N		0	\N		\N	f	\N	f
00000000-0000-0000-0000-000000000000	cb7c8d0f-1838-4fdd-81aa-0348e7781fec	authenticated	authenticated	yizheng@x.com	$2a$10$BVzk3RhYOF0DQyPgRrsyf.HmGMpV.iVK3hHt7QTK1RI6EpLQPiwDi	2025-11-13 01:28:29.504484+00	\N		\N		\N			\N	2025-11-17 08:08:36.191777+00	{"provider": "email", "providers": ["email"]}	{"sub": "cb7c8d0f-1838-4fdd-81aa-0348e7781fec", "role": "participant", "email": "yizheng@x.com", "full_name": "tom", "email_verified": true, "phone_verified": false}	\N	2025-11-13 01:28:29.467486+00	2025-11-17 08:08:36.198806+00	\N	\N			\N		0	\N		\N	f	\N	f
00000000-0000-0000-0000-000000000000	6f18071a-1a54-4d65-9e00-43633e4ae8d5	authenticated	authenticated	yizheng@z.com	$2a$10$huRYG06q9Itit4CyVGrvkOX8/7PLw0dj9MZPcvHEYdzCKhHq/4lMS	2025-11-15 22:07:33.763188+00	\N		\N		\N			\N	2025-11-17 07:16:08.740538+00	{"provider": "email", "providers": ["email"]}	{"sub": "6f18071a-1a54-4d65-9e00-43633e4ae8d5", "role": "participant", "email": "yizheng@z.com", "full_name": "jim", "email_verified": true, "phone_verified": false}	\N	2025-11-15 22:07:33.701718+00	2025-11-17 07:16:08.744237+00	\N	\N			\N		0	\N		\N	f	\N	f
00000000-0000-0000-0000-000000000000	76e8bfd8-4d08-4320-b4f4-dd345d1b94d7	authenticated	authenticated	yizheng@y.com	$2a$10$TFC6.o3VIHVAK6Cg/u6qy.ZCMLHCbqUbTi/tu4TdfSNW/K8izRjS6	2025-11-13 21:17:27.976947+00	\N		\N		\N			\N	2025-11-17 07:32:53.045718+00	{"provider": "email", "providers": ["email"]}	{"sub": "76e8bfd8-4d08-4320-b4f4-dd345d1b94d7", "role": "participant", "email": "yizheng@y.com", "full_name": "tim", "email_verified": true, "phone_verified": false}	\N	2025-11-13 21:17:27.931751+00	2025-11-17 07:32:53.052461+00	\N	\N			\N		0	\N		\N	f	\N	f
00000000-0000-0000-0000-000000000000	fdb2e0d6-01ca-422a-84bb-ed841c9480e6	authenticated	authenticated	2994390156@qq.com	$2a$10$3aoxGeQUWBlV2bVNzq45Ee7vVqURGKvm4vw7mQU1plpLq50a/P2oW	2025-11-26 06:44:41.439046+00	\N		\N		\N			\N	2025-12-02 09:57:36.664243+00	{"provider": "email", "providers": ["email"]}	{"sub": "fdb2e0d6-01ca-422a-84bb-ed841c9480e6", "role": "participant", "email": "2994390156@qq.com", "full_name": "FC", "email_verified": true, "phone_verified": false}	\N	2025-11-26 06:44:41.432047+00	2025-12-02 09:57:36.667609+00	\N	\N			\N		0	\N		\N	f	\N	f
00000000-0000-0000-0000-000000000000	7dd0e9a0-75de-40fd-8998-d387885178d7	authenticated	authenticated	yizheng@h1.com	$2a$10$rIWozZtL5zF/mC1cSGlNCuJt3.m6OtjL2gjuvE0a7nNIXOSQmvI82	2025-11-23 17:25:49.344742+00	\N		\N		\N			\N	2025-11-23 17:25:49.355973+00	{"provider": "email", "providers": ["email"]}	{"sub": "7dd0e9a0-75de-40fd-8998-d387885178d7", "role": "participant", "email": "yizheng@h1.com", "full_name": "hu1", "email_verified": true, "phone_verified": false}	\N	2025-11-23 17:25:49.335897+00	2025-11-23 17:25:49.359453+00	\N	\N			\N		0	\N		\N	f	\N	f
00000000-0000-0000-0000-000000000000	f64611ca-6a4d-42dd-ac81-c2c91b190dd0	authenticated	authenticated	yizheng@ds.com	$2a$10$3hDbkehu8noYXiyNVxZZ6uNbC41yDKFKyJQAsJZS9j3.kclNkEgoq	2025-11-11 03:36:15.284205+00	\N		\N		\N			\N	2025-12-07 10:55:21.646062+00	{"provider": "email", "providers": ["email"]}	{"sub": "f64611ca-6a4d-42dd-ac81-c2c91b190dd0", "role": "researcher", "email": "yizheng@ds.com", "full_name": "andy", "email_verified": true, "phone_verified": false}	\N	2025-11-11 03:36:15.202744+00	2025-12-07 10:55:21.667248+00	\N	\N			\N		0	\N		\N	f	\N	f
00000000-0000-0000-0000-000000000000	525d29ed-3bcf-41f4-9d81-f3ab5f038122	authenticated	authenticated	yizheng@b.com	$2a$10$X75.OyVxL7DDLCdKim6rReCRZTGYy0vtNM/XOSMrQT7Qsa5AlIwNa	2025-11-15 22:46:36.310087+00	\N		\N		\N			\N	2025-11-30 01:36:50.335133+00	{"provider": "email", "providers": ["email"]}	{"sub": "525d29ed-3bcf-41f4-9d81-f3ab5f038122", "role": "participant", "email": "yizheng@b.com", "full_name": "Bob", "email_verified": true, "phone_verified": false}	\N	2025-11-15 22:46:36.286998+00	2025-11-30 01:36:50.339271+00	\N	\N			\N		0	\N		\N	f	\N	f
00000000-0000-0000-0000-000000000000	420f8270-af9a-41ce-87b2-3143037c9237	authenticated	authenticated	yizheng@yun.com	$2a$10$Sus.foWGzNexIO.LtHH/WeP.nYRzrKlwdyjhBpCwcYnBavOQiB.BW	2025-11-23 17:26:40.614736+00	\N		\N		\N			\N	\N	{"provider": "email", "providers": ["email"]}	{"sub": "420f8270-af9a-41ce-87b2-3143037c9237", "role": "researcher", "email": "yizheng@yun.com", "full_name": "yun", "email_verified": true, "phone_verified": false}	\N	2025-11-23 17:26:40.605845+00	2025-11-23 17:26:40.61584+00	\N	\N			\N		0	\N		\N	f	\N	f
00000000-0000-0000-0000-000000000000	0399fa1a-4045-425b-b514-dfd8fb44f233	authenticated	authenticated	wadezhuhk@gmail.com	$2a$10$R8YjpkjjlAU5j3s4TOqbK.fHo4.4mwsuuywUDxKigz0WvScyGfTim	2025-11-19 06:29:57.565456+00	\N		\N		\N			\N	2025-12-07 10:50:52.454121+00	{"provider": "email", "providers": ["email"]}	{"sub": "0399fa1a-4045-425b-b514-dfd8fb44f233", "role": "researcher", "email": "wadezhuhk@gmail.com", "full_name": "朱伟章Allen", "email_verified": true, "phone_verified": false}	\N	2025-11-19 06:29:57.555798+00	2025-12-07 10:50:52.474137+00	\N	\N			\N		0	\N		\N	f	\N	f
00000000-0000-0000-0000-000000000000	d524f2e6-27d4-4f1b-b171-e96df36ec23e	authenticated	authenticated	yizheng@y6.com	$2a$10$bXfIbb8HeXRisTCre4oro.edAlovltK0VJSrg4jviNDvVaLbvARhC	2025-11-23 17:26:50.875588+00	\N		\N		\N			\N	2025-11-23 17:26:50.89008+00	{"provider": "email", "providers": ["email"]}	{"sub": "d524f2e6-27d4-4f1b-b171-e96df36ec23e", "role": "researcher", "email": "yizheng@y6.com", "full_name": "yun", "email_verified": true, "phone_verified": false}	\N	2025-11-23 17:26:50.866112+00	2025-11-23 17:26:50.894093+00	\N	\N			\N		0	\N		\N	f	\N	f
00000000-0000-0000-0000-000000000000	d35ed0e7-12b8-4f0d-9d72-e72125816810	authenticated	authenticated	wadezhuhk_test_4@gmail.com	$2a$10$hL/rDcjSv77qi/Y66H4ez.yYOgyoqkchzYgy0enaV91hZbG0irYl.	2025-11-25 10:28:13.264662+00	\N		\N		\N			\N	2025-12-06 15:14:39.804466+00	{"provider": "email", "providers": ["email"]}	{"sub": "d35ed0e7-12b8-4f0d-9d72-e72125816810", "role": "participant", "email": "wadezhuhk_test_4@gmail.com", "full_name": "wadezhuhk_test_4", "email_verified": true, "phone_verified": false}	\N	2025-11-25 10:28:13.254713+00	2025-12-06 15:14:39.808558+00	\N	\N			\N		0	\N		\N	f	\N	f
00000000-0000-0000-0000-000000000000	f5f0f0a1-0672-4673-ae01-cdd187fcc4cd	authenticated	authenticated	wadezhuhk_test_5@gmail.com	$2a$10$RgBG/rruCXwPf2vRVa1rSOzks0mOVypOP1vinyGrzNUbzl8B11g.K	2025-11-25 10:28:24.682705+00	\N		\N		\N			\N	2025-12-06 15:13:20.675618+00	{"provider": "email", "providers": ["email"]}	{"sub": "f5f0f0a1-0672-4673-ae01-cdd187fcc4cd", "role": "participant", "email": "wadezhuhk_test_5@gmail.com", "full_name": "wadezhuhk_test_5", "email_verified": true, "phone_verified": false}	\N	2025-11-25 10:28:24.669703+00	2025-12-06 15:13:20.679543+00	\N	\N			\N		0	\N		\N	f	\N	f
00000000-0000-0000-0000-000000000000	01941460-10a5-4fd1-87f3-8d19625e4f04	authenticated	authenticated	userr2_7026@163.com	$2a$10$ATCW5zzNfAPlXW//qMIFCOrucGQAWTOR4TNW3mq4fApp/ontff9Ay	2025-12-04 08:39:28.965031+00	\N		\N		\N			\N	2025-12-04 08:39:28.979329+00	{"provider": "email", "providers": ["email"]}	{"sub": "01941460-10a5-4fd1-87f3-8d19625e4f04", "role": "researcher", "email": "userr2_7026@163.com", "full_name": "lzx", "email_verified": true, "phone_verified": false}	\N	2025-12-04 08:39:28.955502+00	2025-12-04 08:39:28.982172+00	\N	\N			\N		0	\N		\N	f	\N	f
00000000-0000-0000-0000-000000000000	1608ba80-8e25-4424-b7ad-5fecacedf81d	authenticated	authenticated	userr1_4940@163.com	$2a$10$eEX8LF.NzhVa6JRChwQNOe0o9O.f6pHHEkLreFrhKhpIqiocrAoIK	2025-12-04 08:37:46.373072+00	\N		\N		\N			\N	2025-12-04 08:37:46.388311+00	{"provider": "email", "providers": ["email"]}	{"sub": "1608ba80-8e25-4424-b7ad-5fecacedf81d", "role": "researcher", "email": "userr1_4940@163.com", "full_name": "曾思棚", "email_verified": true, "phone_verified": false}	\N	2025-12-04 08:37:46.361102+00	2025-12-04 08:37:46.392302+00	\N	\N			\N		0	\N		\N	f	\N	f
00000000-0000-0000-0000-000000000000	6cdba011-5883-4b7d-89f4-ea9a1bcacc55	authenticated	authenticated	wadezhuhk_test_1@gmail.com	$2a$10$UV//yFwWmSWtMiZ1eRT7QuNNbHKBmAlbN0JMg0ggpYAQOcAd8u8gq	2025-11-25 10:27:12.34962+00	\N		\N		\N			\N	2025-12-05 07:23:58.108976+00	{"provider": "email", "providers": ["email"]}	{"sub": "6cdba011-5883-4b7d-89f4-ea9a1bcacc55", "role": "participant", "email": "wadezhuhk_test_1@gmail.com", "full_name": "wade_test_1", "email_verified": true, "phone_verified": false}	\N	2025-11-25 10:27:12.3201+00	2025-12-05 07:23:58.113029+00	\N	\N			\N		0	\N		\N	f	\N	f
00000000-0000-0000-0000-000000000000	4e14ad80-ed09-4db5-9add-fbba2ce1004b	authenticated	authenticated	wadezhuhk3@gmail.com	$2a$10$vSHd17a1rr1g0VLPhJsPnunBktN8aDkJvi.fQS9BbM1ZiVkvdg7Py	2025-12-05 09:16:23.802394+00	\N		\N		\N			\N	2025-12-05 09:16:23.817647+00	{"provider": "email", "providers": ["email"]}	{"sub": "4e14ad80-ed09-4db5-9add-fbba2ce1004b", "role": "researcher", "email": "wadezhuhk3@gmail.com", "full_name": "Allen Zhu", "email_verified": true, "phone_verified": false}	\N	2025-12-05 09:16:23.79216+00	2025-12-05 09:16:23.821784+00	\N	\N			\N		0	\N		\N	f	\N	f
00000000-0000-0000-0000-000000000000	a50e4c18-7e6f-46a5-b8e5-7d4a4db179bb	authenticated	authenticated	userr4_8070@foxmail.com	$2a$10$OM6ze2BVigJJmETen0Yfaeiw0qENQCgCXPagOpAYf5L5c7pQOtAXS	2025-12-05 11:00:24.426956+00	\N		\N		\N			\N	2025-12-05 11:04:58.77487+00	{"provider": "email", "providers": ["email"]}	{"sub": "a50e4c18-7e6f-46a5-b8e5-7d4a4db179bb", "role": "researcher", "email": "userr4_8070@foxmail.com", "full_name": "袁僮璐", "email_verified": true, "phone_verified": false}	\N	2025-12-05 11:00:24.416326+00	2025-12-05 11:04:58.778965+00	\N	\N			\N		0	\N		\N	f	\N	f
00000000-0000-0000-0000-000000000000	5acbb4bd-563e-4a64-a674-edda518cfaf0	authenticated	authenticated	wadezhuhk_test_3@gmail.com	$2a$10$gg2QBwOrBdo.xESzCW.lZOSgySYQi.sGoS0JZW2URJISogkKjbLmO	2025-11-25 10:27:52.172414+00	\N		\N		\N			\N	2025-12-05 11:27:36.193351+00	{"provider": "email", "providers": ["email"]}	{"sub": "5acbb4bd-563e-4a64-a674-edda518cfaf0", "role": "participant", "email": "wadezhuhk_test_3@gmail.com", "full_name": "wadezhuhk_test_3", "email_verified": true, "phone_verified": false}	\N	2025-11-25 10:27:52.162555+00	2025-12-05 11:27:36.196933+00	\N	\N			\N		0	\N		\N	f	\N	f
00000000-0000-0000-0000-000000000000	ce008f4b-dfe9-4301-a844-fe7d337dd1c5	authenticated	authenticated	wadezhuhk_test_2@gmail.com	$2a$10$9D79ee62RKB7CP.BJMVHE.NauZImAc7VUH0pLbPwHiifN/MLwA1TW	2025-11-25 10:27:34.76009+00	\N		\N		\N			\N	2025-12-06 15:16:26.376051+00	{"provider": "email", "providers": ["email"]}	{"sub": "ce008f4b-dfe9-4301-a844-fe7d337dd1c5", "role": "participant", "email": "wadezhuhk_test_2@gmail.com", "full_name": "wadezhuhk_test_2", "email_verified": true, "phone_verified": false}	\N	2025-11-25 10:27:34.739563+00	2025-12-06 15:16:26.379245+00	\N	\N			\N		0	\N		\N	f	\N	f
00000000-0000-0000-0000-000000000000	4398b7ca-ef2c-4b26-b426-d69340b4c15c	authenticated	authenticated	fc13303752056@163.com	$2a$10$2VgSk0v/mTy8RFA5RP9TQeOQywDjfKarEim5JXYsa3gOGQcMpmjeG	2025-11-25 03:53:20.366526+00	\N		\N		\N			\N	2025-12-07 10:29:41.13583+00	{"provider": "email", "providers": ["email"]}	{"sub": "4398b7ca-ef2c-4b26-b426-d69340b4c15c", "role": "researcher", "email": "fc13303752056@163.com", "full_name": "FC", "email_verified": true, "phone_verified": false}	\N	2025-11-25 03:53:20.357571+00	2025-12-07 10:29:41.156093+00	\N	\N			\N		0	\N		\N	f	\N	f
00000000-0000-0000-0000-000000000000	b8b372b5-bd93-48fe-8afa-5a35480330da	authenticated	authenticated	test@ds.com	$2a$10$iD29KvKYO1NeAJL3JzJcI.Giy5zXHXn/32eslEmq73nOviU6kZ956	\N	\N	9cf160df18cf5d89015d7bd578b224584f15227ef2626183722e85e8	2025-11-24 04:35:17.530701+00		\N			\N	\N	{"provider": "email", "providers": ["email"]}	{"sub": "b8b372b5-bd93-48fe-8afa-5a35480330da", "role": "participant", "email": "test@ds.com", "full_name": "test", "email_verified": false, "phone_verified": false}	\N	2025-11-24 04:28:43.166069+00	2025-11-24 04:35:17.534304+00	\N	\N			\N		0	\N		\N	f	\N	f
00000000-0000-0000-0000-000000000000	dff299c1-c9c2-4035-9f2e-107d46ae3c5e	authenticated	authenticated	wanghaipeng@dsdigitalgroup.com	$2a$10$LD65N.iHoczzf0LiOuZ1suuf6AHdq0hk9tg1iXrgkqWMkLtuavafW	\N	\N	7e904381a35ee0b5f530ec546a04f55c4d6fa0115a8150454029bdb9	2025-11-24 07:01:37.450801+00		\N			\N	\N	{"provider": "email", "providers": ["email"]}	{"sub": "dff299c1-c9c2-4035-9f2e-107d46ae3c5e", "role": "participant", "email": "wanghaipeng@dsdigitalgroup.com", "full_name": "test", "email_verified": false, "phone_verified": false}	\N	2025-11-24 04:42:25.261921+00	2025-11-24 07:01:37.454674+00	\N	\N			\N		0	\N		\N	f	\N	f
00000000-0000-0000-0000-000000000000	c3ed6099-2c74-44c9-bdaf-ba9091766d62	authenticated	authenticated	wadezhuhk_test_6@gmail.com	$2a$10$kIbnUP94kf8ZMyFNn0PVSeQ3Jdr6oesYZY9PpF/iLipEFAormhMS.	2025-11-25 10:28:40.741267+00	\N		\N		\N			\N	2025-11-25 10:28:40.756632+00	{"provider": "email", "providers": ["email"]}	{"sub": "c3ed6099-2c74-44c9-bdaf-ba9091766d62", "role": "participant", "email": "wadezhuhk_test_6@gmail.com", "full_name": "wadezhuhk_test_6", "email_verified": true, "phone_verified": false}	\N	2025-11-25 10:28:40.730673+00	2025-11-25 10:28:40.760523+00	\N	\N			\N		0	\N		\N	f	\N	f
00000000-0000-0000-0000-000000000000	83cf7ae9-fd96-426c-9e26-effd554cc8c9	authenticated	authenticated	819028551@qq.com	$2a$10$OPo38BHu67eS1VMPRTxA3uZnGuvohG8JMzN2K1714cDF5gGVZTC/G	2025-12-06 12:37:58.917864+00	\N		\N		\N			\N	2025-12-06 15:13:50.926689+00	{"provider": "email", "providers": ["email"]}	{"sub": "83cf7ae9-fd96-426c-9e26-effd554cc8c9", "role": "researcher", "email": "819028551@qq.com", "full_name": "Wade Zhu", "email_verified": true, "phone_verified": false}	\N	2025-12-06 12:37:58.907804+00	2025-12-06 15:13:50.930573+00	\N	\N			\N		0	\N		\N	f	\N	f
00000000-0000-0000-0000-000000000000	bcdaa16c-9e2d-41da-8d71-992255b8d8f9	authenticated	authenticated	userr8_1111@outlook.com	$2a$10$aaSfB7B0lMA35ebalnOYd.D2wt3mxtN0duLbBjk7ep7/c2dwGGQ8W	2025-12-07 02:00:49.501011+00	\N		\N		\N			\N	2025-12-07 02:54:04.265301+00	{"provider": "email", "providers": ["email"]}	{"sub": "bcdaa16c-9e2d-41da-8d71-992255b8d8f9", "role": "researcher", "email": "userr8_1111@outlook.com", "full_name": "孙天澍", "email_verified": true, "phone_verified": false}	\N	2025-12-07 02:00:49.493357+00	2025-12-07 02:54:04.268338+00	\N	\N			\N		0	\N		\N	f	\N	f
00000000-0000-0000-0000-000000000000	fe96e8e5-9e67-4c02-9ff4-1ddcbbc4ee89	authenticated	authenticated	userr9_1111@outlook.com	$2a$10$t595T38RRQKtr1d7HO595evhOLY4mQ8PjKBxCw8K0XBli5bRW9F1W	2025-12-07 02:27:24.389257+00	\N		\N		\N			\N	2025-12-07 02:27:24.399885+00	{"provider": "email", "providers": ["email"]}	{"sub": "fe96e8e5-9e67-4c02-9ff4-1ddcbbc4ee89", "role": "researcher", "email": "userr9_1111@outlook.com", "full_name": "Frank.Li", "email_verified": true, "phone_verified": false}	\N	2025-12-07 02:27:24.380886+00	2025-12-07 02:27:24.402873+00	\N	\N			\N		0	\N		\N	f	\N	f
00000000-0000-0000-0000-000000000000	1a1b09cb-aa1b-4fb9-a83c-871eb9675be4	authenticated	authenticated	userr10_1111@outlook.com	$2a$10$UuARzhLeFDPA8LVJKM4OfubZ.3sWe0pTDe9TB2wy6cb9R5Bw3qIBW	2025-12-07 02:38:54.499009+00	\N		\N		\N			\N	2025-12-07 02:38:54.509914+00	{"provider": "email", "providers": ["email"]}	{"sub": "1a1b09cb-aa1b-4fb9-a83c-871eb9675be4", "role": "researcher", "email": "userr10_1111@outlook.com", "full_name": "Gavin.Wang", "email_verified": true, "phone_verified": false}	\N	2025-12-07 02:38:54.491128+00	2025-12-07 02:38:54.513006+00	\N	\N			\N		0	\N		\N	f	\N	f
00000000-0000-0000-0000-000000000000	7867d1c5-9496-485c-bf4e-f5e80b3386d3	authenticated	authenticated	userr11_1111@outlook.com	$2a$10$lS.W0kkKaA/iMa6r2z9mwuMdAGQjREG8Y8AiGPOWbzF/hPnicpS.S	2025-12-07 02:39:26.902767+00	\N		\N		\N			\N	2025-12-07 02:39:26.914811+00	{"provider": "email", "providers": ["email"]}	{"sub": "7867d1c5-9496-485c-bf4e-f5e80b3386d3", "role": "researcher", "email": "userr11_1111@outlook.com", "full_name": "Wang.Jin", "email_verified": true, "phone_verified": false}	\N	2025-12-07 02:39:26.893413+00	2025-12-07 02:39:26.917982+00	\N	\N			\N		0	\N		\N	f	\N	f
\.


--
-- Data for Name: coze_workflows; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.coze_workflows (id, workflow_id, name, description, created_at, api_key, researcher_ids, owner_id, type) FROM stdin;
27	7572087336784101376	创意启发与内容思路Workflow	生成活动方案、提炼兴趣与顾虑点	2025-12-07 10:35:20.55683+00	sHeeyAp3Mxgpff5ZUAPRn9Ka6VJGhzCqU5icZWf3XPk+ceamwEw55rhL3Ja5dTX6VfZucz4w2YMeDEvjXvr+pgGWwBmU8hI6OiVz3b/uQYSmSVUEJY0WHD2xMRA8sfH0	{f64611ca-6a4d-42dd-ac81-c2c91b190dd0}	f64611ca-6a4d-42dd-ac81-c2c91b190dd0	workflow
28	7572092413632577536	文本写作与优化Workflow	协助写出完整宣传文案	2025-12-07 10:37:49.828655+00	xz5D20fuZJG0s+WwOapBvvWBGJDkxr2zmMmjnH1wtb8ypMYjGk/LOUdEqBNseojXvGncYnG9PcOTg//GGxLw9VwNo8C0OiCuUitffnNps9VGREAl1XOFH9hK7Sr+Ooa6	{f64611ca-6a4d-42dd-ac81-c2c91b190dd0}	f64611ca-6a4d-42dd-ac81-c2c91b190dd0	workflow
29	7572114723546595328	风险检查与内容修订Workflow	检查并修改风险内容，输出安全版本	2025-12-07 10:39:43.793955+00	fPsagGidOP12r/dKbxeKvrkFHjLgEAVgroOmPfL1EU7XPWD3zx7aSJTgXyPDKhnreeGnHqZOwsjRR2CyICOJPin3V32358RSHCbMotjBeTww9YMkFzeulpwffg/P37lH	{f64611ca-6a4d-42dd-ac81-c2c91b190dd0}	f64611ca-6a4d-42dd-ac81-c2c91b190dd0	workflow
30	7580284403985678336	App_Idea_Generator_1		2025-12-07 10:52:12.665982+00	5P56M3h3dCanDeEdeASFj53zjcMr4/sU9ARafm3l52v+UuqbBhQMRLpzC03Um+68RkyY4TtLZAWGV/WVnuXjp0wqgDZ/6bvCSbNK/H9mk7pjyrk/ORjByWTwkDibuQc0	{0399fa1a-4045-425b-b514-dfd8fb44f233}	0399fa1a-4045-425b-b514-dfd8fb44f233	workflow
\.


--
-- Data for Name: experiment_sessions; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.experiment_sessions (session_id, experiment_id, participant_id, status, current_node_id, created_at, updated_at) FROM stdin;
33	2	cb7c8d0f-1838-4fdd-81aa-0348e7781fec	in_progress	node-b8134d17-6f97-43e5-abf7-7854bafc73a6	2025-11-17 07:58:43.45227+00	2025-11-17 08:04:15.844+00
32	2	6f18071a-1a54-4d65-9e00-43633e4ae8d5	not_started	\N	2025-11-17 07:58:43.45227+00	2025-11-17 07:58:43.45227+00
123	70	f5f0f0a1-0672-4673-ae01-cdd187fcc4cd	completed	\N	2025-12-06 13:51:04.944191+00	2025-12-06 15:01:54.225+00
125	71	d35ed0e7-12b8-4f0d-9d72-e72125816810	in_progress	node-miua7q2o-qi2ahlek	2025-12-06 13:51:05.031791+00	2025-12-06 15:15:03.185+00
128	62	ce008f4b-dfe9-4301-a844-fe7d337dd1c5	completed	\N	2025-12-06 13:51:05.230147+00	2025-12-06 15:18:00.959+00
120	56	d35ed0e7-12b8-4f0d-9d72-e72125816810	not_started	\N	2025-12-05 11:22:02.55005+00	2025-12-05 11:22:02.55005+00
121	56	c3ed6099-2c74-44c9-bdaf-ba9091766d62	not_started	\N	2025-12-05 11:22:02.55005+00	2025-12-05 11:22:02.55005+00
122	8	ce008f4b-dfe9-4301-a844-fe7d337dd1c5	not_started	\N	2025-12-05 11:22:02.592572+00	2025-12-05 11:22:02.592572+00
118	55	5acbb4bd-563e-4a64-a674-edda518cfaf0	completed	\N	2025-12-05 11:22:02.509534+00	2025-12-05 11:28:17.231+00
124	70	5acbb4bd-563e-4a64-a674-edda518cfaf0	not_started	\N	2025-12-06 13:51:04.944191+00	2025-12-06 13:51:04.944191+00
126	72	6cdba011-5883-4b7d-89f4-ea9a1bcacc55	not_started	\N	2025-12-06 13:51:05.130698+00	2025-12-06 13:51:05.130698+00
127	72	c3ed6099-2c74-44c9-bdaf-ba9091766d62	not_started	\N	2025-12-06 13:51:05.130698+00	2025-12-06 13:51:05.130698+00
108	3	525d29ed-3bcf-41f4-9d81-f3ab5f038122	completed	\N	2025-11-28 09:24:06.955167+00	2025-11-28 09:24:49.47+00
87	26	fdb2e0d6-01ca-422a-84bb-ed841c9480e6	completed	\N	2025-11-26 07:10:54.995982+00	2025-12-02 07:09:22.578+00
115	39	fdb2e0d6-01ca-422a-84bb-ed841c9480e6	not_started	\N	2025-12-04 09:16:36.272256+00	2025-12-04 09:16:36.272256+00
117	54	6cdba011-5883-4b7d-89f4-ea9a1bcacc55	not_started	\N	2025-12-05 11:22:02.450807+00	2025-12-05 11:22:02.450807+00
119	55	f5f0f0a1-0672-4673-ae01-cdd187fcc4cd	not_started	\N	2025-12-05 11:22:02.509534+00	2025-12-05 11:22:02.509534+00
\.


--
-- Data for Name: experiments; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.experiments (experiment_id, title, workflow_json, researcher_id, evaluation_config) FROM stdin;
7	test_YJ	{"edges": [], "nodes": []}	4c162250-6d2a-491c-9ea6-5f96332dd929	{"dimensions": [], "overallFeedback": {"prompt": "", "enabled": false}}
2	exp1	{"edges": [{"id": "xy-edge__dndnode_6c46a2a27-f0c3-452c-9fbb-4bd00f50260b-dndnode_3input", "data": {"condition": "lastOutput?.[\\"department\\"] === '销售'", "edgeLabel": "department = '销售'", "isDefault": false, "conditionDisplay": "lastOutput?.[\\"department\\"] = '销售'"}, "label": "department = '销售'", "source": "dndnode_6", "target": "dndnode_3", "sourceHandle": "c46a2a27-f0c3-452c-9fbb-4bd00f50260b", "targetHandle": "input"}, {"id": "xy-edge__dndnode_9output-dndnode_10input", "source": "dndnode_9", "target": "dndnode_10", "sourceHandle": "output", "targetHandle": "input"}, {"id": "xy-edge__dndnode_3output-dndnode_9input", "source": "dndnode_3", "target": "dndnode_9", "sourceHandle": "output", "targetHandle": "input"}, {"id": "xy-edge__dndnode_1start-output-node-9a149b44-63fa-42f0-a0cc-b3a7ac04ec60input", "source": "dndnode_1", "target": "node-9a149b44-63fa-42f0-a0cc-b3a7ac04ec60", "sourceHandle": "start-output", "targetHandle": "input"}, {"id": "xy-edge__node-9a149b44-63fa-42f0-a0cc-b3a7ac04ec60output-dndnode_6input", "source": "node-9a149b44-63fa-42f0-a0cc-b3a7ac04ec60", "target": "dndnode_6", "sourceHandle": "output", "targetHandle": "input"}, {"id": "xy-edge__dndnode_63e8962fc-786f-4d22-81de-d414dbefb050-node-15de56ef-ac53-492d-97dc-b886c62c6f95input", "data": {"condition": "lastOutput?.[\\"department\\"] === '研发'", "edgeLabel": "department = '研发'", "isDefault": false, "conditionDisplay": "lastOutput?.[\\"department\\"] = '研发'"}, "label": "department = '研发'", "source": "dndnode_6", "target": "node-15de56ef-ac53-492d-97dc-b886c62c6f95", "sourceHandle": "3e8962fc-786f-4d22-81de-d414dbefb050", "targetHandle": "input"}, {"id": "xy-edge__dndnode_6493ad8e5-4aa9-4650-a5d2-8f5babd0e888-node-ae291f71-9d20-4ecb-8d8f-6399a82598c6input", "data": {"condition": "", "edgeLabel": "其他", "isDefault": true, "conditionDisplay": ""}, "label": "其他", "source": "dndnode_6", "target": "node-ae291f71-9d20-4ecb-8d8f-6399a82598c6", "sourceHandle": "493ad8e5-4aa9-4650-a5d2-8f5babd0e888", "targetHandle": "input"}, {"id": "xy-edge__node-15de56ef-ac53-492d-97dc-b886c62c6f95output-dndnode_9input", "source": "node-15de56ef-ac53-492d-97dc-b886c62c6f95", "target": "dndnode_9", "sourceHandle": "output", "targetHandle": "input"}, {"id": "xy-edge__node-ae291f71-9d20-4ecb-8d8f-6399a82598c6output-dndnode_9input", "source": "node-ae291f71-9d20-4ecb-8d8f-6399a82598c6", "target": "dndnode_9", "sourceHandle": "output", "targetHandle": "input"}, {"id": "xy-edge__dndnode_10output-node-b8cfb4c6-f9da-4581-b87a-f9f4355cb725input", "source": "dndnode_10", "target": "node-b8cfb4c6-f9da-4581-b87a-f9f4355cb725", "sourceHandle": "output", "targetHandle": "input"}, {"id": "xy-edge__node-b8cfb4c6-f9da-4581-b87a-f9f4355cb725output-node-b8134d17-6f97-43e5-abf7-7854bafc73a6end-input", "source": "node-b8cfb4c6-f9da-4581-b87a-f9f4355cb725", "target": "node-b8134d17-6f97-43e5-abf7-7854bafc73a6", "sourceHandle": "output", "targetHandle": "end-input"}], "nodes": [{"id": "dndnode_6", "data": {"label": "[分支] 条件分流", "branches": [{"id": "c46a2a27-f0c3-452c-9fbb-4bd00f50260b", "label": "分支 1", "value": "销售", "operator": "equals", "variable": "department", "condition": "lastOutput?.[\\"department\\"] === '销售'", "edgeLabel": "department = '销售'", "isDefault": false, "valueType": "string", "conditionDisplay": "lastOutput?.[\\"department\\"] = '销售'"}, {"id": "3e8962fc-786f-4d22-81de-d414dbefb050", "label": "分支 2", "value": "研发", "operator": "equals", "variable": "department", "condition": "lastOutput?.[\\"department\\"] === '研发'", "edgeLabel": "department = '研发'", "isDefault": false, "valueType": "string", "conditionDisplay": "lastOutput?.[\\"department\\"] = '研发'"}, {"id": "493ad8e5-4aa9-4650-a5d2-8f5babd0e888", "label": "其他", "value": "", "operator": "equals", "variable": "", "condition": "", "edgeLabel": "其他", "isDefault": true, "valueType": "string", "conditionDisplay": ""}], "contextText": "", "inputVariableName": "input", "allowDefaultBranch": true}, "type": "branchNode", "position": {"x": -805.2285914719362, "y": -621.6602094673359}}, {"id": "dndnode_1", "data": {"label": "[启动] 活动宣传文案撰写", "contextText": "", "startObjective": " 公司已经为您所在的部门设定了活动目标和时长。您的任务是与AI协作，构思一个具体的活动形式，并为这场活动撰写一份生动、有趣的活动宣传文案，以吸引部门同事积极参与。", "startBackground": " 为推动AI战略落地，公司将针对不同职能部门，举办一系列“AI赋能”主题的内部文化活动。", "inputVariableName": "input", "startDeliverables": "请用一段话（50-80字）描述最终的活动形式；\\n请列举出您认为最核心的两个顾虑点、两个兴趣点\\n"}, "type": "startNode", "position": {"x": -816.2420205208158, "y": -912.3311634606075}}, {"id": "dndnode_3", "data": {"label": "[Human] 销售团队任务", "category": "human", "taskType": "brainstorming", "allowAgent": false, "contextText": "", "instruction": "- 活动主题： AI赋能客户洞察\\n- 活动目标： 帮助销售团队学习使用AI工具分析客户数据，挖掘潜在销售机会，提升销售效率。\\n- 活动时长： 约2小时（包含实操）\\n- 主要挑战： 如何清晰地展示AI工具的实用价值和易用性，让习惯于传统销售模式的同事愿意尝试新工具，并相信AI能真正帮助他们提升业绩。", "inputVariableName": "input"}, "type": "taskNode", "position": {"x": -1168.5675101945096, "y": -455.09250056639604}}, {"id": "dndnode_9", "data": {"label": "[Agent] 活动形式构思", "category": "agent", "allowAgent": false, "contextText": "", "workflow_id": "7572087336784101376", "inputVariableName": "topic", "evaluationWorkflowId": "7572087336784101376"}, "type": "taskNode", "position": {"x": -761.8788451709887, "y": -327.1524345718766}}, {"id": "dndnode_10", "data": {"label": "[Agent] 宣传文字写作", "category": "agent", "allowAgent": false, "contextText": "", "workflow_id": "7572092413632577536", "inputVariableName": "goal_or_topic", "evaluationWorkflowId": "7572347832489738240"}, "type": "taskNode", "position": {"x": -771.8299383019703, "y": -201.14805221466122}}, {"id": "dndnode_1", "data": {"label": "[启动] 活动宣传文案撰写", "contextText": "", "startObjective": " 公司已经为您所在的部门设定了活动目标和时长。您的任务是与AI协作，构思一个具体的活动形式，并为这场活动撰写一份生动、有趣的活动宣传文案，以吸引部门同事积极参与。", "startBackground": " 为推动AI战略落地，公司将针对不同职能部门，举办一系列“AI赋能”主题的内部文化活动。", "inputVariableName": "input", "startDeliverables": "请用一段话（50-80字）描述最终的活动形式；\\n请列举出您认为最核心的两个顾虑点、两个兴趣点\\n"}, "type": "startNode", "position": {"x": -816.2420205208158, "y": -912.3311634606075}}, {"id": "dndnode_9", "data": {"label": "[Agent] 活动形式构思", "category": "agent", "allowAgent": false, "contextText": "", "workflow_id": "7572087336784101376", "inputVariableName": "topic", "evaluationWorkflowId": "7572087336784101376"}, "type": "taskNode", "position": {"x": -761.8788451709887, "y": -327.1524345718766}}, {"id": "dndnode_10", "data": {"label": "[Agent] 宣传文字写作", "category": "agent", "allowAgent": false, "contextText": "", "workflow_id": "7572092413632577536", "inputVariableName": "goal_or_topic", "evaluationWorkflowId": "7572347832489738240"}, "type": "taskNode", "position": {"x": -771.8299383019703, "y": -201.14805221466122}}, {"id": "node-9a149b44-63fa-42f0-a0cc-b3a7ac04ec60", "data": {"label": "[Human] 员工信息输入", "variables": [{"id": "f2624b42-934c-499d-a363-aafa3201e7a5", "key": "department", "note": "", "label": "", "options": [], "varType": "string", "required": false, "inputType": "text"}], "contextText": "", "inputVariableName": "input"}, "type": "infoNode", "position": {"x": -792.2734803521641, "y": -755.2019253624576}}, {"id": "node-15de56ef-ac53-492d-97dc-b886c62c6f95", "data": {"label": "[Human] 研发任务任务", "category": "human", "taskType": "brainstorming", "allowAgent": false, "contextText": "", "instruction": "- 活动主题： AI加速新药发现\\n- 活动目标： 介绍AI在靶点发现、化合物筛选等领域的最新应用，激发研发人员的创新思路。\\n- 活动时长： 约1.5小时\\n- 主要挑战： 如何将高度专业、前沿的技术内容，包装得不那么枯燥，并清晰地传达出对日常研发工作的实际价值，以吸引忙碌的研发人员参与", "inputVariableName": "input"}, "type": "taskNode", "position": {"x": -713.0792711153232, "y": -438.4250884150938}}, {"id": "node-ae291f71-9d20-4ecb-8d8f-6399a82598c6", "data": {"label": "[Human] 其他团队任务", "category": "human", "allowAgent": false, "contextText": "", "inputVariableName": "input"}, "type": "taskNode", "position": {"x": -419.2115234713459, "y": -419.0899820927022}}, {"id": "node-b8cfb4c6-f9da-4581-b87a-f9f4355cb725", "data": {"label": "[Agent] 安全检查", "category": "agent", "allowAgent": false, "contextText": "", "workflow_id": "7572114723546595328", "inputVariableName": "input"}, "type": "taskNode", "position": {"x": -679.1063228494847, "y": -28.605868738515028}}, {"id": "node-b8134d17-6f97-43e5-abf7-7854bafc73a6", "data": {"label": "[结束] 流程终点", "contextText": "", "inputVariableName": "input"}, "type": "endNode", "position": {"x": -705.4987552344327, "y": 107.08727296893822}}]}	f64611ca-6a4d-42dd-ac81-c2c91b190dd0	{"dimensions": [{"id": "733232c3-c286-4d01-a6ab-f20a69e5c687", "name": "创造性", "evaluator": "human", "scoreScale": 5, "description": "", "llmWorkflowId": "", "scoringMethod": "5分制"}, {"id": "5c9686e7-d73b-471c-a916-4ad8f56e0cf3", "name": "完整性", "evaluator": "human", "scoreScale": 5, "description": "", "llmWorkflowId": "", "scoringMethod": "5分制"}], "overallFeedback": {"prompt": "", "enabled": false}}
28	exp3	{"edges": [{"id": "xy-edge__node-mie2mjxz-8zty95ofstart-output-node-mie2mpw7-btakrbjninput", "source": "node-mie2mjxz-8zty95of", "target": "node-mie2mpw7-btakrbjn", "sourceHandle": "start-output", "targetHandle": "input"}, {"id": "xy-edge__node-mie2mpw7-btakrbjnoutput-node-mie2mnrq-2lqa70wvend-input", "source": "node-mie2mpw7-btakrbjn", "target": "node-mie2mnrq-2lqa70wv", "sourceHandle": "output", "targetHandle": "end-input"}], "nodes": [{"id": "node-mie2mjxz-8zty95of", "data": {"label": "[启动] 实验简介", "startObjective": "", "startBackground": "", "startDeliverables": ""}, "type": "startNode", "position": {"x": -777.4777435579716, "y": -923.5894200411899}}, {"id": "node-mie2mnrq-2lqa70wv", "data": {"label": "[结束] 流程终点"}, "type": "endNode", "position": {"x": -749.4840929189486, "y": -643.2243211131993}}, {"id": "node-mie2mpw7-btakrbjn", "data": {"label": "[Human] 信息输入", "variables": [{"id": "info-92t641wz", "key": "income", "note": "", "label": "收入", "options": [{"label": "1-20", "value": "1-20"}, {"label": "20-40", "value": "20-40"}], "varType": "string", "required": false, "inputType": "select"}, {"id": "info-v5wk5b1z", "key": "height", "note": "", "label": "身高", "options": [{"label": "160", "value": "160"}, {"label": "180", "value": "180"}], "varType": "string", "required": false, "inputType": "select"}], "contextText": "", "inputVariableName": "input"}, "type": "infoNode", "position": {"x": -754.2436748714376, "y": -847.3096641176159}}]}	f64611ca-6a4d-42dd-ac81-c2c91b190dd0	{"dimensions": [], "overallFeedback": {"prompt": "", "enabled": false}}
54	Delegation Decision_S1_G1b	{"edges": [{"id": "xy-edge__node-miedmup9-b238794ioutput-node-mi7973bg-8w6fj9fminput", "source": "node-miedmup9-b238794i", "target": "node-mi7973bg-8w6fj9fm", "sourceHandle": "output", "targetHandle": "input"}, {"id": "xy-edge__node-mi7973bg-8w6fj9fmoutput-node-miiginej-0lyp2e6yinput", "source": "node-mi7973bg-8w6fj9fm", "target": "node-miiginej-0lyp2e6y", "sourceHandle": "output", "targetHandle": "input"}, {"id": "xy-edge__node-miiginej-0lyp2e6youtput-node-miee3r6p-gn7l49u9end-input", "source": "node-miiginej-0lyp2e6y", "target": "node-miee3r6p-gn7l49u9", "sourceHandle": "output", "targetHandle": "end-input"}, {"id": "xy-edge__node-mi795m91-xkrbgdj2start-output-node-mislx1qn-xp8oqzciinput", "source": "node-mi795m91-xkrbgdj2", "target": "node-mislx1qn-xp8oqzci", "sourceHandle": "start-output", "targetHandle": "input"}, {"id": "xy-edge__node-mislx1qn-xp8oqzcioutput-node-miedmup9-b238794iinput", "source": "node-mislx1qn-xp8oqzci", "target": "node-miedmup9-b238794i", "sourceHandle": "output", "targetHandle": "input"}], "nodes": [{"id": "node-mi795m91-xkrbgdj2", "data": {"label": "[启动] 实验简介", "startObjective": "提出一个创新的APP创意，该 App 旨在促进更健康的生活方式", "startBackground": "想象你正在为一家名为\\"博伦科技\\"的公司工作。该公司正在寻求创新的 App 概念，以响应消费者对数字健康工具日益增长的需求，帮助用户过上更健康的生活。", "inputVariableName": "input", "startDeliverables": "APP产品创意文案"}, "type": "startNode", "position": {"x": 759.2561607714201, "y": 493.63739796654085}}, {"id": "node-mi7973bg-8w6fj9fm", "data": {"label": "被试自评", "variables": [{"id": "info-xl40jnto", "key": "self_perceived_creativity", "note": "", "label": "请您评价自己是一个富有创造力的人的程度", "options": [], "varType": "string", "required": true, "inputType": "rating"}, {"id": "info-jqhua8w7", "key": "familiarity_GPT", "note": "", "label": "在日常生活中，您使用 ChatGPT 的频率是？", "options": [{"label": "从不使用", "value": "从不使用"}, {"label": "很少使用（每月几次）", "value": "很少使用（每月几次）"}, {"label": "有时使用（每周几次）", "value": "有时使用（每周几次）"}, {"label": "经常使用（几乎每天）", "value": "经常使用（几乎每天）"}], "varType": "string", "required": true, "inputType": "radio"}, {"id": "info-h3av96it", "key": "domain_knowledge", "note": "1（完全不了解）\\n5（非常熟悉）", "label": "您对市场上与健康、健身相关的移动应用程序（例如：Keep, MyFitnessPal, 苹果健康等）有多熟悉？", "options": [], "varType": "string", "required": true, "inputType": "rating"}, {"id": "info-tf6d20kf", "key": "writing_skill", "note": "1（写作能力很弱）\\n5（写作能力很强）", "label": "请您评价自己的文字写作能力（例如：表达清晰度、词汇丰富度、逻辑性等）。", "options": [], "varType": "string", "required": true, "inputType": "rating"}], "contextText": "", "inputVariableName": "input"}, "type": "infoNode", "position": {"x": 612.5234747267325, "y": 870.6156277231825}}, {"id": "node-miedmup9-b238794i", "data": {"label": "任务二-Idea Refinement", "category": "human", "taskType": "writing", "allowAgent": true, "contextText": "", "instruction": "现在你已经有了一个初始创意。在这个阶段，你将与一位 AI 助手合作，对这个创意进行打磨、润色和改进。\\n\\n你可以通过右侧的聊天界面与 AI 自由互动。当你对结果满意时，请提交最终版本的创意。", "outputEditorType": "plaintext", "copilotWorkflowId": "7579907154346246144", "inputVariableName": "input", "evaluationDimensions": [{"id": "branch-zplycd7x", "name": "创意度", "prompt": "", "evaluator": "llm", "scoreScale": 5, "description": "这个创意是否新颖、独特，与现有的 App 不同？", "llmWorkflowId": "7572347832489738240"}, {"id": "branch-9rfm4lxj", "name": "写作质量", "prompt": "", "evaluator": "llm", "scoreScale": 5, "description": "这个创意的表达是否清晰、流畅？", "llmWorkflowId": "7572347832489738240"}, {"id": "branch-1uwoyz50", "name": "购买/使用意愿", "prompt": "", "evaluator": "llm", "scoreScale": 5, "description": "如果这款 App 上线，你有多大可能会下载使用？", "llmWorkflowId": "7572347832489738240"}, {"id": "branch-1wgjeuf1", "name": "预测流行度", "prompt": "", "evaluator": "llm", "scoreScale": 5, "description": "你认为这款 App 会受到大众市场的欢迎吗？", "llmWorkflowId": "7572347832489738240"}], "evaluationWorkflowId": "7576114694956515328"}, "type": "taskNode", "position": {"x": 808.275311058852, "y": 775.8077305995532}}, {"id": "node-miee3r6p-gn7l49u9", "data": {"label": "[结束] 流程终点", "contextText": "", "inputVariableName": "input"}, "type": "endNode", "position": {"x": 780.2939620144369, "y": 1875.8189639680124}}, {"id": "node-miiginej-0lyp2e6y", "data": {"label": "demographic信息填写", "variables": [{"id": "info-itbi0le0", "key": "gender", "note": "", "label": "gender", "options": [{"label": "男", "value": "男"}, {"label": "女", "value": "女"}, {"label": "非二元性别", "value": "非二元性别"}], "varType": "string", "required": true, "inputType": "radio"}, {"id": "info-satlj9xx", "key": "age", "note": "", "label": "年龄", "options": [{"label": "18-24岁", "value": "18-24岁"}, {"label": "25-34岁", "value": "25-34岁"}, {"label": "35-44岁", "value": "35-44岁"}, {"label": "45-54岁", "value": "45-54岁"}, {"label": "55-64岁", "value": "55-64岁"}, {"label": "65岁及以上", "value": "65岁及以上"}], "varType": "string", "required": true, "inputType": "select"}, {"id": "info-a6dqotkc", "key": "martial status", "note": "", "label": "婚姻状况", "options": [{"label": "已婚", "value": "已婚"}, {"label": "未婚", "value": "未婚"}, {"label": "离异", "value": "离异"}], "varType": "string", "required": true, "inputType": "radio"}, {"id": "info-v4e2rs94", "key": "education", "note": "", "label": "受教育程度", "options": [{"label": "高中及以下", "value": "高中及以下"}, {"label": "大专", "value": "大专"}, {"label": "本科", "value": "本科"}, {"label": "硕士", "value": "硕士"}, {"label": "博士", "value": "博士"}], "varType": "string", "required": true, "inputType": "radio"}, {"id": "info-2s5by0rh", "key": "employment status", "note": "", "label": "就业状况", "options": [{"label": "全职工作", "value": "全职工作"}, {"label": "兼职工作", "value": "兼职工作"}, {"label": "无工作", "value": "无工作"}], "varType": "string", "required": true, "inputType": "select"}, {"id": "info-hu5zhhhz", "key": "income", "note": "", "label": "收入", "options": [{"label": "<5000/月", "value": "<5000/月"}, {"label": "5000-10000/月", "value": "5000-10000/月"}, {"label": "10000-20000/月", "value": "10000-20000/月"}, {"label": "20000-30000/月", "value": "20000-30000/月"}, {"label": "30000-40000/月", "value": "30000-40000/月"}, {"label": ">40000/月", "value": ">40000/月"}], "varType": "string", "required": true, "inputType": "select"}], "contextText": "", "inputVariableName": "input"}, "type": "infoNode", "position": {"x": 786.7550098023947, "y": 1240.0253009814921}}, {"id": "node-mislx1qn-xp8oqzci", "data": {"label": "[Agent] 任务", "category": "agent", "allowAgent": false, "contextText": "", "workflow_id": "7580284403985678336", "inputVariableName": "input", "evaluationDimensions": [{"id": "branch-68zuhz39", "name": "创意度", "prompt": "", "evaluator": "llm", "scoreScale": 5, "description": "这个创意是否新颖、独特，与现有的 App 不同？", "llmWorkflowId": "7572347832489738240"}, {"id": "branch-09idx0tf", "name": "写作质量", "prompt": "", "evaluator": "llm", "scoreScale": 5, "description": "这个创意的表达是否清晰、流畅？", "llmWorkflowId": "7572347832489738240"}, {"id": "branch-tdm5svua", "name": "购买/使用意愿", "prompt": "", "evaluator": "llm", "scoreScale": 5, "description": "如果这款 App 上线，你有多大可能会下载使用？", "llmWorkflowId": "7572347832489738240"}, {"id": "branch-ou6iwhrc", "name": "预测流行度", "prompt": "", "evaluator": "llm", "scoreScale": 5, "description": "你认为这款 App 会受到大众市场的欢迎吗？", "llmWorkflowId": "7572347832489738240"}]}, "type": "taskNode", "position": {"x": 841.7411044457905, "y": 661.7292229830088}}]}	0399fa1a-4045-425b-b514-dfd8fb44f233	{"dimensions": [], "overallFeedback": {"prompt": "", "enabled": false}}
55	Delegation Decision_S1_G2	{"edges": [{"id": "xy-edge__node-miedmup9-b238794ioutput-node-mi7973bg-8w6fj9fminput", "source": "node-miedmup9-b238794i", "target": "node-mi7973bg-8w6fj9fm", "sourceHandle": "output", "targetHandle": "input"}, {"id": "xy-edge__node-mi7973bg-8w6fj9fmoutput-node-miiginej-0lyp2e6yinput", "source": "node-mi7973bg-8w6fj9fm", "target": "node-miiginej-0lyp2e6y", "sourceHandle": "output", "targetHandle": "input"}, {"id": "xy-edge__node-miiginej-0lyp2e6youtput-node-miee3r6p-gn7l49u9end-input", "source": "node-miiginej-0lyp2e6y", "target": "node-miee3r6p-gn7l49u9", "sourceHandle": "output", "targetHandle": "end-input"}, {"id": "xy-edge__node-mi795m91-xkrbgdj2start-output-node-mism0r3m-xgh488jcinput", "source": "node-mi795m91-xkrbgdj2", "target": "node-mism0r3m-xgh488jc", "sourceHandle": "start-output", "targetHandle": "input"}, {"id": "xy-edge__node-mism0r3m-xgh488jcoutput-node-mism0r3m-7jjnz7o2input", "source": "node-mism0r3m-xgh488jc", "target": "node-mism0r3m-7jjnz7o2", "sourceHandle": "output", "targetHandle": "input"}, {"id": "xy-edge__node-mism0r3m-7jjnz7o2branch-4d5dl2fz-node-mism0r3m-aep1j8ieinput", "data": {"condition": "lastOutput?.[\\"user_decision\\"] === '不委托'", "edgeLabel": "user_decision = '不委托'", "isDefault": false, "conditionDisplay": "lastOutput?.[\\"user_decision\\"] = '不委托'"}, "label": "user_decision = '不委托'", "source": "node-mism0r3m-7jjnz7o2", "target": "node-mism0r3m-aep1j8ie", "sourceHandle": "branch-4d5dl2fz", "targetHandle": "input"}, {"id": "xy-edge__node-mism0r3m-7jjnz7o2branch-cgazzn78-node-mism0r3m-8qw8jbmginput", "data": {"condition": "lastOutput?.[\\"user_decision\\"] === '委托'", "edgeLabel": "user_decision = '委托'", "isDefault": true, "conditionDisplay": "lastOutput?.[\\"user_decision\\"] = '委托'"}, "label": "user_decision = '委托'", "source": "node-mism0r3m-7jjnz7o2", "target": "node-mism0r3m-8qw8jbmg", "sourceHandle": "branch-cgazzn78", "targetHandle": "input"}, {"id": "xy-edge__node-mism0r3m-aep1j8ieoutput-node-mism0r3m-b9px9rbkmerge-input", "source": "node-mism0r3m-aep1j8ie", "target": "node-mism0r3m-b9px9rbk", "sourceHandle": "output", "targetHandle": "merge-input"}, {"id": "xy-edge__node-mism0r3m-8qw8jbmgoutput-node-mism0r3m-b9px9rbkmerge-input", "source": "node-mism0r3m-8qw8jbmg", "target": "node-mism0r3m-b9px9rbk", "sourceHandle": "output", "targetHandle": "merge-input"}, {"id": "xy-edge__node-mism0r3m-b9px9rbkmerge-output-node-miedmup9-b238794iinput", "source": "node-mism0r3m-b9px9rbk", "target": "node-miedmup9-b238794i", "sourceHandle": "merge-output", "targetHandle": "input"}], "nodes": [{"id": "node-mi795m91-xkrbgdj2", "data": {"label": "[启动] 实验简介", "startObjective": "提出一个创新的APP创意，该 App 旨在促进更健康的生活方式", "startBackground": "想象你正在为一家名为\\"博伦科技\\"的公司工作。该公司正在寻求创新的 App 概念，以响应消费者对数字健康工具日益增长的需求，帮助用户过上更健康的生活。", "inputVariableName": "input", "startDeliverables": "APP产品创意文案"}, "type": "startNode", "position": {"x": 755.4615188829553, "y": 62.243415553709326}}, {"id": "node-mi7973bg-8w6fj9fm", "data": {"label": "被试自评", "variables": [{"id": "info-xl40jnto", "key": "self_perceived_creativity", "note": "", "label": "请您评价自己是一个富有创造力的人的程度", "options": [], "varType": "string", "required": true, "inputType": "rating"}, {"id": "info-jqhua8w7", "key": "familiarity_GPT", "note": "", "label": "在日常生活中，您使用 ChatGPT 的频率是？", "options": [{"label": "从不使用", "value": "从不使用"}, {"label": "很少使用（每月几次）", "value": "很少使用（每月几次）"}, {"label": "有时使用（每周几次）", "value": "有时使用（每周几次）"}, {"label": "经常使用（几乎每天）", "value": "经常使用（几乎每天）"}], "varType": "string", "required": true, "inputType": "radio"}, {"id": "info-h3av96it", "key": "domain_knowledge", "note": "1（完全不了解）\\n5（非常熟悉）", "label": "您对市场上与健康、健身相关的移动应用程序（例如：Keep, MyFitnessPal, 苹果健康等）有多熟悉？", "options": [], "varType": "string", "required": true, "inputType": "rating"}, {"id": "info-tf6d20kf", "key": "writing_skill", "note": "1（写作能力很弱）\\n5（写作能力很强）", "label": "请您评价自己的文字写作能力（例如：表达清晰度、词汇丰富度、逻辑性等）。", "options": [], "varType": "string", "required": true, "inputType": "rating"}], "contextText": "", "inputVariableName": "input"}, "type": "infoNode", "position": {"x": 612.5234747267325, "y": 870.6156277231825}}, {"id": "node-miedmup9-b238794i", "data": {"label": "任务二-Idea Refinement", "category": "human", "taskType": "writing", "allowAgent": true, "contextText": "", "instruction": "现在你已经有了一个初始创意。在这个阶段，你将与一位 AI 助手合作，对这个创意进行打磨、润色和改进。\\n\\n你可以通过右侧的聊天界面与 AI 自由互动。当你对结果满意时，请提交最终版本的创意。", "outputEditorType": "plaintext", "copilotWorkflowId": "7579907154346246144", "inputVariableName": "input", "evaluationDimensions": [{"id": "branch-zplycd7x", "name": "创意度", "prompt": "", "evaluator": "llm", "scoreScale": 5, "description": "这个创意是否新颖、独特，与现有的 App 不同？", "llmWorkflowId": "7572347832489738240"}, {"id": "branch-9rfm4lxj", "name": "写作质量", "prompt": "", "evaluator": "llm", "scoreScale": 5, "description": "这个创意的表达是否清晰、流畅？", "llmWorkflowId": "7572347832489738240"}, {"id": "branch-1uwoyz50", "name": "购买/使用意愿", "prompt": "", "evaluator": "llm", "scoreScale": 5, "description": "如果这款 App 上线，你有多大可能会下载使用？", "llmWorkflowId": "7572347832489738240"}, {"id": "branch-1wgjeuf1", "name": "预测流行度", "prompt": "", "evaluator": "llm", "scoreScale": 5, "description": "你认为这款 App 会受到大众市场的欢迎吗？", "llmWorkflowId": "7572347832489738240"}], "evaluationWorkflowId": "7576114694956515328"}, "type": "taskNode", "position": {"x": 808.275311058852, "y": 775.8077305995532}}, {"id": "node-miee3r6p-gn7l49u9", "data": {"label": "[结束] 流程终点", "contextText": "", "inputVariableName": "input"}, "type": "endNode", "position": {"x": 780.2939620144369, "y": 1875.8189639680124}}, {"id": "node-miiginej-0lyp2e6y", "data": {"label": "demographic信息填写", "variables": [{"id": "info-itbi0le0", "key": "gender", "note": "", "label": "gender", "options": [{"label": "男", "value": "男"}, {"label": "女", "value": "女"}, {"label": "非二元性别", "value": "非二元性别"}], "varType": "string", "required": true, "inputType": "radio"}, {"id": "info-satlj9xx", "key": "age", "note": "", "label": "年龄", "options": [{"label": "18-24岁", "value": "18-24岁"}, {"label": "25-34岁", "value": "25-34岁"}, {"label": "35-44岁", "value": "35-44岁"}, {"label": "45-54岁", "value": "45-54岁"}, {"label": "55-64岁", "value": "55-64岁"}, {"label": "65岁及以上", "value": "65岁及以上"}], "varType": "string", "required": true, "inputType": "select"}, {"id": "info-a6dqotkc", "key": "martial status", "note": "", "label": "婚姻状况", "options": [{"label": "已婚", "value": "已婚"}, {"label": "未婚", "value": "未婚"}, {"label": "离异", "value": "离异"}], "varType": "string", "required": true, "inputType": "radio"}, {"id": "info-v4e2rs94", "key": "education", "note": "", "label": "受教育程度", "options": [{"label": "高中及以下", "value": "高中及以下"}, {"label": "大专", "value": "大专"}, {"label": "本科", "value": "本科"}, {"label": "硕士", "value": "硕士"}, {"label": "博士", "value": "博士"}], "varType": "string", "required": true, "inputType": "radio"}, {"id": "info-2s5by0rh", "key": "employment status", "note": "", "label": "就业状况", "options": [{"label": "全职工作", "value": "全职工作"}, {"label": "兼职工作", "value": "兼职工作"}, {"label": "无工作", "value": "无工作"}], "varType": "string", "required": true, "inputType": "select"}, {"id": "info-hu5zhhhz", "key": "income", "note": "", "label": "收入", "options": [{"label": "<5000/月", "value": "<5000/月"}, {"label": "5000-10000/月", "value": "5000-10000/月"}, {"label": "10000-20000/月", "value": "10000-20000/月"}, {"label": "20000-30000/月", "value": "20000-30000/月"}, {"label": "30000-40000/月", "value": "30000-40000/月"}, {"label": ">40000/月", "value": ">40000/月"}], "varType": "string", "required": true, "inputType": "select"}], "contextText": "", "inputVariableName": "input"}, "type": "infoNode", "position": {"x": 786.7550098023947, "y": 1240.0253009814921}}, {"id": "node-mism0r3m-8qw8jbmg", "data": {"label": "委托给AI创作", "category": "agent", "allowAgent": false, "contextText": "", "workflow_id": "7580284403985678336", "inputVariableName": "input", "evaluationDimensions": [{"id": "branch-3sps6xr8", "name": "创意度", "prompt": "", "evaluator": "llm", "scoreScale": 5, "description": "这个创意是否新颖、独特，与现有的 App 不同？", "llmWorkflowId": "7572347832489738240"}, {"id": "branch-43iimxal", "name": "写作质量", "prompt": "", "evaluator": "llm", "scoreScale": 5, "description": "这个创意的表达是否清晰、流畅？", "llmWorkflowId": "7572347832489738240"}, {"id": "branch-aj9ua6ww", "name": "购买/使用意愿", "prompt": "", "evaluator": "llm", "scoreScale": 5, "description": "如果这款 App 上线，你有多大可能会下载使用？", "llmWorkflowId": "7572347832489738240"}, {"id": "branch-d5vfhclq", "name": "预测流行度", "prompt": "", "evaluator": "llm", "scoreScale": 5, "description": "你认为这款 App 会受到大众市场的欢迎吗？", "llmWorkflowId": "7572347832489738240"}], "evaluationWorkflowId": "7576114694956515328"}, "type": "taskNode", "position": {"x": 947.6364250378218, "y": 516.7934285793798}}, {"id": "node-mism0r3m-aep1j8ie", "data": {"label": "Human自主创作", "category": "human", "taskType": "brainstorming", "allowAgent": false, "contextText": "", "instruction": "1. 背景：想象你正在为一家名为\\"博伦科技\\"的公司工作。该公司正在寻求创新的 App 概念，以响应消费者对数字健康工具日益增长的需求，帮助用户过上更健康的生活。\\n\\n2. 任务要求：\\n请在下方文本框中详细描述您的 App 初始创意。\\n您必须完全依靠自己来构思和撰写，请勿使用任何 AI 工具。\\n\\n为了让您的创意更具说服力，建议您的描述包含以下内容（仅供参考）：\\n - App 名称：给它起一个响亮的名字。\\n - 核心功能：它能做什么？解决了什么问题？\\n - 目标用户：谁会使用它？", "copilotWorkflowId": "", "inputVariableName": "input", "evaluationDimensions": [{"id": "branch-bq77nr16", "name": "创意度", "prompt": "", "evaluator": "llm", "scoreScale": 5, "description": "这个创意是否新颖、独特，与现有的 App 不同？", "llmWorkflowId": "7572347832489738240"}, {"id": "branch-zmrcmbqj", "name": "写作质量", "prompt": "", "evaluator": "llm", "scoreScale": 5, "description": "这个创意的表达是否清晰、流畅？", "llmWorkflowId": "7572347832489738240"}, {"id": "branch-loadlmua", "name": "购买/使用意愿", "prompt": "", "evaluator": "llm", "scoreScale": 5, "description": "如果这款 App 上线，你有多大可能会下载使用？", "llmWorkflowId": "7572347832489738240"}, {"id": "branch-p92u6138", "name": "预测流行度", "prompt": "", "evaluator": "human", "scoreScale": 5, "description": "你认为这款 App 会受到大众市场的欢迎吗？", "llmWorkflowId": ""}], "evaluationWorkflowId": "7576114694956515328"}, "type": "taskNode", "position": {"x": 708.1929448632161, "y": 518.927640560393}}, {"id": "node-mism0r3m-7jjnz7o2", "data": {"label": "[分支] 条件分流", "branches": [{"id": "branch-4d5dl2fz", "label": "分支 1", "value": "不委托", "operator": "equals", "variable": "user_decision", "condition": "lastOutput?.[\\"user_decision\\"] === '不委托'", "edgeLabel": "user_decision = '不委托'", "isDefault": false, "valueType": "string", "conditionDisplay": "lastOutput?.[\\"user_decision\\"] = '不委托'"}, {"id": "branch-cgazzn78", "label": "其他", "value": "委托", "operator": "equals", "variable": "user_decision", "condition": "lastOutput?.[\\"user_decision\\"] === '委托'", "edgeLabel": "user_decision = '委托'", "isDefault": true, "valueType": "string", "conditionDisplay": "lastOutput?.[\\"user_decision\\"] = '委托'"}], "contextText": "", "inputVariableName": "input", "allowDefaultBranch": true}, "type": "branchNode", "position": {"x": 777.0669593286478, "y": 372.4315914306963}}, {"id": "node-mism0r3m-b9px9rbk", "data": {"label": "[汇聚] 分支合流", "contextText": "", "inputVariableName": "input"}, "type": "mergeNode", "position": {"x": 781.0478673212546, "y": 632.5288218071678}}, {"id": "node-mism0r3m-xgh488jc", "data": {"label": "[Human] 信息输入", "variables": [{"id": "info-za5orgmd", "key": "user_decision", "note": "", "label": "请您选择，是否把Idea的构思任务委托给AI完成？", "options": [{"label": "委托", "value": "委托"}, {"label": "不委托", "value": "不委托"}], "varType": "string", "required": true, "inputType": "radio"}], "contextText": "", "inputVariableName": "input"}, "type": "infoNode", "position": {"x": 747.3391318089707, "y": 212.88420681715644}}]}	0399fa1a-4045-425b-b514-dfd8fb44f233	{"dimensions": [], "overallFeedback": {"prompt": "", "enabled": false}}
71	Delegation Decision_Group1b	{"edges": [{"id": "xy-edge__node-miua7q2o-qi2ahlekoutput-node-miua89pi-yo1sqaafinput", "source": "node-miua7q2o-qi2ahlek", "target": "node-miua89pi-yo1sqaaf", "sourceHandle": "output", "targetHandle": "input"}, {"id": "xy-edge__node-miua89pi-yo1sqaafoutput-node-miua8n3s-6lyd0xizinput", "source": "node-miua89pi-yo1sqaaf", "target": "node-miua8n3s-6lyd0xiz", "sourceHandle": "output", "targetHandle": "input"}, {"id": "xy-edge__node-miua8n3s-6lyd0xizoutput-node-miua90fg-5xb2117hend-input", "source": "node-miua8n3s-6lyd0xiz", "target": "node-miua90fg-5xb2117h", "sourceHandle": "output", "targetHandle": "end-input"}, {"id": "xy-edge__node-miua719d-ejzi3dekstart-output-node-miucbs25-na4wm34kinput", "source": "node-miua719d-ejzi3dek", "target": "node-miucbs25-na4wm34k", "sourceHandle": "start-output", "targetHandle": "input"}, {"id": "xy-edge__node-miucbs25-na4wm34koutput-node-miua7q2o-qi2ahlekinput", "source": "node-miucbs25-na4wm34k", "target": "node-miua7q2o-qi2ahlek", "sourceHandle": "output", "targetHandle": "input"}], "nodes": [{"id": "node-miua719d-ejzi3dek", "data": {"label": "[启动] 实验简介", "startObjective": "提出一个创新的APP创意，该 App 旨在促进更健康的生活方式", "startBackground": "想象你正在为一家名为\\"博伦科技\\"的公司工作。该公司正在寻求创新的 App 概念，以响应消费者对数字健康工具日益增长的需求，帮助用户过上更健康的生活。", "inputVariableName": "input", "startDeliverables": "APP产品创意文案"}, "type": "startNode", "position": {"x": 397.95096892111826, "y": 11.770435144872106}}, {"id": "node-miua7q2o-qi2ahlek", "data": {"label": "Task 2: Idea Refinement", "category": "human", "taskType": "writing", "allowAgent": true, "contextText": "", "instruction": "现在你已经有了一个初始创意。在这个阶段，你将与一位 AI 助手合作，对这个创意进行打磨、润色和改进。\\n\\n你可以通过右侧的聊天界面与 AI 自由互动。当你对结果满意时，请提交最终版本的创意。", "copilotWorkflowId": "7579907154346246144", "inputVariableName": "input"}, "type": "taskNode", "position": {"x": 446.12233500718037, "y": 228.68305830541655}}, {"id": "node-miua89pi-yo1sqaaf", "data": {"label": "被试自评", "variables": [{"id": "info-uhr64sxo", "key": "self_perceived_creativity", "note": "1（创造力较低）5（创造力高）", "label": "请您评价自己是一个富有创造力的人的程度", "options": [], "varType": "string", "required": true, "inputType": "rating"}, {"id": "info-wq4q3bs1", "key": "familiarity_GPT", "note": "", "label": "在日常生活中，您使用 ChatGPT 的频率是？", "options": [{"label": "从不使用", "value": "从不使用"}, {"label": "很少使用（每月几次）", "value": "很少使用（每月几次）"}, {"label": "有时使用（每周几次）", "value": "有时使用（每周几次）"}, {"label": "经常使用（几乎每天）", "value": "经常使用（几乎每天）"}], "varType": "string", "required": true, "inputType": "radio"}, {"id": "info-g8qt52sz", "key": "domain_knowledge", "note": "1（完全不了解）\\n5（非常熟悉）", "label": "您对市场上与健康、健身相关的移动应用程序（例如：Keep, MyFitnessPal, 苹果健康等）有多熟悉？", "options": [], "varType": "string", "required": true, "inputType": "rating"}, {"id": "info-s5vob122", "key": "writing_skill", "note": "1（写作能力很弱）\\n5（写作能力很强）", "label": "请您评价自己的文字写作能力（例如：表达清晰度、词汇丰富度、逻辑性等）。", "options": [], "varType": "string", "required": true, "inputType": "rating"}], "contextText": "", "inputVariableName": "input"}, "type": "infoNode", "position": {"x": 252.87036645963553, "y": 302.3601641511546}}, {"id": "node-miua8n3s-6lyd0xiz", "data": {"label": "被试基本信息填写", "variables": [{"id": "info-6dp84pi9", "key": "gender", "note": "", "label": "性别", "options": [{"label": "男", "value": "男"}, {"label": "女", "value": "女"}, {"label": "非二元性别", "value": "非二元性别"}], "varType": "string", "required": true, "inputType": "radio"}, {"id": "info-ulr5moj4", "key": "age", "note": "", "label": "年龄", "options": [{"label": "18-24岁", "value": "18-24岁"}, {"label": "25-34岁", "value": "25-34岁"}, {"label": "35-44岁", "value": "35-44岁"}, {"label": "45-54岁", "value": "45-54岁"}, {"label": "55-64岁", "value": "55-64岁"}, {"label": "65岁及以上", "value": "65岁及以上"}], "varType": "string", "required": true, "inputType": "select"}, {"id": "info-pb5z9bkj", "key": "martial status", "note": "", "label": "婚姻状况", "options": [{"label": "已婚", "value": "已婚"}, {"label": "未婚", "value": "未婚"}, {"label": "离异", "value": "离异"}], "varType": "string", "required": true, "inputType": "radio"}, {"id": "info-1w7jhyyd", "key": "education", "note": "", "label": "受教育程度", "options": [{"label": "高中及以下", "value": "高中及以下"}, {"label": "大专", "value": "大专"}, {"label": "本科", "value": "本科"}, {"label": "硕士", "value": "硕士"}, {"label": "博士", "value": "博士"}], "varType": "string", "required": true, "inputType": "radio"}, {"id": "info-ao4914e2", "key": "employment status", "note": "", "label": "就业状况", "options": [{"label": "全职工作", "value": "全职工作"}, {"label": "兼职工作", "value": "兼职工作"}, {"label": "无工作", "value": "无工作"}], "varType": "string", "required": true, "inputType": "select"}, {"id": "info-w4pwfuw6", "key": "income", "note": "", "label": "收入", "options": [{"label": "<5000/月", "value": "<5000/月"}, {"label": "5000-10000/月", "value": "5000-10000/月"}, {"label": "10000-20000/月", "value": "10000-20000/月"}, {"label": "20000-30000/月", "value": "20000-30000/月"}, {"label": "30000-40000/月", "value": "30000-40000/月"}, {"label": ">40000/月", "value": ">40000/月"}], "varType": "string", "required": true, "inputType": "select"}], "contextText": "", "inputVariableName": "input"}, "type": "infoNode", "position": {"x": 427.6640550363355, "y": 697.7396032371796}}, {"id": "node-miua90fg-5xb2117h", "data": {"label": "[结束] 流程终点"}, "type": "endNode", "position": {"x": 422.79004521263573, "y": 1324.445921742916}}, {"id": "node-miucbs25-na4wm34k", "data": {"label": "Task 1: Idea Generation (AI-Lead)", "category": "agent", "allowAgent": false, "contextText": "", "workflow_id": "7580284403985678336", "inputVariableName": "input"}, "type": "taskNode", "position": {"x": 418.6872312538227, "y": 146.28902785653048}}]}	83cf7ae9-fd96-426c-9e26-effd554cc8c9	{"dimensions": [], "overallFeedback": {"prompt": "", "enabled": false}}
70	Delegation Decision_Group2	{"edges": [{"id": "xy-edge__node-miua7q2o-qi2ahlekoutput-node-miua89pi-yo1sqaafinput", "source": "node-miua7q2o-qi2ahlek", "target": "node-miua89pi-yo1sqaaf", "sourceHandle": "output", "targetHandle": "input"}, {"id": "xy-edge__node-miua89pi-yo1sqaafoutput-node-miua8n3s-6lyd0xizinput", "source": "node-miua89pi-yo1sqaaf", "target": "node-miua8n3s-6lyd0xiz", "sourceHandle": "output", "targetHandle": "input"}, {"id": "xy-edge__node-miua8n3s-6lyd0xizoutput-node-miua90fg-5xb2117hend-input", "source": "node-miua8n3s-6lyd0xiz", "target": "node-miua90fg-5xb2117h", "sourceHandle": "output", "targetHandle": "end-input"}, {"id": "xy-edge__node-miua719d-ejzi3dekstart-output-node-miucdltv-4yfnvoqhinput", "source": "node-miua719d-ejzi3dek", "target": "node-miucdltv-4yfnvoqh", "sourceHandle": "start-output", "targetHandle": "input"}, {"id": "xy-edge__node-miucdltv-4yfnvoqhoutput-node-miuceqty-7ygqto1yinput", "source": "node-miucdltv-4yfnvoqh", "target": "node-miuceqty-7ygqto1y", "sourceHandle": "output", "targetHandle": "input"}, {"id": "xy-edge__node-miuceqty-7ygqto1ybranch-1exivhp1-node-miua79hc-bpp0qxmyinput", "data": {"condition": "lastOutput?.[\\"user_decision\\"] === '不委托'", "edgeLabel": "user_decision = '不委托'", "isDefault": true, "conditionDisplay": "lastOutput?.[\\"user_decision\\"] = '不委托'"}, "label": "user_decision = '不委托'", "source": "node-miuceqty-7ygqto1y", "target": "node-miua79hc-bpp0qxmy", "sourceHandle": "branch-1exivhp1", "targetHandle": "input"}, {"id": "xy-edge__node-miuceqty-7ygqto1ybranch-29rck6fv-node-miucga2x-avn5qsuzinput", "data": {"condition": "lastOutput?.[\\"user_decision\\"] === '委托'", "edgeLabel": "user_decision = '委托'", "isDefault": false, "conditionDisplay": "lastOutput?.[\\"user_decision\\"] = '委托'"}, "label": "user_decision = '委托'", "source": "node-miuceqty-7ygqto1y", "target": "node-miucga2x-avn5qsuz", "sourceHandle": "branch-29rck6fv", "targetHandle": "input"}, {"id": "xy-edge__node-miucga2x-avn5qsuzoutput-node-miuch091-03pfvh61merge-input", "source": "node-miucga2x-avn5qsuz", "target": "node-miuch091-03pfvh61", "sourceHandle": "output", "targetHandle": "merge-input"}, {"id": "xy-edge__node-miua79hc-bpp0qxmyoutput-node-miuch091-03pfvh61merge-input", "source": "node-miua79hc-bpp0qxmy", "target": "node-miuch091-03pfvh61", "sourceHandle": "output", "targetHandle": "merge-input"}, {"id": "xy-edge__node-miuch091-03pfvh61merge-output-node-miua7q2o-qi2ahlekinput", "source": "node-miuch091-03pfvh61", "target": "node-miua7q2o-qi2ahlek", "sourceHandle": "merge-output", "targetHandle": "input"}], "nodes": [{"id": "node-miua719d-ejzi3dek", "data": {"label": "[启动] 实验简介", "startObjective": "提出一个创新的APP创意，该 App 旨在促进更健康的生活方式", "startBackground": "想象你正在为一家名为\\"博伦科技\\"的公司工作。该公司正在寻求创新的 App 概念，以响应消费者对数字健康工具日益增长的需求，帮助用户过上更健康的生活。", "inputVariableName": "input", "startDeliverables": "APP产品创意文案"}, "type": "startNode", "position": {"x": 397.18876565776225, "y": -560.5778186572563}}, {"id": "node-miua79hc-bpp0qxmy", "data": {"label": "Task 1: Idea Generation (Human-Lead)", "category": "human", "taskType": "brainstorming", "allowAgent": false, "contextText": "", "instruction": "1. 背景：想象你正在为一家名为\\"博伦科技\\"的公司工作。该公司正在寻求创新的 App 概念，以响应消费者对数字健康工具日益增长的需求，帮助用户过上更健康的生活。\\n\\n2. 任务要求：\\n请在下方文本框中详细描述您的 App 初始创意。\\n您必须完全依靠自己来构思和撰写，请勿使用任何 AI 工具。\\n\\n为了让您的创意更具说服力，建议您的描述包含以下内容（仅供参考）：\\n - App 名称：给它起一个响亮的名字。\\n - 核心功能：它能做什么？解决了什么问题？\\n - 目标用户：谁会使用它？", "inputVariableName": "input"}, "type": "taskNode", "position": {"x": 593.7128767507957, "y": -23.351582037734662}}, {"id": "node-miua7q2o-qi2ahlek", "data": {"label": "Task 2: Idea Refinement", "category": "human", "taskType": "writing", "allowAgent": true, "contextText": "", "instruction": "现在你已经有了一个初始创意。在这个阶段，你将与一位 AI 助手合作，对这个创意进行打磨、润色和改进。\\n\\n你可以通过右侧的聊天界面与 AI 自由互动。当你对结果满意时，请提交最终版本的创意。", "copilotWorkflowId": "7579907154346246144", "inputVariableName": "input"}, "type": "taskNode", "position": {"x": 446.12233500718037, "y": 226.68305817003625}}, {"id": "node-miua89pi-yo1sqaaf", "data": {"label": "被试自评", "variables": [{"id": "info-uhr64sxo", "key": "self_perceived_creativity", "note": "1（创造力较低）5（创造力高）", "label": "请您评价自己是一个富有创造力的人的程度", "options": [], "varType": "string", "required": true, "inputType": "rating"}, {"id": "info-wq4q3bs1", "key": "familiarity_GPT", "note": "", "label": "在日常生活中，您使用 ChatGPT 的频率是？", "options": [{"label": "从不使用", "value": "从不使用"}, {"label": "很少使用（每月几次）", "value": "很少使用（每月几次）"}, {"label": "有时使用（每周几次）", "value": "有时使用（每周几次）"}, {"label": "经常使用（几乎每天）", "value": "经常使用（几乎每天）"}], "varType": "string", "required": true, "inputType": "radio"}, {"id": "info-g8qt52sz", "key": "domain_knowledge", "note": "1（完全不了解）\\n5（非常熟悉）", "label": "您对市场上与健康、健身相关的移动应用程序（例如：Keep, MyFitnessPal, 苹果健康等）有多熟悉？", "options": [], "varType": "string", "required": true, "inputType": "rating"}, {"id": "info-s5vob122", "key": "writing_skill", "note": "1（写作能力很弱）\\n5（写作能力很强）", "label": "请您评价自己的文字写作能力（例如：表达清晰度、词汇丰富度、逻辑性等）。", "options": [], "varType": "string", "required": true, "inputType": "rating"}], "contextText": "", "inputVariableName": "input"}, "type": "infoNode", "position": {"x": 252.87036645963553, "y": 302.3601641511546}}, {"id": "node-miua8n3s-6lyd0xiz", "data": {"label": "被试基本信息填写", "variables": [{"id": "info-6dp84pi9", "key": "gender", "note": "", "label": "性别", "options": [{"label": "男", "value": "男"}, {"label": "女", "value": "女"}, {"label": "非二元性别", "value": "非二元性别"}], "varType": "string", "required": true, "inputType": "radio"}, {"id": "info-ulr5moj4", "key": "age", "note": "", "label": "年龄", "options": [{"label": "18-24岁", "value": "18-24岁"}, {"label": "25-34岁", "value": "25-34岁"}, {"label": "35-44岁", "value": "35-44岁"}, {"label": "45-54岁", "value": "45-54岁"}, {"label": "55-64岁", "value": "55-64岁"}, {"label": "65岁及以上", "value": "65岁及以上"}], "varType": "string", "required": true, "inputType": "select"}, {"id": "info-pb5z9bkj", "key": "martial status", "note": "", "label": "婚姻状况", "options": [{"label": "已婚", "value": "已婚"}, {"label": "未婚", "value": "未婚"}, {"label": "离异", "value": "离异"}], "varType": "string", "required": true, "inputType": "radio"}, {"id": "info-1w7jhyyd", "key": "education", "note": "", "label": "受教育程度", "options": [{"label": "高中及以下", "value": "高中及以下"}, {"label": "大专", "value": "大专"}, {"label": "本科", "value": "本科"}, {"label": "硕士", "value": "硕士"}, {"label": "博士", "value": "博士"}], "varType": "string", "required": true, "inputType": "radio"}, {"id": "info-ao4914e2", "key": "employment status", "note": "", "label": "就业状况", "options": [{"label": "全职工作", "value": "全职工作"}, {"label": "兼职工作", "value": "兼职工作"}, {"label": "无工作", "value": "无工作"}], "varType": "string", "required": true, "inputType": "select"}, {"id": "info-w4pwfuw6", "key": "income", "note": "", "label": "收入", "options": [{"label": "<5000/月", "value": "<5000/月"}, {"label": "5000-10000/月", "value": "5000-10000/月"}, {"label": "10000-20000/月", "value": "10000-20000/月"}, {"label": "20000-30000/月", "value": "20000-30000/月"}, {"label": "30000-40000/月", "value": "30000-40000/月"}, {"label": ">40000/月", "value": ">40000/月"}], "varType": "string", "required": true, "inputType": "select"}], "contextText": "", "inputVariableName": "input"}, "type": "infoNode", "position": {"x": 427.6640550363355, "y": 697.7396032371796}}, {"id": "node-miua90fg-5xb2117h", "data": {"label": "[结束] 流程终点"}, "type": "endNode", "position": {"x": 422.79004521263573, "y": 1324.445921742916}}, {"id": "node-miucdltv-4yfnvoqh", "data": {"label": "AI委托决策", "variables": [{"id": "info-epth9om1", "key": "user_decision", "note": "", "label": "请您选择，是否把Idea的构思任务委托给AI完成？", "options": [{"label": "委托", "value": "委托"}, {"label": "不委托", "value": "不委托"}], "varType": "string", "required": true, "inputType": "radio"}], "contextText": "", "inputVariableName": "input"}, "type": "infoNode", "position": {"x": 388.788774952552, "y": -416.33149181921715}}, {"id": "node-miuceqty-7ygqto1y", "data": {"label": "[分支] 条件分流", "branches": [{"id": "branch-29rck6fv", "label": "分支 1", "value": "委托", "operator": "equals", "variable": "user_decision", "condition": "lastOutput?.[\\"user_decision\\"] === '委托'", "edgeLabel": "user_decision = '委托'", "isDefault": false, "valueType": "string", "conditionDisplay": "lastOutput?.[\\"user_decision\\"] = '委托'"}, {"id": "branch-1exivhp1", "label": "其他", "value": "不委托", "operator": "equals", "variable": "user_decision", "condition": "lastOutput?.[\\"user_decision\\"] === '不委托'", "edgeLabel": "user_decision = '不委托'", "isDefault": true, "valueType": "string", "conditionDisplay": "lastOutput?.[\\"user_decision\\"] = '不委托'"}], "contextText": "", "inputVariableName": "input", "allowDefaultBranch": true}, "type": "branchNode", "position": {"x": 425.41820102693794, "y": -229.69097832485758}}, {"id": "node-miucga2x-avn5qsuz", "data": {"label": "Task 1: Idea Generation (AI-Lead)", "category": "agent", "allowAgent": false, "contextText": "", "workflow_id": "7580284403985678336", "inputVariableName": "input"}, "type": "taskNode", "position": {"x": 268.4181903995834, "y": -22.690964312995106}}, {"id": "node-miuch091-03pfvh61", "data": {"label": "[汇聚] 分支合流", "contextText": "", "inputVariableName": "input"}, "type": "mergeNode", "position": {"x": 420.4182006884872, "y": 80.30904265909102}}]}	83cf7ae9-fd96-426c-9e26-effd554cc8c9	{"dimensions": [], "overallFeedback": {"prompt": "", "enabled": false}}
56	Delegation Decision_S1_G3	{"edges": [{"id": "xy-edge__node-miedmup9-b238794ioutput-node-mi7973bg-8w6fj9fminput", "source": "node-miedmup9-b238794i", "target": "node-mi7973bg-8w6fj9fm", "sourceHandle": "output", "targetHandle": "input"}, {"id": "xy-edge__node-mi7973bg-8w6fj9fmoutput-node-miiginej-0lyp2e6yinput", "source": "node-mi7973bg-8w6fj9fm", "target": "node-miiginej-0lyp2e6y", "sourceHandle": "output", "targetHandle": "input"}, {"id": "xy-edge__node-miiginej-0lyp2e6youtput-node-miee3r6p-gn7l49u9end-input", "source": "node-miiginej-0lyp2e6y", "target": "node-miee3r6p-gn7l49u9", "sourceHandle": "output", "targetHandle": "end-input"}, {"id": "xy-edge__node-mi795m91-xkrbgdj2start-output-node-mism0r3m-xgh488jcinput", "source": "node-mi795m91-xkrbgdj2", "target": "node-mism0r3m-xgh488jc", "sourceHandle": "start-output", "targetHandle": "input"}, {"id": "xy-edge__node-mism0r3m-xgh488jcoutput-node-mism0r3m-7jjnz7o2input", "source": "node-mism0r3m-xgh488jc", "target": "node-mism0r3m-7jjnz7o2", "sourceHandle": "output", "targetHandle": "input"}, {"id": "xy-edge__node-mism0r3m-7jjnz7o2branch-4d5dl2fz-node-mism0r3m-aep1j8ieinput", "data": {"condition": "lastOutput?.[\\"user_decision\\"] === '不委托'", "edgeLabel": "user_decision = '不委托'", "isDefault": false, "conditionDisplay": "lastOutput?.[\\"user_decision\\"] = '不委托'"}, "label": "user_decision = '不委托'", "source": "node-mism0r3m-7jjnz7o2", "target": "node-mism0r3m-aep1j8ie", "sourceHandle": "branch-4d5dl2fz", "targetHandle": "input"}, {"id": "xy-edge__node-mism0r3m-7jjnz7o2branch-cgazzn78-node-mism0r3m-8qw8jbmginput", "data": {"condition": "lastOutput?.[\\"user_decision\\"] === '委托'", "edgeLabel": "user_decision = '委托'", "isDefault": true, "conditionDisplay": "lastOutput?.[\\"user_decision\\"] = '委托'"}, "label": "user_decision = '委托'", "source": "node-mism0r3m-7jjnz7o2", "target": "node-mism0r3m-8qw8jbmg", "sourceHandle": "branch-cgazzn78", "targetHandle": "input"}, {"id": "xy-edge__node-mism0r3m-aep1j8ieoutput-node-mism0r3m-b9px9rbkmerge-input", "source": "node-mism0r3m-aep1j8ie", "target": "node-mism0r3m-b9px9rbk", "sourceHandle": "output", "targetHandle": "merge-input"}, {"id": "xy-edge__node-mism0r3m-8qw8jbmgoutput-node-mism0r3m-b9px9rbkmerge-input", "source": "node-mism0r3m-8qw8jbmg", "target": "node-mism0r3m-b9px9rbk", "sourceHandle": "output", "targetHandle": "merge-input"}, {"id": "xy-edge__node-mism0r3m-b9px9rbkmerge-output-node-miedmup9-b238794iinput", "source": "node-mism0r3m-b9px9rbk", "target": "node-miedmup9-b238794i", "sourceHandle": "merge-output", "targetHandle": "input"}], "nodes": [{"id": "node-mi795m91-xkrbgdj2", "data": {"label": "[启动] 实验简介", "startObjective": "提出一个创新的APP创意，该 App 旨在促进更健康的生活方式", "startBackground": "想象你正在为一家名为\\"博伦科技\\"的公司工作。该公司正在寻求创新的 App 概念，以响应消费者对数字健康工具日益增长的需求，帮助用户过上更健康的生活。", "inputVariableName": "input", "startDeliverables": "APP产品创意文案"}, "type": "startNode", "position": {"x": 755.4615188829553, "y": 62.243415553709326}}, {"id": "node-mi7973bg-8w6fj9fm", "data": {"label": "被试自评", "variables": [{"id": "info-xl40jnto", "key": "self_perceived_creativity", "note": "", "label": "请您评价自己是一个富有创造力的人的程度", "options": [], "varType": "string", "required": true, "inputType": "rating"}, {"id": "info-jqhua8w7", "key": "familiarity_GPT", "note": "", "label": "在日常生活中，您使用 ChatGPT 的频率是？", "options": [{"label": "从不使用", "value": "从不使用"}, {"label": "很少使用（每月几次）", "value": "很少使用（每月几次）"}, {"label": "有时使用（每周几次）", "value": "有时使用（每周几次）"}, {"label": "经常使用（几乎每天）", "value": "经常使用（几乎每天）"}], "varType": "string", "required": true, "inputType": "radio"}, {"id": "info-h3av96it", "key": "domain_knowledge", "note": "1（完全不了解）\\n5（非常熟悉）", "label": "您对市场上与健康、健身相关的移动应用程序（例如：Keep, MyFitnessPal, 苹果健康等）有多熟悉？", "options": [], "varType": "string", "required": true, "inputType": "rating"}, {"id": "info-tf6d20kf", "key": "writing_skill", "note": "1（写作能力很弱）\\n5（写作能力很强）", "label": "请您评价自己的文字写作能力（例如：表达清晰度、词汇丰富度、逻辑性等）。", "options": [], "varType": "string", "required": true, "inputType": "rating"}], "contextText": "", "inputVariableName": "input"}, "type": "infoNode", "position": {"x": 612.5234747267325, "y": 870.6156277231825}}, {"id": "node-miedmup9-b238794i", "data": {"label": "任务二-Idea Refinement", "category": "human", "taskType": "writing", "allowAgent": true, "contextText": "", "instruction": "现在你已经有了一个初始创意。在这个阶段，你将与一位 AI 助手合作，对这个创意进行打磨、润色和改进。\\n\\n你可以通过右侧的聊天界面与 AI 自由互动。当你对结果满意时，请提交最终版本的创意。", "outputEditorType": "plaintext", "copilotWorkflowId": "7579907154346246144", "inputVariableName": "input", "evaluationDimensions": [{"id": "branch-zplycd7x", "name": "创意度", "prompt": "", "evaluator": "llm", "scoreScale": 5, "description": "这个创意是否新颖、独特，与现有的 App 不同？", "llmWorkflowId": "7572347832489738240"}, {"id": "branch-9rfm4lxj", "name": "写作质量", "prompt": "", "evaluator": "llm", "scoreScale": 5, "description": "这个创意的表达是否清晰、流畅？", "llmWorkflowId": "7572347832489738240"}, {"id": "branch-1uwoyz50", "name": "购买/使用意愿", "prompt": "", "evaluator": "llm", "scoreScale": 5, "description": "如果这款 App 上线，你有多大可能会下载使用？", "llmWorkflowId": "7572347832489738240"}, {"id": "branch-1wgjeuf1", "name": "预测流行度", "prompt": "", "evaluator": "llm", "scoreScale": 5, "description": "你认为这款 App 会受到大众市场的欢迎吗？", "llmWorkflowId": "7572347832489738240"}], "evaluationWorkflowId": "7576114694956515328"}, "type": "taskNode", "position": {"x": 808.275311058852, "y": 775.8077305995532}}, {"id": "node-miee3r6p-gn7l49u9", "data": {"label": "[结束] 流程终点", "contextText": "", "inputVariableName": "input"}, "type": "endNode", "position": {"x": 780.2939620144369, "y": 1875.8189639680124}}, {"id": "node-miiginej-0lyp2e6y", "data": {"label": "demographic信息填写", "variables": [{"id": "info-itbi0le0", "key": "gender", "note": "", "label": "gender", "options": [{"label": "男", "value": "男"}, {"label": "女", "value": "女"}, {"label": "非二元性别", "value": "非二元性别"}], "varType": "string", "required": true, "inputType": "radio"}, {"id": "info-satlj9xx", "key": "age", "note": "", "label": "年龄", "options": [{"label": "18-24岁", "value": "18-24岁"}, {"label": "25-34岁", "value": "25-34岁"}, {"label": "35-44岁", "value": "35-44岁"}, {"label": "45-54岁", "value": "45-54岁"}, {"label": "55-64岁", "value": "55-64岁"}, {"label": "65岁及以上", "value": "65岁及以上"}], "varType": "string", "required": true, "inputType": "select"}, {"id": "info-a6dqotkc", "key": "martial status", "note": "", "label": "婚姻状况", "options": [{"label": "已婚", "value": "已婚"}, {"label": "未婚", "value": "未婚"}, {"label": "离异", "value": "离异"}], "varType": "string", "required": true, "inputType": "radio"}, {"id": "info-v4e2rs94", "key": "education", "note": "", "label": "受教育程度", "options": [{"label": "高中及以下", "value": "高中及以下"}, {"label": "大专", "value": "大专"}, {"label": "本科", "value": "本科"}, {"label": "硕士", "value": "硕士"}, {"label": "博士", "value": "博士"}], "varType": "string", "required": true, "inputType": "radio"}, {"id": "info-2s5by0rh", "key": "employment status", "note": "", "label": "就业状况", "options": [{"label": "全职工作", "value": "全职工作"}, {"label": "兼职工作", "value": "兼职工作"}, {"label": "无工作", "value": "无工作"}], "varType": "string", "required": true, "inputType": "select"}, {"id": "info-hu5zhhhz", "key": "income", "note": "", "label": "收入", "options": [{"label": "<5000/月", "value": "<5000/月"}, {"label": "5000-10000/月", "value": "5000-10000/月"}, {"label": "10000-20000/月", "value": "10000-20000/月"}, {"label": "20000-30000/月", "value": "20000-30000/月"}, {"label": "30000-40000/月", "value": "30000-40000/月"}, {"label": ">40000/月", "value": ">40000/月"}], "varType": "string", "required": true, "inputType": "select"}], "contextText": "", "inputVariableName": "input"}, "type": "infoNode", "position": {"x": 786.7550098023947, "y": 1240.0253009814921}}, {"id": "node-mism0r3m-8qw8jbmg", "data": {"label": "委托给AI创作", "category": "agent", "allowAgent": false, "contextText": "", "workflow_id": "7580284403985678336", "inputVariableName": "input", "evaluationDimensions": [{"id": "branch-3sps6xr8", "name": "创意度", "prompt": "", "evaluator": "llm", "scoreScale": 5, "description": "这个创意是否新颖、独特，与现有的 App 不同？", "llmWorkflowId": "7572347832489738240"}, {"id": "branch-43iimxal", "name": "写作质量", "prompt": "", "evaluator": "llm", "scoreScale": 5, "description": "这个创意的表达是否清晰、流畅？", "llmWorkflowId": "7572347832489738240"}, {"id": "branch-aj9ua6ww", "name": "购买/使用意愿", "prompt": "", "evaluator": "llm", "scoreScale": 5, "description": "如果这款 App 上线，你有多大可能会下载使用？", "llmWorkflowId": "7572347832489738240"}, {"id": "branch-d5vfhclq", "name": "预测流行度", "prompt": "", "evaluator": "llm", "scoreScale": 5, "description": "你认为这款 App 会受到大众市场的欢迎吗？", "llmWorkflowId": "7572347832489738240"}], "evaluationWorkflowId": "7576114694956515328"}, "type": "taskNode", "position": {"x": 947.6364250378218, "y": 516.7934285793798}}, {"id": "node-mism0r3m-aep1j8ie", "data": {"label": "Human自主创作", "category": "human", "taskType": "brainstorming", "allowAgent": false, "contextText": "", "instruction": "1. 背景：想象你正在为一家名为\\"博伦科技\\"的公司工作。该公司正在寻求创新的 App 概念，以响应消费者对数字健康工具日益增长的需求，帮助用户过上更健康的生活。\\n\\n2. 任务要求：\\n请在下方文本框中详细描述您的 App 初始创意。\\n您必须完全依靠自己来构思和撰写，请勿使用任何 AI 工具。\\n\\n为了让您的创意更具说服力，建议您的描述包含以下内容（仅供参考）：\\n - App 名称：给它起一个响亮的名字。\\n - 核心功能：它能做什么？解决了什么问题？\\n - 目标用户：谁会使用它？", "copilotWorkflowId": "", "inputVariableName": "input", "evaluationDimensions": [{"id": "branch-bq77nr16", "name": "创意度", "prompt": "", "evaluator": "llm", "scoreScale": 5, "description": "这个创意是否新颖、独特，与现有的 App 不同？", "llmWorkflowId": "7572347832489738240"}, {"id": "branch-zmrcmbqj", "name": "写作质量", "prompt": "", "evaluator": "llm", "scoreScale": 5, "description": "这个创意的表达是否清晰、流畅？", "llmWorkflowId": "7572347832489738240"}, {"id": "branch-loadlmua", "name": "购买/使用意愿", "prompt": "", "evaluator": "llm", "scoreScale": 5, "description": "如果这款 App 上线，你有多大可能会下载使用？", "llmWorkflowId": "7572347832489738240"}, {"id": "branch-p92u6138", "name": "预测流行度", "prompt": "", "evaluator": "human", "scoreScale": 5, "description": "你认为这款 App 会受到大众市场的欢迎吗？", "llmWorkflowId": ""}], "evaluationWorkflowId": "7576114694956515328"}, "type": "taskNode", "position": {"x": 708.1929448632161, "y": 518.927640560393}}, {"id": "node-mism0r3m-7jjnz7o2", "data": {"label": "[分支] 条件分流", "branches": [{"id": "branch-4d5dl2fz", "label": "分支 1", "value": "不委托", "operator": "equals", "variable": "user_decision", "condition": "lastOutput?.[\\"user_decision\\"] === '不委托'", "edgeLabel": "user_decision = '不委托'", "isDefault": false, "valueType": "string", "conditionDisplay": "lastOutput?.[\\"user_decision\\"] = '不委托'"}, {"id": "branch-cgazzn78", "label": "其他", "value": "委托", "operator": "equals", "variable": "user_decision", "condition": "lastOutput?.[\\"user_decision\\"] === '委托'", "edgeLabel": "user_decision = '委托'", "isDefault": true, "valueType": "string", "conditionDisplay": "lastOutput?.[\\"user_decision\\"] = '委托'"}], "contextText": "", "inputVariableName": "input", "allowDefaultBranch": true}, "type": "branchNode", "position": {"x": 777.0669593286478, "y": 372.4315914306963}}, {"id": "node-mism0r3m-b9px9rbk", "data": {"label": "[汇聚] 分支合流", "contextText": "", "inputVariableName": "input"}, "type": "mergeNode", "position": {"x": 781.0478673212546, "y": 632.5288218071678}}, {"id": "node-mism0r3m-xgh488jc", "data": {"label": "[Human] 信息输入", "variables": [{"id": "info-za5orgmd", "key": "user_decision", "note": "", "label": "请您选择，是否把Idea的构思任务委托给AI完成？ |优势：AI 生成的想法通常在语言质量（通顺度、语法、表达清晰度）方面表现更好。 | 劣势：与人类的想法相比，AI 生成的想法通常创造力较低（缺乏新意、较为平庸）。”", "options": [{"label": "委托", "value": "委托"}, {"label": "不委托", "value": "不委托"}], "varType": "string", "required": true, "inputType": "radio"}], "contextText": "", "inputVariableName": "input"}, "type": "infoNode", "position": {"x": 415.97988073344675, "y": 197.7651535361439}}]}	0399fa1a-4045-425b-b514-dfd8fb44f233	{"dimensions": [], "overallFeedback": {"prompt": "", "enabled": false}}
72	Delegation Decision_Group3	{"edges": [{"id": "xy-edge__node-miua7q2o-qi2ahlekoutput-node-miua89pi-yo1sqaafinput", "source": "node-miua7q2o-qi2ahlek", "target": "node-miua89pi-yo1sqaaf", "sourceHandle": "output", "targetHandle": "input"}, {"id": "xy-edge__node-miua89pi-yo1sqaafoutput-node-miua8n3s-6lyd0xizinput", "source": "node-miua89pi-yo1sqaaf", "target": "node-miua8n3s-6lyd0xiz", "sourceHandle": "output", "targetHandle": "input"}, {"id": "xy-edge__node-miua8n3s-6lyd0xizoutput-node-miua90fg-5xb2117hend-input", "source": "node-miua8n3s-6lyd0xiz", "target": "node-miua90fg-5xb2117h", "sourceHandle": "output", "targetHandle": "end-input"}, {"id": "xy-edge__node-miua719d-ejzi3dekstart-output-node-miucdltv-4yfnvoqhinput", "source": "node-miua719d-ejzi3dek", "target": "node-miucdltv-4yfnvoqh", "sourceHandle": "start-output", "targetHandle": "input"}, {"id": "xy-edge__node-miucdltv-4yfnvoqhoutput-node-miuceqty-7ygqto1yinput", "source": "node-miucdltv-4yfnvoqh", "target": "node-miuceqty-7ygqto1y", "sourceHandle": "output", "targetHandle": "input"}, {"id": "xy-edge__node-miuceqty-7ygqto1ybranch-1exivhp1-node-miua79hc-bpp0qxmyinput", "data": {"condition": "lastOutput?.[\\"user_decision\\"] === '不委托'", "edgeLabel": "user_decision = '不委托'", "isDefault": true, "conditionDisplay": "lastOutput?.[\\"user_decision\\"] = '不委托'"}, "label": "user_decision = '不委托'", "source": "node-miuceqty-7ygqto1y", "target": "node-miua79hc-bpp0qxmy", "sourceHandle": "branch-1exivhp1", "targetHandle": "input"}, {"id": "xy-edge__node-miuceqty-7ygqto1ybranch-29rck6fv-node-miucga2x-avn5qsuzinput", "data": {"condition": "lastOutput?.[\\"user_decision\\"] === '委托'", "edgeLabel": "user_decision = '委托'", "isDefault": false, "conditionDisplay": "lastOutput?.[\\"user_decision\\"] = '委托'"}, "label": "user_decision = '委托'", "source": "node-miuceqty-7ygqto1y", "target": "node-miucga2x-avn5qsuz", "sourceHandle": "branch-29rck6fv", "targetHandle": "input"}, {"id": "xy-edge__node-miucga2x-avn5qsuzoutput-node-miuch091-03pfvh61merge-input", "source": "node-miucga2x-avn5qsuz", "target": "node-miuch091-03pfvh61", "sourceHandle": "output", "targetHandle": "merge-input"}, {"id": "xy-edge__node-miua79hc-bpp0qxmyoutput-node-miuch091-03pfvh61merge-input", "source": "node-miua79hc-bpp0qxmy", "target": "node-miuch091-03pfvh61", "sourceHandle": "output", "targetHandle": "merge-input"}, {"id": "xy-edge__node-miuch091-03pfvh61merge-output-node-miua7q2o-qi2ahlekinput", "source": "node-miuch091-03pfvh61", "target": "node-miua7q2o-qi2ahlek", "sourceHandle": "merge-output", "targetHandle": "input"}], "nodes": [{"id": "node-miua719d-ejzi3dek", "data": {"label": "[启动] 实验简介", "startObjective": "提出一个创新的APP创意，该 App 旨在促进更健康的生活方式", "startBackground": "想象你正在为一家名为\\"博伦科技\\"的公司工作。该公司正在寻求创新的 App 概念，以响应消费者对数字健康工具日益增长的需求，帮助用户过上更健康的生活。", "inputVariableName": "input", "startDeliverables": "APP产品创意文案"}, "type": "startNode", "position": {"x": 397.18876565776225, "y": -560.5778186572563}}, {"id": "node-miua79hc-bpp0qxmy", "data": {"label": "Task 1: Idea Generation (Human-Lead)", "category": "human", "taskType": "brainstorming", "allowAgent": false, "contextText": "", "instruction": "1. 背景：想象你正在为一家名为\\"博伦科技\\"的公司工作。该公司正在寻求创新的 App 概念，以响应消费者对数字健康工具日益增长的需求，帮助用户过上更健康的生活。\\n\\n2. 任务要求：\\n请在下方文本框中详细描述您的 App 初始创意。\\n您必须完全依靠自己来构思和撰写，请勿使用任何 AI 工具。\\n\\n为了让您的创意更具说服力，建议您的描述包含以下内容（仅供参考）：\\n - App 名称：给它起一个响亮的名字。\\n - 核心功能：它能做什么？解决了什么问题？\\n - 目标用户：谁会使用它？", "inputVariableName": "input"}, "type": "taskNode", "position": {"x": 593.7128767507957, "y": -23.351582037734662}}, {"id": "node-miua7q2o-qi2ahlek", "data": {"label": "Task 2: Idea Refinement", "category": "human", "taskType": "writing", "allowAgent": true, "contextText": "", "instruction": "现在你已经有了一个初始创意。在这个阶段，你将与一位 AI 助手合作，对这个创意进行打磨、润色和改进。\\n\\n你可以通过右侧的聊天界面与 AI 自由互动。当你对结果满意时，请提交最终版本的创意。", "copilotWorkflowId": "7579907154346246144", "inputVariableName": "input"}, "type": "taskNode", "position": {"x": 446.12233500718037, "y": 226.68305817003625}}, {"id": "node-miua89pi-yo1sqaaf", "data": {"label": "被试自评", "variables": [{"id": "info-uhr64sxo", "key": "self_perceived_creativity", "note": "1（创造力较低）5（创造力高）", "label": "请您评价自己是一个富有创造力的人的程度", "options": [], "varType": "string", "required": true, "inputType": "rating"}, {"id": "info-wq4q3bs1", "key": "familiarity_GPT", "note": "", "label": "在日常生活中，您使用 ChatGPT 的频率是？", "options": [{"label": "从不使用", "value": "从不使用"}, {"label": "很少使用（每月几次）", "value": "很少使用（每月几次）"}, {"label": "有时使用（每周几次）", "value": "有时使用（每周几次）"}, {"label": "经常使用（几乎每天）", "value": "经常使用（几乎每天）"}], "varType": "string", "required": true, "inputType": "radio"}, {"id": "info-g8qt52sz", "key": "domain_knowledge", "note": "1（完全不了解）\\n5（非常熟悉）", "label": "您对市场上与健康、健身相关的移动应用程序（例如：Keep, MyFitnessPal, 苹果健康等）有多熟悉？", "options": [], "varType": "string", "required": true, "inputType": "rating"}, {"id": "info-s5vob122", "key": "writing_skill", "note": "1（写作能力很弱）\\n5（写作能力很强）", "label": "请您评价自己的文字写作能力（例如：表达清晰度、词汇丰富度、逻辑性等）。", "options": [], "varType": "string", "required": true, "inputType": "rating"}], "contextText": "", "inputVariableName": "input"}, "type": "infoNode", "position": {"x": 252.87036645963553, "y": 302.3601641511546}}, {"id": "node-miua8n3s-6lyd0xiz", "data": {"label": "被试基本信息填写", "variables": [{"id": "info-6dp84pi9", "key": "gender", "note": "", "label": "性别", "options": [{"label": "男", "value": "男"}, {"label": "女", "value": "女"}, {"label": "非二元性别", "value": "非二元性别"}], "varType": "string", "required": true, "inputType": "radio"}, {"id": "info-ulr5moj4", "key": "age", "note": "", "label": "年龄", "options": [{"label": "18-24岁", "value": "18-24岁"}, {"label": "25-34岁", "value": "25-34岁"}, {"label": "35-44岁", "value": "35-44岁"}, {"label": "45-54岁", "value": "45-54岁"}, {"label": "55-64岁", "value": "55-64岁"}, {"label": "65岁及以上", "value": "65岁及以上"}], "varType": "string", "required": true, "inputType": "select"}, {"id": "info-pb5z9bkj", "key": "martial status", "note": "", "label": "婚姻状况", "options": [{"label": "已婚", "value": "已婚"}, {"label": "未婚", "value": "未婚"}, {"label": "离异", "value": "离异"}], "varType": "string", "required": true, "inputType": "radio"}, {"id": "info-1w7jhyyd", "key": "education", "note": "", "label": "受教育程度", "options": [{"label": "高中及以下", "value": "高中及以下"}, {"label": "大专", "value": "大专"}, {"label": "本科", "value": "本科"}, {"label": "硕士", "value": "硕士"}, {"label": "博士", "value": "博士"}], "varType": "string", "required": true, "inputType": "radio"}, {"id": "info-ao4914e2", "key": "employment status", "note": "", "label": "就业状况", "options": [{"label": "全职工作", "value": "全职工作"}, {"label": "兼职工作", "value": "兼职工作"}, {"label": "无工作", "value": "无工作"}], "varType": "string", "required": true, "inputType": "select"}, {"id": "info-w4pwfuw6", "key": "income", "note": "", "label": "收入", "options": [{"label": "<5000/月", "value": "<5000/月"}, {"label": "5000-10000/月", "value": "5000-10000/月"}, {"label": "10000-20000/月", "value": "10000-20000/月"}, {"label": "20000-30000/月", "value": "20000-30000/月"}, {"label": "30000-40000/月", "value": "30000-40000/月"}, {"label": ">40000/月", "value": ">40000/月"}], "varType": "string", "required": true, "inputType": "select"}], "contextText": "", "inputVariableName": "input"}, "type": "infoNode", "position": {"x": 427.6640550363355, "y": 697.7396032371796}}, {"id": "node-miua90fg-5xb2117h", "data": {"label": "[结束] 流程终点"}, "type": "endNode", "position": {"x": 422.79004521263573, "y": 1324.445921742916}}, {"id": "node-miucdltv-4yfnvoqh", "data": {"label": "AI委托决策", "variables": [{"id": "info-epth9om1", "key": "user_decision", "note": "", "label": "请您选择，是否把Idea的构思任务委托给AI完成？(AI的优势:yyyy | AI的劣势:xxx)", "options": [{"label": "委托", "value": "委托"}, {"label": "不委托", "value": "不委托"}], "varType": "string", "required": true, "inputType": "radio"}], "contextText": "", "inputVariableName": "input"}, "type": "infoNode", "position": {"x": 306.788774952552, "y": -412.33149181921715}}, {"id": "node-miuceqty-7ygqto1y", "data": {"label": "[分支] 条件分流", "branches": [{"id": "branch-29rck6fv", "label": "分支 1", "value": "委托", "operator": "equals", "variable": "user_decision", "condition": "lastOutput?.[\\"user_decision\\"] === '委托'", "edgeLabel": "user_decision = '委托'", "isDefault": false, "valueType": "string", "conditionDisplay": "lastOutput?.[\\"user_decision\\"] = '委托'"}, {"id": "branch-1exivhp1", "label": "其他", "value": "不委托", "operator": "equals", "variable": "user_decision", "condition": "lastOutput?.[\\"user_decision\\"] === '不委托'", "edgeLabel": "user_decision = '不委托'", "isDefault": true, "valueType": "string", "conditionDisplay": "lastOutput?.[\\"user_decision\\"] = '不委托'"}], "contextText": "", "inputVariableName": "input", "allowDefaultBranch": true}, "type": "branchNode", "position": {"x": 425.41820102693794, "y": -229.69097832485758}}, {"id": "node-miucga2x-avn5qsuz", "data": {"label": "Task 1: Idea Generation (AI-Lead)", "category": "agent", "allowAgent": false, "contextText": "", "workflow_id": "7580284403985678336", "inputVariableName": "input"}, "type": "taskNode", "position": {"x": 268.4181903995834, "y": -22.690964312995106}}, {"id": "node-miuch091-03pfvh61", "data": {"label": "[汇聚] 分支合流", "contextText": "", "inputVariableName": "input"}, "type": "mergeNode", "position": {"x": 420.4182006884872, "y": 80.30904265909102}}]}	83cf7ae9-fd96-426c-9e26-effd554cc8c9	{"dimensions": [], "overallFeedback": {"prompt": "", "enabled": false}}
14	exp1	{"edges": [{"id": "xy-edge__node-mibzsheg-k367eswdoutput-node-mic0b19b-bsg6ipb0input", "source": "node-mibzsheg-k367eswd", "target": "node-mic0b19b-bsg6ipb0", "sourceHandle": "output", "targetHandle": "input"}, {"id": "xy-edge__node-mic0b19b-bsg6ipb0output-node-mic0b66i-y2ac4vr7input", "source": "node-mic0b19b-bsg6ipb0", "target": "node-mic0b66i-y2ac4vr7", "sourceHandle": "output", "targetHandle": "input"}, {"id": "xy-edge__node-mic0ed1n-ggq2yvcsstart-output-node-mibzsheg-k367eswdinput", "source": "node-mic0ed1n-ggq2yvcs", "target": "node-mibzsheg-k367eswd", "sourceHandle": "start-output", "targetHandle": "input"}, {"id": "xy-edge__node-mic0b66i-y2ac4vr7output-node-mic0emmt-01l9txf9end-input", "source": "node-mic0b66i-y2ac4vr7", "target": "node-mic0emmt-01l9txf9", "sourceHandle": "output", "targetHandle": "end-input"}], "nodes": [{"id": "node-mibzsheg-k367eswd", "data": {"label": "[Human] 任务", "contextText": "", "inputVariableName": "input"}, "type": "taskNode", "position": {"x": 281.1999816894531, "y": 51.29999923706055}}, {"id": "node-mic0b19b-bsg6ipb0", "data": {"label": "[Agent] 任务", "inputVariableName": "input"}, "type": "taskNode", "position": {"x": 283.0499725341797, "y": 114.94999885559082}}, {"id": "node-mic0b66i-y2ac4vr7", "data": {"label": "[Human] 任务"}, "type": "taskNode", "position": {"x": 281.0499725341797, "y": 185.44999885559082}}, {"id": "node-mic0ed1n-ggq2yvcs", "data": {"label": "[启动] 实验简介", "startObjective": "", "startBackground": "", "startDeliverables": ""}, "type": "startNode", "position": {"x": 224.5499725341797, "y": -45.55000114440918}}, {"id": "node-mic0emmt-01l9txf9", "data": {"label": "[结束] 流程终点"}, "type": "endNode", "position": {"x": 239.15496422774368, "y": 271.2380742644179}}]}	d524f2e6-27d4-4f1b-b171-e96df36ec23e	{"dimensions": [], "overallFeedback": {"prompt": "", "enabled": false}}
61	test	{"edges": [{"id": "xy-edge__node-miss9viq-xjxl1t0tstart-output-node-miss9viq-43ivh1o6input", "source": "node-miss9viq-xjxl1t0t", "target": "node-miss9viq-43ivh1o6", "sourceHandle": "start-output", "targetHandle": "input"}, {"id": "xy-edge__node-miss9viq-43ivh1o6output-node-miss9viq-7nuwhlewinput", "source": "node-miss9viq-43ivh1o6", "target": "node-miss9viq-7nuwhlew", "sourceHandle": "output", "targetHandle": "input"}, {"id": "xy-edge__node-miss9viq-7nuwhlewoutput-node-miss9viq-llnl3levinput", "source": "node-miss9viq-7nuwhlew", "target": "node-miss9viq-llnl3lev", "sourceHandle": "output", "targetHandle": "input"}, {"id": "xy-edge__node-miss9viq-llnl3levoutput-node-miss9viq-wxe2t35jinput", "source": "node-miss9viq-llnl3lev", "target": "node-miss9viq-wxe2t35j", "sourceHandle": "output", "targetHandle": "input"}, {"id": "xy-edge__node-miss9viq-wxe2t35joutput-node-miss9viq-0gx52getinput", "source": "node-miss9viq-wxe2t35j", "target": "node-miss9viq-0gx52get", "sourceHandle": "output", "targetHandle": "input"}, {"id": "xy-edge__node-miss9viq-0gx52getoutput-node-miss9viq-javezneiinput", "source": "node-miss9viq-0gx52get", "target": "node-miss9viq-javeznei", "sourceHandle": "output", "targetHandle": "input"}, {"id": "xy-edge__node-miss9viq-javezneioutput-node-miss9viq-xrt5hyf5input", "source": "node-miss9viq-javeznei", "target": "node-miss9viq-xrt5hyf5", "sourceHandle": "output", "targetHandle": "input"}, {"id": "xy-edge__node-miss9viq-xrt5hyf5output-node-miss9viq-qhdabjo7input", "source": "node-miss9viq-xrt5hyf5", "target": "node-miss9viq-qhdabjo7", "sourceHandle": "output", "targetHandle": "input"}, {"id": "xy-edge__node-miss9viq-qhdabjo7output-node-miss9viq-8png5tpiend-input", "source": "node-miss9viq-qhdabjo7", "target": "node-miss9viq-8png5tpi", "sourceHandle": "output", "targetHandle": "end-input"}], "nodes": [{"id": "node-miss9viq-xjxl1t0t", "data": {"label": "[启动] 实验简介", "startObjective": "为虚构公司 BloomTech 设计一款帮助用户养成更健康生活方式的手机 App 创意。", "startBackground": "工作创意完成", "inputVariableName": "input", "startDeliverables": " App 创意"}, "type": "startNode", "position": {"x": 274.33331298828125, "y": 62}}, {"id": "node-miss9viq-43ivh1o6", "data": {"label": "[Human] 任务", "category": "human", "taskType": "brainstorming", "contextText": "", "instruction": "为虚构公司 BloomTech 设计一款帮助用户养成更健康生活方式的手机 App 创意。", "inputVariableName": "input"}, "type": "taskNode", "position": {"x": 351.13365742609983, "y": 189.63681515950432}}, {"id": "node-miss9viq-7nuwhlew", "data": {"label": "[Human] 任务", "category": "human", "taskType": "brainstorming", "allowAgent": true, "contextText": "", "instruction": "对上述内容通过与AI交互进行优化", "copilotWorkflowId": "7574801274202226688", "inputVariableName": "input", "evaluationDimensions": [{"id": "branch-afy8buu8", "name": "Creativity", "prompt": "输入为虚构公司 BloomTech 设计一款帮助用户养成更健康生活方式的手机 App 创意，请根据五级评分规则输出Creativity评分", "evaluator": "llm", "scoreScale": 5, "description": "", "llmWorkflowId": "7574801274202226688"}, {"id": "branch-7pn991ht", "name": "Writing quality", "prompt": "输入为虚构公司 BloomTech 设计一款帮助用户养成更健康生活方式的手机 App 创意，请根据五级评分规则输出Writing quality评分", "evaluator": "llm", "scoreScale": 5, "description": "", "llmWorkflowId": "7574801274202226688"}, {"id": "branch-ki54bben", "name": "Purchase interest", "prompt": "输入为虚构公司 BloomTech 设计一款帮助用户养成更健康生活方式的手机 App 创意，请根据五级评分规则输出Purchase interest评分", "evaluator": "llm", "scoreScale": 5, "description": "", "llmWorkflowId": "7574801274202226688"}, {"id": "branch-khhqpddz", "name": "Predicted popularity", "prompt": "输入为虚构公司 BloomTech 设计一款帮助用户养成更健康生活方式的手机 App 创意，请根据五级评分规则输出Predicted popularity评分", "evaluator": "llm", "scoreScale": 5, "description": "", "llmWorkflowId": "7574801274202226688"}]}, "type": "taskNode", "position": {"x": 350.1818378334779, "y": 283.3153723408618}}, {"id": "node-miss9viq-llnl3lev", "data": {"label": "[Human] 问卷", "category": "human", "taskType": "other", "contextText": "", "instruction": "自评self-perceived creativity，1到5打分", "inputVariableName": "input", "evaluationDimensions": []}, "type": "taskNode", "position": {"x": 149.40842099873745, "y": 379.1183089950154}}, {"id": "node-miss9viq-0gx52get", "data": {"label": "[Human] 问卷", "category": "human", "taskType": "other", "contextText": "", "instruction": "自评familiarity with health-related mobile apps，1到5打分", "inputVariableName": "input", "evaluationDimensions": []}, "type": "taskNode", "position": {"x": 452.86600298592026, "y": 385.6937582349736}}, {"id": "node-miss9viq-wxe2t35j", "data": {"label": "[Human] 问卷", "category": "human", "taskType": "other", "contextText": "", "instruction": "自评familiarity with ChatGPT，1到5打分", "inputVariableName": "input", "evaluationDimensions": []}, "type": "taskNode", "position": {"x": 303.0956136298577, "y": 381.26268162680617}}, {"id": "node-miss9viq-javeznei", "data": {"label": "[Human] 问卷", "category": "human", "taskType": "other", "contextText": "", "instruction": "自评writing skill，1到5打分", "inputVariableName": "input", "evaluationDimensions": []}, "type": "taskNode", "position": {"x": 606.5531956170405, "y": 387.8381308667643}}, {"id": "node-miss9viq-xrt5hyf5", "data": {"label": "[Human] 问卷", "category": "human", "taskType": "other", "contextText": "", "instruction": "自评frequency of ChatGPT use，1到5打分", "inputVariableName": "input", "evaluationDimensions": []}, "type": "taskNode", "position": {"x": 623.7632287166007, "y": 464.4245905157695}}, {"id": "node-miss9viq-qhdabjo7", "data": {"label": "[Human] 问卷", "category": "human", "contextText": "", "instruction": "个人信息", "inputVariableName": "input"}, "type": "taskNode", "position": {"x": 424.5804087916019, "y": 473.9390875584792}}, {"id": "node-miss9viq-8png5tpi", "data": {"label": "[结束] 流程终点", "contextText": "", "inputVariableName": "input"}, "type": "endNode", "position": {"x": 369.6350588503245, "y": 582.0573567977668}}, {"id": "node-misskp9w-fgu9pnt0", "data": {"label": "[Human] 信息输入", "variables": [{"id": "info-k26v3g0g", "key": "", "note": "", "label": "", "options": [], "varType": "string", "required": false, "inputType": "rating"}], "inputVariableName": "input"}, "type": "infoNode", "position": {"x": 72.33390110164959, "y": 216.07167008811774}}]}	a50e4c18-7e6f-46a5-b8e5-7d4a4db179bb	{"dimensions": [], "overallFeedback": {"prompt": "", "enabled": false}}
73	test	{"edges": [{"id": "xy-edge__node-mivl70g6-18ozwkizstart-output-node-mivl6vyx-l6ciyx2binput", "source": "node-mivl70g6-18ozwkiz", "target": "node-mivl6vyx-l6ciyx2b", "sourceHandle": "start-output", "targetHandle": "input"}], "nodes": [{"id": "node-mivl6vyx-l6ciyx2b", "data": {"label": "[Agent] 任务", "category": "agent", "allowAgent": false, "contextText": "", "workflow_id": "7572087336784101376", "inputVariableName": "input"}, "type": "taskNode", "position": {"x": 355.3505497636485, "y": 267.4663312074894}}, {"id": "node-mivl70g6-18ozwkiz", "data": {"label": "[启动] 实验简介", "startObjective": "", "startBackground": "", "inputVariableName": "input", "startDeliverables": ""}, "type": "startNode", "position": {"x": 273.2999725341797, "y": 144.30000114440918}}, {"id": "node-mivly5xi-7i1rbr4f", "data": {"label": "[Human] 信息输入", "variables": [{"id": "info-2c9sdf64", "key": "", "note": "", "label": "", "options": [], "varType": "string", "required": false, "inputType": "text"}]}, "type": "infoNode", "position": {"x": 301.83333955442293, "y": -27.809934798875105}}]}	f64611ca-6a4d-42dd-ac81-c2c91b190dd0	{"dimensions": [], "overallFeedback": {"prompt": "", "enabled": false}}
39	Study1_zengsipeng	{"edges": [{"id": "xy-edge__node-mir6q56m-yakr1pkhstart-output-node-mir6pvfn-dbj7gdp4input", "source": "node-mir6q56m-yakr1pkh", "target": "node-mir6pvfn-dbj7gdp4", "sourceHandle": "start-output", "targetHandle": "input"}, {"id": "xy-edge__node-mir6pvfn-dbj7gdp4output-node-mir7maua-h435fg4jinput", "source": "node-mir6pvfn-dbj7gdp4", "target": "node-mir7maua-h435fg4j", "sourceHandle": "output", "targetHandle": "input"}, {"id": "xy-edge__node-mir7maua-h435fg4joutput-node-mir7mw99-7ucn7ae0input", "source": "node-mir7maua-h435fg4j", "target": "node-mir7mw99-7ucn7ae0", "sourceHandle": "output", "targetHandle": "input"}, {"id": "xy-edge__node-mir7mw99-7ucn7ae0output-node-mir7t6qz-u2sbzwh2end-input", "source": "node-mir7mw99-7ucn7ae0", "target": "node-mir7t6qz-u2sbzwh2", "sourceHandle": "output", "targetHandle": "end-input"}], "nodes": [{"id": "node-mir6pvfn-dbj7gdp4", "data": {"label": "[Human] 任务", "category": "human", "allowAgent": false, "contextText": "", "instruction": "为虚构公司 BloomTech 设计⼀款帮助⽤⼾养成更健康⽣活⽅式的⼿机 App 创意,请你自己生成点子", "outputEditorType": "richtext", "copilotWorkflowId": "", "inputVariableName": "input"}, "type": "taskNode", "position": {"x": 874.8116350897425, "y": 266.31809525685975}}, {"id": "node-mir6q56m-yakr1pkh", "data": {"label": "[启动] 实验简介", "startObjective": "完整参与实验全流程，真实反馈自身决策与交互体验，帮助研究者验证实验设计的合理性与流程完整性；\\n基于实验提示完成 “是否委派” 的决策选择，生成符合情景要求的初始 App 创意；\\n与智能体（LLM）进行有效对话，针对性地对初始创意进行润色优化，形成更完善的创意方案；", "startBackground": "在数字创意与智能协作深度融合的当下，人机协同已成为提升创意产出效率的重要模式。本实验聚焦于 “人类 - 智能体（Human–Agent）” 协作场景，旨在探索普通人与大语言模型（LLM）协同完成创意优化的过程机制，为后续优化人机协作创意工具、提升用户创意体验提供学术依据与实践参考。\\n本次实验将模拟真实的 App 创意开发场景，你将作为创意发起者，先基于特定情景形成初始 App 创意，再与智能体（LLM）进行互动协作，对创意进行润色完善。你的每一步选择与反馈，都将为研究 “人机协作中的创意生成、决策偏好及交互效果” 提供关键数据支持", "inputVariableName": "input", "startDeliverables": "您最终需要交付一个创意方案，即经过 LLM 润色后，你认可的最终 App 创意描述"}, "type": "startNode", "position": {"x": 801.2264251502345, "y": 91.13905193268418}}, {"id": "node-mir7maua-h435fg4j", "data": {"label": "[Human] 任务", "category": "human", "taskType": "writing", "allowAgent": true, "contextText": "", "instruction": "对初始创意进⾏多轮润⾊和完善；", "copilotWorkflowId": "7579907154346246144", "inputVariableName": "input"}, "type": "taskNode", "position": {"x": 873.8637745616562, "y": 419.8997906505044}}, {"id": "node-mir7mw99-7ucn7ae0", "data": {"label": "[Human] 信息输入", "variables": [{"id": "info-o0cr12mo", "key": "", "note": "", "label": "", "options": [], "varType": "string", "required": false, "inputType": "text"}], "contextText": "", "inputVariableName": "input"}, "type": "infoNode", "position": {"x": 826.4235871948134, "y": 567.1990168348341}}, {"id": "node-mir7t6qz-u2sbzwh2", "data": {"label": "[结束] 流程终点"}, "type": "endNode", "position": {"x": 810.6313051365674, "y": 790.660393772264}}]}	1608ba80-8e25-4424-b7ad-5fecacedf81d	{"dimensions": [], "overallFeedback": {"prompt": "", "enabled": false}}
62	Delegation Decision_Group1a	{"edges": [{"id": "xy-edge__node-miua719d-ejzi3dekstart-output-node-miua79hc-bpp0qxmyinput", "source": "node-miua719d-ejzi3dek", "target": "node-miua79hc-bpp0qxmy", "sourceHandle": "start-output", "targetHandle": "input"}, {"id": "xy-edge__node-miua79hc-bpp0qxmyoutput-node-miua7q2o-qi2ahlekinput", "source": "node-miua79hc-bpp0qxmy", "target": "node-miua7q2o-qi2ahlek", "sourceHandle": "output", "targetHandle": "input"}, {"id": "xy-edge__node-miua7q2o-qi2ahlekoutput-node-miua89pi-yo1sqaafinput", "source": "node-miua7q2o-qi2ahlek", "target": "node-miua89pi-yo1sqaaf", "sourceHandle": "output", "targetHandle": "input"}, {"id": "xy-edge__node-miua89pi-yo1sqaafoutput-node-miua8n3s-6lyd0xizinput", "source": "node-miua89pi-yo1sqaaf", "target": "node-miua8n3s-6lyd0xiz", "sourceHandle": "output", "targetHandle": "input"}, {"id": "xy-edge__node-miua8n3s-6lyd0xizoutput-node-miua90fg-5xb2117hend-input", "source": "node-miua8n3s-6lyd0xiz", "target": "node-miua90fg-5xb2117h", "sourceHandle": "output", "targetHandle": "end-input"}], "nodes": [{"id": "node-miua719d-ejzi3dek", "data": {"label": "[启动] 实验简介", "startObjective": "提出一个创新的APP创意，该 App 旨在促进更健康的生活方式", "startBackground": "想象你正在为一家名为\\"博伦科技\\"的公司工作。该公司正在寻求创新的 App 概念，以响应消费者对数字健康工具日益增长的需求，帮助用户过上更健康的生活。", "inputVariableName": "input", "startDeliverables": "APP产品创意文案"}, "type": "startNode", "position": {"x": 397.95096892111826, "y": 11.770435144872106}}, {"id": "node-miua79hc-bpp0qxmy", "data": {"label": "Task 1: Idea Generation", "category": "human", "taskType": "brainstorming", "allowAgent": false, "contextText": "", "instruction": "1. 背景：想象你正在为一家名为\\"博伦科技\\"的公司工作。该公司正在寻求创新的 App 概念，以响应消费者对数字健康工具日益增长的需求，帮助用户过上更健康的生活。\\n\\n2. 任务要求：\\n请在下方文本框中详细描述您的 App 初始创意。\\n您必须完全依靠自己来构思和撰写，请勿使用任何 AI 工具。\\n\\n为了让您的创意更具说服力，建议您的描述包含以下内容（仅供参考）：\\n - App 名称：给它起一个响亮的名字。\\n - 核心功能：它能做什么？解决了什么问题？\\n - 目标用户：谁会使用它？", "inputVariableName": "input", "evaluationDimensions": [{"id": "branch-6vn4ute5", "name": "创意度", "prompt": "", "evaluator": "llm", "scoreScale": 5, "description": "这个创意是否新颖、独特，与现有的 App 不同？", "llmWorkflowId": "7572347832489738240"}, {"id": "branch-2ghzuct0", "name": "写作质量", "prompt": "", "evaluator": "llm", "scoreScale": 5, "description": "这个创意的表达是否清晰、流畅？", "llmWorkflowId": "7572347832489738240"}, {"id": "branch-tu3gq577", "name": "购买/使用意愿", "prompt": "", "evaluator": "llm", "scoreScale": 5, "description": "如果这款 App 上线，你有多大可能会下载使用？", "llmWorkflowId": "7572347832489738240"}, {"id": "branch-jh97eq6l", "name": "预测流行度", "prompt": "", "evaluator": "llm", "scoreScale": 5, "description": "你认为这款 App 会受到大众市场的欢迎吗？", "llmWorkflowId": "7572347832489738240"}]}, "type": "taskNode", "position": {"x": 447.71286686803273, "y": 142.64842919883137}}, {"id": "node-miua7q2o-qi2ahlek", "data": {"label": "Task 2: Idea Refinement", "category": "human", "taskType": "writing", "allowAgent": true, "contextText": "", "instruction": "现在你已经有了一个初始创意。在这个阶段，你将与一位 AI 助手合作，对这个创意进行打磨、润色和改进。\\n\\n你可以通过右侧的聊天界面与 AI 自由互动。当你对结果满意时，请提交最终版本的创意。", "copilotWorkflowId": "7579907154346246144", "inputVariableName": "input", "evaluationDimensions": [{"id": "branch-1vyhgera", "name": "创意度", "prompt": "", "evaluator": "llm", "scoreScale": 5, "description": "这个创意是否新颖、独特，与现有的 App 不同？", "llmWorkflowId": "7572347832489738240"}, {"id": "branch-vl6whmfe", "name": "写作质量", "prompt": "", "evaluator": "llm", "scoreScale": 5, "description": "这个创意的表达是否清晰、流畅？", "llmWorkflowId": "7572347832489738240"}, {"id": "branch-lcy50q4o", "name": "购买/使用意愿", "prompt": "", "evaluator": "llm", "scoreScale": 5, "description": "如果这款 App 上线，你有多大可能会下载使用？", "llmWorkflowId": "7572347832489738240"}, {"id": "branch-7g2vmyk9", "name": "预测流行度", "prompt": "", "evaluator": "llm", "scoreScale": 5, "description": "你认为这款 App 会受到大众市场的欢迎吗？", "llmWorkflowId": "7572347832489738240"}]}, "type": "taskNode", "position": {"x": 446.12233500718037, "y": 228.68305830541655}}, {"id": "node-miua89pi-yo1sqaaf", "data": {"label": "被试自评", "variables": [{"id": "info-uhr64sxo", "key": "self_perceived_creativity", "note": "1（创造力较低）5（创造力高）", "label": "请您评价自己是一个富有创造力的人的程度", "options": [], "varType": "string", "required": true, "inputType": "rating"}, {"id": "info-wq4q3bs1", "key": "familiarity_GPT", "note": "", "label": "在日常生活中，您使用 ChatGPT 的频率是？", "options": [{"label": "从不使用", "value": "从不使用"}, {"label": "很少使用（每月几次）", "value": "很少使用（每月几次）"}, {"label": "有时使用（每周几次）", "value": "有时使用（每周几次）"}, {"label": "经常使用（几乎每天）", "value": "经常使用（几乎每天）"}], "varType": "string", "required": true, "inputType": "radio"}, {"id": "info-g8qt52sz", "key": "domain_knowledge", "note": "1（完全不了解）\\n5（非常熟悉）", "label": "您对市场上与健康、健身相关的移动应用程序（例如：Keep, MyFitnessPal, 苹果健康等）有多熟悉？", "options": [], "varType": "string", "required": true, "inputType": "rating"}, {"id": "info-s5vob122", "key": "writing_skill", "note": "1（写作能力很弱）\\n5（写作能力很强）", "label": "请您评价自己的文字写作能力（例如：表达清晰度、词汇丰富度、逻辑性等）。", "options": [], "varType": "string", "required": true, "inputType": "rating"}], "contextText": "", "inputVariableName": "input"}, "type": "infoNode", "position": {"x": 252.87036645963553, "y": 302.3601641511546}}, {"id": "node-miua8n3s-6lyd0xiz", "data": {"label": "被试基本信息填写", "variables": [{"id": "info-6dp84pi9", "key": "gender", "note": "", "label": "性别", "options": [{"label": "男", "value": "男"}, {"label": "女", "value": "女"}, {"label": "非二元性别", "value": "非二元性别"}], "varType": "string", "required": true, "inputType": "radio"}, {"id": "info-ulr5moj4", "key": "age", "note": "", "label": "年龄", "options": [{"label": "18-24岁", "value": "18-24岁"}, {"label": "25-34岁", "value": "25-34岁"}, {"label": "35-44岁", "value": "35-44岁"}, {"label": "45-54岁", "value": "45-54岁"}, {"label": "55-64岁", "value": "55-64岁"}, {"label": "65岁及以上", "value": "65岁及以上"}], "varType": "string", "required": true, "inputType": "select"}, {"id": "info-pb5z9bkj", "key": "martial status", "note": "", "label": "婚姻状况", "options": [{"label": "已婚", "value": "已婚"}, {"label": "未婚", "value": "未婚"}, {"label": "离异", "value": "离异"}], "varType": "string", "required": true, "inputType": "radio"}, {"id": "info-1w7jhyyd", "key": "education", "note": "", "label": "受教育程度", "options": [{"label": "高中及以下", "value": "高中及以下"}, {"label": "大专", "value": "大专"}, {"label": "本科", "value": "本科"}, {"label": "硕士", "value": "硕士"}, {"label": "博士", "value": "博士"}], "varType": "string", "required": true, "inputType": "radio"}, {"id": "info-ao4914e2", "key": "employment status", "note": "", "label": "就业状况", "options": [{"label": "全职工作", "value": "全职工作"}, {"label": "兼职工作", "value": "兼职工作"}, {"label": "无工作", "value": "无工作"}], "varType": "string", "required": true, "inputType": "select"}, {"id": "info-w4pwfuw6", "key": "income", "note": "", "label": "收入", "options": [{"label": "<5000/月", "value": "<5000/月"}, {"label": "5000-10000/月", "value": "5000-10000/月"}, {"label": "10000-20000/月", "value": "10000-20000/月"}, {"label": "20000-30000/月", "value": "20000-30000/月"}, {"label": "30000-40000/月", "value": "30000-40000/月"}, {"label": ">40000/月", "value": ">40000/月"}], "varType": "string", "required": true, "inputType": "select"}], "contextText": "", "inputVariableName": "input"}, "type": "infoNode", "position": {"x": 427.6640550363355, "y": 697.7396032371796}}, {"id": "node-miua90fg-5xb2117h", "data": {"label": "[结束] 流程终点"}, "type": "endNode", "position": {"x": 422.79004521263573, "y": 1324.445921742916}}]}	83cf7ae9-fd96-426c-9e26-effd554cc8c9	{"dimensions": [], "overallFeedback": {"prompt": "", "enabled": false}}
35	exp4	{"edges": [{"id": "xy-edge__node-minns6ly-5m7zp1i5start-output-node-minoy0mi-phayjw3vinput", "source": "node-minns6ly-5m7zp1i5", "target": "node-minoy0mi-phayjw3v", "sourceHandle": "start-output", "targetHandle": "input"}, {"id": "xy-edge__node-minoy0mi-phayjw3voutput-node-minnsfbh-5aw6lebxend-input", "source": "node-minoy0mi-phayjw3v", "target": "node-minnsfbh-5aw6lebx", "sourceHandle": "output", "targetHandle": "end-input"}], "nodes": [{"id": "node-minns6ly-5m7zp1i5", "data": {"label": "[启动] 实验简介", "startObjective": "", "startBackground": "", "inputVariableName": "input", "startDeliverables": ""}, "type": "startNode", "position": {"x": -748.7911455226692, "y": -898.5155569085653}}, {"id": "node-minnsfbh-5aw6lebx", "data": {"label": "[结束] 流程终点", "contextText": "", "inputVariableName": "input"}, "type": "endNode", "position": {"x": -724.8668178371505, "y": -685.3639073317248}}, {"id": "node-minoy0mi-phayjw3v", "data": {"label": "[Human] 任务", "category": "human", "allowAgent": true, "contextText": "", "copilotWorkflowId": "7578921176311791616", "inputVariableName": "input"}, "type": "taskNode", "position": {"x": -591.6911546779427, "y": -783.7897325016147}}]}	f64611ca-6a4d-42dd-ac81-c2c91b190dd0	{"dimensions": [], "overallFeedback": {"prompt": "", "enabled": false}}
3	exp2	{"edges": [{"id": "xy-edge__dndnode_0output-dndnode_1input", "source": "dndnode_0", "target": "dndnode_1", "sourceHandle": "output", "targetHandle": "input"}, {"id": "xy-edge__dndnode_1output-dndnode_2input", "source": "dndnode_1", "target": "dndnode_2", "sourceHandle": "output", "targetHandle": "input"}, {"id": "xy-edge__node-miinkr3d-7miw0xd9start-output-dndnode_0input", "source": "node-miinkr3d-7miw0xd9", "target": "dndnode_0", "sourceHandle": "start-output", "targetHandle": "input"}, {"id": "xy-edge__dndnode_2output-node-miinl166-tn088zyyend-input", "source": "dndnode_2", "target": "node-miinl166-tn088zyy", "sourceHandle": "output", "targetHandle": "end-input"}], "nodes": [{"id": "dndnode_0", "data": {"label": "[Human] 解释物理名词", "category": "human", "allowAgent": true, "contextText": "", "instruction": "100字解释相对论", "copilotWorkflowId": "7571793542574505984", "inputVariableName": "input", "evaluationCriterion": "输出是否符合事实", "evaluationWorkflowId": "7572347832489738240"}, "type": "taskNode", "position": {"x": 309.34294176802996, "y": 24.520761911084776}}, {"id": "dndnode_1", "data": {"label": "[Agent] AI加工", "category": "agent", "allowAgent": false, "contextText": "", "workflow_id": "7571793542574505984", "inputVariableName": "input", "evaluationCriterion": "输出是否和输入吻合", "evaluationWorkflowId": "7572347832489738240"}, "type": "taskNode", "position": {"x": 276.25, "y": 119}}, {"id": "dndnode_2", "data": {"label": "[Human] 总结提炼", "category": "human", "allowAgent": false, "contextText": "", "instruction": "提炼上下文的输出", "inputVariableName": "input", "evaluationCriterion": "是否符合总结的标准", "evaluationWorkflowId": "7572347832489738240"}, "type": "taskNode", "position": {"x": 283.25, "y": 199}}, {"id": "node-miinkr3d-7miw0xd9", "data": {"label": "[启动] 实验简介", "startObjective": "", "startBackground": "", "startDeliverables": ""}, "type": "startNode", "position": {"x": 265.89646172874154, "y": -71.28962543407553}}, {"id": "node-miinl166-tn088zyy", "data": {"label": "[结束] 流程终点"}, "type": "endNode", "position": {"x": 392.30303549934695, "y": 329.3287430516577}}]}	f64611ca-6a4d-42dd-ac81-c2c91b190dd0	{"dimensions": [{"id": "76678ecd-fa28-40a8-b14e-5e44637baf9b", "name": "正确性", "evaluator": "llm", "scoreScale": 5, "description": "是否符合事实", "llmWorkflowId": "7572347832489738240", "scoringMethod": "5分制"}, {"id": "e499eaa0-4909-424f-be6c-58c3cbf3b677", "name": "创造性", "evaluator": "llm", "scoreScale": 5, "description": "观点是否新颖", "llmWorkflowId": "7572347832489738240", "scoringMethod": "5分制"}], "overallFeedback": {"prompt": "", "enabled": false}}
8	Delegation Decision_S1_G1a	{"edges": [{"id": "xy-edge__node-mie0ms34-w2r6gpxzoutput-node-miedmup9-b238794iinput", "source": "node-mie0ms34-w2r6gpxz", "target": "node-miedmup9-b238794i", "sourceHandle": "output", "targetHandle": "input"}, {"id": "xy-edge__node-miedmup9-b238794ioutput-node-mi7973bg-8w6fj9fminput", "source": "node-miedmup9-b238794i", "target": "node-mi7973bg-8w6fj9fm", "sourceHandle": "output", "targetHandle": "input"}, {"id": "xy-edge__node-mi795m91-xkrbgdj2start-output-node-mie0ms34-w2r6gpxzinput", "source": "node-mi795m91-xkrbgdj2", "target": "node-mie0ms34-w2r6gpxz", "sourceHandle": "start-output", "targetHandle": "input"}, {"id": "xy-edge__node-mi7973bg-8w6fj9fmoutput-node-miiginej-0lyp2e6yinput", "source": "node-mi7973bg-8w6fj9fm", "target": "node-miiginej-0lyp2e6y", "sourceHandle": "output", "targetHandle": "input"}, {"id": "xy-edge__node-miiginej-0lyp2e6youtput-node-miee3r6p-gn7l49u9end-input", "source": "node-miiginej-0lyp2e6y", "target": "node-miee3r6p-gn7l49u9", "sourceHandle": "output", "targetHandle": "end-input"}], "nodes": [{"id": "node-mi795m91-xkrbgdj2", "data": {"label": "[启动] 实验简介", "startObjective": "提出一个创新的APP创意，该 App 旨在促进更健康的生活方式", "startBackground": "想象你正在为一家名为\\"博伦科技\\"的公司工作。该公司正在寻求创新的 App 概念，以响应消费者对数字健康工具日益增长的需求，帮助用户过上更健康的生活。", "inputVariableName": "input", "startDeliverables": "APP产品创意文案"}, "type": "startNode", "position": {"x": 759.2561607714201, "y": 493.63739796654085}}, {"id": "node-mi7973bg-8w6fj9fm", "data": {"label": "被试自评", "variables": [{"id": "info-xl40jnto", "key": "self_perceived_creativity", "note": "", "label": "请您评价自己是一个富有创造力的人的程度", "options": [], "varType": "string", "required": true, "inputType": "rating"}, {"id": "info-jqhua8w7", "key": "familiarity_GPT", "note": "", "label": "在日常生活中，您使用 ChatGPT 的频率是？", "options": [{"label": "从不使用", "value": "从不使用"}, {"label": "很少使用（每月几次）", "value": "很少使用（每月几次）"}, {"label": "有时使用（每周几次）", "value": "有时使用（每周几次）"}, {"label": "经常使用（几乎每天）", "value": "经常使用（几乎每天）"}], "varType": "string", "required": true, "inputType": "radio"}, {"id": "info-h3av96it", "key": "domain_knowledge", "note": "1（完全不了解）\\n5（非常熟悉）", "label": "您对市场上与健康、健身相关的移动应用程序（例如：Keep, MyFitnessPal, 苹果健康等）有多熟悉？", "options": [], "varType": "string", "required": true, "inputType": "rating"}, {"id": "info-tf6d20kf", "key": "writing_skill", "note": "1（写作能力很弱）\\n5（写作能力很强）", "label": "请您评价自己的文字写作能力（例如：表达清晰度、词汇丰富度、逻辑性等）。", "options": [], "varType": "string", "required": true, "inputType": "rating"}], "contextText": "", "inputVariableName": "input"}, "type": "infoNode", "position": {"x": 612.5234747267325, "y": 868.0957855096804}}, {"id": "node-mie0ms34-w2r6gpxz", "data": {"label": "任务一：Idea generation", "category": "human", "taskType": "brainstorming", "allowAgent": false, "contextText": "", "instruction": "1. 背景：想象你正在为一家名为\\"博伦科技\\"的公司工作。该公司正在寻求创新的 App 概念，以响应消费者对数字健康工具日益增长的需求，帮助用户过上更健康的生活。\\n\\n2. 任务要求：\\n请在下方文本框中详细描述您的 App 初始创意。\\n您必须完全依靠自己来构思和撰写，请勿使用任何 AI 工具。\\n\\n为了让您的创意更具说服力，建议您的描述包含以下内容（仅供参考）：\\n - App 名称：给它起一个响亮的名字。\\n - 核心功能：它能做什么？解决了什么问题？\\n - 目标用户：谁会使用它？", "outputEditorType": "plaintext", "copilotWorkflowId": "", "inputVariableName": "input", "contextDocumentUrl": "", "evaluationDimensions": [{"id": "branch-85swcf9q", "name": "创意度", "prompt": "", "evaluator": "llm", "scoreScale": 5, "description": "这个创意是否新颖、独特，与现有的 App 不同？", "llmWorkflowId": "7572347832489738240"}, {"id": "branch-xxm20tzl", "name": "写作质量", "prompt": "", "evaluator": "llm", "scoreScale": 5, "description": "这个创意的表达是否清晰、流畅？", "llmWorkflowId": "7572347832489738240"}, {"id": "branch-healeb67", "name": "购买/使用意愿", "prompt": "", "evaluator": "llm", "scoreScale": 5, "description": "如果这款 App 上线，你有多大可能会下载使用？", "llmWorkflowId": "7572347832489738240"}, {"id": "branch-n4jik7c4", "name": "预测流行度", "prompt": "", "evaluator": "llm", "scoreScale": 5, "description": "你认为这款 App 会受到大众市场的欢迎吗？", "llmWorkflowId": "7572347832489738240"}], "evaluationWorkflowId": "7576114694956515328"}, "type": "taskNode", "position": {"x": 807.129476218258, "y": 666.7164512638379}}, {"id": "node-miedmup9-b238794i", "data": {"label": "任务二-Idea Refinement", "category": "human", "taskType": "writing", "allowAgent": true, "contextText": "", "instruction": "现在你已经有了一个初始创意。在这个阶段，你将与一位 AI 助手合作，对这个创意进行打磨、润色和改进。\\n\\n你可以通过右侧的聊天界面与 AI 自由互动。当你对结果满意时，请提交最终版本的创意。", "outputEditorType": "plaintext", "copilotWorkflowId": "7579907154346246144", "inputVariableName": "input", "evaluationDimensions": [{"id": "branch-zplycd7x", "name": "创意度", "prompt": "", "evaluator": "llm", "scoreScale": 5, "description": "这个创意是否新颖、独特，与现有的 App 不同？", "llmWorkflowId": "7572347832489738240"}, {"id": "branch-9rfm4lxj", "name": "写作质量", "prompt": "", "evaluator": "llm", "scoreScale": 5, "description": "这个创意的表达是否清晰、流畅？", "llmWorkflowId": "7572347832489738240"}, {"id": "branch-1uwoyz50", "name": "购买/使用意愿", "prompt": "", "evaluator": "llm", "scoreScale": 5, "description": "如果这款 App 上线，你有多大可能会下载使用？", "llmWorkflowId": "7572347832489738240"}, {"id": "branch-1wgjeuf1", "name": "预测流行度", "prompt": "", "evaluator": "llm", "scoreScale": 5, "description": "你认为这款 App 会受到大众市场的欢迎吗？", "llmWorkflowId": "7572347832489738240"}], "evaluationWorkflowId": "7576114694956515328"}, "type": "taskNode", "position": {"x": 808.275311058852, "y": 775.8077305995532}}, {"id": "node-miee3r6p-gn7l49u9", "data": {"label": "[结束] 流程终点", "contextText": "", "inputVariableName": "input"}, "type": "endNode", "position": {"x": 780.2939620144369, "y": 1875.8189639680124}}, {"id": "node-miiginej-0lyp2e6y", "data": {"label": "demographic信息填写", "variables": [{"id": "info-itbi0le0", "key": "gender", "note": "", "label": "gender", "options": [{"label": "男", "value": "男"}, {"label": "女", "value": "女"}, {"label": "非二元性别", "value": "非二元性别"}], "varType": "string", "required": true, "inputType": "radio"}, {"id": "info-satlj9xx", "key": "age", "note": "", "label": "年龄", "options": [{"label": "18-24岁", "value": "18-24岁"}, {"label": "25-34岁", "value": "25-34岁"}, {"label": "35-44岁", "value": "35-44岁"}, {"label": "45-54岁", "value": "45-54岁"}, {"label": "55-64岁", "value": "55-64岁"}, {"label": "65岁及以上", "value": "65岁及以上"}], "varType": "string", "required": true, "inputType": "select"}, {"id": "info-a6dqotkc", "key": "martial status", "note": "", "label": "婚姻状况", "options": [{"label": "已婚", "value": "已婚"}, {"label": "未婚", "value": "未婚"}, {"label": "离异", "value": "离异"}], "varType": "string", "required": true, "inputType": "radio"}, {"id": "info-v4e2rs94", "key": "education", "note": "", "label": "受教育程度", "options": [{"label": "高中及以下", "value": "高中及以下"}, {"label": "大专", "value": "大专"}, {"label": "本科", "value": "本科"}, {"label": "硕士", "value": "硕士"}, {"label": "博士", "value": "博士"}], "varType": "string", "required": true, "inputType": "radio"}, {"id": "info-2s5by0rh", "key": "employment status", "note": "", "label": "就业状况", "options": [{"label": "全职工作", "value": "全职工作"}, {"label": "兼职工作", "value": "兼职工作"}, {"label": "无工作", "value": "无工作"}], "varType": "string", "required": true, "inputType": "select"}, {"id": "info-hu5zhhhz", "key": "income", "note": "", "label": "收入", "options": [{"label": "<5000/月", "value": "<5000/月"}, {"label": "5000-10000/月", "value": "5000-10000/月"}, {"label": "10000-20000/月", "value": "10000-20000/月"}, {"label": "20000-30000/月", "value": "20000-30000/月"}, {"label": "30000-40000/月", "value": "30000-40000/月"}, {"label": ">40000/月", "value": ">40000/月"}], "varType": "string", "required": true, "inputType": "select"}], "contextText": "", "inputVariableName": "input"}, "type": "infoNode", "position": {"x": 785.4950886956436, "y": 1236.2455376612388}}]}	0399fa1a-4045-425b-b514-dfd8fb44f233	{"dimensions": [], "overallFeedback": {"prompt": "", "enabled": false}}
42	agent	{"edges": [{"id": "xy-edge__node-mir7mwqb-fhv2z79astart-output-node-mir7mtnu-tmghxkp3input", "source": "node-mir7mwqb-fhv2z79a", "target": "node-mir7mtnu-tmghxkp3", "sourceHandle": "start-output", "targetHandle": "input"}, {"id": "xy-edge__node-mir7mtnu-tmghxkp3output-node-mir7o5ff-leu14dl2end-input", "source": "node-mir7mtnu-tmghxkp3", "target": "node-mir7o5ff-leu14dl2", "sourceHandle": "output", "targetHandle": "end-input"}], "nodes": [{"id": "node-mir7mtnu-tmghxkp3", "data": {"label": "[Agent] 任务", "category": "agent", "allowAgent": false, "contextText": "", "workflow_id": "7574799036708814848", "inputVariableName": "input", "evaluationDimensions": []}, "type": "taskNode", "position": {"x": 334.0361789890456, "y": -257.23109204045926}}, {"id": "node-mir7mwqb-fhv2z79a", "data": {"label": "[启动] 实验简介", "startObjective": "为虚构公司 BloomTech 设计⼀款帮助⽤⼾养成更健康⽣活⽅式的⼿机 App 创意。", "startBackground": "在开放式创意任务中，⼈是否能有效地把⼯作委派给 LLM", "inputVariableName": "input", "startDeliverables": "交付创意文本"}, "type": "startNode", "position": {"x": 251.63616983377216, "y": -350.88109165898953}}, {"id": "node-mir7o5ff-leu14dl2", "data": {"label": "[结束] 流程终点"}, "type": "endNode", "position": {"x": 281.63616983377216, "y": -186.38109165898953}}]}	01941460-10a5-4fd1-87f3-8d19625e4f04	{"dimensions": [], "overallFeedback": {"prompt": "", "enabled": false}}
40	lzx	{"edges": [{"id": "xy-edge__node-mir7hb17-s487ws0bstart-output-node-mir6ufmu-50fz128qinput", "source": "node-mir7hb17-s487ws0b", "target": "node-mir6ufmu-50fz128q", "sourceHandle": "start-output", "targetHandle": "input"}, {"id": "xy-edge__node-mir6ufmu-50fz128qoutput-node-mir7me6u-37i3owzgend-input", "source": "node-mir6ufmu-50fz128q", "target": "node-mir7me6u-37i3owzg", "sourceHandle": "output", "targetHandle": "end-input"}], "nodes": [{"id": "node-mir6ufmu-50fz128q", "data": {"label": "[Human] 任务1", "category": "human", "taskType": "writing", "allowAgent": false, "contextText": "", "instruction": "为虚构公司 BloomTech 设计⼀款帮助⽤⼾养成更健康⽣活⽅式的⼿机 App 创意。", "copilotWorkflowId": "", "inputVariableName": "input", "evaluationDimensions": [{"id": "branch-rua1p16z", "name": "写作质量", "prompt": "", "evaluator": "human", "scoreScale": 5, "description": "", "llmWorkflowId": ""}, {"id": "branch-fxzso5tw", "name": "创意度", "prompt": "", "evaluator": "human", "scoreScale": 5, "description": "", "llmWorkflowId": ""}]}, "type": "taskNode", "position": {"x": 275.0584575856461, "y": -183.0176231268876}}, {"id": "node-mir7hb17-s487ws0b", "data": {"label": "[启动] delegation实验", "startObjective": "为虚构公司 BloomTech 设计⼀款帮助⽤⼾养成更健康⽣活⽅式的⼿机 App 创意。", "startBackground": "在开放式创意任务中，⼈是否能有效地把⼯作委派给 LLM", "inputVariableName": "input", "startDeliverables": "创意文本"}, "type": "startNode", "position": {"x": 197.6584484303727, "y": -320.84261959829263}}, {"id": "node-mir7me6u-37i3owzg", "data": {"label": "[结束] 流程终点", "contextText": "", "inputVariableName": "input"}, "type": "endNode", "position": {"x": 242.8353267151665, "y": -81.12160903730982}}]}	01941460-10a5-4fd1-87f3-8d19625e4f04	{"dimensions": [{"id": "dim-846uj8q4", "name": "", "evaluator": "human", "scoreScale": 5, "description": "", "llmWorkflowId": "", "scoringMethod": "5分制"}], "overallFeedback": {"prompt": "", "enabled": true}}
45	Study1_zengsipeng_3	{"edges": [{"id": "xy-edge__node-mir6q56m-yakr1pkhstart-output-node-mir6pvfn-dbj7gdp4input", "source": "node-mir6q56m-yakr1pkh", "target": "node-mir6pvfn-dbj7gdp4", "sourceHandle": "start-output", "targetHandle": "input"}, {"id": "xy-edge__node-mir6pvfn-dbj7gdp4output-node-mir7maua-h435fg4jinput", "source": "node-mir6pvfn-dbj7gdp4", "target": "node-mir7maua-h435fg4j", "sourceHandle": "output", "targetHandle": "input"}, {"id": "xy-edge__node-mir7maua-h435fg4joutput-node-mir7mw99-7ucn7ae0input", "source": "node-mir7maua-h435fg4j", "target": "node-mir7mw99-7ucn7ae0", "sourceHandle": "output", "targetHandle": "input"}], "nodes": [{"id": "node-mir6pvfn-dbj7gdp4", "data": {"label": "[Human] 任务", "category": "human", "allowAgent": true, "contextText": "", "instruction": "为虚构公司 BloomTech 设计⼀款帮助⽤⼾养成更健康⽣活⽅式的⼿机 App 创意,请你自己生成点子", "outputEditorType": "richtext", "copilotWorkflowId": "7579199088822845440", "inputVariableName": "input"}, "type": "taskNode", "position": {"x": 874.0761898417753, "y": 265.58265000889264}}, {"id": "node-mir6q56m-yakr1pkh", "data": {"label": "[启动] 实验简介", "startObjective": "完整参与实验全流程，真实反馈自身决策与交互体验，帮助研究者验证实验设计的合理性与流程完整性；\\n基于实验提示完成 “是否委派” 的决策选择，生成符合情景要求的初始 App 创意；\\n与智能体（LLM）进行有效对话，针对性地对初始创意进行润色优化，形成更完善的创意方案；", "startBackground": "在数字创意与智能协作深度融合的当下，人机协同已成为提升创意产出效率的重要模式。本实验聚焦于 “人类 - 智能体（Human–Agent）” 协作场景，旨在探索普通人与大语言模型（LLM）协同完成创意优化的过程机制，为后续优化人机协作创意工具、提升用户创意体验提供学术依据与实践参考。\\n本次实验将模拟真实的 App 创意开发场景，你将作为创意发起者，先基于特定情景形成初始 App 创意，再与智能体（LLM）进行互动协作，对创意进行润色完善。你的每一步选择与反馈，都将为研究 “人机协作中的创意生成、决策偏好及交互效果” 提供关键数据支持", "inputVariableName": "input", "startDeliverables": "您最终需要交付一个创意方案，即经过 LLM 润色后，你认可的最终 App 创意描述"}, "type": "startNode", "position": {"x": 801.2264251502345, "y": 91.13905193268418}}, {"id": "node-mir7maua-h435fg4j", "data": {"label": "[Human] 任务", "category": "human", "taskType": "writing", "allowAgent": true, "contextText": "", "instruction": "对初始创意进⾏多轮润⾊和完善；", "copilotWorkflowId": "7579907154346246144", "inputVariableName": "input"}, "type": "taskNode", "position": {"x": 871.657438817755, "y": 416.958009658636}}, {"id": "node-mir7mw99-7ucn7ae0", "data": {"label": "[Human] 信息输入", "variables": [{"id": "info-o0cr12mo", "key": "", "note": "", "label": "", "options": [], "varType": "string", "required": false, "inputType": "text"}]}, "type": "infoNode", "position": {"x": 826.4235871948134, "y": 567.1990168348341}}]}	1608ba80-8e25-4424-b7ad-5fecacedf81d	{"dimensions": [], "overallFeedback": {"prompt": "", "enabled": false}}
52	test1	{"edges": [{"id": "xy-edge__node-mis9wg4v-gcpxhf71start-output-node-mis9x4bf-5m8m01ttinput", "source": "node-mis9wg4v-gcpxhf71", "target": "node-mis9x4bf-5m8m01tt", "sourceHandle": "start-output", "targetHandle": "input"}, {"id": "xy-edge__node-mis9x4bf-5m8m01ttoutput-node-mis9yhxd-4syinqcjinput", "source": "node-mis9x4bf-5m8m01tt", "target": "node-mis9yhxd-4syinqcj", "sourceHandle": "output", "targetHandle": "input"}, {"id": "xy-edge__node-mis9yhxd-4syinqcjbranch-i889y3dz-node-misa0es1-avbo6qy8input", "data": {"condition": "lastOutput?.[\\"选择\\"] === '1'", "edgeLabel": "选择 = '1'", "isDefault": false, "conditionDisplay": "lastOutput?.[\\"选择\\"] = '1'"}, "label": "选择 = '1'", "source": "node-mis9yhxd-4syinqcj", "target": "node-misa0es1-avbo6qy8", "sourceHandle": "branch-i889y3dz", "targetHandle": "input"}, {"id": "xy-edge__node-mis9yhxd-4syinqcjbranch-g12m35tr-node-misa2b3c-jfohk7lfinput", "data": {"condition": "lastOutput?.[\\"选择2\\"] === '2'", "edgeLabel": "选择2 = '2'", "isDefault": true, "conditionDisplay": "lastOutput?.[\\"选择2\\"] = '2'"}, "label": "选择2 = '2'", "source": "node-mis9yhxd-4syinqcj", "target": "node-misa2b3c-jfohk7lf", "sourceHandle": "branch-g12m35tr", "targetHandle": "input"}, {"id": "xy-edge__node-misa0es1-avbo6qy8output-node-misa3dny-yairdiwpmerge-input", "source": "node-misa0es1-avbo6qy8", "target": "node-misa3dny-yairdiwp", "sourceHandle": "output", "targetHandle": "merge-input"}, {"id": "xy-edge__node-misa2b3c-jfohk7lfoutput-node-misa3dny-yairdiwpmerge-input", "source": "node-misa2b3c-jfohk7lf", "target": "node-misa3dny-yairdiwp", "sourceHandle": "output", "targetHandle": "merge-input"}, {"id": "xy-edge__node-misa3dny-yairdiwpmerge-output-node-misa3y25-gcxo2o0zend-input", "source": "node-misa3dny-yairdiwp", "target": "node-misa3y25-gcxo2o0z", "sourceHandle": "merge-output", "targetHandle": "end-input"}], "nodes": [{"id": "node-mis9wg4v-gcpxhf71", "data": {"label": "[启动] 实验简介", "startObjective": "1", "startBackground": "1", "inputVariableName": "input", "startDeliverables": "1"}, "type": "startNode", "position": {"x": 472.33331298828125, "y": 264.16666412353516}}, {"id": "node-mis9x4bf-5m8m01tt", "data": {"label": "[Human] 信息输入", "variables": [{"id": "info-7nosgm08", "key": "选择", "note": "", "label": "选择", "options": [], "varType": "string", "required": true, "inputType": "number"}], "contextText": "", "inputVariableName": "input"}, "type": "infoNode", "position": {"x": 505.9999694824219, "y": 418.24999618530273}}, {"id": "node-mis9yhxd-4syinqcj", "data": {"label": "[分支] 条件分流", "branches": [{"id": "branch-i889y3dz", "label": "分支 1", "value": "1", "operator": "equals", "variable": "选择", "condition": "lastOutput?.[\\"选择\\"] === '1'", "edgeLabel": "选择 = '1'", "isDefault": false, "valueType": "string", "conditionDisplay": "lastOutput?.[\\"选择\\"] = '1'"}, {"id": "branch-g12m35tr", "label": "其他", "value": "2", "operator": "equals", "variable": "选择2", "condition": "lastOutput?.[\\"选择2\\"] === '2'", "edgeLabel": "选择2 = '2'", "isDefault": true, "valueType": "string", "conditionDisplay": "lastOutput?.[\\"选择2\\"] = '2'"}], "contextText": "", "inputVariableName": "input", "allowDefaultBranch": true}, "type": "branchNode", "position": {"x": 474.4999694824219, "y": 583.7499961853027}}, {"id": "node-misa0es1-avbo6qy8", "data": {"label": "[Human] 任务", "category": "human", "allowAgent": true, "contextText": "", "copilotWorkflowId": "7579199088822845440", "inputVariableName": "input", "evaluationDimensions": [{"id": "branch-q5jiy6wi", "name": "准确性", "prompt": "", "evaluator": "human", "scoreScale": 5, "description": "", "llmWorkflowId": ""}]}, "type": "taskNode", "position": {"x": 440.4999694824219, "y": 739.7499961853027}}, {"id": "node-misa2b3c-jfohk7lf", "data": {"label": "[Agent] 任务", "category": "agent", "contextText": "", "inputVariableName": "input"}, "type": "taskNode", "position": {"x": 625.4999694824219, "y": 741.2499961853027}}, {"id": "node-misa3dny-yairdiwp", "data": {"label": "[汇聚] 分支合流", "contextText": "", "inputVariableName": "input"}, "type": "mergeNode", "position": {"x": 501.9999694824219, "y": 840.2499961853027}}, {"id": "node-misa3y25-gcxo2o0z", "data": {"label": "[结束] 流程终点", "contextText": "", "inputVariableName": "input"}, "type": "endNode", "position": {"x": 489.4795964928311, "y": 1002.2350693474839}}]}	4398b7ca-ef2c-4b26-b426-d69340b4c15c	{"dimensions": [{"id": "dim-dfxgufdp", "name": "完成度", "evaluator": "human", "scoreScale": 5, "description": "", "llmWorkflowId": "", "scoringMethod": "5分制"}], "overallFeedback": {"prompt": "", "enabled": false}}
46	Study1_zengsipeng_4	{"edges": [{"id": "xy-edge__node-mir6q56m-yakr1pkhstart-output-node-mir6pvfn-dbj7gdp4input", "source": "node-mir6q56m-yakr1pkh", "target": "node-mir6pvfn-dbj7gdp4", "sourceHandle": "start-output", "targetHandle": "input"}, {"id": "xy-edge__node-mir6pvfn-dbj7gdp4output-node-mir7maua-h435fg4jinput", "source": "node-mir6pvfn-dbj7gdp4", "target": "node-mir7maua-h435fg4j", "sourceHandle": "output", "targetHandle": "input"}, {"id": "xy-edge__node-mir7maua-h435fg4joutput-node-mir7mw99-7ucn7ae0input", "source": "node-mir7maua-h435fg4j", "target": "node-mir7mw99-7ucn7ae0", "sourceHandle": "output", "targetHandle": "input"}], "nodes": [{"id": "node-mir6pvfn-dbj7gdp4", "data": {"label": "[Human] 任务", "category": "human", "allowAgent": true, "contextText": "", "instruction": "为虚构公司 BloomTech 设计⼀款帮助⽤⼾养成更健康⽣活⽅式的⼿机 App 创意,请你自己生成点子", "outputEditorType": "richtext", "copilotWorkflowId": "7579199088822845440", "inputVariableName": "input"}, "type": "taskNode", "position": {"x": 874.0761898417753, "y": 265.58265000889264}}, {"id": "node-mir6q56m-yakr1pkh", "data": {"label": "[启动] 实验简介", "startObjective": "完整参与实验全流程，真实反馈自身决策与交互体验，帮助研究者验证实验设计的合理性与流程完整性；\\n基于实验提示完成 “是否委派” 的决策选择，生成符合情景要求的初始 App 创意；\\n与智能体（LLM）进行有效对话，针对性地对初始创意进行润色优化，形成更完善的创意方案；", "startBackground": "在数字创意与智能协作深度融合的当下，人机协同已成为提升创意产出效率的重要模式。本实验聚焦于 “人类 - 智能体（Human–Agent）” 协作场景，旨在探索普通人与大语言模型（LLM）协同完成创意优化的过程机制，为后续优化人机协作创意工具、提升用户创意体验提供学术依据与实践参考。\\n本次实验将模拟真实的 App 创意开发场景，你将作为创意发起者，先基于特定情景形成初始 App 创意，再与智能体（LLM）进行互动协作，对创意进行润色完善。你的每一步选择与反馈，都将为研究 “人机协作中的创意生成、决策偏好及交互效果” 提供关键数据支持", "inputVariableName": "input", "startDeliverables": "您最终需要交付一个创意方案，即经过 LLM 润色后，你认可的最终 App 创意描述"}, "type": "startNode", "position": {"x": 801.2264251502345, "y": 91.13905193268418}}, {"id": "node-mir7maua-h435fg4j", "data": {"label": "[Human] 任务", "category": "human", "taskType": "writing", "allowAgent": true, "contextText": "", "instruction": "对初始创意进⾏多轮润⾊和完善；", "copilotWorkflowId": "7579907154346246144", "inputVariableName": "input"}, "type": "taskNode", "position": {"x": 871.657438817755, "y": 416.958009658636}}, {"id": "node-mir7mw99-7ucn7ae0", "data": {"label": "[Human] 信息输入", "variables": [{"id": "info-o0cr12mo", "key": "", "note": "", "label": "", "options": [], "varType": "string", "required": false, "inputType": "text"}]}, "type": "infoNode", "position": {"x": 826.4235871948134, "y": 567.1990168348341}}]}	1608ba80-8e25-4424-b7ad-5fecacedf81d	{"dimensions": [], "overallFeedback": {"prompt": "", "enabled": false}}
43	Non-informed Delegation	{"edges": [{"id": "xy-edge__node-mir7p4zf-t2tjexaxstart-output-node-mir7pd1f-e1mzjq45input", "source": "node-mir7p4zf-t2tjexax", "target": "node-mir7pd1f-e1mzjq45", "sourceHandle": "start-output", "targetHandle": "input"}], "nodes": [{"id": "node-mir7p4zf-t2tjexax", "data": {"label": "[启动] 实验简介", "startObjective": "", "startBackground": "", "startDeliverables": ""}, "type": "startNode", "position": {"x": 401.63616983377216, "y": -445.88109165898953}}, {"id": "node-mir7pd1f-e1mzjq45", "data": {"label": "[Human] 任务", "category": "human", "allowAgent": false, "contextText": "", "inputVariableName": "input"}, "type": "taskNode", "position": {"x": 489.73616067849866, "y": -361.5310912775198}}, {"id": "node-mir7r2wg-k8p0s4rq", "data": {"label": "[Agent] 任务", "category": "agent", "inputVariableName": "input"}, "type": "taskNode", "position": {"x": 408.23616067849866, "y": -280.356091086785}}, {"id": "node-mir7rkf8-8gi98h8a", "data": {"label": "[分支] 条件分流", "branches": [{"id": "branch-jlkrz0g9", "label": "分支 1", "value": "", "operator": "equals", "variable": "", "condition": "", "edgeLabel": "", "isDefault": false, "valueType": "string", "conditionDisplay": ""}, {"id": "branch-zrdcn6a5", "label": "其他", "value": "", "operator": "equals", "variable": "", "condition": "", "edgeLabel": "其他", "isDefault": true, "valueType": "string", "conditionDisplay": ""}], "allowDefaultBranch": true}, "type": "branchNode", "position": {"x": 559.8252643292002, "y": -299.488955792992}}]}	01941460-10a5-4fd1-87f3-8d19625e4f04	{"dimensions": [], "overallFeedback": {"prompt": "", "enabled": false}}
44	Study1_zengsipeng_2	{"edges": [{"id": "xy-edge__node-mir7maua-h435fg4joutput-node-mir7mw99-7ucn7ae0input", "source": "node-mir7maua-h435fg4j", "target": "node-mir7mw99-7ucn7ae0", "sourceHandle": "output", "targetHandle": "input"}], "nodes": [{"id": "node-mir6q56m-yakr1pkh", "data": {"label": "[启动] 实验简介", "startObjective": "完整参与实验全流程，真实反馈自身决策与交互体验，帮助研究者验证实验设计的合理性与流程完整性；\\n基于实验提示完成 “是否委派” 的决策选择，生成符合情景要求的初始 App 创意；\\n与智能体（LLM）进行有效对话，针对性地对初始创意进行润色优化，形成更完善的创意方案；", "startBackground": "在数字创意与智能协作深度融合的当下，人机协同已成为提升创意产出效率的重要模式。本实验聚焦于 “人类 - 智能体（Human–Agent）” 协作场景，旨在探索普通人与大语言模型（LLM）协同完成创意优化的过程机制，为后续优化人机协作创意工具、提升用户创意体验提供学术依据与实践参考。\\n本次实验将模拟真实的 App 创意开发场景，你将作为创意发起者，先基于特定情景形成初始 App 创意，再与智能体（LLM）进行互动协作，对创意进行润色完善。你的每一步选择与反馈，都将为研究 “人机协作中的创意生成、决策偏好及交互效果” 提供关键数据支持", "inputVariableName": "input", "startDeliverables": "您最终需要交付一个创意方案，即经过 LLM 润色后，你认可的最终 App 创意描述"}, "type": "startNode", "position": {"x": 801.2264251502345, "y": 91.13905193268418}}, {"id": "node-mir7maua-h435fg4j", "data": {"label": "[Human] 任务", "category": "human", "taskType": "writing", "allowAgent": true, "contextText": "", "instruction": "对初始创意进⾏多轮润⾊和完善；", "copilotWorkflowId": "7579907154346246144", "inputVariableName": "input"}, "type": "taskNode", "position": {"x": 871.657438817755, "y": 416.958009658636}}, {"id": "node-mir7mw99-7ucn7ae0", "data": {"label": "[Human] 信息输入", "variables": [{"id": "info-o0cr12mo", "key": "", "note": "", "label": "", "options": [], "varType": "string", "required": false, "inputType": "text"}]}, "type": "infoNode", "position": {"x": 826.4235871948134, "y": 567.1990168348341}}]}	1608ba80-8e25-4424-b7ad-5fecacedf81d	{"dimensions": [], "overallFeedback": {"prompt": "", "enabled": false}}
26	test	{"edges": [{"id": "xy-edge__node-mie26cvb-7pi1j9qfbranch-joz67xpo-node-mie1m1f2-jthqsl0zinput", "data": {"condition": "lastOutput?.[\\"任务一选择\\"] === '1'", "edgeLabel": "任务一选择 = '1'", "isDefault": false, "conditionDisplay": "lastOutput?.[\\"任务一选择\\"] = '1'"}, "label": "任务一选择 = '1'", "source": "node-mie26cvb-7pi1j9qf", "target": "node-mie1m1f2-jthqsl0z", "sourceHandle": "branch-joz67xpo", "targetHandle": "input"}, {"id": "xy-edge__node-mie1mtqg-hn6gdbfbstart-output-node-mie2dqh7-5c5oopxainput", "source": "node-mie1mtqg-hn6gdbfb", "target": "node-mie2dqh7-5c5oopxa", "sourceHandle": "start-output", "targetHandle": "input"}, {"id": "xy-edge__node-mie26cvb-7pi1j9qfbranch-wjq2mltw-node-miea6kkn-us66og7jinput", "data": {"condition": "lastOutput?.[\\"任务一选择\\"] === '3'", "edgeLabel": "任务一选择 = '3'", "isDefault": true, "conditionDisplay": "lastOutput?.[\\"任务一选择\\"] = '3'"}, "label": "任务一选择 = '3'", "source": "node-mie26cvb-7pi1j9qf", "target": "node-miea6kkn-us66og7j", "sourceHandle": "branch-wjq2mltw", "targetHandle": "input"}, {"id": "xy-edge__node-mie26cvb-7pi1j9qfbranch-bcc9uipv-node-mief26x6-cjvgnuxzinput", "data": {"condition": "lastOutput?.[\\"任务一选择\\"] === '2'", "edgeLabel": "任务一选择 = '2'", "isDefault": false, "conditionDisplay": "lastOutput?.[\\"任务一选择\\"] = '2'"}, "label": "任务一选择 = '2'", "source": "node-mie26cvb-7pi1j9qf", "target": "node-mief26x6-cjvgnuxz", "sourceHandle": "branch-bcc9uipv", "targetHandle": "input"}, {"id": "xy-edge__node-mie1m1f2-jthqsl0zoutput-node-miefosn9-znnjnh08merge-input", "source": "node-mie1m1f2-jthqsl0z", "target": "node-miefosn9-znnjnh08", "sourceHandle": "output", "targetHandle": "merge-input"}, {"id": "xy-edge__node-mief26x6-cjvgnuxzoutput-node-miefosn9-znnjnh08merge-input", "source": "node-mief26x6-cjvgnuxz", "target": "node-miefosn9-znnjnh08", "sourceHandle": "output", "targetHandle": "merge-input"}, {"id": "xy-edge__node-miea6kkn-us66og7joutput-node-miefosn9-znnjnh08merge-input", "source": "node-miea6kkn-us66og7j", "target": "node-miefosn9-znnjnh08", "sourceHandle": "output", "targetHandle": "merge-input"}, {"id": "xy-edge__node-miefxfoq-dwi3lh1vbranch-x00ftwfx-node-miefxvxx-2giuvx93input", "data": {"condition": "lastOutput?.[\\"任务二选择\\"] === '1'", "edgeLabel": "任务二选择 = '1'", "isDefault": false, "conditionDisplay": "lastOutput?.[\\"任务二选择\\"] = '1'"}, "label": "任务二选择 = '1'", "source": "node-miefxfoq-dwi3lh1v", "target": "node-miefxvxx-2giuvx93", "sourceHandle": "branch-x00ftwfx", "targetHandle": "input"}, {"id": "xy-edge__node-miefxfoq-dwi3lh1vbranch-ohrnc2jo-node-miefy1a6-2yzur9szinput", "data": {"condition": "lastOutput?.[\\"任务二选择\\"] === '2'", "edgeLabel": "任务二选择 = '2'", "isDefault": false, "conditionDisplay": "lastOutput?.[\\"任务二选择\\"] = '2'"}, "label": "任务二选择 = '2'", "source": "node-miefxfoq-dwi3lh1v", "target": "node-miefy1a6-2yzur9sz", "sourceHandle": "branch-ohrnc2jo", "targetHandle": "input"}, {"id": "xy-edge__node-miefxfoq-dwi3lh1vbranch-t2dgtm7x-node-miefy6li-yhodzep2input", "data": {"condition": "lastOutput?.[\\"任务二选择\\"] === '3'", "edgeLabel": "任务二选择 = '3'", "isDefault": true, "conditionDisplay": "lastOutput?.[\\"任务二选择\\"] = '3'"}, "label": "任务二选择 = '3'", "source": "node-miefxfoq-dwi3lh1v", "target": "node-miefy6li-yhodzep2", "sourceHandle": "branch-t2dgtm7x", "targetHandle": "input"}, {"id": "xy-edge__node-miefxvxx-2giuvx93output-node-mieg28pl-7h70gfdsmerge-input", "source": "node-miefxvxx-2giuvx93", "target": "node-mieg28pl-7h70gfds", "sourceHandle": "output", "targetHandle": "merge-input"}, {"id": "xy-edge__node-miefy1a6-2yzur9szoutput-node-mieg28pl-7h70gfdsmerge-input", "source": "node-miefy1a6-2yzur9sz", "target": "node-mieg28pl-7h70gfds", "sourceHandle": "output", "targetHandle": "merge-input"}, {"id": "xy-edge__node-miefy6li-yhodzep2output-node-mieg28pl-7h70gfdsmerge-input", "source": "node-miefy6li-yhodzep2", "target": "node-mieg28pl-7h70gfds", "sourceHandle": "output", "targetHandle": "merge-input"}, {"id": "xy-edge__node-mieg28pl-7h70gfdsmerge-output-node-mieg2om5-pnfuie7oend-input", "source": "node-mieg28pl-7h70gfds", "target": "node-mieg2om5-pnfuie7o", "sourceHandle": "merge-output", "targetHandle": "end-input"}, {"id": "xy-edge__node-mie2dqh7-5c5oopxaoutput-node-miffg7fy-lhjjrx2oinput", "source": "node-mie2dqh7-5c5oopxa", "target": "node-miffg7fy-lhjjrx2o", "sourceHandle": "output", "targetHandle": "input"}, {"id": "xy-edge__node-miffg7fy-lhjjrx2ooutput-node-mie26cvb-7pi1j9qfinput", "source": "node-miffg7fy-lhjjrx2o", "target": "node-mie26cvb-7pi1j9qf", "sourceHandle": "output", "targetHandle": "input"}, {"id": "xy-edge__node-miefosn9-znnjnh08merge-output-node-mifnxbex-0dlxeshjinput", "source": "node-miefosn9-znnjnh08", "target": "node-mifnxbex-0dlxeshj", "sourceHandle": "merge-output", "targetHandle": "input"}, {"id": "xy-edge__node-mifnxbex-0dlxeshjoutput-node-miefxfoq-dwi3lh1vinput", "source": "node-mifnxbex-0dlxeshj", "target": "node-miefxfoq-dwi3lh1v", "sourceHandle": "output", "targetHandle": "input"}], "nodes": [{"id": "node-mie1m1f2-jthqsl0z", "data": {"label": "No delegation", "category": "human", "taskType": "brainstorming", "allowAgent": false, "nodeWeight": 2, "contextText": "", "instruction": "在本阶段，你将 完全独立 生成一个健康类 App 的初步创意，不会使用任何 AI 的建议或内容。\\n\\n请根据你的理解和想象，设计一个能够帮助用户改善健康生活方式的手机应用。你可以从以下角度入手（可任选，不限）：\\n\\n应用要解决的健康问题（如睡眠、饮食、运动、压力管理等）\\n\\n目标用户是谁\\n\\n应用的核心功能是什么\\n\\n与现有产品相比有哪些创新点或独特价值\\n\\n用户为什么会愿意使用这款 App\\n\\n你的任务：\\n\\n请在输入框中写出一段 完整的应用创意描述，内容长度不限，但需确保表达清晰、结构连贯。\\n\\n注意事项：\\n\\n你将不使用 AI 生成任何内容；创意需要完全来自你本人。\\n\\n不需要非常专业的技术细节，也不要求商业计划，只需一个可理解、有潜力的点子。\\n\\n没有“正确答案”，你可以自由发挥想象力。\\n\\n完成后进入下一步。", "inputVariableName": "input", "evaluationDimensions": [{"id": "branch-xg5mqulz", "name": "任务完整度", "prompt": "", "evaluator": "human", "scoreScale": 5, "description": "", "llmWorkflowId": ""}, {"id": "branch-f98sdp2u", "name": "创意生动度", "prompt": "", "evaluator": "human", "scoreScale": 5, "description": "", "llmWorkflowId": ""}]}, "type": "taskNode", "position": {"x": 507.61105141607084, "y": 867.0038532425933}}, {"id": "node-mie1mtqg-hn6gdbfb", "data": {"label": "实验简介", "startObjective": "你需要在两个阶段内完成一个具备可读性、结构清晰、内容合理，且具有创新性和吸引力的 App 创意。\\n\\n你的核心目标包括：\\n\\n阶段 1（初始创意生成）\\n选择生成方式 → 产出一个原创应用创意草稿。\\n\\n阶段 2（创意润色）\\n再次选择协作方式 → 对创意进行语言和结构层面的提升，形成最终稿。\\n\\n最终，你将输出一个 完整的健康类 App 创意文案，作为本实验的主要结果。\\n\\nps:委派方式说明（阶段 1 与阶段 2 均需选择）\\n\\n在每个阶段，你都可以从三种方式中选择如何与 AI（或不用 AI）完成任务。下面是三种方式的详细说明，确保你完全理解它们之间的差异：\\n\\n1. 自己完成（No Delegation）\\n你完全独立完成创意生成或润色；不会使用任何 AI 生成的内容或建议；你需要自行构思、组织思路，并输入最终内容。\\n适用于你希望最大程度自主发挥创造力的情况。\\n\\n2. 与 AI 协作完成（Partial Delegation）\\n\\n你和 AI共同完成任务；通常的协作流程包括：\\n你先提供初始方向或需求;AI 提供建议、补充内容或替代方案；你拥有最终决定权，可以选择采纳、编辑或拒绝 AI 的建议。\\n适用于你希望保持主导权，但希望 AI 协助拓展想法或改善表达的情况。\\n\\n3. 完全让 AI 完成（Full Delegation）\\n\\n你将任务完全交给 AI；AI 会自动生成创意内容或自动完成润色；你只需要查看并确认 AI 生成的结果。\\n适用于你希望依赖 AI 的执行能力，而不投入较多创意或编辑精力的情况。", "startBackground": "本实验旨在研究人类在创意任务中如何与 AI（如内容生成模型）进行协作。\\n你将扮演一名受邀参与创新开发流程的“创意产出者”，任务是为一家虚构的数字健康科技公司 BloomTech 设计一款帮助用户改善健康生活方式的手机应用。\\n\\n为了模拟真实情境，你将在 两个阶段 中逐步完成创意的“生成”与“润色”，并根据自己的判断决定是否以及在何种程度上使用 AI 辅助完成任务。\\n\\n在正式开始任务前，你还会看到一段关于 AI 在创意任务中典型表现的简要介绍，这将帮助你更好地理解 AI 的能力和局限，从而做出更合理的协作选择。", "inputVariableName": "input", "startDeliverables": "最终版 App 创意文案\\n包含应用的核心概念、用户价值、主要功能和潜在吸引力等内容；\\n\\n该文案可以完全由你撰写、由你和 AI 协同生成，或由 AI 完全生成（取决于你在两个阶段的选择）"}, "type": "startNode", "position": {"x": 543.3936580201622, "y": -120.21220498270574}}, {"id": "node-mie26cvb-7pi1j9qf", "data": {"label": "分支", "branches": [{"id": "branch-joz67xpo", "label": "分支 1", "value": "1", "operator": "equals", "variable": "任务一选择", "condition": "lastOutput?.[\\"任务一选择\\"] === '1'", "edgeLabel": "任务一选择 = '1'", "isDefault": false, "valueType": "string", "conditionDisplay": "lastOutput?.[\\"任务一选择\\"] = '1'"}, {"id": "branch-bcc9uipv", "label": "分支 2", "value": "2", "operator": "equals", "variable": "任务一选择", "condition": "lastOutput?.[\\"任务一选择\\"] === '2'", "edgeLabel": "任务一选择 = '2'", "isDefault": false, "valueType": "string", "conditionDisplay": "lastOutput?.[\\"任务一选择\\"] = '2'"}, {"id": "branch-wjq2mltw", "label": "其他", "value": "3", "operator": "equals", "variable": "任务一选择", "condition": "lastOutput?.[\\"任务一选择\\"] === '3'", "edgeLabel": "任务一选择 = '3'", "isDefault": true, "valueType": "string", "conditionDisplay": "lastOutput?.[\\"任务一选择\\"] = '3'"}], "contextText": "", "inputVariableName": "input", "allowDefaultBranch": true}, "type": "branchNode", "position": {"x": 583.9992200833425, "y": 697.8832576454076}}, {"id": "node-mie2dqh7-5c5oopxa", "data": {"label": "个人信息采集", "variables": [{"id": "info-xb2v7hw1", "key": "性别", "note": "", "label": "性别", "options": [{"label": "男", "value": "男"}, {"label": "女", "value": "女"}], "varType": "string", "required": false, "inputType": "radio"}, {"id": "info-jyeu3e0x", "key": "年龄", "note": "", "label": "年龄", "options": [], "varType": "string", "required": false, "inputType": "number"}, {"id": "info-ub5e6tut", "key": "学历", "note": "", "label": "最高学历", "options": [{"label": "中学及以下", "value": "中学及以下"}, {"label": "大专", "value": "大专"}, {"label": "本科", "value": "本科"}, {"label": "研究生", "value": "研究生"}, {"label": "博士", "value": "博士"}], "varType": "string", "required": false, "inputType": "radio"}, {"id": "info-0b0yjq8n", "key": "职业", "note": "", "label": "职业", "options": [], "varType": "string", "required": false, "inputType": "text"}], "contextText": "", "inputVariableName": "input"}, "type": "infoNode", "position": {"x": 572.8000244637713, "y": 23.87875062862865}}, {"id": "node-miea6kkn-us66og7j", "data": {"label": "Full Delegation", "category": "agent", "allowAgent": false, "nodeWeight": 2, "contextText": "", "workflow_id": "7576114694956515328", "inputVariableName": "input", "evaluationDimensions": [{"id": "branch-zyqdlqrc", "name": "1", "prompt": "", "evaluator": "human", "scoreScale": 5, "description": "", "llmWorkflowId": ""}, {"id": "branch-vcg3y420", "name": "2", "prompt": "", "evaluator": "human", "scoreScale": 5, "description": "", "llmWorkflowId": ""}, {"id": "branch-kmdaduws", "name": "3", "prompt": "", "evaluator": "human", "scoreScale": 5, "description": "", "llmWorkflowId": ""}]}, "type": "taskNode", "position": {"x": 890.6084935398884, "y": 866.5017700776467}}, {"id": "node-mief26x6-cjvgnuxz", "data": {"label": "Partial Delegation", "category": "human", "taskType": "brainstorming", "allowAgent": true, "nodeWeight": 2, "contextText": "", "instruction": "在本阶段，你将 与 AI（如文本生成模型）共同生成 一个健康类 App 的初步创意。\\n你依然是创意的主要决策者，而 AI 的角色是提供辅助、建议或补充内容。\\n\\n你的任务流程：\\n\\n由你先给出一个初步方向\\n示例：应用目标、想要解决的问题、目标用户等。\\n\\nAI 将根据你的输入给出扩展建议或草稿内容\\n例如功能补充、使用场景、命名建议等。\\n\\n你可以决定如何处理 AI 的输出：\\n\\n采纳\\n\\n修改\\n\\n组合\\n\\n或全部重新编写\\n\\n最终提交的内容仍由你决定。\\n\\n注意事项：\\n\\n你必须至少向 AI 提供一段方向性输入（如创意描述、需求或偏好）。\\n\\nAI 在本阶段只提供建议，你始终保持 最终创意主导权。\\n\\n你可以多轮与 AI 互动，直到形成一个你满意的初步创意。\\n\\n完成后提交你最终的版本。", "copilotWorkflowId": "7579907154346246144", "inputVariableName": "input", "evaluationDimensions": [{"id": "branch-g90fo97q", "name": "任务完整度", "prompt": "", "evaluator": "human", "scoreScale": 5, "description": "", "llmWorkflowId": ""}, {"id": "branch-6x8dimpu", "name": "创意生动度", "prompt": "", "evaluator": "human", "scoreScale": 5, "description": "", "llmWorkflowId": ""}]}, "type": "taskNode", "position": {"x": 695.1658306346432, "y": 870.1512033947648}}, {"id": "node-miefosn9-znnjnh08", "data": {"label": "合流", "contextText": "", "inputVariableName": "input"}, "type": "mergeNode", "position": {"x": 609.4964850478952, "y": 1000.7877401915665}}, {"id": "node-miefxfoq-dwi3lh1v", "data": {"label": "分支", "branches": [{"id": "branch-x00ftwfx", "label": "分支 1", "value": "1", "operator": "equals", "variable": "任务二选择", "condition": "lastOutput?.[\\"任务二选择\\"] === '1'", "edgeLabel": "任务二选择 = '1'", "isDefault": false, "valueType": "string", "conditionDisplay": "lastOutput?.[\\"任务二选择\\"] = '1'"}, {"id": "branch-ohrnc2jo", "label": "分支 2", "value": "2", "operator": "equals", "variable": "任务二选择", "condition": "lastOutput?.[\\"任务二选择\\"] === '2'", "edgeLabel": "任务二选择 = '2'", "isDefault": false, "valueType": "string", "conditionDisplay": "lastOutput?.[\\"任务二选择\\"] = '2'"}, {"id": "branch-t2dgtm7x", "label": "其他", "value": "3", "operator": "equals", "variable": "任务二选择", "condition": "lastOutput?.[\\"任务二选择\\"] === '3'", "edgeLabel": "任务二选择 = '3'", "isDefault": true, "valueType": "string", "conditionDisplay": "lastOutput?.[\\"任务二选择\\"] = '3'"}], "contextText": "", "inputVariableName": "input", "allowDefaultBranch": true}, "type": "branchNode", "position": {"x": 624.6697395560321, "y": 1400.4121864967517}}, {"id": "node-miefxvxx-2giuvx93", "data": {"label": "No delegation", "category": "human", "taskType": "brainstorming", "allowAgent": false, "contextText": "", "instruction": "在本阶段，你将 完全独立 对你的初始创意进行润色与完善，不会使用任何 AI 的建议或内容。\\n\\n你需要根据自己的判断，对初稿进行内容调整与表达优化。你可以从以下角度入手（可任选，不限）：\\n\\n对内容进行语言润色，使表达更清晰流畅\\n\\n增强结构，使创意描述更有逻辑、更易理解\\n\\n对功能、价值、使用场景等内容进行补充或精炼\\n\\n调整措辞，让创意更具吸引力或更专业\\n\\n修正不明确、不完整或不自然的部分\\n\\n你的任务：\\n\\n请在输入框中写出一段 润色后的最终创意描述。\\n内容长度不限，但需确保表达清晰、结构完整、逻辑连贯，能够充分呈现你的最终创意版本。\\n\\n注意事项：\\n\\n本阶段你将 不使用 AI 的任何建议或生成内容；所有修改均应由你亲自完成。\\n\\n不需要使用专业市场术语，只需让你的描述更加完善、自然、有说服力。\\n\\n没有“标准答案”，你可以自由选择润色重点。\\n\\n完成后进入下一步。", "inputVariableName": "input"}, "type": "taskNode", "position": {"x": 512.8049919452403, "y": 1519.7439653247654}}, {"id": "node-miefy1a6-2yzur9sz", "data": {"label": "Partial Delegation", "category": "human", "taskType": "brainstorming", "allowAgent": true, "nodeWeight": 3, "contextText": "", "instruction": "在本阶段，你将 与 AI 协作 完成对初始创意的润色与提升。\\n你依然保持最终决定权，而 AI 将提供辅助性建议。\\n\\n你可以从以下角度向 AI 发起请求（可任选，不限）：\\n\\n请 AI 重新表述你的内容，让语言更顺畅\\n\\n请 AI 提供改写建议，如增强逻辑结构或调整表达方式\\n\\n请 AI 协助补充遗漏的功能说明或使用场景\\n\\n请 AI 给出多个不同的润色版本供你选择\\n\\n你的任务：\\n\\n向 AI 输入你希望改进的部分或具体需求\\n\\n查看 AI 的润色建议\\n\\n选择：采纳、修改或拒绝\\n\\n整合为你的最终版本并提交\\n\\n注意事项：\\n\\n你可以进行多轮与 AI 的互动，但最终内容必须由你决定并亲自确认。\\n\\n你可以自由采用部分内容，不需要全部采纳 AI 建议。\\n\\n不需要追求“完美”，只需让你的创意更加清晰、有吸引力。\\n\\n完成后进入下一步。", "copilotWorkflowId": "7578921176311791616", "inputVariableName": "input", "evaluationDimensions": [{"id": "branch-wuzc45k3", "name": "任务完整度", "prompt": "", "evaluator": "human", "scoreScale": 5, "description": "", "llmWorkflowId": ""}, {"id": "branch-xrqtlgrg", "name": "语言生动度", "prompt": "", "evaluator": "human", "scoreScale": 5, "description": "", "llmWorkflowId": ""}]}, "type": "taskNode", "position": {"x": 700.3597711638126, "y": 1517.8856147196338}}, {"id": "node-miefy6li-yhodzep2", "data": {"label": "Full Delegation", "category": "agent", "allowAgent": false, "contextText": "", "workflow_id": "7571793542574505984", "inputVariableName": "input"}, "type": "taskNode", "position": {"x": 900.0596211807028, "y": 1520.4933685141605}}, {"id": "node-mieg28pl-7h70gfds", "data": {"label": "[汇聚] 分支合流", "contextText": "", "inputVariableName": "input"}, "type": "mergeNode", "position": {"x": 651.8993001419616, "y": 1625.9098360441687}}, {"id": "node-mieg2om5-pnfuie7o", "data": {"label": "[结束] 流程终点"}, "type": "endNode", "position": {"x": 655.6536124089486, "y": 1762.3165150780287}}, {"id": "node-miffg7fy-lhjjrx2o", "data": {"label": "任务一选择", "variables": [{"id": "info-hlsddgq7", "key": "任务一选择", "note": "", "label": "参与者将在任务 一 中选择以下三种方式之一来生成初始创意。 三种方式明确对应： 完全自主（No Delegation） / 部分协作（Partial Delegation） / 完全依赖 Agent（Full Delegation） 完全自主撰写（无agent辅助）输入1；部分参考agent意见输入2（人与agent交互）；完全参考agent意见（强制使用agent回答）输入3", "options": [{"label": "1", "value": "1"}, {"label": "2", "value": "2"}, {"label": "3", "value": "3"}], "varType": "string", "required": true, "inputType": "number"}], "contextText": "", "inputVariableName": "input"}, "type": "infoNode", "position": {"x": 149.39500488110144, "y": 455.35645719894137}}, {"id": "node-mifnxbex-0dlxeshj", "data": {"label": "任务二选择", "variables": [{"id": "info-cob47l57", "key": "任务二选择", "note": "", "label": "参与者将在任务 二 中选择以下三种方式之一来润色创意内容。 三种方式明确对应： 完全自主（No Delegation） / 部分协作（Partial Delegation） / 完全依赖 Agent（Full Delegation） 完全自主撰写（无agent辅助）输入1；部分参考agent意见输入2（人与agent交互）；完全参考agent意见（强制使用agent回答）输入3", "options": [{"label": "1", "value": "1"}, {"label": "2", "value": "2"}, {"label": "3", "value": "3"}], "varType": "string", "required": true, "inputType": "number"}], "contextText": "", "inputVariableName": "input"}, "type": "infoNode", "position": {"x": 191.39500488110139, "y": 1171.3564571989414}}]}	4398b7ca-ef2c-4b26-b426-d69340b4c15c	{"dimensions": [], "overallFeedback": {"prompt": "", "enabled": false}}
\.


--
-- Data for Name: profiles; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.profiles (id, email, role, full_name) FROM stdin;
f64611ca-6a4d-42dd-ac81-c2c91b190dd0	yizheng@ds.com	researcher	andy
cb7c8d0f-1838-4fdd-81aa-0348e7781fec	yizheng@x.com	participant	tom
76e8bfd8-4d08-4320-b4f4-dd345d1b94d7	yizheng@y.com	participant	tim
6f18071a-1a54-4d65-9e00-43633e4ae8d5	yizheng@z.com	participant	jim
f6f69b2b-d1f3-4349-8d2b-3fe31aa30bae	yizheng@a.com	participant	Ace
525d29ed-3bcf-41f4-9d81-f3ab5f038122	yizheng@b.com	participant	Bob
ff478eba-be0c-4e5b-af9a-ae5308d5ca3b	yizheng@h.com	researcher	han
4c162250-6d2a-491c-9ea6-5f96332dd929	yingjie@design.com	researcher	yingjie
0399fa1a-4045-425b-b514-dfd8fb44f233	wadezhuhk@gmail.com	researcher	朱伟章Allen
7dd0e9a0-75de-40fd-8998-d387885178d7	yizheng@h1.com	participant	hu1
420f8270-af9a-41ce-87b2-3143037c9237	yizheng@yun.com	researcher	yun
d524f2e6-27d4-4f1b-b171-e96df36ec23e	yizheng@y6.com	researcher	yun
b8b372b5-bd93-48fe-8afa-5a35480330da	test@ds.com	participant	test
dff299c1-c9c2-4035-9f2e-107d46ae3c5e	wanghaipeng@dsdigitalgroup.com	participant	test
4398b7ca-ef2c-4b26-b426-d69340b4c15c	fc13303752056@163.com	researcher	FC
6cdba011-5883-4b7d-89f4-ea9a1bcacc55	wadezhuhk_test_1@gmail.com	participant	wade_test_1
ce008f4b-dfe9-4301-a844-fe7d337dd1c5	wadezhuhk_test_2@gmail.com	participant	wadezhuhk_test_2
5acbb4bd-563e-4a64-a674-edda518cfaf0	wadezhuhk_test_3@gmail.com	participant	wadezhuhk_test_3
d35ed0e7-12b8-4f0d-9d72-e72125816810	wadezhuhk_test_4@gmail.com	participant	wadezhuhk_test_4
f5f0f0a1-0672-4673-ae01-cdd187fcc4cd	wadezhuhk_test_5@gmail.com	participant	wadezhuhk_test_5
c3ed6099-2c74-44c9-bdaf-ba9091766d62	wadezhuhk_test_6@gmail.com	participant	wadezhuhk_test_6
fdb2e0d6-01ca-422a-84bb-ed841c9480e6	2994390156@qq.com	participant	FC
1608ba80-8e25-4424-b7ad-5fecacedf81d	userr1_4940@163.com	researcher	曾思棚
01941460-10a5-4fd1-87f3-8d19625e4f04	userr2_7026@163.com	researcher	lzx
4e14ad80-ed09-4db5-9add-fbba2ce1004b	wadezhuhk3@gmail.com	researcher	Allen Zhu
a50e4c18-7e6f-46a5-b8e5-7d4a4db179bb	userr4_8070@foxmail.com	researcher	袁僮璐
83cf7ae9-fd96-426c-9e26-effd554cc8c9	819028551@qq.com	researcher	Wade Zhu
bcdaa16c-9e2d-41da-8d71-992255b8d8f9	userr8_1111@outlook.com	researcher	孙天澍
fe96e8e5-9e67-4c02-9ff4-1ddcbbc4ee89	userr9_1111@outlook.com	researcher	Frank.Li
1a1b09cb-aa1b-4fb9-a83c-871eb9675be4	userr10_1111@outlook.com	researcher	Gavin.Wang
7867d1c5-9496-485c-bf4e-f5e80b3386d3	userr11_1111@outlook.com	researcher	Wang.Jin
\.


--
-- Data for Name: session_evaluations; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.session_evaluations (evaluation_id, experiment_id, session_id, evaluator_id, scores, overall_feedback, created_at, updated_at, task_scores) FROM stdin;
10	26	87	4398b7ca-ef2c-4b26-b426-d69340b4c15c	[]	\N	2025-11-26 07:46:53.349782+00	2025-12-02 07:51:32.255+00	[{"notes": "", "nodeId": "node-mief26x6-cjvgnuxz", "resultId": 225, "nodeLabel": "Partial Delegation", "resultKey": "225", "dimensionScores": [{"notes": "", "score": 5, "evaluator": "human", "scoreScale": 5, "description": "", "dimensionId": "branch-g90fo97q", "dimensionName": "任务完整度", "llmWorkflowId": ""}, {"notes": "", "score": 3, "evaluator": "human", "scoreScale": 5, "description": "", "dimensionId": "branch-6x8dimpu", "dimensionName": "创意生动度", "llmWorkflowId": ""}]}, {"notes": "", "nodeId": "node-miefy1a6-2yzur9sz", "resultId": 227, "nodeLabel": "Partial Delegation", "resultKey": "227", "dimensionScores": [{"notes": "", "score": 5, "evaluator": "human", "scoreScale": 5, "description": "", "dimensionId": "branch-wuzc45k3", "dimensionName": "任务完整度", "llmWorkflowId": ""}, {"notes": "", "score": 2, "evaluator": "human", "scoreScale": 5, "description": "", "dimensionId": "branch-xrqtlgrg", "dimensionName": "语言生动度", "llmWorkflowId": ""}]}]
19	55	118	0399fa1a-4045-425b-b514-dfd8fb44f233	[]	\N	2025-12-05 11:34:21.090181+00	2025-12-05 11:34:22.007+00	[{"notes": "", "nodeId": "node-mism0r3m-aep1j8ie", "resultId": 235, "nodeLabel": "Human自主创作", "resultKey": "235", "dimensionScores": [{"notes": "提供的创意仅为数字'123'，缺乏任何具体的App描述元素（如名称、功能、目标用户），无法体现新颖性或独特性，与现有的数字健康工具App没有可比性，因为它不是一个完整的创意概念。", "score": 0, "evaluator": "llm", "scoreScale": 5, "description": "这个创意是否新颖、独特，与现有的 App 不同？", "dimensionId": "branch-bq77nr16", "dimensionName": "创意度", "llmWorkflowId": "7572347832489738240"}, {"notes": "", "score": null, "evaluator": "llm", "scoreScale": 5, "description": "这个创意的表达是否清晰、流畅？", "dimensionId": "branch-zmrcmbqj", "dimensionName": "写作质量", "llmWorkflowId": "7572347832489738240"}, {"notes": "", "score": null, "evaluator": "llm", "scoreScale": 5, "description": "如果这款 App 上线，你有多大可能会下载使用？", "dimensionId": "branch-loadlmua", "dimensionName": "购买/使用意愿", "llmWorkflowId": "7572347832489738240"}, {"notes": "", "score": 3, "evaluator": "human", "scoreScale": 5, "description": "你认为这款 App 会受到大众市场的欢迎吗？", "dimensionId": "branch-p92u6138", "dimensionName": "预测流行度", "llmWorkflowId": ""}]}, {"notes": "", "nodeId": "node-miedmup9-b238794i", "resultId": 236, "nodeLabel": "任务二-Idea Refinement", "resultKey": "236", "dimensionScores": [{"notes": "用户提供的创意 '123' 过于抽象和模糊，缺乏具体细节（如App功能、目标用户或创新点），无法充分评估其新颖性、独特性或与现有App的差异。数字序列本身常见且无原创性，在App背景下不体现显著创新，因此创意度较低。", "score": 1, "evaluator": "llm", "scoreScale": 5, "description": "这个创意是否新颖、独特，与现有的 App 不同？", "dimensionId": "branch-zplycd7x", "dimensionName": "创意度", "llmWorkflowId": "7572347832489738240"}, {"notes": "输入内容'所产生的123'缺乏上下文，含义模糊不清，语法结构不完整，数字的加入显得突兀，导致表达既不清晰也不流畅。", "score": 1, "evaluator": "llm", "scoreScale": 5, "description": "这个创意的表达是否清晰、流畅？", "dimensionId": "branch-9rfm4lxj", "dimensionName": "写作质量", "llmWorkflowId": "7572347832489738240"}, {"notes": "", "score": null, "evaluator": "llm", "scoreScale": 5, "description": "如果这款 App 上线，你有多大可能会下载使用？", "dimensionId": "branch-1uwoyz50", "dimensionName": "购买/使用意愿", "llmWorkflowId": "7572347832489738240"}, {"notes": "", "score": null, "evaluator": "llm", "scoreScale": 5, "description": "你认为这款 App 会受到大众市场的欢迎吗？", "dimensionId": "branch-1wgjeuf1", "dimensionName": "预测流行度", "llmWorkflowId": "7572347832489738240"}]}]
20	62	128	83cf7ae9-fd96-426c-9e26-effd554cc8c9	[]	\N	2025-12-06 15:22:31.067169+00	2025-12-06 15:22:31.052+00	[{"notes": "", "nodeId": "node-miua79hc-bpp0qxmy", "resultId": 248, "nodeLabel": "Task 1: Idea Generation", "resultKey": "248", "dimensionScores": [{"notes": "该创意将健康习惯转化为拼图游戏化元素，结合视觉成就感和社交互动，具有一定的新颖性，为健康追踪领域添加了独特激励方式。然而，核心概念与现有App（如Habitica的游戏化习惯追踪或Forest的视觉奖励机制）相似度高，创新程度不足，缺乏突破性差异。因此，扣1分，给予4分。", "score": 4, "evaluator": "llm", "scoreScale": 5, "description": "这个创意是否新颖、独特，与现有的 App 不同？", "dimensionId": "branch-6vn4ute5", "dimensionName": "创意度", "llmWorkflowId": "7572347832489738240"}, {"notes": "表达清晰流畅：App名称简洁明了，核心功能描述逻辑连贯，详细解释了机制和益处，目标用户定义明确；语言通顺，无语法错误或模糊之处，扣分点为0。", "score": 5, "evaluator": "llm", "scoreScale": 5, "description": "这个创意的表达是否清晰、流畅？", "dimensionId": "branch-2ghzuct0", "dimensionName": "写作质量", "llmWorkflowId": "7572347832489738240"}, {"notes": "该App创意名称'健康拼图'具有吸引力，核心功能通过游戏化（拼图块和完成图片）和社交激励（好友挑战与分享）有效解决健康习惯坚持问题，目标用户定位明确（年轻上班族和学生），增加了下载意愿。但扣分点在于：市场上已有类似游戏化健康App（如Habitica），创意虽新颖但不够独特，可能导致实际下载意愿降低；此外，依赖用户自律和社交互动，如果实施效果不佳或缺乏持续更新，可能影响长期使用吸引力。", "score": 4, "evaluator": "llm", "scoreScale": 5, "description": "如果这款 App 上线，你有多大可能会下载使用？", "dimensionId": "branch-tu3gq577", "dimensionName": "购买/使用意愿", "llmWorkflowId": "7572347832489738240"}, {"notes": "", "score": null, "evaluator": "llm", "scoreScale": 5, "description": "你认为这款 App 会受到大众市场的欢迎吗？", "dimensionId": "branch-jh97eq6l", "dimensionName": "预测流行度", "llmWorkflowId": "7572347832489738240"}]}, {"notes": "", "nodeId": "node-miua7q2o-qi2ahlek", "resultId": 249, "nodeLabel": "Task 2: Idea Refinement", "resultKey": "249", "dimensionScores": [{"notes": "该创意在游戏化健康习惯追踪方面有一定新颖性，特别是通过拼图机制提供视觉激励和成就感的独特设计，这在现有主流App（如Habitica的RPG元素）中不常见；然而，核心框架（将习惯转化为任务奖励、预设模板降低门槛）与现有App相似，社交功能（互助加速卡、分享邀请码）虽优化了用户体验但缺乏颠覆性创新，因此扣分。", "score": 3.5, "evaluator": "llm", "scoreScale": 5, "description": "这个创意是否新颖、独特，与现有的 App 不同？", "dimensionId": "branch-1vyhgera", "dimensionName": "创意度", "llmWorkflowId": "7572347832489738240"}, {"notes": "扣分理由：核心价值点部分完全缺失，导致创意表达不完整，影响整体清晰度；核心功能描述清晰流畅，但部分表述如嵌入邀请码的拉新转化率数字稍显突兀。", "score": 4, "evaluator": "llm", "scoreScale": 5, "description": "这个创意的表达是否清晰、流畅？", "dimensionId": "branch-vl6whmfe", "dimensionName": "写作质量", "llmWorkflowId": "7572347832489738240"}, {"notes": "", "score": null, "evaluator": "llm", "scoreScale": 5, "description": "如果这款 App 上线，你有多大可能会下载使用？", "dimensionId": "branch-lcy50q4o", "dimensionName": "购买/使用意愿", "llmWorkflowId": "7572347832489738240"}, {"notes": "", "score": null, "evaluator": "llm", "scoreScale": 5, "description": "你认为这款 App 会受到大众市场的欢迎吗？", "dimensionId": "branch-7g2vmyk9", "dimensionName": "预测流行度", "llmWorkflowId": "7572347832489738240"}]}]
\.


--
-- Data for Name: task_results; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.task_results (result_id, session_id, node_id, output_data, created_at, input_data) FROM stdin;
145	33	node-15de56ef-ac53-492d-97dc-b886c62c6f95	{"output": "以吸引忙碌的研发人员参与"}	2025-11-17 07:59:13.387391+00	{"label": "[Human] 研发任务任务", "instruction": "- 活动主题： AI加速新药发现\\n- 活动目标： 介绍AI在靶点发现、化合物筛选等领域的最新应用，激发研发人员的创新思路。\\n- 活动时长： 约1.5小时\\n- 主要挑战： 如何将高度专业、前沿的技术内容，包装得不那么枯燥，并清晰地传达出对日常研发工作的实际价值，以吸引忙碌的研发人员参与", "workflow_id": null, "context_text": "", "previous_output": {"__info": {"map": {"department": "研发"}, "variables": [{"id": "f2624b42-934c-499d-a363-aafa3201e7a5", "key": "department", "note": "", "value": "研发", "varType": "string"}]}, "department": "研发"}, "input_variable_name": "input", "context_document_url": null}
146	33	dndnode_9	{"output": "Workflow execution failure: [NodeRunError] failed to create chat completion: Error code: 429 - {\\"code\\":\\"SetLimitExceeded\\",\\"message\\":\\"Your account [2106575053] has reached the set inference limit for the [doubao-seed-1-6-lite] model, and the model service has been paused. To continue using this model, please visit the Model Activation page to adjust or close the \\\\\\"Safe Experience Mode\\\\\\". Request id: 02176336635556896936cd63af93b252982f20e894c791433d8b2\\",\\"param\\":\\"\\",\\"type\\":\\"TooManyRequests\\",\\"request_id\\":\\"202511170759150000EED0883F793F7F7C\\"}\\n------------------------\\nnode path: [129019, llm]"}	2025-11-17 07:59:17.767983+00	{"label": "[Agent] 活动形式构思", "instruction": null, "workflow_id": "7572087336784101376", "context_text": "", "previous_output": "以吸引忙碌的研发人员参与", "input_variable_name": "topic", "context_document_url": null}
147	33	dndnode_10	{"output": "Workflow execution failure: [NodeRunError] failed to create chat completion: Error code: 429 - {\\"code\\":\\"SetLimitExceeded\\",\\"message\\":\\"Your account [2106575053] has reached the set inference limit for the [doubao-seed-1-6-lite] model, and the model service has been paused. To continue using this model, please visit the Model Activation page to adjust or close the \\\\\\"Safe Experience Mode\\\\\\". Request id: 02176336635925396936cd63af93b252982f20e894c791448ce2f\\",\\"param\\":\\"\\",\\"type\\":\\"TooManyRequests\\",\\"request_id\\":\\"202511170759190000F678DE6BB860D0D4\\"}\\n------------------------\\nnode path: [128966, llm]"}	2025-11-17 07:59:21.436085+00	{"label": "[Agent] 宣传文字写作", "instruction": null, "workflow_id": "7572092413632577536", "context_text": "", "previous_output": "Workflow execution failure: [NodeRunError] failed to create chat completion: Error code: 429 - {\\"code\\":\\"SetLimitExceeded\\",\\"message\\":\\"Your account [2106575053] has reached the set inference limit for the [doubao-seed-1-6-lite] model, and the model service has been paused. To continue using this model, please visit the Model Activation page to adjust or close the \\\\\\"Safe Experience Mode\\\\\\". Request id: 02176336635556896936cd63af93b252982f20e894c791433d8b2\\",\\"param\\":\\"\\",\\"type\\":\\"TooManyRequests\\",\\"request_id\\":\\"202511170759150000EED0883F793F7F7C\\"}\\n------------------------\\nnode path: [129019, llm]", "input_variable_name": "goal_or_topic", "context_document_url": null}
148	33	dndnode_10	{"output": "Workflow execution failure: [NodeRunError] failed to create chat completion: Error code: 429 - {\\"code\\":\\"SetLimitExceeded\\",\\"message\\":\\"Your account [2106575053] has reached the set inference limit for the [doubao-seed-1-6-lite] model, and the model service has been paused. To continue using this model, please visit the Model Activation page to adjust or close the \\\\\\"Safe Experience Mode\\\\\\". Request id: 021763366644701b2646f74b3c295a51c79d8c7886b724ab1397d\\",\\"param\\":\\"\\",\\"type\\":\\"TooManyRequests\\",\\"request_id\\":\\"202511170804040000CD1520C6715FEA9F\\"}\\n------------------------\\nnode path: [128966, llm]"}	2025-11-17 08:04:11.693979+00	{"label": "[Agent] 宣传文字写作", "instruction": null, "workflow_id": "7572092413632577536", "context_text": "", "previous_output": "Workflow execution failure: [NodeRunError] failed to create chat completion: Error code: 429 - {\\"code\\":\\"SetLimitExceeded\\",\\"message\\":\\"Your account [2106575053] has reached the set inference limit for the [doubao-seed-1-6-lite] model, and the model service has been paused. To continue using this model, please visit the Model Activation page to adjust or close the \\\\\\"Safe Experience Mode\\\\\\". Request id: 02176336635925396936cd63af93b252982f20e894c791448ce2f\\",\\"param\\":\\"\\",\\"type\\":\\"TooManyRequests\\",\\"request_id\\":\\"202511170759190000F678DE6BB860D0D4\\"}\\n------------------------\\nnode path: [128966, llm]", "input_variable_name": "goal_or_topic", "context_document_url": null}
149	33	node-b8cfb4c6-f9da-4581-b87a-f9f4355cb725	{"output": "Workflow execution failure: [NodeRunError] failed to create chat completion: Error code: 429 - {\\"code\\":\\"SetLimitExceeded\\",\\"message\\":\\"Your account [2106575053] has reached the set inference limit for the [doubao-seed-1-6-lite] model, and the model service has been paused. To continue using this model, please visit the Model Activation page to adjust or close the \\\\\\"Safe Experience Mode\\\\\\". Request id: 021763366653216b2646f74b3c295a51c79d8c7886b724a7d0281\\",\\"param\\":\\"\\",\\"type\\":\\"TooManyRequests\\",\\"request_id\\":\\"202511170804130000263118D7D7241306\\"}\\n------------------------\\nnode path: [106354, llm]"}	2025-11-17 08:04:15.834227+00	{"label": "[Agent] 安全检查", "instruction": null, "workflow_id": "7572114723546595328", "context_text": "", "previous_output": "Workflow execution failure: [NodeRunError] failed to create chat completion: Error code: 429 - {\\"code\\":\\"SetLimitExceeded\\",\\"message\\":\\"Your account [2106575053] has reached the set inference limit for the [doubao-seed-1-6-lite] model, and the model service has been paused. To continue using this model, please visit the Model Activation page to adjust or close the \\\\\\"Safe Experience Mode\\\\\\". Request id: 021763366644701b2646f74b3c295a51c79d8c7886b724ab1397d\\",\\"param\\":\\"\\",\\"type\\":\\"TooManyRequests\\",\\"request_id\\":\\"202511170804040000CD1520C6715FEA9F\\"}\\n------------------------\\nnode path: [128966, llm]", "input_variable_name": "input", "context_document_url": null}
143	33	dndnode_1	{"output": {"acknowledged": true, "startObjective": " 公司已经为您所在的部门设定了活动目标和时长。您的任务是与AI协作，构思一个具体的活动形式，并为这场活动撰写一份生动、有趣的活动宣传文案，以吸引部门同事积极参与。", "startBackground": " 为推动AI战略落地，公司将针对不同职能部门，举办一系列“AI赋能”主题的内部文化活动。", "startDeliverables": "请用一段话（50-80字）描述最终的活动形式；\\n请列举出您认为最核心的两个顾虑点、两个兴趣点\\n"}}	2025-11-17 07:58:58.33758+00	{"label": "[启动] 活动宣传文案撰写", "instruction": null, "workflow_id": null, "context_text": "", "previous_output": null, "input_variable_name": "input", "context_document_url": null}
144	33	node-9a149b44-63fa-42f0-a0cc-b3a7ac04ec60	{"output": {"__info": {"map": {"department": "研发"}, "variables": [{"id": "f2624b42-934c-499d-a363-aafa3201e7a5", "key": "department", "note": "", "value": "研发", "varType": "string"}]}, "department": "研发"}}	2025-11-17 07:59:02.834451+00	{"label": "[Human] 员工信息输入", "info_map": {"department": "研发"}, "instruction": null, "workflow_id": null, "context_text": "", "info_variables": [{"id": "f2624b42-934c-499d-a363-aafa3201e7a5", "key": "department", "note": "", "value": "研发", "varType": "string"}], "previous_output": {"acknowledged": true, "startObjective": " 公司已经为您所在的部门设定了活动目标和时长。您的任务是与AI协作，构思一个具体的活动形式，并为这场活动撰写一份生动、有趣的活动宣传文案，以吸引部门同事积极参与。", "startBackground": " 为推动AI战略落地，公司将针对不同职能部门，举办一系列“AI赋能”主题的内部文化活动。", "startDeliverables": "请用一段话（50-80字）描述最终的活动形式；\\n请列举出您认为最核心的两个顾虑点、两个兴趣点\\n"}, "input_variable_name": "input", "context_document_url": null}
207	108	dndnode_0	{"output": "hi"}	2025-11-28 09:24:29.035087+00	{"label": "[Human] 解释物理名词", "instruction": "100字解释相对论", "workflow_id": null, "context_text": "爱因斯坦的相对论分为狭义和广义。狭义相对论 (1905) 核心是两大公设：光速恒定不变，以及物理定律在所有惯性系中相同。这导出了时间膨胀、长度收缩和著名的质能方程 $E=mc^2$。广义相对论 (1915) 是引力理论，它将引力描述为物质和能量造成的时空弯曲。它成功预测了黑洞、引力透镜和宇宙的膨胀。", "previous_output": {"acknowledged": true, "startObjective": "", "startBackground": "", "startDeliverables": ""}, "input_variable_name": "input", "context_document_url": null}
208	108	dndnode_1	{"output": "{\\"content_type\\":1,\\"data\\":\\"Hello! How can I help you today? 😊\\",\\"type_for_model\\":2}"}	2025-11-28 09:24:40.07198+00	{"label": "[Agent] AI加工", "instruction": null, "workflow_id": "7571793542574505984", "context_text": "", "previous_output": "hi", "input_variable_name": "input", "context_document_url": null}
209	108	dndnode_2	{"output": "hi"}	2025-11-28 09:24:48.296123+00	{"label": "[Human] 总结提炼", "instruction": "提炼上下文的输出", "workflow_id": null, "context_text": "", "previous_output": "{\\"content_type\\":1,\\"data\\":\\"Hello! How can I help you today? 😊\\",\\"type_for_model\\":2}", "input_variable_name": "input", "context_document_url": null}
206	108	node-miinkr3d-7miw0xd9	{"output": {"acknowledged": true, "startObjective": "", "startBackground": "", "startDeliverables": ""}}	2025-11-28 09:24:21.866342+00	{"label": "[启动] 实验简介", "instruction": null, "workflow_id": null, "context_text": null, "previous_output": null, "input_variable_name": null, "context_document_url": null}
222	87	node-mie1mtqg-hn6gdbfb	{"output": {"acknowledged": true, "startObjective": "你需要在两个阶段内完成一个具备可读性、结构清晰、内容合理，且具有创新性和吸引力的 App 创意。\\n\\n你的核心目标包括：\\n\\n阶段 1（初始创意生成）\\n选择生成方式 → 产出一个原创应用创意草稿。\\n\\n阶段 2（创意润色）\\n再次选择协作方式 → 对创意进行语言和结构层面的提升，形成最终稿。\\n\\n最终，你将输出一个 完整的健康类 App 创意文案，作为本实验的主要结果。\\n\\nps:委派方式说明（阶段 1 与阶段 2 均需选择）\\n\\n在每个阶段，你都可以从三种方式中选择如何与 AI（或不用 AI）完成任务。下面是三种方式的详细说明，确保你完全理解它们之间的差异：\\n\\n1. 自己完成（No Delegation）\\n你完全独立完成创意生成或润色；不会使用任何 AI 生成的内容或建议；你需要自行构思、组织思路，并输入最终内容。\\n适用于你希望最大程度自主发挥创造力的情况。\\n\\n2. 与 AI 协作完成（Partial Delegation）\\n\\n你和 AI共同完成任务；通常的协作流程包括：\\n你先提供初始方向或需求;AI 提供建议、补充内容或替代方案；你拥有最终决定权，可以选择采纳、编辑或拒绝 AI 的建议。\\n适用于你希望保持主导权，但希望 AI 协助拓展想法或改善表达的情况。\\n\\n3. 完全让 AI 完成（Full Delegation）\\n\\n你将任务完全交给 AI；AI 会自动生成创意内容或自动完成润色；你只需要查看并确认 AI 生成的结果。\\n适用于你希望依赖 AI 的执行能力，而不投入较多创意或编辑精力的情况。", "startBackground": "本实验旨在研究人类在创意任务中如何与 AI（如内容生成模型）进行协作。\\n你将扮演一名受邀参与创新开发流程的“创意产出者”，任务是为一家虚构的数字健康科技公司 BloomTech 设计一款帮助用户改善健康生活方式的手机应用。\\n\\n为了模拟真实情境，你将在 两个阶段 中逐步完成创意的“生成”与“润色”，并根据自己的判断决定是否以及在何种程度上使用 AI 辅助完成任务。\\n\\n在正式开始任务前，你还会看到一段关于 AI 在创意任务中典型表现的简要介绍，这将帮助你更好地理解 AI 的能力和局限，从而做出更合理的协作选择。", "startDeliverables": "最终版 App 创意文案\\n包含应用的核心概念、用户价值、主要功能和潜在吸引力等内容；\\n\\n该文案可以完全由你撰写、由你和 AI 协同生成，或由 AI 完全生成（取决于你在两个阶段的选择）"}}	2025-12-02 06:35:18.137046+00	{"label": "实验简介", "instruction": null, "workflow_id": null, "context_text": null, "previous_output": null, "input_variable_name": "input", "context_document_url": null}
223	87	node-mie2dqh7-5c5oopxa	{"output": {"__info": {"map": {"学历": "", "年龄": "", "性别": "", "职业": ""}, "variables": [{"id": "info-xb2v7hw1", "key": "性别", "note": "", "label": "性别", "value": "", "options": [{"label": "男", "value": "男"}, {"label": "女", "value": "女"}], "varType": "string", "required": false, "inputType": "radio"}, {"id": "info-jyeu3e0x", "key": "年龄", "note": "", "label": "年龄", "value": "", "options": [], "varType": "string", "required": false, "inputType": "number"}, {"id": "info-ub5e6tut", "key": "学历", "note": "", "label": "最高学历", "value": "", "options": [{"label": "中学及以下", "value": "中学及以下"}, {"label": "大专", "value": "大专"}, {"label": "本科", "value": "本科"}, {"label": "研究生", "value": "研究生"}, {"label": "博士", "value": "博士"}], "varType": "string", "required": false, "inputType": "radio"}, {"id": "info-0b0yjq8n", "key": "职业", "note": "", "label": "职业", "value": "", "options": [], "varType": "string", "required": false, "inputType": "text"}]}, "学历": "", "年龄": "", "性别": "", "职业": ""}}	2025-12-02 06:35:19.525566+00	{"label": "个人信息采集", "info_map": {"学历": "", "年龄": "", "性别": "", "职业": ""}, "instruction": null, "workflow_id": null, "context_text": "", "info_variables": [{"id": "info-xb2v7hw1", "key": "性别", "note": "", "label": "性别", "value": "", "options": [{"label": "男", "value": "男"}, {"label": "女", "value": "女"}], "varType": "string", "required": false, "inputType": "radio"}, {"id": "info-jyeu3e0x", "key": "年龄", "note": "", "label": "年龄", "value": "", "options": [], "varType": "string", "required": false, "inputType": "number"}, {"id": "info-ub5e6tut", "key": "学历", "note": "", "label": "最高学历", "value": "", "options": [{"label": "中学及以下", "value": "中学及以下"}, {"label": "大专", "value": "大专"}, {"label": "本科", "value": "本科"}, {"label": "研究生", "value": "研究生"}, {"label": "博士", "value": "博士"}], "varType": "string", "required": false, "inputType": "radio"}, {"id": "info-0b0yjq8n", "key": "职业", "note": "", "label": "职业", "value": "", "options": [], "varType": "string", "required": false, "inputType": "text"}], "previous_output": {"acknowledged": true, "startObjective": "你需要在两个阶段内完成一个具备可读性、结构清晰、内容合理，且具有创新性和吸引力的 App 创意。\\n\\n你的核心目标包括：\\n\\n阶段 1（初始创意生成）\\n选择生成方式 → 产出一个原创应用创意草稿。\\n\\n阶段 2（创意润色）\\n再次选择协作方式 → 对创意进行语言和结构层面的提升，形成最终稿。\\n\\n最终，你将输出一个 完整的健康类 App 创意文案，作为本实验的主要结果。\\n\\nps:委派方式说明（阶段 1 与阶段 2 均需选择）\\n\\n在每个阶段，你都可以从三种方式中选择如何与 AI（或不用 AI）完成任务。下面是三种方式的详细说明，确保你完全理解它们之间的差异：\\n\\n1. 自己完成（No Delegation）\\n你完全独立完成创意生成或润色；不会使用任何 AI 生成的内容或建议；你需要自行构思、组织思路，并输入最终内容。\\n适用于你希望最大程度自主发挥创造力的情况。\\n\\n2. 与 AI 协作完成（Partial Delegation）\\n\\n你和 AI共同完成任务；通常的协作流程包括：\\n你先提供初始方向或需求;AI 提供建议、补充内容或替代方案；你拥有最终决定权，可以选择采纳、编辑或拒绝 AI 的建议。\\n适用于你希望保持主导权，但希望 AI 协助拓展想法或改善表达的情况。\\n\\n3. 完全让 AI 完成（Full Delegation）\\n\\n你将任务完全交给 AI；AI 会自动生成创意内容或自动完成润色；你只需要查看并确认 AI 生成的结果。\\n适用于你希望依赖 AI 的执行能力，而不投入较多创意或编辑精力的情况。", "startBackground": "本实验旨在研究人类在创意任务中如何与 AI（如内容生成模型）进行协作。\\n你将扮演一名受邀参与创新开发流程的“创意产出者”，任务是为一家虚构的数字健康科技公司 BloomTech 设计一款帮助用户改善健康生活方式的手机应用。\\n\\n为了模拟真实情境，你将在 两个阶段 中逐步完成创意的“生成”与“润色”，并根据自己的判断决定是否以及在何种程度上使用 AI 辅助完成任务。\\n\\n在正式开始任务前，你还会看到一段关于 AI 在创意任务中典型表现的简要介绍，这将帮助你更好地理解 AI 的能力和局限，从而做出更合理的协作选择。", "startDeliverables": "最终版 App 创意文案\\n包含应用的核心概念、用户价值、主要功能和潜在吸引力等内容；\\n\\n该文案可以完全由你撰写、由你和 AI 协同生成，或由 AI 完全生成（取决于你在两个阶段的选择）"}, "input_variable_name": "input", "context_document_url": null}
224	87	node-miffg7fy-lhjjrx2o	{"output": {"__info": {"map": {"任务一选择": "2"}, "variables": [{"id": "info-hlsddgq7", "key": "任务一选择", "note": "", "label": "参与者将在任务 一 中选择以下三种方式之一来生成初始创意。 三种方式明确对应： 完全自主（No Delegation） / 部分协作（Partial Delegation） / 完全依赖 Agent（Full Delegation） 完全自主撰写（无agent辅助）输入1；部分参考agent意见输入2（人与agent交互）；完全参考agent意见（强制使用agent回答）输入3", "value": "2", "options": [{"label": "1", "value": "1"}, {"label": "2", "value": "2"}, {"label": "3", "value": "3"}], "varType": "string", "required": true, "inputType": "number"}]}, "任务一选择": "2"}}	2025-12-02 06:35:24.493881+00	{"label": "任务一选择", "info_map": {"任务一选择": "2"}, "instruction": null, "workflow_id": null, "context_text": "", "info_variables": [{"id": "info-hlsddgq7", "key": "任务一选择", "note": "", "label": "参与者将在任务 一 中选择以下三种方式之一来生成初始创意。 三种方式明确对应： 完全自主（No Delegation） / 部分协作（Partial Delegation） / 完全依赖 Agent（Full Delegation） 完全自主撰写（无agent辅助）输入1；部分参考agent意见输入2（人与agent交互）；完全参考agent意见（强制使用agent回答）输入3", "value": "2", "options": [{"label": "1", "value": "1"}, {"label": "2", "value": "2"}, {"label": "3", "value": "3"}], "varType": "string", "required": true, "inputType": "number"}], "previous_output": {"__info": {"map": {"学历": "", "年龄": "", "性别": "", "职业": ""}, "variables": [{"id": "info-xb2v7hw1", "key": "性别", "note": "", "label": "性别", "value": "", "options": [{"label": "男", "value": "男"}, {"label": "女", "value": "女"}], "varType": "string", "required": false, "inputType": "radio"}, {"id": "info-jyeu3e0x", "key": "年龄", "note": "", "label": "年龄", "value": "", "options": [], "varType": "string", "required": false, "inputType": "number"}, {"id": "info-ub5e6tut", "key": "学历", "note": "", "label": "最高学历", "value": "", "options": [{"label": "中学及以下", "value": "中学及以下"}, {"label": "大专", "value": "大专"}, {"label": "本科", "value": "本科"}, {"label": "研究生", "value": "研究生"}, {"label": "博士", "value": "博士"}], "varType": "string", "required": false, "inputType": "radio"}, {"id": "info-0b0yjq8n", "key": "职业", "note": "", "label": "职业", "value": "", "options": [], "varType": "string", "required": false, "inputType": "text"}]}, "学历": "", "年龄": "", "性别": "", "职业": ""}, "input_variable_name": "input", "context_document_url": null}
225	87	node-mief26x6-cjvgnuxz	{"output": "神经反馈冥想训练：利用脑电图原理实时监测用户脑波，提供个性化冥想反馈，增强专注力。"}	2025-12-02 07:06:35.15687+00	{"label": "Partial Delegation", "instruction": "在本阶段，你将 与 AI（如文本生成模型）共同生成 一个健康类 App 的初步创意。\\n你依然是创意的主要决策者，而 AI 的角色是提供辅助、建议或补充内容。\\n\\n你的任务流程：\\n\\n由你先给出一个初步方向\\n示例：应用目标、想要解决的问题、目标用户等。\\n\\nAI 将根据你的输入给出扩展建议或草稿内容\\n例如功能补充、使用场景、命名建议等。\\n\\n你可以决定如何处理 AI 的输出：\\n\\n采纳\\n\\n修改\\n\\n组合\\n\\n或全部重新编写\\n\\n最终提交的内容仍由你决定。\\n\\n注意事项：\\n\\n你必须至少向 AI 提供一段方向性输入（如创意描述、需求或偏好）。\\n\\nAI 在本阶段只提供建议，你始终保持 最终创意主导权。\\n\\n你可以多轮与 AI 互动，直到形成一个你满意的初步创意。\\n\\n完成后提交你最终的版本。", "workflow_id": null, "context_text": "", "previous_output": {"__info": {"map": {"任务一选择": "2"}, "variables": [{"id": "info-hlsddgq7", "key": "任务一选择", "note": "", "label": "参与者将在任务 一 中选择以下三种方式之一来生成初始创意。 三种方式明确对应： 完全自主（No Delegation） / 部分协作（Partial Delegation） / 完全依赖 Agent（Full Delegation） 完全自主撰写（无agent辅助）输入1；部分参考agent意见输入2（人与agent交互）；完全参考agent意见（强制使用agent回答）输入3", "value": "2", "options": [{"label": "1", "value": "1"}, {"label": "2", "value": "2"}, {"label": "3", "value": "3"}], "varType": "string", "required": true, "inputType": "number"}]}, "任务一选择": "2"}, "input_variable_name": "input", "context_document_url": null}
226	87	node-mifnxbex-0dlxeshj	{"output": {"__info": {"map": {"任务二选择": "2"}, "variables": [{"id": "info-cob47l57", "key": "任务二选择", "note": "", "label": "参与者将在任务 二 中选择以下三种方式之一来润色创意内容。 三种方式明确对应： 完全自主（No Delegation） / 部分协作（Partial Delegation） / 完全依赖 Agent（Full Delegation） 完全自主撰写（无agent辅助）输入1；部分参考agent意见输入2（人与agent交互）；完全参考agent意见（强制使用agent回答）输入3", "value": "2", "options": [{"label": "1", "value": "1"}, {"label": "2", "value": "2"}, {"label": "3", "value": "3"}], "varType": "string", "required": true, "inputType": "number"}]}, "任务二选择": "2"}}	2025-12-02 07:06:49.626153+00	{"label": "任务二选择", "info_map": {"任务二选择": "2"}, "instruction": null, "workflow_id": null, "context_text": "", "info_variables": [{"id": "info-cob47l57", "key": "任务二选择", "note": "", "label": "参与者将在任务 二 中选择以下三种方式之一来润色创意内容。 三种方式明确对应： 完全自主（No Delegation） / 部分协作（Partial Delegation） / 完全依赖 Agent（Full Delegation） 完全自主撰写（无agent辅助）输入1；部分参考agent意见输入2（人与agent交互）；完全参考agent意见（强制使用agent回答）输入3", "value": "2", "options": [{"label": "1", "value": "1"}, {"label": "2", "value": "2"}, {"label": "3", "value": "3"}], "varType": "string", "required": true, "inputType": "number"}], "previous_output": "神经反馈冥想训练：利用脑电图原理实时监测用户脑波，提供个性化冥想反馈，增强专注力。", "input_variable_name": "input", "context_document_url": null}
227	87	node-miefy1a6-2yzur9sz	{"output": "神经反馈冥想训练：通过脑电图技术实时监测用户脑波活动，基于数据分析动态生成个性化反馈（如音频或视觉提示），引导用户优化冥想状态，增强专注力与减压效果，适用于日常压力管理和专注力提升场景。"}	2025-12-02 07:09:21.954927+00	{"label": "Partial Delegation", "instruction": "在本阶段，你将 与 AI 协作 完成对初始创意的润色与提升。\\n你依然保持最终决定权，而 AI 将提供辅助性建议。\\n\\n你可以从以下角度向 AI 发起请求（可任选，不限）：\\n\\n请 AI 重新表述你的内容，让语言更顺畅\\n\\n请 AI 提供改写建议，如增强逻辑结构或调整表达方式\\n\\n请 AI 协助补充遗漏的功能说明或使用场景\\n\\n请 AI 给出多个不同的润色版本供你选择\\n\\n你的任务：\\n\\n向 AI 输入你希望改进的部分或具体需求\\n\\n查看 AI 的润色建议\\n\\n选择：采纳、修改或拒绝\\n\\n整合为你的最终版本并提交\\n\\n注意事项：\\n\\n你可以进行多轮与 AI 的互动，但最终内容必须由你决定并亲自确认。\\n\\n你可以自由采用部分内容，不需要全部采纳 AI 建议。\\n\\n不需要追求“完美”，只需让你的创意更加清晰、有吸引力。\\n\\n完成后进入下一步。", "workflow_id": null, "context_text": "", "previous_output": {"__info": {"map": {"任务二选择": "2"}, "variables": [{"id": "info-cob47l57", "key": "任务二选择", "note": "", "label": "参与者将在任务 二 中选择以下三种方式之一来润色创意内容。 三种方式明确对应： 完全自主（No Delegation） / 部分协作（Partial Delegation） / 完全依赖 Agent（Full Delegation） 完全自主撰写（无agent辅助）输入1；部分参考agent意见输入2（人与agent交互）；完全参考agent意见（强制使用agent回答）输入3", "value": "2", "options": [{"label": "1", "value": "1"}, {"label": "2", "value": "2"}, {"label": "3", "value": "3"}], "varType": "string", "required": true, "inputType": "number"}]}, "任务二选择": "2"}, "input_variable_name": "input", "context_document_url": null}
233	118	node-mi795m91-xkrbgdj2	{"output": {"acknowledged": true, "startObjective": "提出一个创新的APP创意，该 App 旨在促进更健康的生活方式", "startBackground": "想象你正在为一家名为\\"博伦科技\\"的公司工作。该公司正在寻求创新的 App 概念，以响应消费者对数字健康工具日益增长的需求，帮助用户过上更健康的生活。", "startDeliverables": "APP产品创意文案"}}	2025-12-05 11:27:54.827503+00	{"label": "[启动] 实验简介", "instruction": null, "workflow_id": null, "context_text": null, "previous_output": null, "input_variable_name": "input", "context_document_url": null}
234	118	node-mism0r3m-xgh488jc	{"output": {"__info": {"map": {"user_decision": "不委托"}, "variables": [{"id": "info-za5orgmd", "key": "user_decision", "note": "", "label": "请您选择，是否把Idea的构思任务委托给AI完成？", "value": "不委托", "options": [{"label": "委托", "value": "委托"}, {"label": "不委托", "value": "不委托"}], "varType": "string", "required": true, "inputType": "radio"}]}, "user_decision": "不委托"}}	2025-12-05 11:27:57.235261+00	{"label": "[Human] 信息输入", "info_map": {"user_decision": "不委托"}, "instruction": null, "workflow_id": null, "context_text": "", "info_variables": [{"id": "info-za5orgmd", "key": "user_decision", "note": "", "label": "请您选择，是否把Idea的构思任务委托给AI完成？", "value": "不委托", "options": [{"label": "委托", "value": "委托"}, {"label": "不委托", "value": "不委托"}], "varType": "string", "required": true, "inputType": "radio"}], "previous_output": {"acknowledged": true, "startObjective": "提出一个创新的APP创意，该 App 旨在促进更健康的生活方式", "startBackground": "想象你正在为一家名为\\"博伦科技\\"的公司工作。该公司正在寻求创新的 App 概念，以响应消费者对数字健康工具日益增长的需求，帮助用户过上更健康的生活。", "startDeliverables": "APP产品创意文案"}, "input_variable_name": "input", "context_document_url": null}
235	118	node-mism0r3m-aep1j8ie	{"output": "123"}	2025-12-05 11:27:59.911719+00	{"label": "Human自主创作", "instruction": "1. 背景：想象你正在为一家名为\\"博伦科技\\"的公司工作。该公司正在寻求创新的 App 概念，以响应消费者对数字健康工具日益增长的需求，帮助用户过上更健康的生活。\\n\\n2. 任务要求：\\n请在下方文本框中详细描述您的 App 初始创意。\\n您必须完全依靠自己来构思和撰写，请勿使用任何 AI 工具。\\n\\n为了让您的创意更具说服力，建议您的描述包含以下内容（仅供参考）：\\n - App 名称：给它起一个响亮的名字。\\n - 核心功能：它能做什么？解决了什么问题？\\n - 目标用户：谁会使用它？", "workflow_id": null, "context_text": "", "previous_output": {"__info": {"map": {"user_decision": "不委托"}, "variables": [{"id": "info-za5orgmd", "key": "user_decision", "note": "", "label": "请您选择，是否把Idea的构思任务委托给AI完成？", "value": "不委托", "options": [{"label": "委托", "value": "委托"}, {"label": "不委托", "value": "不委托"}], "varType": "string", "required": true, "inputType": "radio"}]}, "user_decision": "不委托"}, "input_variable_name": "input", "context_document_url": null}
236	118	node-miedmup9-b238794i	{"output": "123"}	2025-12-05 11:28:03.535155+00	{"label": "任务二-Idea Refinement", "instruction": "现在你已经有了一个初始创意。在这个阶段，你将与一位 AI 助手合作，对这个创意进行打磨、润色和改进。\\n\\n你可以通过右侧的聊天界面与 AI 自由互动。当你对结果满意时，请提交最终版本的创意。", "workflow_id": null, "context_text": "", "previous_output": "123", "input_variable_name": "input", "context_document_url": null}
237	118	node-mi7973bg-8w6fj9fm	{"output": {"__info": {"map": {"writing_skill": "4", "familiarity_GPT": "有时使用（每周几次）", "domain_knowledge": "3", "self_perceived_creativity": "5"}, "variables": [{"id": "info-xl40jnto", "key": "self_perceived_creativity", "note": "", "label": "请您评价自己是一个富有创造力的人的程度", "value": "5", "options": [], "varType": "string", "required": true, "inputType": "rating"}, {"id": "info-jqhua8w7", "key": "familiarity_GPT", "note": "", "label": "在日常生活中，您使用 ChatGPT 的频率是？", "value": "有时使用（每周几次）", "options": [{"label": "从不使用", "value": "从不使用"}, {"label": "很少使用（每月几次）", "value": "很少使用（每月几次）"}, {"label": "有时使用（每周几次）", "value": "有时使用（每周几次）"}, {"label": "经常使用（几乎每天）", "value": "经常使用（几乎每天）"}], "varType": "string", "required": true, "inputType": "radio"}, {"id": "info-h3av96it", "key": "domain_knowledge", "note": "1（完全不了解）\\n5（非常熟悉）", "label": "您对市场上与健康、健身相关的移动应用程序（例如：Keep, MyFitnessPal, 苹果健康等）有多熟悉？", "value": "3", "options": [], "varType": "string", "required": true, "inputType": "rating"}, {"id": "info-tf6d20kf", "key": "writing_skill", "note": "1（写作能力很弱）\\n5（写作能力很强）", "label": "请您评价自己的文字写作能力（例如：表达清晰度、词汇丰富度、逻辑性等）。", "value": "4", "options": [], "varType": "string", "required": true, "inputType": "rating"}]}, "writing_skill": "4", "familiarity_GPT": "有时使用（每周几次）", "domain_knowledge": "3", "self_perceived_creativity": "5"}}	2025-12-05 11:28:07.773727+00	{"label": "被试自评", "info_map": {"writing_skill": "4", "familiarity_GPT": "有时使用（每周几次）", "domain_knowledge": "3", "self_perceived_creativity": "5"}, "instruction": null, "workflow_id": null, "context_text": "", "info_variables": [{"id": "info-xl40jnto", "key": "self_perceived_creativity", "note": "", "label": "请您评价自己是一个富有创造力的人的程度", "value": "5", "options": [], "varType": "string", "required": true, "inputType": "rating"}, {"id": "info-jqhua8w7", "key": "familiarity_GPT", "note": "", "label": "在日常生活中，您使用 ChatGPT 的频率是？", "value": "有时使用（每周几次）", "options": [{"label": "从不使用", "value": "从不使用"}, {"label": "很少使用（每月几次）", "value": "很少使用（每月几次）"}, {"label": "有时使用（每周几次）", "value": "有时使用（每周几次）"}, {"label": "经常使用（几乎每天）", "value": "经常使用（几乎每天）"}], "varType": "string", "required": true, "inputType": "radio"}, {"id": "info-h3av96it", "key": "domain_knowledge", "note": "1（完全不了解）\\n5（非常熟悉）", "label": "您对市场上与健康、健身相关的移动应用程序（例如：Keep, MyFitnessPal, 苹果健康等）有多熟悉？", "value": "3", "options": [], "varType": "string", "required": true, "inputType": "rating"}, {"id": "info-tf6d20kf", "key": "writing_skill", "note": "1（写作能力很弱）\\n5（写作能力很强）", "label": "请您评价自己的文字写作能力（例如：表达清晰度、词汇丰富度、逻辑性等）。", "value": "4", "options": [], "varType": "string", "required": true, "inputType": "rating"}], "previous_output": "123", "input_variable_name": "input", "context_document_url": null}
238	118	node-miiginej-0lyp2e6y	{"output": {"age": "25-34岁", "__info": {"map": {"age": "25-34岁", "gender": "男", "income": "10000-20000/月", "education": "硕士", "martial status": "未婚", "employment status": "兼职工作"}, "variables": [{"id": "info-itbi0le0", "key": "gender", "note": "", "label": "gender", "value": "男", "options": [{"label": "男", "value": "男"}, {"label": "女", "value": "女"}, {"label": "非二元性别", "value": "非二元性别"}], "varType": "string", "required": true, "inputType": "radio"}, {"id": "info-satlj9xx", "key": "age", "note": "", "label": "年龄", "value": "25-34岁", "options": [{"label": "18-24岁", "value": "18-24岁"}, {"label": "25-34岁", "value": "25-34岁"}, {"label": "35-44岁", "value": "35-44岁"}, {"label": "45-54岁", "value": "45-54岁"}, {"label": "55-64岁", "value": "55-64岁"}, {"label": "65岁及以上", "value": "65岁及以上"}], "varType": "string", "required": true, "inputType": "select"}, {"id": "info-a6dqotkc", "key": "martial status", "note": "", "label": "婚姻状况", "value": "未婚", "options": [{"label": "已婚", "value": "已婚"}, {"label": "未婚", "value": "未婚"}, {"label": "离异", "value": "离异"}], "varType": "string", "required": true, "inputType": "radio"}, {"id": "info-v4e2rs94", "key": "education", "note": "", "label": "受教育程度", "value": "硕士", "options": [{"label": "高中及以下", "value": "高中及以下"}, {"label": "大专", "value": "大专"}, {"label": "本科", "value": "本科"}, {"label": "硕士", "value": "硕士"}, {"label": "博士", "value": "博士"}], "varType": "string", "required": true, "inputType": "radio"}, {"id": "info-2s5by0rh", "key": "employment status", "note": "", "label": "就业状况", "value": "兼职工作", "options": [{"label": "全职工作", "value": "全职工作"}, {"label": "兼职工作", "value": "兼职工作"}, {"label": "无工作", "value": "无工作"}], "varType": "string", "required": true, "inputType": "select"}, {"id": "info-hu5zhhhz", "key": "income", "note": "", "label": "收入", "value": "10000-20000/月", "options": [{"label": "<5000/月", "value": "<5000/月"}, {"label": "5000-10000/月", "value": "5000-10000/月"}, {"label": "10000-20000/月", "value": "10000-20000/月"}, {"label": "20000-30000/月", "value": "20000-30000/月"}, {"label": "30000-40000/月", "value": "30000-40000/月"}, {"label": ">40000/月", "value": ">40000/月"}], "varType": "string", "required": true, "inputType": "select"}]}, "gender": "男", "income": "10000-20000/月", "education": "硕士", "martial status": "未婚", "employment status": "兼职工作"}}	2025-12-05 11:28:16.184189+00	{"label": "demographic信息填写", "info_map": {"age": "25-34岁", "gender": "男", "income": "10000-20000/月", "education": "硕士", "martial status": "未婚", "employment status": "兼职工作"}, "instruction": null, "workflow_id": null, "context_text": "", "info_variables": [{"id": "info-itbi0le0", "key": "gender", "note": "", "label": "gender", "value": "男", "options": [{"label": "男", "value": "男"}, {"label": "女", "value": "女"}, {"label": "非二元性别", "value": "非二元性别"}], "varType": "string", "required": true, "inputType": "radio"}, {"id": "info-satlj9xx", "key": "age", "note": "", "label": "年龄", "value": "25-34岁", "options": [{"label": "18-24岁", "value": "18-24岁"}, {"label": "25-34岁", "value": "25-34岁"}, {"label": "35-44岁", "value": "35-44岁"}, {"label": "45-54岁", "value": "45-54岁"}, {"label": "55-64岁", "value": "55-64岁"}, {"label": "65岁及以上", "value": "65岁及以上"}], "varType": "string", "required": true, "inputType": "select"}, {"id": "info-a6dqotkc", "key": "martial status", "note": "", "label": "婚姻状况", "value": "未婚", "options": [{"label": "已婚", "value": "已婚"}, {"label": "未婚", "value": "未婚"}, {"label": "离异", "value": "离异"}], "varType": "string", "required": true, "inputType": "radio"}, {"id": "info-v4e2rs94", "key": "education", "note": "", "label": "受教育程度", "value": "硕士", "options": [{"label": "高中及以下", "value": "高中及以下"}, {"label": "大专", "value": "大专"}, {"label": "本科", "value": "本科"}, {"label": "硕士", "value": "硕士"}, {"label": "博士", "value": "博士"}], "varType": "string", "required": true, "inputType": "radio"}, {"id": "info-2s5by0rh", "key": "employment status", "note": "", "label": "就业状况", "value": "兼职工作", "options": [{"label": "全职工作", "value": "全职工作"}, {"label": "兼职工作", "value": "兼职工作"}, {"label": "无工作", "value": "无工作"}], "varType": "string", "required": true, "inputType": "select"}, {"id": "info-hu5zhhhz", "key": "income", "note": "", "label": "收入", "value": "10000-20000/月", "options": [{"label": "<5000/月", "value": "<5000/月"}, {"label": "5000-10000/月", "value": "5000-10000/月"}, {"label": "10000-20000/月", "value": "10000-20000/月"}, {"label": "20000-30000/月", "value": "20000-30000/月"}, {"label": "30000-40000/月", "value": "30000-40000/月"}, {"label": ">40000/月", "value": ">40000/月"}], "varType": "string", "required": true, "inputType": "select"}], "previous_output": {"__info": {"map": {"writing_skill": "4", "familiarity_GPT": "有时使用（每周几次）", "domain_knowledge": "3", "self_perceived_creativity": "5"}, "variables": [{"id": "info-xl40jnto", "key": "self_perceived_creativity", "note": "", "label": "请您评价自己是一个富有创造力的人的程度", "value": "5", "options": [], "varType": "string", "required": true, "inputType": "rating"}, {"id": "info-jqhua8w7", "key": "familiarity_GPT", "note": "", "label": "在日常生活中，您使用 ChatGPT 的频率是？", "value": "有时使用（每周几次）", "options": [{"label": "从不使用", "value": "从不使用"}, {"label": "很少使用（每月几次）", "value": "很少使用（每月几次）"}, {"label": "有时使用（每周几次）", "value": "有时使用（每周几次）"}, {"label": "经常使用（几乎每天）", "value": "经常使用（几乎每天）"}], "varType": "string", "required": true, "inputType": "radio"}, {"id": "info-h3av96it", "key": "domain_knowledge", "note": "1（完全不了解）\\n5（非常熟悉）", "label": "您对市场上与健康、健身相关的移动应用程序（例如：Keep, MyFitnessPal, 苹果健康等）有多熟悉？", "value": "3", "options": [], "varType": "string", "required": true, "inputType": "rating"}, {"id": "info-tf6d20kf", "key": "writing_skill", "note": "1（写作能力很弱）\\n5（写作能力很强）", "label": "请您评价自己的文字写作能力（例如：表达清晰度、词汇丰富度、逻辑性等）。", "value": "4", "options": [], "varType": "string", "required": true, "inputType": "rating"}]}, "writing_skill": "4", "familiarity_GPT": "有时使用（每周几次）", "domain_knowledge": "3", "self_perceived_creativity": "5"}, "input_variable_name": "input", "context_document_url": null}
239	128	node-miua719d-ejzi3dek	{"output": {"acknowledged": true, "startObjective": "提出一个创新的APP创意，该 App 旨在促进更健康的生活方式", "startBackground": "想象你正在为一家名为\\"博伦科技\\"的公司工作。该公司正在寻求创新的 App 概念，以响应消费者对数字健康工具日益增长的需求，帮助用户过上更健康的生活。", "startDeliverables": "APP产品创意文案"}}	2025-12-06 14:48:51.6883+00	{"label": "[启动] 实验简介", "instruction": null, "workflow_id": null, "context_text": null, "previous_output": null, "input_variable_name": "input", "context_document_url": null}
240	123	node-miua719d-ejzi3dek	{"output": {"acknowledged": true, "startObjective": "提出一个创新的APP创意，该 App 旨在促进更健康的生活方式", "startBackground": "想象你正在为一家名为\\"博伦科技\\"的公司工作。该公司正在寻求创新的 App 概念，以响应消费者对数字健康工具日益增长的需求，帮助用户过上更健康的生活。", "startDeliverables": "APP产品创意文案"}}	2025-12-06 14:49:35.162571+00	{"label": "[启动] 实验简介", "instruction": null, "workflow_id": null, "context_text": null, "previous_output": null, "input_variable_name": "input", "context_document_url": null}
241	123	node-miucdltv-4yfnvoqh	{"output": {"__info": {"map": {"user_decision": "委托"}, "variables": [{"id": "info-epth9om1", "key": "user_decision", "note": "", "label": "请您选择，是否把Idea的构思任务委托给AI完成？", "value": "委托", "options": [{"label": "委托", "value": "委托"}, {"label": "不委托", "value": "不委托"}], "varType": "string", "required": true, "inputType": "radio"}]}, "user_decision": "委托"}}	2025-12-06 14:49:40.927566+00	{"label": "AI委托决策", "info_map": {"user_decision": "委托"}, "instruction": null, "workflow_id": null, "context_text": "", "info_variables": [{"id": "info-epth9om1", "key": "user_decision", "note": "", "label": "请您选择，是否把Idea的构思任务委托给AI完成？", "value": "委托", "options": [{"label": "委托", "value": "委托"}, {"label": "不委托", "value": "不委托"}], "varType": "string", "required": true, "inputType": "radio"}], "previous_output": {"acknowledged": true, "startObjective": "提出一个创新的APP创意，该 App 旨在促进更健康的生活方式", "startBackground": "想象你正在为一家名为\\"博伦科技\\"的公司工作。该公司正在寻求创新的 App 概念，以响应消费者对数字健康工具日益增长的需求，帮助用户过上更健康的生活。", "startDeliverables": "APP产品创意文案"}, "input_variable_name": "input", "context_document_url": null}
242	123	node-miucga2x-avn5qsuz	{"output": "{\\"output1\\":\\"好的，这是我的提案：\\\\n\\\\n**App名称：健康拼图 (Health Puzzle)**\\\\n\\\\n**核心功能：** 将健康习惯转化为趣味“拼图块”。用户设定每日小目标（如喝水、运动、早睡），完成即获得一块拼图。连续达成目标，拼图逐渐显现一幅完整的健康主题图片（如风景、名画），提供成就感与即时激励。支持好友间拼图挑战与分享，增加社交动力。\\\\n\\\\n**目标用户：** 追求健康生活方式但难以坚持的年轻上班族及学生，偏好游戏化互动和社交激励的人群。\\\\n\\\\n（字数：约140字）\\"}"}	2025-12-06 14:49:55.8505+00	{"label": "Task 1: Idea Generation (AI-Lead)", "instruction": null, "workflow_id": "7580284403985678336", "context_text": "", "previous_output": {"__info": {"map": {"user_decision": "委托"}, "variables": [{"id": "info-epth9om1", "key": "user_decision", "note": "", "label": "请您选择，是否把Idea的构思任务委托给AI完成？", "value": "委托", "options": [{"label": "委托", "value": "委托"}, {"label": "不委托", "value": "不委托"}], "varType": "string", "required": true, "inputType": "radio"}]}, "user_decision": "委托"}, "input_variable_name": "input", "context_document_url": null}
243	123	node-miua7q2o-qi2ahlek	{"output": "**App名称：健康拼图 (Health Puzzle)**\\n\\n**核心价值主张： **\\n[拼图你的健康人生！]\\n\\n**核心功能：** \\n1. 目标设定 & 拼图：\\n -将健康习惯转化为趣味“拼图块”。用户设定每日小目标（如喝水、运动、早睡），完成即获得一块拼图；\\n - 目标库预设：提供「喝水/运动/睡眠」等10个高频场景模板（降低用户设置门槛）；\\n2. 拼图游戏 + 社交\\n - 连续达成目标，拼图逐渐显现一幅完整的健康主题图片（如风景、名画），提供成就感与即时激励；\\n - 引入「拼图互助」：好友可赠送「加速卡」（缩短目标达成时间），避免攀比导致压力。  \\n - 分享机制：生成拼图成就海报时，自动嵌入「邀请码」（拉新转化率预计提升15%）。\\n - 支持好友间拼图挑战与分享，增加社交动力。\\n\\n\\n**目标用户：** 追求健康生活方式但难以坚持的年轻上班族及学生，偏好游戏化互动和社交激励的人群。"}	2025-12-06 15:01:33.573553+00	{"label": "Task 2: Idea Refinement", "instruction": "现在你已经有了一个初始创意。在这个阶段，你将与一位 AI 助手合作，对这个创意进行打磨、润色和改进。\\n\\n你可以通过右侧的聊天界面与 AI 自由互动。当你对结果满意时，请提交最终版本的创意。", "workflow_id": null, "context_text": "", "previous_output": "{\\"output1\\":\\"好的，这是我的提案：\\\\n\\\\n**App名称：健康拼图 (Health Puzzle)**\\\\n\\\\n**核心功能：** 将健康习惯转化为趣味“拼图块”。用户设定每日小目标（如喝水、运动、早睡），完成即获得一块拼图。连续达成目标，拼图逐渐显现一幅完整的健康主题图片（如风景、名画），提供成就感与即时激励。支持好友间拼图挑战与分享，增加社交动力。\\\\n\\\\n**目标用户：** 追求健康生活方式但难以坚持的年轻上班族及学生，偏好游戏化互动和社交激励的人群。\\\\n\\\\n（字数：约140字）\\"}", "input_variable_name": "input", "context_document_url": null}
244	123	node-miua89pi-yo1sqaaf	{"output": {"__info": {"map": {"writing_skill": "4", "familiarity_GPT": "经常使用（几乎每天）", "domain_knowledge": "4", "self_perceived_creativity": "4"}, "variables": [{"id": "info-uhr64sxo", "key": "self_perceived_creativity", "note": "1（创造力较低）5（创造力高）", "label": "请您评价自己是一个富有创造力的人的程度", "value": "4", "options": [], "varType": "string", "required": true, "inputType": "rating"}, {"id": "info-wq4q3bs1", "key": "familiarity_GPT", "note": "", "label": "在日常生活中，您使用 ChatGPT 的频率是？", "value": "经常使用（几乎每天）", "options": [{"label": "从不使用", "value": "从不使用"}, {"label": "很少使用（每月几次）", "value": "很少使用（每月几次）"}, {"label": "有时使用（每周几次）", "value": "有时使用（每周几次）"}, {"label": "经常使用（几乎每天）", "value": "经常使用（几乎每天）"}], "varType": "string", "required": true, "inputType": "radio"}, {"id": "info-g8qt52sz", "key": "domain_knowledge", "note": "1（完全不了解）\\n5（非常熟悉）", "label": "您对市场上与健康、健身相关的移动应用程序（例如：Keep, MyFitnessPal, 苹果健康等）有多熟悉？", "value": "4", "options": [], "varType": "string", "required": true, "inputType": "rating"}, {"id": "info-s5vob122", "key": "writing_skill", "note": "1（写作能力很弱）\\n5（写作能力很强）", "label": "请您评价自己的文字写作能力（例如：表达清晰度、词汇丰富度、逻辑性等）。", "value": "4", "options": [], "varType": "string", "required": true, "inputType": "rating"}]}, "writing_skill": "4", "familiarity_GPT": "经常使用（几乎每天）", "domain_knowledge": "4", "self_perceived_creativity": "4"}}	2025-12-06 15:01:45.135713+00	{"label": "被试自评", "info_map": {"writing_skill": "4", "familiarity_GPT": "经常使用（几乎每天）", "domain_knowledge": "4", "self_perceived_creativity": "4"}, "instruction": null, "workflow_id": null, "context_text": "", "info_variables": [{"id": "info-uhr64sxo", "key": "self_perceived_creativity", "note": "1（创造力较低）5（创造力高）", "label": "请您评价自己是一个富有创造力的人的程度", "value": "4", "options": [], "varType": "string", "required": true, "inputType": "rating"}, {"id": "info-wq4q3bs1", "key": "familiarity_GPT", "note": "", "label": "在日常生活中，您使用 ChatGPT 的频率是？", "value": "经常使用（几乎每天）", "options": [{"label": "从不使用", "value": "从不使用"}, {"label": "很少使用（每月几次）", "value": "很少使用（每月几次）"}, {"label": "有时使用（每周几次）", "value": "有时使用（每周几次）"}, {"label": "经常使用（几乎每天）", "value": "经常使用（几乎每天）"}], "varType": "string", "required": true, "inputType": "radio"}, {"id": "info-g8qt52sz", "key": "domain_knowledge", "note": "1（完全不了解）\\n5（非常熟悉）", "label": "您对市场上与健康、健身相关的移动应用程序（例如：Keep, MyFitnessPal, 苹果健康等）有多熟悉？", "value": "4", "options": [], "varType": "string", "required": true, "inputType": "rating"}, {"id": "info-s5vob122", "key": "writing_skill", "note": "1（写作能力很弱）\\n5（写作能力很强）", "label": "请您评价自己的文字写作能力（例如：表达清晰度、词汇丰富度、逻辑性等）。", "value": "4", "options": [], "varType": "string", "required": true, "inputType": "rating"}], "previous_output": "**App名称：健康拼图 (Health Puzzle)**\\n\\n**核心价值主张： **\\n[拼图你的健康人生！]\\n\\n**核心功能：** \\n1. 目标设定 & 拼图：\\n -将健康习惯转化为趣味“拼图块”。用户设定每日小目标（如喝水、运动、早睡），完成即获得一块拼图；\\n - 目标库预设：提供「喝水/运动/睡眠」等10个高频场景模板（降低用户设置门槛）；\\n2. 拼图游戏 + 社交\\n - 连续达成目标，拼图逐渐显现一幅完整的健康主题图片（如风景、名画），提供成就感与即时激励；\\n - 引入「拼图互助」：好友可赠送「加速卡」（缩短目标达成时间），避免攀比导致压力。  \\n - 分享机制：生成拼图成就海报时，自动嵌入「邀请码」（拉新转化率预计提升15%）。\\n - 支持好友间拼图挑战与分享，增加社交动力。\\n\\n\\n**目标用户：** 追求健康生活方式但难以坚持的年轻上班族及学生，偏好游戏化互动和社交激励的人群。", "input_variable_name": "input", "context_document_url": null}
245	123	node-miua8n3s-6lyd0xiz	{"output": {"age": "25-34岁", "__info": {"map": {"age": "25-34岁", "gender": "男", "income": "5000-10000/月", "education": "硕士", "martial status": "已婚", "employment status": "全职工作"}, "variables": [{"id": "info-6dp84pi9", "key": "gender", "note": "", "label": "性别", "value": "男", "options": [{"label": "男", "value": "男"}, {"label": "女", "value": "女"}, {"label": "非二元性别", "value": "非二元性别"}], "varType": "string", "required": true, "inputType": "radio"}, {"id": "info-ulr5moj4", "key": "age", "note": "", "label": "年龄", "value": "25-34岁", "options": [{"label": "18-24岁", "value": "18-24岁"}, {"label": "25-34岁", "value": "25-34岁"}, {"label": "35-44岁", "value": "35-44岁"}, {"label": "45-54岁", "value": "45-54岁"}, {"label": "55-64岁", "value": "55-64岁"}, {"label": "65岁及以上", "value": "65岁及以上"}], "varType": "string", "required": true, "inputType": "select"}, {"id": "info-pb5z9bkj", "key": "martial status", "note": "", "label": "婚姻状况", "value": "已婚", "options": [{"label": "已婚", "value": "已婚"}, {"label": "未婚", "value": "未婚"}, {"label": "离异", "value": "离异"}], "varType": "string", "required": true, "inputType": "radio"}, {"id": "info-1w7jhyyd", "key": "education", "note": "", "label": "受教育程度", "value": "硕士", "options": [{"label": "高中及以下", "value": "高中及以下"}, {"label": "大专", "value": "大专"}, {"label": "本科", "value": "本科"}, {"label": "硕士", "value": "硕士"}, {"label": "博士", "value": "博士"}], "varType": "string", "required": true, "inputType": "radio"}, {"id": "info-ao4914e2", "key": "employment status", "note": "", "label": "就业状况", "value": "全职工作", "options": [{"label": "全职工作", "value": "全职工作"}, {"label": "兼职工作", "value": "兼职工作"}, {"label": "无工作", "value": "无工作"}], "varType": "string", "required": true, "inputType": "select"}, {"id": "info-w4pwfuw6", "key": "income", "note": "", "label": "收入", "value": "5000-10000/月", "options": [{"label": "<5000/月", "value": "<5000/月"}, {"label": "5000-10000/月", "value": "5000-10000/月"}, {"label": "10000-20000/月", "value": "10000-20000/月"}, {"label": "20000-30000/月", "value": "20000-30000/月"}, {"label": "30000-40000/月", "value": "30000-40000/月"}, {"label": ">40000/月", "value": ">40000/月"}], "varType": "string", "required": true, "inputType": "select"}]}, "gender": "男", "income": "5000-10000/月", "education": "硕士", "martial status": "已婚", "employment status": "全职工作"}}	2025-12-06 15:01:54.135928+00	{"label": "被试基本信息填写", "info_map": {"age": "25-34岁", "gender": "男", "income": "5000-10000/月", "education": "硕士", "martial status": "已婚", "employment status": "全职工作"}, "instruction": null, "workflow_id": null, "context_text": "", "info_variables": [{"id": "info-6dp84pi9", "key": "gender", "note": "", "label": "性别", "value": "男", "options": [{"label": "男", "value": "男"}, {"label": "女", "value": "女"}, {"label": "非二元性别", "value": "非二元性别"}], "varType": "string", "required": true, "inputType": "radio"}, {"id": "info-ulr5moj4", "key": "age", "note": "", "label": "年龄", "value": "25-34岁", "options": [{"label": "18-24岁", "value": "18-24岁"}, {"label": "25-34岁", "value": "25-34岁"}, {"label": "35-44岁", "value": "35-44岁"}, {"label": "45-54岁", "value": "45-54岁"}, {"label": "55-64岁", "value": "55-64岁"}, {"label": "65岁及以上", "value": "65岁及以上"}], "varType": "string", "required": true, "inputType": "select"}, {"id": "info-pb5z9bkj", "key": "martial status", "note": "", "label": "婚姻状况", "value": "已婚", "options": [{"label": "已婚", "value": "已婚"}, {"label": "未婚", "value": "未婚"}, {"label": "离异", "value": "离异"}], "varType": "string", "required": true, "inputType": "radio"}, {"id": "info-1w7jhyyd", "key": "education", "note": "", "label": "受教育程度", "value": "硕士", "options": [{"label": "高中及以下", "value": "高中及以下"}, {"label": "大专", "value": "大专"}, {"label": "本科", "value": "本科"}, {"label": "硕士", "value": "硕士"}, {"label": "博士", "value": "博士"}], "varType": "string", "required": true, "inputType": "radio"}, {"id": "info-ao4914e2", "key": "employment status", "note": "", "label": "就业状况", "value": "全职工作", "options": [{"label": "全职工作", "value": "全职工作"}, {"label": "兼职工作", "value": "兼职工作"}, {"label": "无工作", "value": "无工作"}], "varType": "string", "required": true, "inputType": "select"}, {"id": "info-w4pwfuw6", "key": "income", "note": "", "label": "收入", "value": "5000-10000/月", "options": [{"label": "<5000/月", "value": "<5000/月"}, {"label": "5000-10000/月", "value": "5000-10000/月"}, {"label": "10000-20000/月", "value": "10000-20000/月"}, {"label": "20000-30000/月", "value": "20000-30000/月"}, {"label": "30000-40000/月", "value": "30000-40000/月"}, {"label": ">40000/月", "value": ">40000/月"}], "varType": "string", "required": true, "inputType": "select"}], "previous_output": {"__info": {"map": {"writing_skill": "4", "familiarity_GPT": "经常使用（几乎每天）", "domain_knowledge": "4", "self_perceived_creativity": "4"}, "variables": [{"id": "info-uhr64sxo", "key": "self_perceived_creativity", "note": "1（创造力较低）5（创造力高）", "label": "请您评价自己是一个富有创造力的人的程度", "value": "4", "options": [], "varType": "string", "required": true, "inputType": "rating"}, {"id": "info-wq4q3bs1", "key": "familiarity_GPT", "note": "", "label": "在日常生活中，您使用 ChatGPT 的频率是？", "value": "经常使用（几乎每天）", "options": [{"label": "从不使用", "value": "从不使用"}, {"label": "很少使用（每月几次）", "value": "很少使用（每月几次）"}, {"label": "有时使用（每周几次）", "value": "有时使用（每周几次）"}, {"label": "经常使用（几乎每天）", "value": "经常使用（几乎每天）"}], "varType": "string", "required": true, "inputType": "radio"}, {"id": "info-g8qt52sz", "key": "domain_knowledge", "note": "1（完全不了解）\\n5（非常熟悉）", "label": "您对市场上与健康、健身相关的移动应用程序（例如：Keep, MyFitnessPal, 苹果健康等）有多熟悉？", "value": "4", "options": [], "varType": "string", "required": true, "inputType": "rating"}, {"id": "info-s5vob122", "key": "writing_skill", "note": "1（写作能力很弱）\\n5（写作能力很强）", "label": "请您评价自己的文字写作能力（例如：表达清晰度、词汇丰富度、逻辑性等）。", "value": "4", "options": [], "varType": "string", "required": true, "inputType": "rating"}]}, "writing_skill": "4", "familiarity_GPT": "经常使用（几乎每天）", "domain_knowledge": "4", "self_perceived_creativity": "4"}, "input_variable_name": "input", "context_document_url": null}
246	125	node-miua719d-ejzi3dek	{"output": {"acknowledged": true, "startObjective": "提出一个创新的APP创意，该 App 旨在促进更健康的生活方式", "startBackground": "想象你正在为一家名为\\"博伦科技\\"的公司工作。该公司正在寻求创新的 App 概念，以响应消费者对数字健康工具日益增长的需求，帮助用户过上更健康的生活。", "startDeliverables": "APP产品创意文案"}}	2025-12-06 15:14:44.894692+00	{"label": "[启动] 实验简介", "instruction": null, "workflow_id": null, "context_text": null, "previous_output": null, "input_variable_name": "input", "context_document_url": null}
247	125	node-miucbs25-na4wm34k	{"output": "{\\"output1\\":\\"好的，作为博伦科技的产品经理，我构思了一款名为**\\\\\\"PowerNap\\\\\\"**的App。\\\\n\\\\n**核心功能：**\\\\n*   **智能午休管理：** 用户设定目标小睡时长（如20分钟），App提供舒缓引导（音乐、呼吸）助其快速入睡。\\\\n*   **科学唤醒：** 在用户设定的时间窗口内，通过温和震动或渐强声音，在用户处于浅睡眠阶段唤醒，避免昏沉感。\\\\n*   **睡眠周期追踪：** 记录小睡时长和质量，分析其对用户日间精力的影响。\\\\n*   **个性化建议：** 根据用户习惯和数据分析，提供优化午休时间和方式的建议，避免影响夜间睡眠。\\\\n\\\\n**目标用户：** 注重工作效率、精力管理的职场人士，尤其是经常感到午后疲惫、难以集中注意力的人群。它旨在帮助用户高效恢复精力，提升下午工作效率。\\"}"}	2025-12-06 15:15:03.122029+00	{"label": "Task 1: Idea Generation (AI-Lead)", "instruction": null, "workflow_id": "7580284403985678336", "context_text": "", "previous_output": {"acknowledged": true, "startObjective": "提出一个创新的APP创意，该 App 旨在促进更健康的生活方式", "startBackground": "想象你正在为一家名为\\"博伦科技\\"的公司工作。该公司正在寻求创新的 App 概念，以响应消费者对数字健康工具日益增长的需求，帮助用户过上更健康的生活。", "startDeliverables": "APP产品创意文案"}, "input_variable_name": "input", "context_document_url": null}
248	128	node-miua79hc-bpp0qxmy	{"output": "**App名称：健康拼图 (Health Puzzle)**\\n\\n**核心功能：\\n** 将健康习惯转化为趣味“拼图块”。用户设定每日小目标（如喝水、运动、早睡），完成即获得一块拼图。连续达成目标，拼图逐渐显现一幅完整的健康主题图片（如风景、名画），提供成就感与即时激励。支持好友间拼图挑战与分享，增加社交动力。\\n\\n**目标用户：** 追求健康生活方式但难以坚持的年轻上班族及学生，偏好游戏化互动和社交激励的人群。"}	2025-12-06 15:17:32.237983+00	{"label": "Task 1: Idea Generation", "instruction": "1. 背景：想象你正在为一家名为\\"博伦科技\\"的公司工作。该公司正在寻求创新的 App 概念，以响应消费者对数字健康工具日益增长的需求，帮助用户过上更健康的生活。\\n\\n2. 任务要求：\\n请在下方文本框中详细描述您的 App 初始创意。\\n您必须完全依靠自己来构思和撰写，请勿使用任何 AI 工具。\\n\\n为了让您的创意更具说服力，建议您的描述包含以下内容（仅供参考）：\\n - App 名称：给它起一个响亮的名字。\\n - 核心功能：它能做什么？解决了什么问题？\\n - 目标用户：谁会使用它？", "workflow_id": null, "context_text": "", "previous_output": {"acknowledged": true, "startObjective": "提出一个创新的APP创意，该 App 旨在促进更健康的生活方式", "startBackground": "想象你正在为一家名为\\"博伦科技\\"的公司工作。该公司正在寻求创新的 App 概念，以响应消费者对数字健康工具日益增长的需求，帮助用户过上更健康的生活。", "startDeliverables": "APP产品创意文案"}, "input_variable_name": "input", "context_document_url": null}
249	128	node-miua7q2o-qi2ahlek	{"output": "**App名称：健康拼图 (Health Puzzle)**\\n\\n**核心价值点： **\\n\\n\\n**核心功能：** \\n1. 目标设定 & 拼图：\\n -将健康习惯转化为趣味“拼图块”。用户设定每日小目标（如喝水、运动、早睡），完成即获得一块拼图；\\n - 目标库预设：提供「喝水/运动/睡眠」等10个高频场景模板（降低用户设置门槛）；\\n2. 拼图游戏 + 社交\\n - 连续达成目标，拼图逐渐显现一幅完整的健康主题图片（如风景、名画），提供成就感与即时激励；\\n - 引入「拼图互助」：好友可赠送「加速卡」（缩短目标达成时间），避免攀比导致压力。  \\n - 分享机制：生成拼图成就海报时，自动嵌入「邀请码」（拉新转化率预计提升15%）。\\n - 支持好友间拼图挑战与分享，增加社交动力。\\n\\n\\n**目标用户：** 追求健康生活方式但难以坚持的年轻上班族及学生，偏好游戏化互动和社交激励的人群。"}	2025-12-06 15:17:46.225875+00	{"label": "Task 2: Idea Refinement", "instruction": "现在你已经有了一个初始创意。在这个阶段，你将与一位 AI 助手合作，对这个创意进行打磨、润色和改进。\\n\\n你可以通过右侧的聊天界面与 AI 自由互动。当你对结果满意时，请提交最终版本的创意。", "workflow_id": null, "context_text": "", "previous_output": "**App名称：健康拼图 (Health Puzzle)**\\n\\n**核心功能：\\n** 将健康习惯转化为趣味“拼图块”。用户设定每日小目标（如喝水、运动、早睡），完成即获得一块拼图。连续达成目标，拼图逐渐显现一幅完整的健康主题图片（如风景、名画），提供成就感与即时激励。支持好友间拼图挑战与分享，增加社交动力。\\n\\n**目标用户：** 追求健康生活方式但难以坚持的年轻上班族及学生，偏好游戏化互动和社交激励的人群。", "input_variable_name": "input", "context_document_url": null}
250	128	node-miua89pi-yo1sqaaf	{"output": {"__info": {"map": {"writing_skill": "4", "familiarity_GPT": "经常使用（几乎每天）", "domain_knowledge": "4", "self_perceived_creativity": "4"}, "variables": [{"id": "info-uhr64sxo", "key": "self_perceived_creativity", "note": "1（创造力较低）5（创造力高）", "label": "请您评价自己是一个富有创造力的人的程度", "value": "4", "options": [], "varType": "string", "required": true, "inputType": "rating"}, {"id": "info-wq4q3bs1", "key": "familiarity_GPT", "note": "", "label": "在日常生活中，您使用 ChatGPT 的频率是？", "value": "经常使用（几乎每天）", "options": [{"label": "从不使用", "value": "从不使用"}, {"label": "很少使用（每月几次）", "value": "很少使用（每月几次）"}, {"label": "有时使用（每周几次）", "value": "有时使用（每周几次）"}, {"label": "经常使用（几乎每天）", "value": "经常使用（几乎每天）"}], "varType": "string", "required": true, "inputType": "radio"}, {"id": "info-g8qt52sz", "key": "domain_knowledge", "note": "1（完全不了解）\\n5（非常熟悉）", "label": "您对市场上与健康、健身相关的移动应用程序（例如：Keep, MyFitnessPal, 苹果健康等）有多熟悉？", "value": "4", "options": [], "varType": "string", "required": true, "inputType": "rating"}, {"id": "info-s5vob122", "key": "writing_skill", "note": "1（写作能力很弱）\\n5（写作能力很强）", "label": "请您评价自己的文字写作能力（例如：表达清晰度、词汇丰富度、逻辑性等）。", "value": "4", "options": [], "varType": "string", "required": true, "inputType": "rating"}]}, "writing_skill": "4", "familiarity_GPT": "经常使用（几乎每天）", "domain_knowledge": "4", "self_perceived_creativity": "4"}}	2025-12-06 15:17:52.628909+00	{"label": "被试自评", "info_map": {"writing_skill": "4", "familiarity_GPT": "经常使用（几乎每天）", "domain_knowledge": "4", "self_perceived_creativity": "4"}, "instruction": null, "workflow_id": null, "context_text": "", "info_variables": [{"id": "info-uhr64sxo", "key": "self_perceived_creativity", "note": "1（创造力较低）5（创造力高）", "label": "请您评价自己是一个富有创造力的人的程度", "value": "4", "options": [], "varType": "string", "required": true, "inputType": "rating"}, {"id": "info-wq4q3bs1", "key": "familiarity_GPT", "note": "", "label": "在日常生活中，您使用 ChatGPT 的频率是？", "value": "经常使用（几乎每天）", "options": [{"label": "从不使用", "value": "从不使用"}, {"label": "很少使用（每月几次）", "value": "很少使用（每月几次）"}, {"label": "有时使用（每周几次）", "value": "有时使用（每周几次）"}, {"label": "经常使用（几乎每天）", "value": "经常使用（几乎每天）"}], "varType": "string", "required": true, "inputType": "radio"}, {"id": "info-g8qt52sz", "key": "domain_knowledge", "note": "1（完全不了解）\\n5（非常熟悉）", "label": "您对市场上与健康、健身相关的移动应用程序（例如：Keep, MyFitnessPal, 苹果健康等）有多熟悉？", "value": "4", "options": [], "varType": "string", "required": true, "inputType": "rating"}, {"id": "info-s5vob122", "key": "writing_skill", "note": "1（写作能力很弱）\\n5（写作能力很强）", "label": "请您评价自己的文字写作能力（例如：表达清晰度、词汇丰富度、逻辑性等）。", "value": "4", "options": [], "varType": "string", "required": true, "inputType": "rating"}], "previous_output": "**App名称：健康拼图 (Health Puzzle)**\\n\\n**核心价值点： **\\n\\n\\n**核心功能：** \\n1. 目标设定 & 拼图：\\n -将健康习惯转化为趣味“拼图块”。用户设定每日小目标（如喝水、运动、早睡），完成即获得一块拼图；\\n - 目标库预设：提供「喝水/运动/睡眠」等10个高频场景模板（降低用户设置门槛）；\\n2. 拼图游戏 + 社交\\n - 连续达成目标，拼图逐渐显现一幅完整的健康主题图片（如风景、名画），提供成就感与即时激励；\\n - 引入「拼图互助」：好友可赠送「加速卡」（缩短目标达成时间），避免攀比导致压力。  \\n - 分享机制：生成拼图成就海报时，自动嵌入「邀请码」（拉新转化率预计提升15%）。\\n - 支持好友间拼图挑战与分享，增加社交动力。\\n\\n\\n**目标用户：** 追求健康生活方式但难以坚持的年轻上班族及学生，偏好游戏化互动和社交激励的人群。", "input_variable_name": "input", "context_document_url": null}
251	128	node-miua8n3s-6lyd0xiz	{"output": {"age": "25-34岁", "__info": {"map": {"age": "25-34岁", "gender": "男", "income": "5000-10000/月", "education": "硕士", "martial status": "已婚", "employment status": "全职工作"}, "variables": [{"id": "info-6dp84pi9", "key": "gender", "note": "", "label": "性别", "value": "男", "options": [{"label": "男", "value": "男"}, {"label": "女", "value": "女"}, {"label": "非二元性别", "value": "非二元性别"}], "varType": "string", "required": true, "inputType": "radio"}, {"id": "info-ulr5moj4", "key": "age", "note": "", "label": "年龄", "value": "25-34岁", "options": [{"label": "18-24岁", "value": "18-24岁"}, {"label": "25-34岁", "value": "25-34岁"}, {"label": "35-44岁", "value": "35-44岁"}, {"label": "45-54岁", "value": "45-54岁"}, {"label": "55-64岁", "value": "55-64岁"}, {"label": "65岁及以上", "value": "65岁及以上"}], "varType": "string", "required": true, "inputType": "select"}, {"id": "info-pb5z9bkj", "key": "martial status", "note": "", "label": "婚姻状况", "value": "已婚", "options": [{"label": "已婚", "value": "已婚"}, {"label": "未婚", "value": "未婚"}, {"label": "离异", "value": "离异"}], "varType": "string", "required": true, "inputType": "radio"}, {"id": "info-1w7jhyyd", "key": "education", "note": "", "label": "受教育程度", "value": "硕士", "options": [{"label": "高中及以下", "value": "高中及以下"}, {"label": "大专", "value": "大专"}, {"label": "本科", "value": "本科"}, {"label": "硕士", "value": "硕士"}, {"label": "博士", "value": "博士"}], "varType": "string", "required": true, "inputType": "radio"}, {"id": "info-ao4914e2", "key": "employment status", "note": "", "label": "就业状况", "value": "全职工作", "options": [{"label": "全职工作", "value": "全职工作"}, {"label": "兼职工作", "value": "兼职工作"}, {"label": "无工作", "value": "无工作"}], "varType": "string", "required": true, "inputType": "select"}, {"id": "info-w4pwfuw6", "key": "income", "note": "", "label": "收入", "value": "5000-10000/月", "options": [{"label": "<5000/月", "value": "<5000/月"}, {"label": "5000-10000/月", "value": "5000-10000/月"}, {"label": "10000-20000/月", "value": "10000-20000/月"}, {"label": "20000-30000/月", "value": "20000-30000/月"}, {"label": "30000-40000/月", "value": "30000-40000/月"}, {"label": ">40000/月", "value": ">40000/月"}], "varType": "string", "required": true, "inputType": "select"}]}, "gender": "男", "income": "5000-10000/月", "education": "硕士", "martial status": "已婚", "employment status": "全职工作"}}	2025-12-06 15:18:00.863901+00	{"label": "被试基本信息填写", "info_map": {"age": "25-34岁", "gender": "男", "income": "5000-10000/月", "education": "硕士", "martial status": "已婚", "employment status": "全职工作"}, "instruction": null, "workflow_id": null, "context_text": "", "info_variables": [{"id": "info-6dp84pi9", "key": "gender", "note": "", "label": "性别", "value": "男", "options": [{"label": "男", "value": "男"}, {"label": "女", "value": "女"}, {"label": "非二元性别", "value": "非二元性别"}], "varType": "string", "required": true, "inputType": "radio"}, {"id": "info-ulr5moj4", "key": "age", "note": "", "label": "年龄", "value": "25-34岁", "options": [{"label": "18-24岁", "value": "18-24岁"}, {"label": "25-34岁", "value": "25-34岁"}, {"label": "35-44岁", "value": "35-44岁"}, {"label": "45-54岁", "value": "45-54岁"}, {"label": "55-64岁", "value": "55-64岁"}, {"label": "65岁及以上", "value": "65岁及以上"}], "varType": "string", "required": true, "inputType": "select"}, {"id": "info-pb5z9bkj", "key": "martial status", "note": "", "label": "婚姻状况", "value": "已婚", "options": [{"label": "已婚", "value": "已婚"}, {"label": "未婚", "value": "未婚"}, {"label": "离异", "value": "离异"}], "varType": "string", "required": true, "inputType": "radio"}, {"id": "info-1w7jhyyd", "key": "education", "note": "", "label": "受教育程度", "value": "硕士", "options": [{"label": "高中及以下", "value": "高中及以下"}, {"label": "大专", "value": "大专"}, {"label": "本科", "value": "本科"}, {"label": "硕士", "value": "硕士"}, {"label": "博士", "value": "博士"}], "varType": "string", "required": true, "inputType": "radio"}, {"id": "info-ao4914e2", "key": "employment status", "note": "", "label": "就业状况", "value": "全职工作", "options": [{"label": "全职工作", "value": "全职工作"}, {"label": "兼职工作", "value": "兼职工作"}, {"label": "无工作", "value": "无工作"}], "varType": "string", "required": true, "inputType": "select"}, {"id": "info-w4pwfuw6", "key": "income", "note": "", "label": "收入", "value": "5000-10000/月", "options": [{"label": "<5000/月", "value": "<5000/月"}, {"label": "5000-10000/月", "value": "5000-10000/月"}, {"label": "10000-20000/月", "value": "10000-20000/月"}, {"label": "20000-30000/月", "value": "20000-30000/月"}, {"label": "30000-40000/月", "value": "30000-40000/月"}, {"label": ">40000/月", "value": ">40000/月"}], "varType": "string", "required": true, "inputType": "select"}], "previous_output": {"__info": {"map": {"writing_skill": "4", "familiarity_GPT": "经常使用（几乎每天）", "domain_knowledge": "4", "self_perceived_creativity": "4"}, "variables": [{"id": "info-uhr64sxo", "key": "self_perceived_creativity", "note": "1（创造力较低）5（创造力高）", "label": "请您评价自己是一个富有创造力的人的程度", "value": "4", "options": [], "varType": "string", "required": true, "inputType": "rating"}, {"id": "info-wq4q3bs1", "key": "familiarity_GPT", "note": "", "label": "在日常生活中，您使用 ChatGPT 的频率是？", "value": "经常使用（几乎每天）", "options": [{"label": "从不使用", "value": "从不使用"}, {"label": "很少使用（每月几次）", "value": "很少使用（每月几次）"}, {"label": "有时使用（每周几次）", "value": "有时使用（每周几次）"}, {"label": "经常使用（几乎每天）", "value": "经常使用（几乎每天）"}], "varType": "string", "required": true, "inputType": "radio"}, {"id": "info-g8qt52sz", "key": "domain_knowledge", "note": "1（完全不了解）\\n5（非常熟悉）", "label": "您对市场上与健康、健身相关的移动应用程序（例如：Keep, MyFitnessPal, 苹果健康等）有多熟悉？", "value": "4", "options": [], "varType": "string", "required": true, "inputType": "rating"}, {"id": "info-s5vob122", "key": "writing_skill", "note": "1（写作能力很弱）\\n5（写作能力很强）", "label": "请您评价自己的文字写作能力（例如：表达清晰度、词汇丰富度、逻辑性等）。", "value": "4", "options": [], "varType": "string", "required": true, "inputType": "rating"}]}, "writing_skill": "4", "familiarity_GPT": "经常使用（几乎每天）", "domain_knowledge": "4", "self_perceived_creativity": "4"}, "input_variable_name": "input", "context_document_url": null}
\.


--
-- Data for Name: messages_2025_11_29; Type: TABLE DATA; Schema: realtime; Owner: -
--

COPY realtime.messages_2025_11_29 (topic, extension, payload, event, private, updated_at, inserted_at, id) FROM stdin;
\.


--
-- Data for Name: messages_2025_12_01; Type: TABLE DATA; Schema: realtime; Owner: -
--

COPY realtime.messages_2025_12_01 (topic, extension, payload, event, private, updated_at, inserted_at, id) FROM stdin;
\.


--
-- Data for Name: messages_2025_12_02; Type: TABLE DATA; Schema: realtime; Owner: -
--

COPY realtime.messages_2025_12_02 (topic, extension, payload, event, private, updated_at, inserted_at, id) FROM stdin;
\.


--
-- Data for Name: messages_2025_12_03; Type: TABLE DATA; Schema: realtime; Owner: -
--

COPY realtime.messages_2025_12_03 (topic, extension, payload, event, private, updated_at, inserted_at, id) FROM stdin;
\.


--
-- Data for Name: messages_2025_12_04; Type: TABLE DATA; Schema: realtime; Owner: -
--

COPY realtime.messages_2025_12_04 (topic, extension, payload, event, private, updated_at, inserted_at, id) FROM stdin;
\.


--
-- Data for Name: messages_2025_12_05; Type: TABLE DATA; Schema: realtime; Owner: -
--

COPY realtime.messages_2025_12_05 (topic, extension, payload, event, private, updated_at, inserted_at, id) FROM stdin;
\.


--
-- Data for Name: schema_migrations; Type: TABLE DATA; Schema: realtime; Owner: -
--

COPY realtime.schema_migrations (version, inserted_at) FROM stdin;
20211116024918	2025-11-18 07:44:32
20211116045059	2025-11-18 07:44:32
20211116050929	2025-11-18 07:44:32
20211116051442	2025-11-18 07:44:33
20211116212300	2025-11-18 07:44:33
20211116213355	2025-11-18 07:44:33
20211116213934	2025-11-18 07:44:33
20211116214523	2025-11-18 07:44:33
20211122062447	2025-11-18 07:44:33
20211124070109	2025-11-18 07:44:33
20211202204204	2025-11-18 07:44:33
20211202204605	2025-11-18 07:44:33
20211210212804	2025-11-18 07:44:33
20211228014915	2025-11-18 07:44:33
20220107221237	2025-11-18 07:44:33
20220228202821	2025-11-18 07:44:33
20220312004840	2025-11-18 07:44:33
20220603231003	2025-11-18 07:44:33
20220603232444	2025-11-18 07:44:33
20220615214548	2025-11-18 07:44:33
20220712093339	2025-11-18 07:44:33
20220908172859	2025-11-18 07:44:33
20220916233421	2025-11-18 07:44:33
20230119133233	2025-11-18 07:44:33
20230128025114	2025-11-18 07:44:33
20230128025212	2025-11-18 07:44:33
20230227211149	2025-11-18 07:44:33
20230228184745	2025-11-18 07:44:33
20230308225145	2025-11-18 07:44:33
20230328144023	2025-11-18 07:44:33
20231018144023	2025-11-18 07:44:33
20231204144023	2025-11-18 07:44:33
20231204144024	2025-11-18 07:44:33
20231204144025	2025-11-18 07:44:33
20240108234812	2025-11-18 07:44:33
20240109165339	2025-11-18 07:44:33
20240227174441	2025-11-18 07:44:33
20240311171622	2025-11-18 07:44:33
20240321100241	2025-11-18 07:44:33
20240401105812	2025-11-18 07:44:33
20240418121054	2025-11-18 07:44:33
20240523004032	2025-11-18 07:44:33
20240618124746	2025-11-18 07:44:33
20240801235015	2025-11-18 07:44:33
20240805133720	2025-11-18 07:44:33
20240827160934	2025-11-18 07:44:33
20240919163303	2025-11-18 07:44:33
20240919163305	2025-11-18 07:44:33
20241019105805	2025-11-18 07:44:33
20241030150047	2025-11-18 07:44:33
20241108114728	2025-11-18 07:44:33
20241121104152	2025-11-18 07:44:33
20241130184212	2025-11-18 07:44:33
20241220035512	2025-11-18 07:44:33
20241220123912	2025-11-18 07:44:33
20241224161212	2025-11-18 07:44:33
20250107150512	2025-11-18 07:44:33
20250110162412	2025-11-18 07:44:33
20250123174212	2025-11-18 07:44:33
20250128220012	2025-11-18 07:44:33
20250506224012	2025-11-18 07:44:33
20250523164012	2025-11-18 07:44:33
20250714121412	2025-11-18 07:44:33
20250905041441	2025-11-18 07:44:33
20251103001201	2025-11-18 07:44:33
\.


--
-- Data for Name: subscription; Type: TABLE DATA; Schema: realtime; Owner: -
--

COPY realtime.subscription (id, subscription_id, entity, filters, claims, created_at) FROM stdin;
\.


--
-- Data for Name: buckets; Type: TABLE DATA; Schema: storage; Owner: -
--

COPY storage.buckets (id, name, owner, created_at, updated_at, public, avif_autodetection, file_size_limit, allowed_mime_types, owner_id, type) FROM stdin;
\.


--
-- Data for Name: buckets_analytics; Type: TABLE DATA; Schema: storage; Owner: -
--

COPY storage.buckets_analytics (name, type, format, created_at, updated_at, id, deleted_at) FROM stdin;
\.


--
-- Data for Name: buckets_vectors; Type: TABLE DATA; Schema: storage; Owner: -
--

COPY storage.buckets_vectors (id, type, created_at, updated_at) FROM stdin;
\.


--
-- Data for Name: iceberg_namespaces; Type: TABLE DATA; Schema: storage; Owner: -
--

COPY storage.iceberg_namespaces (id, bucket_name, name, created_at, updated_at, metadata, catalog_id) FROM stdin;
\.


--
-- Data for Name: iceberg_tables; Type: TABLE DATA; Schema: storage; Owner: -
--

COPY storage.iceberg_tables (id, namespace_id, bucket_name, name, location, created_at, updated_at, remote_table_id, shard_key, shard_id, catalog_id) FROM stdin;
\.


--
-- Data for Name: migrations; Type: TABLE DATA; Schema: storage; Owner: -
--

COPY storage.migrations (id, name, hash, executed_at) FROM stdin;
0	create-migrations-table	e18db593bcde2aca2a408c4d1100f6abba2195df	2025-11-18 07:44:36.331908
1	initialmigration	6ab16121fbaa08bbd11b712d05f358f9b555d777	2025-11-18 07:44:36.334539
2	storage-schema	5c7968fd083fcea04050c1b7f6253c9771b99011	2025-11-18 07:44:36.335698
3	pathtoken-column	2cb1b0004b817b29d5b0a971af16bafeede4b70d	2025-11-18 07:44:36.344963
4	add-migrations-rls	427c5b63fe1c5937495d9c635c263ee7a5905058	2025-11-18 07:44:36.348211
5	add-size-functions	79e081a1455b63666c1294a440f8ad4b1e6a7f84	2025-11-18 07:44:36.348961
6	change-column-name-in-get-size	f93f62afdf6613ee5e7e815b30d02dc990201044	2025-11-18 07:44:36.350184
7	add-rls-to-buckets	e7e7f86adbc51049f341dfe8d30256c1abca17aa	2025-11-18 07:44:36.351234
8	add-public-to-buckets	fd670db39ed65f9d08b01db09d6202503ca2bab3	2025-11-18 07:44:36.351862
9	fix-search-function	3a0af29f42e35a4d101c259ed955b67e1bee6825	2025-11-18 07:44:36.352596
10	search-files-search-function	68dc14822daad0ffac3746a502234f486182ef6e	2025-11-18 07:44:36.353923
11	add-trigger-to-auto-update-updated_at-column	7425bdb14366d1739fa8a18c83100636d74dcaa2	2025-11-18 07:44:36.35578
12	add-automatic-avif-detection-flag	8e92e1266eb29518b6a4c5313ab8f29dd0d08df9	2025-11-18 07:44:36.357726
13	add-bucket-custom-limits	cce962054138135cd9a8c4bcd531598684b25e7d	2025-11-18 07:44:36.358987
14	use-bytes-for-max-size	941c41b346f9802b411f06f30e972ad4744dad27	2025-11-18 07:44:36.360507
15	add-can-insert-object-function	934146bc38ead475f4ef4b555c524ee5d66799e5	2025-11-18 07:44:36.37461
16	add-version	76debf38d3fd07dcfc747ca49096457d95b1221b	2025-11-18 07:44:36.375934
17	drop-owner-foreign-key	f1cbb288f1b7a4c1eb8c38504b80ae2a0153d101	2025-11-18 07:44:36.376595
18	add_owner_id_column_deprecate_owner	e7a511b379110b08e2f214be852c35414749fe66	2025-11-18 07:44:36.377472
19	alter-default-value-objects-id	02e5e22a78626187e00d173dc45f58fa66a4f043	2025-11-18 07:44:36.378722
20	list-objects-with-delimiter	cd694ae708e51ba82bf012bba00caf4f3b6393b7	2025-11-18 07:44:36.379448
21	s3-multipart-uploads	8c804d4a566c40cd1e4cc5b3725a664a9303657f	2025-11-18 07:44:36.380717
22	s3-multipart-uploads-big-ints	9737dc258d2397953c9953d9b86920b8be0cdb73	2025-11-18 07:44:36.386634
23	optimize-search-function	9d7e604cddc4b56a5422dc68c9313f4a1b6f132c	2025-11-18 07:44:36.392165
24	operation-function	8312e37c2bf9e76bbe841aa5fda889206d2bf8aa	2025-11-18 07:44:36.393384
25	custom-metadata	d974c6057c3db1c1f847afa0e291e6165693b990	2025-11-18 07:44:36.394412
26	objects-prefixes	ef3f7871121cdc47a65308e6702519e853422ae2	2025-11-18 07:44:36.395306
27	search-v2	33b8f2a7ae53105f028e13e9fcda9dc4f356b4a2	2025-11-18 07:44:36.402892
28	object-bucket-name-sorting	ba85ec41b62c6a30a3f136788227ee47f311c436	2025-11-18 07:44:36.404769
29	create-prefixes	a7b1a22c0dc3ab630e3055bfec7ce7d2045c5b7b	2025-11-18 07:44:36.406086
30	update-object-levels	6c6f6cc9430d570f26284a24cf7b210599032db7	2025-11-18 07:44:36.40715
31	objects-level-index	33f1fef7ec7fea08bb892222f4f0f5d79bab5eb8	2025-11-18 07:44:36.407999
32	backward-compatible-index-on-objects	2d51eeb437a96868b36fcdfb1ddefdf13bef1647	2025-11-18 07:44:36.408913
33	backward-compatible-index-on-prefixes	fe473390e1b8c407434c0e470655945b110507bf	2025-11-18 07:44:36.409767
34	optimize-search-function-v1	82b0e469a00e8ebce495e29bfa70a0797f7ebd2c	2025-11-18 07:44:36.410229
35	add-insert-trigger-prefixes	63bb9fd05deb3dc5e9fa66c83e82b152f0caf589	2025-11-18 07:44:36.412195
36	optimise-existing-functions	81cf92eb0c36612865a18016a38496c530443899	2025-11-18 07:44:36.412999
37	add-bucket-name-length-trigger	3944135b4e3e8b22d6d4cbb568fe3b0b51df15c1	2025-11-18 07:44:36.416791
38	iceberg-catalog-flag-on-buckets	19a8bd89d5dfa69af7f222a46c726b7c41e462c5	2025-11-18 07:44:36.418718
39	add-search-v2-sort-support	39cf7d1e6bf515f4b02e41237aba845a7b492853	2025-11-18 07:44:36.427604
40	fix-prefix-race-conditions-optimized	fd02297e1c67df25a9fc110bf8c8a9af7fb06d1f	2025-11-18 07:44:36.428877
41	add-object-level-update-trigger	44c22478bf01744b2129efc480cd2edc9a7d60e9	2025-11-18 07:44:36.432106
42	rollback-prefix-triggers	f2ab4f526ab7f979541082992593938c05ee4b47	2025-11-18 07:44:36.433641
43	fix-object-level	ab837ad8f1c7d00cc0b7310e989a23388ff29fc6	2025-11-18 07:44:36.435366
44	vector-bucket-type	99c20c0ffd52bb1ff1f32fb992f3b351e3ef8fb3	2025-11-18 07:44:36.436431
45	vector-buckets	049e27196d77a7cb76497a85afae669d8b230953	2025-11-18 07:44:36.437852
46	buckets-objects-grants	fedeb96d60fefd8e02ab3ded9fbde05632f84aed	2025-11-18 07:44:36.44397
47	iceberg-table-metadata	649df56855c24d8b36dd4cc1aeb8251aa9ad42c2	2025-11-18 07:44:36.445346
48	iceberg-catalog-ids	2666dff93346e5d04e0a878416be1d5fec345d6f	2025-11-18 07:44:36.447157
\.


--
-- Data for Name: objects; Type: TABLE DATA; Schema: storage; Owner: -
--

COPY storage.objects (id, bucket_id, name, owner, created_at, updated_at, last_accessed_at, metadata, version, owner_id, user_metadata, level) FROM stdin;
\.


--
-- Data for Name: prefixes; Type: TABLE DATA; Schema: storage; Owner: -
--

COPY storage.prefixes (bucket_id, name, created_at, updated_at) FROM stdin;
\.


--
-- Data for Name: s3_multipart_uploads; Type: TABLE DATA; Schema: storage; Owner: -
--

COPY storage.s3_multipart_uploads (id, in_progress_size, upload_signature, bucket_id, key, version, owner_id, created_at, user_metadata) FROM stdin;
\.


--
-- Data for Name: s3_multipart_uploads_parts; Type: TABLE DATA; Schema: storage; Owner: -
--

COPY storage.s3_multipart_uploads_parts (id, upload_id, size, part_number, bucket_id, key, etag, owner_id, version, created_at) FROM stdin;
\.


--
-- Data for Name: vector_indexes; Type: TABLE DATA; Schema: storage; Owner: -
--

COPY storage.vector_indexes (id, name, bucket_id, data_type, dimension, distance_metric, metadata_configuration, created_at, updated_at) FROM stdin;
\.


--
-- Data for Name: hooks; Type: TABLE DATA; Schema: supabase_functions; Owner: -
--

COPY supabase_functions.hooks (id, hook_table_id, hook_name, created_at, request_id) FROM stdin;
\.


--
-- Data for Name: migrations; Type: TABLE DATA; Schema: supabase_functions; Owner: -
--

COPY supabase_functions.migrations (version, inserted_at) FROM stdin;
initial	2025-11-18 07:44:20.993809+00
20210809183423_update_grants	2025-11-18 07:44:20.993809+00
\.


--
-- Data for Name: secrets; Type: TABLE DATA; Schema: vault; Owner: -
--

COPY vault.secrets (id, name, description, secret, key_id, nonce, created_at, updated_at) FROM stdin;
\.


--
-- Name: refresh_tokens_id_seq; Type: SEQUENCE SET; Schema: auth; Owner: -
--

SELECT pg_catalog.setval('auth.refresh_tokens_id_seq', 268, true);


--
-- Name: coze_workflows_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.coze_workflows_id_seq', 30, true);


--
-- Name: experiment_sessions_session_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.experiment_sessions_session_id_seq', 128, true);


--
-- Name: experiments_experiment_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.experiments_experiment_id_seq', 73, true);


--
-- Name: session_evaluations_evaluation_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.session_evaluations_evaluation_id_seq', 20, true);


--
-- Name: task_results_result_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.task_results_result_id_seq', 251, true);


--
-- Name: subscription_id_seq; Type: SEQUENCE SET; Schema: realtime; Owner: -
--

SELECT pg_catalog.setval('realtime.subscription_id_seq', 1, false);


--
-- Name: hooks_id_seq; Type: SEQUENCE SET; Schema: supabase_functions; Owner: -
--

SELECT pg_catalog.setval('supabase_functions.hooks_id_seq', 1, false);


--
-- Name: extensions extensions_pkey; Type: CONSTRAINT; Schema: _realtime; Owner: -
--

ALTER TABLE ONLY _realtime.extensions
    ADD CONSTRAINT extensions_pkey PRIMARY KEY (id);


--
-- Name: schema_migrations schema_migrations_pkey; Type: CONSTRAINT; Schema: _realtime; Owner: -
--

ALTER TABLE ONLY _realtime.schema_migrations
    ADD CONSTRAINT schema_migrations_pkey PRIMARY KEY (version);


--
-- Name: tenants tenants_pkey; Type: CONSTRAINT; Schema: _realtime; Owner: -
--

ALTER TABLE ONLY _realtime.tenants
    ADD CONSTRAINT tenants_pkey PRIMARY KEY (id);


--
-- Name: mfa_amr_claims amr_id_pk; Type: CONSTRAINT; Schema: auth; Owner: -
--

ALTER TABLE ONLY auth.mfa_amr_claims
    ADD CONSTRAINT amr_id_pk PRIMARY KEY (id);


--
-- Name: audit_log_entries audit_log_entries_pkey; Type: CONSTRAINT; Schema: auth; Owner: -
--

ALTER TABLE ONLY auth.audit_log_entries
    ADD CONSTRAINT audit_log_entries_pkey PRIMARY KEY (id);


--
-- Name: flow_state flow_state_pkey; Type: CONSTRAINT; Schema: auth; Owner: -
--

ALTER TABLE ONLY auth.flow_state
    ADD CONSTRAINT flow_state_pkey PRIMARY KEY (id);


--
-- Name: identities identities_pkey; Type: CONSTRAINT; Schema: auth; Owner: -
--

ALTER TABLE ONLY auth.identities
    ADD CONSTRAINT identities_pkey PRIMARY KEY (id);


--
-- Name: identities identities_provider_id_provider_unique; Type: CONSTRAINT; Schema: auth; Owner: -
--

ALTER TABLE ONLY auth.identities
    ADD CONSTRAINT identities_provider_id_provider_unique UNIQUE (provider_id, provider);


--
-- Name: instances instances_pkey; Type: CONSTRAINT; Schema: auth; Owner: -
--

ALTER TABLE ONLY auth.instances
    ADD CONSTRAINT instances_pkey PRIMARY KEY (id);


--
-- Name: mfa_amr_claims mfa_amr_claims_session_id_authentication_method_pkey; Type: CONSTRAINT; Schema: auth; Owner: -
--

ALTER TABLE ONLY auth.mfa_amr_claims
    ADD CONSTRAINT mfa_amr_claims_session_id_authentication_method_pkey UNIQUE (session_id, authentication_method);


--
-- Name: mfa_challenges mfa_challenges_pkey; Type: CONSTRAINT; Schema: auth; Owner: -
--

ALTER TABLE ONLY auth.mfa_challenges
    ADD CONSTRAINT mfa_challenges_pkey PRIMARY KEY (id);


--
-- Name: mfa_factors mfa_factors_last_challenged_at_key; Type: CONSTRAINT; Schema: auth; Owner: -
--

ALTER TABLE ONLY auth.mfa_factors
    ADD CONSTRAINT mfa_factors_last_challenged_at_key UNIQUE (last_challenged_at);


--
-- Name: mfa_factors mfa_factors_pkey; Type: CONSTRAINT; Schema: auth; Owner: -
--

ALTER TABLE ONLY auth.mfa_factors
    ADD CONSTRAINT mfa_factors_pkey PRIMARY KEY (id);


--
-- Name: oauth_authorizations oauth_authorizations_authorization_code_key; Type: CONSTRAINT; Schema: auth; Owner: -
--

ALTER TABLE ONLY auth.oauth_authorizations
    ADD CONSTRAINT oauth_authorizations_authorization_code_key UNIQUE (authorization_code);


--
-- Name: oauth_authorizations oauth_authorizations_authorization_id_key; Type: CONSTRAINT; Schema: auth; Owner: -
--

ALTER TABLE ONLY auth.oauth_authorizations
    ADD CONSTRAINT oauth_authorizations_authorization_id_key UNIQUE (authorization_id);


--
-- Name: oauth_authorizations oauth_authorizations_pkey; Type: CONSTRAINT; Schema: auth; Owner: -
--

ALTER TABLE ONLY auth.oauth_authorizations
    ADD CONSTRAINT oauth_authorizations_pkey PRIMARY KEY (id);


--
-- Name: oauth_clients oauth_clients_pkey; Type: CONSTRAINT; Schema: auth; Owner: -
--

ALTER TABLE ONLY auth.oauth_clients
    ADD CONSTRAINT oauth_clients_pkey PRIMARY KEY (id);


--
-- Name: oauth_consents oauth_consents_pkey; Type: CONSTRAINT; Schema: auth; Owner: -
--

ALTER TABLE ONLY auth.oauth_consents
    ADD CONSTRAINT oauth_consents_pkey PRIMARY KEY (id);


--
-- Name: oauth_consents oauth_consents_user_client_unique; Type: CONSTRAINT; Schema: auth; Owner: -
--

ALTER TABLE ONLY auth.oauth_consents
    ADD CONSTRAINT oauth_consents_user_client_unique UNIQUE (user_id, client_id);


--
-- Name: one_time_tokens one_time_tokens_pkey; Type: CONSTRAINT; Schema: auth; Owner: -
--

ALTER TABLE ONLY auth.one_time_tokens
    ADD CONSTRAINT one_time_tokens_pkey PRIMARY KEY (id);


--
-- Name: refresh_tokens refresh_tokens_pkey; Type: CONSTRAINT; Schema: auth; Owner: -
--

ALTER TABLE ONLY auth.refresh_tokens
    ADD CONSTRAINT refresh_tokens_pkey PRIMARY KEY (id);


--
-- Name: refresh_tokens refresh_tokens_token_unique; Type: CONSTRAINT; Schema: auth; Owner: -
--

ALTER TABLE ONLY auth.refresh_tokens
    ADD CONSTRAINT refresh_tokens_token_unique UNIQUE (token);


--
-- Name: saml_providers saml_providers_entity_id_key; Type: CONSTRAINT; Schema: auth; Owner: -
--

ALTER TABLE ONLY auth.saml_providers
    ADD CONSTRAINT saml_providers_entity_id_key UNIQUE (entity_id);


--
-- Name: saml_providers saml_providers_pkey; Type: CONSTRAINT; Schema: auth; Owner: -
--

ALTER TABLE ONLY auth.saml_providers
    ADD CONSTRAINT saml_providers_pkey PRIMARY KEY (id);


--
-- Name: saml_relay_states saml_relay_states_pkey; Type: CONSTRAINT; Schema: auth; Owner: -
--

ALTER TABLE ONLY auth.saml_relay_states
    ADD CONSTRAINT saml_relay_states_pkey PRIMARY KEY (id);


--
-- Name: schema_migrations schema_migrations_pkey; Type: CONSTRAINT; Schema: auth; Owner: -
--

ALTER TABLE ONLY auth.schema_migrations
    ADD CONSTRAINT schema_migrations_pkey PRIMARY KEY (version);


--
-- Name: sessions sessions_pkey; Type: CONSTRAINT; Schema: auth; Owner: -
--

ALTER TABLE ONLY auth.sessions
    ADD CONSTRAINT sessions_pkey PRIMARY KEY (id);


--
-- Name: sso_domains sso_domains_pkey; Type: CONSTRAINT; Schema: auth; Owner: -
--

ALTER TABLE ONLY auth.sso_domains
    ADD CONSTRAINT sso_domains_pkey PRIMARY KEY (id);


--
-- Name: sso_providers sso_providers_pkey; Type: CONSTRAINT; Schema: auth; Owner: -
--

ALTER TABLE ONLY auth.sso_providers
    ADD CONSTRAINT sso_providers_pkey PRIMARY KEY (id);


--
-- Name: users users_phone_key; Type: CONSTRAINT; Schema: auth; Owner: -
--

ALTER TABLE ONLY auth.users
    ADD CONSTRAINT users_phone_key UNIQUE (phone);


--
-- Name: users users_pkey; Type: CONSTRAINT; Schema: auth; Owner: -
--

ALTER TABLE ONLY auth.users
    ADD CONSTRAINT users_pkey PRIMARY KEY (id);


--
-- Name: coze_workflows coze_workflows_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.coze_workflows
    ADD CONSTRAINT coze_workflows_pkey PRIMARY KEY (id);


--
-- Name: coze_workflows coze_workflows_workflow_id_key; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.coze_workflows
    ADD CONSTRAINT coze_workflows_workflow_id_key UNIQUE (workflow_id);


--
-- Name: experiment_sessions experiment_sessions_experiment_id_participant_id_key; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.experiment_sessions
    ADD CONSTRAINT experiment_sessions_experiment_id_participant_id_key UNIQUE (experiment_id, participant_id);


--
-- Name: experiment_sessions experiment_sessions_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.experiment_sessions
    ADD CONSTRAINT experiment_sessions_pkey PRIMARY KEY (session_id);


--
-- Name: experiments experiments_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.experiments
    ADD CONSTRAINT experiments_pkey PRIMARY KEY (experiment_id);


--
-- Name: profiles profiles_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.profiles
    ADD CONSTRAINT profiles_pkey PRIMARY KEY (id);


--
-- Name: session_evaluations session_evaluations_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.session_evaluations
    ADD CONSTRAINT session_evaluations_pkey PRIMARY KEY (evaluation_id);


--
-- Name: session_evaluations session_evaluations_session_id_key; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.session_evaluations
    ADD CONSTRAINT session_evaluations_session_id_key UNIQUE (session_id);


--
-- Name: task_results task_results_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.task_results
    ADD CONSTRAINT task_results_pkey PRIMARY KEY (result_id);


--
-- Name: messages messages_pkey; Type: CONSTRAINT; Schema: realtime; Owner: -
--

ALTER TABLE ONLY realtime.messages
    ADD CONSTRAINT messages_pkey PRIMARY KEY (id, inserted_at);


--
-- Name: messages_2025_11_29 messages_2025_11_29_pkey; Type: CONSTRAINT; Schema: realtime; Owner: -
--

ALTER TABLE ONLY realtime.messages_2025_11_29
    ADD CONSTRAINT messages_2025_11_29_pkey PRIMARY KEY (id, inserted_at);


--
-- Name: messages_2025_12_01 messages_2025_12_01_pkey; Type: CONSTRAINT; Schema: realtime; Owner: -
--

ALTER TABLE ONLY realtime.messages_2025_12_01
    ADD CONSTRAINT messages_2025_12_01_pkey PRIMARY KEY (id, inserted_at);


--
-- Name: messages_2025_12_02 messages_2025_12_02_pkey; Type: CONSTRAINT; Schema: realtime; Owner: -
--

ALTER TABLE ONLY realtime.messages_2025_12_02
    ADD CONSTRAINT messages_2025_12_02_pkey PRIMARY KEY (id, inserted_at);


--
-- Name: messages_2025_12_03 messages_2025_12_03_pkey; Type: CONSTRAINT; Schema: realtime; Owner: -
--

ALTER TABLE ONLY realtime.messages_2025_12_03
    ADD CONSTRAINT messages_2025_12_03_pkey PRIMARY KEY (id, inserted_at);


--
-- Name: messages_2025_12_04 messages_2025_12_04_pkey; Type: CONSTRAINT; Schema: realtime; Owner: -
--

ALTER TABLE ONLY realtime.messages_2025_12_04
    ADD CONSTRAINT messages_2025_12_04_pkey PRIMARY KEY (id, inserted_at);


--
-- Name: messages_2025_12_05 messages_2025_12_05_pkey; Type: CONSTRAINT; Schema: realtime; Owner: -
--

ALTER TABLE ONLY realtime.messages_2025_12_05
    ADD CONSTRAINT messages_2025_12_05_pkey PRIMARY KEY (id, inserted_at);


--
-- Name: subscription pk_subscription; Type: CONSTRAINT; Schema: realtime; Owner: -
--

ALTER TABLE ONLY realtime.subscription
    ADD CONSTRAINT pk_subscription PRIMARY KEY (id);


--
-- Name: schema_migrations schema_migrations_pkey; Type: CONSTRAINT; Schema: realtime; Owner: -
--

ALTER TABLE ONLY realtime.schema_migrations
    ADD CONSTRAINT schema_migrations_pkey PRIMARY KEY (version);


--
-- Name: buckets_analytics buckets_analytics_pkey; Type: CONSTRAINT; Schema: storage; Owner: -
--

ALTER TABLE ONLY storage.buckets_analytics
    ADD CONSTRAINT buckets_analytics_pkey PRIMARY KEY (id);


--
-- Name: buckets buckets_pkey; Type: CONSTRAINT; Schema: storage; Owner: -
--

ALTER TABLE ONLY storage.buckets
    ADD CONSTRAINT buckets_pkey PRIMARY KEY (id);


--
-- Name: buckets_vectors buckets_vectors_pkey; Type: CONSTRAINT; Schema: storage; Owner: -
--

ALTER TABLE ONLY storage.buckets_vectors
    ADD CONSTRAINT buckets_vectors_pkey PRIMARY KEY (id);


--
-- Name: iceberg_namespaces iceberg_namespaces_pkey; Type: CONSTRAINT; Schema: storage; Owner: -
--

ALTER TABLE ONLY storage.iceberg_namespaces
    ADD CONSTRAINT iceberg_namespaces_pkey PRIMARY KEY (id);


--
-- Name: iceberg_tables iceberg_tables_pkey; Type: CONSTRAINT; Schema: storage; Owner: -
--

ALTER TABLE ONLY storage.iceberg_tables
    ADD CONSTRAINT iceberg_tables_pkey PRIMARY KEY (id);


--
-- Name: migrations migrations_name_key; Type: CONSTRAINT; Schema: storage; Owner: -
--

ALTER TABLE ONLY storage.migrations
    ADD CONSTRAINT migrations_name_key UNIQUE (name);


--
-- Name: migrations migrations_pkey; Type: CONSTRAINT; Schema: storage; Owner: -
--

ALTER TABLE ONLY storage.migrations
    ADD CONSTRAINT migrations_pkey PRIMARY KEY (id);


--
-- Name: objects objects_pkey; Type: CONSTRAINT; Schema: storage; Owner: -
--

ALTER TABLE ONLY storage.objects
    ADD CONSTRAINT objects_pkey PRIMARY KEY (id);


--
-- Name: prefixes prefixes_pkey; Type: CONSTRAINT; Schema: storage; Owner: -
--

ALTER TABLE ONLY storage.prefixes
    ADD CONSTRAINT prefixes_pkey PRIMARY KEY (bucket_id, level, name);


--
-- Name: s3_multipart_uploads_parts s3_multipart_uploads_parts_pkey; Type: CONSTRAINT; Schema: storage; Owner: -
--

ALTER TABLE ONLY storage.s3_multipart_uploads_parts
    ADD CONSTRAINT s3_multipart_uploads_parts_pkey PRIMARY KEY (id);


--
-- Name: s3_multipart_uploads s3_multipart_uploads_pkey; Type: CONSTRAINT; Schema: storage; Owner: -
--

ALTER TABLE ONLY storage.s3_multipart_uploads
    ADD CONSTRAINT s3_multipart_uploads_pkey PRIMARY KEY (id);


--
-- Name: vector_indexes vector_indexes_pkey; Type: CONSTRAINT; Schema: storage; Owner: -
--

ALTER TABLE ONLY storage.vector_indexes
    ADD CONSTRAINT vector_indexes_pkey PRIMARY KEY (id);


--
-- Name: hooks hooks_pkey; Type: CONSTRAINT; Schema: supabase_functions; Owner: -
--

ALTER TABLE ONLY supabase_functions.hooks
    ADD CONSTRAINT hooks_pkey PRIMARY KEY (id);


--
-- Name: migrations migrations_pkey; Type: CONSTRAINT; Schema: supabase_functions; Owner: -
--

ALTER TABLE ONLY supabase_functions.migrations
    ADD CONSTRAINT migrations_pkey PRIMARY KEY (version);


--
-- Name: extensions_tenant_external_id_index; Type: INDEX; Schema: _realtime; Owner: -
--

CREATE INDEX extensions_tenant_external_id_index ON _realtime.extensions USING btree (tenant_external_id);


--
-- Name: extensions_tenant_external_id_type_index; Type: INDEX; Schema: _realtime; Owner: -
--

CREATE UNIQUE INDEX extensions_tenant_external_id_type_index ON _realtime.extensions USING btree (tenant_external_id, type);


--
-- Name: tenants_external_id_index; Type: INDEX; Schema: _realtime; Owner: -
--

CREATE UNIQUE INDEX tenants_external_id_index ON _realtime.tenants USING btree (external_id);


--
-- Name: audit_logs_instance_id_idx; Type: INDEX; Schema: auth; Owner: -
--

CREATE INDEX audit_logs_instance_id_idx ON auth.audit_log_entries USING btree (instance_id);


--
-- Name: confirmation_token_idx; Type: INDEX; Schema: auth; Owner: -
--

CREATE UNIQUE INDEX confirmation_token_idx ON auth.users USING btree (confirmation_token) WHERE ((confirmation_token)::text !~ '^[0-9 ]*$'::text);


--
-- Name: email_change_token_current_idx; Type: INDEX; Schema: auth; Owner: -
--

CREATE UNIQUE INDEX email_change_token_current_idx ON auth.users USING btree (email_change_token_current) WHERE ((email_change_token_current)::text !~ '^[0-9 ]*$'::text);


--
-- Name: email_change_token_new_idx; Type: INDEX; Schema: auth; Owner: -
--

CREATE UNIQUE INDEX email_change_token_new_idx ON auth.users USING btree (email_change_token_new) WHERE ((email_change_token_new)::text !~ '^[0-9 ]*$'::text);


--
-- Name: factor_id_created_at_idx; Type: INDEX; Schema: auth; Owner: -
--

CREATE INDEX factor_id_created_at_idx ON auth.mfa_factors USING btree (user_id, created_at);


--
-- Name: flow_state_created_at_idx; Type: INDEX; Schema: auth; Owner: -
--

CREATE INDEX flow_state_created_at_idx ON auth.flow_state USING btree (created_at DESC);


--
-- Name: identities_email_idx; Type: INDEX; Schema: auth; Owner: -
--

CREATE INDEX identities_email_idx ON auth.identities USING btree (email text_pattern_ops);


--
-- Name: INDEX identities_email_idx; Type: COMMENT; Schema: auth; Owner: -
--

COMMENT ON INDEX auth.identities_email_idx IS 'Auth: Ensures indexed queries on the email column';


--
-- Name: identities_user_id_idx; Type: INDEX; Schema: auth; Owner: -
--

CREATE INDEX identities_user_id_idx ON auth.identities USING btree (user_id);


--
-- Name: idx_auth_code; Type: INDEX; Schema: auth; Owner: -
--

CREATE INDEX idx_auth_code ON auth.flow_state USING btree (auth_code);


--
-- Name: idx_user_id_auth_method; Type: INDEX; Schema: auth; Owner: -
--

CREATE INDEX idx_user_id_auth_method ON auth.flow_state USING btree (user_id, authentication_method);


--
-- Name: mfa_challenge_created_at_idx; Type: INDEX; Schema: auth; Owner: -
--

CREATE INDEX mfa_challenge_created_at_idx ON auth.mfa_challenges USING btree (created_at DESC);


--
-- Name: mfa_factors_user_friendly_name_unique; Type: INDEX; Schema: auth; Owner: -
--

CREATE UNIQUE INDEX mfa_factors_user_friendly_name_unique ON auth.mfa_factors USING btree (friendly_name, user_id) WHERE (TRIM(BOTH FROM friendly_name) <> ''::text);


--
-- Name: mfa_factors_user_id_idx; Type: INDEX; Schema: auth; Owner: -
--

CREATE INDEX mfa_factors_user_id_idx ON auth.mfa_factors USING btree (user_id);


--
-- Name: oauth_auth_pending_exp_idx; Type: INDEX; Schema: auth; Owner: -
--

CREATE INDEX oauth_auth_pending_exp_idx ON auth.oauth_authorizations USING btree (expires_at) WHERE (status = 'pending'::auth.oauth_authorization_status);


--
-- Name: oauth_clients_deleted_at_idx; Type: INDEX; Schema: auth; Owner: -
--

CREATE INDEX oauth_clients_deleted_at_idx ON auth.oauth_clients USING btree (deleted_at);


--
-- Name: oauth_consents_active_client_idx; Type: INDEX; Schema: auth; Owner: -
--

CREATE INDEX oauth_consents_active_client_idx ON auth.oauth_consents USING btree (client_id) WHERE (revoked_at IS NULL);


--
-- Name: oauth_consents_active_user_client_idx; Type: INDEX; Schema: auth; Owner: -
--

CREATE INDEX oauth_consents_active_user_client_idx ON auth.oauth_consents USING btree (user_id, client_id) WHERE (revoked_at IS NULL);


--
-- Name: oauth_consents_user_order_idx; Type: INDEX; Schema: auth; Owner: -
--

CREATE INDEX oauth_consents_user_order_idx ON auth.oauth_consents USING btree (user_id, granted_at DESC);


--
-- Name: one_time_tokens_relates_to_hash_idx; Type: INDEX; Schema: auth; Owner: -
--

CREATE INDEX one_time_tokens_relates_to_hash_idx ON auth.one_time_tokens USING hash (relates_to);


--
-- Name: one_time_tokens_token_hash_hash_idx; Type: INDEX; Schema: auth; Owner: -
--

CREATE INDEX one_time_tokens_token_hash_hash_idx ON auth.one_time_tokens USING hash (token_hash);


--
-- Name: one_time_tokens_user_id_token_type_key; Type: INDEX; Schema: auth; Owner: -
--

CREATE UNIQUE INDEX one_time_tokens_user_id_token_type_key ON auth.one_time_tokens USING btree (user_id, token_type);


--
-- Name: reauthentication_token_idx; Type: INDEX; Schema: auth; Owner: -
--

CREATE UNIQUE INDEX reauthentication_token_idx ON auth.users USING btree (reauthentication_token) WHERE ((reauthentication_token)::text !~ '^[0-9 ]*$'::text);


--
-- Name: recovery_token_idx; Type: INDEX; Schema: auth; Owner: -
--

CREATE UNIQUE INDEX recovery_token_idx ON auth.users USING btree (recovery_token) WHERE ((recovery_token)::text !~ '^[0-9 ]*$'::text);


--
-- Name: refresh_tokens_instance_id_idx; Type: INDEX; Schema: auth; Owner: -
--

CREATE INDEX refresh_tokens_instance_id_idx ON auth.refresh_tokens USING btree (instance_id);


--
-- Name: refresh_tokens_instance_id_user_id_idx; Type: INDEX; Schema: auth; Owner: -
--

CREATE INDEX refresh_tokens_instance_id_user_id_idx ON auth.refresh_tokens USING btree (instance_id, user_id);


--
-- Name: refresh_tokens_parent_idx; Type: INDEX; Schema: auth; Owner: -
--

CREATE INDEX refresh_tokens_parent_idx ON auth.refresh_tokens USING btree (parent);


--
-- Name: refresh_tokens_session_id_revoked_idx; Type: INDEX; Schema: auth; Owner: -
--

CREATE INDEX refresh_tokens_session_id_revoked_idx ON auth.refresh_tokens USING btree (session_id, revoked);


--
-- Name: refresh_tokens_updated_at_idx; Type: INDEX; Schema: auth; Owner: -
--

CREATE INDEX refresh_tokens_updated_at_idx ON auth.refresh_tokens USING btree (updated_at DESC);


--
-- Name: saml_providers_sso_provider_id_idx; Type: INDEX; Schema: auth; Owner: -
--

CREATE INDEX saml_providers_sso_provider_id_idx ON auth.saml_providers USING btree (sso_provider_id);


--
-- Name: saml_relay_states_created_at_idx; Type: INDEX; Schema: auth; Owner: -
--

CREATE INDEX saml_relay_states_created_at_idx ON auth.saml_relay_states USING btree (created_at DESC);


--
-- Name: saml_relay_states_for_email_idx; Type: INDEX; Schema: auth; Owner: -
--

CREATE INDEX saml_relay_states_for_email_idx ON auth.saml_relay_states USING btree (for_email);


--
-- Name: saml_relay_states_sso_provider_id_idx; Type: INDEX; Schema: auth; Owner: -
--

CREATE INDEX saml_relay_states_sso_provider_id_idx ON auth.saml_relay_states USING btree (sso_provider_id);


--
-- Name: sessions_not_after_idx; Type: INDEX; Schema: auth; Owner: -
--

CREATE INDEX sessions_not_after_idx ON auth.sessions USING btree (not_after DESC);


--
-- Name: sessions_oauth_client_id_idx; Type: INDEX; Schema: auth; Owner: -
--

CREATE INDEX sessions_oauth_client_id_idx ON auth.sessions USING btree (oauth_client_id);


--
-- Name: sessions_user_id_idx; Type: INDEX; Schema: auth; Owner: -
--

CREATE INDEX sessions_user_id_idx ON auth.sessions USING btree (user_id);


--
-- Name: sso_domains_domain_idx; Type: INDEX; Schema: auth; Owner: -
--

CREATE UNIQUE INDEX sso_domains_domain_idx ON auth.sso_domains USING btree (lower(domain));


--
-- Name: sso_domains_sso_provider_id_idx; Type: INDEX; Schema: auth; Owner: -
--

CREATE INDEX sso_domains_sso_provider_id_idx ON auth.sso_domains USING btree (sso_provider_id);


--
-- Name: sso_providers_resource_id_idx; Type: INDEX; Schema: auth; Owner: -
--

CREATE UNIQUE INDEX sso_providers_resource_id_idx ON auth.sso_providers USING btree (lower(resource_id));


--
-- Name: sso_providers_resource_id_pattern_idx; Type: INDEX; Schema: auth; Owner: -
--

CREATE INDEX sso_providers_resource_id_pattern_idx ON auth.sso_providers USING btree (resource_id text_pattern_ops);


--
-- Name: unique_phone_factor_per_user; Type: INDEX; Schema: auth; Owner: -
--

CREATE UNIQUE INDEX unique_phone_factor_per_user ON auth.mfa_factors USING btree (user_id, phone);


--
-- Name: user_id_created_at_idx; Type: INDEX; Schema: auth; Owner: -
--

CREATE INDEX user_id_created_at_idx ON auth.sessions USING btree (user_id, created_at);


--
-- Name: users_email_partial_key; Type: INDEX; Schema: auth; Owner: -
--

CREATE UNIQUE INDEX users_email_partial_key ON auth.users USING btree (email) WHERE (is_sso_user = false);


--
-- Name: INDEX users_email_partial_key; Type: COMMENT; Schema: auth; Owner: -
--

COMMENT ON INDEX auth.users_email_partial_key IS 'Auth: A partial unique index that applies only when is_sso_user is false';


--
-- Name: users_instance_id_email_idx; Type: INDEX; Schema: auth; Owner: -
--

CREATE INDEX users_instance_id_email_idx ON auth.users USING btree (instance_id, lower((email)::text));


--
-- Name: users_instance_id_idx; Type: INDEX; Schema: auth; Owner: -
--

CREATE INDEX users_instance_id_idx ON auth.users USING btree (instance_id);


--
-- Name: users_is_anonymous_idx; Type: INDEX; Schema: auth; Owner: -
--

CREATE INDEX users_is_anonymous_idx ON auth.users USING btree (is_anonymous);


--
-- Name: ix_realtime_subscription_entity; Type: INDEX; Schema: realtime; Owner: -
--

CREATE INDEX ix_realtime_subscription_entity ON realtime.subscription USING btree (entity);


--
-- Name: messages_inserted_at_topic_index; Type: INDEX; Schema: realtime; Owner: -
--

CREATE INDEX messages_inserted_at_topic_index ON ONLY realtime.messages USING btree (inserted_at DESC, topic) WHERE ((extension = 'broadcast'::text) AND (private IS TRUE));


--
-- Name: messages_2025_11_29_inserted_at_topic_idx; Type: INDEX; Schema: realtime; Owner: -
--

CREATE INDEX messages_2025_11_29_inserted_at_topic_idx ON realtime.messages_2025_11_29 USING btree (inserted_at DESC, topic) WHERE ((extension = 'broadcast'::text) AND (private IS TRUE));


--
-- Name: messages_2025_12_01_inserted_at_topic_idx; Type: INDEX; Schema: realtime; Owner: -
--

CREATE INDEX messages_2025_12_01_inserted_at_topic_idx ON realtime.messages_2025_12_01 USING btree (inserted_at DESC, topic) WHERE ((extension = 'broadcast'::text) AND (private IS TRUE));


--
-- Name: messages_2025_12_02_inserted_at_topic_idx; Type: INDEX; Schema: realtime; Owner: -
--

CREATE INDEX messages_2025_12_02_inserted_at_topic_idx ON realtime.messages_2025_12_02 USING btree (inserted_at DESC, topic) WHERE ((extension = 'broadcast'::text) AND (private IS TRUE));


--
-- Name: messages_2025_12_03_inserted_at_topic_idx; Type: INDEX; Schema: realtime; Owner: -
--

CREATE INDEX messages_2025_12_03_inserted_at_topic_idx ON realtime.messages_2025_12_03 USING btree (inserted_at DESC, topic) WHERE ((extension = 'broadcast'::text) AND (private IS TRUE));


--
-- Name: messages_2025_12_04_inserted_at_topic_idx; Type: INDEX; Schema: realtime; Owner: -
--

CREATE INDEX messages_2025_12_04_inserted_at_topic_idx ON realtime.messages_2025_12_04 USING btree (inserted_at DESC, topic) WHERE ((extension = 'broadcast'::text) AND (private IS TRUE));


--
-- Name: messages_2025_12_05_inserted_at_topic_idx; Type: INDEX; Schema: realtime; Owner: -
--

CREATE INDEX messages_2025_12_05_inserted_at_topic_idx ON realtime.messages_2025_12_05 USING btree (inserted_at DESC, topic) WHERE ((extension = 'broadcast'::text) AND (private IS TRUE));


--
-- Name: subscription_subscription_id_entity_filters_key; Type: INDEX; Schema: realtime; Owner: -
--

CREATE UNIQUE INDEX subscription_subscription_id_entity_filters_key ON realtime.subscription USING btree (subscription_id, entity, filters);


--
-- Name: bname; Type: INDEX; Schema: storage; Owner: -
--

CREATE UNIQUE INDEX bname ON storage.buckets USING btree (name);


--
-- Name: bucketid_objname; Type: INDEX; Schema: storage; Owner: -
--

CREATE UNIQUE INDEX bucketid_objname ON storage.objects USING btree (bucket_id, name);


--
-- Name: buckets_analytics_unique_name_idx; Type: INDEX; Schema: storage; Owner: -
--

CREATE UNIQUE INDEX buckets_analytics_unique_name_idx ON storage.buckets_analytics USING btree (name) WHERE (deleted_at IS NULL);


--
-- Name: idx_iceberg_namespaces_bucket_id; Type: INDEX; Schema: storage; Owner: -
--

CREATE UNIQUE INDEX idx_iceberg_namespaces_bucket_id ON storage.iceberg_namespaces USING btree (catalog_id, name);


--
-- Name: idx_iceberg_tables_location; Type: INDEX; Schema: storage; Owner: -
--

CREATE UNIQUE INDEX idx_iceberg_tables_location ON storage.iceberg_tables USING btree (location);


--
-- Name: idx_iceberg_tables_namespace_id; Type: INDEX; Schema: storage; Owner: -
--

CREATE UNIQUE INDEX idx_iceberg_tables_namespace_id ON storage.iceberg_tables USING btree (catalog_id, namespace_id, name);


--
-- Name: idx_multipart_uploads_list; Type: INDEX; Schema: storage; Owner: -
--

CREATE INDEX idx_multipart_uploads_list ON storage.s3_multipart_uploads USING btree (bucket_id, key, created_at);


--
-- Name: idx_name_bucket_level_unique; Type: INDEX; Schema: storage; Owner: -
--

CREATE UNIQUE INDEX idx_name_bucket_level_unique ON storage.objects USING btree (name COLLATE "C", bucket_id, level);


--
-- Name: idx_objects_bucket_id_name; Type: INDEX; Schema: storage; Owner: -
--

CREATE INDEX idx_objects_bucket_id_name ON storage.objects USING btree (bucket_id, name COLLATE "C");


--
-- Name: idx_objects_lower_name; Type: INDEX; Schema: storage; Owner: -
--

CREATE INDEX idx_objects_lower_name ON storage.objects USING btree ((path_tokens[level]), lower(name) text_pattern_ops, bucket_id, level);


--
-- Name: idx_prefixes_lower_name; Type: INDEX; Schema: storage; Owner: -
--

CREATE INDEX idx_prefixes_lower_name ON storage.prefixes USING btree (bucket_id, level, ((string_to_array(name, '/'::text))[level]), lower(name) text_pattern_ops);


--
-- Name: name_prefix_search; Type: INDEX; Schema: storage; Owner: -
--

CREATE INDEX name_prefix_search ON storage.objects USING btree (name text_pattern_ops);


--
-- Name: objects_bucket_id_level_idx; Type: INDEX; Schema: storage; Owner: -
--

CREATE UNIQUE INDEX objects_bucket_id_level_idx ON storage.objects USING btree (bucket_id, level, name COLLATE "C");


--
-- Name: vector_indexes_name_bucket_id_idx; Type: INDEX; Schema: storage; Owner: -
--

CREATE UNIQUE INDEX vector_indexes_name_bucket_id_idx ON storage.vector_indexes USING btree (name, bucket_id);


--
-- Name: supabase_functions_hooks_h_table_id_h_name_idx; Type: INDEX; Schema: supabase_functions; Owner: -
--

CREATE INDEX supabase_functions_hooks_h_table_id_h_name_idx ON supabase_functions.hooks USING btree (hook_table_id, hook_name);


--
-- Name: supabase_functions_hooks_request_id_idx; Type: INDEX; Schema: supabase_functions; Owner: -
--

CREATE INDEX supabase_functions_hooks_request_id_idx ON supabase_functions.hooks USING btree (request_id);


--
-- Name: messages_2025_11_29_inserted_at_topic_idx; Type: INDEX ATTACH; Schema: realtime; Owner: -
--

ALTER INDEX realtime.messages_inserted_at_topic_index ATTACH PARTITION realtime.messages_2025_11_29_inserted_at_topic_idx;


--
-- Name: messages_2025_11_29_pkey; Type: INDEX ATTACH; Schema: realtime; Owner: -
--

ALTER INDEX realtime.messages_pkey ATTACH PARTITION realtime.messages_2025_11_29_pkey;


--
-- Name: messages_2025_12_01_inserted_at_topic_idx; Type: INDEX ATTACH; Schema: realtime; Owner: -
--

ALTER INDEX realtime.messages_inserted_at_topic_index ATTACH PARTITION realtime.messages_2025_12_01_inserted_at_topic_idx;


--
-- Name: messages_2025_12_01_pkey; Type: INDEX ATTACH; Schema: realtime; Owner: -
--

ALTER INDEX realtime.messages_pkey ATTACH PARTITION realtime.messages_2025_12_01_pkey;


--
-- Name: messages_2025_12_02_inserted_at_topic_idx; Type: INDEX ATTACH; Schema: realtime; Owner: -
--

ALTER INDEX realtime.messages_inserted_at_topic_index ATTACH PARTITION realtime.messages_2025_12_02_inserted_at_topic_idx;


--
-- Name: messages_2025_12_02_pkey; Type: INDEX ATTACH; Schema: realtime; Owner: -
--

ALTER INDEX realtime.messages_pkey ATTACH PARTITION realtime.messages_2025_12_02_pkey;


--
-- Name: messages_2025_12_03_inserted_at_topic_idx; Type: INDEX ATTACH; Schema: realtime; Owner: -
--

ALTER INDEX realtime.messages_inserted_at_topic_index ATTACH PARTITION realtime.messages_2025_12_03_inserted_at_topic_idx;


--
-- Name: messages_2025_12_03_pkey; Type: INDEX ATTACH; Schema: realtime; Owner: -
--

ALTER INDEX realtime.messages_pkey ATTACH PARTITION realtime.messages_2025_12_03_pkey;


--
-- Name: messages_2025_12_04_inserted_at_topic_idx; Type: INDEX ATTACH; Schema: realtime; Owner: -
--

ALTER INDEX realtime.messages_inserted_at_topic_index ATTACH PARTITION realtime.messages_2025_12_04_inserted_at_topic_idx;


--
-- Name: messages_2025_12_04_pkey; Type: INDEX ATTACH; Schema: realtime; Owner: -
--

ALTER INDEX realtime.messages_pkey ATTACH PARTITION realtime.messages_2025_12_04_pkey;


--
-- Name: messages_2025_12_05_inserted_at_topic_idx; Type: INDEX ATTACH; Schema: realtime; Owner: -
--

ALTER INDEX realtime.messages_inserted_at_topic_index ATTACH PARTITION realtime.messages_2025_12_05_inserted_at_topic_idx;


--
-- Name: messages_2025_12_05_pkey; Type: INDEX ATTACH; Schema: realtime; Owner: -
--

ALTER INDEX realtime.messages_pkey ATTACH PARTITION realtime.messages_2025_12_05_pkey;


--
-- Name: users on_auth_user_created; Type: TRIGGER; Schema: auth; Owner: -
--

CREATE TRIGGER on_auth_user_created AFTER INSERT ON auth.users FOR EACH ROW EXECUTE FUNCTION public.handle_new_user();


--
-- Name: subscription tr_check_filters; Type: TRIGGER; Schema: realtime; Owner: -
--

CREATE TRIGGER tr_check_filters BEFORE INSERT OR UPDATE ON realtime.subscription FOR EACH ROW EXECUTE FUNCTION realtime.subscription_check_filters();


--
-- Name: buckets enforce_bucket_name_length_trigger; Type: TRIGGER; Schema: storage; Owner: -
--

CREATE TRIGGER enforce_bucket_name_length_trigger BEFORE INSERT OR UPDATE OF name ON storage.buckets FOR EACH ROW EXECUTE FUNCTION storage.enforce_bucket_name_length();


--
-- Name: objects objects_delete_delete_prefix; Type: TRIGGER; Schema: storage; Owner: -
--

CREATE TRIGGER objects_delete_delete_prefix AFTER DELETE ON storage.objects FOR EACH ROW EXECUTE FUNCTION storage.delete_prefix_hierarchy_trigger();


--
-- Name: objects objects_insert_create_prefix; Type: TRIGGER; Schema: storage; Owner: -
--

CREATE TRIGGER objects_insert_create_prefix BEFORE INSERT ON storage.objects FOR EACH ROW EXECUTE FUNCTION storage.objects_insert_prefix_trigger();


--
-- Name: objects objects_update_create_prefix; Type: TRIGGER; Schema: storage; Owner: -
--

CREATE TRIGGER objects_update_create_prefix BEFORE UPDATE ON storage.objects FOR EACH ROW WHEN (((new.name <> old.name) OR (new.bucket_id <> old.bucket_id))) EXECUTE FUNCTION storage.objects_update_prefix_trigger();


--
-- Name: prefixes prefixes_create_hierarchy; Type: TRIGGER; Schema: storage; Owner: -
--

CREATE TRIGGER prefixes_create_hierarchy BEFORE INSERT ON storage.prefixes FOR EACH ROW WHEN ((pg_trigger_depth() < 1)) EXECUTE FUNCTION storage.prefixes_insert_trigger();


--
-- Name: prefixes prefixes_delete_hierarchy; Type: TRIGGER; Schema: storage; Owner: -
--

CREATE TRIGGER prefixes_delete_hierarchy AFTER DELETE ON storage.prefixes FOR EACH ROW EXECUTE FUNCTION storage.delete_prefix_hierarchy_trigger();


--
-- Name: objects update_objects_updated_at; Type: TRIGGER; Schema: storage; Owner: -
--

CREATE TRIGGER update_objects_updated_at BEFORE UPDATE ON storage.objects FOR EACH ROW EXECUTE FUNCTION storage.update_updated_at_column();


--
-- Name: extensions extensions_tenant_external_id_fkey; Type: FK CONSTRAINT; Schema: _realtime; Owner: -
--

ALTER TABLE ONLY _realtime.extensions
    ADD CONSTRAINT extensions_tenant_external_id_fkey FOREIGN KEY (tenant_external_id) REFERENCES _realtime.tenants(external_id) ON DELETE CASCADE;


--
-- Name: identities identities_user_id_fkey; Type: FK CONSTRAINT; Schema: auth; Owner: -
--

ALTER TABLE ONLY auth.identities
    ADD CONSTRAINT identities_user_id_fkey FOREIGN KEY (user_id) REFERENCES auth.users(id) ON DELETE CASCADE;


--
-- Name: mfa_amr_claims mfa_amr_claims_session_id_fkey; Type: FK CONSTRAINT; Schema: auth; Owner: -
--

ALTER TABLE ONLY auth.mfa_amr_claims
    ADD CONSTRAINT mfa_amr_claims_session_id_fkey FOREIGN KEY (session_id) REFERENCES auth.sessions(id) ON DELETE CASCADE;


--
-- Name: mfa_challenges mfa_challenges_auth_factor_id_fkey; Type: FK CONSTRAINT; Schema: auth; Owner: -
--

ALTER TABLE ONLY auth.mfa_challenges
    ADD CONSTRAINT mfa_challenges_auth_factor_id_fkey FOREIGN KEY (factor_id) REFERENCES auth.mfa_factors(id) ON DELETE CASCADE;


--
-- Name: mfa_factors mfa_factors_user_id_fkey; Type: FK CONSTRAINT; Schema: auth; Owner: -
--

ALTER TABLE ONLY auth.mfa_factors
    ADD CONSTRAINT mfa_factors_user_id_fkey FOREIGN KEY (user_id) REFERENCES auth.users(id) ON DELETE CASCADE;


--
-- Name: oauth_authorizations oauth_authorizations_client_id_fkey; Type: FK CONSTRAINT; Schema: auth; Owner: -
--

ALTER TABLE ONLY auth.oauth_authorizations
    ADD CONSTRAINT oauth_authorizations_client_id_fkey FOREIGN KEY (client_id) REFERENCES auth.oauth_clients(id) ON DELETE CASCADE;


--
-- Name: oauth_authorizations oauth_authorizations_user_id_fkey; Type: FK CONSTRAINT; Schema: auth; Owner: -
--

ALTER TABLE ONLY auth.oauth_authorizations
    ADD CONSTRAINT oauth_authorizations_user_id_fkey FOREIGN KEY (user_id) REFERENCES auth.users(id) ON DELETE CASCADE;


--
-- Name: oauth_consents oauth_consents_client_id_fkey; Type: FK CONSTRAINT; Schema: auth; Owner: -
--

ALTER TABLE ONLY auth.oauth_consents
    ADD CONSTRAINT oauth_consents_client_id_fkey FOREIGN KEY (client_id) REFERENCES auth.oauth_clients(id) ON DELETE CASCADE;


--
-- Name: oauth_consents oauth_consents_user_id_fkey; Type: FK CONSTRAINT; Schema: auth; Owner: -
--

ALTER TABLE ONLY auth.oauth_consents
    ADD CONSTRAINT oauth_consents_user_id_fkey FOREIGN KEY (user_id) REFERENCES auth.users(id) ON DELETE CASCADE;


--
-- Name: one_time_tokens one_time_tokens_user_id_fkey; Type: FK CONSTRAINT; Schema: auth; Owner: -
--

ALTER TABLE ONLY auth.one_time_tokens
    ADD CONSTRAINT one_time_tokens_user_id_fkey FOREIGN KEY (user_id) REFERENCES auth.users(id) ON DELETE CASCADE;


--
-- Name: refresh_tokens refresh_tokens_session_id_fkey; Type: FK CONSTRAINT; Schema: auth; Owner: -
--

ALTER TABLE ONLY auth.refresh_tokens
    ADD CONSTRAINT refresh_tokens_session_id_fkey FOREIGN KEY (session_id) REFERENCES auth.sessions(id) ON DELETE CASCADE;


--
-- Name: saml_providers saml_providers_sso_provider_id_fkey; Type: FK CONSTRAINT; Schema: auth; Owner: -
--

ALTER TABLE ONLY auth.saml_providers
    ADD CONSTRAINT saml_providers_sso_provider_id_fkey FOREIGN KEY (sso_provider_id) REFERENCES auth.sso_providers(id) ON DELETE CASCADE;


--
-- Name: saml_relay_states saml_relay_states_flow_state_id_fkey; Type: FK CONSTRAINT; Schema: auth; Owner: -
--

ALTER TABLE ONLY auth.saml_relay_states
    ADD CONSTRAINT saml_relay_states_flow_state_id_fkey FOREIGN KEY (flow_state_id) REFERENCES auth.flow_state(id) ON DELETE CASCADE;


--
-- Name: saml_relay_states saml_relay_states_sso_provider_id_fkey; Type: FK CONSTRAINT; Schema: auth; Owner: -
--

ALTER TABLE ONLY auth.saml_relay_states
    ADD CONSTRAINT saml_relay_states_sso_provider_id_fkey FOREIGN KEY (sso_provider_id) REFERENCES auth.sso_providers(id) ON DELETE CASCADE;


--
-- Name: sessions sessions_oauth_client_id_fkey; Type: FK CONSTRAINT; Schema: auth; Owner: -
--

ALTER TABLE ONLY auth.sessions
    ADD CONSTRAINT sessions_oauth_client_id_fkey FOREIGN KEY (oauth_client_id) REFERENCES auth.oauth_clients(id) ON DELETE CASCADE;


--
-- Name: sessions sessions_user_id_fkey; Type: FK CONSTRAINT; Schema: auth; Owner: -
--

ALTER TABLE ONLY auth.sessions
    ADD CONSTRAINT sessions_user_id_fkey FOREIGN KEY (user_id) REFERENCES auth.users(id) ON DELETE CASCADE;


--
-- Name: sso_domains sso_domains_sso_provider_id_fkey; Type: FK CONSTRAINT; Schema: auth; Owner: -
--

ALTER TABLE ONLY auth.sso_domains
    ADD CONSTRAINT sso_domains_sso_provider_id_fkey FOREIGN KEY (sso_provider_id) REFERENCES auth.sso_providers(id) ON DELETE CASCADE;


--
-- Name: coze_workflows coze_workflows_owner_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.coze_workflows
    ADD CONSTRAINT coze_workflows_owner_id_fkey FOREIGN KEY (owner_id) REFERENCES auth.users(id);


--
-- Name: experiment_sessions experiment_sessions_experiment_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.experiment_sessions
    ADD CONSTRAINT experiment_sessions_experiment_id_fkey FOREIGN KEY (experiment_id) REFERENCES public.experiments(experiment_id) ON DELETE CASCADE;


--
-- Name: experiment_sessions experiment_sessions_participant_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.experiment_sessions
    ADD CONSTRAINT experiment_sessions_participant_id_fkey FOREIGN KEY (participant_id) REFERENCES auth.users(id) ON DELETE CASCADE;


--
-- Name: experiments experiments_researcher_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.experiments
    ADD CONSTRAINT experiments_researcher_id_fkey FOREIGN KEY (researcher_id) REFERENCES public.profiles(id) ON DELETE CASCADE;


--
-- Name: profiles profiles_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.profiles
    ADD CONSTRAINT profiles_id_fkey FOREIGN KEY (id) REFERENCES auth.users(id) ON DELETE CASCADE;


--
-- Name: session_evaluations session_evaluations_evaluator_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.session_evaluations
    ADD CONSTRAINT session_evaluations_evaluator_id_fkey FOREIGN KEY (evaluator_id) REFERENCES auth.users(id);


--
-- Name: session_evaluations session_evaluations_experiment_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.session_evaluations
    ADD CONSTRAINT session_evaluations_experiment_id_fkey FOREIGN KEY (experiment_id) REFERENCES public.experiments(experiment_id) ON DELETE CASCADE;


--
-- Name: session_evaluations session_evaluations_session_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.session_evaluations
    ADD CONSTRAINT session_evaluations_session_id_fkey FOREIGN KEY (session_id) REFERENCES public.experiment_sessions(session_id) ON DELETE CASCADE;


--
-- Name: task_results task_results_session_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.task_results
    ADD CONSTRAINT task_results_session_id_fkey FOREIGN KEY (session_id) REFERENCES public.experiment_sessions(session_id) ON DELETE CASCADE;


--
-- Name: iceberg_namespaces iceberg_namespaces_catalog_id_fkey; Type: FK CONSTRAINT; Schema: storage; Owner: -
--

ALTER TABLE ONLY storage.iceberg_namespaces
    ADD CONSTRAINT iceberg_namespaces_catalog_id_fkey FOREIGN KEY (catalog_id) REFERENCES storage.buckets_analytics(id) ON DELETE CASCADE;


--
-- Name: iceberg_tables iceberg_tables_catalog_id_fkey; Type: FK CONSTRAINT; Schema: storage; Owner: -
--

ALTER TABLE ONLY storage.iceberg_tables
    ADD CONSTRAINT iceberg_tables_catalog_id_fkey FOREIGN KEY (catalog_id) REFERENCES storage.buckets_analytics(id) ON DELETE CASCADE;


--
-- Name: iceberg_tables iceberg_tables_namespace_id_fkey; Type: FK CONSTRAINT; Schema: storage; Owner: -
--

ALTER TABLE ONLY storage.iceberg_tables
    ADD CONSTRAINT iceberg_tables_namespace_id_fkey FOREIGN KEY (namespace_id) REFERENCES storage.iceberg_namespaces(id) ON DELETE CASCADE;


--
-- Name: objects objects_bucketId_fkey; Type: FK CONSTRAINT; Schema: storage; Owner: -
--

ALTER TABLE ONLY storage.objects
    ADD CONSTRAINT "objects_bucketId_fkey" FOREIGN KEY (bucket_id) REFERENCES storage.buckets(id);


--
-- Name: prefixes prefixes_bucketId_fkey; Type: FK CONSTRAINT; Schema: storage; Owner: -
--

ALTER TABLE ONLY storage.prefixes
    ADD CONSTRAINT "prefixes_bucketId_fkey" FOREIGN KEY (bucket_id) REFERENCES storage.buckets(id);


--
-- Name: s3_multipart_uploads s3_multipart_uploads_bucket_id_fkey; Type: FK CONSTRAINT; Schema: storage; Owner: -
--

ALTER TABLE ONLY storage.s3_multipart_uploads
    ADD CONSTRAINT s3_multipart_uploads_bucket_id_fkey FOREIGN KEY (bucket_id) REFERENCES storage.buckets(id);


--
-- Name: s3_multipart_uploads_parts s3_multipart_uploads_parts_bucket_id_fkey; Type: FK CONSTRAINT; Schema: storage; Owner: -
--

ALTER TABLE ONLY storage.s3_multipart_uploads_parts
    ADD CONSTRAINT s3_multipart_uploads_parts_bucket_id_fkey FOREIGN KEY (bucket_id) REFERENCES storage.buckets(id);


--
-- Name: s3_multipart_uploads_parts s3_multipart_uploads_parts_upload_id_fkey; Type: FK CONSTRAINT; Schema: storage; Owner: -
--

ALTER TABLE ONLY storage.s3_multipart_uploads_parts
    ADD CONSTRAINT s3_multipart_uploads_parts_upload_id_fkey FOREIGN KEY (upload_id) REFERENCES storage.s3_multipart_uploads(id) ON DELETE CASCADE;


--
-- Name: vector_indexes vector_indexes_bucket_id_fkey; Type: FK CONSTRAINT; Schema: storage; Owner: -
--

ALTER TABLE ONLY storage.vector_indexes
    ADD CONSTRAINT vector_indexes_bucket_id_fkey FOREIGN KEY (bucket_id) REFERENCES storage.buckets_vectors(id);


--
-- Name: audit_log_entries; Type: ROW SECURITY; Schema: auth; Owner: -
--

ALTER TABLE auth.audit_log_entries ENABLE ROW LEVEL SECURITY;

--
-- Name: flow_state; Type: ROW SECURITY; Schema: auth; Owner: -
--

ALTER TABLE auth.flow_state ENABLE ROW LEVEL SECURITY;

--
-- Name: identities; Type: ROW SECURITY; Schema: auth; Owner: -
--

ALTER TABLE auth.identities ENABLE ROW LEVEL SECURITY;

--
-- Name: instances; Type: ROW SECURITY; Schema: auth; Owner: -
--

ALTER TABLE auth.instances ENABLE ROW LEVEL SECURITY;

--
-- Name: mfa_amr_claims; Type: ROW SECURITY; Schema: auth; Owner: -
--

ALTER TABLE auth.mfa_amr_claims ENABLE ROW LEVEL SECURITY;

--
-- Name: mfa_challenges; Type: ROW SECURITY; Schema: auth; Owner: -
--

ALTER TABLE auth.mfa_challenges ENABLE ROW LEVEL SECURITY;

--
-- Name: mfa_factors; Type: ROW SECURITY; Schema: auth; Owner: -
--

ALTER TABLE auth.mfa_factors ENABLE ROW LEVEL SECURITY;

--
-- Name: one_time_tokens; Type: ROW SECURITY; Schema: auth; Owner: -
--

ALTER TABLE auth.one_time_tokens ENABLE ROW LEVEL SECURITY;

--
-- Name: refresh_tokens; Type: ROW SECURITY; Schema: auth; Owner: -
--

ALTER TABLE auth.refresh_tokens ENABLE ROW LEVEL SECURITY;

--
-- Name: saml_providers; Type: ROW SECURITY; Schema: auth; Owner: -
--

ALTER TABLE auth.saml_providers ENABLE ROW LEVEL SECURITY;

--
-- Name: saml_relay_states; Type: ROW SECURITY; Schema: auth; Owner: -
--

ALTER TABLE auth.saml_relay_states ENABLE ROW LEVEL SECURITY;

--
-- Name: schema_migrations; Type: ROW SECURITY; Schema: auth; Owner: -
--

ALTER TABLE auth.schema_migrations ENABLE ROW LEVEL SECURITY;

--
-- Name: sessions; Type: ROW SECURITY; Schema: auth; Owner: -
--

ALTER TABLE auth.sessions ENABLE ROW LEVEL SECURITY;

--
-- Name: sso_domains; Type: ROW SECURITY; Schema: auth; Owner: -
--

ALTER TABLE auth.sso_domains ENABLE ROW LEVEL SECURITY;

--
-- Name: sso_providers; Type: ROW SECURITY; Schema: auth; Owner: -
--

ALTER TABLE auth.sso_providers ENABLE ROW LEVEL SECURITY;

--
-- Name: users; Type: ROW SECURITY; Schema: auth; Owner: -
--

ALTER TABLE auth.users ENABLE ROW LEVEL SECURITY;

--
-- Name: task_results Allow participants to manage results for their own sessions; Type: POLICY; Schema: public; Owner: -
--

CREATE POLICY "Allow participants to manage results for their own sessions" ON public.task_results USING ((EXISTS ( SELECT 1
   FROM public.experiment_sessions s
  WHERE ((s.session_id = task_results.session_id) AND (s.participant_id = auth.uid())))));


--
-- Name: experiment_sessions Allow researchers to create sessions for their own experiments; Type: POLICY; Schema: public; Owner: -
--

CREATE POLICY "Allow researchers to create sessions for their own experiments" ON public.experiment_sessions FOR INSERT WITH CHECK ((EXISTS ( SELECT 1
   FROM public.experiments e
  WHERE ((e.experiment_id = experiment_sessions.experiment_id) AND (e.researcher_id = auth.uid())))));


--
-- Name: task_results Allow researchers to view results for their experiments; Type: POLICY; Schema: public; Owner: -
--

CREATE POLICY "Allow researchers to view results for their experiments" ON public.task_results FOR SELECT USING ((EXISTS ( SELECT 1
   FROM (public.experiment_sessions s
     JOIN public.experiments e ON ((s.experiment_id = e.experiment_id)))
  WHERE ((s.session_id = task_results.session_id) AND (e.researcher_id = auth.uid())))));


--
-- Name: profiles Allow users to insert their own profile; Type: POLICY; Schema: public; Owner: -
--

CREATE POLICY "Allow users to insert their own profile" ON public.profiles FOR INSERT WITH CHECK ((auth.uid() = id));


--
-- Name: profiles Allow users to view profiles; Type: POLICY; Schema: public; Owner: -
--

CREATE POLICY "Allow users to view profiles" ON public.profiles FOR SELECT TO authenticated USING (((id = auth.uid()) OR (((((auth.jwt() ->> 'user_metadata'::text))::jsonb ->> 'role'::text) = 'researcher'::text) AND (role = 'participant'::text))));


--
-- Name: coze_workflows Create workflows; Type: POLICY; Schema: public; Owner: -
--

CREATE POLICY "Create workflows" ON public.coze_workflows FOR INSERT WITH CHECK ((auth.uid() = owner_id));


--
-- Name: coze_workflows Delete workflows; Type: POLICY; Schema: public; Owner: -
--

CREATE POLICY "Delete workflows" ON public.coze_workflows FOR DELETE USING ((auth.uid() = owner_id));


--
-- Name: task_results Participants can manage results for their sessions; Type: POLICY; Schema: public; Owner: -
--

CREATE POLICY "Participants can manage results for their sessions" ON public.task_results TO authenticated USING ((EXISTS ( SELECT 1
   FROM public.experiment_sessions s
  WHERE ((s.session_id = task_results.session_id) AND (s.participant_id = auth.uid()))))) WITH CHECK ((EXISTS ( SELECT 1
   FROM public.experiment_sessions s
  WHERE ((s.session_id = task_results.session_id) AND (s.participant_id = auth.uid())))));


--
-- Name: experiment_sessions Participants can update their own sessions; Type: POLICY; Schema: public; Owner: -
--

CREATE POLICY "Participants can update their own sessions" ON public.experiment_sessions FOR UPDATE TO authenticated USING ((auth.uid() = participant_id)) WITH CHECK ((auth.uid() = participant_id));


--
-- Name: experiment_sessions Participants can view their own sessions; Type: POLICY; Schema: public; Owner: -
--

CREATE POLICY "Participants can view their own sessions" ON public.experiment_sessions FOR SELECT TO authenticated USING ((auth.uid() = participant_id));


--
-- Name: session_evaluations Participants view their evaluations; Type: POLICY; Schema: public; Owner: -
--

CREATE POLICY "Participants view their evaluations" ON public.session_evaluations FOR SELECT USING (((EXISTS ( SELECT 1
   FROM public.experiment_sessions s
  WHERE ((s.session_id = session_evaluations.session_id) AND (s.participant_id = auth.uid())))) OR (EXISTS ( SELECT 1
   FROM public.experiments e
  WHERE ((e.experiment_id = session_evaluations.experiment_id) AND (e.researcher_id = auth.uid()))))));


--
-- Name: experiments Researchers and assigned participants can view experiments; Type: POLICY; Schema: public; Owner: -
--

CREATE POLICY "Researchers and assigned participants can view experiments" ON public.experiments FOR SELECT TO authenticated USING ((public.is_researcher_for_experiment((experiment_id)::bigint, auth.uid()) OR public.is_participant_in_experiment((experiment_id)::bigint, auth.uid())));


--
-- Name: experiments Researchers can manage their own experiments; Type: POLICY; Schema: public; Owner: -
--

CREATE POLICY "Researchers can manage their own experiments" ON public.experiments USING ((auth.uid() = researcher_id));


--
-- Name: task_results Researchers can view results for their experiments; Type: POLICY; Schema: public; Owner: -
--

CREATE POLICY "Researchers can view results for their experiments" ON public.task_results FOR SELECT TO authenticated USING ((EXISTS ( SELECT 1
   FROM (public.experiment_sessions s
     JOIN public.experiments e ON ((s.experiment_id = e.experiment_id)))
  WHERE ((s.session_id = task_results.session_id) AND (e.researcher_id = auth.uid())))));


--
-- Name: session_evaluations Researchers manage evaluations; Type: POLICY; Schema: public; Owner: -
--

CREATE POLICY "Researchers manage evaluations" ON public.session_evaluations USING ((EXISTS ( SELECT 1
   FROM public.experiments e
  WHERE ((e.experiment_id = session_evaluations.experiment_id) AND (e.researcher_id = auth.uid()))))) WITH CHECK ((EXISTS ( SELECT 1
   FROM public.experiments e
  WHERE ((e.experiment_id = session_evaluations.experiment_id) AND (e.researcher_id = auth.uid())))));


--
-- Name: experiment_sessions Researchers manage sessions for their experiments; Type: POLICY; Schema: public; Owner: -
--

CREATE POLICY "Researchers manage sessions for their experiments" ON public.experiment_sessions TO authenticated USING (public.is_researcher_for_experiment(experiment_id, auth.uid())) WITH CHECK (public.is_researcher_for_experiment(experiment_id, auth.uid()));


--
-- Name: coze_workflows Update workflows; Type: POLICY; Schema: public; Owner: -
--

CREATE POLICY "Update workflows" ON public.coze_workflows FOR UPDATE USING ((auth.uid() = owner_id));


--
-- Name: profiles Users can update their own profile; Type: POLICY; Schema: public; Owner: -
--

CREATE POLICY "Users can update their own profile" ON public.profiles FOR UPDATE USING ((auth.uid() = id));


--
-- Name: profiles Users can view their own profile; Type: POLICY; Schema: public; Owner: -
--

CREATE POLICY "Users can view their own profile" ON public.profiles FOR SELECT USING ((auth.uid() = id));


--
-- Name: coze_workflows View workflows; Type: POLICY; Schema: public; Owner: -
--

CREATE POLICY "View workflows" ON public.coze_workflows FOR SELECT USING (((auth.uid() = owner_id) OR (auth.uid() = ANY (researcher_ids))));


--
-- Name: experiment_sessions; Type: ROW SECURITY; Schema: public; Owner: -
--

ALTER TABLE public.experiment_sessions ENABLE ROW LEVEL SECURITY;

--
-- Name: experiments; Type: ROW SECURITY; Schema: public; Owner: -
--

ALTER TABLE public.experiments ENABLE ROW LEVEL SECURITY;

--
-- Name: profiles; Type: ROW SECURITY; Schema: public; Owner: -
--

ALTER TABLE public.profiles ENABLE ROW LEVEL SECURITY;

--
-- Name: session_evaluations; Type: ROW SECURITY; Schema: public; Owner: -
--

ALTER TABLE public.session_evaluations ENABLE ROW LEVEL SECURITY;

--
-- Name: task_results; Type: ROW SECURITY; Schema: public; Owner: -
--

ALTER TABLE public.task_results ENABLE ROW LEVEL SECURITY;

--
-- Name: messages; Type: ROW SECURITY; Schema: realtime; Owner: -
--

ALTER TABLE realtime.messages ENABLE ROW LEVEL SECURITY;

--
-- Name: buckets; Type: ROW SECURITY; Schema: storage; Owner: -
--

ALTER TABLE storage.buckets ENABLE ROW LEVEL SECURITY;

--
-- Name: buckets_analytics; Type: ROW SECURITY; Schema: storage; Owner: -
--

ALTER TABLE storage.buckets_analytics ENABLE ROW LEVEL SECURITY;

--
-- Name: buckets_vectors; Type: ROW SECURITY; Schema: storage; Owner: -
--

ALTER TABLE storage.buckets_vectors ENABLE ROW LEVEL SECURITY;

--
-- Name: iceberg_namespaces; Type: ROW SECURITY; Schema: storage; Owner: -
--

ALTER TABLE storage.iceberg_namespaces ENABLE ROW LEVEL SECURITY;

--
-- Name: iceberg_tables; Type: ROW SECURITY; Schema: storage; Owner: -
--

ALTER TABLE storage.iceberg_tables ENABLE ROW LEVEL SECURITY;

--
-- Name: migrations; Type: ROW SECURITY; Schema: storage; Owner: -
--

ALTER TABLE storage.migrations ENABLE ROW LEVEL SECURITY;

--
-- Name: objects; Type: ROW SECURITY; Schema: storage; Owner: -
--

ALTER TABLE storage.objects ENABLE ROW LEVEL SECURITY;

--
-- Name: prefixes; Type: ROW SECURITY; Schema: storage; Owner: -
--

ALTER TABLE storage.prefixes ENABLE ROW LEVEL SECURITY;

--
-- Name: s3_multipart_uploads; Type: ROW SECURITY; Schema: storage; Owner: -
--

ALTER TABLE storage.s3_multipart_uploads ENABLE ROW LEVEL SECURITY;

--
-- Name: s3_multipart_uploads_parts; Type: ROW SECURITY; Schema: storage; Owner: -
--

ALTER TABLE storage.s3_multipart_uploads_parts ENABLE ROW LEVEL SECURITY;

--
-- Name: vector_indexes; Type: ROW SECURITY; Schema: storage; Owner: -
--

ALTER TABLE storage.vector_indexes ENABLE ROW LEVEL SECURITY;

--
-- Name: supabase_realtime; Type: PUBLICATION; Schema: -; Owner: -
--

CREATE PUBLICATION supabase_realtime WITH (publish = 'insert, update, delete, truncate');


--
-- Name: issue_graphql_placeholder; Type: EVENT TRIGGER; Schema: -; Owner: -
--

CREATE EVENT TRIGGER issue_graphql_placeholder ON sql_drop
         WHEN TAG IN ('DROP EXTENSION')
   EXECUTE FUNCTION extensions.set_graphql_placeholder();


--
-- Name: issue_pg_cron_access; Type: EVENT TRIGGER; Schema: -; Owner: -
--

CREATE EVENT TRIGGER issue_pg_cron_access ON ddl_command_end
         WHEN TAG IN ('CREATE EXTENSION')
   EXECUTE FUNCTION extensions.grant_pg_cron_access();


--
-- Name: issue_pg_graphql_access; Type: EVENT TRIGGER; Schema: -; Owner: -
--

CREATE EVENT TRIGGER issue_pg_graphql_access ON ddl_command_end
         WHEN TAG IN ('CREATE FUNCTION')
   EXECUTE FUNCTION extensions.grant_pg_graphql_access();


--
-- Name: issue_pg_net_access; Type: EVENT TRIGGER; Schema: -; Owner: -
--

CREATE EVENT TRIGGER issue_pg_net_access ON ddl_command_end
         WHEN TAG IN ('CREATE EXTENSION')
   EXECUTE FUNCTION extensions.grant_pg_net_access();


--
-- Name: pgrst_ddl_watch; Type: EVENT TRIGGER; Schema: -; Owner: -
--

CREATE EVENT TRIGGER pgrst_ddl_watch ON ddl_command_end
   EXECUTE FUNCTION extensions.pgrst_ddl_watch();


--
-- Name: pgrst_drop_watch; Type: EVENT TRIGGER; Schema: -; Owner: -
--

CREATE EVENT TRIGGER pgrst_drop_watch ON sql_drop
   EXECUTE FUNCTION extensions.pgrst_drop_watch();


--
-- PostgreSQL database dump complete
--


