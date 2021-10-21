# cdh

术语介绍和概念

https://github.com/JetBone/documents/blob/master/CDH%20%E4%BB%8B%E7%BB%8D%E4%B8%8E%E9%85%8D%E7%BD%AE.md

## cdh install

https://mp.weixin.qq.com/s/P0UMXT01WxWqR0J3ZDqBpQ

https://blog.csdn.net/qq_40180229/article/details/108778683

https://blog.51cto.com/anfishr/2550426

https://blog.csdn.net/qq_40180229/article/details/108755530

https://www.blog.kamisamak.com/cloudera-cdh-6-3-2-centos7%e7%a6%bb%e7%ba%bf%e5%ae%89%e8%a3%85/

# CDH 编译

https://github.com/xjjdlut/BigdataNote/blob/83aa901f0f34dde784b120a208916ce604e1cf33/cdh/cdh%E7%BC%96%E8%AF%91.md

## Centos-7 部署CDH

https://anjia0532.github.io/2019/04/28/cdh-local-parcel-repo/

https://www.cnblogs.com/ttzzyy/p/13072774.html

https://blog.csdn.net/BoomLee/article/details/119119096

## CDH 卸载

https://yangqian.asia/posts/cdh/cdh_doc/

## cdh CDH Parcel包制作流程详解

parcel包内包含了你的服务组件，同时包含一个重要的描述性文件parcel.json；这个文件记录了你的服务信息，如版本、所属用户、适用的CDH平台版本等parcel必须包置于/opt/cloudera/parcel-repo/目录下才可以被CDH发布程序时识别到。

https://blog.csdn.net/weixin_40670099/article/details/111874424


## CDH的包管理方式


https://cloud.tencent.com/developer/article/1363408



## CDH6.3.2 CM web 开启kudu

https://blog.csdn.net/weixin_43270493/article/details/93067793




# CDH 6.3.2端口使用说明:

