# java--遇到NoSuchMethodError通用解决思路

```sh
java.lang.NoSuchMethodError: io.netty.util.NetUtil.toSocketAddressString(Ljava/lang/String;I)Ljava/l
```

https://www.cnblogs.com/xiaoMzjm/p/4566672.html

https://blog.csdn.net/menggudaoke/article/details/81197413


# spark 设置driver的本地jar优先时出现的jar包冲突问题

```sh
21/10/29 09:14:28  INFO JobManager: JobManager started with initialDelay=30 checkTimeInterval=5
Exception in thread "main" java.lang.LinkageError: loader constraint violation in interface itable initialization: when resolving method "org.apache.spark.ps.cluster.PSDriverBackend.org$apache$spark$internal$Logging$$log_()Lorg/slf4j/Logger;" the class loader (instance of org/apache/spark/util/ChildFirstURLClassLoader) of the current class, org/apache/spark/ps/cluster/PSDriverBackend, and the class loader (instance of sun/misc/Launcher$AppClassLoader) for interface org/apache/spark/internal/Logging have different Class objects for the type org/slf4j/Logger used in the signature
        at streaming.core.strategy.platform.SparkRuntime.createRuntime(SparkRuntime.scala:185)
        at streaming.core.strategy.platform.SparkRuntime.<init>(SparkRuntime.scala:63)
        at streaming.core.strategy.platform.SparkRuntime$.getOrCreate(SparkRuntime.scala:322)
        at streaming.core.strategy.platform.SparkRuntime.getOrCreate(SparkRuntime.scala)
        at sun.reflect.NativeMethodAccessorImpl.invoke0(Native Method)
        at sun.reflect.NativeMethodAccessorImpl.invoke(NativeMethodAccessorImpl.java:62)
        at sun.reflect.DelegatingMethodAccessorImpl.invoke(DelegatingMethodAccessorImpl.java:43)
        at java.lang.reflect.Method.invoke(Method.java:498)
        at streaming.core.strategy.platform.PlatformManager$.createRuntimeByPlatform(PlatformManager.scala:237)
        at streaming.core.strategy.platform.PlatformManager$.getRuntime(PlatformManager.scala:252)
        at streaming.core.strategy.platform.PlatformManager.run(PlatformManager.scala:117)
        at streaming.core.StreamingApp$.main(StreamingApp.scala:45)
        at streaming.core.StreamingApp.main(StreamingApp.scala)
        at sun.reflect.NativeMethodAccessorImpl.invoke0(Native Method)
        at sun.reflect.NativeMethodAccessorImpl.invoke(NativeMethodAccessorImpl.java:62)
        at sun.reflect.DelegatingMethodAccessorImpl.invoke(DelegatingMethodAccessorImpl.java:43)
        at java.lang.reflect.Method.invoke(Method.java:498)
        at org.apache.spark.deploy.JavaMainApplication.start(SparkApplication.scala:52)
        at org.apache.spark.deploy.SparkSubmit.org$apache$spark$deploy$SparkSubmit$$runMain(SparkSubmit.scala:851)
        at org.apache.spark.deploy.SparkSubmit.doRunMain$1(SparkSubmit.scala:167)
        at org.apache.spark.deploy.SparkSubmit.submit(SparkSubmit.scala:195)
        at org.apache.spark.deploy.SparkSubmit.doSubmit(SparkSubmit.scala:86)
        at org.apache.spark.deploy.SparkSubmit$$anon$2.doSubmit(SparkSubmit.scala:926)
        at org.apache.spark.deploy.SparkSubmit$.main(SparkSubmit.scala:935)
        at org.apache.spark.deploy.SparkSubmit.main(SparkSubmit.scala)
21/10/29 09:14:28 INFO storage.BlockManagerMasterEndpoint: Registering block manager cdh06.com:40133 with 366.3 MB RAM, BlockManagerId(7, cdh06.com, 40133, None)
```


https://stackoverflow.com/questions/36341756/spark-driver-extraclasspath-multiple-jars