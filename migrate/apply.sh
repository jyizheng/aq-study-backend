
cat full_backup.sql | docker compose exec -T db psql -U supabase_admin -d postgres

