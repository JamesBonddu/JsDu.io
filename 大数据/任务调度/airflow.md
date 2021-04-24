https://github.com/jghoman/awesome-apache-airflow

# airflow 安装配置

https://blog.csdn.net/youzi_yun/article/details/90141362

https://cloud.tencent.com/developer/article/1035943

# 使用airflow来做etl


https://gtoonstra.github.io/etl-with-airflow/principles.html


# API文档

https://incubator-airflow.readthedocs.io/en/latest/operators-and-hooks-ref.html

# 工作流对比

https://hackernoon.com/airflow-the-missing-context-1a04b3a9475c

# 数据分析流产品构建步骤

http://blog.paracode.com/2017/10/29/building-market-analysis-products/

https://www.zhihu.com/question/46573431

# airflow实践

https://www.coderbridge.com/series/c012cc1c8f9846359bb9b8940d4c10a8/posts/a4e14b0357ca4c7b987e3c6f3c18cd45

# airflow xcom
https://kiwijia.work/2020/04/06/xcom/


# airflow docker

https://github.com/zer0beat/airflow-for-docker

http://bigbigben.com/2020/03/11/docker-compose-airfow-stockdata/

## airflow 的docker compose 文件

https://github.com/xnuinside/airflow_in_docker_compose

## awsome airflow

https://github.com/jghoman/awesome-apache-airflow/stargazers


## airflow 不需要重启安装外部依赖

https://xnuinside.medium.com/install-python-dependencies-to-docker-compose-cluster-without-re-build-images-8c63a431e11c

## airflow 插件

https://github.com/airflow-plugins

###  airflow-console插件

https://www.cnblogs.com/woshimrf/p/airflow-console.html

https://github.com/Ryan-Miao/airflow-console.git

## airflow 在线编辑器

https://github.com/andreax79/airflow-code-editor

## 通过yaml文件动态加载dag

https://github.com/ajbosco/dag-factory

## airflow维护工具

https://github.com/teamclairvoyant/airflow-maintenance-dags

https://tech.cuixiangbin.com/?p=1380

## airflow providers

http://airflow.apache.org/docs/apache-airflow-providers/


# airflow 生态资源

https://airflow.apache.org/ecosystem/

# airflow 附加功能

http://apache-airflow-docs.s3-website.eu-central-1.amazonaws.com/docs/apache-airflow/latest/extra-packages-ref.html

# airflow日志写入 ES

https://airflow.apache.org/docs/apache-airflow-providers-elasticsearch/stable/logging.html

https://blog.csdn.net/sxf_123456/article/details/80452807


# airflow 插件


clickhouse插件

https://github.com/whisklabs/airflow-clickhouse-plugin

es 插件

https://github.com/Vectoryzed/Apache-Airflow/tree/f0af6eb8d3c2a5626217eb199c1df2e1f9fd4b34/plugins/elasticsearch_plugin

# 序列化设置
 
https://airflow.readthedocs.io/en/1.10.14/dag-serialization.html

```sh

docker-compose run airflow-worker airflow info

# 列出当前providers
root@jinqia-test:/opt/airflow1# airflow providers list
package_name                    | description                                 | version
================================+=============================================+========
apache-airflow-providers-ftp    | File Transfer Protocol (FTP)                | 1.0.1  
                                | https://tools.ietf.org/html/rfc114          |        
apache-airflow-providers-http   | Hypertext Transfer Protocol (HTTP)          | 1.1.1  
                                | https://www.w3.org/Protocols/               |        
apache-airflow-providers-imap   | Internet Message Access Protocol (IMAP)     | 1.0.1  
                                | https://tools.ietf.org/html/rfc3501         |        
apache-airflow-providers-sqlite | SQLite https://www.sqlite.org/              | 1.0.2  
                                                                                       
root@jinqia-test:/opt/airflow1# 

```


# airflow 数仓持续发布

https://blog.csdn.net/Young2018/article/details/109230482


https://www.astronomer.io/blog/7-common-errors-to-check-when-debugging-airflow-dag

# airflow 共享变量和数据



dags公用函数和配置的方式

https://stackoverflow.com/questions/58402733/how-to-use-common-script-in-diferent-dags

怎么使用模板和宏

https://www.youtube.com/channel/UCeuN3wTm-15myt26ZS21P_Q

https://marclamberti.com/blog/variables-with-apache-airflow/

https://marclamberti.com/blog/templates-macros-apache-airflow/


通过Xcom获取配置文件 airflow intermediary data storage

https://stackoverflow.com/questions/48755948/sharing-large-intermediate-state-between-airflow-tasks


https://softwareengineering.stackexchange.com/questions/399477/best-practice-for-sharing-code-and-data-between-airflow-worker-nodes

https://marclamberti.com/blog/airflow-xcom/


xcom获取

https://marclamberti.com/blog/airflow-xcom/


https://precocityllc.com/blog/airflow-and-xcom-inter-task-communication-use-cases/

# 获取http response

https://airflow.apache.org/docs/apache-airflow-providers-http/stable/operators.html

https://stackoverflow.com/questions/46676449/how-to-access-the-response-from-airflow-simplehttpoperator-get-request

# ariflow 调试

https://stackoverflow.com/questions/58931845/debugging-airflow-tasks-with-ide-tools

https://michal.karzynski.pl/blog/2017/03/19/developing-workflows-with-apache-airflow/