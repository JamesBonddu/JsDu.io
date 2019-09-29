# presto

Presto 是一个运行在集群上的分布式系统. 完整的安装需要一个协处理器和几个workers. 通过Presto CLI将查询传输到协处理器. 协处理器进行转换, 分析和计划query执行, 接着分发这些进程给wokres.


Presto 被设计用来处理数据仓库,和分析: 数据分析, 聚合大数据量的数据和产生报告. 常常被定义为Online Analytical Processing(OLAP).

Presto 的类型有两种 coordinatiors 和 workers.


## Requirements

Linux or Mac OS X
java8 64bit
python 2.4+


参考:

https://prestodb.github.io/
