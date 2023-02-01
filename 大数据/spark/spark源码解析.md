# spark 源码解析

https://xkx9431.github.io/spark-internals/scheduler/TaskSetManager/

# spark sql JIT编译

https://www.waitingforcode.com/apache-spark-sql/generated-method-too-long-be-jit-compiled/read


https://www.waitingforcode.com/apache-spark-sql/who-when-how-what-apache-spark-sql-code-generation/read

https://github.com/bartosz25/spark-scala-playground/issues/12


# sparksql TaskScheduler底层调度器

RDD -> DAGScheduler -> TaskScheduler -> Worker

Spark 多个Stage执行执行逻辑:
Stage 可以并行执行的
存在依赖的Stage 必须在依赖的Stage执行完成后才能执行下一个Stage
Stage的并行度取决于资源数

https://www.cnblogs.com/hframe/p/6927673.html

https://blog.csdn.net/weixin_45723348/article/details/107392903

https://blog.csdn.net/qq_16669583/article/details/106033492

https://www.cnblogs.com/saowei/p/15992034.html

https://blog.csdn.net/qq_37588493/article/details/83011899

# spark job 执行

这里，大家会有点疑惑，我明明是执行了两条语句(load/select)啊，为什么这里打印说当前只有一个 job？

因为 Byzer-lang 有 描述/执行 两个概念。 正常情况，load/select 之类的都是描述语句，而 save 语句是实际触发执行的语句。 在调试的过程中，我们需要查看 load/select 的结果，所以系统会自动把最后一句当做 执行 动作来做。 此时 load/select 两条语句会被合并成一个执行计划来执行。 对于一个复杂的脚本，DefaultMLSQLJobProgressListener 会自动拆解出哪些是执行语句，并且得到所有执行语句的条数，以及当前正在运行的执行语句，从而正确的评估出脚本进度。

MLSQL应用层执行触发机制（本次分享不涉及AI与机器学习内容），大纲如下：
Action（行动）触发执行，依赖执行；

- 一棵树（一个Action）分支并发执行；
- 多棵树（多个Action）顺序执行；
- 多次引用临时视图重复计算；
- Insert & Save的爱与伤。
首先先介绍一个概念，什么是视图？

视图(VIEW)也被称作虚表，即虚拟的表，是一组数据的逻辑表示,其本质是对应于一条SELECT语句，结果集被赋予一个名字，即视图名字。字面意思是可以看的图，比如建筑图纸。可以看到，但只有在实施的时候才会建造。

对应MLSQL中的as语法（MLSQL的另一个定位是，让不懂技术的数据分析和数据使用者，快速的进行大规模数据处理，比如产品、市场对于它的理解可能比较浅，很容易理解as为把数据计算完成并加载进来的意思，重复引用不会触发重复计算）。

目前的Action有3种情况：
insert/save操作一定触发执行；

- select/load脚本，是最后一个操作则触发执行；

- ET操作--传统SQL无法解决，需要用代码进行处理的封装的工具。目前常用的都是dataframe操作，触发执行与select操作相同。（不包括特殊类型，如cache - 不建议使用，具体使用看文档）

注意：

- as语法是把一个结果注册成一张临时视图，并不会进行计算或加载到内存中。除非脚本最后一个操作是as，系统会进行collect调用，并触发计算；

依赖的意思是，Action触发时候引用的视图将执行，注册未引用的视图不执行。

https://mp.weixin.qq.com/s/kLdD_THHWuWgjJ4Y2CgMDw

