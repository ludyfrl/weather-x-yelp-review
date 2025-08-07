#!/bin/bash
# setup_dbt.sh

# Create .env file
echo "Creating dbt-transform/.env file..."
cat > $(pwd)/dbt-transform/.env << EOF
DBT_POSTGRES_HOST=postgres-dwh
DBT_POSTGRES_PORT=5432
DBT_POSTGRES_USER=data_dwh
DBT_POSTGRES_PASSWORD=data_dwh
DBT_POSTGRES_DATABASE=data_dwh

DBT_PROFILES_DIR=/usr/app/dbt
DBT_PROJECT_DIR=/usr/app/dbt
EOF