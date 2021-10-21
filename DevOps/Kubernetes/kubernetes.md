# kubernetes

k8s的历史

https://jimmysong.io/kubernetes-handbook/cloud-native/kubernetes-history.html


https://kubernetes.io/zh/docs/concepts/overview/what-is-kubernetes/



云计算从宏观上分为以下三种类型：

IaaS：这是为了想要建立自己的商业模式并进行自定义的客户，例如亚马逊的EC2、S3存储、Rackspace虚拟机等都是IaaS。
PaaS：工具和服务的集合，对于想用它来构建自己的应用程序或者想快速得将应用程序部署到生产环境而不必关心底层硬件的用户和开发者来说是特别有用的，比如Cloud Foundry、Google App Engine、Heroku等。
SaaS：终端用户可以直接使用的应用程序。这个就太多，我们生活中用到的很多软件都是SaaS服务，只要基于互联网来提供的服务基本都是SaaS服务，有的服务是免费的，比如Google Docs，还有更多的是根据我们购买的Plan和使用量付费，比如GitHub、各种云存储。

## Docker 和K8s的兼容性

Kubernetes 1.9  <--Docker 1.11.2 to 1.13.1 and 17.03.x

Kubernetes 1.8  <--Docker 1.11.2 to 1.13.1 and 17.03.x

Kubernetes 1.7  <--Docker 1.10.3,  1.11.2,  1.12.6

Kubernetes 1.6  <--Docker 1.10.3,  1.11.2,  1.12.6

Kubernetes 1.5  <--Docker 1.10.3,  1.11.2,  1.12.3


参考:

[k8s wiki](https://zh.wikipedia.org/wiki/Kubernetes)

[gitlabrunner](https://docs.gitlab.com/runner/)

[k8s cn](https://kubernetes.io/cn/docs/tutorials/kubernetes-basics/)

[k8s 对docker的兼容性](https://blog.csdn.net/CSDN_duomaomao/article/details/79171027)

[k8s本地开发](https://blog.qikqiak.com/post/skaffold-simple-local-develop-k8s-app-tools/)

https://kubesphere.io/docs/advanced-v2.0/zh-CN/introduction/architecture/


https://tech.meituan.com/2020/08/13/openstack-to-kubernetes-in-meituan.html

# 数据包在k8s中的一生


https://blog.fleeto.us/post/life-of-a-packet-in-k8s-1/

https://github.com/containernetworking/cni/blob/master/SPEC.md

## minikube

Minikube是由Kubernetes社区维护的单机版的Kubernetes集群，支持macOS, Linux, and Windows等多种操作系统平台，使用最新的官方stable版本，并支持Kubernetes的大部分功能，从基础的容器编排管理，到高级特性如负载均衡、Ingress，权限控制等。非常适合作为Kubernetes入门，或开发测试环境使用。

https://minikube.sigs.k8s.io/docs/

https://zhuanlan.zhihu.com/p/112755080

## K8s 部署spark History Server

https://cloud.tencent.com/developer/inventory/9360


## k8s 报错

## k8s创建Deployment报错：no matches for kind “Deployment“ in version “extensions/v1beta1“

```sh
修改 apiVersion 选项： apps/v1

[root@k8sm90 demo]# cat tomcat-deployment.yaml
apiVersion: apps/v1
kind: Deployment
...
因为我的 k8s 版本是 1.16.2，在这个版本中 Deployment 已经从 extensions/v1beta1 弃用

DaemonSet, Deployment, StatefulSet, and ReplicaSet resources will no longer be served from extensions/v1beta1, apps/v1beta1, or apps/v1beta2 by default in v1.16.
```

https://github.com/Azure/AKS/issues/1205

https://www.cnblogs.com/nnylee/p/11779653.html


## error validating "": error validating data: apiVersion not set

```sh
root@node1:/data/hadoop-kerberos-helm# helm install --generate-name --namespace=hdfs-kdc kdc
Error: unable to build kubernetes objects from release manifest: error validating "": error validating data: ValidationError(Deployment.spec): missing required field "selector" in io.k8s.api.apps.v1.DeploymentSpec

root@node1:/data/hadoop-kerberos-helm# helm install --generate-name --namespace=hdfs-kdc kdc
Error: Deployment.apps "kerberos" is invalid: spec.template.metadata.labels: Invalid value: map[string]string{"kerberosService":"kerberos", "name":"hdfs-kerberos"}: `selector` does not match template `labels`

root@node1:/data/hadoop-kerberos-helm# helm install --generate-name --namespace=hdfs-kdc kdc
Error: rendered manifests contain a resource that already exists. Unable to continue with install: Service "kerberos" in namespace "hdfs-kdc" exists and cannot be imported into the current release: invalid ownership metadata; annotation validation error: key "meta.helm.sh/release-name" must equal "kdc-1633691647": current value is "kdc-1633691595"
```

# 优秀博客

https://xinchen.blog.csdn.net/article/details/105086794