```scala
 private def _run(code: String,
                   context: MLSQLExecuteContext,
                   jobInfo: MLSQLJobInfo,
                   spark: SparkSession,
                   fetchResult: (DataFrame) => Unit,
                   reuseContext: Boolean,
                   reuseExecListenerEnv: Boolean) = {

    JobManager.run(spark, jobInfo, () => {

      val newContext = if (!reuseContext) {
        val ssel = context.execListener.clone(spark)
        val newContext = new MLSQLExecuteContext(ssel, context.owner, context.home, jobInfo.groupId, context.userDefinedParam)
        ScriptSQLExec.setContext(newContext)
        if (!reuseExecListenerEnv) {
          newContext.execListener.env().clear()
        }
        List("SKIP_AUTH", "HOME", "OWNER").foreach { item =>
          newContext.execListener.env().put(item, context.execListener.env().get(item).get)
        }
        newContext
      } else context
      val skipAuth = newContext.execListener.env().getOrElse("SKIP_AUTH", "false").toBoolean
      val skipPhysical = newContext.execListener.env().getOrElse("SKIP_PHYSICAL", "false").toBoolean
      ScriptSQLExec.parse(code, newContext.execListener, false, skipAuth, skipPhysical, false)
      context.execListener.getLastSelectTable() match {
        case Some(tableName) =>
          if (spark.catalog.tableExists(tableName)) {
            val df = spark.table(tableName)
            fetchResult(df)
            Option(df)
          }
          else None
        case None => None
      }
    })
  }


// src/main/java/tech/mlsql/job/JobManager.scala

  def run(session: SparkSession, job: MLSQLJobInfo, f: () => Unit): Unit = {

    val context = ScriptSQLExec.contextGetOrForTest()
    context.execListener.addJobProgressListener(new DefaultMLSQLJobProgressListener())
    try {
      _jobListeners.foreach { f => f.onJobStarted(new JobStartedEvent(job.groupId)) }
      if (_jobManager == null) {
        f()
      } else {
        session.sparkContext.setJobGroup(job.groupId, job.jobName, true)
        _jobManager.groupIdToMLSQLJobInfo.put(job.groupId, job)
        f()
      }

    } finally {
      handleJobDone(job.groupId)
      session.sparkContext.clearJobGroup()
      _jobListeners.foreach { f => f.onJobFinished(new JobFinishedEvent(job.groupId)) }
    }
  }
```

在script进行run的过程中通过`ScriptSQLExec` 和任务处理progressListener中解析后的`statements`语句来决定获取action算子触发操作.
针对于
```scala
val actionSet = Set("save", "insert", "train", "run", "predict")
```
等操作都会触发action算子

jobinfo
```scala
def getJobInfo(owner: String,
                jobType: String,
                jobName: String,
                jobContent: String,
                timeout: Long): MLSQLJobInfo = {
val startTime = System.currentTimeMillis()
val groupId = _jobManager.nextGroupId
MLSQLJobInfo(owner, jobType, jobName, jobContent, groupId, new MLSQLJobProgress(0, 0), startTime, timeout)
}
```


```scala
class DefaultMLSQLJobProgressListener extends MLSQLJobProgressListener with Logging with WowLog {

  val actionSet = Set("save", "insert", "train", "run", "predict")
  var counter = 0

  override def before(name: String, sql: String): Unit = {
    counter += 1
    val context = ScriptSQLExec.contextGetOrForTest()
    val job = JobManager.getJobInfo.filter(f => f._1 == context.groupId).head._2
    // only save/insert will trigger execution

    def getHead(str: String) = {
      str.trim.toLowerCase().split("\\s+").head
    }

    val statements = context.execListener.preProcessListener.get.statements

    val actions = statements.filter { statement =>
      actionSet.contains(getHead(statement))
    }

    var finalSize = actions.size
    if (!actionSet.contains(getHead(statements.last))) {
      finalSize += 1
    }
    var shouldLog = false

    if (actionSet.contains(name)) {
      job.progress.increment
      job.progress.script = sql
      shouldLog = true
    }
    job.progress.totalJob = finalSize

    if (counter == statements.size && !actionSet.contains(name)) {
      job.progress.currentJobIndex = job.progress.totalJob
      job.progress.script = sql
      shouldLog = true
    }
    if (shouldLog && !job.progress.script.startsWith("load _mlsql_.")) {
      logInfo(format(s"Total jobs: ${job.progress.totalJob} current job:${job.progress.currentJobIndex} job script:${job.progress.script} "))
    }


  }

  override def after(name: String, sql: String): Unit = {

  }
}
```

