## 尝试k8s沙箱环境

```sh

                          WARNING!!!!

 This is a sandbox environment. Using personal credentials
 is HIGHLY! discouraged. Any consequences of doing so, are
 completely the user's responsibilites.

 You can bootstrap a cluster as follows:

 1. Initializes cluster master node:

 kubeadm init --apiserver-advertise-address $(hostname -i)


 2. Initialize cluster networking:

 kubectl apply -n kube-system -f \
    "https://cloud.weave.works/k8s/net?k8s-version=$(kubectl version | base64 |tr -d '\n')"


 3. (Optional) Create an nginx deployment:

 kubectl apply -f https://raw.githubusercontent.com/kubernetes/website/master/content/cn/docs/user-guide/nginx-app.yaml


                          The PWK team.
```

### 试用第一个命令

```sh
[node1 ~]$ kubeadm init --apiserver-advertise-address $(hostname -i)
Initializing machine ID from random generator.
[kubeadm] WARNING: kubeadm is in beta, please do not use it for production clusters.
[init] Using Kubernetes version: v1.8.15
[init] Using Authorization modes: [Node RBAC]
[preflight] Skipping pre-flight checks
[kubeadm] WARNING: starting in 1.8, tokens expire after 24 hours by default (if you require a non-expiring token use --token-ttl 0)
[certificates] Generated ca certificate and key.
[certificates] Generated apiserver certificate and key.
[certificates] apiserver serving cert is signed for DNS names [node1 kubernetes kubernetes.default kubernetes.default.svc kubernetes.default.svc.cluster.local] and IPs [10.96.0.1 192.168.0.18]
[certificates] Generated apiserver-kubelet-client certificate and key.
[certificates] Generated sa key and public key.
[certificates] Generated front-proxy-ca certificate and key.
[certificates] Generated front-proxy-client certificate and key.
[certificates] Valid certificates and keys now exist in "/etc/kubernetes/pki"
[kubeconfig] Wrote KubeConfig file to disk: "admin.conf"
[kubeconfig] Wrote KubeConfig file to disk: "kubelet.conf"
[kubeconfig] Wrote KubeConfig file to disk: "controller-manager.conf"
[kubeconfig] Wrote KubeConfig file to disk: "scheduler.conf"
[controlplane] Wrote Static Pod manifest for component kube-apiserver to "/etc/kubernetes/manifests/kube-apiserver.yaml"
[controlplane] Wrote Static Pod manifest for component kube-controller-manager to "/etc/kubernetes/manifests/kube-controller-manager.yaml"
[controlplane] Wrote Static Pod manifest for component kube-scheduler to "/etc/kubernetes/manifests/kube-scheduler.yaml"
[etcd] Wrote Static Pod manifest for a local etcd instance to "/etc/kubernetes/manifests/etcd.yaml"
[init] Waiting for the kubelet to boot up the control plane as Static Pods from directory "/etc/kubernetes/manifests"
[init] This often takes around a minute; or longer if the control plane images have to be pulled.
[apiclient] All control plane components are healthy after 32.002605 seconds
[uploadconfig] Storing the configuration used in ConfigMap "kubeadm-config" in the "kube-system" Namespace
[markmaster] Will mark node node1 as master by adding a label and a taint
[markmaster] Master node1 tainted and labelled with key/value: node-role.kubernetes.io/master=""
[bootstraptoken] Using token: df0dca.acb50a30486ace08
[bootstraptoken] Configured RBAC rules to allow Node Bootstrap tokens to post CSRs in order for nodes to get long term certificate credentials
[bootstraptoken] Configured RBAC rules to allow the csrapprover controller automatically approve CSRs from a Node Bootstrap Token
[bootstraptoken] Configured RBAC rules to allow certificate rotation for all node client certificates in the cluster
[bootstraptoken] Creating the "cluster-info" ConfigMap in the "kube-public" namespace
[addons] Applied essential addon: kube-dns
[addons] Applied essential addon: kube-proxy

Your Kubernetes master has initialized successfully!

To start using your cluster, you need to run (as a regular user):

  mkdir -p $HOME/.kube
  sudo cp -i /etc/kubernetes/admin.conf $HOME/.kube/config
  sudo chown $(id -u):$(id -g) $HOME/.kube/config

You should now deploy a pod network to the cluster.
Run "kubectl apply -f [podnetwork].yaml" with one of the options listed at:
  http://kubernetes.io/docs/admin/addons/

You can now join any number of machines by running the following on each node
as root:

  kubeadm join --token df0dca.acb50a30486ace08 192.168.0.18:6443 --discovery-token-ca-cert-hash sha256:4b3bd5451974ea29e92d00c83123b442a428f609c6800bbf7d50b135c948a8b9

Waiting for api server to startup...........
Warning: kubectl apply should be used on resource created by either kubectl create --save-config or kubectl apply
daemonset "kube-proxy" configured
No resources found
```



