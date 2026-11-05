#!/usr/bin/env bash
# restore_postgres.sh — pg_restore from custom archive; requires: ./restore.sh <file> [--force]
set -euo pipefail
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
source "${SCRIPT_DIR}/../../.env" 2>/dev/null || true
export PGPASSWORD="${DB_PASSWORD:-myfridge_secure_password_2026}"
BACKUP_FILE="${1:?Usage: $0 <backup.dump> [--force]}"
FORCE="${2:-}"
[ -f "${BACKUP_FILE}" ] || { echo "File not found: ${BACKUP_FILE}"; exit 1; }
if [ "${FORCE}" != "--force" ]; then
    read -r -p "Overwrite ${DB_NAME:-myfridge_db}? [y/N]: " c
    [[ "${c}" =~ ^[yY] ]] || { echo "Aborted."; exit 0; }
fi
psql --host="${DB_HOST:-localhost}" --port="${DB_PORT:-5432}" \
     --username="${DB_USER:-myfridge_user}" --dbname=postgres \
     --command="SELECT pg_terminate_backend(pid) FROM pg_stat_activity WHERE datname='${DB_NAME:-myfridge_db}' AND pid<>pg_backend_pid();" || true
pg_restore --host="${DB_HOST:-localhost}" --port="${DB_PORT:-5432}" \
           --username="${DB_USER:-myfridge_user}" --dbname="${DB_NAME:-myfridge_db}" \
           --clean --if-exists --no-owner --no-privileges --verbose "${BACKUP_FILE}" || true
psql --host="${DB_HOST:-localhost}" --port="${DB_PORT:-5432}" \
     --username="${DB_USER:-myfridge_user}" --dbname="${DB_NAME:-myfridge_db}" \
     --command="SELECT count(*) AS tables FROM information_schema.tables WHERE table_schema='public';"
echo "Restore completed at $(date)."
