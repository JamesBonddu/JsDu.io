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