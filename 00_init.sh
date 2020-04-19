#!/bin/bash
set -e
psql -v ON_ERROR_STOP=1 --username "$POSTGRES_USER" --dbname "$POSTGRES_DB" <<-EOSQL
    CREATE USER admin WITH PASSWORD 'pass';
    CREATE DATABASE service_db;
    CREATE DATABASE bank_db;
    GRANT ALL PRIVILEGES ON DATABASE service_db TO admin;
    GRANT ALL PRIVILEGES ON DATABASE bank_db TO admin;
EOSQL
