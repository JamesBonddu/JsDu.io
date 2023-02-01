
# spark on k8s

简而言之，spark standalone on kubernetes 有如下几个缺点：

无法对于多租户做隔离，每个用户都想给 pod 申请 node 节点可用的最大的资源。
Spark 的 master／worker 本来不是设计成使用 kubernetes 的资源调度，这样会存在两层的资源调度问题，不利于与 kuberentes 集成。
而 kubernetes native spark 集群中，spark 可以调用 kubernetes API 获取集群资源和调度。要实现 kubernetes native spark 需要为 spark 提供一个集群外部的 manager 可以用来跟 kubernetes API 交互。

使用 kubernetes 原生调度的 spark 的基本设计思路是将 spark 的 driver 和 executor 都放在 kubernetes 的 pod 中运行，另外还有两个附加的组件：ResourceStagingServer 和 KubernetesExternalShuffleService。

Spark driver 其实可以运行在 kubernetes 集群内部（cluster mode）可以运行在外部（client mode），executor 只能运行在集群内部，当有 spark 作业提交到 kubernetes 集群上时，调度器后台将会为 executor pod 设置如下属性：

- 使用我们预先编译好的包含 kubernetes 支持的 spark 镜像，然后调用 CoarseGrainedExecutorBackend main class 启动 JVM。
- 调度器后台为 executor pod 的运行时注入环境变量，例如各种 JVM 参数，包括用户在 spark-submit 时指定的那些参数。
- Executor 的 CPU、内存限制根据这些注入的环境变量保存到应用程序的 SparkConf 中。
- 可以在配置中指定 spark 运行在指定的 namespace 中。

https://www.helloworld.net/p/9534492240

https://spark.apache.org/docs/latest/running-on-kubernetes.html

https://jimmysong.io/kubernetes-handbook/usecases/running-spark-with-kubernetes-native-scheduler.html



# docker spark

https://zhuanlan.zhihu.com/p/421375012

https://github.com/s1mplecc/spark-hadoop-docker

https://developers.weixin.qq.com/community/develop/article/doc/0004486f288110a898cb012fa51c13


# spark on k8s 执行流程

http://fanyilun.me/2021/08/22/Spark%20on%20Kubernetes%E4%BD%9C%E4%B8%9A%E6%89%A7%E8%A1%8C%E6%B5%81%E7%A8%8B/

http://geosmart.github.io/2021/11/21/SparkOnK8S%E8%B8%A9%E5%9D%91%E8%AE%B0%E5%BD%95/



# spark 云原生部署方式

spark 部署mater-slave hadoop 集群

https://testdriven.io/blog/deploying-spark-on-kubernetes/


spark 通过livy同spark 集群沟通

https://github.com/jupyter-incubator/sparkmagic/blob/master/docker-compose.yml

字节的CloudShuffleService

https://github.com/bytedance/CloudShuffleService

https://github.com/bytedance/CloudShuffleService/blob/main/README_zh.md

# spark 性能调优

https://blog.csdn.net/littlePYR/article/details/104713847

https://www.qubole.com/blog/introducing-quboles-spark-tuning-tool


# spark on k8s

https://www.danielsobrado.com/blog/spark-create-cluster/

https://github.com/big-data-europe/docker-spark


https://marcel-jan.eu/datablog/2020/10/25/i-built-a-working-hadoop-spark-hive-cluster-on-docker-here-is-how/


https://gist.github.com/y0ngb1n/7e8f16af3242c7815e7ca2f0833d3ea6


https://github.com/alibaba/celeborn


https://medium.com/@rachit1arora/apache-spark-shuffle-service-there-are-more-than-one-options-c1a8e098230e

# spark k8s 提交方式

https://mp.weixin.qq.com/s/hbKml9cHvfUBbH-lH4E3wA
