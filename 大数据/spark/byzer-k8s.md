# spark on k8s 原理

https://cloud.tencent.com/developer/article/1675534

https://spark.apache.org/docs/3.1.1/running-on-kubernetes.html#client-mode

https://www.xsky.com/news/6656/

## spark on k8s的几种模式

- Standalone：在 K8S 启动一个长期运行的集群，所有 Job 都通过 spark-submit 向这个集群提交

- Kubernetes Native：通过 spark-submit 直接向 K8S 的 API Server 提交，申请到资源后启动 Pod 做为 Driver 和 Executor 执行 Job，参考 http://spark.apache.org/docs/2.4.6/running-on-kubernetes.html

spark on k8s支持cluster和client两种模式。

- 在cluster模式下，driver运行在pod中，spark-submit脚本会启动一个k8s client，该client负责调用k8s api。由于driver也运行在pod中，所以集群中的excutor容器可以直接访问。
- 在客户端模式下，driver在集群外部运行，并调用Kubernetes API来创建和销毁执行器Pods。driver必须可以从集群中路由，以便excutor容器与之进行通信

- Spark Operator：安装 Spark Operator，然后定义 spark-app.yaml，再执行 kubectl apply -f spark-app.yaml，这种申明式 API 和调用方式是 K8S 的典型应用方式，https://github.com/GoogleCloudPlatform/spark-on-k8s-operator

https://blog.51cto.com/zhangxueliang/3128990

https://ieevee.com/tech/2017/08/31/spark-on-k8s.html

https://tianchi.aliyun.com/forum/postDetail?postId=81662


https://developer.aliyun.com/article/712250
https://kubernetes.io/blog/2018/03/apache-spark-23-with-native-kubernetes/

https://weidongzhou.wordpress.com/2018/04/29/running-spark-on-kubernetes/

https://techblog.cisco.com/blog/scaling-spark-k8s


## spark on k8s 启动流程

http://fanyilun.me/2021/08/22/Spark%20on%20Kubernetes%E4%BD%9C%E4%B8%9A%E6%89%A7%E8%A1%8C%E6%B5%81%E7%A8%8B/


## k8s的网络通信模式
Kubernetes的四种网络

- Container-to-Container networking：容器到容器的网络
- Pod-to-Pod networking：pod到pod的网络
- Pod-to-Service networking：pod到service的网络
- Internet-to-Service networking：internet到service的网络

https://kubesphere.com.cn/forum/d/1310-kubernets

## api 网关 on k8s

https://www.apiseven.com/blog/use-apisix-ingress-in-kubesphere

## kubesphere_devops源码阅读

http://www.iceyao.com.cn/post/2021-09-28-kubesphere_devops/

## spark on k8s 计算存储分离

https://juicefs.com/zh-cn/blog/solutions/why-disaggregated-compute-and-storage-is-future

## spark shuffle service 优化

https://www.baifachuan.com/posts/36faeace.html

https://main.qcloudimg.com/raw/document/product/pdf/1424_70963_cn.pdf


# 加速方法

spark + alluxio

https://docs.alluxio.io/os/user/stable/cn/core-services/Caching.html

http://startogether.ai/activities/sql-boy-review


# k8s 部署 byzer engine k8s过程

```sh
./byzerup run \
--kube-config  ~/.kube/config \
--engine-name byzer-engine-turing   \
--engine-version 2.3.1 \
--engine-service-account-name byzer \
--engine-namespace byzer-ns \
--engine-executor-core-num 1   \
--engine-executor-num 1   \
--engine-executor-memory "1024" \
--engine-driver-core-num 1   \
--engine-driver-memory "1024" \
--storage-name jfs \
--storage-meta-url  "redis://192.168.211.212:32044/1"

./byzerup run \
--kube-config  ~/.kube/config \
--engine-name byzer-engine-turing   \
--engine-version 3.3.0-latest \
--engine-image byzer/byzer-lang-k8s:3.3.0-latest \
--engine-service-account-name byzer \
--engine-namespace byzer-ns \
--engine-executor-core-num 1   \
--engine-executor-num 1   \
--engine-executor-memory "1024" \
--engine-driver-core-num 1   \
--engine-driver-memory "1024" \
--storage-name jfs \
--storage-meta-url  "redis://192.168.211.212:32044/1"

--engine-access-token mlsql  \
```