```md
ClouderaManager 版本:6.1.1
7180： Cloudera Manager WebUI端口
7182： Cloudera Manager Server 与 Agent 通讯端口
8087: Activity Monitor Web UI 端口
9087: Port for Activity Monitor’s HTTPS Debug page
9999: Activity Monitor 侦听端口
9998: 公开 Activity Monitor 的查询 API 的端口
10101: Alert Publisher 侦听内部 API 请求的端口。
7184: Event Server 监听事件发布的端口。
7185: Event Server 监听事件查询的端口。
8084: Event Server 的调试页面的端口。请设为 -1 以禁用调试服务器。
8091: Host Monitor 的调试页面的端口。请设为 -1 以禁用调试服务器。
9091: Port for Host Monitor’s HTTPS Debug page.
9995: Host Monitor 侦听代理消息的端口。
9994: 公开 Host Monitor 的查询 API 的端口。
7186: Navigator 审核服务器监听请求的端口
8089: Navigator 审核服务器启动调试 Web 服务器的端口。请设为 -1 以禁用调试服务器。
7178: Navigator Metadata Server 监听请求的端口
5678: Reports Manager 侦听请求的端口
8083: Reports Manager 启动调试 web 服务器的端口。请设为 -1 以禁用调试服务器。
8086: Service Monitor 的调试页面的端口。请设为 -1 以禁用调试服务器。
9086: Port for Service Monitor’s HTTPS Debug page.
9997: Service Monitor 侦听代理消息的端口。
9996: 公开 Service Monitor 的查询 API 的端口。
10111: The port where Telemetry Publisher starts a debug web server. Set to -1 to disable debug server.
10110: The port where Telemetry Publisher listens for requests

Hadoop：
50070： HDFS WEB UI端口
8020 ： 高可用的HDFS RPC端口
9000 ： 非高可用的HDFS RPC端口
8088 ： Yarn 的WEB UI 接口
8485 ： JournalNode 的RPC端口
8019 ： ZKFC端口
10020： historyserver端口

9867: 各个 DataNode 协议的端口。结合 DataNode 的主机名称建立其 IPC 端口地址。
9866: DataNode 的 XCeiver 协议的端口。结合 DataNode 的主机名称建立其地址。
9864: DataNode HTTP Web UI 的端口。结合 DataNode 的主机名称建立其 HTTP 地址。
9865: DataNode Web UI 侦听的基本端口。结合 DataNode 的主机名称建立安全的 Web UI 地址。
14000: REST 接口可连接至 HDFS 的端口。如果已为 HttpFS 启用 TLS/SSL，则 REST 接口通过 HTTPS 服务，否则通过 HTTP 服务。
14001: 用于管理界面的端口。
8485: JournalNode 的 RPC 端口。结合 JournalNode 的主机名称构建其 RPC 地址。
8480: JournalNode HTTP Web UI 的端口。结合 JournalNode 的主机名称建立其 HTTP 地址。
8481: JournalNode Web UI 侦听的基本端口。结合 JournalNode 的主机名称建立安全的 Web UI 地址。
2409: NFS Gateway 服务器端口。
4242: NFS Gateway 服务器角色内执行的装载守护程序的端口号。
111: 系统端口映射或 rpcbind 服务的端口号。此配置由 Cloudera Manager 用来验证系统端口映射或 rpcbind 服务是否在启动 NFS 网关角色之前运行。Cloudera Manager 不会管理系统端口映射或 rpcbind 服务。
50079: The base port where the NFS Gateway server web UI listens. Combined with the NFS Gateway server hostname to build its HTTP address.
50579: The base port where the secure NFS Gateway server web UI listens. Combined with the NFS Gateway server’s hostname to build its secure web UI address.
8020: NameNode 运行 HDFS 协议的端口。结合 NameNode 的主机名称建立其地址
8022: HDFS Daemon 可以使用的 service-rpc 地址（而非共享客户端使用的 RPC 地址）的可选端口。
9870: DFS NameNode Web UI 侦听的基本端口。如端口为 0，服务器将在自由端口启动。结合 NameNode 的主机名称建立其 HTTP 地址。
9871: 安全 NameNode Web UI 侦听的基本端口。
9868: SecondaryNameNode HTTP 端口。如端口为 0，服务器将在自由端口启动。结合 SecondaryNameNode 的主机名称建立其 HTTP 地址。
9869: 安全 SecondaryNameNode Web UI 侦听的基本端口。

Hive:
9083 : Hive Metastore 服务器监听连接的端口。
10000：Hive 的JDBC端口
10002: HiveServer2 WebUI 将侦听的端口。可以将其设为 0 以禁用 WebUI。
50111: WebHCat Server 用于监听连接的端口。

Impala:
26000: 导出 Catalog Server 的端口。
25020: Catalog Server 调试 Web 服务器运行的端口。
22000: ImpalaBackendService 导出的端口。
27000: Port on which KRPC-based ImpalaInternalService is exported.
28000: 应启动 Llama 通知回调的端口
21000: Impala Daemon 向 Beeswax 客户端请求提供服务所使用的端口。
21050: Impala Daemon 向 HiveServer2 客户端请求提供服务所使用的端口。
25000: Impala 调试网站服务器运行的端口。
23000: StateStoreSubscriberService 运行的端口。
24000: StateStoreService 导出的端口。
25010: StateStore 调试网站服务器运行的端口。

Kudu:
8051: The port of the Kudu Master Web UI.
8050: The port of the Kudu Tablet Server Web UI.

Zookeeper:
2181: 客户端连接zookeeper的端口
3181: zookeeper集群内通讯使用，Leader监听此端口
4181: zookeeper端口 用于选举leader
9010: ZooKeeper 服务器 RMI 注册表使用的端口。需要该端口以通过 Cloudera Manager ZooKeeper 监控需要的 RMI 启用 JMX 访问。将其作为“-Dcom.sun.management.jmxremote.port”添加到 ZooKeeper 服务器 JVM 命令行。

Yarn:
10020: MapReduce JobHistory Server 的端口。与 JobHistory 角色的主机名称一起构成地址。
19888: MapReduce JobHistory Server Web 应用程序的 HTTP 端口。与 JobHistory 角色的主机名称一起形成地址。
19890: MapReduce JobHistory Server Web 应用程序的 HTTPS 端口。与 JobHistory 角色的主机名称一起形成地址。
10033: MapReduce JobHistory Server 管理接口的端口。与 JobHistory 角色的主机名称一起形成地址。
8042: NodeManager Web 应用程序的 HTTP 端口。
8044: NodeManager Web 应用程序的 HTTPS 端口
8041: NodeManager IPC 的地址。
8040: Localizer IPC 所在地址。
8032: ResourceManager 中应用程序管理接口的地址。
8030: ResourceManager 中调度器接口的地址。
8031: ResourceManager 中资源追踪器接口的地址。
8033: ResourceManager 中管理接口的地址。
8088: ResourceManager Web 应用程序的 HTTP 端口。
8090: ResourceManager Web 应用程序的 HTTPS 端口。
```

版权声明：本文为CSDN博主「Apache_Jerry」的原创文章，遵循CC 4.0 BY-SA版权协议，转载请附上原文出处链接及本声明。
原文链接：https://blog.csdn.net/Apache_Jerry/article/details/115321227

http://localhost:7180/cmf/home


# CDH 大数据相关组件的日志位置

CDH 中大数据相关组件的日志目录存放在
/var/log/${component}  目录下面。

相关组件的例子

