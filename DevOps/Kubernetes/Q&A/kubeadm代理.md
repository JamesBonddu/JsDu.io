```sh
[root@master ~]# proxychains4 kubeadm init --image-repository registry.aliyuncs.com/google_containers --kubernetes-version v1.13.5 --pod-network-cidr=192.168.0.0/16
[proxychains] config file found: /root/proxychains.conf
[proxychains] preloading /usr/local/lib/libproxychains4.so
[init] Using Kubernetes version: v1.13.5
[preflight] Running pre-flight checks
        [WARNING IsDockerSystemdCheck]: detected "cgroupfs" as the Docker cgroup driver. The recommended driver is "systemd". Please follow the guide at https://kubernetes.io/docs/setup/cri/
[preflight] The system verification failed. Printing the output from the verification:
KERNEL_VERSION: [proxychains] DLL init
3.10.0-327.28.3.el7.x86_64
DOCKER_VERSION: 18.09.6
DOCKER_GRAPH_DRIVER: overlay2
OS: [proxychains] DLL init
Linux
CGROUPS_CPU: enabled
CGROUPS_CPUACCT: enabled
CGROUPS_CPUSET: enabled
CGROUPS_DEVICES: enabled
CGROUPS_FREEZER: enabled
CGROUPS_MEMORY: enabled
error execution phase preflight: [preflight] Some fatal errors occurred:
        [ERROR FileContent--proc-sys-net-bridge-bridge-nf-call-iptables]: /proc/sys/net/bridge/bridge-nf-call-iptables contents are not set to 1
        [ERROR Swap]: running with swap on is not supported. Please disable swap
        [ERROR SystemVerification]: failed to parse kernel config: unable to load kernel module: "configs", output: "[proxychains] DLL init\nmodprobe: FATAL: Module configs not found.\n", err: exit status 1
        [ERROR SystemVerification]: unsupported operating system: [proxychains] DLL init
Linux
        [ERROR KubeletVersion]: couldn't get kubelet version: Unable to parse output from Kubelet: "[proxychains] DLL init\nKubernetes v1.14.1"
[root@master ~]# proxychains4 kubeadm init --image-repository registry.aliyuncs.com/google_containers --kubernetes-version v1.13.5 --pod-network-cidr=192.168.0.0/16^C
[root@master ~]# echo 1 /proc/sys/net/bridge/bridge-nf-call-iptables
1 /proc/sys/net/bridge/bridge-nf-call-iptables
[root@master ~]# cat /proc/sys/net/bridge/bridge-nf-call-iptables
0
[root@master ~]# echo 1 > /proc/sys/net/bridge/bridge-nf-call-iptables
[root@master ~]# echo 1 > /proc/sys/net/bridge/bridge-nf-call-ip6tables
```


[remove swap](https://serverfault.com/questions/684771/best-way-to-disable-swap-in-linux)