from airflow import DAG
from airflow.operators.python import PythonOperator
from datetime import datetime
import duckdb
import pandas as pd
import boto3
from io import BytesIO

def load_customers_from_minio():
    s3 = boto3.client(
        's3',
        endpoint_url='http://host.docker.internal:9000',
        aws_access_key_id='minioadmin',
        aws_secret_access_key='minioadmin',
    )

    obj = s3.get_object(Bucket='grocery', Key='raw_customers.csv')
    df = pd.read_csv(BytesIO(obj['Body'].read()))

    print("🧾 Columns:", df.columns.tolist())
    print("📦 Data types:\n", df.dtypes)

    con = duckdb.connect('/opt/airflow/db/grocery_sales.duckdb')
    con.execute("DROP TABLE IF EXISTS raw_customers")
    con.execute("CREATE TABLE raw_customers AS SELECT * FROM df")
    con.close()


with DAG(
    dag_id='minio_to_duckdb',
    start_date=datetime(2024, 1, 1),
    schedule_interval=None,
    catchup=False,
    tags=['etl'],
) as dag:
    task_load_customers = PythonOperator(
        task_id='load_customers_from_minio',
        python_callable=load_customers_from_minio,
    )
