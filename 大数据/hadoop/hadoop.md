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

# 大数据集群管理方式

大数据集群管理方式分为手工方式（Apache hadoop）和工具方式（Ambari + hdp 和Cloudera Manger + CDH）。

总的来说：

如果对服务集成或二次开发有需求的话，可以选择 ambari 。
如果对集群稳定性要求高，服务集成相对弱的话，可以选择 cloudera manager 。

https://community.cloudera.com/t5/Support-Questions/comparison-of-Ambari-and-Cloudera-Manager/td-p/102038


https://chu888chu888.gitbooks.io/hadoopstudy/content/Content/3/chapter0303.html

https://cloud.tencent.com/developer/article/1809751

# ambari

https://github.com/apache/ambari

https://github.com/sequenceiq/docker-ambari

## HDP对比CDH

https://blog.hming.org/2019/07/03/hdp-yu-cdh-dui-bi/

https://docs.cloudera.com/HDPDocuments/HDP3/HDP-3.1.4/release-notes/content/comp_versions.html

## ambari 2.7.4 + HDP 3.1.4

Ambari在线安装特别慢，所以使用离线安装，建议使用迅雷下载

名称	地址
ambari	http://public-repo-1.hortonworks.com/ambari/centos7/2.x/updates/2.7.4.0/ambari-2.7.4.0-centos7.tar.gz
HDP	http://public-repo-1.hortonworks.com/HDP/centos7/3.x/updates/3.1.4.0/HDP-3.1.4.0-centos7-rpm.tar.gz
HDP-UTILS	http://public-repo-1.hortonworks.com/HDP-UTILS-1.1.0.22/repos/centos7/HDP-UTILS-1.1.0.22-centos7.tar.gz
（2021.06.19更新）鉴于有很多用户反映离线包已收费，这里提供一下白度云地址：链接: https://pan.baidu.com/s/1obECabArXjHmZXVuxxpdYQ 提取码: ma4e

JDK8环境

名称	地址
OracleJDK	https://www.oracle.com/java/technologies/javase-jdk8-downloads.html


https://www.cnblogs.com/shook/p/12409759.html

## ambari 2.7.5 + HDP 3.1.5

https://docs.cloudera.com/HDPDocuments/HDP3/HDP-3.1.5/release-notes/content/comp_versions.html

https://docs.cloudera.com/HDPDocuments/Ambari-2.7.5.0/bk_ambari-installation/content/hdp_315_repositories.html

## 下载

https://ambari.apache.org/

https://docs.cloudera.com/HDPDocuments/Ambari-2.7.0.0/bk_ambari-installation/content/download_the_ambari_repo.html


https://cwiki.apache.org/confluence/display/AMBARI/Installation+Guide+for+Ambari+2.7.5

https://www.yinxiang.com/everhub/note/cf31361a-f451-416c-bb02-fe132c540f5a

## Ambari2.7整体编译+安装使用

https://cloud.tencent.com/developer/article/1375511



## ambari 安装方式

https://hwilu.github.io/2018/01/02/%E4%BD%BF%E7%94%A8ambari%E5%AE%89%E8%A3%85hdp%E9%9B%86%E7%BE%A4%E5%AE%8C%E5%85%A8%E5%8F%82%E8%80%83%E6%89%8B%E5%86%8C/

https://cwiki.apache.org/confluence/display/AMBARI/Ambari

https://support.huaweicloud.com/dpmg-hdp-kunpengbds/kunpengbds_04_0014.html



https://osamaoracle.com/2020/03/22/install-apache-ambari-on-ubuntu-18-04-to-manage-hadoop/

https://blog.csdn.net/weijiasheng/article/details/104792428

https://docs.cloudera.com/HDPDocuments/Ambari-2.7.5.0/bk_ambari-installation/content/install-ambari-server-ubuntu18.html

https://blog.csdn.net/cp_panda_5/article/details/79989575


https://cdap.atlassian.net/wiki/spaces/DOCS/pages/480412478/Installation+using+Apache+Ambari

centos7 安装ambari-2.6.1

https://www.cnblogs.com/mymelody/p/9253643.html


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

阿里云一键部署 Hadoop 分布式集群

