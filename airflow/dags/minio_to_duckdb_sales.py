from airflow import DAG
from airflow.operators.python import PythonOperator
from datetime import datetime
import duckdb
import pandas as pd
import boto3
from io import BytesIO

def load_sales_from_minio():
    s3 = boto3.client(
        's3',
        endpoint_url='http://host.docker.internal:9000',
        aws_access_key_id='minioadmin',
        aws_secret_access_key='minioadmin',
    )
    obj = s3.get_object(Bucket='grocery', Key='raw_sales.csv')
    df = pd.read_csv(BytesIO(obj['Body'].read()))

    con = duckdb.connect('/opt/airflow/db/grocery_sales.duckdb')
    print("🧩 DuckDB Path:", con.execute("PRAGMA database_list;").fetchall())
    con.execute("DROP TABLE IF EXISTS raw_sales")
    con.execute("CREATE TABLE raw_sales AS SELECT * FROM df")
    con.close()

with DAG(
    dag_id='minio_to_duckdb_sales',
    start_date=datetime(2024, 1, 1),
    schedule_interval=None,
    catchup=False,

    tags=['etl'],
) as dag:
    task_load_sales = PythonOperator(
        task_id='load_sales_from_minio',
        python_callable=load_sales_from_minio,
    )
