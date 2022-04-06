byzer相关资料地址

byzer编辑器
开源:
https://github.com/byzer-org/byzer-notebook

云效
https://codeup.aliyun.com/5eaa6e683fd198000181a4c6/HightTechPark/byzer-notebook

byzer-lang 语法解析引擎
byzer-lang
https://github.com/byzer-org/byzer-lang

https://github.com/byzer-org

新手任务指南
https://github.com/byzer-org/byzer-lang/issues/1406

https://github.com/byzer-org/byzer-lang/issues/1326

https://docs.byzer.org/#/byzer-lang/zh-cn/

https://docs.mlsql.tech/mlsql-stack/api/run-script.html


notebook swagger

http://47.103.78.125:9002/swagger-ui.html



[分享]Byzer-python 架构大揭秘
https://zhuanlan.zhihu.com/p/479232343?utm_source=wechat_session&utm_medium=social&utm_oi=26974185586688&s_r=0

[分享]Byzer 中如何将 Pandas DataFrame 映射成表
https://zhuanlan.zhihu.com/p/476992440?utm_source=wechat_session&utm_medium=social&utm_oi=26974185586688&s_r=0

[分享]Byzer 多租户支持指南
https://zhuanlan.zhihu.com/p/473515255?utm_source=wechat_session&utm_medium=social&utm_oi=26974185586688&s_r=0

[分享]Byzer 技术内幕: SQL层面的扩展是如何实现的
https://mp.weixin.qq.com/s/wXoKYxjv4HfPUPgrwNsR0Q


https://github.com/latincross/mlsqlwechat


JDBC原理解析

Spark相关源码解读（Spark 2.4），上述代码最终会翻译为JDBCRDD：

```scala
class JdbcRDD[T: ClassTag](
    sc: SparkContext,
    getConnection: () => Connection,
    sql: String,
    lowerBound: Long,
    upperBound: Long,
    numPartitions: Int,
    mapRow: (ResultSet) => T = JdbcRDD.resultSetToObjectArray _)
  extends RDD[T](sc, Nil) with Logging {

  override def getPartitions: Array[Partition] = {
    // bounds are inclusive, hence the + 1 here and - 1 on end
    val length = BigInt(1) + upperBound - lowerBound
    (0 until numPartitions).map { i =>
      val start = lowerBound + ((i * length) / numPartitions)
      val end = lowerBound + (((i + 1) * length) / numPartitions) - 1
      new JdbcPartition(i, start.toLong, end.toLong)
    }.toArray
  }

  override def compute(thePart: Partition, context: TaskContext): Iterator[T] = new NextIterator[T]
  ...
}
```
从上述代码可以看出，Spark根据lowerBound、upperBound、numPartitions三个参数来构造多个JdbcPartition，按照固定长度分隔。因此，如果数据分布均匀，可以选择此方式，否则可能会出现JdbcPartition数据倾斜。

https://mp.weixin.qq.com/s/zaz8sRdIkQEUn65FPQfIQg


byzer DSL

https://mp.weixin.qq.com/s?__biz=MzI5NzEwODUwNw==&mid=2247483674&idx=1&sn=6952086cbc3b99f44f01ffdea9211e0c&chksm=ecbb546edbccdd78693fcec627e15ce7ae895e48f65b0433e90223baa0861835d87e9c7700ba&cur_album_id=2234148859302182915&scene=189#wechat_redirect


自定义数据源开发

https://docs.mlsql.tech/mlsql-stack/dev_guide/engine/plugin/ds.html


http://blog.mlsql.tech/blog/mlsql-ifelse.html


深度学习

MLSQL 机器学习最简教程（无需Python!）
MLSQL深度学习入门【一】
http://blog.mlsql.tech/blog/mlsql-build-ml.html
MLSQL深度学习入门【二】-分布式模型训练
http://blog.mlsql.tech/blog/mlsql-dl.html
MLSQL深度学习入门【三】-特征工程
http://blog.mlsql.tech/blog/mlsql-feature-engineer.html
MLSQL深度学习入门【四】-Serving
http://blog.mlsql.tech/blog/mlsql-serving.html

http://blog.mlsql.tech/blog/mlsql-feature-engineer.html


http://blog.mlsql.tech/blog/plugin-dev-1.html


# 源码阅读

http://blog.mlsql.tech/blog/pyjava-1.html

http://blog.mlsql.tech/blog/sourcecode-reading.html


