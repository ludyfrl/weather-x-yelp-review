from airflow import DAG
from airflow.decorators import task
from airflow.providers.postgres.hooks.postgres import PostgresHook
from datetime import datetime, timedelta

default_args = {
    'owner': 'Ludy',
    'retries': 1,
    'retry_delay': timedelta(minutes=5),
}

with DAG(
    'staging.raw_yelp_review',
    default_args=default_args,
    description='Ingest Yelp review raw CSV data to DWH',
    schedule=None,
    start_date=datetime(2025, 8, 6),
    catchup=False,
    tags=['ingest', 'csv2postgres', 'staging', 'yelp'],
) as dag:

    @task()
    def ingest_csv_file():
        """Ingest Yelp review data from raw CSV file"""
        import pandas as pd

        postgres_hook = PostgresHook(postgres_conn_id='postgres_dwh')
        engine = postgres_hook.get_sqlalchemy_engine()

        chunk_size = 20000
        filepath = '/opt/dataset/yelp/yelp_academic_dataset_review.csv'
        total_rows = 0
        with pd.read_csv(filepath, sep=";", chunksize=chunk_size, lineterminator="\n") as reader:
            for chunk in reader:
                chunk.to_sql(
                    'raw_yelp_review',
                    engine,
                    schema='staging',
                    if_exists='append',
                    index=False
                )

                total_rows += len(chunk)
                print(f"Processed {total_rows:,} rows...")
    
    ingest_csv_file()
