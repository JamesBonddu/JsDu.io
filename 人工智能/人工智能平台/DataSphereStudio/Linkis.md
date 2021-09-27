# Linkis

## HUE的痛点

https://juejin.cn/post/6844903904371539981

## Linkis 1.0作业执行流程和新引擎实现解密

https://www.bilibili.com/video/BV1xf4y1k7ZG

# 架构设计

https://github.com/WeBankFinTech/Linkis/wiki/%E6%80%BB%E4%BD%93%E6%9E%B6%E6%9E%84%E8%AE%BE%E8%AE%A1%E4%BB%8B%E7%BB%8D

UJES(Unified Job Execution Service)，统一作业执行服务是Linkis的核心组件之一。项目以微服务架构的实现方式，为大数据生态圈提供了一种大数据作业提交的全新通用框架方案，同时解决现有市面上同类开源项目的一些使用上的痛点。

如上图所示，UJES框架位于上层应用系统与下层计算存储系统之间，是用户作业的管理角色，它将大数据集群的数据存储、计算等功能进行封装，提供了一种统一的作业提交框架，用户不再需要区分作业是spark还是hive等类型，只需要提交给UJES，就可以正确地让集群为自己服务，节省了用户极大的学习成本。

https://github.com/WeBankFinTech/Linkis/wiki/Linkis-UJES%E8%AE%BE%E8%AE%A1%E6%96%87%E6%A1%A3

下面开始介绍用户在上层系统提交了一个SQL，Linkis是如何执行并返回结果的。

流程时序图

上层系统的用户提交一个SQL，先经过Gateway，Gateway负责解析用户请求，并路由转发给合适的统一入口Entrance

entrance会先寻找该系统的该用户是否存在可用的Spark引擎服务，如果存在，则直接将请求提交给Spark引擎服务

不存在可用Spark引擎服务，开始通过Eureka的服务注册发现功能，拿到所有的引擎管理器列表，通过请求RM实时获取引擎管理器的实际负载

Entrance拿到负载最低的引擎管理器，开始要求引擎管理器启动一个Spark引擎服务

引擎管理器接收到请求，开始询问RM该系统下的该用户，是否可以启动新引擎

如果可以启动，则开始请求资源并锁定；否则返回启动失败的异常给到Entrance

锁定资源成功，开始启动新的spark引擎服务；启动成功后，将新Spark新引擎返回给Entrance

Entrance拿到新引擎后，开始向新引擎请求执行SQL

Spark新引擎接收SQL请求，开始向Yarn提交执行SQL，并实时推送日志、进度和状态给Entrance

Entrance将获取的日志、进度和状态实时推送给Gateway

Gateway回推日志、进度和状态给前端

一旦SQL执行成功，Engine主动将结果集推给Entrance，Entrance通知前端拿取结果。

关于Entrance/EngineManager/Engine异常情况下的设计方案，请查看UJES架构设计文档


https://blog.csdn.net/WANTAWAY314/article/details/108638809


# 如何调试Linkis

https://github.com/WeBankFinTech/Linkis-Doc/blob/master/zh_CN/Development_Documents/DEBUG_LINKIS.md


# 安装启动

```sh
# 启动hadoop
/usr/local/hadoop-2.7.2/sbin/start-all.sh
# 停止hadoop
/usr/local/hadoop-2.7.2/sbin/stop-all.sh

# 启动hive2
# https://cloud.tencent.com/developer/article/1697496

hive --service metastore &

https://stackoverflow.com/questions/39254865/spark-installation-spark-2-0-0-bin-hadoop2-7-lib-spark-assembly-jar-no-such
```

# 安装目录依赖 lib的依赖原因

