# hive

Hive 是一个构建在 Hadoop 之上的数据仓库，它可以将结构化的数据文件映射成表，并提供类 SQL 查询功能，用于查询的 SQL 语句会被转化为 MapReduce 作业，然后提交到 Hadoop 上运行。

Hadoop生态系统包含了用于协助Hadoop的不同的子项目（工具）模块，如Sqoop, Pig 和 Hive。

- Sqoop: 它是用来在HDFS和RDBMS之间来回导入和导出数据。
- Pig: 它是用于开发MapReduce操作的脚本程序语言的平台。
- Hive: 它是用来开发SQL类型脚本用于做MapReduce操作的平台。



Hive 在执行一条 HQL 的时候，会经过以下步骤：

语法解析：Antlr 定义 SQL 的语法规则，完成 SQL 词法，语法解析，将 SQL 转化为抽象 语法树 AST Tree；
语义解析：遍历 AST Tree，抽象出查询的基本组成单元 QueryBlock；
生成逻辑执行计划：遍历 QueryBlock，翻译为执行操作树 OperatorTree；
优化逻辑执行计划：逻辑层优化器进行 OperatorTree 变换，合并不必要的 ReduceSinkOperator，减少 shuffle 数据量；
生成物理执行计划：遍历 OperatorTree，翻译为 MapReduce 任务；
优化物理执行计划：物理层优化器进行 MapReduce 任务的变换，生成最终的执行计划。

Hive 的核心是驱动引擎， 驱动引擎由四部分组成：

- 解释器：解释器的作用是将 HiveSQL 语句转换为抽象语法树（AST）

- 编译器：编译器是将语法树编译为逻辑执行计划

- 优化器：优化器是对逻辑执行计划进行优化

- 执行器：执行器是调用底层的运行框架执行逻辑执行计划


元数据，通俗的讲，就是存储在 Hive 中的数据的描述信息。

　　Hive 中的元数据通常包括：表的名字，表的列和分区及其属性，表的属性（内部表和 外部表），表的数据所在目录

　　Metastore 默认存在自带的 Derby 数据库中。缺点就是不适合多用户操作，并且数据存 储目录不固定。数据库跟着 Hive 走，极度不方便管理

　　解决方案：通常存我们自己创建的 MySQL 库（本地 或 远程）

　　Hive 和 MySQL 之间通过 MetaStore 服务交互


https://tech.meituan.com/2014/02/12/hive-sql-to-mapreduce.html

https://www.cnblogs.com/qingyunzong/p/8707885.html

https://www.yiibai.com/hive/

https://cwiki.apache.org/confluence/display/Hive/Home

## Hive的编译过程

https://tech.meituan.com/2014/02/12/hive-sql-to-mapreduce.html


# hive 启动

```sh
# 初始化
$HIVE_HOME/bin/schematool -dbType <db type> -initSchema

# 启动
$ $HIVE_HOME/bin/hiveserver2
# 链接
$ $HIVE_HOME/bin/beeline -u jdbc:hive2://$HS2_HOST:$HS2_PORT
```

https://blog.csdn.net/lblblblblzdx/article/details/79760959

https://cwiki.apache.org/confluence/display/Hive/GettingStarted

# hive的数据类型

- 列类型
- 文字
- Null 值
- 复杂类型

https://www.yiibai.com/hive/hive_data_types.html

# hive 查询语句

```hql
CREATE DATABASE|SCHEMA [IF NOT EXISTS] <database name>

# 创建表的时候可以指定存储文件类型的格式
各个存储文件类型指定方式如下：

STORED AS TEXTFILE
STORED AS SEQUENCEFILE
STORED AS ORC
STORED AS PARQUET
STORED AS AVRO
STORED AS RCFILE

DROP DATABASE StatementDROP (DATABASE|SCHEMA) [IF EXISTS] database_name 
[RESTRICT|CASCADE];

CREATE [TEMPORARY] [EXTERNAL] TABLE [IF NOT EXISTS] [db_name.] table_name

[(col_name data_type [COMMENT col_comment], ...)]
[COMMENT table_comment]
[ROW FORMAT row_format]
[STORED AS file_format]

#  修改表
ALTER TABLE name RENAME TO new_name
ALTER TABLE name ADD COLUMNS (col_spec[, col_spec ...])
ALTER TABLE name DROP [COLUMN] column_name
ALTER TABLE name CHANGE column_name new_name new_type
ALTER TABLE name REPLACE COLUMNS (col_spec[, col_spec ...])

# 查询
SELECT [ALL | DISTINCT] select_expr, select_expr, ... 
FROM table_reference 
[WHERE where_condition] 
[GROUP BY col_list] 
[HAVING having_condition] 
[CLUSTER BY col_list | [DISTRIBUTE BY col_list] [SORT BY col_list]] 
[LIMIT number];

```

