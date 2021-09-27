# pyjava

http://blog.mlsql.tech/blog/pyjava-1.html

# MLSQL

mlsql如何初步加入贡献:

https://github.com/allwefantasy/mlsql/issues/1326


https://www.infoq.cn/article/ma627l7zy5hhghjojmbh

MLSQL架构

MLSQL Engine是执行MLSQL语言的分布式引擎，通过Antlr4(后续文章会讲解)定义和解析MLSQL语法，并翻译为Spark代码，在本地或集群执行；MLSQL是一种类SQL语言，通过类SQL的语法开发业务，执行计算。MLSQL的计算内核是Spark，但是内嵌python计算引擎和Spark交互，因此对机器学习的支持也是很强大的，也可以支持自定义计算引擎(如javascript)。MLSQL提供丰富的接口，满足大多自定义开发的需求。MLSQL太强大了，今天先做一个简单介绍，后续将开启MLSQL的探索之旅。

https://blog.csdn.net/zhaodedong/article/details/105926308

https://raysummit.anyscale.com/content/Videos/mANe3ZoQwD39mj3Bv

## mlsql使用antlr语法解析器

https://github.com/allwefantasy/mlsql/tree/020991597df578a7b9a654996fa5ff47119e8f16/external/mlsql-autosuggest


## mlsql 机器学习集成

https://flashgene.com/archives/214.html

## mlsql发展历程

我基本上划分了三个系统：

MLSQL Consle
MLSQL Cluster
MLSQL Engine
三个产品统称为MLSQL Stack。前两个是Web系统，Engine则是我们原来说的MLSQL,但是现在只是MLSQL Stack里一个产品。

https://blog.csdn.net/allwefantasy/article/details/89474187

# mlsql自定义数据源

# 自定义数据源插件开发

数据源主要应用于MLSQL的Load/Save语法里。尽管MLSQL提供了非常多的数据源支持[加载和存储多种数据源](http://docs.mlsql.tech/mlsql-stack/datasource/)，但肯定还有非常的数据源并没有被官方支持到。MLSQL为此提供了自定义数据源的支持。

通常，为了达成此目标，用户大体需要实现两个步骤：

1. 按Spark DataSource标准封装对应的数据源。因为Spark良好的生态储备，一般而言大部分数据源都会有Spark的Connector(DataSource)。 所以这一步实际上仅仅是引入相应的Connector Jar包即可。
2. 按MLSQL DataSource标准进一步封装Spark DataSource数据源（或者原生的数据源）。比如我么常用的jsonStr,csvStr等就没有使用Spark DataSource Connector,而是职级使用MLSQL DataSource标准实现的。

在这篇教程中，我们不会介绍Spark DataSource的开发，而是介绍MLSQL DataSource的标准。

# mlsql部署安装

## 装k8s

https://www.cnblogs.com/you-men/p/13192086.html

跟着官方文档从零搭建K8S

https://juejin.cn/post/6844903943051411469

## 安装kubeadm

https://kubernetes.io/zh/docs/setup/production-environment/tools/kubeadm/install-kubeadm/

https://gist.github.com/islishude/231659cec0305ace090b933ce851994a

centos 安装kubeadm

https://developer.aliyun.com/article/763983

安装kubeadm报错

https://blog.csdn.net/weixin_43168190/article/details/107227626

https://last2win.com/2020/01/30/k8s-install-and-use-and-fix-bug/

https://juejin.cn/post/6844903668269973511


## init 报错
I0630 11:23:37.443159   15080 version.go:185] fetching Kubernetes version from URL: https://dl.k8s.io/release/stable-1.txt
open /etc/kubernetes/admin.conf: no such file or directory
failed to load admin kubeconfig

# kube-dns 组件安装

https://jimmysong.io/blog/configuring-kubernetes-kube-dns/

# mlsql jdbc报错

https://stackoverflow.com/questions/6865538/solving-a-communications-link-failure-with-jdbc-and-mysql