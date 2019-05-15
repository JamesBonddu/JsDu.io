# Mincube

安装Mincube分以下几步:
- BIOS开启虚拟化
- 安装Hypervisor虚拟化工具
- 安装kubectl
- 安装

## 使用阿里镜像源安装
```sh
cat <<EOF > /etc/yum.repos.d/kubernetes.repo
[kubernetes]
name=Kubernetes
baseurl=http://mirrors.aliyun.com/kubernetes/yum/repos/kubernetes-el7-x86_64
enabled=1
gpgcheck=0
repo_gpgcheck=0
gpgkey=http://mirrors.aliyun.com/kubernetes/yum/doc/yum-key.gpg http://mirrors.aliyun.com/kubernetes/yum/doc/rpm-package-key.gpg
EOF
yum install -y kubectl
```

## kubectl

它是user-commands工具.目前kubectl还未配置成功

```sh
(base) [root@bogon home]# kubectl cluster-info
Kubernetes master is running at http://localhost:8080

To further debug and diagnose cluster problems, use 'kubectl cluster-info dump'.
The connection to the server localhost:8080 was refused - did you specify the right host or port?
```

## 安装kubeadm
```sh
function addKubRep() {
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
}

function disabledSELinux() {
        # 将 SELinux 设置为 permissive 模式(将其禁用)
        setenforce 0
        sed -i 's/^SELINUX=enforcing$/SELINUX=permissive/' /etc/selinux/config
}

functuion installKubctl() {
        yum install -y kubelet kubeadm kubectl --disableexcludes=kubernetes

        systemctl enable kubelet && systemctl start kubelet
}

```


参考:

[选择最佳的实践策略](https://kubernetes.io/docs/setup/pick-right-solution/)

[kubernetes 最佳实践](https://kubernetes.feisky.xyz/zh/)

[安装 kubectl](https://kubernetes.io/docs/tasks/tools/install-kubectl/)

[尝试搭建一个k8s集群体验环境](https://labs.play-with-k8s.com/)

[kubernetes 阿里云镜像](http://ljchen.net/2018/10/23/%E5%9F%BA%E4%BA%8E%E9%98%BF%E9%87%8C%E4%BA%91%E9%95%9C%E5%83%8F%E7%AB%99%E5%AE%89%E8%A3%85kubernetes/)