```sh
├── bin 安装目录
│   ├── checkEnv.sh ── 环境变量检测
│   ├── checkServices.sh ── 微服务状态检测
│   ├── common.sh ── 部分公共shell函数
│   ├── install-io.sh ── 用于安装时的依赖替换
│   └── install.sh ── Linkis安装的主脚本
├── conf 配置目录
│   ├── application-eureka.yml
│   ├── application-linkis.yml ──微服务通用yml
│   ├── linkis-cg-engineconnmanager-io.properties
│   ├── linkis-cg-engineconnmanager.properties
│   ├── linkis-cg-engineplugin.properties
│   ├── linkis-cg-entrance.properties
│   ├── linkis-cg-linkismanager.properties
│   ├── linkis-computation-governance
│   │   └── linkis-client
│   │   └── linkis-cli
│   │   ├── linkis-cli.properties
│   │   └── log4j2.xml
│   ├── linkis-env.sh ──linkis environment properties
│   ├── linkis-et-validator.properties
│   ├── linkis-mg-gateway.properties
│   ├── linkis.properties ──linkis global properties
│   ├── linkis-ps-bml.properties
│   ├── linkis-ps-cs.properties
│   ├── linkis-ps-datasource.properties
│   ├── linkis-ps-publicservice.properties
│   ├── log4j2.xml
│   ├── proxy.properties(可选)
│   └── token.properties(可选)
├── db 数据库DML和DDL文件目录
│   ├── linkis_ddl.sql ──数据库表定义SQL
│   ├── linkis_dml.sql ──数据库表初始化SQL
│   └── module ──包含各个微服务的DML和DDL文件
├── lib lib目录
│   ├── linkis-commons ──公共依赖包
│   ├── linkis-computation-governance ──计算治理模块的lib目录
│   ├── linkis-engineconn-plugins ──所有引擎插件的lib目录
│   ├── linkis-public-enhancements ──公共增强服务的lib目录
│   └── linkis-spring-cloud-services ──SpringCloud的lib目录
├── logs 日志目录
│   ├── linkis-cg-engineconnmanager-gc.log
│   ├── linkis-cg-engineconnmanager.log
│   ├── linkis-cg-engineconnmanager.out
│   ├── linkis-cg-engineplugin-gc.log
│   ├── linkis-cg-engineplugin.log
│   ├── linkis-cg-engineplugin.out
│   ├── linkis-cg-entrance-gc.log
│   ├── linkis-cg-entrance.log
│   ├── linkis-cg-entrance.out
│   ├── linkis-cg-linkismanager-gc.log
│   ├── linkis-cg-linkismanager.log
│   ├── linkis-cg-linkismanager.out
│   ├── linkis-et-validator-gc.log
│   ├── linkis-et-validator.log
│   ├── linkis-et-validator.out
│   ├── linkis-mg-eureka-gc.log
│   ├── linkis-mg-eureka.log
│   ├── linkis-mg-eureka.out
│   ├── linkis-mg-gateway-gc.log
│   ├── linkis-mg-gateway.log
│   ├── linkis-mg-gateway.out
│   ├── linkis-ps-bml-gc.log
│   ├── linkis-ps-bml.log
│   ├── linkis-ps-bml.out
│   ├── linkis-ps-cs-gc.log
│   ├── linkis-ps-cs.log
│   ├── linkis-ps-cs.out
│   ├── linkis-ps-datasource-gc.log
│   ├── linkis-ps-datasource.log
│   ├── linkis-ps-datasource.out
│   ├── linkis-ps-publicservice-gc.log
│   ├── linkis-ps-publicservice.log
│   └── linkis-ps-publicservice.out
├── pid 所有微服务的进程ID
│   ├── linkis_cg-engineconnmanager.pid ──引擎管理器微服务
│   ├── linkis_cg-engineconnplugin.pid ──引擎插件微服务
│   ├── linkis_cg-entrance.pid ──引擎入口微服务
│   ├── linkis_cg-linkismanager.pid ──linkis管理器微服务
│   ├── linkis_mg-eureka.pid ──eureka微服务
│   ├── linkis_mg-gateway.pid ──gateway微服务
│   ├── linkis_ps-bml.pid ──物料库微服务
│   ├── linkis_ps-cs.pid ──上下文微服务
│   ├── linkis_ps-datasource.pid ──数据源微服务
│   └── linkis_ps-publicservice.pid ──公共微服务
└── sbin 微服务启停脚本目录
     ├── ext ──各个微服务的启停脚本目录
     ├── linkis-daemon.sh ── 快捷启停、重启单个微服务脚本
    ├── linkis-start-all.sh ── 一键启动全部微服务脚本
   └── linkis-stop-all.sh ── 一键停止全部微服务脚本
```

https://github.com/WeBankFinTech/Linkis-Doc/blob/3b3905da9448a02ef29325691c2f9a2c15d6b857/zh_CN/Deployment_Documents/Installation_Hierarchical_Structure.md


# Linkis接入方式

https://github.com/WeBankFinTech/Linkis-Doc/blob/master/zh_CN/User_Manual/How_To_Use_Linkis.md

https://github.com/WeBankFinTech/Linkis-Doc/blob/master/zh_CN/Development_MEETUP/Phase_Two/chapter2.md

https://github.com/WeBankFinTech/Linkis-Doc/blob/master/zh_CN/Development_MEETUP/Phase_Two/chapter1.md

# scripts使用

https://github.com/WeBankFinTech/Scriptis/blob/master/docs/zh_CN/ch4/Scriptis%E4%BD%BF%E7%94%A8%E6%89%8B%E5%86%8C.md