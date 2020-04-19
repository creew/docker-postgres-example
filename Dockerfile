FROM	postgres:12.2
COPY	00_init.sh /docker-entrypoint-initdb.d/
COPY	01_create_tables_in_service_db.sh /docker-entrypoint-initdb.d/
COPY	02_create_tables_in_bank_db.sh /docker-entrypoint-initdb.d/
