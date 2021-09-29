# hadoop 文档


Hadoop各个组件的基本原理，处理过程和关键的知识点等，包括HDFS、YARN、MapReduce等。

HDFS: 分布式文件存储
YARN: 分布式资源管理
MapReduce: 分布式计算
Others: 利用YARN的资源管理功能实现其他的数据处理方式
内部各个节点基本都是采用Master-Woker架构

## HDFS

Hadoop Distributed File System，分布式文件系统

HDFS 的可靠性主要有以下几点:

- 冗余副本策略

可以在 hdfs-site.xml 中设置复制因子指定副本数量

　　所有数据块都可副本

　　DataNode 启动时,遍历本地文件系统,产生一份 HDFS 数据块和本地文件的对应关系列表 (blockreport) 汇报给 Namenode

- 机架策略

　HDFS 的"机架感知",通过节点之间发送一个数据包,来感应它们是否在同一个机架

　　一般在本机架放一个副本,在其他机架再存放一个副本,这样可以防止机架失效时丢失数据,也可以提高带宽利用率

- 心跳机制

NameNode 周期性从 DataNode 接受心跳信息和块报告

　　NameNode 根据块报告验证元数据

　　没有按时发送心跳的 DataNode 会被标记为宕机,不会再给他任何 I/O 请求

　　如果 DataNode 失效造成副本数量下降,并且低于预先设定的值,NameNode 会检测出这些数据库,并在合适的时机重新复制

　　引发重新复制的原因还包括数据副本本身损坏,磁盘错误,复制因子被增大等

- 安全模式

NameNode 启动时会先经过一个 "安全模式" 阶段

　　安全模式阶段不会产生数据写

　　在此阶段 NameNode 收集各个 DataNode 的报告, 当数据块达到最小副本数以上时,会被认为是"安全"的

　　在一定比例(可设置) 的数据块被确定为"安全" 后 ,在过若干时间,安全模式结束

　　当检测到副本数不足的数据块时,该块会被复制,直到达到最小副本数
- 效验和
- 回收站
- 元数据保护
映像文件和事物日志是 NameNode 的核心数据.可以配置为拥有多个副本

　　副本会降低 NameNode 的处理速度,但增加安全性

　　NameNode 依然是单点,如果发生故障要手工切换

- 快照机制



https://www.w3cschool.cn/hadoop/xvmi1hd6.html

- NameNode

    - 存储文件的metadata，运行时所有数据都保存到内存，整个HDFS可存储的文件数受限于NameNode的内存大小

    - 一个Block在NameNode中对应一条记录（一般一个block占用150字节），如果是大量的小文件，会消耗大量内存。同时map task的数量是由splits来决定的，所以用MapReduce处理大量的小文件时，就会产生过多的map task，线程管理开销将会增加作业时间。处理大量小文件的速度远远小于处理同等大小的大文件的速度。因此Hadoop建议存储大文件

    - 数据会定时保存到本地磁盘，但不保存block的位置信息，而是由DataNode注册时上报和运行时维护（NameNode中与DataNode相关的信息并不保存到NameNode的文件系统中，而是NameNode每次重启后，动态重建）

    - NameNode失效则整个HDFS都失效了，所以要保证NameNode的可用性

- Secondary NameNode

    - 定时与NameNode进行同步（定期合并文件系统镜像和编辑日志，然后把合并后的传给NameNode，替换其镜像，并清空编辑日志，类似于CheckPoint机制），但NameNode失效后仍需要手工将其设置成主机
- DataNode

    - 保存具体的block数据

    - 负责数据的读写操作和复制操作

    - DataNode启动时会向NameNode报告当前存储的数据块信息，后续也会定时报告修改信息

    - DataNode之间会进行通信，复制数据块，保证数据的冗余性

https://zhuanlan.zhihu.com/p/54994736

https://www.w3cschool.cn/hadoop/

https://hadoop.apache.org/docs/r1.0.4/cn/

http://dockone.io/article/4879

https://docs.rancher.cn/


# YARN

YARN就是将 JobTracker 的职责进行拆分，将资源管理和任务调度监控拆分成独立的进程：一个全局的资源管理和一个每个作业的管理（ApplicationMaster） ResourceManager 和 NodeManager 提供了计算资源的分配和管理，而 ApplicationMaster 则完成应用程序的运行

- ResourceManager: 全局资源管理和任务调度

    负责全局的资源管理和任务调度，把整个集群当成计算资源池，只关注分配，不管应用，且不负责容错

    资源管理
    - 以前资源是每个节点分成一个个的Map slot和Reduce slot，现在是一个个Container，每个Container可以根据需要运行ApplicationMaster、Map、Reduce或者任意的程序
    - 以前的资源分配是静态的，目前是动态的，资源利用率更高
    - Container是资源申请的单位，一个资源申请格式：<resource-name, priority, resource-requirement, number-of-containers>, resource-name：主机名、机架名或*（代表任意机器）, resource-requirement：目前只支持CPU和内存
    - 用户提交作业到ResourceManager，然后在某个NodeManager上分配一个Container来运行ApplicationMaster，ApplicationMaster再根据自身程序需要向ResourceManager申请资源
    - YARN有一套Container的生命周期管理机制，而ApplicationMaster和其Container之间的管理是应用程序自己定义的