```sh
[node1 ~]$ kubeadm  config view
api:
  advertiseAddress: 192.168.0.18
  bindPort: 6443
authorizationModes:
- Node
- RBAC
certificatesDir: /etc/kubernetes/pki
cloudProvider: ""
etcd:
  caFile: ""
  certFile: ""
  dataDir: /var/lib/etcd
  endpoints: null
  image: ""
  keyFile: ""
imageRepository: gcr.io/google_containers
kubernetesVersion: v1.8.15
networking:
  dnsDomain: cluster.local
  podSubnet: ""
  serviceSubnet: 10.96.0.0/12
nodeName: node1
token: ""
tokenTTL: 24h0m0s
unifiedControlPlaneImage: ""

[node1 ~]$ kubectl version
Client Version: version.Info{Major:"1", Minor:"8", GitVersion:"v1.8.11", GitCommit:"1df6a8381669a6c753f79cb31ca2e3d57ee7c8a3", GitTreeState:"clean", BuildDate:"2018-04-05T17:24:03Z", GoVersion:"go1.8.3", Compiler:"gc", Platform:"linux/amd64"}
Server Version: version.Info{Major:"1", Minor:"8", GitVersion:"v1.8.15", GitCommit:"c2bd642c70b3629223ea3b7db566a267a1e2d0df", GitTreeState:"clean", BuildDate:"2018-07-11T17:52:15Z", GoVersion:"go1.8.3", Compiler:"gc", Platform:"linux/amd64"}


[node1 ~]$ kubectl api-versions
apiextensions.k8s.io/v1beta1
apiregistration.k8s.io/v1beta1
apps/v1beta1
apps/v1beta2
authentication.k8s.io/v1
authentication.k8s.io/v1beta1
authorization.k8s.io/v1
authorization.k8s.io/v1beta1
autoscaling/v1
autoscaling/v2beta1
batch/v1
batch/v1beta1
certificates.k8s.io/v1beta1
extensions/v1beta1
networking.k8s.io/v1
policy/v1beta1
rbac.authorization.k8s.io/v1
rbac.authorization.k8s.io/v1beta1
storage.k8s.io/v1
storage.k8s.io/v1beta1
v1

[node1 ~]$ kubectl config
Modify kubeconfig files using subcommands like "kubectl config set current-context my-context"

The loading order follows these rules:

  1. If the --kubeconfig flag is set, then only that file is loaded.  The flag may only be set once and no merging takes
place.
  2. If $KUBECONFIG environment variable is set, then it is used a list of paths (normal path delimitting rules for your
system).  These paths are merged.  When a value is modified, it is modified in the file that defines the stanza.  When a
value is created, it is created in the first file that exists.  If no files in the chain exist, then it creates the last
file in the list.
  3. Otherwise, ${HOME}/.kube/config is used and no merging takes place.

Available Commands:
  current-context Displays the current-context
  delete-cluster  Delete the specified cluster from the kubeconfig
  delete-context  Delete the specified context from the kubeconfig
  get-clusters    Display clusters defined in the kubeconfig
  get-contexts    Describe one or many contexts
  rename-context  Renames a context from the kubeconfig file.
  set             Sets an individual value in a kubeconfig file
  set-cluster     Sets a cluster entry in kubeconfig
  set-context     Sets a context entry in kubeconfig
  set-credentials Sets a user entry in kubeconfig
  unset           Unsets an individual value in a kubeconfig file
  use-context     Sets the current-context in a kubeconfig file
  view            Display merged kubeconfig settings or a specified kubeconfig file

Usage:
  kubectl config SUBCOMMAND [options]

Use "kubectl <command> --help" for more information about a given command.
Use "kubectl options" for a list of global command-line options (applies to all commands).

[node1 ~]$ kubectl config view
apiVersion: v1
clusters:
- cluster:
    certificate-authority-data: REDACTED
    server: https://192.168.0.18:6443
  name: kubernetes
contexts:
- context:
    cluster: kubernetes
    user: kubernetes-admin
  name: kubernetes-admin@kubernetes
current-context: kubernetes-admin@kubernetes
kind: Config
preferences: {}
users:
- name: kubernetes-admin
  user:
    client-certificate-data: REDACTED
    client-key-data: REDACTED

[node1 ~]$ kubectl config get-clusters
NAME
kubernetes

[node1 ~]$ kubectl config get-contexts
CURRENT   NAME                          CLUSTER      AUTHINFO           NAMESPACE
*         kubernetes-admin@kubernetes   kubernetes   kubernetes-admin

[node1 ~]$ kubectl config current-context
kubernetes-admin@kubernetes
```

