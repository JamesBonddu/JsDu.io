# spark分享


# spark 整体概念

https://zacks.one/learningspark/

https://github.com/YunKillerE/spark-learning/blob/master/%E7%AC%AC%E4%B8%80%E7%AB%A0%EF%BC%9Aspark%E5%9F%BA%E7%A1%80%E7%9F%A5%E8%AF%86/spark%E8%BF%90%E8%A1%8C%E6%9E%B6%E6%9E%84.md

https://spark-internals.books.yourtion.com/markdown/2-JobLogicalPlan.html

https://buwenbuhuo.blog.csdn.net/article/details/108077472

https://blog.csdn.net/bocai8058/article/details/119300198?spm=1001.2014.3001.5501

# spark 运行模式

https://blog.csdn.net/bocai8058/article/details/119300198

https://buwenbuhuo.blog.csdn.net/article/details/108077472

https://blog.csdn.net/weixin_43616627/article/details/104234556

# RDD 和DataFrame和DataSet之间的关系

https://waltyou.github.io/Learning-Spark-0/

https://bbs.huaweicloud.com/blogs/302320

https://code-cookbook.readthedocs.io/zh_CN/latest/Bigdata%20Tools/SparkSQL.html

https://lansonli.blog.csdn.net/article/details/115743862


# RDD 五大特点

https://developer.huawei.com/consumer/cn/forum/topic/0202628556358740265?fid=23

https://www.jianshu.com/p/650d6e33914b

https://www.cnblogs.com/NightPxy/p/9324532.html

# RDD 算子

https://www.cnblogs.com/kpsmile/p/10434390.html


# spark SQL

https://linzebing.github.io/2020/10/23/spark-sql-4-6.html

## spark sql 执行逻辑

https://cloud.tencent.com/developer/article/1887150

https://blog.51cto.com/u_14932245/5237847


# s1 如何新增spark的datasource数据源类型?


基于基础的`DataSource API` 中的 DataFrameReader 和 DataFrameWriter

为什么在有API V1的基础上又多了API V2呢?

既然 Datasource API 可以满足我们绝大多数的需求，那为什么又出来个 DataSource v2。主要是由于以下几点因素。

- Datasource API v1 依赖于一些上层 API，如 SqlContext 和 DataFrame。我们知道 Spark 2.x 里面 SqlContext 被 SparkSession 代替，DataFrame 被统一到 Dataset。上层 API 在不断更新发展，在 Datasource API v1 中确没有什么体现。
- DataSource API v1 不支持列式读取。Spark SQL 引擎本身支持列式存储，但是在 DataSource API v1 里没有体现。
- DataSource API v1 实现一些算子下推太过繁琐。比如 limit 下推，如果实现的话，就是一大推接口，TableScan，PrunedScan
- DataSource API v1 缺乏分区和排序信息。数据源的分区和排序信息并不能传递给 Spark 优化器
- DataSource API v1 不支持流处理
- DataSource API v1 写操作不支持事务。比如，像 Mysql 中存入数据过程中发生异常，已经存进去的数据不会被清理，破坏数据的一致性。需要引入事务。
- DataSource API v2 应运而生，可以简单看下，v2 基本已经解决了上述的问题，支持自定义分区信息。


DataFrameReader API接口


实现某种数据源的DataFrameReader, 试用DataSource API 基础形式创建, 形如以下格式.

```scala
override def load(reader: DataFrameReader, config: DataSourceConfig): DataFrame = {
    reader.option("path", config.path).options(rewriteConfig(config.config)).format("org.apache.spark.sql.execution.datasources.crawlersql").load()
}

abstract class MLSQLBaseFileSource extends MLSQLSource with MLSQLSink with MLSQLSourceInfo with MLSQLRegistry with DslTool {
  override def load(reader: DataFrameReader, config: DataSourceConfig): DataFrame = {
    val context = ScriptSQLExec.contextGetOrForTest()
    val format = config.config.getOrElse("implClass", fullFormat)
    val owner = config.config.get("owner").getOrElse(context.owner)
    reader.options(rewriteConfig(config.config)).format(format).load(resourceRealPath(context.execListener, Option(owner), config.path))
  }
}

```

