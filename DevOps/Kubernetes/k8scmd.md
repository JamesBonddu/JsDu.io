# k8s 命令

# namespace 相关

```sh
kubectl get ns

root@node1:/data/hadoop-kerberos-helm# kubectl get ns
NAME                              STATUS   AGE
default                           Active   9d
kube-node-lease                   Active   9d
kube-public                       Active   9d
kube-system                       Active   9d
kubesphere-controls-system        Active   9d
kubesphere-monitoring-federated   Active   9d
kubesphere-monitoring-system      Active   9d
kubesphere-system                 Active   9d

# 获取指定namespace下的所有pod

kubectl get po --namespace kube-system
# 或
kubectl get po -n kube-system

# 创建namespace
kubectl create namespace custom-namespace
# 或者使用yaml文件进行创建
# custom-namespace.yaml
apiVersion: v1
kind: Namespace
metadata:
    name: custom-namespace


root@node1:/data/hadoop-kerberos-helm# kubectl create namespace hdfs-pvs
namespace/hdfs-pvs created
root@node1:/data/hadoop-kerberos-helm# helm install --generate-name --namespace=hdfs-pvs pv 
NAME: pv-1633690868
LAST DEPLOYED: Fri Oct  8 19:01:08 2021
NAMESPACE: hdfs-pvs
STATUS: deployed
REVISION: 1
TEST SUITE: None
```

helm install --generate-name --namespace=hdfs-kdc kdc