## 调用第二个命令

```sh
[node1 ~]$ kubectl apply -n kube-system -f \
>     "https://cloud.weave.works/k8s/net?k8s-version=$(kubectl version | base64 |tr -d '\n')"
serviceaccount "weave-net" created
clusterrole "weave-net" created
clusterrolebinding "weave-net" created
role "weave-net" created
rolebinding "weave-net" created
daemonset "weave-net" created
```

### 调用第三个命令

```sh
[node1 ~]$  kubectl apply -f https://raw.githubusercontent.com/kubernetes/website/master/content/cn/docs/user-guide/nginx-app.yaml
service "my-nginx-svc" created
deployment "my-nginx" created
```

```sh
[node1 ~]$ docker ps
CONTAINER ID        IMAGE                                                  COMMAND                  CREATED              STATUS              PORTS               NAMES
d20e811ba46f        gcr.io/google_containers/k8s-dns-sidecar-amd64         "/sidecar --v=2 --lo…"   About a minute ago   Up About a minute                       k8s_sidecar_kube-dns-545bc4bfd4-54pj7_kube-system_5dbef6ab-a514-11e8-8000-0242feac80ab_0
5f662519973c        gcr.io/google_containers/k8s-dns-dnsmasq-nanny-amd64   "/dnsmasq-nanny -v=2…"   About a minute ago   Up About a minute                       k8s_dnsmasq_kube-dns-545bc4bfd4-54pj7_kube-system_5dbef6ab-a514-11e8-8000-0242feac80ab_0
06fc97724223        gcr.io/google_containers/k8s-dns-kube-dns-amd64        "/kube-dns --domain=…"   About a minute ago   Up About a minute                       k8s_kubedns_kube-dns-545bc4bfd4-54pj7_kube-system_5dbef6ab-a514-11e8-8000-0242feac80ab_0
a86fdbc84cbf        k8s.gcr.io/pause-amd64:3.1                             "/pause"                 About a minute ago   Up About a minute                       k8s_POD_kube-dns-545bc4bfd4-54pj7_kube-system_5dbef6ab-a514-11e8-8000-0242feac80ab_0
7ec76b4081fd        weaveworks/weave-npc                                   "/usr/bin/weave-npc"     About a minute ago   Up About a minute                       k8s_weave-npc_weave-net-59fp5_kube-system_c4849d74-a515-11e8-8000-0242feac80ab_0
0b9b40dd60e1        weaveworks/weave-kube                                  "/home/weave/launch.…"   About a minute ago   Up About a minute                       k8s_weave_weave-net-59fp5_kube-system_c4849d74-a515-11e8-8000-0242feac80ab_0
44eec6d709a6        k8s.gcr.io/pause-amd64:3.1                             "/pause"                 About a minute ago   Up About a minute                       k8s_POD_weave-net-59fp5_kube-system_c4849d74-a515-11e8-8000-0242feac80ab_0
dfae24e15cdc        gcr.io/google_containers/kube-proxy-amd64              "/usr/local/bin/kube…"   11 minutes ago       Up 11 minutes                           k8s_kube-proxy_kube-proxy-slhnz_kube-system_5db19be4-a514-11e8-8000-0242feac80ab_0
3c55746f18b8        k8s.gcr.io/pause-amd64:3.1                             "/pause"                 11 minutes ago       Up 11 minutes                           k8s_POD_kube-proxy-slhnz_kube-system_5db19be4-a514-11e8-8000-0242feac80ab_0
033fa5844695        6015bf4bb1f1                                           "kube-controller-man…"   11 minutes ago       Up 11 minutes                           k8s_kube-controller-manager_kube-controller-manager-node1_kube-system_846f06b74abd4522e4c089d7730d2c7f_1
45553ff3a5f9        053cf553fa2d                                           "kube-apiserver --re…"   11 minutes ago       Up 11 minutes                           k8s_kube-apiserver_kube-apiserver-node1_kube-system_836e476f1e0225b2782e3e33908849fd_0
32ce18e00906        k8s.gcr.io/pause-amd64:3.1                             "/pause"                 11 minutes ago       Up 11 minutes                           k8s_POD_kube-apiserver-node1_kube-system_836e476f1e0225b2782e3e33908849fd_0
ee8691339cdf        gcr.io/google_containers/etcd-amd64                    "etcd --listen-clien…"   12 minutes ago       Up 12 minutes                           k8s_etcd_etcd-node1_kube-system_43a7b79b0d85dfa85932daa25361ac87_0
69e06f5d90e2        gcr.io/google_containers/kube-scheduler-amd64          "kube-scheduler --ad…"   12 minutes ago       Up 12 minutes                           k8s_kube-scheduler_kube-scheduler-node1_kube-system_6a17e9027c31b6807f6bf0f4dbc8fa17_0
81a84754706c        k8s.gcr.io/pause-amd64:3.1                             "/pause"                 12 minutes ago       Up 12 minutes                           k8s_POD_kube-controller-manager-node1_kube-system_846f06b74abd4522e4c089d7730d2c7f_0
b3710632bada        k8s.gcr.io/pause-amd64:3.1                             "/pause"                 12 minutes ago       Up 12 minutes                           k8s_POD_etcd-node1_kube-system_43a7b79b0d85dfa85932daa25361ac87_0
f125234e73a1        k8s.gcr.io/pause-amd64:3.1                             "/pause"                 12 minutes ago       Up 12 minutes                           k8s_POD_kube-scheduler-node1_kube-system_6a17e9027c31b6807f6bf0f4dbc8fa17_0
```


