from airflow import DAG
from airflow.decorators import task
from airflow.providers.docker.operators.docker import DockerOperator
from datetime import datetime, timedelta

default_args = {
    'owner': 'Ludy',
    'retries': 1,
    'retry_delay': timedelta(minutes=5),
}

with DAG(
    'staging_to_ods',
    default_args=default_args,
    description='Transform all staging tables to ODS tables',
    schedule=None,
    start_date=datetime(2025, 8, 6),
    catchup=False,
    tags=['transform', 'ods', 'yelp', 'weather'],
) as dag:
    
    staging_to_ods = DockerOperator(
        task_id='staging_to_ods',
        image='dbt-transform',
        command='dbt run --select models/ods/yelp_review.sql',
        auto_remove='success',
        docker_url='unix://var/run/docker.sock',
        network_mode='airflow_default',
        environment={
            'DBT_PROFILES_DIR': '/usr/app/dbt',
            'DBT_POSTGRES_HOST': 'postgres-dwh',
            'DBT_POSTGRES_PORT': 5432,
            'DBT_POSTGRES_USER': 'data_dwh',
            'DBT_POSTGRES_PASSWORD': 'data_dwh',
            'DBT_POSTGRES_DATABASE': 'data_dwh'
        },
    )

    staging_to_ods
