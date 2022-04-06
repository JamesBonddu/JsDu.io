# ETL工具


https://github.com/pawl/awesome-etl

Kettle

https://www.kettle.net.cn/1260.html


https://github.com/topics/etl

# datax ETL

https://lzyz.fun/bloglist/datax/


# 主流ETL工具对比

http://synball.com/blog/article/-ETL/

https://mp.weixin.qq.com/s/O9r-1GFHAiiBb-JCXyl13Q

https://cloud.tencent.com/developer/article/1531141

https://jishuin.proginn.com/p/763bfbd5776e

https://www.cnblogs.com/qumogu/p/13524403.html

# datax

https://github.com/alibaba/DataX/blob/master/introduction.md


## datax 核心设计原理

DataX 核心主要由 Job、Task Group、Task、Channel 等概念组成：

1、Job

在 DataX 中用来描述一个源端到一个目的端的同步作业，是 DataX 数据同步面向用户的最小业务单元。一个Job 对应 一个 JobContainer， JobContainer 负责 Job 的全局切分、调度、前置语句和后置语句等工作。

2、Task Group

一组 Task 的集合，根据 DataX 的公平分配策略，公平地分配 Task 到对应的 TaskGroup 中。一个 TaskGroup 对应一个 TaskGroupContainer，负责执行一组 Task。

3、Task

Job 的最小执行单元，一个 Job 可根据 Reader 端切分策略，且分成若干个 Task，以便于并发执行。

Job、Task Group、Task 三者之间的关系可以用如下图表示：

https://objcoding.com/2020/09/06/datax/


## 商业版是DataWorks

https://help.aliyun.com/document_detail/146778.html

https://help.aliyun.com/document_detail/146777.html

## dbus

https://github.com/BriData/DBus


# 增量数据集成

https://www.cnblogs.com/ucarinc/p/9770990.html

https://github.com/ucarGroup/DataLink

# 基于datax的竞品对比

## addax

https://addax.readthedocs.io/zh/latest/

https://github.com/wgzhao/Addax


## datax-web

https://gitee.com/WeiYe-Jing/datax-web

https://github.com/WeiYe-Jing/datax-web

## Exchangis

https://github.com/WeBankFinTech/Exchangis

# 有赞数据仓库血缘关系

“表”是元数据系统的后台逻辑核心，数据仓库是构建在 Hive 之上，而 Hive 的原始数据往往来自于生产系统，也可能会把计算结果导出到外部存储，所以我们认为 Hive 表、mysql 表、hbase 表、BI 报表都是“表”，这些“表”间关系是一个 DAG，也就是血缘关系。

有了血缘关系，基于开源 jsmind 库做了展示，可以让用户清楚看到一张表的上下游，更方便地查找表。基于血缘关系可以做很多事情，例如：

结合表的更新时间，还可以找到调度 DAG 的关键路径，协助定位性能瓶颈；

当表出现变更时，可以通知下游责任人，以及自动对下游任务做 SQL 的静态检查；

辅助生命周期管理，找到没有被使用的表/字段；

辅助维护字段的一致性，如注释、校验规则复用。

业务域管理
以前我们会维护一张表格，记录数据仓库每个业务的对接人，方便用户找到我们。后来我们把这个表格扩展成了业务域管理，除了记录业务与人的关系，还可以看出每张表属于哪个业务。

受到了 apache ranger 的启发，我们使用表名匹配的方式来动态的计算表所归属的业务域，只需配置几十个业务域规则，而不用对每张表分别配置。而与 ranger 采样相同匹配规则，使得我们做到了表、用户、业务多个业务视角任意切换，提升了元数据系统的业务扩展性，开发效率大大提升。

https://blog.51cto.com/u_15127645/2779015

## 数据质量把控

我们记录了每个离线计算任务对应的 Hive 表，当某个任务执行结束，会立即做表行数/更新时间的采集。

文件大小/更新时间：metastore 有记录但是不准。我们完全基于 hdfs，读取文件的属性作为 Hive 表的大小与更新时间。再根据任务的启动时间，就可以得到计算出表所对应任务的执行时长。

行数：非常重要且明智的选择，使用 Presto 对全表或分区做 count 计算，这个 SQL 的执行效率是惊人的。对 orc 文件，简单的 count 计算，Presto 并不会整个文件扫描，而仅仅读取 orc 文件的 index data 部分就可以得到行数。在实际运行中，几亿行的表都可以秒级得到行数。为了采集表的行数，我们下定决定把所有 Hive 表的存储格式改成  orc。

表行数、文件大小、更新时间、运行时长的数据采集一段时间后，就可以形成曲线图，数据仓库管理员和开发者都可以从这个图中发现规律或数据质量问题，甚至业务系统开发者也会通过这个曲线图来查看业务量变化趋势。在行数采集的功能基础之上，我们还做了数据质量校验、数值分布探查等功能。把多个关键表的产出时间绘制到一张图里，可以清楚的看出数据仓库的稳定情况。
-----------------------------------
©著作权归作者所有：来自51CTO博客作者mob604756fe27f4的原创作品，请联系作者获取转载授权，否则将追究法律责任
有赞数据仓库元数据系统实践
https://blog.51cto.com/u_15127645/2779015


## hive按照年月日分区

https://blog.csdn.net/qq_34247077/article/details/102390764


## hive 全量和增量的思考

https://blog.css8.cn/post/11875833.html

https://segmentfault.com/a/1190000022783071

http://patamon.me/icemimosa/hive/hive%E5%A4%84%E7%90%86%E5%A2%9E%E9%87%8F%E6%95%B0%E6%8D%AE/