```scala
// src/main/java/streaming/dsl/ScriptSQLExec.scala
  override def exitSql(ctx: SqlContext): Unit = {

    def getText = {
      val input = ctx.start.getTokenSource().asInstanceOf[DSLSQLLexer]._input

      val start = ctx.start.getStartIndex()
      val stop = ctx.stop.getStopIndex()
      val interval = new Interval(start, stop)
      input.getText(interval)
    }

    def before(clzz: String) = {
      _jobListeners.foreach(_.before(clzz, getText))
    }

    def after(clzz: String) = {
      _jobListeners.foreach(_.after(clzz, getText))
    }
}
```

语法解析并执行
```scala
// src/main/java/streaming/dsl/ScriptSQLExec.scala
def _parse(input: String, listener: DSLSQLListener) = {
val loadLexer = new DSLSQLLexer(new CaseChangingCharStream(input))
val tokens = new CommonTokenStream(loadLexer)
val parser = new DSLSQLParser(tokens)

parser.setErrorHandler(new MLSQLErrorStrategy)
parser.addErrorListener(new MLSQLSyntaxErrorListener())

val stat = parser.statement()
ParseTreeWalker.DEFAULT.walk(listener, stat)
}
```


https://books.japila.pl/spark-sql-internals/QueryExecution/

https://blog.csdn.net/thinktothings/article/details/84726769?spm=a2c6h.12873639.article-detail.6.46701b60Y13FzI

https://zhuanlan.zhihu.com/p/490263108

spark action 操作

https://blog.csdn.net/alionsss/article/details/107225329

# collect触发job执行

https://developer.aliyun.com/article/675430


# spark scheduler
Spark的任务调度开销非常大。对于一个复杂的任务，业务逻辑代码执行时间大约是3-7ms,但是整个spark运行的开销大概是1.3s左右。

经过详细dig发现，sparkContext里RDD转化时，会对函数进行clean操作，clean操作的过程中，默认会检查是不是能序列化（就是序列化一遍，没抛出异常就算可以序列化）。而序列化成本相当高（默认使用的JavaSerializer并且对于函数和任务序列化，是不可更改的），单次序列化耗时就达到200ms左右，在local模式下对其进行优化，可以减少600ms左右的请求时间。

https://blog.csdn.net/allwefantasy/article/details/82883703
https://www.slidestalk.com/mlsql/Deep_Dive_Scheduler_in_Apache_Spark89573

# spark rpc支持

https://blog.csdn.net/allwefantasy/article/details/82883703?spm=1001.2014.3001.5502

# spark task 级别调度
TaskSetManager

https://blog.csdn.net/u012387141/article/details/105816090

# spark 内存管理

https://www.cnblogs.com/LXL616/p/11165976.html

ContextCleaner是一个Spark服务，负责在应用程序范围内清除 shuffles, RDDs, broadcasts, accumulators和checkpointed RDDs，目的是减少长时间运行的数据密集型Spark应用程序的内存需求。

ContextCleaner在驱动程序上运行。 它会在SparkContext启动时被创建并立即启动（并且默认情况下spark.cleaner.referenceTracking Spark属性已启用），生命周期：当SparkContext停止时，它停止。

https://www.cnblogs.com/hanhaotian/p/11712370.html

# byzer 通过spark 动态添加job

大神，现在所有的job都是放在一个spark app里面，所以所有的job的执行时间间隔都是一样的，能有办法实现不同的job的时间间隔不同？ 另外如果我job很多的情况下，都放在一个app里面会有问题？

在一个spark app 实例里，没有办法实现不同Job 时间间隔不一致。

Q: 所以所有的job的执行时间间隔都是一样的，能有办法实现不同的job的时间间隔不同
A: job 都放在同一个配置文件，然后启动时加上 streaming.jobs 参数指定需要启动的job 。这样配置文件统一了，根据时间分组，启动不同app 实例

