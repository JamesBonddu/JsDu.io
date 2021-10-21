# hdfs (Hadoop Distribute File System) 是分布式文件系统

NameNode
NameNode 负责管理整个分布式系统的元数据，主要包括：

目录树结构；
文件到数据库 Block 的映射关系；
Block 副本及其存储位置等管理数据；
DataNode 的状态监控，两者通过段时间间隔的心跳来传递管理信息和数据信息，通过这种方式的信息传递，NameNode 可以获知每个 DataNode 保存的 Block 信息、DataNode 的健康状况、命令 DataNode 启动停止等（如果发现某个 DataNode 节点故障，NameNode 会将其负责的 block 在其他 DataNode 上进行备份）。
这些数据保存在内存中，同时在磁盘保存两个元数据管理文件：fsimage 和 editlog。

fsimage：是内存命名空间元数据在外存的镜像文件；
editlog：则是各种元数据操作的 write-ahead-log 文件，在体现到内存数据变化前首先会将操作记入 editlog 中，以防止数据丢失。
这两个文件相结合可以构造完整的内存数据。

Secondary NameNode
Secondary NameNode 并不是 NameNode 的热备机，而是定期从 NameNode 拉取 fsimage 和 editlog 文件，并对两个文件进行合并，形成新的 fsimage 文件并传回 NameNode，这样做的目的是减轻 NameNod 的工作压力，本质上 SNN 是一个提供检查点功能服务的服务点。

DataNode
负责数据块的实际存储和读写工作，Block 默认是64MB（HDFS2.0改成了128MB），当客户端上传一个大文件时，HDFS 会自动将其切割成固定大小的 Block，为了保证数据可用性，每个 Block 会以多备份的形式存储，默认是3份。


https://www.cnblogs.com/zsql/p/11587240.html

https://matt33.com/2018/07/15/hdfs-architecture-learn/

https://juejin.cn/post/6844903805314826254


# hadoop原理


https://www.cnblogs.com/jackchen-Net/p/6506321.html


# hdfs 设计指南

NameNode 通过Hadoop Rack Awareness中概述的过程确定每个 DataNode 所属的机架 ID 。一个简单但非最优的策略是将副本放在唯一的机架上。这可以防止在整个机架出现故障时丢失数据，并允许在读取数据时使用多个机架的带宽。此策略在集群中均匀分布副本，从而可以轻松平衡组件故障时的负载。但是，此策略增加了写入成本，因为写入需要将块传输到多个机架。

对于常见的情况，当复制因子为 3 时，HDFS 的放置策略是将一个副本放在本地机架中的一个节点上，另一个放在不同（远程）机架中的节点上，最后一个放在同一机架中的不同节点上。远程机架。此策略减少了机架间写入流量，这通常会提高写入性能。机架故障的几率远小于节点故障；此政策不影响数据可靠性和可用性保证。然而，它确实减少了读取数据时使用的总网络带宽，因为一个块只放置在两个独特的机架中，而不是三个。使用此策略，文件的副本不会在机架之间均匀分布。三分之一的副本在一个节点上，三分之二的副本在一个机架上，其余的三分之一均匀分布在剩余的机架上。此策略可在不影响数据可靠性或读取性能的情况下提高写入性能。

HDFS 和 Map/Reduce 组件是机架感知的。

所述的NameNode和JobTracker的获得 架子ID通过调用的API在集群中的从站的 决心管理员配置的模块中。API 将从站的 DNS 名称（也是 IP 地址）解析为机架 ID。使用什么模块可以通过配置项topology.node.switch.mapping.impl进行配置。相同的默认实现运行使用topology.script.file.name配置的脚本/命令 。如果topology.script.file.name 未设置，则为任何传递的IP 地址返回机架ID /default-rack。Map/Reduce部分的附加配置是mapred.cache.task.levels确定缓存的级别数（在网络拓扑中）。因此，例如，如果它是默认值 2，则会构建两级缓存 - 一级用于主机（主机 -> 任务映射），另一级用于机架（机架 -> 任务映射）

https://hadoop.apache.org/docs/r1.2.1/hdfs_design.html


# _success 和 part-r-00000 文件是什么

https://stackoverflow.com/questions/10666488/what-are-success-and-part-r-00000-files-in-hadoop

# secondary namenode工作机制

1）第一阶段：NameNode启动
  （1）第一次启动NameNode格式化后，创建fsimage和edits文件。如果不是第一次启动，直接加载编辑日志和镜像文件到内存。
  （2）客户端对元数据进行增删改的请求。
  （3）NameNode记录操作日志，更新滚动日志。
  （4）NameNode在内存中对数据进行增删改查。
2）第二阶段：Secondary NameNode工作
  （1）Secondary NameNode询问NameNode是否需要checkpoint。直接带回NameNode是否检查结果。
  （2）Secondary NameNode请求执行checkpoint。
  （3）NameNode滚动正在写的edits日志。
  （4）将滚动前的编辑日志和镜像文件拷贝到Secondary NameNode。
  （5）Secondary NameNode加载编辑日志和镜像文件到内存，并合并。
  （6）生成新的镜像文件fsimage.chkpoint。
  （7）拷贝fsimage.chkpoint到NameNode。
  （8）NameNode将fsimage.chkpoint重新命名成fsimage。

## NameNode和SecondaryNameNode 的区别与联系

1）区别
  （1）NameNode负责管理整个文件系统的元数据，以及每一个路径（文件）所对应的数据块信息。
  （2）SecondaryNameNode主要用于定期合并命名空间镜像和命名空间镜像的编辑日志。
2）联系：
  （1）SecondaryNameNode中保存了一份和namenode一致的镜像文件（fsimage）和编辑日志（edits）。
  （2）在主namenode发生故障时（假设没有及时备份数据），可以从SecondaryNameNode恢复数据。


https://github.com/wangzhiwubigdata/God-Of-BigData/blob/master/%E9%9D%A2%E8%AF%95%E7%B3%BB%E5%88%97/Hadoop%E9%9D%A2%E8%AF%95%E9%A2%98%E6%80%BB%E7%BB%93/Hadoop%E9%9D%A2%E8%AF%95%E9%A2%98%E6%80%BB%E7%BB%93%EF%BC%88%E4%BA%8C%EF%BC%89%E2%80%94%E2%80%94HDFS.md