```sh
[root@cdh01 tmp]# ll /opt/cloudera/parcels/CDH-6.3.2-1.cdh6.3.2.p0.1605554/lib/
total 116
drwxr-xr-x  2 root root 4096 Nov  9  2019 avro
drwxr-xr-x  2 root root 4096 Nov  9  2019 bigtop-utils
drwxr-xr-x  6 root root 4096 Nov  9  2019 flume-ng
drwxr-xr-x 10 root root 4096 Nov  9  2019 hadoop
drwxr-xr-x  7 root root 4096 Nov  9  2019 hadoop-hdfs
drwxr-xr-x  4 root root 4096 Nov  9  2019 hadoop-httpfs
drwxr-xr-x  4 root root 4096 Nov  9  2019 hadoop-kms
drwxr-xr-x  5 root root 4096 Nov  9  2019 hadoop-mapreduce
drwxr-xr-x  8 root root 4096 Nov  9  2019 hadoop-yarn
drwxr-xr-x  7 root root 4096 Nov  9  2019 hbase
drwxr-xr-x  6 root root 4096 Nov  9  2019 hbase-solr
drwxr-xr-x 12 root root 4096 Nov  9  2019 hive
drwxr-xr-x  8 root root 4096 Nov  9  2019 hive-hcatalog
drwxr-xr-x  8 root root 4096 Nov  9  2019 hue
drwxr-xr-x  9 root root 4096 Nov  9  2019 impala
drwxr-xr-x  5 root root 4096 Nov  9  2019 impala-shell
drwxr-xr-x  5 root root 4096 Nov  9  2019 kafka
drwxr-xr-x  5 root root 4096 Nov  9  2019 kite
drwxr-xr-x  8 root root 4096 Nov  9  2019 kudu
drwxr-xr-x  8 root root 4096 Nov  9  2019 oozie
drwxr-xr-x  6 root root 4096 Nov  9  2019 parquet
drwxr-xr-x  8 root root 4096 Nov  9  2019 pig
drwxr-xr-x  3 root root 4096 Nov  9  2019 search
drwxr-xr-x  6 root root 4096 Nov  9  2019 sentry
drwxr-xr-x 15 root root 4096 Nov  9  2019 solr
drwxr-xr-x 10 root root 4096 Nov  9  2019 spark
drwxr-xr-x  5 root root 4096 Nov  9  2019 sqoop
drwxr-xr-x  5 root root 4096 Nov  9  2019 zookeeper
drwxr-xr-x  2 root root 4096 Nov  9  2019 zookeeper-native
```

cdh自身的日志存储位置

```sh
[root@cdh01 ~]# ll /var/log/|grep cloudera
drwxr-x---  2 cloudera-scm cloudera-scm      4096 Oct 12 09:36 cloudera-scm-agent
drwxrwxr-x  3 cloudera-scm cloudera-scm      4096 Oct 11 18:18 cloudera-scm-alertpublisher
drwxrwxr-x  3 cloudera-scm cloudera-scm      4096 Oct 11 18:18 cloudera-scm-eventserver
drwxrwxr-x  3 cloudera-scm cloudera-scm      4096 Oct 11 18:18 cloudera-scm-firehose
drwxr-x---  2 cloudera-scm cloudera-scm      4096 Oct 12 09:35 cloudera-scm-server
```

https://blog.csdn.net/silentwolfyh/article/details/59489852


# CDH hadoop 组件的路径

hadoop组件启动的脚本文件：

 /etc/alternatives/
 

hadoop生态组件执行路径：

 /opt/cloudera/parcels/CDH/bin/ 
 

hadoop生态组件依赖包路径：

 /opt/cloudera/parcels/CDH/lib/
 

1、hadoop
 配置文件：/etc/hadoop/conf
 执行文件：/opt/cloudera/parcels/CDH/bin/hadoop
 

2、hive
 配置文件：/etc/hive/conf
 执行文件：/opt/cloudera/parcels/CDH/bin/hive
 

3、hbase
 配置文件：/etc/hbase/conf
 执行文件：/opt/cloudera/parcels/CDH/bin/hbase
 

4、zookeeper
 配置文件：/etc/zookeeper/conf
 执行文件：/opt/cloudera/parcels/CDH/bin/zookeeper
 

5、spark
 配置文件：/etc/spark/conf
 执行文件：/opt/cloudera/parcels/CDH/bin/spark 

https://cloud.tencent.com/developer/article/1818618


# CDH 集成 zeeplin

https://www.codetd.com/en/article/10238292

https://stackoverflow.com/questions/67023694/how-can-i-run-zeppelin-with-keberos-in-cdh-6-3-2

https://cloud.tencent.com/developer/article/1600652

# CDH 集成 Kylin

https://blog.csdn.net/AyubLIbra/article/details/105857546


# Elasticsearch 集成  CDH

https://www.lynsite.cn/20210731/OeKCQgz2Gcy5iq3s/