Q: 另外如果我job很多的情况下，都放在一个app里面会有问题？
默认是顺序执行的。如果处理时间过程，可以通过spark 参数 spark.streaming.concurrentJobs 设置并行度。默认是1。 如果你单个Streaming实例资源有限，那么建议还是分开成多个实例执行比较好。

个人推荐：

最好是一个job 一个Streaming实例。资源科适当调小。这样你说的问题就都解决了。

首先我已经做了很多示例了，参看这些gist:

https://gist.github.com/allwefantasy

批处理任务的所有Compositor 都是在：

streaming.core.compositor.spark.source

流式处理的都在

streaming.core.compositor.spark.source.streaming

https://github.com/byzer-org/byzer-lang/issues/3

# spark sql 生成流程

codegen.CodeGenerator

spark.SparkContext: Starting job: apply at DatabricksLogging.scala:77

scheduler.DAGScheduler

memory.MemoryStore

storage.BlockManagerInfo

scheduler.TaskSetManager

cluster.YarnScheduler

scheduler.DAGScheduler: ShuffleMapStage 2 (apply at DatabricksLogging.scala:77) finished in 3.654 s
2022-12-07 17:20:32,649 INFO scheduler.DAGScheduler: looking for newly runnable stages
2022-12-07 17:20:32,650 INFO scheduler.DAGScheduler: running: Set()
2022-12-07 17:20:32,650 INFO scheduler.DAGScheduler: waiting: Set(ResultStage 3)
2022-12-07 17:20:32,651 INFO scheduler.DAGScheduler: failed: Set()
2022-12-07 17:20:32,653 INFO scheduler.DAGScheduler: Submitting ResultStage 3 (MapPartitionsRDD[28] at apply at DatabricksLogging.scala:77), which has no missing parents
2022-12-07 17:20:32,680 INFO memory.MemoryStore: Block broadcast_2 stored as values in memory (estimated size 427.7 KB, free 8.0 GB)
2022-12-07 17:20:32,684 INFO memory.MemoryStore: Block broadcast_2_piece0 stored as bytes in memory (estimated size 110.3 KB, free 8.0 GB)
2022-12-07 17:20:32,684 INFO storage.BlockManagerInfo: Added broadcast_2_piece0 in memory on cdh06.com:39104 (size: 110.3 KB, free: 8.0 GB)
2022-12-07 17:20:32,685 INFO spark.SparkContext: Created broadcast 2 from broadcast at DAGScheduler.scala:1161
2022-12-07 17:20:32,685 INFO scheduler.DAGScheduler: Submitting 1 missing tasks from ResultStage 3 (MapPartitionsRDD[28] at apply at DatabricksLogging.scala:77) (first 15 tasks are for partitions Vector(0))
2022-12-07 17:20:32,685 INFO cluster.YarnScheduler: Adding task set 3.0 with 1 tasks
2022-12-07 17:20:32,688 INFO scheduler.FairSchedulableBuilder: Added task set TaskSet_3.0 tasks to pool default
2022-12-07 17:20:32,689 INFO scheduler.TaskSetManager: Starting task 0.0 in stage 3.0 (TID 51, cdh01.com, executor 1, partition 0, NODE_LOCAL, 7778 bytes)
2022-12-07 17:20:32,695 INFO storage.BlockManagerInfo: Added broadcast_2_piece0 in memory on cdh01.com:39535 (size: 110.3 KB, free: 5.9 GB)
2022-12-07 17:20:32,709 INFO spark.MapOutputTrackerMasterEndpoint: Asked to send map output locations for shuffle 1 to 172.19.211.155:45184
2022-12-07 17:20:32,774 INFO scheduler.TaskSetManager: Finished task 0.0 in stage 3.0 (TID 51) in 86 ms on cdh01.com (executor 1) (1/1)
2022-12-07 17:20:32,774 INFO cluster.YarnScheduler: Removed TaskSet 3.0, whose tasks have all completed, from pool default
spark.ContextCleaner


INFO stream.MLSQLStreamManager: Start streaming job monitor....


 session.SparkSessionCacheManager: SparkSession for [admin] isn't cached, will create a new one.
