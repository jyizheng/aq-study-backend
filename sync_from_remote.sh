#!/bin/bash
set -e # 遇到错误立即退出

# ================= 配置区域 =================

# 远程服务器 SSH 配置
REMOTE_HOST="122.225.39.134"
REMOTE_PORT="2222"
REMOTE_USER="yizheng"

# 本地 Supabase 配置
LOCAL_PG_USER="supabase_admin"
LOCAL_PG_DB="postgres"

# 临时 dump 文件
DUMP_FILE="/tmp/supabase_remote_dump.sql"

# ===========================================

# 颜色输出
GREEN='\033[0;32m'
RED='\033[0;31m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

cleanup() {
    echo -e "${YELLOW}>>> Cleaning up...${NC}"
    # 删除临时文件
    rm -f $DUMP_FILE
}
trap cleanup EXIT

echo -e "${YELLOW}===============================================${NC}"
echo -e "${YELLOW}  Sync Supabase from Remote Server${NC}"
echo -e "${YELLOW}  Remote: $REMOTE_USER@$REMOTE_HOST:$REMOTE_PORT${NC}"
echo -e "${YELLOW}===============================================${NC}"

# Step 1: 测试远程连接
echo -e "${YELLOW}>>> [Step 1] Testing remote connection...${NC}"
if ! ssh -p $REMOTE_PORT $REMOTE_USER@$REMOTE_HOST "docker exec supabase-db psql -U postgres -c '\q'" 2>/dev/null; then
    echo -e "${RED}Error: Cannot connect to remote Supabase${NC}"
    echo "Please check:"
    echo "  1. SSH connection to $REMOTE_USER@$REMOTE_HOST:$REMOTE_PORT"
    echo "  2. Remote supabase-db container is running"
    exit 1
fi
echo -e "${GREEN}Remote connection OK.${NC}"

# Step 2: 测试本地连接
echo -e "${YELLOW}>>> [Step 2] Testing local connection...${NC}"
if ! docker exec supabase-db psql -U $LOCAL_PG_USER -d $LOCAL_PG_DB -c "\q" 2>/dev/null; then
    echo -e "${RED}Error: Cannot connect to local Supabase${NC}"
    echo "Please check if local Supabase is running: docker compose ps"
    exit 1
fi
echo -e "${GREEN}Local connection OK.${NC}"

# 确认操作
echo ""
echo -e "${YELLOW}WARNING: This will OVERWRITE data in local Supabase!${NC}"
read -p "Are you sure you want to continue? (y/N) " -n 1 -r < /dev/tty
echo
if [[ ! $REPLY =~ ^[Yy]$ ]]; then
    echo "Aborted."
    exit 1
fi

# Step 3: Dump 远程数据库 (通过 SSH + docker exec)
echo -e "${YELLOW}>>> [Step 3] Dumping remote database via SSH...${NC}"

ssh -p $REMOTE_PORT $REMOTE_USER@$REMOTE_HOST "docker exec supabase-db pg_dump \
    -U postgres \
    -d postgres \
    --clean \
    --if-exists \
    --quote-all-identifiers \
    --no-owner \
    --exclude-schema=extensions \
    --exclude-schema=vault \
    --exclude-schema=supabase_functions \
    --exclude-schema=supabase_migrations \
    --exclude-schema=_realtime \
    --exclude-schema=_analytics \
    --exclude-schema=pgbouncer \
    --exclude-schema=pgsodium \
    --exclude-schema=pgsodium_masks \
    --exclude-schema=graphql \
    --exclude-schema=graphql_public" > $DUMP_FILE

DUMP_SIZE=$(du -h $DUMP_FILE | cut -f1)
echo -e "${GREEN}Dump complete. Size: $DUMP_SIZE${NC}"

# Step 4: 导入到本地
echo -e "${YELLOW}>>> [Step 4] Importing to local database...${NC}"
(
    echo "SET session_replication_role = replica;"
    cat $DUMP_FILE
) | docker exec -i supabase-db psql -U $LOCAL_PG_USER -d $LOCAL_PG_DB

echo -e "${GREEN}Import complete.${NC}"

# Step 5: 重置序列
echo -e "${YELLOW}>>> [Step 5] Resetting sequences...${NC}"
docker exec -i supabase-db psql -U $LOCAL_PG_USER -d $LOCAL_PG_DB -t -c "
DO \$\$
DECLARE
    row record;
BEGIN
    FOR row IN 
        SELECT 'SELECT setval(' || quote_literal(n.nspname || '.' || s.relname) || ', COALESCE((SELECT MAX(' || quote_ident(a.attname) || ') FROM ' || quote_ident(n.nspname) || '.' || quote_ident(t.relname) || '), 1), true);' AS sql_cmd
        FROM pg_class s
        JOIN pg_namespace n ON n.oid = s.relnamespace
        JOIN pg_depend d ON d.objid = s.oid
        JOIN pg_class t ON d.refobjid = t.oid
        JOIN pg_attribute a ON a.attrelid = d.refobjid AND a.attnum = d.refobjsubid
        WHERE s.relkind = 'S' AND n.nspname NOT IN ('pg_catalog', 'information_schema', 'extensions')
    LOOP
        BEGIN
            EXECUTE row.sql_cmd;
        EXCEPTION WHEN OTHERS THEN
            -- 忽略错误，继续下一个
            NULL;
        END;
    END LOOP;
END \$\$;
"

echo -e "${GREEN}Sequences reset complete.${NC}"

echo ""
echo -e "${GREEN}===============================================${NC}"
echo -e "${GREEN}  Sync Complete!${NC}"
echo -e "${GREEN}===============================================${NC}"
