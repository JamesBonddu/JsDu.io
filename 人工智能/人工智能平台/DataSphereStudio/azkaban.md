# azkaban

https://azkaban.readthedocs.io/en/latest/jobTypes.html

https://zhuanlan.zhihu.com/p/196561446

http://submitteddenied.github.io/azkaban2/documents/2.1/jobtypeplugin.html


## 如何编写任务
原生的 Azkaban 支持的plugin类型有以下这些：

- command：Linux shell命令行任务
- gobblin：通用数据采集工具
- hadoopJava：运行hadoopMR任务
- java：原生java任务
- hive：支持执行hiveSQL
- pig：pig脚本任务
- spark：spark任务
- hdfsToTeradata：把数据从hdfs导入Teradata
- teradataToHdfs：把数据从Teradata导入hdfs
其中最简单而且最常用的是command类型，我们在上一篇文章中已经描述了如何编写一个command的job任务。如果使用command类型，效果其实跟在本地执行Linux shell命令一样，这样的话，还不如把shell放到crontable 中运行。所以我们把重点放到Azkaban支持的比较常用的四种类型：java、hadoopJava、hive、spark


https://www.jianshu.com/p/f2310a5c38c6