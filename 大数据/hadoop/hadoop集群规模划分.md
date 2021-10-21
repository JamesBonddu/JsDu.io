# 集群规模

从测试/开发集群（小于10台），小规模集群（10-20台），中小规模集群（20-50台），中等规模集群（50-100台），大型集群（100-200台），超大规模集群（200-500台），巨型规模集群（500台以上）来分别讲述角色划分。

IO受限例子：

索引
分组
数据倒入导出
数据移动和转换
 
CPU受限例子：

聚类/分类
复杂的文本挖掘
特征提取
用户画像
自然语言处理

## 角色分配参考

https://www.cnblogs.com/xiqing/p/9645644.html

https://www.cndba.cn/dave/article/3372

## 小于10台

一般用于测试/开发集群，我们建议至少5台机器，没有高可用。一个管理节点主要用于安装NameNode和ResourceManager，工具节点和边缘节点复用一个，主要用于安装Cloudera Manager等，剩余3-7台工作节点。


https://cloud.tencent.com/developer/article/1035458

## 如何评估集群规模

需要多少计算资源可能不是特别好评估，推荐横向扩展，随业务规模和应用发展再考虑扩展。开始可以就按照数据量来评估数据规模，估计一下每天的数据增量？保存数据的周期是多少？有没有冷数据方案？

假设每天增长的数据为600G、3备份存储，以一年规划为例,大概存储为600G3360天=633T, 再考虑增加%20的预留，考虑未来数据增长的趋势，考虑应用计算等空间需求。为节省空间可考虑压缩存储（大概可以节省70%空间）。

https://www.cnblogs.com/zzjhn/p/11525140.html

## CDH硬件和集群需求

https://docs.cloudera.com/documentation/enterprise/latest/topics/cm_ig_host_allocations.html

https://docs.cloudera.com/documentation/enterprise/6/release-notes/topics/rg_hardware_requirements.html#concept_vvv_cxt_gbb


## 参考阿里云EMR最小集群规模配置

按量计费配置为:
```md
一台ecs.g6e.2xlarge的Master实例和两台ecs.g6e.xlarge的Core实例

ecs.g6e.2xlarge
8vCPU + 32G内存 + 100G存储

ecs.g6e.xlarge * 2

4vCPU + 16G内存 + 100G存储

总核数是 16 核 + 64G内存 + 300G存储.

此时价格为0.0413元/小时/核 *16 *1小时 = 0.66元。

月消耗:
0.66 * 24 * 30 = 475.2 
年消耗:
0.66 * 24 * 365 = 5781.6

包年包月配置为:

三个ecs.g5.2xlarge的包月的集群, 每个CPU是八核。
8*3 CPU + 32*3内存 + 100G存储

总核数是 24 核 + 96G内存 + 300G存储.

价格为19.13元/月/核 *24核* 1月 = 459.12元。
月消耗:
459.12
年消耗:
5509.44
```

https://help.aliyun.com/document_detail/106976.html

## 华为云MRS集群规模配置

Master和Core节点都选择“通用计算型S3->8核16GB(s3.2xlarge.2 )



https://support.huaweicloud.com/usermanual-mrs/mrs_01_0910.html

https://www.huaweicloud.com/pricing.html#/mrs

# 华为云集群拓扑方案

管理节点和控制节点合并部署，数据节点单独部署

(MN+CN) × 3 + DN × n
(推荐)数据节点数3-30时采用此方案

集群内节点部署在同一子网，集群内通过汇聚交换机二层互联。


https://support.huaweicloud.com/usermanual-mrs/mrs_01_0121.html?utm_campaign=ua&utm_content=mrs&utm_term=mrshelpcenter

# H3C 新华三

CloudOS平台至少部署在3个主机节点上，DataEngine至少部署在3个节点上，建议两个平台分开部署。

CPU数量

2路10核，2.0GHz

内存容量

256G

网口

2个千兆网口，2个万兆网口

http://www.h3c.com/cn/d_202002/1274935_30005_0.htm#_Toc33606560

# 添加节点和重新平衡

1. 在新节点上配置cloudera-scm-agent 连接的server节点
2. 登录CDH web管理界面操作集群添加节点


