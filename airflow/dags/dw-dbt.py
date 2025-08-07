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
    'ods_to_dw',
    default_args=default_args,
    description='Transform all ODS tables to DW tables',
    schedule=None,
    start_date=datetime(2025, 8, 6),
    catchup=False,
    tags=['transform', 'dw', 'yelp', 'weather'],
) as dag:
    
    ods_to_dw = DockerOperator(
        task_id='ods_to_dw',
        image='dbt-transform',
        command='dbt run --select dw',
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

    ods_to_dw
