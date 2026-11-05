#!/usr/bin/env bash
# backup_postgres.sh — pg_dump to custom archive (.dump) with retention cleanup
set -euo pipefail
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
source "${SCRIPT_DIR}/../../.env" 2>/dev/null || true
export PGPASSWORD="${DB_PASSWORD:-myfridge_secure_password_2026}"
BACKUP_DIR="${SCRIPT_DIR}/backups"
TIMESTAMP="$(date +%Y%m%d_%H%M%S)"
BACKUP_FILE="${BACKUP_DIR}/myfridge_${DB_NAME:-myfridge_db}_${TIMESTAMP}.dump"
RETENTION_DAYS="${BACKUP_RETENTION_DAYS:-7}"
mkdir -p "${BACKUP_DIR}"
pg_dump --host="${DB_HOST:-localhost}" --port="${DB_PORT:-5432}" \
        --username="${DB_USER:-myfridge_user}" --dbname="${DB_NAME:-myfridge_db}" \
        --format=custom --blobs --verbose --file="${BACKUP_FILE}"
echo "Backup OK: ${BACKUP_FILE} ($(du -h "${BACKUP_FILE}" | cut -f1))"
find "${BACKUP_DIR}" -name "*.dump" -type f -mtime +"${RETENTION_DAYS}" -exec rm -vf {} \;
