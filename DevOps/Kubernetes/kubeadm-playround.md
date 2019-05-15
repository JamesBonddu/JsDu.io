# kubeadm 练习

## 内网机器通过能上网的机器联网设置
156
157
158
为内网ip;都通过10.255.175.96这个(docker hub)能上网的机器进行联网.

在各个内网机器设置96为默认网关.
在96这个机器上添加NAT规则
iptables -t nat -A POSTROUTING  -s 10.255.175.0/24 -o eth0 -j SNAT --to 10.255.175.96

再在各个内网机器systemctl restart network ;便可联网

在三台机器都安装kubeadm,docker:
156 master
157 slave01
158 slave02

96  DockerHub

0. 检测docker版本并检验对应兼容的k8s版本 
[root@node1 ~]# docker -v
Docker version 18.09.6, build 481bc77156

选用 v1.13.6 k8s

1. 配置HOSTS和安装 kubeadm

```sh
[root@localhost ~]# echo  "node1.com" > /etc/hostname
[root@localhost ~]# hostname
node1.com
[root@localhost ~]# cat /etc/hosts
127.0.0.1   localhost localhost.localdomain localhost4 localhost4.localdomain4
::1         localhost localhost.localdomain localhost6 localhost6.localdomain6
127.0.0.1 localhost
10.255.175.156 master.com
10.255.175.157 node1.com
10.255.175.158 node2.com

# 此处由于该宿主机需要代理才能上网
proxychains4 yum install -y kubelet kubeadm kubectl --disableexcludes=kubernetes
# 之前未docker设为自启动
systemctl enable docker && systemctl start docker
systemctl enable kubelet && systemctl start kubelet
```

2. 关闭SELinux
```sh
[root@master ~]# cat /etc/selinux/config

# This file controls the state of SELinux on the system.
# SELINUX= can take one of these three values:
#     enforcing - SELinux security policy is enforced.
#     permissive - SELinux prints warnings instead of enforcing.
#     disabled - No SELinux policy is loaded.
SELINUX=disabled
# SELINUXTYPE= can take one of three two values:
#     targeted - Targeted processes are protected,
#     minimum - Modification of targeted policy. Only selected processes are protected.
#     mls - Multi Level Security protection.
SELINUXTYPE=targeted

[root@master ~]# sestatus
SELinux status:                 disabled
```

3. 配置各台机器上的hub和镜像加速地址
```sh
[root@localhost ~]# cat /etc/docker/daemon.json 
{
  "registry-mirrors": ["https://q0i1jkif.mirror.aliyuncs.com"], # 阿里云加速地址
  "insecure-registries":["10.255.175.96:5000"],
  "exec-opts": ["native.cgroupdriver=systemd"],
  "log-driver": "json-file",
  "log-opts": {
    "max-size": "100m"
  },
  "storage-driver": "overlay2",
  "storage-opts": [
    "overlay2.override_kernel_check=true"
  ]
}

systemctl daemon-reload &&
systemctl restart docker.service &&
systemctl status docker -l
```


4. 安装Master节点

K8s的控制面板组件运行在Master节点上，包括etcd和API server（Kubectl便是通过API server与k8s通信）。

在执行初始化之前，我们还有一下3点需要注意：

1.选择一个网络插件，并检查它是否需要在初始化Master时指定一些参数，比如我们可能需要根据选择的插件来设置--pod-network-cidr参数。参考：Installing a pod network add-on。

2.kubeadm使用eth0的默认网络接口（通常是内网IP）做为Master节点的advertise address，如果我们想使用不同的网络接口，可以使用--apiserver-advertise-address=<ip-address>参数来设置。如果适应IPv6，则必须使用IPv6d的地址，如：--apiserver-advertise-address=fd00::101。

3.使用kubeadm config images pull来预先拉取初始化需要用到的镜像，用来检查是否能连接到Kubenetes的Registries。

Kubenetes默认Registries地址是k8s.gcr.io，很明显，在国内并不能访问gcr.io，因此在kubeadm v1.13之前的版本，安装起来非常麻烦，但是在1.13版本中终于解决了国内的痛点，其增加了一个--image-repository参数，默认值是k8s.gcr.io，我们将其指定为国内镜像地址：registry.aliyuncs.com/google_containers，其它的就可以完全按照官方文档来愉快的玩耍了。

其次，我们还需要指定--kubernetes-version参数，因为它的默认值是stable-1，会导致从https://dl.k8s.io/release/stable-1.txt下载最新的版本号，我们可以将其指定为固定版本(最新版：v1.13.5)来跳过网络请求。

```sh
proxychains4 kubeadm init --image-repository registry.aliyuncs.com/google_containers --kubernetes-version v1.14.1 --pod-network-cidr=192.168.0.0/16
```

参考:

[kubeadm 创建集群](https://www.cnblogs.com/RainingNight/p/using-kubeadm-to-create-a-cluster-1-13.html)

[kubeadm 搭建集群](https://mritd.me/2016/10/29/set-up-kubernetes-cluster-by-kubeadm/)

[kubeadm安装 kubernets](https://www.cnblogs.com/cocowool/p/kubeadm_install_kubernetes.html)

[disabled selinux](https://howto.lintel.in/enable-disable-selinux-centos/)

[daemon.json作用](https://blog.csdn.net/u013948858/article/details/79974796)

[docker daemon.json 配置各台机器上的hub和镜像加速地址](https://blog.csdn.net/kozazyh/article/details/79795559)

[docker 私有仓库登录](https://segmentfault.com/a/1190000012175537)

[docker 和k8s兼容版本](https://github.com/kubernetes/kubernetes/blob/master/CHANGELOG-1.13.md#downloads-for-v1136)

[kubeadm version constant](https://godoc.org/k8s.io/kubernetes/cmd/kubeadm/app/constants)

[kubeadm constants](https://github.com/kubernetes/kubernetes/blob/master/cmd/kubeadm/app/constants/constants.go)