https://developer.aliyun.com/article/73766

https://hadoop.apache.org/

https://hadoop.apache.org/docs/stable/hadoop-project-dist/hadoop-common/SingleCluster.html

https://github.com/xingtanzjr/hadoop-on-kubernetes

## k8s 上部署 hadoop

部署 Kerberos 认证的 HDFS 本来就是一件比较麻烦的事，那么如果遇到 K8S 呢？也就是需要把 HDFS 部署到 K8S 集群上，并且带有 Kerberos 认证的呢，那恐怕就既要懂的 Hadoop 安全集群的搭建又要一点 K8S 的实践基础。


https://github.com/ifilonenko/hadoop-kerberos-helm

https://cloud.tencent.com/developer/article/1674898


https://github.com/Comcast/kube-yarn

https://github.com/helm/charts/tree/master/stable/hadoop

## k8s 部署cdh

https://blog.windawings.com/research/kubernetes-cloudera.html

CDH + Kylin

https://segmentfault.com/a/1190000037559639

https://github.com/zq2599/blog_demos



# CDH 部署

## 安装位置

http://www.amoscloud.com/?p=2638

https://docs.cloudera.com/documentation/enterprise/6/release-notes/topics/rg_cdh_6_packaging.html

http://wo2099.com/2021/02/21/centos7%E9%83%A8%E7%BD%B2cdh6-3-2%E9%9B%86%E7%BE%A4/

## CDH 配套

CDH 6.3.2

Component|	Component Version	Changes| Information
-|-|-
Apache Avro	| 1.8.2	| Changes
Apache Flume	| 1.9.0	| Changes
Apache Hadoop	| 3.0.0	| Changes
Apache HBase	| 2.1.4	| Changes
HBase Indexer	| 1.5	| Changes
Apache Hive	| 2.1.1	| Changes
Hue	| 4.3.0	| Changes
Apache Impala	| 3.2.0	| Changes
Apache Kafka	| 2.2.1	| Changes
Kite SDK	| 1.0.0	| Changes
Apache Kudu	| 1.10.0| 	Changes
Apache Solr	| 7.4.0	| Changes
Apache Oozie	| 5.1.0	| Changes
Apache Parquet	| 1.9.0	| Changes
Parquet-format	| 2.4.0	| Changes
Apache Pig	| 0.17.0| 	Changes
Apache Sentry	| 2.1.0	| Changes
Apache Spark	| 2.4.0	| Changes
Apache Sqoop	| 1.4.7	| Changes
Apache ZooKeeper	| 3.4.5	| Changes


## ubuntu18.04 安装CM6.3.1 + CDH 6.3.2


https://blog.csdn.net/weixin_45883933/article/details/106202292



### Cloudera免费版节点数限制

Cloudera免费版现在不允许集群节点数超过100，具体如下描述：

1.单个Cloudera Manager管理的所有CDH6.x集群所包含的主机总数不允许超过100个，如果超过，增加主机会失败。

2.如果Cloudera Manager管理的集群主机数量超过100，Cloudera Manager不允许将集群升级到CDH6.x。如果你主机总数超过100，从Cloudera Manager6.0升级到6.1会失败，这时你需要移除一些主机使总数小于100，然后重新升级才能成功。

注意：如果你从Cloudera企业版降级为Cloudera免费版后，并且你的主机数量超过了100，这时Cloudera Manager会禁用集群管理的所有功能除了停止集群。如果主机总数超过100，你将无法重启集群或以其他方式使用集群，必须使用Cloudera Manager删除主机使主机总数小于100后才能恢复正常。

https://cloud.tencent.com/developer/article/1419293

https://cloud.tencent.com/developer/article/1588989

## 部署

https://www.cnblogs.com/swordfall/p/10816797.html


https://jiamaoxiang.top/2021/01/24/CDH%E9%9B%86%E7%BE%A4%E5%AE%89%E8%A3%85%E9%83%A8%E7%BD%B2/

https://bbs.huaweicloud.com/blogs/detail/110064


https://github.com/heibaiying/BigData-Notes/blob/master/notes/installation/Hadoop%E9%9B%86%E7%BE%A4%E7%8E%AF%E5%A2%83%E6%90%AD%E5%BB%BA.md


