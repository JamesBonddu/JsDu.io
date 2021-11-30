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


# spark dataset

数据集是域特定对象的强类型集合，可以使用函数或关系操作并行转换这些对象。每个 Dataset 也有一个称为 a 的无类型视图DataFrame，它是一个 Dataset of Row。
数据集上可用的操作分为转换和操作。转换是产生新数据集的那些，而动作是触发计算和返回结果的那些。示例转换包括映射、过滤器、选择和聚合 ( groupBy)。示例操作计数、显示或将数据写入文件系统。

数据集是“惰性的”，即计算仅在调用操作时触发。在内部，数据集表示描述生成数据所需的计算的逻辑计划。当一个动作被调用时，Spark 的查询优化器会优化逻辑计划并生成一个物理计划，以便以并行和分布式的方式高效执行。要探索逻辑计划以及优化的物理计划，请使用该explain功能。

为了有效地支持特定于域的对象，Encoder需要一个。编码器将域特定类型映射T到 Spark 的内部类型系统。例如，给定一个Person 具有name(string) 和age(int)两个字段的类，编码器用于告诉 Spark 在运行时生成代码以将Person对象序列化为二进制结构。这种二进制结构通常具有低得多的内存占用，并且针对数据处理的效率进行了优化（例如，以列格式）。要了解数据的内部二进制表示，请使用该 schema函数。

static Dataset<Row>	ofRows(SparkSession sparkSession, org.apache.spark.sql.catalyst.plans.logical.LogicalPlan logicalPlan) 
static Dataset<Row>	ofRows(SparkSession sparkSession, org.apache.spark.sql.catalyst.plans.logical.LogicalPlan logicalPlan, org.apache.spark.sql.catalyst.QueryPlanningTracker tracker)

ofRows 的一种变体，它允许传入跟踪器，以便我们可以跟踪查询解析时间。

https://spark.apache.org/docs/latest/api/java/org/apache/spark/sql/Dataset.html


# spark 之RPC框架

在Spark中很多地方都涉及网络通信，比如 Spark各个组件间的消息互通、用户文件与Jar包的上传、节点间的Shuffle过程、Block数据的复制与备份等。Spark1.6之前，Spark的Rpc是基于Akka来实现的，Akka是一个基于scala语言的异步的消息框架，但由于Akka不适合大文件的传输，在Spark1.6之前RPC通过Akka来实现，而大文件是基于Jetty实现的HttpFileServer。

在Spark2.0.0中也移除了Jetty，在Spark2.0.0版本借鉴了Akka的设计，重构了基于Netty的Rpc框架体系，其中Rpc和大文件传输都是使用Netty。


下面介绍一些重要概念：

