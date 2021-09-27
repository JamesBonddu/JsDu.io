# datax ETL

https://lzyz.fun/bloglist/datax/


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
