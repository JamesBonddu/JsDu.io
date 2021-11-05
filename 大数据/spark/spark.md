# spark

Apache Spark™是用于大规模数据处理的统一分析引擎


https://archive.apache.org/dist/spark/

https://repo1.maven.org/maven2/org/apache/hive/hive-jdbc/


https://spark.apache.org/

## spark download

https://archive.apache.org/dist/spark/spark-2.4.0/

## spark源码解析

https://www.cnblogs.com/qingyunzong/p/8945933.html


## awsome spark

https://github.com/awesome-spark/awesome-spark

https://www.cnblogs.com/qingyunzong/p/8886338.html

### spark 优化


https://mp.weixin.qq.com/s/tTMeeATIs5lybBO-ifmq-g

https://mp.weixin.qq.com/s/M3YCKtbZt97jXrPFXqafAA

# spark 配置

hive2.1.1 和 spark2.1.2

https://blog.csdn.net/jobschen/article/details/78468358

https://spark.apache.org/docs/latest/sql-data-sources-hive-tables.html

https://www.huaweicloud.com/articles/12601849.html


https://blog.csdn.net/weixin_44033089/article/details/86588595

https://archive.apache.org/dist/hive/hive-2.1.1/

# hive2 外部jars包

https://cloud.tencent.com/developer/article/1621038

https://www.jianshu.com/p/86884c70b0e0

# hive spark version compare


Spark SQL 旨在与 Hive Metastore、SerDes 和 UDF 兼容。目前，Hive SerDes 和 UDF 基于 Hive 1.2.1，Spark SQL 可以连接到不同版本的 Hive Metastore（从 0.12.0 到 2.3.3。另见与不同版本的 Hive Metastore 交互）。


https://spark.apache.org/docs/2.4.5/sql-data-sources-hive-tables.html#interacting-with-different-versions-of-hive-metastore

https://spark.apache.org/docs/2.4.5/sql-migration-guide-hive-compatibility.html

https://stackoverflow.com/questions/33785843/hive-version-compatibility-with-spark



hadoop版本 ： hadoop-2.7.5

hive版本 ：apache-hive-2.1.1

spark版本： spark-2.3.0-bin-hadoop2.7

各个版本到官网下载就ok，注意的是版本之间的匹配

https://www.cnblogs.com/gxc2015/p/9035455.html

如何查看不同版本的兼容性

https://cloud.tencent.com/developer/article/1073016

https://github.com/MicrosoftDocs/azure-docs.zh-cn/blob/master/articles/synapse-analytics/spark/apache-spark-version-support.md


# spark RDD 

RDD 支持两种类型的操作：transforms，它从现有的数据集创建一个新的数据集，以及actions，它在对数据集运行计算后返回一个值给驱动程序。例如，map是一个转换，它通过一个函数传递每个数据集元素并返回一个表示结果的新 RDD。另一方面，reduce是使用某个函数聚合RDD的所有元素并将最终结果返回给驱动程序的操作（尽管也有一个并行reduceByKey返回分布式数据集）。

Spark 中的所有转换都是惰性的，因为它们不会立即计算结果。相反，他们只记住应用于某些基本数据集（例如文件）的转换。仅当操作需要将结果返回到驱动程序时才计算转换。这种设计使 Spark 能够更高效地运行。例如，我们可以意识到通过创建的数据集map将在 a 中使用，reduce并且仅将 的结果返回reduce给驱动程序，而不是更大的映射数据集。

默认情况下，每次在其上运行操​​作时，每个转换后的 RDD 可能会重新计算。但是，你也可以坚持使用内存中的RDD persist（或cache）方法，在这种情况下，星火将保持元件周围的群集上更快访问你查询它的下一次。还支持在磁盘上持久化 RDD，或跨多个节点复制。

```scala
val lines = sc.textFile("data.txt")
val lineLengths = lines.map(s => s.length)
val totalLength = lineLengths.reduce((a, b) => a + b)
```
第一行定义了来自外部文件的基本 RDD。此数据集未加载到内存中或以其他方式对其进行操作：lines只是指向文件的指针。第二行定义lineLengths为map转换的结果。再次，lineLengths 是不是马上计算，由于懒惰。最后，我们运行reduce，这是一个动作。在这一点上，Spark 将计算分解为在不同机器上运行的任务，每台机器都运行它的映射部分和局部归约，仅将其答案返回给驱动程序。

## Spark shuffle

