# kubernetes

## kubernetes 主要功能

Kubernetes 是谷歌开源的容器集群管理系统，是 Google 多年大规模容器管理技术 Borg 的开源版本，也是 CNCF 最重要的项目之一，主要功能包括：
- 基于容器的应用部署、维护和滚动升级
- 负载均衡和服务发现
- 跨机器和跨地区的集群调度
- 自动伸缩
- 无状态服务和有状态服务
- 广泛的 Volume 支持
- 插件机制保证扩展性

## Kubernetes 的核心组件

- etcd 保存了整个集群的状态;

- apiserver提供了资源操作的唯一入口,并提供认证,授权,访问控制,API注册和发现等机制.

- controller manager负责维护集群的状态,比如故障检测,自动扩展,滚动更新等;

- scheduler负责资源的调度,按照预定的调度策略将Pod调度到相应的机器上;

- kubelet负责维护容器的生命周期,同时也负责Volume(CVI)和网络(CNI)的管理

- Container runtime负责镜像管理以及Pod和容器的真正运行(CRI)、

- kube-proxy负责为Service提供cluster内部的服务发现和负载均衡

## Master节点上运行着以下关键进程

- Kubernetes API Server(kube-apiserver), 提供了HTTP Rest接口的关键服务进程,是k8s里所有资源增,删,改,查等操作的唯一入口,也是集群控制的入口进程.

- Kubernetes Controller Manager(kube-controller-manager),k8s里所有资源对象的自动化控制中心,可以理解为资源对象的"大总管"

- Kubernetes Scheduler(kube-scheduler),负责资源调度(Pod调度)的进程,相当与公交公司的"调度室"

- etcd Server,保存k8s里所有资源对象.


## Node节点上运行着以下关键进程

- kubelet: 负责Pod对应的容器的创建,启停等任务,同时与Master节点密切协作,实现集群管理的基础功能.
 
- kube-proxy: 实现Kuberbetes Service的通信与负载均衡机制的重要组件.

- Docker Engine: Docker引擎,负责本机的容器创建和管理工作.

## Kubernetes 基本概念

### Container

Container（容器）是一种便携式、轻量级的操作系统级虚拟化技术。它使用 namespace 隔离不同的软件运行环境，并通过镜像自包含软件的运行环境，从而使得容器可以很方便的在任何地方运行.

容器同样比虚拟机更加透明，这有助于监测和管理。尤其是容器进程的生命周期由基础设施管理，而不是被进程管理器隐藏在容器内部。最后，每个应用程序用容器封装，管理容器部署就等同于管理应用程序部署.

### Pod

Kubernetes 使用 Pod 来管理容器，每个 Pod 可以包含一个或多个紧密关联的容器。

Pod 是一组紧密关联的容器集合，它们共享 PID、IPC、Network 和 UTS namespace，是 Kubernetes 调度的基本单位。Pod 内的多个容器共享网络和文件系统，可以通过进程间通信和文件共享这种简单高效的方式组合完成服务。

### Node

Node 是 Pod 真正运行的主机，可以是物理机，也可以是虚拟机。为了管理 Pod，每个 Node 节点上至少要运行 container runtime（比如 docker 或者 rkt）、`kubelet` 和 `kube-proxy` 服务。

### Namespace

Namespace 是对一组资源和对象的抽象集合，比如可以用来将系统内部的对象划分为不同的项目组或用户组。常见的 pods, services, replication controllers 和 deployments 等都是属于某一个 namespace 的（默认是 default），而 node, persistentVolumes 等则不属于任何 namespace。

### Service

Service 是应用服务的抽象，通过 labels 为应用提供负载均衡和服务发现。匹配 labels 的 Pod IP 和端口列表组成 endpoints，由 kube-proxy 负责将服务 IP 负载均衡到这些 endpoints 上

每个 Service 都会自动分配一个 cluster IP（仅在集群内部可访问的虚拟地址）和 DNS 名，其他容器可以通过该地址或 DNS 来访问服务，而不需要了解后端容器的运行。

### Label

Label 是识别 Kubernetes 对象的标签，以 key/value 的方式附加到对象上（key 最长不能超过 63 字节，value 可以为空，也可以是不超过 253 字节的字符串）。

## Kubernetes 架构原理

Kubernetes 最初源于谷歌内部的 Borg，提供了面向应用的容器集群部署和管理系统。Kubernetes 的目标旨在消除编排物理 / 虚拟计算，网络和存储基础设施的负担，并使应用程序运营商和开发人员完全将重点放在以容器为中心的原语上进行自助运营。Kubernetes 也提供稳定、兼容的基础（平台），用于构建定制化的 workflows 和更高级的自动化任务。 Kubernetes 具备完善的集群管理能力，包括多层次的安全防护和准入机制、多租户应用支撑能力、透明的服务注册和服务发现机制、内建负载均衡器、故障发现和自我修复能力、服务滚动升级和在线扩容、可扩展的资源自动调度机制、多粒度的资源配额管理能力。 Kubernetes 还提供完善的管理工具，涵盖开发、部署测试、运维监控等各个环节。

### Borg 简介

Borg 是谷歌内部的大规模集群管理系统，负责对谷歌内部很多核心服务的调度和管理。Borg 的目的是让用户能够不必操心资源管理的问题，让他们专注于自己的核心业务，并且做到跨多个数据中心的资源利用率最大化.

Brog 主要是由以下部分组成:

- BorgMaster
    BorgMaster 是整个集群的大脑，负责维护整个集群的状态，并将数据持久化到 Paxos 存储中；
