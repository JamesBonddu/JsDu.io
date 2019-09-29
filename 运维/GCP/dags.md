# Airflow DAG

包含DAG定义, 操作器和操作器关系.

```py
import pendulum
from datetime import datetime, timedelta, timezone, tzinfo
from airflow import models
from airflow.operators import bash_operator
from airflow.operators import python_operator

local_tz = pendulum.timezone("Etc/GMT+8")

default_dag_args = {
    # https://airflow.apache.org/faq.html#what-s-the-deal-with-start-date
    'owner': 'JSDu',
    'start_date': datetime(2019, 9, 3),
    'retries': 2,
    'retry_delay': timedelta(minutes=5),
}


def custom_python_operator(task_id, fn):
    return python_operator.PythonOperator(
        task_id=task_id,
        python_callable=fn,
    )

def custom_bash_operator(task_id, cmd):
    return bash_operator.PythonOperator(
        task_id=task_id,
        bash_command=cmd,
    )

# Define a DAG of tasks
with  models.DAG(
    'jsdu_simple_greeting',
    schedule_interval=datetie.timedelta(days=1),
    default_args=default_dag_args) as dag:
    # [END composer_simple_define_dag]
    # [START composer_simple_operators]
    def gretting():
        import logging
        logging.info('Minston, Hi JSDu!')

    # An instance of an operator is called a task.
    hi_python_task = custom_python_operator('Hi', gretting)

    cmd = 'kubectl config current-context'
    bye_bash_task = custom_bash_operator('Kubectl', )
    # [END composer_simple_operators]

    # [START composer_simple_relationships]
    hi_python_task >> bye_bash_task
    # [END composer_simple_relationships]
```

Cloud Composer在工作器的Bash脚本中运行提供的命令. 工作器是一个基于Debian的Docker容器, 其中包含多个软件包:
- gcloud
- bq
- gsutil
- kubctl

包含的python软件包有:
- google-cloud-bigquery
- google-cloud-dataflow
- google-cloud-storage
- pandas
- pandas-gbq
- tensorflow
- tensorflow-trasform


https://cloud.google.com/composer/docs/how-to/using/writing-dags
