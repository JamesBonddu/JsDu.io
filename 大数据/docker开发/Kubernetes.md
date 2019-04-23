# Kubernetes

## 安装kubeadm
```sh
cat <<EOF > /etc/yum.repos.d/kubernetes.repo
[kubernetes]
name=Kubernetes
baseurl=http://mirrors.aliyun.com/kubernetes/yum/repos/kubernetes-el7-x86_64
enabled=1
gpgcheck=0
repo_gpgcheck=0
gpgkey=http://mirrors.aliyun.com/kubernetes/yum/doc/yum-key.gpg
        http://mirrors.aliyun.com/kubernetes/yum/doc/rpm-package-key.gpg
EOF

# 将 SELinux 设置为 permissive 模式(将其禁用)
setenforce 0
sed -i 's/^SELINUX=enforcing$/SELINUX=permissive/' /etc/selinux/config

yum install -y kubelet kubeadm kubectl --disableexcludes=kubernetes

systemctl enable kubelet && systemctl start kubelet
```


## Service
服务式分布式集群架构的核心, 一个Service对象拥有如下关键特征:
- 拥有一个唯一指定的名字
- 拥有一个虚拟IP和端口号
- 能够提供某种远程服务能力
- 被映射道了提供着中国服务能力的一组容器应用上

## Pod
Pod运行在我们称之为节点(Node)的环境中,这个节点既可以是物理机,也可以是私有云或者公有云中的一个虚拟机,通常在一个结点上运行几百个Pod.
Pod里运行着一个被称之为Pause的容器,其它容器则为业务容器,这些业务容器共享Pause容器的网络栈和Volume挂载卷，因此它们之间的通信和数据交换更为高效, 在设计时可以将一组密切相关的服务进程放入同一个Pod中.
并不是每个Pod和它里面运行的容器都能"映射"到一个Service上,只有那些提供服务的一组Pod才会被"映射"成一个服务.

参考:
https://kubernetes.io/zh/

[kubernetes 阿里云镜像](http://ljchen.net/2018/10/23/%E5%9F%BA%E4%BA%8E%E9%98%BF%E9%87%8C%E4%BA%91%E9%95%9C%E5%83%8F%E7%AB%99%E5%AE%89%E8%A3%85kubernetes/)