Shuffle 是一项昂贵的操作，因为它通常会跨节点操作数据，这会涉及磁盘 I/O，网络 I/O，和数据序列化。某些 Shuffle 操作还会消耗大量的堆内存，因为它们使用堆内存来临时存储需要网络传输的数据。Shuffle 还会在磁盘上生成大量中间文件，从 Spark 1.3 开始，这些文件将被保留，直到相应的 RDD 不再使用并进行垃圾回收，这样做是为了避免在计算时重复创建 Shuffle 文件。如果应用程序长期保留对这些 RDD 的引用，则垃圾回收可能在很长一段时间后才会发生，这意味着长时间运行的 Spark 作业可能会占用大量磁盘空间，通常可以使用 spark.local.dir 参数来指定这些临时文件的存储目录。

https://github.com/JamesBonddu/BigData-Notes/blob/master/notes/Spark_RDD.md

## spark 清空缓存的方式

Spark 自动监控每个节点上的缓存使用情况，并以最近最少使用 (LRU) 的方式丢弃旧数据分区。如果您想手动删除 RDD 而不是等待它从缓存中掉出来，请使用该RDD.unpersist()方法。请注意，此方法默认不会阻塞。要阻塞直到资源被释放，请blocking=true在调用此方法时指定。


## 宽依赖和窄依赖

区分这两种依赖是非常有用的：

首先，窄依赖允许在一个集群节点上以流水线的方式（pipeline）对父分区数据进行计算，例如先执行 map 操作，然后执行 filter 操作。而宽依赖则需要计算好所有父分区的数据，然后再在节点之间进行 Shuffle，这与 MapReduce 类似。
窄依赖能够更有效地进行数据恢复，因为只需重新对丢失分区的父分区进行计算，且不同节点之间可以并行计算；而对于宽依赖而言，如果数据丢失，则需要对所有父分区数据进行计算并再次 Shuffle。

RDD(s) 及其之间的依赖关系组成了 DAG(有向无环图)，DAG 定义了这些 RDD(s) 之间的 Lineage(血统) 关系，通过血统关系，如果一个 RDD 的部分或者全部计算结果丢失了，也可以重新进行计算。那么 Spark 是如何根据 DAG 来生成计算任务呢？主要是根据依赖关系的不同将 DAG 划分为不同的计算阶段 (Stage)：

对于窄依赖，由于分区的依赖关系是确定的，其转换操作可以在同一个线程执行，所以可以划分到同一个执行阶段；
对于宽依赖，由于 Shuffle 的存在，只能在父 RDD(s) 被 Shuffle 处理完成后，才能开始接下来的计算，因此遇到宽依赖就需要重新划分阶段。


# spark 转换和算子

https://github.com/JamesBonddu/BigData-Notes/blob/master/notes/Spark_Transformation%E5%92%8CAction%E7%AE%97%E5%AD%90.md

# spark部署模式和作业提交

https://github.com/JamesBonddu/BigData-Notes/blob/master/notes/Spark%E9%83%A8%E7%BD%B2%E6%A8%A1%E5%BC%8F%E4%B8%8E%E4%BD%9C%E4%B8%9A%E6%8F%90%E4%BA%A4.md


# spark 累加器和广播变量

在 Spark 中，提供了两种类型的共享变量：累加器 (accumulator) 与广播变量 (broadcast variable)：

累加器：用来对信息进行聚合，主要用于累计计数等场景；
广播变量：主要用于在节点间高效分发大对象。

https://github.com/JamesBonddu/BigData-Notes/blob/master/notes/Spark%E7%B4%AF%E5%8A%A0%E5%99%A8%E4%B8%8E%E5%B9%BF%E6%92%AD%E5%8F%98%E9%87%8F.md

# spark SQL

Spark SQL 是 Spark 中的一个子模块，主要用于操作结构化数据。它具有以下特点：

能够将 SQL 查询与 Spark 程序无缝混合，允许您使用 SQL 或 DataFrame API 对结构化数据进行查询；
支持多种开发语言；
支持多达上百种的外部数据源，包括 Hive，Avro，Parquet，ORC，JSON 和 JDBC 等；
支持 HiveQL 语法以及 Hive SerDes 和 UDF，允许你访问现有的 Hive 仓库；
支持标准的 JDBC 和 ODBC 连接；
支持优化器，列式存储和代码生成等特性；
支持扩展并能保证容错。