- RpcEnv：RpcEnv 抽象类表示一个 RPC Environment，管理着整个RpcEndpoint的生命周期，每个 Rpc 端点运行时依赖的环境称之为 RpcEnv。
- NettyRpcEnv： RpcEnv的唯一实现类
- RpcEndpoint：RPC 端点 ，Spark 将每个通信实体都都称之一个Rpc端点，且都实现 RpcEndpoint 接口，比如DriverEndpoint，MasterEndpont，内部根据不同端点的需求，设计不同的消息和不同的业务处理。
- Dispatcher：消息分发器(来自netty的概念)，负责将 RpcMessage 分发至对应的 RpcEndpoint。Dispatcher 中包含一个 MessageLoop，它读取 LinkedBlockingQueue 中的投递 RpcMessage，根据客户端指定的 Endpoint 标识，找到 Endpoint 的 Inbox，然后投递进去，由于是阻塞队列，当没有消息的时候自然阻塞，一旦有消息，就开始工作。Dispatcher 的 ThreadPool 负责消费这些 Message。
- EndpointData：每个endpoint都有一个对应的EndpointData，EndpointData内部包含了RpcEndpoint、NettyRpcEndpointRef信息，与一个Inbox，收信箱Inbox内部有一个InboxMessage链表，发送到该endpoint的消息，就是添加到该链表，同时将整个EndpointData添加Dispatcher到阻塞队列receivers中，由Dispatcher线程异步处理
- Inbox：一个本地端点对应一个收件箱，Inbox 里面有一个 InboxMessage 的链表，InboxMessage 有很多子类，可以是远程调用过来的 RpcMessage，可以是远程调用过来的 fire-and-forget 的单向消息 OneWayMessage，还可以是各种服务启动，链路建立断开等 Message，这些 Message 都会在 Inbox 内部的方法内做模式匹配，调用相应的 RpcEndpoint 的函数。
- RpcEndPointRef： RpcEndpointRef是一个对RpcEndpoint的远程引用对象，通过它可以向远程的RpcEndpoint端发送消息以进行通信。
- NettyRpcEndpointRef：RpcEndpointRef 的唯一实现类，RpcEndpointRef的NettyRpcEnv版本。此类的行为取决于它的创建位置。在“拥有”RpcEndpoint的节点上，它是RpcEndpointAddress实例的简单包装器。
- RpcEndpointAddress：主要包含了 RpcAddress (host和port) 和 rpc endpoint name的信息
- Outbox：一个远程端点对应一个发件箱，NettyRpcEnv 中包含一个 ConcurrentHashMap[RpcAddress, Outbox]。当消息放入 Outbox 后，紧接着将消息通过 TransportClient 发送出去。
- TransportContext：是一个创建TransportServer, TransportClientFactory，使用TransportChannelHandler建立netty channel pipeline的上下文，这也是它的三个主要功能。TransportClient 提供了两种通信协议：控制层面的RPC以及数据层面的 “chunk抓取”。用户通过构造方法传入的 rpcHandler 负责处理RPC 请求。并且 rpcHandler 负责设置流，这些流可以使用零拷贝IO以数据块的形式流式传输。TransportServer 和 TransportClientFactory 都为每一个channel创建一个 TransportChannelHandler对象。每一个TransportChannelHandler 包含一个 TransportClient，这使服务器进程能够在现有通道上将消息发送回客户端。
- TransportServer：TransportServer是RPC框架的服务端，可提供高效的、低级别的流服务。
- TransportServerBootstrap：定义了服务端引导程序的规范，服务端引导程序旨在当客户端与服务端建立连接之后，在服务端持有的客户端管道上执行的引导程序。用于初始化TransportServer
- TransportClientFactory：创建传输客户端（TransportClient）的传输客户端工厂类。
- TransportClient:RPC框架的客户端，用于获取预先协商好的流中的连续块。TransportClient旨在允许有效传输大量数据，这些数据将被拆分成几百KB到几MB的块。简言之，可以认为TransportClient就是Spark Rpc 最底层的基础客户端类。主要用于向server端发送rpc 请求和从server 端获取流的chunk块。
- TransportClientBootstrap：是在TransportClient上执行的客户端引导程序，主要对连接建立时进行一些初始化的准备（例如验证、加密）。TransportClientBootstrap所作的操作往往是昂贵的，好在建立的连接可以重用。用于初始化TransportClient
- TransportChannelHandler：传输层的handler，负责委托请求给TransportRequestHandler，委托响应给TransportResponseHandler。在传输层中创建的所有通道都是双向的。当客户端使用RequestMessage启动Netty通道（由服务器的RequestHandler处理）时，服务器将生成ResponseMessage（由客户端的ResponseHandler处理）。但是，服务器也会在同一个Channel上获取句柄，因此它可能会开始向客户端发送RequestMessages。这意味着客户端还需要一个RequestHandler，而Server需要一个ResponseHandler，用于客户端对服务器请求的响应。此类还处理来自io.netty.handler.timeout.IdleStateHandler的超时。如果存在未完成的提取或RPC请求但是至少在“requestTimeoutMs”上没有通道上的流量，我们认为连接超时。请注意，这是双工流量;如果客户端不断发送但是没有响应，我们将不会超时。
- 当TransportChannelHandler读取到的request是RequestMessage类型时，则将此消息的处理进一步交给TransportRequestHandler，当request是ResponseMessage时，则将此消息的处理进一步交给TransportResponseHandler。
- TransportResponseHandler：用于处理服务端的响应，并且对发出请求的客户端进行响应的处理程序。
- TransportRequestHandler：用于处理客户端的请求并在写完块数据后返回的处理程序。
- MessageEncoder：在将消息放入管道前，先对消息内容进行编码，防止管道另一端读取时丢包和解析错误。
- MessageDecoder：对从管道中读取的ByteBuf进行解析，防止丢包和解析错误；
- TransportFrameDecoder：对从管道中读取的ByteBuf按照数据帧进行解析；
- StreamManager：处理ChunkFetchRequest和StreamRequest请求
- RpcHandler：处理RpcRequest和OneWayMessage请求
- Message：Message是消息的抽象接口，消息实现类都直接或间接的实现了RequestMessage或ResponseMessage接口。


我们首先要知道 Spark 的心跳有什么用。心跳是分布式技术的基础，我们知道在 Spark 中，是有一个 Master 和众多的 Worker，那么 Master 怎么知道每个 Worker 的情况呢，这就需要借助心跳机制了。心跳除了传输信息，另一个主要的作用就是 Worker 告诉 Master 它还活着，当心跳停止时，方便 Master 进行一些容错操作，比如数据转移备份等等。


https://zhuanlan.zhihu.com/p/28893155

https://zhuanlan.zhihu.com/p/55127453