## 分区表
```sql
 CREATE EXTERNAL TABLE emp_partition(
    empno INT,
    ename STRING,
    job STRING,
    mgr INT,
    hiredate TIMESTAMP,
    sal DECIMAL(7,2),
    comm DECIMAL(7,2)
    )
    PARTITIONED BY (deptno INT)   -- 按照部门编号进行分区
    ROW FORMAT DELIMITED FIELDS TERMINATED BY "\t"
    LOCATION '/hive/emp_partition';
```

## 分桶表

```sql
 CREATE EXTERNAL TABLE emp_bucket(
    empno INT,
    ename STRING,
    job STRING,
    mgr INT,
    hiredate TIMESTAMP,
    sal DECIMAL(7,2),
    comm DECIMAL(7,2),
    deptno INT)
    CLUSTERED BY(empno) SORTED BY(empno ASC) INTO 4 BUCKETS  --按照员工编号散列到四个 bucket 中
    ROW FORMAT DELIMITED FIELDS TERMINATED BY "\t"
    LOCATION '/hive/emp_bucket';
```

## 倾斜表

通过指定一个或者多个列经常出现的值（严重偏斜），Hive 会自动将涉及到这些值的数据拆分为单独的文件。在查询时，如果涉及到倾斜值，它就直接从独立文件中获取数据，而不是扫描所有文件，这使得性能得到提升。

```sql
 CREATE EXTERNAL TABLE emp_skewed(
    empno INT,
    ename STRING,
    job STRING,
    mgr INT,
    hiredate TIMESTAMP,
    sal DECIMAL(7,2),
    comm DECIMAL(7,2)
    )
    SKEWED BY (empno) ON (66,88,100)  --指定 empno 的倾斜值 66,88,100
    ROW FORMAT DELIMITED FIELDS TERMINATED BY "\t"
    LOCATION '/hive/emp_skewed';   
```

## 临时表

临时表仅对当前 session 可见，临时表的数据将存储在用户的暂存目录中，并在会话结束后删除。如果临时表与永久表表名相同，则对该表名的任何引用都将解析为临时表，而不是永久表。临时表还具有以下两个限制：

- 不支持分区列.
- 不支持创建索引.


```sql
 CREATE TEMPORARY TABLE emp_temp(
    empno INT,
    ename STRING,
    job STRING,
    mgr INT,
    hiredate TIMESTAMP,
    sal DECIMAL(7,2),
    comm DECIMAL(7,2)
    )
    ROW FORMAT DELIMITED FIELDS TERMINATED BY "\t";
```

## CTAS创建表
支持从查询语句的结果创建表：

CREATE TABLE emp_copy AS SELECT * FROM emp WHERE deptno='20';

https://www.yiibai.com/hive/hiveql_select_where.html




https://github.com/heibaiying/BigData-Notes/blob/master/notes/Hive%E6%95%B0%E6%8D%AE%E6%9F%A5%E8%AF%A2%E8%AF%A6%E8%A7%A3.md

https://github.com/heibaiying/BigData-Notes/blob/master/notes/Hive%E5%B8%B8%E7%94%A8DDL%E6%93%8D%E4%BD%9C.md#11-%E6%9F%A5%E7%9C%8B%E6%95%B0%E6%8D%AE%E5%88%97%E8%A1%A8

# hive关系运算符

本章介绍Hive的内置运算符。在Hive有四种类型的运算符：
- 关系运算符
- 算术运算符
- 逻辑运算符
- 复杂运算符

# 内置函数

https://www.yiibai.com/hive/hive_built_in_functions.html

# HiveServer2/beeline

Hive 内置了 HiveServer 和 HiveServer2 服务，两者都允许客户端使用多种编程语言进行连接，但是 HiveServer 不能处理多个客户端的并发请求，因此产生了 HiveServer2。HiveServer2（HS2）允许远程客户端可以使用各种编程语言向 Hive 提交请求并检索结果，支持多客户端并发访问和身份验证。HS2 是由多个服务组成的单个进程，其包括基于 Thrift 的 Hive 服务（TCP 或 HTTP）和用于 Web UI 的 Jetty Web 服务。

HiveServer2 拥有自己的 CLI 工具——Beeline。Beeline 是一个基于 SQLLine 的 JDBC 客户端。由于目前 HiveServer2 是 Hive 开发维护的重点，所以官方更加推荐使用 Beeline 而不是 Hive CLI。以下主要讲解 Beeline 的配置方式。

https://github.com/heibaiying/BigData-Notes/blob/master/notes/installation/Linux%E7%8E%AF%E5%A2%83%E4%B8%8BHive%E7%9A%84%E5%AE%89%E8%A3%85%E9%83%A8%E7%BD%B2.md

# 相关配置文件

可以通过三种方式对 Hive 的相关属性进行配置，分别介绍如下：