spark SQL 支持的函数有scala 内置函数, UDF scala 函数.
Spark SQL 支持 Hive UDF、UDAF 和 UDTF 的集成。与 Spark UDF 和 UDAF 类似，Hive UDF 将单行作为输入工作并生成单行作为输出，而 Hive UDAF 对多行进行操作并作为结果返回单个聚合行。

## Spark SQL常见语法

https://spark.apache.org/docs/latest/sql-ref-syntax.html


## User Defined Aggregate Functions (UDAFs)

用户定义聚合的基类`Aggregator[-IN, BUF, OUT]`，可用于数据集操作以获取组的所有元素并将它们减少为单个值。

https://spark.apache.org/docs/3.1.2/sql-ref-functions-udf-aggregate.html#aggregator-in-buf-out

## DataFrame & DataSet

DataFrame
为了支持结构化数据的处理，Spark SQL 提供了新的数据结构 DataFrame。DataFrame 是一个由具名列组成的数据集。它在概念上等同于关系数据库中的表或 R/Python 语言中的 data frame。 由于 Spark SQL 支持多种语言的开发，所以每种语言都定义了 DataFrame 的抽象，主要如下

DataFrame 和 RDDs 应该如何选择？

- 如果你想使用函数式编程而不是 DataFrame API，则使用 RDDs；
- 如果你的数据是非结构化的 (比如流媒体或者字符流)，则使用 RDDs，
- 如果你的数据是结构化的 (如 RDBMS 中的数据) 或者半结构化的 (如日志)，出于性能上的考虑，应优先使用 DataFrame。

Dataset 也是分布式的数据集合，在 Spark 1.6 版本被引入，它集成了 RDD 和 DataFrame 的优点，具备强类型的特点，同时支持 Lambda 函数，但只能在 Scala 和 Java 语言中使用。在 Spark 2.0 后，为了方便开发者，Spark 将 DataFrame 和 Dataset 的 API 融合到一起，提供了结构化的 API(Structured API)，即用户可以通过一套标准的 API 就能完成对两者的操作。

## DataFrame & Dataset & RDDs总结
这里对三者做一下简单的总结：

RDDs 适合非结构化数据的处理，而 DataFrame & DataSet 更适合结构化数据和半结构化的处理；
DataFrame & DataSet 可以通过统一的 Structured API 进行访问，而 RDDs 则更适合函数式编程的场景；
相比于 DataFrame 而言，DataSet 是强类型的 (Typed)，有着更为严格的静态类型检查；
DataSets、DataFrames、SQL 的底层都依赖了 RDDs API，并对外提供结构化的访问接口。

# spark Streaming

Structured Streaming 的关键思想是将实时数据流视为一个不断追加的表。这导致了一种与批处理模型非常相似的新流处理模型。

## 离散流(DStreams)

Discretized Stream或DStream是 Spark Streaming 提供的基本抽象。它表示一个连续的数据流，可以是从源接收到的输入数据流，也可以是通过转换输入流生成的处理后的数据流。在内部，DStream 由一系列连续的 RDD 表示，这是 Spark 对不可变的分布式数据集的抽象（有关更多详细信息，请参阅Spark 编程指南）。

https://spark.apache.org/docs/latest/structured-streaming-programming-guide.html

# spark on yarn 是如何工作

```sh
spark-submit --class com.turing.WCApp --master yarn --deploy-mode client --executor-memory 2G --num-executors 10 spark-practice-1.0-SNAPSHOT.jar  hdfs:///tmp/hh.md  hdfs:///tmp/hh-out

[root@cdh01 bigdata-prcatice]# hdfs dfs -cat hdfs:///tmp/hh-out/part-00000
(jsdu,1)


# Adding Other JARs 添加其它jar包
# In cluster mode, the driver runs on a different machine than the client, so SparkContext.addJar won’t work out of the box with files that are local to the client. To make files on the client available to SparkContext.addJar, include them with the --jars option in the launch command.

$ ./bin/spark-submit --class my.main.Class \
    --master yarn \
    --deploy-mode cluster \
    --jars my-other-jar.jar,my-other-other-jar.jar \
    my-main-jar.jar \
    app_arg1 app_arg2
```

https://spark.apache.org/docs/latest/running-on-yarn.html


# spark on yarn


按照Spark应用程序中的driver分布方式不同，Spark on YARN有两种模式： yarn-client模式、yarn-cluster模式。

https://developer.aliyun.com/article/25468