```sh
[node1 ~]$ cat  .kube/config
apiVersion: v1
clusters:
- cluster:
    certificate-authority-data: LS0tLS1CRUdJTiBDRVJUSUZJQ0FURS0tLS0tCk1JSUN5RENDQWJDZ0F3SUJBZ0lCQURBTkJna3Foa2lHOXcwQkFRc0ZBREFWTVJNd0VRWURWUVFERXdwcmRXSmwKY201bGRHVnpNQjRYRFRFNE1EZ3lNVEEzTXpFek5sb1hEVEk0TURneE9EQTNNekV6Tmxvd0ZURVRNQkVHQTFVRQpBeE1LYTNWaVpYSnVaWFJsY3pDQ0FTSXdEUVlKS29aSWh2Y05BUUVCQlFBRGdnRVBBRENDQVFvQ2dnRUJBTjJVCi9ralNsMmU5QXBhSjhOTkJEazF3MTRwWWcrTUw1aGdKMzIzamllNFlpWmNzVGpaSEZrUDFZcWw4RVpKa2JkbEUKRnRPRWZWWG42dWlYcWRqUXF2cWJFU2hJR3htSytxQ05aUHIwaTlBeitxV0NrbnQ4WnhOemNVSW16QWd1WUYyYwpTR3dzdXFReks2TWxlS2EyU0IxU2xzczZqU3lnaVZqNzY0dU05akJ4SjVHb0k0SSthWHU3Ym5iclhaZVhwR3VsCmk1MjVvMlVrSEtkSXQvVlJ4bklWK1pWU25jUXZuRlN0SHVXbmVwS291UEMxMndnRGhJZXVKVkx4bjZPK01XaEQKMnppWnh1VTZTZDVWYktsWHJDTUxXUmJqbmlIck5RRFAxVjRkeUFPRE82TzR1Y2J1a0lrVHNoUHdxRi9JUG53Zwp2ckx4dHM5TVlIU3FLTWc1bGpzQ0F3RUFBYU1qTUNFd0RnWURWUjBQQVFIL0JBUURBZ0trTUE4R0ExVWRFd0VCCi93UUZNQU1CQWY4d0RRWUpLb1pJaHZjTkFRRUxCUUFEZ2dFQkFEVGZGaXRGMEhrQUt4QWtqMmtDZGk5aENocy8KL1ltcGxCNmNJbDVwSklnY2lDWjgxdTlTRzZLVlhVb2Z3TlBBT1F6NHMzYjZrYTh6c2xkTWR2SkVMQVpqdUFjYQpmdW1pMUw2Y1hMK0FHb0UyREs5TXk3VjhkOE9KQndRUUJYTzdqZ2o1U2VyaVJhWFVlcHJaRmF1OU9NSjgycG1YCjRKeGFXRTNxemlEKzdlQjI5TGYzTmtxY3pyZDE1aW5Oem1FWU1VN1ZkQy8xdHIzVCtBRFhHMjI3Tlk5VHJhcWMKOHdsYjlRQW4xaUJyZXU4blRtZWUrbG5FcVZSMHlrOFZlZFV3S21pL0NKQkZwN1hyL1pMdXQrOWZhUEZBUGs2bgozTXZFSkwrNWpTRXp5T1FSNk1WVzhkaVlVdEpVTUxDckh6bUVIUGI0Q2VBQjB3WWVzdGhtQUh3ZlNJUT0KLS0tLS1FTkQgQ0VSVElGSUNBVEUtLS0tLQo=
    server: https://192.168.0.18:6443
  name: kubernetes
contexts:
- context:
    cluster: kubernetes
    user: kubernetes-admin
  name: kubernetes-admin@kubernetes
current-context: kubernetes-admin@kubernetes
kind: Config
preferences: {}
users:
- name: kubernetes-admin
  user:
    client-certificate-data: LS0tLS1CRUdJTiBDRVJUSUZJQ0FURS0tLS0tCk1JSUM4akNDQWRxZ0F3SUJBZ0lJSGVyYmhHdzZjN1l3RFFZSktvWklodmNOQVFFTEJRQXdGVEVUTUJFR0ExVUUKQXhNS2EzVmlaWEp1WlhSbGN6QWVGdzB4T0RBNE1qRXdOek14TXpaYUZ3MHhPVEE0TWpFd056TXhNemhhTURReApGekFWQmdOVkJBb1REbk41YzNSbGJUcHRZWE4wWlhKek1Sa3dGd1lEVlFRREV4QnJkV0psY201bGRHVnpMV0ZrCmJXbHVNSUlCSWpBTkJna3Foa2lHOXcwQkFRRUZBQU9DQVE4QU1JSUJDZ0tDQVFFQXVtMG9wZlZaNlRoWnR6ZmcKNnpOR2NNTnBUb0R3bWdESDJXZTJleTQ0b0FMSVRaZXJuNUhwYitHNFE5czFZL2EwN2RiSlBkYVlDTUJSampsRQo3KzVMYVpqRHEwRG1pL2tZeHVFZUxBeTd6a21Fa2pPemJWQ2xTSXVpNm9kcG03aTE3TEhMVmdyOGRGbWNhSDd0CjR4VkVtK2JrSGxlVGdUV1lHZncxdzJXYUc1TlB6emZlN1hlUVYvNkU0cXpQMm9Hd3JpdVNydGQxT1NtOFJZa3MKRUYzWUZkMTJTVnl4QUlKL0FvNnd4SHpIK0xlQTBMem1pd25DL0o1SWNITmZEbWlKVnNJWG5nVEhHRlZMbm5qMwpqMTlwb1V0bHRoeFpwQlZUVnZnN05PNzJ0aTdhY2VIVEo5c2hVRnhVTnFlZkdCc294bUVnZCtnR3JMcG9OTHlVCnIrK09kd0lEQVFBQm95Y3dKVEFPQmdOVkhROEJBZjhFQkFNQ0JhQXdFd1lEVlIwbEJBd3dDZ1lJS3dZQkJRVUgKQXdJd0RRWUpLb1pJaHZjTkFRRUxCUUFEZ2dFQkFMcTZGNS94ZmxyNUNuY1VrSW5pb2lpMC9qeHBJRzFJWHkyOQpHZEFDL0FSeWR1SEtONzVVMUdmMi9Gc3pzcFR1TGJuRGJFM25ZVmgyS25VaE82Z0ZlZE5lOFY3SHI2UVVQTTI1CkF5T3Avcm5NaFlIT285VzhoSmdtaW13d3dYd0JETDQ4K3RUMHJ5UUNZcTRidi9aNFlhOHRvSWJOdndyak1zNXEKamk4Z3pPUDdaSlFWNTg3c2pzcmFDMUpuYTl0N2oxZXUzelI2RGNZZDcwYjBaWkNQRXZKeDFmZEVVVDBPRUtIbApQV1ZoaklMYzR2RjZiUDFwVlBLY1hIaTdMdlJocWFRL2tFQ0tFNXZVdVNlczNtZkI4dWRBSFF3UmM2WlF6U0FxClNwbEppNkQvSjRBOGRCNkliZm83TjNDby9aQU42V29QZEo2bTZRNmRJb2ZKZ1lQRW9sVT0KLS0tLS1FTkQgQ0VSVElGSUNBVEUtLS0tLQo=
    client-key-data: LS0tLS1CRUdJTiBSU0EgUFJJVkFURSBLRVktLS0tLQpNSUlFb3dJQkFBS0NBUUVBdW0wb3BmVlo2VGhadHpmZzZ6TkdjTU5wVG9Ed21nREgyV2UyZXk0NG9BTElUWmVyCm41SHBiK0c0UTlzMVkvYTA3ZGJKUGRhWUNNQlJqamxFNys1TGFaakRxMERtaS9rWXh1RWVMQXk3emttRWtqT3oKYlZDbFNJdWk2b2RwbTdpMTdMSExWZ3I4ZEZtY2FIN3Q0eFZFbStia0hsZVRnVFdZR2Z3MXcyV2FHNU5QenpmZQo3WGVRVi82RTRxelAyb0d3cml1U3J0ZDFPU204Ullrc0VGM1lGZDEyU1Z5eEFJSi9BbzZ3eEh6SCtMZUEwTHptCml3bkMvSjVJY0hOZkRtaUpWc0lYbmdUSEdGVkxubmozajE5cG9VdGx0aHhacEJWVFZ2ZzdOTzcydGk3YWNlSFQKSjlzaFVGeFVOcWVmR0Jzb3htRWdkK2dHckxwb05MeVVyKytPZHdJREFRQUJBb0lCQVFDdzRmMmRhV3dEMHNtZApBOUhPbC9vUDUvazAyVFp3aUtrV2FFZEdIUmJ4QzNMTjNFaWt3S2NDMXVJazBBcWFiR3hDOW5ZK3pDdTRzZkV2CnhycllBL3RkbCtxZnhKWjYzTUJiZ3lGRG5sbGJZM243MWo0NlREaG0yc2FiVEJ3eCtsSHk0TWNUUHAxR0wvZ3QKVmJHVXNvdEVlUkNja1crTk96SzBCUTlsOURNQ1VXWnd5OFhjejA2L1lSMmw4YWtnc2xSNmlFYW1CYXJqMUxCTAo2YkNBa0tkckFrN2hreGJpM0o0VjRJeTUzMFhaWkVhNm8wR0ZMVUd3Y3hhWjMvZjBHL2tiSUViQXh2YzZnY01HCjdFcktlYnh6c1ZFeVQvSHcwOWRWTUhjODBUbE4zWlBla2VGd2R4TDMwRW13NGdnckg3VmV2Tmp3Mlg5VXN6bWwKb0xwZytrblJBb0dCQU5BK08yRm8vb0M5cHVDRldBRFRRa2ZKb0RjMTJWQUgxQ3d0b2MzQmJWSjRKK1JqcFdSYQpsWlRZdno4VXBoZEJkNDNEMzE3U1hDWStOVEN5c1RQb3A0R0JqNlV2R010ZU53ek5vdkpUUXZxdFEvR3FCRndCCk5XK0dvdi9KN0t2QnlSOVgxeDRPYWNDOFVnRzNmUVRYR2JLd0t2bzB6dXZCN3ZBcEl1RFFWd0E5QW9HQkFPVXUKRm81Y2t5b0tBcy92R1VnT2phc0dHa1NscE5RWFJwT2ZqSXY5TEJZRDVyZnVIM2tGVTB5ZExEelMwdzl2a0tRZAp5MWRCUWtGVkVqUlJMeHFLRlpaeWt2TGdzTkNFaVQ4cXdNRGo3SVE5Zml5V09JZXk4SlpyVCtjcjkrYXZvZXYyCkJ4NE9MMTVUcDRKamM4ZjBuTFdWc0JIdkVjS0FOR3F0bmdBdG1lRERBb0dBRmNES2R5eCttWGcyUEhIeGRYU2MKRWQrd0N0Um5OUUw4V1BrVFUra0d3SHlvdmlUaW5BOFNYUkFmT2ptdjkvSHd5VEJTM3hiZVpXaE9LaDRnZ0ttbgpCZEpBN1NKMFZwb3E2ZjE1TGhNZ2hnc2ZjOWtzeDJlZzYxdUhIMjA2ZWQ2dVljWE5ST2lBaDQra2lXVmZlK2YwCldVUXAyU1UzRUUyYjVoNkY5RElQUklrQ2dZQllBdXNHb09hakxsVUdKWHcvLzliSDV3QVBmTTFmNWRCa3dORG8Kc2NGTWN4TVhiNHNHbnRUdWh5MkY3akMvck1pUFBpSG8wRmJ4WUFvdHJUKzVvVzNJNlJjbHpzUVlUODJsUkhYaApuYVltNHJhaHlNN016aHMycU45Mmw1d01LMGF6cHpmMGd0NE9DM0k0MEppV0lZcE04Yjg4SStOZUhuNEN1Y29ECnAzK0FvUUtCZ0M3Y0c3SklDc3RPUXZra2hndE9KdWwyaFdtOFR5cXhZYzlpQ2Y4VE5lZXNYSVR6Y1VUSlQ3WEQKWUN1Nmo4ZHVoZFQrTzJ3aUFoeDNnaEFMb0hGZWh2aVpuZkFTckp5VVdjVE5sSk1QeGRRRi9SK3M1b1lRVXNiYQprMEVlS0VlZ2JyOU0xU0Q4TlpTR2U0ZnFlUlNWVVNRR05TWnMvYUxNdDNaUDJSWW82eFVYCi0tLS0tRU5EIFJTQSBQUklWQVRFIEtFWS0tLS0tCg==
```