https://blog.csdn.net/Zsigner/article/details/102522405

https://www.cnblogs.com/yangshibiao/p/10868523.html

https://docs.cloudera.com/documentation/enterprise/6/6.3/topics/cm_mc_adding_hosts.html

# 迁移CDH集群元数据库

https://cloud.tencent.com/developer/article/1176740

https://docs.cloudera.com/documentation/enterprise/6/6.3/topics/admin_cm_ha_dbms.html

# CDH高可用集群配置方式

https://blog.csdn.net/ZZQHELLO2018/article/details/105161844

https://www.staroon.dev/2018/02/08/CDH5Install/


HMS MetastoreHA CDH的高可用配置

Metastore HA解决方案被设计用来处理metastore服务故障。当一个部署的metastore宕机时，metastore服务可能持续相当长的时间不可用，直到服务被重新拉起。为了避免这种服务中断情况，需要部署Hive Metastore HA模式。

https://mp.weixin.qq.com/s?__biz=MzI4OTY3MTUyNg==&mid=2247498762&idx=1&sn=10ebf5adf8e9bb4adc76dbd8d97734cd&chksm=ec292c03db5ea515e952616a2cc6743bee5d000b6020eb4294a39271d0a41bdd3bf8784f23a2&scene=21#wechat_redirect

HDFS-Hbase-Yarn的高可用配置

https://blog.csdn.net/silentwolfyh/article/details/86658133


给集群添加Gateway

https://cloud.tencent.com/developer/article/1078286

https://cloud.tencent.com/developer/article/1158339




# hdfs 高可用问题

hadoop2.2.0（HA）中HDFS的高可靠指的是可以同时启动2个NameNode。其中一个处于工作状态，另一个处于随时待命状态。这样，当一个NameNode所在的服务器宕机时，可以在数据不丢失的情况下，手工或者自动切换到另一个NameNode提供服务。 

这些NameNode之间通过共享数据，保证数据的状态一致。多个NameNode之间共享数据，可以通过Nnetwork File System或者Quorum Journal Node。前者是通过linux共享的文件系统，属于操作系统的配置；后者是hadoop自身的东西，属于软件的配置。

- namdenode和datanode是否分离?

https://bbs.csdn.net/topics/390887079

- NamdeNode高可用迁移

我们假设一个场景，你已经有一个CDH集群了，因为硬件或者OS升级，你需要把这个节点服务器拿出来进行维护处理，如果是DataNode是比较简单的，可以很简单的进行下线甚至暴力删除都可以直接将其从集群中剥离出来，但是如果这个节点是NameNode呢。其实Cloudera Manager也提供了界面化迁移角色的功能，比较方便，我们知道NameNode节点一般都会同时有NameNode，JournalNode和Failover Controller角色，Fayson本文会主要介绍如何迁移NameNode相关角色。

https://cloud.tencent.com/developer/article/1545706


- CDH误删NameNode故障恢复

https://cloud.tencent.com/developer/article/1078071


- CDH HDFS HA高可用

https://www.cndba.cn/dave/article/3378

https://blog.csdn.net/qq_36933797/article/details/105262276

HDFS 高可用 更新 Hive Metastore NameNode（先停止Hive）

https://blog.csdn.net/wangshuo2019/article/details/103050953

# 认证

cdh 版本的 hadoop 在对数据安全上的处理通常采用 Kerberos+Sentry 的结构。
kerberos 主要负责平台用户的用户认证，sentry 则负责数据的权限管理。

## OpenLDAP高可用

https://cloud.tencent.com/developer/article/1360828

## CDH配置Kerberos和Sentry 

https://blog.csdn.net/summer089089/article/details/107369994

https://blog.csdn.net/Java_Road_Far/article/details/106256873


## kerberos 高可用

https://blog.csdn.net/sinat_32176947/article/details/79605499

## 大数据权限与安全

https://cloud.tencent.com/developer/article/1368183


# CDH 实施踩坑经验

1. 平台规划注意事项
1.1 业务数据全部存储在datanode上面，所以datanode的存储空间必须足够大，且每个datanode的存储空间尽量保持一致。

