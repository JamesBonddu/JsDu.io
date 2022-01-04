# DolphinScheduler


在线DEMO: http://106.75.43.194:8888/

官网：https://dolphinscheduler.apache.org

开源地址： https://github.com/apache/incubator-dolphinscheduler



插件

https://www.bookstack.cn/read/dolphinscheduler-1.2.0/99f93be6ac9869a0.md

https://xie.infoq.cn/article/f6fcc093d0a0b3b0272952621

https://blog.csdn.net/qq825193156/article/details/110165230


https://dolphinscheduler.apache.org/zh-cn/blog/Apache-DolphinScheduler-2.0.1.html

# 海豚任务调度

https://dolphinscheduler.apache.org/zh-cn/docs/2.0.1/user_doc/guide/quick-start.html

1. 下载源码包

https://dlcdn.apache.org/dolphinscheduler/2.0.1/apache-dolphinscheduler-2.0.1-bin.tar.gz

https://dlcdn.apache.org/dolphinscheduler/2.0.1/apache-dolphinscheduler-2.0.1-src.tar.gz

2. 拉取镜像并启动服务

```sh
$ tar -zxvf apache-dolphinscheduler-2.0.1-src.tar.gz
$ cd apache-dolphinscheduler-2.0.1-src/docker/docker-swarm
$ docker pull dolphinscheduler.docker.scarf.sh/apache/dolphinscheduler:2.0.1
$ docker tag apache/dolphinscheduler:2.0.1 apache/dolphinscheduler:latest
$ docker-compose up -d
```

访问前端页面： http://192.168.xx.xx:12345/dolphinscheduler (本地地址为 http://127.0.0.1:12345/dolphinscheduler)

默认的用户是

admin

默认的密码是

dolphinscheduler123


# 源码调试

https://www.bilibili.com/video/BV1oh411J7mu?spm_id_from=333.999.0.0


https://dolphinscheduler.apache.org/zh-cn/development/backend/spi/alert.html


https://www.cnblogs.com/lukairui/p/15592541.html


Apache DolphinScheduler 源码剖析之 Worker 容错处理流程

https://blog.csdn.net/DolphinScheduler/article/details/110103020


# window 源码调试

https://dolphinscheduler.apache.org/zh-cn/blog/DS_run_in_windows.html

# 任务大json拆解步骤

https://dolphinscheduler.apache.org/zh-cn/blog/json_split.html

https://dolphinscheduler.apache.org/zh-cn/blog/dolphinscheduler_json.html

## 源码解析

https://mp.weixin.qq.com/s/Ew2DKT-QQeYLSS78-



## 前端开发指南

https://dolphinscheduler.apache.org/zh-cn/development/frontend-development.html

# 案例实战

https://www.jianshu.com/p/6992f41a5704

# CDH集群集成

https://mp.weixin.qq.com/s/d_NBid3BbDhyBI-Sa8xJoQ

https://mp.weixin.qq.com/s/qXBvxgXD1f0HC2CiN4MaPA

https://mp.weixin.qq.com/s/pmg3Ta6_MLcCAGjUdOzLqQ

https://juejin.cn/post/6953261989376294948

https://mp.weixin.qq.com/s/uSvCUJmcLIQBEQ-Dx-JKVw


# 伪造集群部署

https://dolphinscheduler.apache.org/zh-cn/docs/latest/user_doc/guide/installation/pseudo-cluster.html


## 安装环境建议配置

修改 conf/env 目录下的 dolphinscheduler_env.sh 环境变量(以相关用到的软件都安装在/opt/soft下为例)

https://dolphinscheduler.apache.org/zh-cn/docs/1.3.3/user_doc/hardware-environment.html


## 目录含义讲解

https://www.bookstack.cn/read/dolphinscheduler-1.3.0-zh/c1be99cffa3341bf.md

## 修改环境变量配置

https://dolphinscheduler.apache.org/zh-cn/docs/1.3.3/user_doc/standalone-deployment.html

# mysql 替换postgresql

官方打包好的包里面默认的驱动是mysql8.0的这时需要修改驱动名称
由`com.mysql.jdbc.Driver` 改为 `com.mysql.cj.jdbc.Driver`


```sh
# driver-class 名称 com.mysql.cj.jdbc.Driver
#
spring:
  datasource:
    driver-class-name: com.mysql.cj.jdbc.Driver
    url: jdbc:mysql://127.0.0.1:3306/dolphinscheduler?useUnicode=true&characterEncoding=UTF-8&useSSL=false
    username: ds_user
    password: dolphinscheduler
    hikari:
      connection-test-query: select 1
      minimum-idle: 5
      auto-commit: true
      validation-timeout: 3000
      pool-name: DolphinScheduler
      maximum-pool-size: 50
      connection-timeout: 30000
      idle-timeout: 600000
      leak-detection-threshold: 0
      initialization-fail-timeout: 1
```

