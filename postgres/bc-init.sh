#!/bin/bash
set -e

psql -v ON_ERROR_STOP=1 --username "$POSTGRES_USER" --dbname "$POSTGRES_DB" <<-EOSQL
	CREATE DATABASE bc;
	GRANT ALL PRIVILEGES ON DATABASE bc TO postgres;
	CREATE DATABASE ev;
	GRANT ALL PRIVILEGES ON DATABASE ev TO postgres;

EOSQL