- Borglet
    Borglet 负责真正运行任务（在容器中）；
- borgcfg
    borgcfg 是 Borg 的命令行工具，用于跟 Borg 系统交互，一般通过一个配置文件来提交任务。
- Scheduler
    Scheduer 负责任务的调度，根据应用的特点将其调度到具体的机器上去；


### 分层架构

- 核心层
    Kubernetes 最核心的功能，对外提供 API 构建高层的应用，对内提供插件式应用执行环境
- 应用层
    部署（无状态应用、有状态应用、批处理任务、集群应用等）和路由（服务发现、DNS 解析等）
- 管理层
    系统度量（如基础设施、容器和网络的度量），自动化（如自动扩展、动态 Provision 等）以及策略管理（RBAC、Quota、PSP、NetworkPolicy 等）
- 接口层
    kubectl 命令行工具、客户端 SDK 以及集群联邦
- 生态系统
    在接口层之上的庞大容器集群管理调度的生态系统，可以划分为两个范畴
    Kubernetes 外部：日志、监控、配置管理、CI、CD、Workflow、FaaS、OTS 应用、ChatOps 等
    Kubernetes 内部：CRI、CNI、CVI、镜像仓库、Cloud Provider、集群自身的配置和管理等

## 设计理念

核心技术概念和API对象
---

API对象是K8s集群中的管理操作单元。K8s集群系统每支持一项新功能，引入一项新技术，一定会新引入对应的API对象，支持对该功能的管理操作。例如副本集Replica Set对应的API对象是RS。

每个API对象都有3大类属性: 
- 元数据metadata

用来标识API对象的,每个对象至少有3个元数据: namespace, name, uid;
还有各种标签labels用来标识和匹配不同的对象.

- 规范spec

描述了用户期望k8s集群中的分布式系统达到的理想状态。比如用户可以通过复制控制器Replication Controller设置期望值的Pod副本数为3.

- 状态status.

描述了系统实际当前达到的状态.

### Pod

微服务Pod是在K8s集群中运行部署应用或服务的最小单元,它是可以支持多容器的在一个Pod中共享网络地址和文件系统,可以通过进程间通信和文件共享这种简单高效的方式组合完成服务.

Pod是K8s集群中所有业务类型的基础,目前K8s中的业务主要可以分为:
- 长期伺服型(long-running) --- Deployment
- 批处理型(batch) --- Job
- 节点后台支撑型(node-daemon) --- DaemonSet
- 有状态应用型(stateful application) --- StatefulSet

### 复制控制器 (Replication Cotroller, RC)

RC是K8s集群中最早的保证Pod高可用的API对象。通过监控运行中的Pod来保证集群中运行指定数目的Pod副本.
作用:
- 指定的数目可以是多个也可以是1个；即使在指定数目为1的情况下，通过RC运行Pod也比直接运行Pod更明智，因为RC也可以发挥它高可用的能力，保证永远有1个Pod在运行。
- 少于指定数目，RC就会启动运行新的Pod副本；
- 多于指定数目，RC就会杀死多余的Pod副本。

### 副本集 (Replica Set, RS)

RS是新一代RC, 提供同样高可用的能力,区别主要在于RS后来居上,能支撑更多种类的匹配模式.

### 部署(Deployment)

部署表示用户对k8s集群的一次更新操作.部署是一个比RS应用模式更广的API对象,可以是创建一个新的服务,更新一个新的服务,也可以是滚动升级一个服务.

### 服务(Service)

RC、RS和Deployment只是保证了支撑服务的微服务Pod的数量，但是没有解决如何访问这些服务的问题。要稳定地提供服务需要服务发现和负载均衡能力。

服务发现: 

客户端需要访问的服务就是Service对象。每个Service会对应一个集群内部有效的虚拟IP，集群内部通过虚拟IP访问一个服务。

负载均衡:

Kube-proxy是K8s集群内部的负载均衡器。它是一个分布式代理服务器，在K8s的每个节点上都有一个；

### 任务(Job)

Job是K8s用来控制批处理型任务的API对象。批处理业务与长期伺服业务的主要区别是批处理业务的运行有头有尾，而长期伺服业务在用户不停止的情况下永远运行。

### 后台支撑服务集 (DaemonSet)

长期伺服型和批处理型服务的核心在业务应用，可能有些节点运行多个同类业务的Pod，有些节点上又没有这类Pod运行；而后台支撑型服务的核心关注点在K8s集群中的节点（物理机或虚拟机），要保证每个节点上都有一个此类Pod运行

### 存储卷(Volume)

K8s集群中的存储卷跟Docker的存储卷有些类似，只不过Docker的存储卷作用范围为一个容器，而K8s的存储卷的生命周期和作用范围是一个Pod。每个Pod中声明的存储卷由Pod中的所有容器共享。

### 持久存储卷(Persistent Volume, PV)和持久存储卷声明(Persistent Volume Claim, PVC)

PV和PVC使得K8s集群具备了存储的逻辑抽象能力，使得在配置Pod的逻辑里可以忽略对实际后台存储技术的配置，而把这项配置的工作交给PV的配置者，即集群的管理者。

参考:

[kubernetes 最佳实践](https://kubernetes.feisky.xyz/zh/)

[architecture roadmap](https://github.com/kubernetes/community/tree/master/sig-architecture)

[kubernetes 设计理念](https://kubernetes.feisky.xyz/zh/architecture/concepts.html)