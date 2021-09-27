# oozie 

Oozie 是一个用于管理 Apache Hadoop 作业的工作流调度程序系统。

Oozie 工作流作业是动作的有向无环图 (DAG)。

Oozie Coordinator 作业是由时间（频率）和数据可用性触发的循环 Oozie 工作流作业。

Oozie 与 Hadoop 堆栈的其余部分集成，支持多种开箱即用的 Hadoop 作业类型（例如 Java map-reduce、Streaming map-reduce、Pig、Hive、Sqoop 和 Distcp）以及系统特定作业（例如Java 程序和 shell 脚本）。

Oozie 是一个可扩展、可靠和可扩展的系统。

Oozie工作流引擎

https://oozie.apache.org/docs/5.2.1/index.html

## Oozie的web监控

https://oozie.apache.org/docs/5.2.1/WebServicesAPI.html

## Oozie的身份验证

https://oozie.apache.org/docs/5.2.1/ENG_Custom_Authentication.html

## 工作流作业的生命周期

9.1 工作流作业生命周期
工作流作业可以处于以下任一状态：

PREP：首次创建工作流作业时，它将处于PREP状态。工作流作业已定义但未运行。

RUNNING：当CREATED工作流作业启动时，它进入RUNNING状态，它将保持RUNNING状态，直到达到其结束状态、错误结束或暂停。

暂停：一个RUNNING工作流程作业可以暂停，它会留在挂起直到工作流恢复作业，或者被杀死的状态。

SUCCEEDED：当RUNNING工作流作业到达结束节点时，它结束到达SUCCEEDED最终状态。

KILLED：当CREATED、RUNNING或SUSPENDED工作流作业被管理员或所有者通过向 Oozie 发出请求而终止时，工作流作业结束并达到KILLED最终状态。

FAILED：当RUNNING工作流作业由于意外错误而失败时，它会结束达到FAILED最终状态。

工作流作业状态有效转换：

- > PREP
准备–>跑步| 被杀
正在运行–>暂停| 成功| 杀死| 失败的
暂停–>运行| 被杀

https://oozie.apache.org/docs/5.2.1/WorkflowFunctionalSpec.html#a4_Parameterization_of_Workflows