# spark的任务提交流程


https://www.cnblogs.com/xing901022/p/9146767.html

https://blog.csdn.net/NextAction/article/details/104219326

https://juejin.cn/post/6998087803821096991

# spark 集群模式


以yarn调度和以k8s进行调度

https://cloud.tencent.com/developer/article/1738761

https://spark.apache.org/docs/latest/running-on-kubernetes.html

https://jimmysong.io/kubernetes-handbook/usecases/running-spark-with-kubernetes-native-scheduler.html

https://github.com/GoogleCloudPlatform/spark-on-k8s-operator

https://developer.aliyun.com/article/697793

https://www.shangmayuan.com/a/9ebf740a72184613a3c73018.html


spark on k8s

https://xiaoxubeii.github.io/articles/practice-of-spark-on-kubernetes/

https://github.com/GoogleCloudPlatform/spark-on-k8s-operator/blob/master/docs/design.md

https://developers.weixin.qq.com/community/develop/article/doc/0004486f288110a898cb012fa51c13

https://ieevee.com/tech/2017/08/31/spark-on-k8s.html


https://yunikorn.apache.org/docs/user_guide/workloads/run_spark/


# spark-jar冲突解决; 三方包与spark集群jar包冲突问题

出现该冲突的原因是JVM加载jar，如果有多个版本的jar，默认会先使用spark集群内部的，JVM一旦加载后，就不会进行第二次加载，如果运用了高版本的jar的一些特性，也就会无法运行程序。

分析local模式能运行，yarn模式不能运行的原因是，用户提交的protobuf-java-3.0.0.jar与SPARK_HOME/lib下的protobuf-java-2.5.0.jar冲突了，默认会优先加载SPARK_HOME/lib下的jar，而不是你程序的jar，所以会发生“ NoSuchMethodError”。

解决方法：提交参数添加 --conf spark.executor.extraClassPath=$user_jars


在spark程序中，经常需要一些外部的依赖（比如Zookeper、libthrift等），这些依赖可能本身在spark或者Hadoop客户端的jar包中就已经存在。当用户程序依赖的jar包版本和集群上spark/hadoop客户端依赖的jar包版本不一致时，可能会出现编译失败，或者执行过程中加载类失败的问题。

解决
分两种情况：

程序本身不依赖特定版本
用集群中存在的jar包就可以：这种情况可以在编译时去掉程序本身对这个jar包的依赖。参考POM文件示例中的在依赖时加上：<scope>provided</scope>

程序需要依赖特定版本
一般是集群中的该jar包版本较低，无法满足需求。这种情况可以利用maven-shade-plugin插件将冲突Jar包中的类重命名，在程序中调用重命名后的类，避免和集群上低版本的jar包冲突。

作者：西二旗老司机
链接：https://www.jianshu.com/p/f26d4f35ecd7
来源：简书
著作权归作者所有。商业转载请联系作者获得授权，非商业转载请注明出处。


https://whisperloli.github.io/2020/04/13/spark_hole_two.html


https://blog.csdn.net/u013200380/article/details/108509716

https://bbs.huaweicloud.com/blogs/detail/258449

# spark 依赖包加载顺序和冲突解决

我们知道Spark application运行加载依赖有三个地方：

SystemClasspath 
- -- Spark安装时候提供的依赖包 【SystemClassPath】
- Spark-submit --jars 提交的依赖包                               【UserClassPath】
- Spark-submit app.jar或者shadowJar打的jar               【UserClassPath】

Spark 依赖包默认优先级
通过测试发现class的默认加载顺序如下：

1. SystemClasspath -- Spark安装时候提供的依赖包

2. UserClassPath   -- Spark-submit --jars 提交的依赖包 或用户的app.jar

 

SystemClasspath 系统安装的包，默认优先使用环境的包，这样更加稳定安全。

spark-submit --jars 在默认spark环境里没有需要的包时，自己上传提供。


观察方法： spark-submit 的时候添加参数

--driver-java-options -verbose:class


https://blog.csdn.net/adorechen/article/details/90722933


# spark 源码

spark.driver.userClassPathFirst

实验性）在驱动程序中加载类时，是否让用户添加的 jar 优先于 Spark 自己的 jar。此功能可用于缓解 Spark 的依赖项和用户依赖项之间的冲突。它目前是一个实验性功能。这仅用于集群模式。

https://spark.apache.org/docs/3.2.0/configuration.html#content