https://monkeywie.cn/2020/04/14/cdh6-2-install/

## CDH 和HDP 到CDP

https://blog.csdn.net/Allenzyg/article/details/108197147


## CDH 自动部署脚本

https://github.com/chubbyjiang/cdh-deploy-robot

https://github.com/iconsider/setup_cdh_cluster

https://github.com/ymc-geko/ansible-cdh-cluster

https://github.com/bjddd192/ansible-playbooks-cdh6


https://github.com/AlionSSS/CDH-Install-Manual


# CDH 手动搭建步骤

## CDH 6.1 支持的系统版本


Ubuntu	
16.04 LTS (Xenial)

https://docs.cloudera.com/documentation/enterprise/6/release-notes/topics/rg_os_requirements.html#c61_supported_os

## 依赖位置

## CDH 和Apache Hadoop对比

Hadoop大致可分为Apache Hadoop和第三方发行版本Hadoop。考虑到Hadoop集群部署的高效性，集群的稳定性以及后期集中的配置管理，业界大多使用Cloudera公司的发行版CDH。

　　Apache Hadoop社区版本虽然完全开源免费，但是也存在诸多问题：
　　　　（1）版本管理比较混乱，让人有些无所适从；
　　　　（2）集群部署配置较为复杂，通常安装集群需要编写大量的配置文件，分发到每一台节点上，容易出错，效率低下；
　　　　（3）对集群的监控，运维，需要安装第三方的其他软件，运维难度比较大；
　　　　（4）在Hadoop生态圈中，组件的选择和使用，比如Hive，Mahout，Sqoop，Flume，Spark，Oozie等，需要大量考虑兼容性的问题，经常会浪大量的时间去编译组件，解决版本冲突问题。

　　CDH版本的Hadoop的优势在于：
　　　　（1）基于Apache协议，100%开源，版本管理清晰；
　　　　（2）在兼容性，安全性，稳定性上比Apache Hadoop有大幅度的增强；
　　　　（3）运维简单方便，对于Hadoop集群提供管理，诊断，监控，配置更改等功能，使得运维工作非常高效，而且集群节点越来越多，优势越明显。
　　　　（4）CDH提供成体系的文档，很多大公司的应用案例以及商业支持等。

## Cloudera Manager 6.3.1 下载地址

https://archive.cloudera.com/cm6/6.3.1/generic/jar/cm_api/

https://segmentfault.com/a/1190000040342022



## ambari

Ambari 官方资料入口：
https://www.cloudera.com/products/open-source/apache-hadoop/apache-ambari.html

Ambari 相关 rpm 包：
https://docs.cloudera.com/HDPDocuments/Ambari-2.7.3.0/bk_ambari-installation/content/ambari_repositories.html

HDP 相关 rpm 包：
https://docs.cloudera.com/HDPDocuments/Ambari-2.7.3.0/bk_ambari-installation/content/hdp_31_repositories.html

Ambari 相关软件版本适配表：
https://supportmatrix.hortonworks.com/

Ambari 2.7 安装思维导图：
https://cdn.jsdelivr.net/gh/841809077/blog-img/20191201/20191224005347.jpg

Ambari 2.7 安装配置教程：
https://mp.weixin.qq.com/s?__biz=MzU3MTc1NzU0Mg==&mid=2247483940&idx=1&sn=7c35e51f61458ac5f92909a05012fb99&scene=19#wechat_redirect

Ambari 2.7.3.0 界面通过 yum 安装 hadoop 服务时报错的解决方式：
https://community.cloudera.com/t5/Community-Articles/ambari-2-7-3-Ambari-writes-Empty-baseurl-values-written-to/ta-p/249314

https://www.zybuluo.com/Vany/note/297036


https://www.cnblogs.com/chevin/p/9929140.html

https://www.cnblogs.com/shun7man/p/12368349.html

https://jiyiren.github.io/2017/11/09/CDH/

http://www.amoscloud.com/?p=2638

https://www.cnblogs.com/shun7man/p/12368349.html

## 国双基于ambari搭建

https://www.gridsum.com/web/upload/2020/12/30/16092957150136jfyv7.pdf