1.2 管理节点/namenode对存储空间要求不高，主要存储各计算节点datanode的元数据信息，以3个datanode为例，每个datanode存储2T的数据，namenode才耗费80G的空间。

1.3 由于hadoop有数据副本机制，默认为3个副本，因此datanode节点，系统盘做raid 1，数据盘做raid 0；namenode做raid 5,不管系统盘还是数据盘，都可以直接更换，保证数据不丢失；

1.4 计算节点datanode依靠的是数量优势，除了存储空间足够大之外，对机器配置要求不高，但是安装spark和impala的话对内存的要求较高，单节点2T的数据配置64G的单机内存有点吃力。

1.5 但是namenode要跟所有的datanode交互，接收处理各种请求，对机器配置要求较高，以的测试数据来看，namenode存放80G的元数据时，64G的内存已经有点紧张了，开始使用交换内存了。

1.6 namenode和Secondary namenode需要各自独立的两个节点，即相互独立部署，这样即使namenode机器挂了，也可以手动从secondary namenode恢复一下。在Hadoop 2高可靠性下可以配置两个namenode，保证一个namenode出现问题可以自动切换至另一个。

1.7 由于secondary namenode的是周期性的合并日志文件，因此单独部署时对机器压力较小，空间使用也只勉强是namenode的一半，因此可以把诸如hive/hbase等的服务器端安装在snn所在的服务器上，这样可以使机器资源得到最大化利用。

1.8 hdfs空间不够开始报警，但是df –h命令下查看就会发现其实空间余额还有好几T，这种情况是由于non dfs used空间膨胀导致的，non dfs used和remaining一起构成了hdfs的可用空间容量，两者呈现此消彼长的关系。Non dfs used从字面理解来看是非hadoop文件占用的空间，实际上是某些文件删除之后，hadoop的组件没有释放对其引用导致的，从的情况来看，单个节点2T的数据运行一个月会产生600G的non dfs used空间，最笨的办法就是重启CDH，一下子占用就到1G以下了。


https://blog.csdn.net/thinkpadshi/article/details/71643618


# mysql集群

## mysql 高可用 GTID

https://blog.csdn.net/Enmotech/article/details/107479240


https://blog.csdn.net/qq_40378034/article/details/91125768

## 高可用方案
目前大多公司目前采用的有三种，PXC，MHA，MGR，MySQL5.6版本的采用MHA，5.7版本的采用MGR。注：所以mysql版本最好在5.7或8.0版本以上　　

　　PXC
　　　　PXC是Percona公司的(Percona XtraDB Cluster) 简称PXC。它是基于Galera协议的高可用集群方案。可以实现多个节点间的数据同步复制以及读写，并且可保障数据库的服务高可用及数据强一致性。
　　MHA
　　　　MHA（Master High Availability）目前在MySQL高可用方面是一个相对成熟的解决方案，该软件由两部分组成：MHA Manager（管理节点）和MHA Node（数据节点）。
　　MGR
　　　　MySQL官方推荐的一款高可用集群方案MySQL Group Replication，基于Paxos协议的状态机复制，彻底解决了基于传统的异步复制和半同步复制中数据一致性问题无法保证的情况，也让MySQL数据库涉及的领域更广，打开互联网金融行业的大门。　　　　
　　　　MGR是基于现有的MySQL架构实现的复制插件，可以实现多个主对数据进行修改，使用paxos协议复制，不同于异步复制的多Master复制集群。

　　　　支持多主模式，但官方推荐单主模式：

　　　　多主模式下，客户端可以随机向MySQL节点写入数据

　　　　单主模式下，MGR集群会选出primary节点负责写请求，primary节点与其它节点都可以进行读请求处理.

https://www.cnblogs.com/shumtn/p/13404817.html



# 集群配置需求

大数据集群配置
系统: centos 7
主节点:
8vCPU + 32G内存 + 100G存储
4个从节点每个机器配置
4vCPU + 16G内存 + 100G存储


业务服务器搭建MLSQL, Exchangis等:
系统: centos 7或ubuntu18
业务节点:
8vCPU + 32G内存 + 100G存储