# 特殊处理某个输入的数据源

http://blog.mlsql.tech/blog/mlsql-mod.html


# Tips

## 变量生命周期

set 语法当前的生命周期是 request 级别的，也就是每次请求有效。

通常在 Byzer-lang 中，生命周期分成三个部分：

- request （当前执行请求有效/ Notebook 中实现为 Cell 等级）
- session （当前会话周期有效 /Notebook 的用户等级）
- application （全局应用有效，暂不支持）


Byzer-lang 的变量被分为五种类型：
- text
- conf
- shell
- sql
- defaultParam


# Spark SQL DSL

https://zhuanlan.zhihu.com/p/373497278

https://spark.apache.org/docs/latest/api/scala/org/apache/spark/sql/Dataset.html

https://github.com/thenaturalist/awesome-business-intelligence#8-etl-orchestration

## LookML

https://docs.looker.com/data-modeling/learning-lookml/what-is-lookml

https://docs.looker.com/reference/api-embedding-intro

https://chartio.com/learn/business-intelligence/the-11-best-data-visualization-tools-for-sql/

https://docs.looker.com/reference

https://docs.looker.com/reference/join-reference

https://www.infoq.cn/article/kqk9fd4wlvwp2ovmukc9

https://cloud.google.com/certification/lookml-developer

https://cloud.google.com/blog/products/data-analytics/7-reasons-looker-built-a-new-language-for-data

https://cloud.google.com/bigquery/docs/looker

https://docs.looker.com/?_ga=2.103401664.1943604055.1647307497-1004973044.1640605154&_gac=1.183158356.1645092905.CjwKCAiAgbiQBhAHEiwAuQ6Bkp45q2J6G8e90YuUACgkPnGsBWEoCCEknSeRDn76vXthWTwxAHQHNhoC9BYQAvD_BwE

## LookML的各种语法

https://docs.looker.com/data-modeling/learning-lookml

https://docs.looker.com/data-modeling/learning-lookml/derived-tables#persistent_derived_tables_(pdts)

git@github.com:looker-open-source/sdk-codegen.git

https://medium.com/google-cloud/google-cloud-data-catalog-and-looker-integration-4ebefdef6a34

## awsome look组件

https://gitlab.com/alison985/awesome-looker/-/tree/main

https://looker-open-source.github.io/components/latest/

https://looker-open-source.github.io/components/latest/develop

## redash

https://cn.kyligence.io/blog/redash-kylin-plugin-strikingly/

http://blog.maizimi.com/

http://guzhenping.com/2018/07/26/Redash%20Model%E6%95%B4%E7%90%86%E5%88%86%E6%9E%90/index.html

https://blog.csdn.net/womeng2009/article/details/106669458


# 关联数据集设计

https://help.fanruan.com/finereport/doc-view-4101.html

https://help.aliyun.com/document_detail/61151.html

https://tech.antfin.com/docs/2/117435

https://cloud.google.com/blog/topics/developers-practitioners/bigquery-explained-working-joins-nested-repeated-data


# 大屏

https://github.com/anji-plus/report


# CTE分层子查询

https://en.wikipedia.org/wiki/Hierarchical_and_recursive_queries_in_SQL#Common_table_expression


https://docs.microsoft.com/zh-cn/azure/databricks/sql/language-manual/sql-ref-syntax-qry-select-cte


mysql8.0 支持CTE表达式

sql写Fibonacci

```sql
  WITH RECURSIVE fibonacci (n, fib_n, next_fib_n) AS
  (
   SELECT 1, 0, 1
   UNION ALL
   SELECT n + 1, next_fib_n, fib_n + next_fib_n
   FROM fibonacci WHERE n < 10
  )
  SELECT * FROM fibonacci;
```

CTE似乎是Derived Table的一个替代品？其实不是的，虽然CTE内部优化流程与Derived Table类似，但是两者还是区别的，具体如下：

（1）一个CTE可以引用另一个CTE

（2）CTE可以自引用

（3）CTE在语句级别生成临时表，多次调用只需要执行一次，提高性能

Derived Table

http://mysql.taobao.org/monthly/2017/03/05/

https://developer.aliyun.com/article/874693

https://dev.mysql.com/doc/refman/8.0/en/with.html

https://cloud.tencent.com/developer/article/1142313

http://mysql.taobao.org/monthly/2019/07/06/


http://mysql.taobao.org/monthly/2021/08/04/
