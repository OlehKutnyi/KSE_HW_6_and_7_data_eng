from airflow import DAG
from airflow.operators.bash import BashOperator
from datetime import datetime

# Шлях до dbt-проєкту всередині контейнера (це важливо!)
DBT_PROJECT_DIR = "/opt/dbt_project"


default_args = {
    "start_date": datetime(2024, 1, 1),
}

with DAG(
    dag_id="run_dbt_build",
    default_args=default_args,
    schedule_interval=None,
    catchup=False,
    tags=["dbt", "build"],
) as dag:

    dbt_build = BashOperator(
        task_id="dbt_build",
        bash_command=f"cd {DBT_PROJECT_DIR} && dbt build",
    )

    dbt_build