https://timemachine.icu/posts/a5a69ed8/


Spark 中的 Catalyst Optimizer 提供基于规则和基于成本的优化。基于规则的优化指示如何根据一组定义的规则执行查询。同时，基于成本的优化会生成多个执行计划并比较它们以选择成本最低的一个。
sparksql Catalyst 执行的转换的四个阶段如下:

阶段 1：分析
Spark SQL 引擎首先为 SQL 或 DataFrame 查询生成抽象语法树 (AST) 。在这个初始阶段，任何列或表名都将通过查询内部Catalog的 ，Spark SQL 的编程接口来解析，其中包含列名、数据类型、函数、表、数据库等的名称列表。一旦它们都被成功解决，查询进入下一阶段。

阶段 2：逻辑优化
如图 3-4 所示，该阶段包括两个内部阶段。应用基于标准规则的优化方法，Catalyst 优化器将首先构建一组多个计划，然后使用其基于成本的优化器 (CBO)为每个计划分配成本。这些计划以算子树的形式展开（如图 3-5 所示）；例如，它们可能包括常量折叠、谓词下推、投影修剪、布尔表达式简化等过程。这个逻辑计划是物理计划的输入。

> 什么是谓词下推?
谓词下推 ：将过滤过程尽可能的推到底层，最好数据源端，这样子在执行阶段数据计算量就会相应变少。举个极端的例子，如果数据在上层才过滤，那么从读取到 fliter 都要保持着全表才可以，这无疑加大了计算量和资源消耗，我们希望的是读取出来的数据就是已经过滤的。

第 3 阶段：物理计划
在此阶段，Spark SQL 使用与 Spark 执行引擎中可用的物理运算符匹配的物理运算符，为选定的逻辑计划生成最佳物理计划。

阶段 4：代码生成
查询优化的最后阶段包括生成高效的 Java 字节码以在每台机器上运行。由于 Spark SQL 可以对加载到内存中的数据集进行操作，因此 Spark 可以使用最先进的编译器技术进行代码生成以加快执行速度。换句话说，它充当编译器。促进全阶段代码生成的 Project Tungsten 在这里发挥了作用。

什么是全阶段代码生成？这是一个物理查询优化阶段，它将整个查询折叠成一个函数，摆脱了虚拟函数调用，并为中间数据使用 CPU 寄存器。Spark 2.0 中引入的第二代 Tungsten 引擎使用这种方法生成紧凑的 RDD 代码以供最终执行。这种精简策略显着提高了 CPU 效率和性能。

mlsql-sql-profiler 对应着上述查询优化的阶段

## 主要包含两个模块
### catalyst
spark的 Catalyst的核心是使用一个通用库生成树并使用规则操作这些树。在该框架的基础上，构建了用于关系查询处理库（例如表达式，逻辑查询计划）和处理执行查询不同阶段的几组规则：分析、逻辑优化、物理计划和代码生成，代码生成将部分查询编译为Java字节码。对于后者，使用了Scala特性quasiquotes，它可以很容易地在运行时由组合表达式生成代码。最后，Catalyst提供了几个公共扩展点，包括外部数据源和用户定义的类型。
Spark SQL 是用一个名为 Catalyst 的优化器设计的，它基于 Scala 的函数式编程。它的两个主要目的是：第一，添加新的优化技术来解决“大数据”的一些问题；第二，允许开发人员扩展和定制优化器的功能。

Spark SQL的核心是Catalyst优化器，是以一种新颖的方式利用Scala的的模式匹配和quasiquotes机制来构建的可扩展查询优化器。
SparkSQL利用Scala提供的Reflection和Quasiquotes机制来实现Code Generation。

https://www.cnblogs.com/shishanyuan/p/8455786.html

https://blog.bi-geek.com/en/spark-sql-optimizador-catalyst/

https://www.jianshu.com/p/410c23efb565

https://github.com/marsishandsome/SparkSQL-Internal/blob/master/06-component/code_generation.md#scala-quasiquotes

https://jtlibrain.github.io/2020/09/11/spark/Spark-SQL-Catalyst-details/

https://blog.csdn.net/qq_26442553/article/details/114988789

### optimizer
对应逻辑优化阶段.