```sh
[node1 ~]$ ls  .kube/cache/discovery/192.168.0.18_6443/
apiextensions.k8s.io    apps                   authorization.k8s.io  batch                extensions         policy                     servergroups.json  v1
apiregistration.k8s.io  authentication.k8s.io  autoscaling           certificates.k8s.io  networking.k8s.io  rbac.authorization.k8s.io  storage.k8s.io
```

```sh
[node1 ~]$ ls  .kube/http-cache/
01cb950acba014a4088e8a81c554dd8d  59febcd5519751707bb880efa7b5ab20  8f7690db01fca87b663335de1b691cb2  df07a45be9279c34ed1417f79177b3b5
17530063965cc4ea5d0b24eaa93d8233  694c50f725e48086aa2ae8c445c8737f  94af4d7a881c3dc002f098f99009838e  ee23796d54ebcb59e0757145a2d45a21
17d77745f1ec84e741ed19bf35e70589  6aadc9fb9366f4f02333ba58d545c56f  a6298e87761566fa642e4c5b9ebd219b  f5568ac4afc5913a5aa680e0fdae9929
1ce5725e1e762b409d26af04bd9bbe83  6eae4a12a007abb3497d5e68922d3f92  a947b24676ad161ece629d937378c394  f7940f510850679616c87ecb93c96f01
401f1eb169da5cd85a7b53ce1dcbaeca  6f041d2f11810aa00fe275a12c409ed8  ad616d73eff52198b12896bf7d75e928
411e0fa7a743fd7dfb804991c3d10b2e  87d2e1091e6edb0e75b8a9b1d9ee82f3  be2540e4ac2e0bc1d1337cf83af25776
542415af432272c6a50f82ea9306cff5  8ec6ed70f8c8e8fd1cddceaf81454b6d  cb2419a70261f4a92781246cf1ca392a
```

> Refrence

[尝试搭建一个k8s集群体验环境](https://labs.play-with-k8s.com/)

[katacoda k8s模拟环境](https://www.katacoda.com/courses/kubernetes/playground)