https://docs.ksyun.com/documents/5864

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

# 商业版集群

## UDSP

https://uclub.ucloud.cn/article/560.html

https://www.ucloud.cn/site/product/usdp.html

https://m.ucloud.cn/mobile/product/usdp.html

## 华为鲲鹏

https://support.huaweicloud.com/prtg-cdh-kunpengbds/kunpenghadoopcdh632_02_0010.html

# 业界大数据集群的扩展方案

https://www.infoq.cn/article/gtlguya2mo8rgbwndt2x

https://mp.weixin.qq.com/s/_AumiAx9wbpOZCGMdf0Arw


https://www.infoq.cn/article/d*dxy1kj1su2enlf5fei


# hadoop 的oss配置

https://blog.csdn.net/mnasd/article/details/90181532

https://developer.aliyun.com/article/277304

# hadoop 的联邦机制  HDFS Federation 联邦机制

单组Namenode只允许整个集群有一个活动的Namenode，管理所有的命名空间。随着集群规模的增长，在1000个节点以上的大型Hadoop集群中，单组Namenode的局限性越发的明显，主要表现在以下几个方面：

扩展性：Namenode内存使用和元数据量正相关。180GB堆内存配置下，元数据量红线约为7亿，而随着集群规模和业务的发展，即使经过小文件合并与数据压缩，仍然无法阻止元数据量逐渐接近红线。

可用性：随着元数据量越来越接近7亿，CMS GC频率也越来越高，期间也曾发生过一次在CMS GC过程中由于大文件“get Block location”并发过高导致的promotion fail。

性能：随着集群规模增长，Namenode响应的RPC QPS也在逐渐提高。越来越高并发的读写，与Namenode的粗粒度元数据锁，使Namenode RPC响应延迟和平均RPC队列长度都在慢慢提高。

隔离性：由于Namenode没有隔离性设计，单一对Namenode负载过高的应用，会影响到整个集群的服务能力。

 
既然单组Namenode存在上述局限性，那么为什么要通过Federation的方式横向拓展Namenode，纵向拓展Namenode为什么不行？不选择纵向拓展Namenode的原因主要体现在以下三个方面：

启动时间长：Namenode启动需要将元数据加载到内存中，具有128 GB Java Heap的Namenode启动一次大概需要40分钟到1个小时，那512GB呢？

调试困难：对大JVM Heap进行调试比较困难，优化Namenode的内存使用性价比比较低。

集群易宕机：Namenode在Full GC时，如果发生错误将会导致整个集群宕机。

为什么要引入Federation
1.采用Federation的最主要的原因是简单，Federation能够快速的解决大部分单Namenode的问题。

2.Federation是简单鲁棒的设计，由于联邦中各个Namenode之间是相互独立的。Federation整个核心设实现大概用了3.5个月。大部分改变是在Datanode、Config和Tools，而Namenode本身的改动非常少，这样Namenode的原先的鲁棒性不会受到影响。比分布式的Namenode简单，虽然这种事先的扩展性比起真正的分布式的Namenode要小些，但是可以迅速满足需求。

3.Federation良好的向后兼容性，已有的单Namenode的部署配置不需要进行太大的改变就可以继续工作。

https://www.cnblogs.com/xinfang520/p/10397360.html

https://blog.csdn.net/lb812913059/article/details/79718875


https://blog.csdn.net/weixin_42486226/article/details/99581546



https://cloud.tencent.com/developer/article/1349375

https://mp.weixin.qq.com/s?__biz=MzI4OTY3MTUyNg==&mid=2247492135&idx=4&sn=ee96877a2461972e4ff73cc85e42f9cd&chksm=ec29322edb5ebb381d4acc2071e8db68bf8fb489ffa1216855a25e2207262165534e90c91536&scene=21#wechat_redirect

# hadoop 添加namenode

https://www.bigdatas.cn/forum.php?mod=viewthread&tid=59057&highlight=%BC%AF%C8%BA

# hadoop 商业版解决方案

阿里E-MapReduce

https://help.aliyun.com/document_detail/28068.html

阿里EMR hadoop组件版本

https://help.aliyun.com/document_detail/132036.html