```scala
var finalLogicalPlan: LogicalPlan = finalPlan(plan)
```

https://zacks.one/learningspark/


---

sparksql 自定义外部数据源
https://blog.csdn.net/wuxintdrh/article/details/116064794

数据源扩展方式

https://www.jianshu.com/p/b67f44e9c472

spark connector reader writer

https://juejin.cn/post/6941272505034211359

datasource v1和v2 API的区别

https://blog.csdn.net/penriver/article/details/115672072

https://codeantenna.com/a/uuFZlBtKBx

https://jaceklaskowski.gitbooks.io/mastering-spark-sql/content/spark-sql-data-source-api-v2.html

https://www.waitingforcode.com/apache-spark-sql/what-new-apache-spark-3.1-jdbc-datasource-v2-api/read

华为云DLI

https://bbs.huaweicloud.com/blogs/301053

spark 3.0 datasource v2

http://blog.madhukaraphatak.com/spark-3-datasource-v2-part-1/

https://docs.google.com/document/d/1DDXCTCrup4bKWByTalkXWgavcPdvur8a4eEu8x1BzPM/edit#

# s2 如何在byzer支持新的数据源类型?

byzer 基础数据源
- MLSQLBaseFileSource
- MLSQLBaseStreamSource


https://docs.byzer.org/#/byzer-lang/zh-cn/extension/dev/ds_dev

byzer hbase 数据源支持

https://blog.csdn.net/allwefantasy/article/details/88889184?spm=1001.2014.3001.5502


# spark scheduler

PPT链接：

https://www.slidestalk.com/s/Deep_Dive_Scheduler_in_Apache_Spark89573

论文链接：

https://www.slidestalk.com/s/eurosys_delay_scheduling5820

https://blog.csdn.net/allwefantasy/article/details/103790403?spm=1001.2014.3001.5502

# s3 如何自定义spark的算子


# spark原理

## RDD DataSet 和 DataFrame

Spark 作为一个编译器，它可以理解 Dataset 类型的 JVM 对象，它会使用编码器来把特定类型的 JVM 对象映射成 Tungsten 的内部内存表示。结果，Tungsten 的编码器就可以非常高效地将 JVM 对象序列化或反序列化，同时生成压缩字节码，这样执行效率就非常高了。

- Spark RDD：RDD代表弹性分布式数据集。它是记录的只读分区集合。 RDD是Spark的基本数据结构。它允许程序员以容错方式在大型集群上执行内存计算。
- Spark Dataframe：与RDD不同，数据组以列的形式组织起来，类似于关系数据库中的表。它是一个不可变的分布式数据集合。 Spark中的DataFrame允许开发人员将数据结构(类型)加到分布式数据集合上，从而实现更高级别的抽象。
- Spark Dataset：Apache Spark中的Dataset是DataFrame API的扩展，它提供了类型安全(type-safe)，面向对象(object-oriented)的编程接口。 Dataset利用Catalyst optimizer可以让用户通过类似于sql的表达式对数据进行查询。


https://blog.csdn.net/weixin_45366499/article/details/110727662

https://www.infoq.cn/article/three-apache-spark-apis-rdds-dataframes-and-datasets

## RDD 和 shuffle是什么

https://blog.csdn.net/allwefantasy/article/details/81039605?spm=1001.2014.3001.5502

## spark执行的完整流程

https://blog.csdn.net/allwefantasy/article/details/50564482?spm=1001.2014.3001.5502

## spark streaming 解析

https://blog.csdn.net/allwefantasy/article/details/81039475?spm=1001.2014.3001.5502

https://github.com/lw-lin/CoolplaySpark/tree/master/Spark%20Streaming%20%E6%BA%90%E7%A0%81%E8%A7%A3%E6%9E%90%E7%B3%BB%E5%88%97

https://github.com/lw-lin/CoolplaySpark

https://github.com/lw-lin/streaming-readings

# 海豚调度

如何支持海豚调度的依赖关系上下游依赖触发

如何自动创建海豚调度的dag关系节点.



# 如何支持spark的
缓存
定时任务
资源动态调整

https://blog.csdn.net/allwefantasy/article/details/89876684?spm=1001.2014.3001.5502
