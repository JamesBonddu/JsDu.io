# mysql集群

## mysql 高可用 GTID

https://blog.csdn.net/Enmotech/article/details/107479240

https://blog.csdn.net/qq_40378034/article/details/91125768

https://cloud.tencent.com/developer/article/1120513

## PXC

PXC是Percona XtraDB Cluster的缩写，是 Percona 公司出品的免费MySQL集群产品。PXC的作用是通过mysql自带的Galera集群技术，将不同的mysql实例连接起来，实现多主集群。在PXC集群中每个mysql节点都是可读可写的，也就是主从概念中的主节点，不存在只读的节点。

https://segmentfault.com/a/1190000037760128

## 读写分离和常见开源数据库中间件


功能|	Sharding-JDBC|	TDDL|	Amoeba|	Cobar|	MyCat
-|-|-|-|-|-
基于客户端还是服务端|	客户端|	客户端|	服务端|	服务端|	服务端
分库分表|	有|	有|	有|	有|	有
MySQL交互协议|	JDBC Driver	JDBC Driver|	前端用NIO,后端用JDBC Driver|	前端用NIO,后端用BIO	前后端均用NIO
支持的数据库|	任意|	任意|	任意|	MySQL|	任意

https://blog.csdn.net/rexct392358928/article/details/105104712

https://blog.51cto.com/u_15080016/2620587

https://github.com/sysown/proxysql

https://mp.weixin.qq.com/s/Wxjlg3QNCo09hurS32bRtg

## mysql proxy代理

https://cloud.tencent.com/developer/article/1696210

https://cloud.tencent.com/developer/article/1429052

分库分表方案

https://zhuanlan.zhihu.com/p/137368446

https://mp.weixin.qq.com/s/A5SnwL4Gzin6Sz2weu9Bzw

## proxysql

https://proxysql.com/documentation/

https://github.com/patrickallaert/MySQL-Proxy-scripts-for-devs

https://www.cnblogs.com/rongfengliang/p/10850674.html

https://github.com/rongfengliang/proxysql-docker-compose

https://proxysql.com/Documentation/configuring-proxySQL/

https://breeze2.github.io/blog/practice-mysql-proxysql-docker-compose.html

https://blog.frognew.com/2017/08/proxysql-1.4-and-mysql-group-replication.html#2proxysql-141%E5%92%8Cmysql-group-replication

https://www.cnblogs.com/kevingrace/p/10411457.html

https://juejin.cn/post/6844904036718608392

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