# Airflow

https://airflow.apachecn.org/#/

## Airflow template


https://airflow.apache.org/macros.html

https://www.astronomer.io/guides/templating/

https://diogoalexandrefranco.github.io/about-airflow-date-macros-ds-and-execution-date/


http://michal.karzynski.pl/blog/2017/03/19/developing-workflows-with-apache-airflow/

## Airflow Celery 

https://medium.com/@xnuinside/quick-tutorial-apache-airflow-with-3-celery-workers-in-docker-composer-9f2f3b445e4


http://yangcongchufang.com/airflow/airflow-with-docker.html

# Docker Airflow

https://abhioncbr.github.io/docker-airflow/

# ETL Airflow

https://github.com/gtoonstra/etl-with-airflow


# CMD

```sh
airflow list_dags

example_bash_operator
example_branch_dop_operator_v3
example_branch_operator
example_complex
example_external_task_marker_child
example_external_task_marker_parent
example_http_operator
example_passing_params_via_test_command
example_pig_operator
example_python_operator
example_short_circuit_operator
example_skip_dag
example_trigger_controller_dag
example_trigger_target_dag
example_xcom
latest_only
latest_only_with_trigger
test_utils
tutorial
```


# 同时定义多个查询query

https://stackoverflow.com/questions/49620202/airflow-how-to-run-same-query-on-multiple-databases


并行dag查询

https://stackoverflow.com/questions/52741536/running-airflow-tasks-dags-in-parallel


pandas 插入mysql
df.to_sql(con=con, name='table_name_for_df', if_exists='replace', flavor='mysql')

https://stackoverflow.com/questions/16476413/how-to-insert-pandas-dataframe-via-mysqldb-into-database


设计airflow的工作流

https://dwtobigdata.wordpress.com/2016/01/14/designing-workflow-with-airflow/

https://zhuanlan.zhihu.com/p/20601020


## airflow的变量和执行器

https://ttxsgoto.github.io/2019/07/27/yw-airflow-operator/