https://dolphinscheduler.apache.org/zh-cn/docs/latest/user_doc/guide/installation/docker.html


# 与三方系统集成

https://dolphinscheduler.apache.org/zh-cn/docs/latest/user_doc/guide/open-api.html


# 海豚调度竞品对比

https://mp.weixin.qq.com/s/xwLH9Z9EFVvBN_l6hvd4Ng


# 海豚调度登录

https://mp.weixin.qq.com/s/XLzeV30gl4xcfHYMZs8ZdQ

## hive包冲突

1. 通过源码编译部署
如果您通过源码编译进行部署，则可以通过修改 pom 文件的方式替换 hive-jdbc 包为cdh 版本。

修改 pom.xml 文件

配置 cloudera 仓库信息

<repositories>
  <repository>
   <id>cloudera</id>
   <url>https://repository.cloudera.com/artifactory/cloudera-repos/</url>
  </repository>
</repositories>
修改 hive.jdbc.version

<!-- 这⾥以cdh5.15.1和cdh6.3.1为例, 可按实际情况修改为对应版本。 -->
<!-- cdh5.15.1 -->
<hive.jdbc.version>1.1.0-cdh5.15.1</hive.jdbc.version>
<!-- cdh6.3.1 -->
<hive.jdbc.version>2.1.1-cdh6.3.1</hive.jdbc.version>
增加 hive-shims

<!-- 具体版本按实际情况指定 -->
<hive.shims.version>1.1.0-cdh5.15.1</hive.shims.version>

<dependency>
  <groupId>org.apache.hive</groupId>
  <artifactId>hive-shims</artifactId>
  <version>${hive.shims.version}</version>
</dependency>
修改后重新打包编译:
```sh
mvn -U clean package -Prelease -Dmaven.test.skip=true
```
打包完成后可以在lib中看到如下 hive-jdbc 相关 jar 包，说明打包完成， 可以进行部署。
```sh
hive-classification-1.1.0-cdh5.15.1.jar
hive-common-1.1.0-cdh5.15.1.jar
hive-jdbc-1.1.0-cdh5.15.1.jar
hive-metastore-1.1.0-cdh5.15.1.jar
hive-serde-1.1.0-cdh5.15.1.jar
hive-service-1.1.0-cdh5.15.1.jar
hive-shims-0.23-1.1.0-cdh5.16.1.jar
hive-shims-1.1.0-cdh5.16.1.jar
hive-shims-common-1.1.0-cdh5.16.1.jar
hive-shims-scheduler-1.1.0-cdh5.16.1.jar
```
由于 cloudera 仓库对网络有一定要求， 如果打包时下载jar包报错，可以先将官网的包直接部署，并参照已使用官方包部署进行处理。

2. 已使用官方包部署

如果您先前已使用官方包进行部署，那么可在 cdh 集群的任意节点中， 找到 cdh 版本的 hive包。
以我的环境为例，hive包在下列路径中:
/opt/cloudera/parcels/CDH/jars
同样的，只需要在这个路径中找到hive-jdbc相关的包， 然后替换掉Dolphinscheduler lib 中的 hive 包即可(需要移除原先的 hive-jdbc 相关包)。
以下为cdh6所需要的包:
```sh
hive-common-2.1.1-cdh6.3.1.jar
hive-jdbc-2.1.1-cdh6.3.1.jar
hive-metastore-2.1.1-cdh6.3.1.jar
hive-serde-2.1.1-cdh6.3.1.jar
hive-service-2.1.1-cdh6.3.1.jar
hive-service-rpc-2.1.1-cdh6.3.1.jar
hive-shims-0.23-2.1.1-cdh6.3.1.jar
hive-shims-2.1.1-cdh6.3.1.jar
hive-shims-common-2.1.1-cdh6.3.1.jar
hive-shims-scheduler-2.1.1-cdh6.3.1.jar
```
替换完成后，重启 Dolphinscheduler 即可。

https://blog.csdn.net/DolphinScheduler/article/details/109984188

https://my.oschina.net/dailidong/blog/4483145


hive冲突解决

https://blog.csdn.net/lyq7269/article/details/114666047


# 海豚调度系统使用

## 全局参数

https://dolphinscheduler.apache.org/zh-cn/docs/latest/user_doc/guide/parameter/global.html