- NodeManager: 单个节点的资源管理和监控
- ApplicationMaster: 单个作业的资源管理和任务监控
- Container: 资源申请的单位和任务运行的容器

https://www.w3cschool.cn/hadoop/rh161hda.html

https://www.cnblogs.com/cainiao-chuanqi/p/11420490.html

# hadoop集群搭建

## k8s 搭建hadoop集群

https://bbs.huaweicloud.com/blogs/127507

https://github.com/Alanthur/hadoop-kubernetes

https://github.com/ifilonenko/hadoop-kerberos-helm

https://github.com/cclient/kubernetes-hadoop

https://github.com/keremceliker/Deploy-a-Hadoop-Big-Data-Cluster-using-Cloudera-CDH-6.x-on-Docker-Container

配置文件修改

https://www.w3cschool.cn/hadoop/a86m1jyo.html


https://github.com/youngwookim/awesome-hadoop

## k8s install hadoop

https://blog.csdn.net/m0_46413065/article/details/115196370

https://github.com/xingtanzjr/hadoop-on-kubernetes


https://juejin.cn/post/6919873566435622926

https://blog.csdn.net/chenleiking/article/details/82467715

https://www.bilibili.com/medialist/play/381746344?from=space&business=space&sort_field=pubtime

## 安装hadoop

https://linuxconfig.org/how-to-install-hadoop-on-redhat-8-linux


https://hadoop.apache.org/

https://hadoop.apache.org/docs/stable/hadoop-project-dist/hadoop-common/SingleCluster.html


# 基于Rancher搭建K8s集群

https://docs.rancher.cn/docs/rancher2/cluster-admin/editing-clusters/_index/

https://jimmysong.io/kubernetes-handbook/guide/migrating-hadoop-yarn-to-kubernetes.html

# Rancher

https://www.bilibili.com/read/cv5941736?from=search

# rancker和k8s的区别

Rancher和k8s都是用来作为容器的调度与编排系统。但是rancher不仅能够管理应用容器，更重要的一点是能够管理k8s集群。Rancher2.x底层基于k8s调度引擎，通过Rancher的封装，用户可以在不熟悉k8s概念的情况下轻松的通过Rancher来部署容器到k8s集群当中。为实现上述的功能，Rancher自身提供了一套完整的用于管理k8s的组件，包括Rancher API Server, Cluster Controller, Cluster Agent, Node Agent等等。组件相互协作使得Rancher能够掌控每个k8s集群，从而将多集群的管理和使用整合在统一的Rancher平台中。Rancher增强了一些k8s的功能，并提供了面向用户友好的使用方式。


在这个部分的主要涉及的名词如下：

Rancher Server： 是用于管理和配置 Kubernetes 集群。您可以通过 Rancher Server 的 UI 与下游 Kubernetes 集群进行交互。
RKE（Rancher Kubernetes Engine)：是经过认证的 Kubernetes 发行版，它拥有对应的 CLI 工具可用于创建和管理 Kubernetes 集群。在 Rancher UI 中创建集群时，它将调用 RKE 来配置 Rancher 启动的 Kubernetes 集群。
K3s (轻量级 Kubernetes)： 和 RKE 类似，也是经过认证的 Kubernetes 发行版。它比 RKE 更新，更易用且更轻量化，全部组件都在一个小于 100 MB 的二进制文件中。从 Rancher v2.4 开始，Rancher 可以安装在 K3s 集群上。
RKE2是一个完全合规的 Kubernetes 发行版，专注于美国联邦政府部门的安全和合规性。
RancherD是安装 Rancher 的新工具，从 Rancher v2.5.4 开始提供。它是一个实验性功能。RancherD 是一个二进制文件，它首先启动一个 RKE2 Kubernetes 集群，然后在集群上安装 Rancher 服务器 Helm 图。


https://www.zhihu.com/question/309076492

https://xie.infoq.cn/article/d9e1838a0fdddd42ed90c87eb

https://rancher.com/docs/rancher/v2.5/en/installation/requirements/ports/


> 安装步骤参考


https://www.lishuai.fun/2020/12/02/rke-install-k8s/

rancher界面讲解

https://www.bilibili.com/video/BV1GL411x7B5?from=search&seid=1574902638464593121&spm_id_from=333.337.0.0

https://blog.csdn.net/aixiaoyang168/article/details/88600530


## RKE2部署k8s集群

https://docs.rancher.cn/docs/rancher2.5/installation/resources/k8s-tutorials/ha-rke2/_index/

https://docs.rke2.io/

https://www.bilibili.com/video/BV1x44y167YS?from=search&seid=6897200581127411691&spm_id_from=333.337.0.0

# 安装步骤

- 安装docker

```sh
curl https://releases.rancher.com/install-docker/20.10.sh | sh
```

https://github.com/rancher/install-docker

- 搭建私有镜像仓库

```sh
sudo docker run -d -p 5000:5000 -v /opt/data/registry:/var/lib/registry registry
```

配置 `/etc/docker/daemon.json`

```json
{
  "registry-mirror": [
    "https://hub-mirror.c.163.com",
    "https://mirror.baidubce.com"
  ],
  "insecure-registries": [
    "172.19.211.125:5000"
  ]
}
```

https://yeasy.gitbook.io/docker_practice/repository/registry