3.1 配置文件
方式一为使用配置文件，使用配置文件指定的配置是永久有效的。Hive 有以下三个可选的配置文件：

hive-site.xml ：Hive 的主要配置文件；

hivemetastore-site.xml： 关于元数据的配置；

hiveserver2-site.xml：关于 HiveServer2 的配置。

# hive分区表和分桶表


## 分区表

Hive 中的表对应为 HDFS 上的指定目录，在查询数据时候，默认会对全表进行扫描，这样时间和性能的消耗都非常大。

分区为 HDFS 上表目录的子目录，数据按照分区存储在子目录中。如果查询的 where 字句的中包含分区条件，则直接从该分区去查找，而不是扫描整个表目录，合理的分区设计可以极大提高查询速度和性能。

https://github.com/heibaiying/BigData-Notes/blob/master/notes/Hive%E5%88%86%E5%8C%BA%E8%A1%A8%E5%92%8C%E5%88%86%E6%A1%B6%E8%A1%A8.md

## 分桶表

分区提供了一个隔离数据和优化查询的可行方案，但是并非所有的数据集都可以形成合理的分区，分区的数量也不是越多越好，过多的分区条件可能会导致很多分区上没有数据。同时 Hive 会限制动态分区可以创建的最大分区数，用来避免过多分区文件对文件系统产生负担。鉴于以上原因，Hive 还提供了一种更加细粒度的数据拆分方案：分桶表 (bucket Table)。

分桶表会将指定列的值进行哈希散列，并对 bucket（桶数量）取余，然后存储到对应的 bucket（桶）中。

## 分区表和分桶表结合使用

分区表和分桶表的本质都是将数据按照不同粒度进行拆分，从而使得在查询时候不必扫描全表，只需要扫描对应的分区或分桶，从而提升查询效率。两者可以结合起来使用，从而保证表数据在不同粒度上都能得到合理的拆分。下面是 Hive 官方给出的示例：

```sql
CREATE TABLE page_view_bucketed(
	viewTime INT, 
    userid BIGINT,
    page_url STRING, 
    referrer_url STRING,
    ip STRING )
 PARTITIONED BY(dt STRING)
 CLUSTERED BY(userid) SORTED BY(viewTime) INTO 32 BUCKETS
 ROW FORMAT DELIMITED
   FIELDS TERMINATED BY '\001'
   COLLECTION ITEMS TERMINATED BY '\002'
   MAP KEYS TERMINATED BY '\003'
 STORED AS SEQUENCEFILE;
```

导入数据时需要指定分区:

```sql
INSERT OVERWRITE page_view_bucketed
PARTITION (dt='2009-02-25')
SELECT * FROM page_view WHERE dt='2009-02-25';
```

# hql练习

```sh
CREATE TABLE person (
    age int,
    name STRING, 
    address STRING
);
INSERT INTO person (age, name, address) VALUES (12, 'jsdu', 'asdas');
hive> INSERT INTO person (age, name, address) VALUES (12, 'jsdu', 'asdas');
Query ID = root_20211013210224_57c64282-85e3-47aa-82f7-92f6a87544db
Total jobs = 3
Launching Job 1 out of 3
Number of reduce tasks is set to 0 since there's no reduce operator
21/10/13 21:02:25 INFO client.RMProxy: Connecting to ResourceManager at cdh01/172.19.211.138:8032
21/10/13 21:02:25 INFO client.RMProxy: Connecting to ResourceManager at cdh01/172.19.211.138:8032
Starting Job = job_1634023124458_0005, Tracking URL = http://cdh01:8088/proxy/application_1634023124458_0005/
Kill Command = /opt/cloudera/parcels/CDH-6.3.2-1.cdh6.3.2.p0.1605554/lib/hadoop/bin/hadoop job  -kill job_1634023124458_0005
Hadoop job information for Stage-1: number of mappers: 1; number of reducers: 0
2021-10-13 21:02:32,281 Stage-1 map = 0%,  reduce = 0%
2021-10-13 21:02:38,434 Stage-1 map = 100%,  reduce = 0%, Cumulative CPU 2.31 sec
MapReduce Total cumulative CPU time: 2 seconds 310 msec
Ended Job = job_1634023124458_0005
Stage-4 is selected by condition resolver.
Stage-3 is filtered out by condition resolver.
Stage-5 is filtered out by condition resolver.
Moving data to directory hdfs://cdh01:8020/user/hive/warehouse/person/.hive-staging_hive_2021-10-13_21-02-24_285_2561911674843952826-1/-ext-10000
Loading data to table default.person
MapReduce Jobs Launched: 
Stage-Stage-1: Map: 1   Cumulative CPU: 2.31 sec   HDFS Read: 4401 HDFS Write: 84 HDFS EC Read: 0 SUCCESS
Total MapReduce CPU Time Spent: 2 seconds 310 msec
OK
Time taken: 15.842 seconds
```