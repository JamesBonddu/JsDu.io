# clickhouse

https://clickhouse.tech/docs/en/getting-started/tutorial/


https://www.sohu.com/a/457462190_315839

clickhouse 和ES对比

https://zhuanlan.zhihu.com/p/353296392

https://schnappi618.github.io/2020/03/21/clickhouse/clickhouse%E7%9A%84docker%E6%9E%B6%E6%9E%84/

django + clickhouse

https://github.com/carrotquest/django-clickhouse

# clickhouse实时数据分析平台

https://www.yijiyong.com/dw/clickhouse/03-caseintro.html

https://www.jwldata.com/archives/tag/clickhouse

# clickhouse理念

https://www.sohu.com/a/506676289_355140



# ck 配置文件

```sh
创建数据库和表
create database distributed_db; #所有节点执行
CREATE TABLE distributed_db.local (FlightDate Date,Year UInt16) ENGINE = ReplicatedMergeTree('/clickhouse/distributed_db/local/shard1','1',FlightDate,(Year, FlightDate),8192); #分片1的第1个副本执行
CREATE TABLE distributed_db.local (FlightDate Date,Year UInt16) ENGINE = ReplicatedMergeTree('/clickhouse/distributed_db/local/shard1','2',FlightDate,(Year, FlightDate),8192); #分片1的第2个副本执行
CREATE TABLE distributed_db.local (FlightDate Date,Year UInt16) ENGINE = ReplicatedMergeTree('/clickhouse/distributed_db/local/shard2','1',FlightDate,(Year, FlightDate),8192); #分片2的第1个副本执行
CREATE TABLE distributed_db.local (FlightDate Date,Year UInt16) ENGINE = ReplicatedMergeTree('/clickhouse/distributed_db/local/shard2','2',FlightDate,(Year, FlightDate),8192); #分片2的第2个副本执行
CREATE TABLE distributed_db.dis_all (FlightDate Date,Year UInt16) ENGINE= Distributed(clickhouse_cluster_name, distributed_db, local, rand()); #所有节点执行
```

insert into distributed_db.local (FlightDate,Year)values('2022-1-17',2022);

####说明：local是本地表，存数据的；dis_all是分布式表，不存数据
-----------------------------------
©著作权归作者所有：来自51CTO博客作者feko大魔王的原创作品，请联系作者获取转载授权，否则将追究法律责任
实操，ClickHouse高可用集群部署
https://blog.51cto.com/feko/2738319


https://blog.csdn.net/wulitaotao96/article/details/117927551

https://www.jianshu.com/p/e7c38086eeae

https://mp.weixin.qq.com/s/JR8wamqNd5Bg6e2CnX6orw


https://clickhouse.com/docs/zh/operations/configuration-files/
# clickhouse 集群部署文档

clickhouse 集群部署架构

https://blog.51cto.com/u_15289334/2970972

https://juejin.cn/post/6995053938105909256

https://kelovp.tech/nostring/blog/1712/


## clickhouse 下载安装配置

https://repo.clickhouse.com/rpm/


https://zhuanlan.zhihu.com/p/161242274

https://blog.51cto.com/feko/2738319

## docker版本

https://www.cnblogs.com/EminemJK/p/15138536.html

https://blog.51cto.com/u_14900374/2629096

http://sineyuan.github.io/post/clickhouse-docker-quick-start/


# clickhouse 教程精选

http://www.clickhouse.com.cn/?tab=you

## python clickhouse接口

https://github.com/mymarilyn/clickhouse-driver

https://stackoverflow.com/questions/57778609/issue-connecting-to-dockerized-clickhouse-server-with-python-driver

https://blog.csdn.net/Allan_shore_ma/article/details/107633320


## airflow clickhouse插件

http://www.clickhouse.com.cn/

https://github.com/whisklabs/airflow-clickhouse-plugin

## airflow 使用dataX抽取数据

https://cloud.tencent.com/developer/article/1517121

https://mux.com/blog/from-russia-with-love-how-clickhouse-saved-our-data/

## airflow的ETL

https://gtoonstra.github.io/etl-with-airflow/


# clickhouse 链接方式

使用ck的jdbc的driver, 此时端口是8123

```java
ENGINE = JDBC('jdbc:clickhouse://node02:8123?user=default&password=', 'mydatabase', 'test')
```

使用mysql协议进行链接时,此时端口是9004
```java
ENGINE = JDBC('jdbc:mysql://node02:9004?user=default&password=', 'mydatabase', 'test')
```

https://blog.csdn.net/zhangpeterx/article/details/95060788

https://help.aliyun.com/document_detail/167430.html

https://help.aliyun.com/document_detail/381082.html


# clickhouse的表引擎

MergeTree
适用于高负载任务的最通用和功能最强大的表引擎。这些引擎的共同特点是可以快速插入数据并进行后续的后台数据处理。 MergeTree系列引擎支持数据复制（使用Replicated* 的引擎版本），分区和一些其他引擎不支持的其他功能。

该类型的引擎：
- MergeTree
- ReplacingMergeTree
- SummingMergeTree
- AggregatingMergeTree
- CollapsingMergeTree
- VersionedCollapsingMergeTree
- GraphiteMergeTree

日志
该类型的引擎：

TinyLog
StripeLog
Log


集成引擎
用于与其他的数据存储与处理系统集成的引擎。
该类型的引擎：

- Kafka
- MySQL
- ODBC
- JDBC
- HDFS

其它特定功能的引擎

该类型的引擎:
- Distributed
- MaterializedView
- Dictionary
- Merge
- File
- Null
- Set
- Join
- URL
- View
- Memory
- Buffer

https://clickhouse.com/docs/zh/engines/table-engines/


## clickhouse 集群管理

https://developer.huawei.com/consumer/cn/forum/topic/0201253538672480409?fid=23

## ck 的表原理

https://segmentfault.com/a/1190000023089140

https://clickhouse.com/docs/zh/operations/system-tables/tables/

分区表使用创建方式

https://blog.csdn.net/j3T9Z7H/article/details/108067342


# clickhouse原理

https://www.cnblogs.com/ludongguoa/p/15319811.html

# clickhouse tips

https://blog.tinybird.co/categories/clickhouse-tips/

https://www.tinybird.co/

https://docs.tinybird.co/
