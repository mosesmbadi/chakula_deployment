#!/bin/bash
# Creates the AquaCheck LIMS role and database. Runs once, when the postgres data
# volume is first initialised. To add another app later on an existing volume, run the
# same SQL by hand: docker exec -it postgres psql -U "$POSTGRES_USER" -d postgres
set -euo pipefail

psql -v ON_ERROR_STOP=1 \
  --username "$POSTGRES_USER" --dbname "$POSTGRES_DB" \
  -v app_password="$AQUACHECK_DB_PASSWORD" <<'SQL'
CREATE ROLE aquacheck LOGIN PASSWORD :'app_password';
CREATE DATABASE aquacheck OWNER aquacheck;
REVOKE ALL ON DATABASE aquacheck FROM PUBLIC;
SQL