example
```sh
./byzer-k8s-deploy run \
--kube-config ~/.kube/config \
 --engine-name byzer-engine \
 --engine-image byzer/byzer-lang-k8s:3.1.1-2.2.2 \
 --engine-executor-core-num 1 \
 --engine-executor-num 1  \
 --engine-executor-memory 1024 \
 --engine-driver-core-num 1  \
 --engine-driver-memory 1024 \
 --engine-jar-path-in-container local:///home/deploy/mlsql/libs/streamingpro-mlsql-spark_3.0_2.12-2.2.2.jar  \
 --storage-name jfs \
 --storage-meta-url redis://192.168.0.121:6379/1
```

.engine.config  example

```sh
engine.spark.kubernetes.container.image.pullPolicy=IfNotPresent
engine.streaming.datalake.path=./data/
```


## k8s 对外暴露服务的方式

https://kubesphere.io/zh/blogs/kubesphere-loadbalance/

# k8s

```yaml
kind: Pod
apiVersion: v1
metadata:
  name: byzer-engine-turing-55a2c783cedeaef4-exec-1
  namespace: byzer-ns
  labels:
    spark-app-selector: spark-application-1665623044100
    spark-exec-id: '1'
    spark-exec-resourceprofile-id: '0'
    spark-role: executor
  annotations:
    cni.projectcalico.org/containerID: fe1d1d37d255390095e2115797420cef35a6dcf14f4109d34f58536acaa4d17f
    cni.projectcalico.org/podIP: ''
    cni.projectcalico.org/podIPs: ''
spec:
  volumes:
    - name: spark-conf-volume-exec
      configMap:
        name: spark-exec-17624d83cedeb0c9-conf-map
        items:
          - key: core-site.xml
            path: core-site.xml
            mode: 420
        defaultMode: 420
    - name: spark-local-dir-1
      emptyDir: {}
    - name: kube-api-access-gkbh2
      projected:
        sources:
          - serviceAccountToken:
              expirationSeconds: 3607
              path: token
          - configMap:
              name: kube-root-ca.crt
              items:
                - key: ca.crt
                  path: ca.crt
          - downwardAPI:
              items:
                - path: namespace
                  fieldRef:
                    apiVersion: v1
                    fieldPath: metadata.namespace
        defaultMode: 420
  containers:
    - name: spark-kubernetes-executor
      image: 'byzer/byzer-lang-k8s-base:3.1.1-2.3.1'
      args:
        - executor
      ports:
        - name: blockmanager
          containerPort: 7079
          protocol: TCP
      env:
        - name: SPARK_USER
          value: root
        - name: SPARK_DRIVER_URL
          value: 'spark://CoarseGrainedScheduler@10.233.70.71:35179'
        - name: SPARK_EXECUTOR_CORES
          value: '1'
        - name: SPARK_EXECUTOR_MEMORY
          value: 2048m
        - name: SPARK_APPLICATION_ID
          value: spark-application-1665623044100
        - name: SPARK_CONF_DIR
          value: /opt/spark/conf
        - name: SPARK_EXECUTOR_ID
          value: '1'
        - name: SPARK_RESOURCE_PROFILE_ID
          value: '0'
        - name: SPARK_EXECUTOR_POD_IP
          valueFrom:
            fieldRef:
              apiVersion: v1
              fieldPath: status.podIP
        - name: SPARK_CLASSPATH
          value: >-
            /home/deploy/byzer-lang/libs/juicefs-hadoop-0.17.5-linux-amd64.jar:/home/deploy/byzer-lang/libs/ansj_seg-5.1.6.jar:/home/deploy/byzer-lang/libs/nlp-lang-1.7.8.jar:/home/deploy/byzer-lang/plugin/mlsql-assert-3.0_2.12-0.1.0-SNAPSHOT.jar:/home/deploy/byzer-lang/mlsql-excel-3.0_2.12-0.1.0-SNAPSHOT.jar:/home/deploy/byzer-lang/plugin/mlsql-ext-ets-3.0_2.12-0.1.0-SNAPSHOT.jar:/home/deploy/byzer-lang/plugin/mlsql-shell-3.0_2.12-0.1.0-SNAPSHOT.jar:/home/deploy/byzer-lang/plugin/mlsql-mllib-3.0_2.12-0.1.0-SNAPSHOT.jar
        - name: SPARK_JAVA_OPT_0
          value: '-Dspark.network.timeout=28800s'
        - name: SPARK_JAVA_OPT_1
          value: '-Dspark.driver.port=35179'
        - name: SPARK_JAVA_OPT_2
          value: '-Dspark.mlsql.log.driver.port=46696'
        - name: SPARK_JAVA_OPT_3
          value: '-Dspark.ps.cluster.driver.port=7778'
        - name: SPARK_LOCAL_DIRS
          value: /var/data/spark-b62a3893-c2f4-48d5-8b87-e156e5625058
      resources:
        limits:
          cpu: '2'
          memory: 2432Mi
        requests:
          cpu: '2'
          memory: 2432Mi
      volumeMounts:
        - name: spark-conf-volume-exec
          mountPath: /opt/spark/conf
        - name: spark-local-dir-1
          mountPath: /var/data/spark-b62a3893-c2f4-48d5-8b87-e156e5625058
        - name: kube-api-access-gkbh2
          readOnly: true
          mountPath: /var/run/secrets/kubernetes.io/serviceaccount
      terminationMessagePath: /dev/termination-log
      terminationMessagePolicy: File
      imagePullPolicy: IfNotPresent
  restartPolicy: Never
  terminationGracePeriodSeconds: 30
  dnsPolicy: ClusterFirst
  serviceAccountName: byzer-sa
  serviceAccount: byzer-sa
  nodeName: node6
  securityContext: {}
  hostname: byzer-engine-turing-55a2c783cedeaef4-exec-1
  schedulerName: default-scheduler
  tolerations:
    - key: node.kubernetes.io/not-ready
      operator: Exists
      effect: NoExecute
      tolerationSeconds: 300
    - key: node.kubernetes.io/unreachable
      operator: Exists
      effect: NoExecute
      tolerationSeconds: 300
  priority: 0
  enableServiceLinks: true
  preemptionPolicy: PreemptLowerPriority
```

