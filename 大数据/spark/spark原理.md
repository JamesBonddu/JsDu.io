# spark 存储体系

BlockManagerMaster对BlockManager的管理

https://blog.csdn.net/LINBE_blazers/article/details/89856726


# spark 启动流程源码分析

https://www.cnblogs.com/yy3b2007com/p/11087180.html

https://bbs.huaweicloud.com/blogs/216441


# spark driver 

spark驱动程序是声明数据RDD上的转换和操作并将此类请求提交给master的程序。

实际上，驱动程序是创建 SparkContext 的程序，连接到给定的 Spark Master。在本地集群的情况下，就像你的情况一样，master_url=spark://<host>:<port>

它的位置独立于主/从。您可以与主节点共存或从另一个节点运行它。唯一的要求是它必须位于可从 Spark Workers 寻址的网络中。

这是您的驱动程序配置的样子：

```scala
val conf = new SparkConf()
      .setMaster("master_url") // this is where the master is specified
      .setAppName("SparkExamplesMinimal")
      .set("spark.local.ip","xx.xx.xx.xx") // helps when multiple network interfaces are present. The driver must be in the same network as the master and slaves
      .set("spark.driver.host","xx.xx.xx.xx") // same as above. This duality might disappear in a future version

val sc = new spark.SparkContext(conf)
    // etc...
```

https://stackoverflow.com/questions/24637312/spark-driver-in-apache-spark


# yarn 终止任务

https://cloud.tencent.com/developer/article/1807709

# spark on yarn 模式

yarn-cluster 和 yarn-client两种模式

https://developer.aliyun.com/article/4652

https://www.quora.com/When-should-apache-spark-be-run-in-yarn-cluster-mode-vs-yarn-client-mode-A-use-case-example-for-both-approaches-would-be-more-helpful

# resource-types

```sh
2017-12-22 11:15:40,838 INFO conf.Configuration: resource-types.xml not found
2017-12-22 11:15:40,839 INFO resource.ResourceUtils: Unable to find ‘resource-types.xml’.
```

不过不影响Job的执行。关于resource-types.xml详细信息，可以去官网查看:

https://hadoop.apache.org/docs/r3.0.0/hadoop-yarn/hadoop-yarn-site/ResourceModel.html


# spark topology 拓扑 机架意识

什么是机架感知
机架感知是一种计算不同计算节点（TT）的距离的技术，用以在任务调度过程中尽量减少网络带宽资源的消耗，这里用尽量，想表达的是当一个TT申请不到本地化任务时，JT会尽量调度一个机架的任务给他，因为不同机架的网络带宽资源比同一个机架的网络带宽资源更可贵。当然，机架感知不仅仅用在MR中，同样还用在HDFS数据块备份过程中（第一个replica选择本节点【如果上传是DataNode】或者随机的一个DN（系统会尽量避免存储太满和太忙的节点），第二个节点选择于第一个节点不同机架的DN，第三个选择放在第二个DN同一个机架的另一个DN上）


如果net.topology.script.file.name或net.topology.node.switch.mapping.impl未设置，则为任何传递的 IP 地址返回机架 ID '/default-rack'。虽然这种行为看起来是可取的，但它可能会导致 HDFS 块复制问题，因为默认行为是将一个复制块写到机架外，并且无法这样做，因为只有一个名为“/default-rack”的机架。


查看拓扑的命令是

```sh
hdfs dfsadmin -printTopology
```


https://blog.51cto.com/u_15278282/2932194

https://subscription.packtpub.com/book/big_data_and_business_intelligence/9781785889271/1/ch01lvl1sec10/spark-topology

https://hadoop.apache.org/docs/r3.1.0/hadoop-project-dist/hadoop-common/RackAwareness.html

https://blog.csdn.net/qianshangding0708/article/details/47292385


# CDH 配置机架感知

机架感知不仅仅用在MR中，同样还用在HDFS数据块备份过程中（第一个replica选择本节点【如果上传是DataNode】或者随机的一个DN（系统会尽量避免存储太满和太忙的节点），第二个节点选择于第一个节点不同机架的DN，第三个选择放在第二个DN同一个机架的另一个DN上）

机架感知有什么用？
- 将数据保存在不同 rack 中，保证数据安全性。
- 当读数据时， namenode 检查 client 是否在集群中，若是，根据离该 client 由近到远的顺序返回 block 位置。

https://cloud.tencent.com/developer/article/1189373

https://blog.csdn.net/wflh323/article/details/88695494

https://github.com/mattshma/bigdata/blob/master/hadoop/hdfs/hadoop_rack.md

# SparkRackResolver 报错