https://blog.csdn.net/weixin_44515781/article/details/112777253

# Flink Parcel 集成CDH

https://www.codeleading.com/article/61055163504/

https://github.com/KinoMin/bigdata-learning-notes/blob/a7dcf8cb2c7762848f5fc0cf35140d0e975d2dd7/note/flink/CDH6.3.2%E9%9B%86%E6%88%90FLink.md


# CDH 系统调优

https://www.jianshu.com/p/b805fd9995f1


# 集群安全

## CDH开启kerberos认证

https://mp.weixin.qq.com/s/A3UCjHnzPIPXYfzm4GDteA

https://cloud.tencent.com/developer/article/1183747

https://www.infoq.cn/article/yfxkhjdask0eme2gaqnz


Ranger：一个基于Hadoop平台监控和管理数据安全的框架。（Ranger组件当前不支持开启Kerberos认证。）
https://support.huaweicloud.com/usermanual-mrs/mrs_01_0513.html

## CDH kerberos和sentry配置

https://blog.eric7.site/2020/01/02/cdh6-3-1%E5%BC%80%E5%90%AFsentry/

https://blog.csdn.net/summer089089/article/details/107369994

https://blog.51cto.com/u_15278282/2932625

https://blog.csdn.net/qq_31454379/article/details/114361759

# CDH集群规划

https://docs.cloudera.com/documentation/enterprise/6/6.3/topics/cm_ig_host_allocations.html


# 集群迁移规划实战方案

有赞大数据方案

在开始迁移之前，我们调研了业界在迁移 Hadoop 集群时，常用的几种方案：

## 2.1 单集群
两个机房公用一个 Hadoop 集群（同一个Active NameNode，DataNode节点进行双机房部署），具体来讲有两种实现方式：

(记为方案A) 新机房DataNode节点逐步扩容，老机房DataNode节点逐步缩容，缩容之后通过 HDFS 原生工具 Balancer 实现 HDFS Block 副本的动态均衡，最后将Active NameNode切换到新机房部署，完成迁移。这种方式最为简单，但是存在跨机房拉取 Shuffle 数据、HDFS 文件读取等导致的专线带宽耗尽的风险，如图2.1所示
(记为方案B) 方案 A 由于两个机房之间有大量的网络传输，实际跨机房专线带宽较少情况下一般不会采纳，另外一种带宽更加友好的方案是:
通过Hadoop 的 Rack Awareness 来实现 HDFS Block N副本双机房按比例分布（通过调整 HDFS 数据块副本放置策略，比如常用3副本，两个机房比例为1：2）
通过工具（需要自研）来保证 HDFS Block 副本按比例在两个机房间的分布（思路是：通过 NameNode 拉取 FSImage，读取每个 HDFS Block 副本的机房分布情况，然后在预定限速下，实现副本的均衡）

优点：
- 对用户透明，基本无需业务方投入
- 数据一致性好
- 相比多集群，机器成本比较低
缺点：
- 需要比较大的跨机房专线带宽，保证每天增量数据的同步和 Shuffle 数据拉取的需要
- 需要改造基础组件（Hadoop/Spark）来支持本机房优先读写、在限速下实现跨机房副本按比例分布等
- 最后在完成迁移之前，需要集中进行 Namenode、ResourceManager 等切换，有变更风险

## 2.1 多集群

在新机房搭建一套新的 Hadoop 集群，第一次将全量 HDFS 数据通过 Distcp 拷贝到新集群，之后保证增量的数据拷贝直至两边的数据完全一致，完成切换并把老的集群下线，如图2.2所示。

这种场景也有两种不同的实施方式：

(记为方案C) 两边 HDFS 数据完全一致后，一键全部切换（比如通过在DP上配置改成指向新集群），优点是用户基本无感知，缺点也比较明显，一键迁移的风险极大（怎么保证两边完全一致、怎么快速识别&快速回滚）
(记为方案D) 按照DP上的任务血缘关系，分层（比如按照数据仓库分层依次迁移 ODS / DW / DM 层数据）、分不同业务线迁移，优点是风险较低(分治)且可控，缺点是用户感知较为明显

图2.2 多集群迁移方案

优点：

跨机房专线带宽要求不高（第一次全量同步期间不跑任务，后续增量数据同步，两边双跑任务不存在跨机房 Shuffle 问题）
风险可控，可以分阶段（ODS / DW / DM）依次迁移，每个阶段可以验证数据一致性后再开始下一阶段的迁移
不需要改造基础组件（Hadoop/Spark）
缺点：

对用户不透明，需要业务方配合
在平台层需要提供工具，来实现低成本迁移、数据一致性校验等

https://cloud.tencent.com/developer/news/672556

https://segmentfault.com/a/1190000039279848