byzer engine

```yaml
kind: Pod
apiVersion: v1
metadata:
  name: byzer-engine-turing-f5669c966-c65xh
  generateName: byzer-engine-turing-f5669c966-
  namespace: byzer-ns
  labels:
    app: byzer-engine-turing
    pod-template-hash: f5669c966
  annotations:
    cni.projectcalico.org/containerID: 6e06679135d62ff78ad846a831e275a8a468408ef00a28fe9a79d80b527f7f47
    cni.projectcalico.org/podIP: 10.233.70.71/32
    cni.projectcalico.org/podIPs: 10.233.70.71/32
spec:
  volumes:
    - name: spark-conf
      configMap:
        name: byzer-engine-turing-core-site-xml
        defaultMode: 420
    - name: kube-api-access-wxkhl
      projected:
        sources:
          - serviceAccountToken:
              expirationSeconds: 3607
              path: token
          - configMap:
              name: kube-root-ca.crt
              items:
                - key: ca.crt
                  path: ca.crt
          - downwardAPI:
              items:
                - path: namespace
                  fieldRef:
                    apiVersion: v1
                    fieldPath: metadata.namespace
        defaultMode: 420
  containers:
    - name: byzer-engine-turing
      image: 'byzer/byzer-lang-k8s-base:3.1.1-2.3.1'
      command:
        - /bin/sh
        - '-c'
      args:
        - >-
          echo "/work/spark-3.1.1-bin-hadoop3.2/bin/spark-submit --master
          k8s://https://192.168.211.213:6443 --deploy-mode client
          --driver-memory 4048m             --executor-memory 2048m
          --driver-class-path
          /home/deploy/byzer-lang/libs/juicefs-hadoop-0.17.5-linux-amd64.jar:/home/deploy/byzer-lang/libs/ansj_seg-5.1.6.jar:/home/deploy/byzer-lang/libs/nlp-lang-1.7.8.jar:/home/deploy/byzer-lang/plugin/mlsql-assert-3.0_2.12-0.1.0-SNAPSHOT.jar:/home/deploy/byzer-lang/mlsql-excel-3.0_2.12-0.1.0-SNAPSHOT.jar:/home/deploy/byzer-lang/plugin/mlsql-ext-ets-3.0_2.12-0.1.0-SNAPSHOT.jar:/home/deploy/byzer-lang/plugin/mlsql-shell-3.0_2.12-0.1.0-SNAPSHOT.jar:/home/deploy/byzer-lang/plugin/mlsql-mllib-3.0_2.12-0.1.0-SNAPSHOT.jar
          --class streaming.core.StreamingApp --conf
          spark.kubernetes.driver.request.cores=2 --conf
          spark.kubernetes.executor.request.cores=2 --conf
          spark.executor.extraClassPath=/home/deploy/byzer-lang/libs/juicefs-hadoop-0.17.5-linux-amd64.jar:/home/deploy/byzer-lang/libs/ansj_seg-5.1.6.jar:/home/deploy/byzer-lang/libs/nlp-lang-1.7.8.jar:/home/deploy/byzer-lang/plugin/mlsql-assert-3.0_2.12-0.1.0-SNAPSHOT.jar:/home/deploy/byzer-lang/mlsql-excel-3.0_2.12-0.1.0-SNAPSHOT.jar:/home/deploy/byzer-lang/plugin/mlsql-ext-ets-3.0_2.12-0.1.0-SNAPSHOT.jar:/home/deploy/byzer-lang/plugin/mlsql-shell-3.0_2.12-0.1.0-SNAPSHOT.jar:/home/deploy/byzer-lang/plugin/mlsql-mllib-3.0_2.12-0.1.0-SNAPSHOT.jar
          --conf
          spark.kubernetes.container.image=byzer/byzer-lang-k8s-base:3.1.1-2.3.1
          --conf spark.kubernetes.namespace=byzer-ns --conf
          spark.kubernetes.authenticate.driver.serviceAccountName=byzer-sa
          --conf spark.kubernetes.executor.request.cores=2 --conf
          spark.kubernetes.executor.limit.cores=2 --conf
          spark.executor.instances=2 --conf spark.driver.host=$POD_IP --conf
          spark.mlsql.auth.access_token=mlsql --conf
          \"spark.kubernetes.container.image.pullPolicy=IfNotPresent\" --conf
          \"spark.kubernetes.context=byzer-ns\"
          local:///home/deploy/byzer-lang/main/byzer-lang-3.1.1-2.12-2.3.1.jar
          -streaming.name byzer-engine-turing -streaming.rest true
          -streaming.thrift false -streaming.platform spark
          -streaming.spark.service true -streaming.job.cancel true
          -streaming.driver.port 9003  \" -streaming.datalake.path\"
          \"./data/\"  " | bash
      env:
        - name: POD_IP
          valueFrom:
            fieldRef:
              apiVersion: v1
              fieldPath: status.podIP
      resources:
        limits:
          cpu: '4'
          memory: 8096Mi
        requests:
          cpu: '2'
          memory: 4048Mi
      volumeMounts:
        - name: spark-conf
          mountPath: /work/spark-3.1.1-bin-hadoop3.2/conf
        - name: kube-api-access-wxkhl
          readOnly: true
          mountPath: /var/run/secrets/kubernetes.io/serviceaccount
      terminationMessagePath: /dev/termination-log
      terminationMessagePolicy: File
      imagePullPolicy: Always
  restartPolicy: Always
  terminationGracePeriodSeconds: 30
  dnsPolicy: ClusterFirst
  serviceAccountName: default
  serviceAccount: default
  nodeName: node5
  securityContext: {}
  schedulerName: default-scheduler
  tolerations:
    - key: node.kubernetes.io/not-ready
      operator: Exists
      effect: NoExecute
      tolerationSeconds: 300
    - key: node.kubernetes.io/unreachable
      operator: Exists
      effect: NoExecute
      tolerationSeconds: 300
  priority: 0
  enableServiceLinks: true
  preemptionPolicy: PreemptLowerPriority
```




