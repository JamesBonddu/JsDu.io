# HELM

Helm 使用一种称为charts的打包格式。图表是描述一组相关 Kubernetes 资源的文件集合。单个图表可能用于部署一些简单的东西，比如 memcached pod，或者一些复杂的东西，比如带有 HTTP 服务器、数据库、缓存等的完整 Web 应用程序堆栈。

图表创建为在特定目录树中布置的文件。它们可以打包到要部署的版本化档案中。

如果您想下载并查看已发布图表的文件而不安装它，您可以使用helm pull chartrepo/chartname.

本文档解释了图表格式，并提供了使用 Helm 构建图表的基本指南。


https://helm.sh/

https://jimmysong.io/kubernetes-handbook/practice/helm.html

helm 安装官方仓库

https://github.com/helm/charts

https://github.com/helm/charts/issues/21103

https://artifacthub.io/


# helm 安装hadoop 安装 spark

https://github.com/JahstreetOrg/spark-on-kubernetes-helm

https://github.com/ifilonenko/hadoop-kerberos-helm

## 模板调试

```sh
helm lint 是验证chart是否遵循最佳实践的首选工具
helm install --dry-run --debug 或 helm template --debug：我们已经看过这个技巧了， 这是让服务器渲染模板的好方法，然后返回生成的清单文件。
helm get manifest: 这是查看安装在服务器上的模板的好方法。


```


https://helm.sh/docs/chart_template_guide/getting_started/

## helm 安装报错

just to add --generate-name at the end of helm command
```sh
helm install -n hdfs-pvs pv --generate-name

helm repo add stable https://kubernetes.oss-cn-hangzhou.aliyuncs.com/charts

helm repo remove stable

helm repo list

helm search repo prometheus-operator
```

配置国内源
https://www.cnblogs.com/a120608yby/p/10683502.html

https://www.chenshaowen.com/blog/configure-helm-mirror-in-china.html


https://stackoverflow.com/questions/57322873/how-to-fix-error-must-either-provide-a-name-or-specify-generate-name-in-he

## 使用helm 安装

```sh
# 使用安装
helm install --generate-name --namespace=hdfs-pvs pv 
root@node1:/data/hadoop-kerberos-helm# helm install --generate-name --namespace=hdfs-pvs pv 
Error: create: failed to create: namespaces "hdfs-pvs" not found
root@node1:/data/hadoop-kerberos-helm# helm version
version.BuildInfo{Version:"v3.2.1", GitCommit:"fe51cd1e31e6a202cba7dead9552a6d418ded79a", GitTreeState:"clean", GoVersion:"go1.13.10"}

root@node1:/data/hadoop-kerberos-helm# kubectl version --short
Client Version: v1.19.8
Server Version: v1.19.8
```

在此期间删除命名空间创建的更改helm install是有意的。这是为了模仿与kubectl create --namespace foo -f deployment.yaml- 命名空间是全局集群资源相同的行为，并且将资源安装到该命名空间中的用户可能没有安装命名空间本身的适当管理权限，因为这意味着您对集群具有完全管理权限（如与在特定命名空间内绑定到具有受限权限的角色相反）。如果没有此更改，用户必须具有集群管理员权限才能安装图表，并且我们希望确保管理员可以确保用户在每次安装时只能应用一组受限的角色。这也是当初 TIller 被下架的一个重要原因。

此外，社区中有几个要求允许修改命名空间helm install创建（例如#3503），而支持此类用例的 UX 实现起来会非常痛苦。将命名空间创建卸载到单独的工具（可能是插件？）为用户提供了一种解决这些问题的方法，而无需围绕这些用例强加限制性的用户体验。

注意：我只是转发我所知道的关于这个主题的信息以及它被删除的原因。我建议向@adamreese询问更多有关删除理由的信息。


Helm 3 发生了变化，它现在从本地 kube 配置中获取当前命名空间。如果它不存在，则使用默认命名空间。

要更改 alpha 的当前命名空间，您可以使用

kubectl set-context NAME --namespace=foo
Helm 将在您下次调用它时选择并使用该命名空间。

Helm 3 中进行了一些设计重构，以解决从 CLI 标志和 kube 配置加载设置的优先级问题。据我了解，--namespace 标志已被暂时删除，但计划允许以某种方式即时更改命名空间。

@adamreese你还有什么其他的上下文我可能在这里遗漏了为什么我们删除了 --namespace 标志？

您好，正确切换不同上下文的命令应该是这样的：

kubectl config set-context CONTENT_NAME --namespace NAMESPACE
例子：

kubectl config set-context gke_xxx_top_us-east1-b_my-test --namespace qa

https://github.com/helm/helm/issues/5753

https://github.com/helm/helm/issues/5628

https://helm.sh/docs/intro/quickstart/

# kubctl

使用kubectl来管理Kubernetes集群。

```sh
kubectl annotate – 更新资源的注解。
kubectl api-versions – 以“组/版本”的格式输出服务端支持的API版本。
kubectl apply – 通过文件名或控制台输入，对资源进行配置。
kubectl attach – 连接到一个正在运行的容器。
kubectl autoscale – 对replication controller进行自动伸缩。
kubectl cluster-info – 输出集群信息。
kubectl config – 修改kubeconfig配置文件。
kubectl create – 通过文件名或控制台输入，创建资源。
kubectl delete – 通过文件名、控制台输入、资源名或者label selector删除资源。
kubectl describe – 输出指定的一个/多个资源的详细信息。
kubectl edit – 编辑服务端的资源。
kubectl exec – 在容器内部执行命令。
kubectl expose – 输入replication controller，service或者pod，并将其暴露为新的kubernetes service。
kubectl get – 输出一个/多个资源。
kubectl label – 更新资源的label。
kubectl logs – 输出pod中一个容器的日志。
kubectl namespace -（已停用）设置或查看当前使用的namespace。
kubectl patch – 通过控制台输入更新资源中的字段。
kubectl port-forward – 将本地端口转发到Pod。
kubectl proxy – 为Kubernetes API server启动代理服务器。
kubectl replace – 通过文件名或控制台输入替换资源。
kubectl rolling-update – 对指定的replication controller执行滚动升级。
kubectl run – 在集群中使用指定镜像启动容器。
kubectl scale – 为replication controller设置新的副本数。
kubectl stop – （已停用）通过资源名或控制台输入安全删除资源。
kubectl version – 输出服务端和客户端的版本信息。
```

https://www.kubernetes.org.cn/doc-45

https://kubernetes.io/docs/reference/kubectl/overview/


# ERROR

## no matches for kind "Deployment" in version "extensions/v1beta1"

```sh
修改 apiVersion 选项： apps/v1

[root@k8sm90 demo]# cat tomcat-deployment.yaml
apiVersion: apps/v1
kind: Deployment
...
```

https://www.cnblogs.com/nnylee/p/11779653.html