```sh
21/10/26 18:13:14 INFO yarn.SparkRackResolver: Got an error when resolving hostNames. Falling back to /default-rack for all
```

https://github.com/apache/spark/blob/master/resource-managers/yarn/src/main/scala/org/apache/spark/deploy/yarn/SparkRackResolver.scala


# yarn DNS 服务器功能

https://hadoop.apache.org/docs/r3.1.0/hadoop-yarn/hadoop-yarn-site/yarn-service/RegistryDNS.html



# yarn 调度spark 任务报错

```sh
21/10/26 18:13:16 INFO executor.CoarseGrainedExecutorBackend: Started daemon with process name: 7790@cdh02.com
21/10/26 18:13:16 INFO util.SignalUtils: Registered signal handler for TERM
21/10/26 18:13:16 INFO util.SignalUtils: Registered signal handler for HUP
21/10/26 18:13:16 INFO util.SignalUtils: Registered signal handler for INT
21/10/26 18:13:17 INFO spark.SecurityManager: Changing view acls to: yarn,root
21/10/26 18:13:17 INFO spark.SecurityManager: Changing modify acls to: yarn,root
21/10/26 18:13:17 INFO spark.SecurityManager: Changing view acls groups to: 
21/10/26 18:13:17 INFO spark.SecurityManager: Changing modify acls groups to: 
21/10/26 18:13:17 INFO spark.SecurityManager: SecurityManager: authentication disabled; ui acls disabled; users  with view permissions: Set(yarn, root); groups with view permissions: Set(); users  with modify permissions: Set(yarn, root); groups with modify permissions: Set()
21/10/26 18:13:17 INFO client.TransportClientFactory: Successfully created connection to cdh02.com/172.19.211.141:40761 after 61 ms (0 ms spent in bootstraps)
21/10/26 18:13:17 INFO spark.SecurityManager: Changing view acls to: yarn,root
21/10/26 18:13:17 INFO spark.SecurityManager: Changing modify acls to: yarn,root
21/10/26 18:13:17 INFO spark.SecurityManager: Changing view acls groups to: 
21/10/26 18:13:17 INFO spark.SecurityManager: Changing modify acls groups to: 
21/10/26 18:13:17 INFO spark.SecurityManager: SecurityManager: authentication disabled; ui acls disabled; users  with view permissions: Set(yarn, root); groups with view permissions: Set(); users  with modify permissions: Set(yarn, root); groups with modify permissions: Set()
21/10/26 18:13:17 INFO client.TransportClientFactory: Successfully created connection to cdh02.com/172.19.211.141:40761 after 1 ms (0 ms spent in bootstraps)
21/10/26 18:13:17 INFO storage.DiskBlockManager: Created local directory at /yarn/nm/usercache/root/appcache/application_1635242602037_0001/blockmgr-decb13d0-488e-45ae-8f95-88af06ff54d5
21/10/26 18:13:17 INFO memory.MemoryStore: MemoryStore started with capacity 366.3 MB
21/10/26 18:13:17 INFO executor.CoarseGrainedExecutorBackend: Connecting to driver: spark://CoarseGrainedScheduler@cdh02.com:40761
21/10/26 18:13:17 INFO executor.CoarseGrainedExecutorBackend: Successfully registered with driver
21/10/26 18:13:17 INFO executor.Executor: Starting executor ID 1 on host cdh02.com
21/10/26 18:13:17 INFO util.Utils: Successfully started service 'org.apache.spark.network.netty.NettyBlockTransferService' on port 32846.
21/10/26 18:13:17 INFO netty.NettyBlockTransferService: Server created on cdh02.com:32846
21/10/26 18:13:17 INFO storage.BlockManager: Using org.apache.spark.storage.RandomBlockReplicationPolicy for block replication policy
21/10/26 18:13:17 INFO storage.BlockManagerMaster: Registering BlockManager BlockManagerId(1, cdh02.com, 32846, None)
21/10/26 18:13:17 INFO storage.BlockManagerMaster: Registered BlockManager BlockManagerId(1, cdh02.com, 32846, None)
21/10/26 18:13:17 INFO storage.BlockManager: external shuffle service port = 7337
21/10/26 18:13:17 INFO storage.BlockManager: Registering executor with local external shuffle service.
21/10/26 18:13:17 INFO client.TransportClientFactory: Successfully created connection to cdh02.com/172.19.211.141:7337 after 1 ms (0 ms spent in bootstraps)
21/10/26 18:13:17 INFO storage.BlockManager: Initialized BlockManager: BlockManagerId(1, cdh02.com, 32846, None)
21/10/26 18:13:17 INFO cluster.PSExecutorPlugin: PSExecutorPlugin starting.....
21/10/26 18:13:18 INFO cluster.PSExecutorBackend: Connecting to driver: spark://ps-driver-endpoint@cdh02.com:7778
21/10/26 18:13:18 ERROR cluster.PSExecutorBackend: Cannot register with driver: spark://ps-driver-endpoint@cdh02.com:7778
java.io.IOException: Failed to connect to cdh02.com/172.19.211.141:7778
	at org.apache.spark.network.client.TransportClientFactory.createClient(TransportClientFactory.java:250)
	at org.apache.spark.network.client.TransportClientFactory.createClient(TransportClientFactory.java:192)
	at org.apache.spark.rpc.netty.NettyRpcEnv.createClient(NettyRpcEnv.scala:198)
	at org.apache.spark.rpc.netty.Outbox$$anon$1.call(Outbox.scala:194)
	at org.apache.spark.rpc.netty.Outbox$$anon$1.call(Outbox.scala:190)
	at java.util.concurrent.FutureTask.run(FutureTask.java:266)
	at java.util.concurrent.ThreadPoolExecutor.runWorker(ThreadPoolExecutor.java:1149)
	at java.util.concurrent.ThreadPoolExecutor$Worker.run(ThreadPoolExecutor.java:624)
	at java.lang.Thread.run(Thread.java:748)
Caused by: io.netty.channel.AbstractChannel$AnnotatedConnectException: Connection refused: cdh02.com/172.19.211.141:7778
	at sun.nio.ch.SocketChannelImpl.checkConnect(Native Method)
	at sun.nio.ch.SocketChannelImpl.finishConnect(SocketChannelImpl.java:716)
	at io.netty.channel.socket.nio.NioSocketChannel.doFinishConnect(NioSocketChannel.java:323)
	at io.netty.channel.nio.AbstractNioChannel$AbstractNioUnsafe.finishConnect(AbstractNioChannel.java:340)
	at io.netty.channel.nio.NioEventLoop.processSelectedKey(NioEventLoop.java:633)
	at io.netty.channel.nio.NioEventLoop.processSelectedKeysOptimized(NioEventLoop.java:580)
	at io.netty.channel.nio.NioEventLoop.processSelectedKeys(NioEventLoop.java:497)
	at io.netty.channel.nio.NioEventLoop.run(NioEventLoop.java:459)
	at io.netty.util.concurrent.SingleThreadEventExecutor$5.run(SingleThreadEventExecutor.java:858)
	at io.netty.util.concurrent.DefaultThreadFactory$DefaultRunnableDecorator.run(DefaultThreadFactory.java:138)
	... 1 more
Caused by: java.net.ConnectException: Connection refused
	... 11 more
21/10/26 18:13:49 INFO executor.CoarseGrainedExecutorBackend: Got assigned task 0
21/10/26 18:13:49 INFO executor.Executor: Running task 0.0 in stage 0.0 (TID 0)
21/10/26 18:13:49 INFO broadcast.TorrentBroadcast: Started reading broadcast variable 0
21/10/26 18:13:49 INFO client.TransportClientFactory: Successfully created connection to cdh02.com/172.19.211.141:41787 after 1 ms (0 ms spent in bootstraps)
21/10/26 18:13:49 INFO memory.MemoryStore: Block broadcast_0_piece0 stored as bytes in memory (estimated size 4.3 KB, free 366.3 MB)
21/10/26 18:13:49 INFO broadcast.TorrentBroadcast: Reading broadcast variable 0 took 102 ms
21/10/26 18:13:49 INFO memory.MemoryStore: Block broadcast_0 stored as values in memory (estimated size 8.7 KB, free 366.3 MB)
21/10/26 18:13:49 INFO codegen.CodeGenerator: Code generated in 181.924829 ms
21/10/26 18:13:49 INFO executor.Executor: Finished task 0.0 in stage 0.0 (TID 0). 1225 bytes result sent to driver
21/10/26 18:14:51 ERROR executor.CoarseGrainedExecutorBackend: RECEIVED SIGNAL TERM
21/10/26 18:14:51 INFO storage.DiskBlockManager: Shutdown hook called
21/10/26 18:14:51 INFO util.ShutdownHookManager: Shutdown hook called
```

# spark 详解

https://cloud.tencent.com/developer/article/1733855


# spark driver 和 executor

https://blog.knoldus.com/understanding-the-working-of-spark-driver-and-executor/

https://blog.csdn.net/zpf336/article/details/83006569

https://www.cnblogs.com/gnivor/p/5157516.html


https://tech.shmily-qjj.top/38328/


https://blog.csdn.net/Young2018/article/details/108856622