# k8s 安装 byzer

删除实例

```sh
./byzerup delete --kube-config  ~/.kube/config --engine-name byzer-engine-turing  --engine-namespace byzer-ns

# 查看日志和运行状态
[root@node3 byzerup]# kubectl get pods --all-namespaces |grep byzer-ns
byzer-ns                       byzer-engine-turing-59c8c76df8-c7fqs                              0/1     ContainerCreating   0              4m46s
[root@node3 byzerup]# kubectl get pods --namespace byzer-ns
NAME                                   READY   STATUS              RESTARTS   AGE
byzer-engine-turing-59c8c76df8-c7fqs   0/1     ContainerCreating   0          10m

```
https://jimmysong.io/kubernetes-handbook/concepts/configmap.html

https://kubernetes.io/zh-cn/docs/concepts/configuration/configmap/

https://zhengzhou1992.github.io/2021/05/%E5%AE%9E%E7%8E%B0%E5%A4%9A-k8s-%E5%A4%9A-pod-%E5%AE%9E%E6%97%B6%E6%97%A5%E5%BF%97%E6%9F%A5%E7%9C%8B/


https://zhuanlan.zhihu.com/p/553688233


# spark on k8s调度

https://jimmysong.io/kubernetes-handbook/usecases/running-spark-with-kubernetes-native-scheduler.html


https://developer.aliyun.com/article/768355


https://spark.apache.org/docs/latest/running-on-kubernetes.html#resource-allocation-and-configuration-overview
