#!/bin/bash
# setup_airflow.sh

# Create airflow/.env file
echo "Creating .env file..."
cat > $(pwd)/airflow/.env << EOF
AIRFLOW_UID=$(id -u)
_AIRFLOW_WWW_USER_USERNAME=airflow
_AIRFLOW_WWW_USER_PASSWORD=airflow
AIRFLOW__CORE__LOAD_EXAMPLES=false
DATASET_DIR=$(pwd)/dataset
EOF