# 安装报错

```sh
22/10/13 01:37:22 ERROR CoarseGrainedExecutorBackend: Executor self-exiting due to : Driver 10.233.70.71:36571 disassociated! Shutting down.
```

这个错误比较隐晦，归根结底还是内存的问题，有两个方法可以解决这个错误，一是，如上面所说，加大excutor-memory的值，减少executor-cores的数量，问题可以解决。二是，加大executor.overhead的值，但是这样其实并没有解决掉根本的问题。所以如果集群的资源是支持的话，就用1的办法吧。

　　另外，这个错误也出现在partitionBy(new HashPartition(partiton-num))时，如果partiton-num太大或者太小的时候会报这种错误，说白了也是内存的原因，不过这个时候增加内存和overhead没有什么用，得去调整这个partiton-num的值。


```sh
 22/10/13 01:42:28 ERROR PSExecutorBackend: Cannot register with driver: spark://ps-driver-endpoint@10.233.105.240:7778

 java.io.IOException: Failed to connect to /10.233.105.240:7778

 	at org.apache.spark.network.client.TransportClientFactory.createClient(TransportClientFactory.java:287)

 	at org.apache.spark.network.client.TransportClientFactory.createClient(TransportClientFactory.java:218)

 	at org.apache.spark.network.client.TransportClientFactory.createClient(TransportClientFactory.java:230)

 	at org.apache.spark.rpc.netty.NettyRpcEnv.createClient(NettyRpcEnv.scala:204)

 	at org.apache.spark.rpc.netty.Outbox$$anon$1.call(Outbox.scala:202)

 	at org.apache.spark.rpc.netty.Outbox$$anon$1.call(Outbox.scala:198)

 	at java.util.concurrent.FutureTask.run(FutureTask.java:266)

 	at java.util.concurrent.ThreadPoolExecutor.runWorker(ThreadPoolExecutor.java:1149)

 	at java.util.concurrent.ThreadPoolExecutor$Worker.run(ThreadPoolExecutor.java:624)

 	at java.lang.Thread.run(Thread.java:748)

 Caused by: io.netty.channel.AbstractChannel$AnnotatedConnectException: Connection refused: /10.233.105.240:7778
```


```sh
root@byzer-engine-turing-dbc4cc85f-rwc5q:/home/deploy#  /work/spark-3.1.1-bin-hadoop3.2/bin/spark-sql
22/10/18 03:15:14 WARN NativeCodeLoader: Unable to load native-hadoop library for your platform... using builtin-java classes where applicable
Using Spark's default log4j profile: org/apache/spark/log4j-defaults.properties
Setting default log level to "WARN".
To adjust logging level use sc.setLogLevel(newLevel). For SparkR, use setLogLevel(newLevel).
Exception in thread "main" java.lang.RuntimeException: java.lang.ClassNotFoundException: Class io.juicefs.JuiceFileSystem not found

scala> val textFile = spark.read.textFile("/home/deploy/byzer-lang/README.md")
java.lang.RuntimeException: java.lang.ClassNotFoundException: Class io.juicefs.JuiceFileSystem not found
  at org.apache.hadoop.conf.Configuration.getClass(Configuration.java:2595)
  at org.apache.hadoop.fs.FileSystem.getFileSystemClass(FileSystem.java:3269)
  at org.apache.hadoop.fs.FileSystem.createFileSystem(FileSystem.java:3301)
  at org.apache.hadoop.fs.FileSystem.access$200(FileSystem.java:124)
  at org.apache.hadoop.fs.FileSystem$Cache.getInternal(FileSystem.java:3352)
  at org.apache.hadoop.fs.FileSystem$Cache.get(FileSystem.java:3320)
  at org.apache.hadoop.fs.FileSystem.get(FileSystem.java:479)
  at org.apache.hadoop.fs.FileSystem.get(FileSystem.java:227)
  at org.apache.hadoop.fs.FileSystem.get(FileSystem.java:463)
  at org.apache.hadoop.fs.Path.getFileSystem(Path.java:361)
  at org.apache.spark.sql.execution.streaming.FileStreamSink$.hasMetadata(FileStreamSink.scala:46)
  at org.apache.spark.sql.execution.datasources.DataSource.resolveRelation(DataSource.scala:376)
  at org.apache.spark.sql.DataFrameReader.loadV1Source(DataFrameReader.scala:326)
  at org.apache.spark.sql.DataFrameReader.$anonfun$load$3(DataFrameReader.scala:308)
  at scala.Option.getOrElse(Option.scala:189)
  at org.apache.spark.sql.DataFrameReader.load(DataFrameReader.scala:308)
  at org.apache.spark.sql.DataFrameReader.text(DataFrameReader.scala:945)
  at org.apache.spark.sql.DataFrameReader.textFile(DataFrameReader.scala:982)
  at org.apache.spark.sql.DataFrameReader.textFile(DataFrameReader.scala:954)
  ... 47 elided
Caused by: java.lang.ClassNotFoundException: Class io.juicefs.JuiceFileSystem not found
  at org.apache.hadoop.conf.Configuration.getClassByName(Configuration.java:2499)
  at org.apache.hadoop.conf.Configuration.getClass(Configuration.java:2593)
  ... 65 more
```
