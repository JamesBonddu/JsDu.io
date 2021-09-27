# DSS

# 快速入门指南

https://github.com/WeBankFinTech/DataSphereStudio/blob/master/docs/en_US/ch3/DataSphereStudio_quick_start.md

# 与外部系统集成的平台

https://github.com/WeBankFinTech/DataSphereStudio/blob/master/docs/en_US/ch4/The%20Guide%20for%20Third-party%20Systems%20accessing%20DSS.md


# 报错

1. 部署DSS 和 Linkis 的服务器，不要求必须安装Hadoop，但要求hdfs命令必须可用，如：hdfs dfs -ls /。

[root@DataSphereStudio-Test data]# hdfs dfs -ls
ls: Call From DataSphereStudio-Test/172.19.196.66 to localhost:9000 failed on connection exception: java.net.ConnectException: Connection refused; For more details see:  http://wiki.apache.org/hadoop/ConnectionRefused

## 重启hadoop

```sh
cd /usr/local/hadoop-2.7.2/sbin
[root@DataSphereStudio-Test sbin]# ./stop-all.sh 
This script is Deprecated. Instead use stop-dfs.sh and stop-yarn.sh
Stopping namenodes on [localhost]
localhost: no namenode to stop
localhost: no datanode to stop
Stopping secondary namenodes [0.0.0.0]
0.0.0.0: no secondarynamenode to stop
stopping yarn daemons
no resourcemanager to stop
localhost: no nodemanager to stop
no proxyserver to stop


[root@DataSphereStudio-Test sbin]# ./start-all.sh 
This script is Deprecated. Instead use start-dfs.sh and start-yarn.sh
Starting namenodes on [localhost]
localhost: starting namenode, logging to /usr/local/hadoop-2.7.2/logs/hadoop-root-namenode-DataSphereStudio-Test.out
localhost: starting datanode, logging to /usr/local/hadoop-2.7.2/logs/hadoop-root-datanode-DataSphereStudio-Test.out
Starting secondary namenodes [0.0.0.0]
0.0.0.0: starting secondarynamenode, logging to /usr/local/hadoop-2.7.2/logs/hadoop-root-secondarynamenode-DataSphereStudio-Test.out
starting yarn daemons
starting resourcemanager, logging to /usr/local/hadoop-2.7.2/logs/yarn-root-resourcemanager-DataSphereStudio-Test.out
localhost: starting nodemanager, logging to /usr/local/hadoop-2.7.2/logs/yarn-root-nodemanager-DataSphereStudio-Test.out


[root@DataSphereStudio-Test sbin]# hdfs dfs -ls /
Found 1 items
drwx-wx-wx   - root supergroup          0 2021-07-05 05:57 /tmp
```

## dss install 安装报错

```sh
[root@DataSphereStudio-Test dss_linkis]# sh bin/install.sh 
<-----start to check used cmd---->
<-----end to check used cmd---->
Succeed to + check env

WARN:Please check your Linux commands: mv, cp, rm, aliases may have been set, which will cause repeated prompts for 'y' or 'n' !
!!

Welcome to DSS & Linkis Deployment Service!
Suitable for Linkis and DSS first installation, please be sure the environment is ready.
Please enter the installation mode. such as: 1
 1: Lite
 2: Standard

Please input the choice:2
You chose Standard installation mode.
########################################################################
###################### Start to install Linkis #########################
########################################################################
Start to unzip linkis package.
cp: overwrite '/data/apps/dss_linkis/linkis/bin/checkEnv.sh'? y
cp: overwrite '/data/apps/dss_linkis/linkis/bin/checkServices.sh'? y
cp: overwrite '/data/apps/dss_linkis/linkis/bin/common.sh'? y
cp: overwrite '/data/apps/dss_linkis/linkis/bin/install.sh'? y
cp: overwrite '/data/apps/dss_linkis/linkis/bin/start-all.sh'? 
cp: overwrite '/data/apps/dss_linkis/linkis/bin/stop-all.sh'? 
Succeed to + Unzip linkis package to /data/apps/dss_linkis/linkis.
<-----start to check used cmd---->
<-----end to check used cmd---->
Succeed to + check env
step1:load config 
Succeed to + load config
You chose Standard installation mode
Python 3.6.8
Succeed to + execute python --version
openjdk version "1.8.0_292"
OpenJDK Runtime Environment (build 1.8.0_292-b10)
OpenJDK 64-Bit Server VM (build 25.292-b10, mixed mode)
Succeed to + execute java --version

hadoop version match
WARN: Your hive version is not 1.2, there may be compatibility issues:
 1: Continue installation, there may be compatibility issues
 2: Exit installation

Please input the choice:Welcome to
      ____              __
     / __/__  ___ _____/ /__
    _\ \/ _ \/ _ `/ __/  '_/
   /___/ .__/\_,_/_/ /_/\_\   version 2.4.8
      /_/
                        
Using Scala version 2.11.12, OpenJDK 64-Bit Server VM, 1.8.0_292
Branch HEAD
Compiled by user viirya on 2021-05-08T08:01:33Z
Revision 4be40640e063612aa50772b2ceeca1c930029553
Url https://gitbox.apache.org/repos/asf/spark.git
Type --help for more information.
Succeed to + execute spark-submit --version
Do you want to clear Linkis table information in the database?
 1: Do not execute table-building statements
 2: Dangerous! Clear all data and rebuild the tables

Please input the choice:2 
You chose Rebuild the table
create hdfs  directory and local directory
Succeed to + create file:///tmp/linkis/ directory
Succeed to + create hdfs:///tmp/linkis directory
Succeed to + create hdfs:///tmp/linkis directory
mysql: [Warning] Using a password on the command line interface can be insecure.
mysql: [Warning] Using a password on the command line interface can be insecure.
Succeed to + source linkis_ddl.sql
mysql: [Warning] Using a password on the command line interface can be insecure.
+-----------------------+
| @application_id := id |
+-----------------------+
|                     1 |
+-----------------------+
+-----------------------+
| @application_id := id |
+-----------------------+
|                     2 |
+-----------------------+
+-----------------------+
| @application_id := id |
+-----------------------+
|                     4 |
+-----------------------+
+-----------------------+
| @application_id := id |
+-----------------------+
|                     6 |
+-----------------------+
+-----------------------+
| @application_id := id |
+-----------------------+
|                     7 |
+-----------------------+
+-----------------------+
| @application_id := id |
+-----------------------+
|                     8 |
+-----------------------+
+-----------------------+
| @application_id := id |
+-----------------------+
|                     1 |
+-----------------------+
+-----------------------+
| @application_id := id |
+-----------------------+
|                     3 |
+-----------------------+
+---------------+
| @key_id := id |
+---------------+
|             1 |
+---------------+
+----------------+
| @tree_id := id |
+----------------+
|              1 |
+----------------+
+---------------+
| @key_id := id |
+---------------+
|             4 |
+---------------+
+----------------+
| @tree_id := id |
+----------------+
|              1 |
+----------------+
+---------------+
| @key_id := id |
+---------------+
|             5 |
+---------------+
+----------------+
| @tree_id := id |
+----------------+
|              1 |
+----------------+
+---------------+
| @key_id := id |
+---------------+
|             2 |
+---------------+
+----------------+
| @tree_id := id |
+----------------+
|              2 |
+----------------+
+---------------+
| @key_id := id |
+---------------+
|             3 |
+---------------+
+----------------+
| @tree_id := id |
+----------------+
|              3 |
+----------------+
+---------------+
| @key_id := id |
+---------------+
|             7 |
+---------------+
+----------------+
| @tree_id := id |
+----------------+
|              4 |
+----------------+
+---------------+
| @key_id := id |
+---------------+
|             6 |
+---------------+
+----------------+
| @tree_id := id |
+----------------+
|              5 |
+----------------+
+-------------+
| @key_id:=id |
+-------------+
|           8 |
+-------------+
+------------------+
| @tree_id := t.id |
+------------------+
|                6 |
+------------------+
+-------------+
| @key_id:=id |
+-------------+
|          16 |
+-------------+
+------------------+
| @tree_id := t.id |
+------------------+
|                7 |
+------------------+
+-------------+
| @key_id:=id |
+-------------+
|           9 |
+-------------+
+------------------+
| @tree_id := t.id |
+------------------+
|                6 |
+------------------+
+-------------+
| @key_id:=id |
+-------------+
|          10 |
+-------------+
+------------------+
| @tree_id := t.id |
+------------------+
|                6 |
+------------------+
+-------------+
| @key_id:=id |
+-------------+
|          11 |
+-------------+
+------------------+
| @tree_id := t.id |
+------------------+
|                6 |
+------------------+
+-------------+
| @key_id:=id |
+-------------+
|          12 |
+-------------+
+------------------+
| @tree_id := t.id |
+------------------+
|                6 |
+------------------+
+-------------+
| @key_id:=id |
+-------------+
|          23 |
+-------------+
+------------------+
| @tree_id := t.id |
+------------------+
|               14 |
+------------------+
+-------------+
| @key_id:=id |
+-------------+
|          22 |
+-------------+
+------------------+
| @tree_id := t.id |
+------------------+
|               13 |
+------------------+
+-------------+
| @key_id:=id |
+-------------+
|          24 |
+-------------+
+------------------+
| @tree_id := t.id |
+------------------+
|               14 |
+------------------+
+-------------+
| @key_id:=id |
+-------------+
|          25 |
+-------------+
+------------------+
| @tree_id := t.id |
+------------------+
|               14 |
+------------------+
+-------------+
| @key_id:=id |
+-------------+
|          26 |
+-------------+
+------------------+
| @tree_id := t.id |
+------------------+
|               14 |
+------------------+
+-------------+
| @key_id:=id |
+-------------+
|          27 |
+-------------+
+------------------+
| @tree_id := t.id |
+------------------+
|               14 |
+------------------+
+-----------------+
| @key_id := k.id |
+-----------------+
|              28 |
+-----------------+
+------------------+
| @tree_id := t.id |
+------------------+
|               12 |
+------------------+
+-----------------+
| @key_id := k.id |
+-----------------+
|              29 |
+-----------------+
+------------------+
| @tree_id := t.id |
+------------------+
|               12 |
+------------------+
+-----------------+
| @key_id := k.id |
+-----------------+
|              30 |
+-----------------+
+------------------+
| @tree_id := t.id |
+------------------+
|               12 |
+------------------+
+-----------------+
| @key_id := k.id |
+-----------------+
|              31 |
+-----------------+
+------------------+
| @tree_id := t.id |
+------------------+
|               12 |
+------------------+
+-----------------+
| @key_id := k.id |
+-----------------+
|              32 |
+-----------------+
+------------------+
| @tree_id := t.id |
+------------------+
|               12 |
+------------------+
+-----------------+
| @key_id := k.id |
+-----------------+
|              15 |
+-----------------+
+------------------+
| @tree_id := t.id |
+------------------+
|                8 |
+------------------+
+-----------------+
| @key_id := k.id |
+-----------------+
|              13 |
+-----------------+
+------------------+
| @tree_id := t.id |
+------------------+
|                9 |
+------------------+
+-----------------+
| @key_id := k.id |
+-----------------+
|              18 |
+-----------------+
+------------------+
| @tree_id := t.id |
+------------------+
|                9 |
+------------------+
+-----------------+
| @key_id := k.id |
+-----------------+
|              19 |
+-----------------+
+------------------+
| @tree_id := t.id |
+------------------+
|                9 |
+------------------+
+-----------------+
| @key_id := k.id |
+-----------------+
|              20 |
+-----------------+
+------------------+
| @tree_id := t.id |
+------------------+
|                9 |
+------------------+
+-----------------+
| @key_id := k.id |
+-----------------+
|              14 |
+-----------------+
+------------------+
| @tree_id := t.id |
+------------------+
|                9 |
+------------------+
+-----------------+
| @key_id := k.id |
+-----------------+
|              17 |
+-----------------+
+------------------+
| @tree_id := t.id |
+------------------+
|               10 |
+------------------+
+-----------------+
| @key_id := k.id |
+-----------------+
|              21 |
+-----------------+
+------------------+
| @tree_id := t.id |
+------------------+
|               11 |
+------------------+
+---------------------+
| @application_id:=id |
+---------------------+
|                   3 |
+---------------------+
+--------------+
| @jdbc_id:=id |
+--------------+
|            9 |
+--------------+
+--------------+
| @key_id1:=id |
+--------------+
|           36 |
+--------------+
+--------------+
| @key_id2:=id |
+--------------+
|           37 |
+--------------+
+--------------+
| @key_id3:=id |
+--------------+
|           38 |
+--------------+
+-----------------+
| @tree_id1:=t.id |
+-----------------+
|              17 |
+-----------------+
+-----------------+
| @key_id := k.id |
+-----------------+
|              33 |
+-----------------+
+------------------+
| @tree_id := t.id |
+------------------+
|               15 |
+------------------+
+-----------------+
| @key_id := k.id |
+-----------------+
|              34 |
+-----------------+
+------------------+
| @tree_id := t.id |
+------------------+
|               16 |
+------------------+
+-----------------+
| @key_id := k.id |
+-----------------+
|              35 |
+-----------------+
+------------------+
| @tree_id := t.id |
+------------------+
|               16 |
+------------------+
Succeed to + source linkis_dml.sql
Rebuild the table
eureka-step1: create dir
Is local execution:test -e /data/apps/dss_linkis/linkis
eureka-step2:copy install package
Is local cp 

# Linkis安装成功
Succeed to + install Linkis
########################################################################
###################### Start to install DSS Server #####################
########################################################################
Start to unzip dss server package.
cp: overwrite '/data/apps/dss_linkis/dss/bin/checkEnv.sh'? y

Succeed to + Unzip dss server package to /data/apps/dss_linkis/dss
<-----start to check used cmd---->
<-----end to check used cmd---->
Succeed to + check env
step1:load config
Succeed to + load config
You chose Standard installation mode
openjdk version "1.8.0_292"
OpenJDK Runtime Environment (build 1.8.0_292-b10)
OpenJDK 64-Bit Server VM (build 25.292-b10, mixed mode)
Succeed to + execute java --version
telnet check for your MYSQL, if you wait for a long time,may be your MYSQL does not prepared
MYSQL is OK.
Do you want to clear DSS table information in the database?
 1: Do not execute table-building statements
 2: Dangerous! Clear all data and rebuild the tables.

# 重置数据安装DSS Server 和Web
Succeed to + install schedulis.zip
Succeed to + subsitution conf of schedulis
<----------------schedulis:end------------------->
Succeed to + install DSS Server
########################################################################
###################### Start to install DSS Web ########################
########################################################################
Start to unzip dss web package.
Succeed to + Unzip dss web package to /data/apps/dss_linkis/web
dss web install start
linux
========================================================================配置信息=======================================================================
DSS web访问端口：8088
Linkis gateway 的地址：http://127.0.0.1:9001
DSS web 静态文件地址：/data/apps/dss_linkis/web/dist
DSS web 安装路径：/data/apps/dss_linkis/web
DSS nginx ip：127.0.0.1
========================================================================配置信息=======================================================================

Succeed to + install DSS Web
########################################################################
###################### Start to install AZKABAN SERVER #################
########################################################################
Start to install azkaban server.


Succeed to + Install azkaban server.
########################################################################
############# Start to install Linkis JobTpye for azkaban server #######
########################################################################
```

# azkaban server 调度的端口链接有问题

azkaban 安装部署

https://www.codenong.com/cs105844352/

```sh
########################################################################
############# Start to install Linkis JobTpye for azkaban server #######
########################################################################

curl: (7) Failed to connect to 127.0.0.1 port 12321: Connection refused

########################################################################
############# Start to install qualitis server #######
########################################################################
Start to unzip qualitis package.
Succeed to + Unzip dss web package to /data/apps/dss_linkis/qualitis
mysql: [Warning] Using a password on the command line interface can be insecure.
Succeed to + source init.sql
Succeed to + subsitution qualitis application-dev.yml config
Succeed to + install qualitis server
```


## Hadoop、Hbase、Hive和zookeeper版本匹配关系

hive和hadoop兼容
```sh
# hadoop 版本
[root@DataSphereStudio-Test apps]# hadoop version
Hadoop 2.7.2
Subversion https://git-wip-us.apache.org/repos/asf/hadoop.git -r b165c4fe8a74265c792ce23f546c64604acf0e41
Compiled by jenkins on 2016-01-26T00:08Z
Compiled with protoc 2.5.0
From source with checksum d0fda26633fa762bff87ec759ebe689c
This command was run using /usr/local/hadoop-2.7.2/share/hadoop/common/hadoop-common-2.7.2.jar
```

http://hive.apache.org/downloads.html

https://blog.csdn.net/u014333671/article/details/81196341

## dss_links 的visualis-server microservice is not start successful !!! ERROR logs as follows

```sh

===========================================================
<--------------------------------------------------------------------------->
ERROR your visualis-server microservice is not start successful !!! ERROR logs as follows :
PLEAESE CHECK  DETAIL LOG,LOCATION:/data/apps/dss_linkis/dss/visualis-server/logs/linkis.out
<------------------------------------------------------------->
Is local 0
Caused by: javax.net.ssl.SSLHandshakeException: No appropriate protocol (protocol is disabled or cipher suites are inappropriate)
	at sun.security.ssl.HandshakeContext.<init>(HandshakeContext.java:171) ~[?:1.8.0_292]
	at sun.security.ssl.ClientHandshakeContext.<init>(ClientHandshakeContext.java:98) ~[?:1.8.0_292]
	at sun.security.ssl.TransportContext.kickstart(TransportContext.java:220) ~[?:1.8.0_292]
	at sun.security.ssl.SSLSocketImpl.startHandshake(SSLSocketImpl.java:428) ~[?:1.8.0_292]
	at com.mysql.jdbc.ExportControlled.transformSocketToSSLSocket(ExportControlled.java:188) ~[mysql-connector-java-5.1.44.jar:5.1.44]
	... 21 more

2021-07-06 15:20:29.283 INFO  [Druid-ConnectionPool-Create-551319099] com.alibaba.druid.pool.DruidAbstractDataSource 1790 setFailContinuous - {dataSource-1} failContinuous is true
2021-07-06 15:20:31.150 INFO  [main] org.springframework.boot.web.servlet.ServletRegistrationBean 186 addRegistration - Servlet statViewServlet mapped to [/druid/*]
2021-07-06 15:20:31.152 INFO  [main] org.springframework.boot.web.servlet.ServletRegistrationBean 186 addRegistration - Servlet dispatcherServlet mapped to [/]
2021-07-06 15:20:31.153 INFO  [main] org.springframework.boot.web.servlet.FilterRegistrationBean 245 configure - Mapping filter: 'characterEncodingFilter' to: [/*]
2021-07-06 15:20:31.154 INFO  [main] org.springframework.boot.web.servlet.FilterRegistrationBean 245 configure - Mapping filter: 'httpTraceFilter' to: [/*]
2021-07-06 15:20:31.154 INFO  [main] org.springframework.boot.web.servlet.FilterRegistrationBean 258 configure - Mapping filter: 'webStatFilter' to urls: [/*]
2021-07-06 15:20:31.155 INFO  [main] org.springframework.boot.web.servlet.FilterRegistrationBean 245 configure - Mapping filter: 'webMvcMetricsFilter' to: [/*]
2021-07-06 15:20:31.160 INFO  [main] org.eclipse.jetty.server.handler.ContextHandler 851 doStart - Started o.s.b.w.e.j.JettyEmbeddedWebAppContext@3304362e{application,/,[file:///tmp/jetty-docbase.4843534003128154558.9007/, jar:file:/data/apps/dss_linkis/dss/visualis-server/lib/jquery-1.11.3.jar!/META-INF/resources, jar:file:/data/apps/dss_linkis/dss/visualis-server/lib/springfox-swagger-ui-2.6.1.jar!/META-INF/resources],AVAILABLE}
2021-07-06 15:20:31.161 INFO  [main] org.eclipse.jetty.server.Server 411 doStart - Started @13697ms
2021-07-06 15:20:31.185 INFO  [main] org.springframework.aop.framework.CglibAopProxy 265 doValidateClass - Final method [protected final void org.springframework.boot.web.servlet.support.SpringBootServletInitializer.setRegisterErrorPageFilter(boolean)] cannot get proxied via CGLIB: Calls to this method will NOT be routed to the target instance and might lead to NPEs against uninitialized fields in the proxy instance.
2021-07-06 15:20:31.195 INFO  [main] com.webank.wedatasphere.linkis.entrance.conf.EntranceSpringConfiguration$$EnhancerBySpringCGLIB$$5f45e9e4 59 <init> - load the ujes-entrance spring configuration.
2021-07-06 15:20:31.460 INFO  [main] com.webank.wedatasphere.linkis.entrance.execute.impl.EntranceExecutorManagerImpl 42 info - load entranceExecutorRules => List(exceptInstances, fixedInstance)
2021-07-06 15:20:31.554 INFO  [main] com.webank.wedatasphere.linkis.entrance.event.EntranceEventListenerBus 42 info - visualis-EventListenerBus-ListenerBus add a new listener => class com.webank.wedatasphere.linkis.entrance.execute.impl.EngineManagerImpl
2021-07-06 15:20:31.702 INFO  [main] com.webank.wedatasphere.linkis.entrance.execute.impl.EngineManagerImpl 42 info - begin to read all alive engines for entrance remark.
2021-07-06 15:20:31.904 INFO  [main] org.springframework.cloud.netflix.eureka.InstanceInfoFactory 71 create - Setting initial instance status as: STARTING
2021-07-06 15:20:31.962 INFO  [main] com.netflix.discovery.DiscoveryClient 347 <init> - Initializing Eureka in region us-east-1
2021-07-06 15:20:32.082 INFO  [main] com.netflix.discovery.provider.DiscoveryJerseyProvider 70 <init> - Using JSON encoding codec LegacyJacksonJson
2021-07-06 15:20:32.083 INFO  [main] com.netflix.discovery.provider.DiscoveryJerseyProvider 71 <init> - Using JSON decoding codec LegacyJacksonJson
2021-07-06 15:20:32.229 INFO  [main] com.netflix.discovery.provider.DiscoveryJerseyProvider 80 <init> - Using XML encoding codec XStreamXml
2021-07-06 15:20:32.229 INFO  [main] com.netflix.discovery.provider.DiscoveryJerseyProvider 81 <init> - Using XML decoding codec XStreamXml
2021-07-06 15:20:32.617 INFO  [main] com.netflix.discovery.shared.resolver.aws.ConfigClusterResolver 43 getClusterEndpoints - Resolving eureka endpoints via configuration
2021-07-06 15:20:32.687 INFO  [main] com.netflix.discovery.DiscoveryClient 934 fetchRegistry - Disable delta property : false
2021-07-06 15:20:32.699 INFO  [main] com.netflix.discovery.DiscoveryClient 935 fetchRegistry - Single vip registry refresh property : null
2021-07-06 15:20:32.699 INFO  [main] com.netflix.discovery.DiscoveryClient 936 fetchRegistry - Force full registry fetch : false
2021-07-06 15:20:32.699 INFO  [main] com.netflix.discovery.DiscoveryClient 937 fetchRegistry - Application is null : false
2021-07-06 15:20:32.700 INFO  [main] com.netflix.discovery.DiscoveryClient 938 fetchRegistry - Registered Applications size is zero : true
2021-07-06 15:20:32.700 INFO  [main] com.netflix.discovery.DiscoveryClient 940 fetchRegistry - Application version is -1: true
2021-07-06 15:20:32.700 INFO  [main] com.netflix.discovery.DiscoveryClient 1023 getAndStoreFullRegistry - Getting all instance registry info from the eureka server
2021-07-06 15:20:32.942 INFO  [main] com.netflix.discovery.DiscoveryClient 1032 getAndStoreFullRegistry - The response status is 200
2021-07-06 15:20:32.948 INFO  [main] com.netflix.discovery.DiscoveryClient 1258 initScheduledTasks - Starting heartbeat executor: renew interval is: 30
2021-07-06 15:20:32.955 INFO  [main] com.netflix.discovery.InstanceInfoReplicator 59 <init> - InstanceInfoReplicator onDemand update allowed rate per min is 4
2021-07-06 15:20:32.958 INFO  [main] com.netflix.discovery.DiscoveryClient 434 <init> - Discovery Client initialized at timestamp 1625556032958 with initial instances count: 18
2021-07-06 15:20:32.976 INFO  [main] com.webank.wedatasphere.linkis.entrance.execute.impl.EngineManagerImpl 42 info - all alive engines has been marked.
2021-07-06 15:20:33.016 INFO  [main] com.webank.wedatasphere.linkis.rpc.RPCReceiveRestful 42 info - init all receiverChoosers in spring beans, list => List(com.webank.wedatasphere.linkis.entrance.execute.EntranceReceiverChooser@679f3e12, com.webank.wedatasphere.linkis.rpc.CommonReceiverChooser@415cb259)
2021-07-06 15:20:33.020 INFO  [main] com.webank.wedatasphere.linkis.rpc.RPCReceiveRestful 42 info - init all receiverSenderBuilders in spring beans, list => List(com.webank.wedatasphere.linkis.rpc.CommonReceiverSenderBuilder@393b99d)
2021-07-06 15:20:33.029 INFO  [main] com.webank.wedatasphere.linkis.rpc.RPCReceiveRestful 42 info - init RPCReceiverListenerBus with queueSize 1000 and consumeThreadSize 10.
2021-07-06 15:20:33.031 INFO  [main] com.webank.wedatasphere.linkis.rpc.AsynRPCMessageBus 42 info - RPC-Receiver-Asyn-Thread-ListenerBus add a new listener => class com.webank.wedatasphere.linkis.rpc.RPCReceiveRestful$$anon$1
2021-07-06 15:20:33.032 INFO  [main] com.webank.wedatasphere.linkis.rpc.RPCReceiveRestful 42 info - add a new RPCBroadcastListener => class com.webank.wedatasphere.linkis.entrance.execute.NewEngineBroadcastListener
2021-07-06 15:20:33.033 INFO  [main] com.webank.wedatasphere.linkis.rpc.AsynRPCMessageBus 42 info - RPC-Receiver-Asyn-Thread-ListenerBus add a new listener => class com.webank.wedatasphere.linkis.rpc.RPCReceiveRestful$$anon$2
2021-07-06 15:20:33.033 INFO  [main] com.webank.wedatasphere.linkis.rpc.RPCReceiveRestful 42 info - add a new RPCBroadcastListener => class com.webank.wedatasphere.linkis.entrance.execute.ResponseEngineStatusChangedBroadcastListener
2021-07-06 15:20:33.033 INFO  [main] com.webank.wedatasphere.linkis.rpc.AsynRPCMessageBus 42 info - RPC-Receiver-Asyn-Thread-ListenerBus add a new listener => class com.webank.wedatasphere.linkis.rpc.RPCReceiveRestful$$anon$2
2021-07-06 15:20:34.603 WARN  [main] org.thymeleaf.templatemode.TemplateMode 150 parse - [THYMELEAF][main] Template Mode 'HTML5' is deprecated. Using Template Mode 'HTML' instead.
<-------------------------------------------------------------->
PLEAESE CHECK DETAIL LOG,LOCATION:/data/apps/dss_linkis/dss/visualis-server/logs/linkis.out
ERROR:   + start visualis-server
Failed to  + start DSS Server
```

## linkis报错

```sh
2021-07-06 15:20:29.142 ERROR [main] com.alibaba.druid.pool.DruidDataSource 936 init - init datasource error, url: jdbc:mysql://127.0.0.1:3306/dss?characterEncoding=UTF-8 com.mysql.jdbc.exceptions.jdbc4.CommunicationsException: Communications link failure

The last packet successfully received from the server was 240 milliseconds ago.  The last packet sent successfully to the server was 231 milliseconds ago.
	at sun.reflect.NativeConstructorAccessorImpl.newInstance0(Native Method) ~[?:1.8.0_292]
	at sun.reflect.NativeConstructorAccessorImpl.newInstance(NativeConstructorAccessorImpl.java:62) ~[?:1.8.0_292]
	at sun.reflect.DelegatingConstructorAccessorImpl.newInstance(DelegatingConstructorAccessorImpl.java:45) ~[?:1.8.0_292]
	at java.lang.reflect.Constructor.newInstance(Constructor.java:423) ~[?:1.8.0_292]
	at com.mysql.jdbc.Util.handleNewInstance(Util.java:425) ~[mysql-connector-java-5.1.44.jar:5.1.44]
	at com.mysql.jdbc.SQLError.createCommunicationsException(SQLError.java:989) ~[mysql-connector-java-5.1.44.jar:5.1.44]
	at com.mysql.jdbc.ExportControlled.transformSocketToSSLSocket(ExportControlled.java:203) ~[mysql-connector-java-5.1.44.jar:5.1.44]
	at com.mysql.jdbc.MysqlIO.negotiateSSLConnection(MysqlIO.java:4901) ~[mysql-connector-java-5.1.44.jar:5.1.44]
	at com.mysql.jdbc.MysqlIO.proceedHandshakeWithPluggableAuthentication(MysqlIO.java:1659) ~[mysql-connector-java-5.1.44.jar:5.1.44]
	at com.mysql.jdbc.MysqlIO.doHandshake(MysqlIO.java:1226) ~[mysql-connector-java-5.1.44.jar:5.1.44]
	at com.mysql.jdbc.ConnectionImpl.coreConnect(ConnectionImpl.java:2191) ~[mysql-connector-java-5.1.44.jar:5.1.44]
	at com.mysql.jdbc.ConnectionImpl.connectOneTryOnly(ConnectionImpl.java:2222) ~[mysql-connector-java-5.1.44.jar:5.1.44]
	at com.mysql.jdbc.ConnectionImpl.createNewIO(ConnectionImpl.java:2017) ~[mysql-connector-java-5.1.44.jar:5.1.44]
	at com.mysql.jdbc.ConnectionImpl.<init>(ConnectionImpl.java:779) ~[mysql-connector-java-5.1.44.jar:5.1.44]
	at com.mysql.jdbc.JDBC4Connection.<init>(JDBC4Connection.java:47) ~[mysql-connector-java-5.1.44.jar:5.1.44]
	at sun.reflect.NativeConstructorAccessorImpl.newInstance0(Native Method) ~[?:1.8.0_292]
	at sun.reflect.NativeConstructorAccessorImpl.newInstance(NativeConstructorAccessorImpl.java:62) ~[?:1.8.0_292]
	at sun.reflect.DelegatingConstructorAccessorImpl.newInstance(DelegatingConstructorAccessorImpl.java:45) ~[?:1.8.0_292]
	at java.lang.reflect.Constructor.newInstance(Constructor.java:423) ~[?:1.8.0_292]
	at com.mysql.jdbc.Util.handleNewInstance(Util.java:425) ~[mysql-connector-java-5.1.44.jar:5.1.44]
	at com.mysql.jdbc.ConnectionImpl.getInstance(ConnectionImpl.java:389) ~[mysql-connector-java-5.1.44.jar:5.1.44]
	at com.mysql.jdbc.NonRegisteringDriver.connect(NonRegisteringDriver.java:330) ~[mysql-connector-java-5.1.44.jar:5.1.44]
	at com.alibaba.druid.filter.FilterChainImpl.connection_connect(FilterChainImpl.java:156) ~[druid-1.1.20.jar:1.1.20]
	at com.alibaba.druid.filter.stat.StatFilter.connection_connect(StatFilter.java:218) ~[druid-1.1.20.jar:1.1.20]
	at com.alibaba.druid.filter.FilterChainImpl.connection_connect(FilterChainImpl.java:150) ~[druid-1.1.20.jar:1.1.20]
	at com.alibaba.druid.pool.DruidAbstractDataSource.createPhysicalConnection(DruidAbstractDataSource.java:1645) ~[druid-1.1.20.jar:1.1.20]
	at com.alibaba.druid.pool.DruidAbstractDataSource.createPhysicalConnection(DruidAbstractDataSource.java:1709) ~[druid-1.1.20.jar:1.1.20]
	at com.alibaba.druid.pool.DruidDataSource.init(DruidDataSource.java:932) ~[druid-1.1.20.jar:1.1.20]
	at edp.core.config.DruidConfig.druidDataSource(DruidConfig.java:151) ~[visualis-server-0.5.0.jar:?]
	at edp.core.config.DruidConfig$$EnhancerBySpringCGLIB$$155ee6c5.CGLIB$druidDataSource$0(<generated>) ~[visualis-server-0.5.0.jar:?]
	at edp.core.config.DruidConfig$$EnhancerBySpringCGLIB$$155ee6c5$$FastClassBySpringCGLIB$$25271246.invoke(<generated>) ~[visualis-server-0.5.0.jar:?]
	at org.springframework.cglib.proxy.MethodProxy.invokeSuper(MethodProxy.java:228) ~[spring-core-5.0.8.RELEASE.jar:5.0.8.RELEASE]
	at org.springframework.context.annotation.ConfigurationClassEnhancer$BeanMethodInterceptor.intercept(ConfigurationClassEnhancer.java:361) ~[spring-context-5.0.7.RELEASE.jar:5.0.7.RELEASE]
	at edp.core.config.DruidConfig$$EnhancerBySpringCGLIB$$155ee6c5.druidDataSource(<generated>) ~[visualis-server-0.5.0.jar:?]
	at sun.reflect.NativeMethodAccessorImpl.invoke0(Native Method) ~[?:1.8.0_292]
	at sun.reflect.NativeMethodAccessorImpl.invoke(NativeMethodAccessorImpl.java:62) ~[?:1.8.0_292]
	at sun.reflect.DelegatingMethodAccessorImpl.invoke(DelegatingMethodAccessorImpl.java:43) ~[?:1.8.0_292]
	at java.lang.reflect.Method.invoke(Method.java:498) ~[?:1.8.0_292]
	at org.springframework.beans.factory.support.SimpleInstantiationStrategy.instantiate(SimpleInstantiationStrategy.java:154) ~[spring-beans-5.0.8.RELEASE.jar:5.0.8.RELEASE]
	at org.springframework.beans.factory.support.ConstructorResolver.instantiateUsingFactoryMethod(ConstructorResolver.java:582) ~[spring-beans-5.0.8.RELEASE.jar:5.0.8.RELEASE]
	at org.springframework.beans.factory.support.AbstractAutowireCapableBeanFactory.instantiateUsingFactoryMethod(AbstractAutowireCapableBeanFactory.java:1247) ~[spring-beans-5.0.8.RELEASE.jar:5.0.8.RELEASE]
	at org.springframework.beans.factory.support.AbstractAutowireCapableBeanFactory.createBeanInstance(AbstractAutowireCapableBeanFactory.java:1096) ~[spring-beans-5.0.8.RELEASE.jar:5.0.8.RELEASE]
	at org.springframework.beans.factory.support.AbstractAutowireCapableBeanFactory.doCreateBean(AbstractAutowireCapableBeanFactory.java:535) ~[spring-beans-5.0.8.RELEASE.jar:5.0.8.RELEASE]
	at org.springframework.beans.factory.support.AbstractAutowireCapableBeanFactory.createBean(AbstractAutowireCapableBeanFactory.java:495) ~[spring-beans-5.0.8.RELEASE.jar:5.0.8.RELEASE]
	at org.springframework.beans.factory.support.AbstractBeanFactory.lambda$doGetBean$0(AbstractBeanFactory.java:317) ~[spring-beans-5.0.8.RELEASE.jar:5.0.8.RELEASE]
	at org.springframework.beans.factory.support.DefaultSingletonBeanRegistry.getSingleton(DefaultSingletonBeanRegistry.java:222) ~[spring-beans-5.0.8.RELEASE.jar:5.0.8.RELEASE]
	at org.springframework.beans.factory.support.AbstractBeanFactory.doGetBean(AbstractBeanFactory.java:315) ~[spring-beans-5.0.8.RELEASE.jar:5.0.8.RELEASE]
	at org.springframework.beans.factory.support.AbstractBeanFactory.getBean(AbstractBeanFactory.java:199) ~[spring-beans-5.0.8.RELEASE.jar:5.0.8.RELEASE]
	at org.springframework.beans.factory.config.DependencyDescriptor.resolveCandidate(DependencyDescriptor.java:251) ~[spring-beans-5.0.8.RELEASE.jar:5.0.8.RELEASE]
	at org.springframework.beans.factory.support.DefaultListableBeanFactory.addCandidateEntry(DefaultListableBeanFactory.java:1322) ~[spring-beans-5.0.8.RELEASE.jar:5.0.8.RELEASE]
	at org.springframework.beans.factory.support.DefaultListableBeanFactory.findAutowireCandidates(DefaultListableBeanFactory.java:1288) ~[spring-beans-5.0.8.RELEASE.jar:5.0.8.RELEASE]
	at org.springframework.beans.factory.support.DefaultListableBeanFactory.resolveMultipleBeans(DefaultListableBeanFactory.java:1215) ~[spring-beans-5.0.8.RELEASE.jar:5.0.8.RELEASE]
	at org.springframework.beans.factory.support.DefaultListableBeanFactory.doResolveDependency(DefaultListableBeanFactory.java:1093) ~[spring-beans-5.0.8.RELEASE.jar:5.0.8.RELEASE]
	at org.springframework.beans.factory.support.DefaultListableBeanFactory$DependencyObjectProvider.getIfAvailable(DefaultListableBeanFactory.java:1706) ~[spring-beans-5.0.8.RELEASE.jar:5.0.8.RELEASE]
	at org.springframework.boot.actuate.autoconfigure.jdbc.DataSourceHealthIndicatorAutoConfiguration.<init>(DataSourceHealthIndicatorAutoConfiguration.java:77) ~[spring-boot-actuator-autoconfigure-2.0.3.RELEASE.jar:2.0.3.RELEASE]
	at org.springframework.boot.actuate.autoconfigure.jdbc.DataSourceHealthIndicatorAutoConfiguration$$EnhancerBySpringCGLIB$$d344081c.<init>(<generated>) ~[spring-boot-actuator-autoconfigure-2.0.3.RELEASE.jar:2.0.3.RELEASE]
	at sun.reflect.NativeConstructorAccessorImpl.newInstance0(Native Method) ~[?:1.8.0_292]
	at sun.reflect.NativeConstructorAccessorImpl.newInstance(NativeConstructorAccessorImpl.java:62) ~[?:1.8.0_292]
	at sun.reflect.DelegatingConstructorAccessorImpl.newInstance(DelegatingConstructorAccessorImpl.java:45) ~[?:1.8.0_292]
	at java.lang.reflect.Constructor.newInstance(Constructor.java:423) ~[?:1.8.0_292]
	at org.springframework.beans.BeanUtils.instantiateClass(BeanUtils.java:170) ~[spring-beans-5.0.8.RELEASE.jar:5.0.8.RELEASE]
	at org.springframework.beans.factory.support.SimpleInstantiationStrategy.instantiate(SimpleInstantiationStrategy.java:117) ~[spring-beans-5.0.8.RELEASE.jar:5.0.8.RELEASE]
	at org.springframework.beans.factory.support.ConstructorResolver.autowireConstructor(ConstructorResolver.java:275) ~[spring-beans-5.0.8.RELEASE.jar:5.0.8.RELEASE]
	at org.springframework.beans.factory.support.AbstractAutowireCapableBeanFactory.autowireConstructor(AbstractAutowireCapableBeanFactory.java:1267) ~[spring-beans-5.0.8.RELEASE.jar:5.0.8.RELEASE]
	at org.springframework.beans.factory.support.AbstractAutowireCapableBeanFactory.createBeanInstance(AbstractAutowireCapableBeanFactory.java:1124) ~[spring-beans-5.0.8.RELEASE.jar:5.0.8.RELEASE]
	at org.springframework.beans.factory.support.AbstractAutowireCapableBeanFactory.doCreateBean(AbstractAutowireCapableBeanFactory.java:535) ~[spring-beans-5.0.8.RELEASE.jar:5.0.8.RELEASE]
	at org.springframework.beans.factory.support.AbstractAutowireCapableBeanFactory.createBean(AbstractAutowireCapableBeanFactory.java:495) ~[spring-beans-5.0.8.RELEASE.jar:5.0.8.RELEASE]
	at org.springframework.beans.factory.support.AbstractBeanFactory.lambda$doGetBean$0(AbstractBeanFactory.java:317) ~[spring-beans-5.0.8.RELEASE.jar:5.0.8.RELEASE]
	at org.springframework.beans.factory.support.DefaultSingletonBeanRegistry.getSingleton(DefaultSingletonBeanRegistry.java:222) ~[spring-beans-5.0.8.RELEASE.jar:5.0.8.RELEASE]
	at org.springframework.beans.factory.support.AbstractBeanFactory.doGetBean(AbstractBeanFactory.java:315) ~[spring-beans-5.0.8.RELEASE.jar:5.0.8.RELEASE]
	at org.springframework.beans.factory.support.AbstractBeanFactory.getBean(AbstractBeanFactory.java:199) ~[spring-beans-5.0.8.RELEASE.jar:5.0.8.RELEASE]
	at org.springframework.beans.factory.support.ConstructorResolver.instantiateUsingFactoryMethod(ConstructorResolver.java:372) ~[spring-beans-5.0.8.RELEASE.jar:5.0.8.RELEASE]
	at org.springframework.beans.factory.support.AbstractAutowireCapableBeanFactory.instantiateUsingFactoryMethod(AbstractAutowireCapableBeanFactory.java:1247) ~[spring-beans-5.0.8.RELEASE.jar:5.0.8.RELEASE]
	at org.springframework.beans.factory.support.AbstractAutowireCapableBeanFactory.createBeanInstance(AbstractAutowireCapableBeanFactory.java:1096) ~[spring-beans-5.0.8.RELEASE.jar:5.0.8.RELEASE]
	at org.springframework.beans.factory.support.AbstractAutowireCapableBeanFactory.doCreateBean(AbstractAutowireCapableBeanFactory.java:535) ~[spring-beans-5.0.8.RELEASE.jar:5.0.8.RELEASE]
	at org.springframework.beans.factory.support.AbstractAutowireCapableBeanFactory.createBean(AbstractAutowireCapableBeanFactory.java:495) ~[spring-beans-5.0.8.RELEASE.jar:5.0.8.RELEASE]
	at org.springframework.beans.factory.support.AbstractBeanFactory.lambda$doGetBean$0(AbstractBeanFactory.java:317) ~[spring-beans-5.0.8.RELEASE.jar:5.0.8.RELEASE]
	at org.springframework.beans.factory.support.DefaultSingletonBeanRegistry.getSingleton(DefaultSingletonBeanRegistry.java:222) ~[spring-beans-5.0.8.RELEASE.jar:5.0.8.RELEASE]
	at org.springframework.beans.factory.support.AbstractBeanFactory.doGetBean(AbstractBeanFactory.java:315) ~[spring-beans-5.0.8.RELEASE.jar:5.0.8.RELEASE]
	at org.springframework.beans.factory.support.AbstractBeanFactory.getBean(AbstractBeanFactory.java:199) ~[spring-beans-5.0.8.RELEASE.jar:5.0.8.RELEASE]
	at org.springframework.beans.factory.support.DefaultListableBeanFactory.getBeansOfType(DefaultListableBeanFactory.java:514) ~[spring-beans-5.0.8.RELEASE.jar:5.0.8.RELEASE]
	at org.springframework.beans.factory.support.DefaultListableBeanFactory.getBeansOfType(DefaultListableBeanFactory.java:502) ~[spring-beans-5.0.8.RELEASE.jar:5.0.8.RELEASE]
	at org.springframework.context.support.AbstractApplicationContext.getBeansOfType(AbstractApplicationContext.java:1198) ~[spring-context-5.0.7.RELEASE.jar:5.0.7.RELEASE]
	at org.springframework.boot.actuate.autoconfigure.health.HealthIndicatorBeansComposite.get(HealthIndicatorBeansComposite.java:46) ~[spring-boot-actuator-autoconfigure-2.0.3.RELEASE.jar:2.0.3.RELEASE]
	at org.springframework.boot.actuate.autoconfigure.health.HealthEndpointConfiguration.healthEndpoint(HealthEndpointConfiguration.java:38) ~[spring-boot-actuator-autoconfigure-2.0.3.RELEASE.jar:2.0.3.RELEASE]
	at org.springframework.boot.actuate.autoconfigure.health.HealthEndpointConfiguration$$EnhancerBySpringCGLIB$$81006c79.CGLIB$healthEndpoint$0(<generated>) ~[spring-boot-actuator-autoconfigure-2.0.3.RELEASE.jar:2.0.3.RELEASE]
	at org.springframework.boot.actuate.autoconfigure.health.HealthEndpointConfiguration$$EnhancerBySpringCGLIB$$81006c79$$FastClassBySpringCGLIB$$93ffc003.invoke(<generated>) ~[spring-boot-actuator-autoconfigure-2.0.3.RELEASE.jar:2.0.3.RELEASE]
	at org.springframework.cglib.proxy.MethodProxy.invokeSuper(MethodProxy.java:228) ~[spring-core-5.0.8.RELEASE.jar:5.0.8.RELEASE]
	at org.springframework.context.annotation.ConfigurationClassEnhancer$BeanMethodInterceptor.intercept(ConfigurationClassEnhancer.java:361) ~[spring-context-5.0.7.RELEASE.jar:5.0.7.RELEASE]
	at org.springframework.boot.actuate.autoconfigure.health.HealthEndpointConfiguration$$EnhancerBySpringCGLIB$$81006c79.healthEndpoint(<generated>) ~[spring-boot-actuator-autoconfigure-2.0.3.RELEASE.jar:2.0.3.RELEASE]
	at sun.reflect.NativeMethodAccessorImpl.invoke0(Native Method) ~[?:1.8.0_292]
	at sun.reflect.NativeMethodAccessorImpl.invoke(NativeMethodAccessorImpl.java:62) ~[?:1.8.0_292]
	at sun.reflect.DelegatingMethodAccessorImpl.invoke(DelegatingMethodAccessorImpl.java:43) ~[?:1.8.0_292]
	at java.lang.reflect.Method.invoke(Method.java:498) ~[?:1.8.0_292]
	at org.springframework.beans.factory.support.SimpleInstantiationStrategy.instantiate(SimpleInstantiationStrategy.java:154) ~[spring-beans-5.0.8.RELEASE.jar:5.0.8.RELEASE]
	at org.springframework.beans.factory.support.ConstructorResolver.instantiateUsingFactoryMethod(ConstructorResolver.java:582) ~[spring-beans-5.0.8.RELEASE.jar:5.0.8.RELEASE]
	at org.springframework.beans.factory.support.AbstractAutowireCapableBeanFactory.instantiateUsingFactoryMethod(AbstractAutowireCapableBeanFactory.java:1247) ~[spring-beans-5.0.8.RELEASE.jar:5.0.8.RELEASE]
	at org.springframework.beans.factory.support.AbstractAutowireCapableBeanFactory.createBeanInstance(AbstractAutowireCapableBeanFactory.java:1096) ~[spring-beans-5.0.8.RELEASE.jar:5.0.8.RELEASE]
	at org.springframework.beans.factory.support.AbstractAutowireCapableBeanFactory.doCreateBean(AbstractAutowireCapableBeanFactory.java:535) ~[spring-beans-5.0.8.RELEASE.jar:5.0.8.RELEASE]
	at org.springframework.beans.factory.support.AbstractAutowireCapableBeanFactory.createBean(AbstractAutowireCapableBeanFactory.java:495) ~[spring-beans-5.0.8.RELEASE.jar:5.0.8.RELEASE]
	at org.springframework.beans.factory.support.AbstractBeanFactory.lambda$doGetBean$0(AbstractBeanFactory.java:317) ~[spring-beans-5.0.8.RELEASE.jar:5.0.8.RELEASE]
	at org.springframework.beans.factory.support.DefaultSingletonBeanRegistry.getSingleton(DefaultSingletonBeanRegistry.java:222) ~[spring-beans-5.0.8.RELEASE.jar:5.0.8.RELEASE]
	at org.springframework.beans.factory.support.AbstractBeanFactory.doGetBean(AbstractBeanFactory.java:315) ~[spring-beans-5.0.8.RELEASE.jar:5.0.8.RELEASE]
	at org.springframework.beans.factory.support.AbstractBeanFactory.getBean(AbstractBeanFactory.java:199) ~[spring-beans-5.0.8.RELEASE.jar:5.0.8.RELEASE]
	at org.springframework.context.support.AbstractApplicationContext.getBean(AbstractApplicationContext.java:1089) ~[spring-context-5.0.7.RELEASE.jar:5.0.7.RELEASE]
	at org.springframework.boot.actuate.endpoint.annotation.EndpointDiscoverer.createEndpointBean(EndpointDiscoverer.java:143) ~[spring-boot-actuator-2.0.3.RELEASE.jar:2.0.3.RELEASE]
	at org.springframework.boot.actuate.endpoint.annotation.EndpointDiscoverer.createEndpointBeans(EndpointDiscoverer.java:132) ~[spring-boot-actuator-2.0.3.RELEASE.jar:2.0.3.RELEASE]
	at org.springframework.boot.actuate.endpoint.annotation.EndpointDiscoverer.discoverEndpoints(EndpointDiscoverer.java:122) ~[spring-boot-actuator-2.0.3.RELEASE.jar:2.0.3.RELEASE]
	at org.springframework.boot.actuate.endpoint.annotation.EndpointDiscoverer.getEndpoints(EndpointDiscoverer.java:116) ~[spring-boot-actuator-2.0.3.RELEASE.jar:2.0.3.RELEASE]
	at org.springframework.boot.actuate.autoconfigure.endpoint.web.ServletEndpointManagementContextConfiguration$WebMvcServletEndpointManagementContextConfiguration.servletEndpointRegistrar(ServletEndpointManagementContextConfiguration.java:78) ~[spring-boot-actuator-autoconfigure-2.0.3.RELEASE.jar:2.0.3.RELEASE]
	at org.springframework.boot.actuate.autoconfigure.endpoint.web.ServletEndpointManagementContextConfiguration$WebMvcServletEndpointManagementContextConfiguration$$EnhancerBySpringCGLIB$$1a940e71.CGLIB$servletEndpointRegistrar$0(<generated>) ~[spring-boot-actuator-autoconfigure-2.0.3.RELEASE.jar:2.0.3.RELEASE]
	at org.springframework.boot.actuate.autoconfigure.endpoint.web.ServletEndpointManagementContextConfiguration$WebMvcServletEndpointManagementContextConfiguration$$EnhancerBySpringCGLIB$$1a940e71$$FastClassBySpringCGLIB$$4ba0cefd.invoke(<generated>) ~[spring-boot-actuator-autoconfigure-2.0.3.RELEASE.jar:2.0.3.RELEASE]
	at org.springframework.cglib.proxy.MethodProxy.invokeSuper(MethodProxy.java:228) ~[spring-core-5.0.8.RELEASE.jar:5.0.8.RELEASE]
	at org.springframework.context.annotation.ConfigurationClassEnhancer$BeanMethodInterceptor.intercept(ConfigurationClassEnhancer.java:361) ~[spring-context-5.0.7.RELEASE.jar:5.0.7.RELEASE]
	at org.springframework.boot.actuate.autoconfigure.endpoint.web.ServletEndpointManagementContextConfiguration$WebMvcServletEndpointManagementContextConfiguration$$EnhancerBySpringCGLIB$$1a940e71.servletEndpointRegistrar(<generated>) ~[spring-boot-actuator-autoconfigure-2.0.3.RELEASE.jar:2.0.3.RELEASE]
	at sun.reflect.NativeMethodAccessorImpl.invoke0(Native Method) ~[?:1.8.0_292]
	at sun.reflect.NativeMethodAccessorImpl.invoke(NativeMethodAccessorImpl.java:62) ~[?:1.8.0_292]
	at sun.reflect.DelegatingMethodAccessorImpl.invoke(DelegatingMethodAccessorImpl.java:43) ~[?:1.8.0_292]
	at java.lang.reflect.Method.invoke(Method.java:498) ~[?:1.8.0_292]
	at org.springframework.beans.factory.support.SimpleInstantiationStrategy.instantiate(SimpleInstantiationStrategy.java:154) ~[spring-beans-5.0.8.RELEASE.jar:5.0.8.RELEASE]
	at org.springframework.beans.factory.support.ConstructorResolver.instantiateUsingFactoryMethod(ConstructorResolver.java:582) ~[spring-beans-5.0.8.RELEASE.jar:5.0.8.RELEASE]
	at org.springframework.beans.factory.support.AbstractAutowireCapableBeanFactory.instantiateUsingFactoryMethod(AbstractAutowireCapableBeanFactory.java:1247) ~[spring-beans-5.0.8.RELEASE.jar:5.0.8.RELEASE]
	at org.springframework.beans.factory.support.AbstractAutowireCapableBeanFactory.createBeanInstance(AbstractAutowireCapableBeanFactory.java:1096) ~[spring-beans-5.0.8.RELEASE.jar:5.0.8.RELEASE]
	at org.springframework.beans.factory.support.AbstractAutowireCapableBeanFactory.doCreateBean(AbstractAutowireCapableBeanFactory.java:535) ~[spring-beans-5.0.8.RELEASE.jar:5.0.8.RELEASE]
	at org.springframework.beans.factory.support.AbstractAutowireCapableBeanFactory.createBean(AbstractAutowireCapableBeanFactory.java:495) ~[spring-beans-5.0.8.RELEASE.jar:5.0.8.RELEASE]
	at org.springframework.beans.factory.support.AbstractBeanFactory.lambda$doGetBean$0(AbstractBeanFactory.java:317) ~[spring-beans-5.0.8.RELEASE.jar:5.0.8.RELEASE]
	at org.springframework.beans.factory.support.DefaultSingletonBeanRegistry.getSingleton(DefaultSingletonBeanRegistry.java:222) ~[spring-beans-5.0.8.RELEASE.jar:5.0.8.RELEASE]
	at org.springframework.beans.factory.support.AbstractBeanFactory.doGetBean(AbstractBeanFactory.java:315) ~[spring-beans-5.0.8.RELEASE.jar:5.0.8.RELEASE]
	at org.springframework.beans.factory.support.AbstractBeanFactory.getBean(AbstractBeanFactory.java:204) ~[spring-beans-5.0.8.RELEASE.jar:5.0.8.RELEASE]
	at org.springframework.boot.web.servlet.ServletContextInitializerBeans.getOrderedBeansOfType(ServletContextInitializerBeans.java:226) ~[spring-boot-2.0.3.RELEASE.jar:2.0.3.RELEASE]
	at org.springframework.boot.web.servlet.ServletContextInitializerBeans.getOrderedBeansOfType(ServletContextInitializerBeans.java:214) ~[spring-boot-2.0.3.RELEASE.jar:2.0.3.RELEASE]
	at org.springframework.boot.web.servlet.ServletContextInitializerBeans.addServletContextInitializerBeans(ServletContextInitializerBeans.java:91) ~[spring-boot-2.0.3.RELEASE.jar:2.0.3.RELEASE]
	at org.springframework.boot.web.servlet.ServletContextInitializerBeans.<init>(ServletContextInitializerBeans.java:80) ~[spring-boot-2.0.3.RELEASE.jar:2.0.3.RELEASE]
	at org.springframework.boot.web.servlet.context.ServletWebServerApplicationContext.getServletContextInitializerBeans(ServletWebServerApplicationContext.java:250) ~[spring-boot-2.0.3.RELEASE.jar:2.0.3.RELEASE]
	at org.springframework.boot.web.servlet.context.ServletWebServerApplicationContext.selfInitialize(ServletWebServerApplicationContext.java:237) ~[spring-boot-2.0.3.RELEASE.jar:2.0.3.RELEASE]
	at org.springframework.boot.web.embedded.jetty.ServletContextInitializerConfiguration$Initializer.callInitializers(ServletContextInitializerConfiguration.java:84) [spring-boot-2.0.3.RELEASE.jar:2.0.3.RELEASE]
	at org.springframework.boot.web.embedded.jetty.ServletContextInitializerConfiguration$Initializer.doStart(ServletContextInitializerConfiguration.java:73) [spring-boot-2.0.3.RELEASE.jar:2.0.3.RELEASE]
	at org.eclipse.jetty.util.component.AbstractLifeCycle.start(AbstractLifeCycle.java:68) [jetty-util-9.4.11.v20180605.jar:9.4.11.v20180605]
	at org.eclipse.jetty.util.component.ContainerLifeCycle.start(ContainerLifeCycle.java:138) [jetty-util-9.4.11.v20180605.jar:9.4.11.v20180605]
	at org.eclipse.jetty.util.component.ContainerLifeCycle.doStart(ContainerLifeCycle.java:108) [jetty-util-9.4.11.v20180605.jar:9.4.11.v20180605]
	at org.eclipse.jetty.server.handler.AbstractHandler.doStart(AbstractHandler.java:113) [jetty-server-9.4.11.v20180605.jar:9.4.11.v20180605]
	at org.eclipse.jetty.server.handler.ScopedHandler.doStart(ScopedHandler.java:123) [jetty-server-9.4.11.v20180605.jar:9.4.11.v20180605]
	at org.eclipse.jetty.server.handler.ContextHandler.startContext(ContextHandler.java:909) [jetty-server-9.4.11.v20180605.jar:9.4.11.v20180605]
	at org.eclipse.jetty.servlet.ServletContextHandler.startContext(ServletContextHandler.java:370) [jetty-servlet-9.4.11.v20180605.jar:9.4.11.v20180605]
	at org.eclipse.jetty.webapp.WebAppContext.startWebapp(WebAppContext.java:1497) [jetty-webapp-9.4.11.v20180605.jar:9.4.11.v20180605]
	at org.eclipse.jetty.webapp.WebAppContext.startContext(WebAppContext.java:1459) [jetty-webapp-9.4.11.v20180605.jar:9.4.11.v20180605]
	at org.eclipse.jetty.server.handler.ContextHandler.doStart(ContextHandler.java:848) [jetty-server-9.4.11.v20180605.jar:9.4.11.v20180605]
	at org.eclipse.jetty.servlet.ServletContextHandler.doStart(ServletContextHandler.java:287) [jetty-servlet-9.4.11.v20180605.jar:9.4.11.v20180605]
	at org.eclipse.jetty.webapp.WebAppContext.doStart(WebAppContext.java:545) [jetty-webapp-9.4.11.v20180605.jar:9.4.11.v20180605]
	at org.eclipse.jetty.util.component.AbstractLifeCycle.start(AbstractLifeCycle.java:68) [jetty-util-9.4.11.v20180605.jar:9.4.11.v20180605]
	at org.eclipse.jetty.util.component.ContainerLifeCycle.start(ContainerLifeCycle.java:138) [jetty-util-9.4.11.v20180605.jar:9.4.11.v20180605]
	at org.eclipse.jetty.server.Server.start(Server.java:419) [jetty-server-9.4.11.v20180605.jar:9.4.11.v20180605]
	at org.eclipse.jetty.util.component.ContainerLifeCycle.doStart(ContainerLifeCycle.java:108) [jetty-util-9.4.11.v20180605.jar:9.4.11.v20180605]
	at org.eclipse.jetty.server.handler.AbstractHandler.doStart(AbstractHandler.java:113) [jetty-server-9.4.11.v20180605.jar:9.4.11.v20180605]
	at org.eclipse.jetty.server.Server.doStart(Server.java:386) [jetty-server-9.4.11.v20180605.jar:9.4.11.v20180605]
	at org.eclipse.jetty.util.component.AbstractLifeCycle.start(AbstractLifeCycle.java:68) [jetty-util-9.4.11.v20180605.jar:9.4.11.v20180605]
	at org.springframework.boot.web.embedded.jetty.JettyWebServer.initialize(JettyWebServer.java:107) [spring-boot-2.0.3.RELEASE.jar:2.0.3.RELEASE]
	at org.springframework.boot.web.embedded.jetty.JettyWebServer.<init>(JettyWebServer.java:85) [spring-boot-2.0.3.RELEASE.jar:2.0.3.RELEASE]
	at org.springframework.boot.web.embedded.jetty.JettyServletWebServerFactory.getJettyWebServer(JettyServletWebServerFactory.java:409) [spring-boot-2.0.3.RELEASE.jar:2.0.3.RELEASE]
	at org.springframework.boot.web.embedded.jetty.JettyServletWebServerFactory.getWebServer(JettyServletWebServerFactory.java:153) [spring-boot-2.0.3.RELEASE.jar:2.0.3.RELEASE]
	at org.springframework.boot.web.servlet.context.ServletWebServerApplicationContext.createWebServer(ServletWebServerApplicationContext.java:179) [spring-boot-2.0.3.RELEASE.jar:2.0.3.RELEASE]
	at org.springframework.boot.web.servlet.context.ServletWebServerApplicationContext.onRefresh(ServletWebServerApplicationContext.java:152) [spring-boot-2.0.3.RELEASE.jar:2.0.3.RELEASE]
	at org.springframework.context.support.AbstractApplicationContext.refresh(AbstractApplicationContext.java:544) [spring-context-5.0.7.RELEASE.jar:5.0.7.RELEASE]
	at org.springframework.boot.web.servlet.context.ServletWebServerApplicationContext.refresh(ServletWebServerApplicationContext.java:140) [spring-boot-2.0.3.RELEASE.jar:2.0.3.RELEASE]
	at org.springframework.boot.SpringApplication.refresh(SpringApplication.java:759) [spring-boot-2.0.3.RELEASE.jar:2.0.3.RELEASE]
	at org.springframework.boot.SpringApplication.refreshContext(SpringApplication.java:395) [spring-boot-2.0.3.RELEASE.jar:2.0.3.RELEASE]
	at org.springframework.boot.SpringApplication.run(SpringApplication.java:327) [spring-boot-2.0.3.RELEASE.jar:2.0.3.RELEASE]
	at com.webank.wedatasphere.linkis.DataWorkCloudApplication.main(DataWorkCloudApplication.java:105) [linkis-module-0.9.3.jar:?]
Caused by: javax.net.ssl.SSLHandshakeException: No appropriate protocol (protocol is disabled or cipher suites are inappropriate)
	at sun.security.ssl.HandshakeContext.<init>(HandshakeContext.java:171) ~[?:1.8.0_292]
	at sun.security.ssl.ClientHandshakeContext.<init>(ClientHandshakeContext.java:98) ~[?:1.8.0_292]
	at sun.security.ssl.TransportContext.kickstart(TransportContext.java:220) ~[?:1.8.0_292]
	at sun.security.ssl.SSLSocketImpl.startHandshake(SSLSocketImpl.java:428) ~[?:1.8.0_292]
	at com.mysql.jdbc.ExportControlled.transformSocketToSSLSocket(ExportControlled.java:188) ~[mysql-connector-java-5.1.44.jar:5.1.44]
	... 161 more

# 前端可视化链接报错

2021-07-06 15:20:21.212 INFO  [main] org.springframework.cloud.config.client.ConfigServicePropertySourceLocator 205 getRemoteEnvironment - Fetching config from server at : http://localhost:8888
2021-07-06 15:20:21.356 INFO  [main] org.springframework.cloud.config.client.ConfigServicePropertySourceLocator 227 getRemoteEnvironment - Connect Timeout Exception on Url - http://localhost:8888. Will be trying the next url if available
2021-07-06 15:20:21.357 WARN  [main] org.springframework.cloud.config.client.ConfigServicePropertySourceLocator 140 locate - Could not locate PropertySource: I/O error on GET request for "http://localhost:8888/visualis/default": Connection refused (Connection refused); nested exception is java.net.ConnectException: Connection refused (Connection refused)
2021-07-06 15:20:21.361 INFO  [main] com.webank.wedatasphere.linkis.DataWorkCloudApplication 659 logStartupProfileInfo - No active profile set, falling back to default profiles: default
2021-07-06 15:20:21.391 INFO  [main] com.webank.wedatasphere.linkis.DataWorkCloudApplication 84 onApplicationEvent - add config from config server...
2021-07-06 15:20:21.391 INFO  [main] com.webank.wedatasphere.linkis.DataWorkCloudApplication 89 onApplicationEvent - initialize DataWorkCloud spring application...
```

# 解决 0.0.0.0:8888 问题
sudo  yum -y install policycoreutils-python
sudo semanage port -a -t http_port_t -p tcp $dss_web_port

https://blog.csdn.net/fu18838928050/article/details/107901895

# web端生成的dss的nginx的配置


```sh
server {
    listen       8088;# 访问端口
    server_name  localhost;
    #charset koi8-r;
    #access_log  /var/log/nginx/host.access.log  main;
    location /dss/visualis {
        root   /data/apps/dss_linkis/web; # 静态文件目录
        autoindex on;
    }
    location / {
        root   /data/apps/dss_linkis/web/dist; # 静态文件目录
        index  index.html index.html;
    }
    location /ws {
        proxy_pass http://localhost:9001;#后端Linkis的地址
        proxy_http_version 1.1;
        proxy_set_header Upgrade $http_upgrade;
        proxy_set_header Connection upgrade;
    }

    location /api {
        proxy_pass http://localhost:9001; #后端Linkis的地址
        proxy_set_header Host $host;
        proxy_set_header X-Real-IP $remote_addr;
        proxy_set_header x_real_ipP $remote_addr;
        proxy_set_header remote_addr $remote_addr;
        proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;
        proxy_http_version 1.1;
        proxy_connect_timeout 4s;
        proxy_read_timeout 600s;
        proxy_send_timeout 12s;
        proxy_set_header Upgrade $http_upgrade;
        proxy_set_header Connection upgrade;
    }

        #error_page  404              /404.html;
        # redirect server error pages to the static page /50x.html
        #
        error_page   500 502 503 504  /50x.html;
        location = /50x.html {
        root   /usr/share/nginx/html;
    }
}
```

# Hive元数据链接问题

```sh
2021-07-06 17:45:02.197 INFO  [AsyncResolver-bootstrap-executor-0] com.netflix.discovery.shared.resolver.aws.ConfigClusterResolver 43 getClusterEndpoints - Resolving eureka endpoints via configuration
2021-07-06 17:45:38,750 INFO  (qtp1719289471-22) INFO RestfulApplication - register com.webank.wedatasphere.linkis.rpc.RPCReceiveRestful
2021-07-06 17:45:38,752 INFO  (qtp1719289471-22) INFO RestfulApplication - packages com.webank.wedatasphere.linkis.metadata.restful.api
2021-07-06 17:45:39,205 ERROR (qtp1719289471-22) ERROR DataSourceRestfulApi - Failed to get allDbs and tables(获取数据全部的库表信息失败)：
org.apache.ibatis.binding.BindingException: Invalid bound statement (not found): com.webank.wedatasphere.linkis.metadata.hive.dao.HiveMetaDao.getDbsByUser
	at org.apache.ibatis.binding.MapperMethod$SqlCommand.<init>(MapperMethod.java:227)
	at org.apache.ibatis.binding.MapperMethod.<init>(MapperMethod.java:49)
	at org.apache.ibatis.binding.MapperProxy.cachedMapperMethod(MapperProxy.java:65)
	at org.apache.ibatis.binding.MapperProxy.invoke(MapperProxy.java:58)
	at com.sun.proxy.$Proxy161.getDbsByUser(Unknown Source)
	at com.webank.wedatasphere.linkis.metadata.service.impl.DataSourceServiceImpl.getDbsWithTables(DataSourceServiceImpl.java:72)
	at com.webank.wedatasphere.linkis.metadata.restful.api.DataSourceRestfulApi.queryDbsWithTables(DataSourceRestfulApi.java:93)
	at com.webank.wedatasphere.linkis.metadata.restful.api.DataSourceRestfulApi$$FastClassBySpringCGLIB$$d7cb9416.invoke(<generated>)
	at org.springframework.cglib.proxy.MethodProxy.invoke(MethodProxy.java:204)
	at org.springframework.aop.framework.CglibAopProxy$CglibMethodInvocation.invokeJoinpoint(CglibAopProxy.java:746)
	at org.springframework.aop.framework.ReflectiveMethodInvocation.proceed(ReflectiveMethodInvocation.java:163)
	at org.springframework.aop.aspectj.MethodInvocationProceedingJoinPoint.proceed(MethodInvocationProceedingJoinPoint.java:88)
	at com.webank.wedatasphere.linkis.server.restful.RestfulCatchAOP$$anonfun$1.apply(RestfulCatchAOP.scala:48)
	at com.webank.wedatasphere.linkis.server.restful.RestfulCatchAOP$$anonfun$1.apply(RestfulCatchAOP.scala:48)
	at com.webank.wedatasphere.linkis.common.utils.Utils$.tryCatch(Utils.scala:48)
	at com.webank.wedatasphere.linkis.server.package$.catchMsg(package.scala:57)
	at com.webank.wedatasphere.linkis.server.package$.catchIt(package.scala:89)
	at com.webank.wedatasphere.linkis.server.restful.RestfulCatchAOP.dealResponseRestful(RestfulCatchAOP.scala:47)
	at sun.reflect.NativeMethodAccessorImpl.invoke0(Native Method)
	at sun.reflect.NativeMethodAccessorImpl.invoke(NativeMethodAccessorImpl.java:62)
	at sun.reflect.DelegatingMethodAccessorImpl.invoke(DelegatingMethodAccessorImpl.java:43)
	at java.lang.reflect.Method.invoke(Method.java:498)
	at org.springframework.aop.aspectj.AbstractAspectJAdvice.invokeAdviceMethodWithGivenArgs(AbstractAspectJAdvice.java:644)
	at org.springframework.aop.aspectj.AbstractAspectJAdvice.invokeAdviceMethod(AbstractAspectJAdvice.java:633)
	at org.springframework.aop.aspectj.AspectJAroundAdvice.invoke(AspectJAroundAdvice.java:70)
	at org.springframework.aop.framework.ReflectiveMethodInvocation.proceed(ReflectiveMethodInvocation.java:174)
	at org.springframework.aop.interceptor.ExposeInvocationInterceptor.invoke(ExposeInvocationInterceptor.java:92)
	at org.springframework.aop.framework.ReflectiveMethodInvocation.proceed(ReflectiveMethodInvocation.java:185)
	at org.springframework.aop.framework.CglibAopProxy$DynamicAdvisedInterceptor.intercept(CglibAopProxy.java:688)
	at com.webank.wedatasphere.linkis.metadata.restful.api.DataSourceRestfulApi$$EnhancerBySpringCGLIB$$c7201aaf.queryDbsWithTables(<generated>)
	at sun.reflect.NativeMethodAccessorImpl.invoke0(Native Method)
	at sun.reflect.NativeMethodAccessorImpl.invoke(NativeMethodAccessorImpl.java:62)
	at sun.reflect.DelegatingMethodAccessorImpl.invoke(DelegatingMethodAccessorImpl.java:43)
	at java.lang.reflect.Method.invoke(Method.java:498)
	at org.glassfish.jersey.server.model.internal.ResourceMethodInvocationHandlerFactory$1.invoke(ResourceMethodInvocationHandlerFactory.java:81)
	at org.glassfish.jersey.server.model.internal.AbstractJavaResourceMethodDispatcher$1.run(AbstractJavaResourceMethodDispatcher.java:144)
	at org.glassfish.jersey.server.model.internal.AbstractJavaResourceMethodDispatcher.invoke(AbstractJavaResourceMethodDispatcher.java:161)
	at org.glassfish.jersey.server.model.internal.JavaResourceMethodDispatcherProvider$ResponseOutInvoker.doDispatch(JavaResourceMethodDispatcherProvider.java:160)
	at org.glassfish.jersey.server.model.internal.AbstractJavaResourceMethodDispatcher.dispatch(AbstractJavaResourceMethodDispatcher.java:99)
	at org.glassfish.jersey.server.model.ResourceMethodInvoker.invoke(ResourceMethodInvoker.java:389)
	at org.glassfish.jersey.server.model.ResourceMethodInvoker.apply(ResourceMethodInvoker.java:347)
	at org.glassfish.jersey.server.model.ResourceMethodInvoker.apply(ResourceMethodInvoker.java:102)
	at org.glassfish.jersey.server.ServerRuntime$2.run(ServerRuntime.java:309)
	at org.glassfish.jersey.internal.Errors$1.call(Errors.java:271)
	at org.glassfish.jersey.internal.Errors$1.call(Errors.java:267)
	at org.glassfish.jersey.internal.Errors.process(Errors.java:315)
	at org.glassfish.jersey.internal.Errors.process(Errors.java:297)
	at org.glassfish.jersey.internal.Errors.process(Errors.java:267)
	at org.glassfish.jersey.process.internal.RequestScope.runInScope(RequestScope.java:317)
	at org.glassfish.jersey.server.ServerRuntime.process(ServerRuntime.java:292)
	at org.glassfish.jersey.server.ApplicationHandler.handle(ApplicationHandler.java:1139)
	at org.glassfish.jersey.servlet.WebComponent.service(WebComponent.java:460)
	at org.glassfish.jersey.servlet.ServletContainer.service(ServletContainer.java:386)
	at org.glassfish.jersey.servlet.ServletContainer.service(ServletContainer.java:334)
	at org.glassfish.jersey.servlet.ServletContainer.service(ServletContainer.java:221)
	at org.eclipse.jetty.servlet.ServletHolder.handle(ServletHolder.java:865)
	at org.eclipse.jetty.servlet.ServletHandler$CachedChain.doFilter(ServletHandler.java:1655)
	at org.eclipse.jetty.websocket.server.WebSocketUpgradeFilter.doFilter(WebSocketUpgradeFilter.java:215)
	at org.eclipse.jetty.servlet.ServletHandler$CachedChain.doFilter(ServletHandler.java:1642)
	at com.webank.wedatasphere.linkis.server.security.SecurityFilter.doFilter(SecurityFilter.scala:101)
	at org.eclipse.jetty.servlet.ServletHandler$CachedChain.doFilter(ServletHandler.java:1642)
	at org.springframework.web.filter.CharacterEncodingFilter.doFilterInternal(CharacterEncodingFilter.java:200)
	at org.springframework.web.filter.OncePerRequestFilter.doFilter(OncePerRequestFilter.java:107)
	at org.eclipse.jetty.servlet.ServletHandler$CachedChain.doFilter(ServletHandler.java:1642)
	at org.springframework.boot.actuate.metrics.web.servlet.WebMvcMetricsFilter.filterAndRecordMetrics(WebMvcMetricsFilter.java:158)
	at org.springframework.boot.actuate.metrics.web.servlet.WebMvcMetricsFilter.filterAndRecordMetrics(WebMvcMetricsFilter.java:126)
	at org.springframework.boot.actuate.metrics.web.servlet.WebMvcMetricsFilter.doFilterInternal(WebMvcMetricsFilter.java:111)
	at org.springframework.web.filter.OncePerRequestFilter.doFilter(OncePerRequestFilter.java:107)
	at org.eclipse.jetty.servlet.ServletHandler$CachedChain.doFilter(ServletHandler.java:1642)
	at org.springframework.boot.actuate.web.trace.servlet.HttpTraceFilter.doFilterInternal(HttpTraceFilter.java:90)
	at org.springframework.web.filter.OncePerRequestFilter.doFilter(OncePerRequestFilter.java:107)
	at org.eclipse.jetty.servlet.ServletHandler$CachedChain.doFilter(ServletHandler.java:1642)
	at org.springframework.web.filter.RequestContextFilter.doFilterInternal(RequestContextFilter.java:99)
	at org.springframework.web.filter.OncePerRequestFilter.doFilter(OncePerRequestFilter.java:107)
	at org.eclipse.jetty.servlet.ServletHandler$CachedChain.doFilter(ServletHandler.java:1642)
	at org.springframework.web.filter.HttpPutFormContentFilter.doFilterInternal(HttpPutFormContentFilter.java:109)
	at org.springframework.web.filter.OncePerRequestFilter.doFilter(OncePerRequestFilter.java:107)
	at org.eclipse.jetty.servlet.ServletHandler$CachedChain.doFilter(ServletHandler.java:1642)
	at org.springframework.web.filter.HiddenHttpMethodFilter.doFilterInternal(HiddenHttpMethodFilter.java:93)
	at org.springframework.web.filter.OncePerRequestFilter.doFilter(OncePerRequestFilter.java:107)
	at org.eclipse.jetty.servlet.ServletHandler$CachedChain.doFilter(ServletHandler.java:1642)
	at org.springframework.web.filter.CharacterEncodingFilter.doFilterInternal(CharacterEncodingFilter.java:200)
	at org.springframework.web.filter.OncePerRequestFilter.doFilter(OncePerRequestFilter.java:107)
	at org.eclipse.jetty.servlet.ServletHandler$CachedChain.doFilter(ServletHandler.java:1642)
	at org.eclipse.jetty.servlet.ServletHandler.doHandle(ServletHandler.java:533)
	at org.eclipse.jetty.server.handler.ScopedHandler.handle(ScopedHandler.java:146)
	at org.eclipse.jetty.security.SecurityHandler.handle(SecurityHandler.java:548)
	at org.eclipse.jetty.server.handler.HandlerWrapper.handle(HandlerWrapper.java:132)
	at org.eclipse.jetty.server.handler.ScopedHandler.nextHandle(ScopedHandler.java:257)
	at org.eclipse.jetty.server.session.SessionHandler.doHandle(SessionHandler.java:1595)
	at org.eclipse.jetty.server.handler.ScopedHandler.nextHandle(ScopedHandler.java:255)
	at org.eclipse.jetty.server.handler.ContextHandler.doHandle(ContextHandler.java:1317)
	at org.eclipse.jetty.server.handler.ScopedHandler.nextScope(ScopedHandler.java:203)
	at org.eclipse.jetty.servlet.ServletHandler.doScope(ServletHandler.java:473)
	at org.eclipse.jetty.server.session.SessionHandler.doScope(SessionHandler.java:1564)
	at org.eclipse.jetty.server.handler.ScopedHandler.nextScope(ScopedHandler.java:201)
	at org.eclipse.jetty.server.handler.ContextHandler.doScope(ContextHandler.java:1219)
	at org.eclipse.jetty.server.handler.ScopedHandler.handle(ScopedHandler.java:144)
	at org.eclipse.jetty.server.handler.HandlerWrapper.handle(HandlerWrapper.java:132)
	at org.eclipse.jetty.server.Server.handle(Server.java:531)
	at org.eclipse.jetty.server.HttpChannel.handle(HttpChannel.java:352)
	at org.eclipse.jetty.server.HttpConnection.onFillable(HttpConnection.java:260)
	at org.eclipse.jetty.io.AbstractConnection$ReadCallback.succeeded(AbstractConnection.java:281)
	at org.eclipse.jetty.io.FillInterest.fillable(FillInterest.java:102)
	at org.eclipse.jetty.io.ChannelEndPoint$2.run(ChannelEndPoint.java:118)
	at org.eclipse.jetty.util.thread.QueuedThreadPool.runJob(QueuedThreadPool.java:762)
	at org.eclipse.jetty.util.thread.QueuedThreadPool$2.run(QueuedThreadPool.java:680)
	at java.lang.Thread.run(Thread.java:748)
2021-07-06 17:45:47,986 ERROR (qtp1719289471-20) ERROR DataSourceRestfulApi - Failed to get allDbs and tables(获取数据全部的库表信息失败)：
org.apache.ibatis.binding.BindingException: Invalid bound statement (not found): com.webank.wedatasphere.linkis.metadata.hive.dao.HiveMetaDao.getDbsByUser
	at org.apache.ibatis.binding.MapperMethod$SqlCommand.<init>(MapperMethod.java:227)
	at org.apache.ibatis.binding.MapperMethod.<init>(MapperMethod.java:49)
	at org.apache.ibatis.binding.MapperProxy.cachedMapperMethod(MapperProxy.java:65)
	at org.apache.ibatis.binding.MapperProxy.invoke(MapperProxy.java:58)
	at com.sun.proxy.$Proxy161.getDbsByUser(Unknown Source)
	at com.webank.wedatasphere.linkis.metadata.service.impl.DataSourceServiceImpl.getDbsWithTables(DataSourceServiceImpl.java:72)
	at com.webank.wedatasphere.linkis.metadata.restful.api.DataSourceRestfulApi.queryDbsWithTables(DataSourceRestfulApi.java:93)
	at com.webank.wedatasphere.linkis.metadata.restful.api.DataSourceRestfulApi$$FastClassBySpringCGLIB$$d7cb9416.invoke(<generated>)
	at org.springframework.cglib.proxy.MethodProxy.invoke(MethodProxy.java:204)
	at org.springframework.aop.framework.CglibAopProxy$CglibMethodInvocation.invokeJoinpoint(CglibAopProxy.java:746)
	at org.springframework.aop.framework.ReflectiveMethodInvocation.proceed(ReflectiveMethodInvocation.java:163)
	at org.springframework.aop.aspectj.MethodInvocationProceedingJoinPoint.proceed(MethodInvocationProceedingJoinPoint.java:88)
	at com.webank.wedatasphere.linkis.server.restful.RestfulCatchAOP$$anonfun$1.apply(RestfulCatchAOP.scala:48)
	at com.webank.wedatasphere.linkis.server.restful.RestfulCatchAOP$$anonfun$1.apply(RestfulCatchAOP.scala:48)
	at com.webank.wedatasphere.linkis.common.utils.Utils$.tryCatch(Utils.scala:48)
	at com.webank.wedatasphere.linkis.server.package$.catchMsg(package.scala:57)
	at com.webank.wedatasphere.linkis.server.package$.catchIt(package.scala:89)
	at com.webank.wedatasphere.linkis.server.restful.RestfulCatchAOP.dealResponseRestful(RestfulCatchAOP.scala:47)
	at sun.reflect.NativeMethodAccessorImpl.invoke0(Native Method)
	at sun.reflect.NativeMethodAccessorImpl.invoke(NativeMethodAccessorImpl.java:62)
	at sun.reflect.DelegatingMethodAccessorImpl.invoke(DelegatingMethodAccessorImpl.java:43)
	at java.lang.reflect.Method.invoke(Method.java:498)
	at org.springframework.aop.aspectj.AbstractAspectJAdvice.invokeAdviceMethodWithGivenArgs(AbstractAspectJAdvice.java:644)
	at org.springframework.aop.aspectj.AbstractAspectJAdvice.invokeAdviceMethod(AbstractAspectJAdvice.java:633)
	at org.springframework.aop.aspectj.AspectJAroundAdvice.invoke(AspectJAroundAdvice.java:70)
	at org.springframework.aop.framework.ReflectiveMethodInvocation.proceed(ReflectiveMethodInvocation.java:174)
	at org.springframework.aop.interceptor.ExposeInvocationInterceptor.invoke(ExposeInvocationInterceptor.java:92)
	at org.springframework.aop.framework.ReflectiveMethodInvocation.proceed(ReflectiveMethodInvocation.java:185)
	at org.springframework.aop.framework.CglibAopProxy$DynamicAdvisedInterceptor.intercept(CglibAopProxy.java:688)
	at com.webank.wedatasphere.linkis.metadata.restful.api.DataSourceRestfulApi$$EnhancerBySpringCGLIB$$c7201aaf.queryDbsWithTables(<generated>)
	at sun.reflect.NativeMethodAccessorImpl.invoke0(Native Method)
	at sun.reflect.NativeMethodAccessorImpl.invoke(NativeMethodAccessorImpl.java:62)
	at sun.reflect.DelegatingMethodAccessorImpl.invoke(DelegatingMethodAccessorImpl.java:43)
	at java.lang.reflect.Method.invoke(Method.java:498)
	at org.glassfish.jersey.server.model.internal.ResourceMethodInvocationHandlerFactory$1.invoke(ResourceMethodInvocationHandlerFactory.java:81)
	at org.glassfish.jersey.server.model.internal.AbstractJavaResourceMethodDispatcher$1.run(AbstractJavaResourceMethodDispatcher.java:144)
	at org.glassfish.jersey.server.model.internal.AbstractJavaResourceMethodDispatcher.invoke(AbstractJavaResourceMethodDispatcher.java:161)
	at org.glassfish.jersey.server.model.internal.JavaResourceMethodDispatcherProvider$ResponseOutInvoker.doDispatch(JavaResourceMethodDispatcherProvider.java:160)
	at org.glassfish.jersey.server.model.internal.AbstractJavaResourceMethodDispatcher.dispatch(AbstractJavaResourceMethodDispatcher.java:99)
	at org.glassfish.jersey.server.model.ResourceMethodInvoker.invoke(ResourceMethodInvoker.java:389)
	at org.glassfish.jersey.server.model.ResourceMethodInvoker.apply(ResourceMethodInvoker.java:347)
	at org.glassfish.jersey.server.model.ResourceMethodInvoker.apply(ResourceMethodInvoker.java:102)
	at org.glassfish.jersey.server.ServerRuntime$2.run(ServerRuntime.java:309)
	at org.glassfish.jersey.internal.Errors$1.call(Errors.java:271)
	at org.glassfish.jersey.internal.Errors$1.call(Errors.java:267)
	at org.glassfish.jersey.internal.Errors.process(Errors.java:315)
	at org.glassfish.jersey.internal.Errors.process(Errors.java:297)
	at org.glassfish.jersey.internal.Errors.process(Errors.java:267)
	at org.glassfish.jersey.process.internal.RequestScope.runInScope(RequestScope.java:317)
	at org.glassfish.jersey.server.ServerRuntime.process(ServerRuntime.java:292)
	at org.glassfish.jersey.server.ApplicationHandler.handle(ApplicationHandler.java:1139)
	at org.glassfish.jersey.servlet.WebComponent.service(WebComponent.java:460)
	at org.glassfish.jersey.servlet.ServletContainer.service(ServletContainer.java:386)
	at org.glassfish.jersey.servlet.ServletContainer.service(ServletContainer.java:334)
	at org.glassfish.jersey.servlet.ServletContainer.service(ServletContainer.java:221)
	at org.eclipse.jetty.servlet.ServletHolder.handle(ServletHolder.java:865)
	at org.eclipse.jetty.servlet.ServletHandler$CachedChain.doFilter(ServletHandler.java:1655)
	at org.eclipse.jetty.websocket.server.WebSocketUpgradeFilter.doFilter(WebSocketUpgradeFilter.java:215)
	at org.eclipse.jetty.servlet.ServletHandler$CachedChain.doFilter(ServletHandler.java:1642)
	at com.webank.wedatasphere.linkis.server.security.SecurityFilter.doFilter(SecurityFilter.scala:101)
	at org.eclipse.jetty.servlet.ServletHandler$CachedChain.doFilter(ServletHandler.java:1642)
	at org.springframework.web.filter.CharacterEncodingFilter.doFilterInternal(CharacterEncodingFilter.java:200)
	at org.springframework.web.filter.OncePerRequestFilter.doFilter(OncePerRequestFilter.java:107)
	at org.eclipse.jetty.servlet.ServletHandler$CachedChain.doFilter(ServletHandler.java:1642)
	at org.springframework.boot.actuate.metrics.web.servlet.WebMvcMetricsFilter.filterAndRecordMetrics(WebMvcMetricsFilter.java:158)
	at org.springframework.boot.actuate.metrics.web.servlet.WebMvcMetricsFilter.filterAndRecordMetrics(WebMvcMetricsFilter.java:126)
	at org.springframework.boot.actuate.metrics.web.servlet.WebMvcMetricsFilter.doFilterInternal(WebMvcMetricsFilter.java:111)
	at org.springframework.web.filter.OncePerRequestFilter.doFilter(OncePerRequestFilter.java:107)
	at org.eclipse.jetty.servlet.ServletHandler$CachedChain.doFilter(ServletHandler.java:1642)
	at org.springframework.boot.actuate.web.trace.servlet.HttpTraceFilter.doFilterInternal(HttpTraceFilter.java:90)
	at org.springframework.web.filter.OncePerRequestFilter.doFilter(OncePerRequestFilter.java:107)
	at org.eclipse.jetty.servlet.ServletHandler$CachedChain.doFilter(ServletHandler.java:1642)
	at org.springframework.web.filter.RequestContextFilter.doFilterInternal(RequestContextFilter.java:99)
	at org.springframework.web.filter.OncePerRequestFilter.doFilter(OncePerRequestFilter.java:107)
	at org.eclipse.jetty.servlet.ServletHandler$CachedChain.doFilter(ServletHandler.java:1642)
	at org.springframework.web.filter.HttpPutFormContentFilter.doFilterInternal(HttpPutFormContentFilter.java:109)
	at org.springframework.web.filter.OncePerRequestFilter.doFilter(OncePerRequestFilter.java:107)
	at org.eclipse.jetty.servlet.ServletHandler$CachedChain.doFilter(ServletHandler.java:1642)
	at org.springframework.web.filter.HiddenHttpMethodFilter.doFilterInternal(HiddenHttpMethodFilter.java:93)
	at org.springframework.web.filter.OncePerRequestFilter.doFilter(OncePerRequestFilter.java:107)
	at org.eclipse.jetty.servlet.ServletHandler$CachedChain.doFilter(ServletHandler.java:1642)
	at org.springframework.web.filter.CharacterEncodingFilter.doFilterInternal(CharacterEncodingFilter.java:200)
	at org.springframework.web.filter.OncePerRequestFilter.doFilter(OncePerRequestFilter.java:107)
	at org.eclipse.jetty.servlet.ServletHandler$CachedChain.doFilter(ServletHandler.java:1642)
	at org.eclipse.jetty.servlet.ServletHandler.doHandle(ServletHandler.java:533)
	at org.eclipse.jetty.server.handler.ScopedHandler.handle(ScopedHandler.java:146)
	at org.eclipse.jetty.security.SecurityHandler.handle(SecurityHandler.java:548)
	at org.eclipse.jetty.server.handler.HandlerWrapper.handle(HandlerWrapper.java:132)
	at org.eclipse.jetty.server.handler.ScopedHandler.nextHandle(ScopedHandler.java:257)
	at org.eclipse.jetty.server.session.SessionHandler.doHandle(SessionHandler.java:1595)
	at org.eclipse.jetty.server.handler.ScopedHandler.nextHandle(ScopedHandler.java:255)
	at org.eclipse.jetty.server.handler.ContextHandler.doHandle(ContextHandler.java:1317)
	at org.eclipse.jetty.server.handler.ScopedHandler.nextScope(ScopedHandler.java:203)
	at org.eclipse.jetty.servlet.ServletHandler.doScope(ServletHandler.java:473)
	at org.eclipse.jetty.server.session.SessionHandler.doScope(SessionHandler.java:1564)
	at org.eclipse.jetty.server.handler.ScopedHandler.nextScope(ScopedHandler.java:201)
	at org.eclipse.jetty.server.handler.ContextHandler.doScope(ContextHandler.java:1219)
	at org.eclipse.jetty.server.handler.ScopedHandler.handle(ScopedHandler.java:144)
	at org.eclipse.jetty.server.handler.HandlerWrapper.handle(HandlerWrapper.java:132)
	at org.eclipse.jetty.server.Server.handle(Server.java:531)
	at org.eclipse.jetty.server.HttpChannel.handle(HttpChannel.java:352)
	at org.eclipse.jetty.server.HttpConnection.onFillable(HttpConnection.java:260)
	at org.eclipse.jetty.io.AbstractConnection$ReadCallback.succeeded(AbstractConnection.java:281)
	at org.eclipse.jetty.io.FillInterest.fillable(FillInterest.java:102)
	at org.eclipse.jetty.io.ChannelEndPoint$2.run(ChannelEndPoint.java:118)
	at org.eclipse.jetty.util.thread.strategy.EatWhatYouKill.runTask(EatWhatYouKill.java:333)
	at org.eclipse.jetty.util.thread.strategy.EatWhatYouKill.doProduce(EatWhatYouKill.java:310)
	at org.eclipse.jetty.util.thread.strategy.EatWhatYouKill.tryProduce(EatWhatYouKill.java:168)
	at org.eclipse.jetty.util.thread.strategy.EatWhatYouKill.produce(EatWhatYouKill.java:132)
	at org.eclipse.jetty.util.thread.QueuedThreadPool.runJob(QueuedThreadPool.java:762)
	at org.eclipse.jetty.util.thread.QueuedThreadPool$2.run(QueuedThreadPool.java:680)
	at java.lang.Thread.run(Thread.java:748)
2021-07-06 17:47:15,194 ERROR (qtp1719289471-24) ERROR DataSourceRestfulApi - Failed to get database(获取数据库失败)：
org.apache.ibatis.binding.BindingException: Invalid bound statement (not found): com.webank.wedatasphere.linkis.metadata.hive.dao.HiveMetaDao.getDbsByUser
	at org.apache.ibatis.binding.MapperMethod$SqlCommand.<init>(MapperMethod.java:227)
	at org.apache.ibatis.binding.MapperMethod.<init>(MapperMethod.java:49)
	at org.apache.ibatis.binding.MapperProxy.cachedMapperMethod(MapperProxy.java:65)
	at org.apache.ibatis.binding.MapperProxy.invoke(MapperProxy.java:58)
	at com.sun.proxy.$Proxy161.getDbsByUser(Unknown Source)
	at com.webank.wedatasphere.linkis.metadata.service.impl.DataSourceServiceImpl.getDbs(DataSourceServiceImpl.java:59)
	at com.webank.wedatasphere.linkis.metadata.restful.api.DataSourceRestfulApi.queryDatabaseInfo(DataSourceRestfulApi.java:80)
	at com.webank.wedatasphere.linkis.metadata.restful.api.DataSourceRestfulApi$$FastClassBySpringCGLIB$$d7cb9416.invoke(<generated>)
	at org.springframework.cglib.proxy.MethodProxy.invoke(MethodProxy.java:204)
	at org.springframework.aop.framework.CglibAopProxy$CglibMethodInvocation.invokeJoinpoint(CglibAopProxy.java:746)
	at org.springframework.aop.framework.ReflectiveMethodInvocation.proceed(ReflectiveMethodInvocation.java:163)
	at org.springframework.aop.aspectj.MethodInvocationProceedingJoinPoint.proceed(MethodInvocationProceedingJoinPoint.java:88)
	at com.webank.wedatasphere.linkis.server.restful.RestfulCatchAOP$$anonfun$1.apply(RestfulCatchAOP.scala:48)
	at com.webank.wedatasphere.linkis.server.restful.RestfulCatchAOP$$anonfun$1.apply(RestfulCatchAOP.scala:48)
	at com.webank.wedatasphere.linkis.common.utils.Utils$.tryCatch(Utils.scala:48)
	at com.webank.wedatasphere.linkis.server.package$.catchMsg(package.scala:57)
	at com.webank.wedatasphere.linkis.server.package$.catchIt(package.scala:89)
	at com.webank.wedatasphere.linkis.server.restful.RestfulCatchAOP.dealResponseRestful(RestfulCatchAOP.scala:47)
	at sun.reflect.NativeMethodAccessorImpl.invoke0(Native Method)
	at sun.reflect.NativeMethodAccessorImpl.invoke(NativeMethodAccessorImpl.java:62)
	at sun.reflect.DelegatingMethodAccessorImpl.invoke(DelegatingMethodAccessorImpl.java:43)
	at java.lang.reflect.Method.invoke(Method.java:498)
	at org.springframework.aop.aspectj.AbstractAspectJAdvice.invokeAdviceMethodWithGivenArgs(AbstractAspectJAdvice.java:644)
	at org.springframework.aop.aspectj.AbstractAspectJAdvice.invokeAdviceMethod(AbstractAspectJAdvice.java:633)
	at org.springframework.aop.aspectj.AspectJAroundAdvice.invoke(AspectJAroundAdvice.java:70)
	at org.springframework.aop.framework.ReflectiveMethodInvocation.proceed(ReflectiveMethodInvocation.java:174)
	at org.springframework.aop.interceptor.ExposeInvocationInterceptor.invoke(ExposeInvocationInterceptor.java:92)
	at org.springframework.aop.framework.ReflectiveMethodInvocation.proceed(ReflectiveMethodInvocation.java:185)
	at org.springframework.aop.framework.CglibAopProxy$DynamicAdvisedInterceptor.intercept(CglibAopProxy.java:688)
	at com.webank.wedatasphere.linkis.metadata.restful.api.DataSourceRestfulApi$$EnhancerBySpringCGLIB$$c7201aaf.queryDatabaseInfo(<generated>)
	at sun.reflect.NativeMethodAccessorImpl.invoke0(Native Method)
	at sun.reflect.NativeMethodAccessorImpl.invoke(NativeMethodAccessorImpl.java:62)
	at sun.reflect.DelegatingMethodAccessorImpl.invoke(DelegatingMethodAccessorImpl.java:43)
	at java.lang.reflect.Method.invoke(Method.java:498)
	at org.glassfish.jersey.server.model.internal.ResourceMethodInvocationHandlerFactory$1.invoke(ResourceMethodInvocationHandlerFactory.java:81)
	at org.glassfish.jersey.server.model.internal.AbstractJavaResourceMethodDispatcher$1.run(AbstractJavaResourceMethodDispatcher.java:144)
	at org.glassfish.jersey.server.model.internal.AbstractJavaResourceMethodDispatcher.invoke(AbstractJavaResourceMethodDispatcher.java:161)
	at org.glassfish.jersey.server.model.internal.JavaResourceMethodDispatcherProvider$ResponseOutInvoker.doDispatch(JavaResourceMethodDispatcherProvider.java:160)
	at org.glassfish.jersey.server.model.internal.AbstractJavaResourceMethodDispatcher.dispatch(AbstractJavaResourceMethodDispatcher.java:99)
	at org.glassfish.jersey.server.model.ResourceMethodInvoker.invoke(ResourceMethodInvoker.java:389)
	at org.glassfish.jersey.server.model.ResourceMethodInvoker.apply(ResourceMethodInvoker.java:347)
	at org.glassfish.jersey.server.model.ResourceMethodInvoker.apply(ResourceMethodInvoker.java:102)
	at org.glassfish.jersey.server.ServerRuntime$2.run(ServerRuntime.java:309)
	at org.glassfish.jersey.internal.Errors$1.call(Errors.java:271)
	at org.glassfish.jersey.internal.Errors$1.call(Errors.java:267)
	at org.glassfish.jersey.internal.Errors.process(Errors.java:315)
	at org.glassfish.jersey.internal.Errors.process(Errors.java:297)
	at org.glassfish.jersey.internal.Errors.process(Errors.java:267)
	at org.glassfish.jersey.process.internal.RequestScope.runInScope(RequestScope.java:317)
	at org.glassfish.jersey.server.ServerRuntime.process(ServerRuntime.java:292)
	at org.glassfish.jersey.server.ApplicationHandler.handle(ApplicationHandler.java:1139)
	at org.glassfish.jersey.servlet.WebComponent.service(WebComponent.java:460)
	at org.glassfish.jersey.servlet.ServletContainer.service(ServletContainer.java:386)
	at org.glassfish.jersey.servlet.ServletContainer.service(ServletContainer.java:334)
	at org.glassfish.jersey.servlet.ServletContainer.service(ServletContainer.java:221)
	at org.eclipse.jetty.servlet.ServletHolder.handle(ServletHolder.java:865)
	at org.eclipse.jetty.servlet.ServletHandler$CachedChain.doFilter(ServletHandler.java:1655)
	at org.eclipse.jetty.websocket.server.WebSocketUpgradeFilter.doFilter(WebSocketUpgradeFilter.java:215)
	at org.eclipse.jetty.servlet.ServletHandler$CachedChain.doFilter(ServletHandler.java:1642)
	at com.webank.wedatasphere.linkis.server.security.SecurityFilter.doFilter(SecurityFilter.scala:101)
	at org.eclipse.jetty.servlet.ServletHandler$CachedChain.doFilter(ServletHandler.java:1642)
	at org.springframework.web.filter.CharacterEncodingFilter.doFilterInternal(CharacterEncodingFilter.java:200)
	at org.springframework.web.filter.OncePerRequestFilter.doFilter(OncePerRequestFilter.java:107)
	at org.eclipse.jetty.servlet.ServletHandler$CachedChain.doFilter(ServletHandler.java:1642)
	at org.springframework.boot.actuate.metrics.web.servlet.WebMvcMetricsFilter.filterAndRecordMetrics(WebMvcMetricsFilter.java:158)
	at org.springframework.boot.actuate.metrics.web.servlet.WebMvcMetricsFilter.filterAndRecordMetrics(WebMvcMetricsFilter.java:126)
	at org.springframework.boot.actuate.metrics.web.servlet.WebMvcMetricsFilter.doFilterInternal(WebMvcMetricsFilter.java:111)
	at org.springframework.web.filter.OncePerRequestFilter.doFilter(OncePerRequestFilter.java:107)
	at org.eclipse.jetty.servlet.ServletHandler$CachedChain.doFilter(ServletHandler.java:1642)
	at org.springframework.boot.actuate.web.trace.servlet.HttpTraceFilter.doFilterInternal(HttpTraceFilter.java:90)
	at org.springframework.web.filter.OncePerRequestFilter.doFilter(OncePerRequestFilter.java:107)
	at org.eclipse.jetty.servlet.ServletHandler$CachedChain.doFilter(ServletHandler.java:1642)
	at org.springframework.web.filter.RequestContextFilter.doFilterInternal(RequestContextFilter.java:99)
	at org.springframework.web.filter.OncePerRequestFilter.doFilter(OncePerRequestFilter.java:107)
	at org.eclipse.jetty.servlet.ServletHandler$CachedChain.doFilter(ServletHandler.java:1642)
	at org.springframework.web.filter.HttpPutFormContentFilter.doFilterInternal(HttpPutFormContentFilter.java:109)
	at org.springframework.web.filter.OncePerRequestFilter.doFilter(OncePerRequestFilter.java:107)
	at org.eclipse.jetty.servlet.ServletHandler$CachedChain.doFilter(ServletHandler.java:1642)
	at org.springframework.web.filter.HiddenHttpMethodFilter.doFilterInternal(HiddenHttpMethodFilter.java:93)
	at org.springframework.web.filter.OncePerRequestFilter.doFilter(OncePerRequestFilter.java:107)
	at org.eclipse.jetty.servlet.ServletHandler$CachedChain.doFilter(ServletHandler.java:1642)
	at org.springframework.web.filter.CharacterEncodingFilter.doFilterInternal(CharacterEncodingFilter.java:200)
	at org.springframework.web.filter.OncePerRequestFilter.doFilter(OncePerRequestFilter.java:107)
	at org.eclipse.jetty.servlet.ServletHandler$CachedChain.doFilter(ServletHandler.java:1642)
	at org.eclipse.jetty.servlet.ServletHandler.doHandle(ServletHandler.java:533)
	at org.eclipse.jetty.server.handler.ScopedHandler.handle(ScopedHandler.java:146)
	at org.eclipse.jetty.security.SecurityHandler.handle(SecurityHandler.java:548)
	at org.eclipse.jetty.server.handler.HandlerWrapper.handle(HandlerWrapper.java:132)
	at org.eclipse.jetty.server.handler.ScopedHandler.nextHandle(ScopedHandler.java:257)
	at org.eclipse.jetty.server.session.SessionHandler.doHandle(SessionHandler.java:1595)
	at org.eclipse.jetty.server.handler.ScopedHandler.nextHandle(ScopedHandler.java:255)
	at org.eclipse.jetty.server.handler.ContextHandler.doHandle(ContextHandler.java:1317)
	at org.eclipse.jetty.server.handler.ScopedHandler.nextScope(ScopedHandler.java:203)
	at org.eclipse.jetty.servlet.ServletHandler.doScope(ServletHandler.java:473)
	at org.eclipse.jetty.server.session.SessionHandler.doScope(SessionHandler.java:1564)
	at org.eclipse.jetty.server.handler.ScopedHandler.nextScope(ScopedHandler.java:201)
	at org.eclipse.jetty.server.handler.ContextHandler.doScope(ContextHandler.java:1219)
	at org.eclipse.jetty.server.handler.ScopedHandler.handle(ScopedHandler.java:144)
	at org.eclipse.jetty.server.handler.HandlerWrapper.handle(HandlerWrapper.java:132)
	at org.eclipse.jetty.server.Server.handle(Server.java:531)
	at org.eclipse.jetty.server.HttpChannel.handle(HttpChannel.java:352)
	at org.eclipse.jetty.server.HttpConnection.onFillable(HttpConnection.java:260)
	at org.eclipse.jetty.io.AbstractConnection$ReadCallback.succeeded(AbstractConnection.java:281)
	at org.eclipse.jetty.io.FillInterest.fillable(FillInterest.java:102)
	at org.eclipse.jetty.io.ChannelEndPoint$2.run(ChannelEndPoint.java:118)
	at org.eclipse.jetty.util.thread.strategy.EatWhatYouKill.runTask(EatWhatYouKill.java:333)
	at org.eclipse.jetty.util.thread.strategy.EatWhatYouKill.doProduce(EatWhatYouKill.java:310)
	at org.eclipse.jetty.util.thread.strategy.EatWhatYouKill.tryProduce(EatWhatYouKill.java:168)
	at org.eclipse.jetty.util.thread.strategy.EatWhatYouKill.run(EatWhatYouKill.java:126)
	at org.eclipse.jetty.util.thread.ReservedThreadExecutor$ReservedThread.run(ReservedThreadExecutor.java:366)
	at org.eclipse.jetty.util.thread.QueuedThreadPool.runJob(QueuedThreadPool.java:762)
	at org.eclipse.jetty.util.thread.QueuedThreadPool$2.run(QueuedThreadPool.java:680)
	at java.lang.Thread.run(Thread.java:748)
2021-07-06 17:47:22,109 ERROR (qtp1719289471-23) ERROR DataSourceRestfulApi - Failed to get allDbs and tables(获取数据全部的库表信息失败)：
org.apache.ibatis.binding.BindingException: Invalid bound statement (not found): com.webank.wedatasphere.linkis.metadata.hive.dao.HiveMetaDao.getDbsByUser
	at org.apache.ibatis.binding.MapperMethod$SqlCommand.<init>(MapperMethod.java:227)
	at org.apache.ibatis.binding.MapperMethod.<init>(MapperMethod.java:49)
	at org.apache.ibatis.binding.MapperProxy.cachedMapperMethod(MapperProxy.java:65)
	at org.apache.ibatis.binding.MapperProxy.invoke(MapperProxy.java:58)
	at com.sun.proxy.$Proxy161.getDbsByUser(Unknown Source)
	at com.webank.wedatasphere.linkis.metadata.service.impl.DataSourceServiceImpl.getDbsWithTables(DataSourceServiceImpl.java:72)
	at com.webank.wedatasphere.linkis.metadata.restful.api.DataSourceRestfulApi.queryDbsWithTables(DataSourceRestfulApi.java:93)
	at com.webank.wedatasphere.linkis.metadata.restful.api.DataSourceRestfulApi$$FastClassBySpringCGLIB$$d7cb9416.invoke(<generated>)
	at org.springframework.cglib.proxy.MethodProxy.invoke(MethodProxy.java:204)
	at org.springframework.aop.framework.CglibAopProxy$CglibMethodInvocation.invokeJoinpoint(CglibAopProxy.java:746)
	at org.springframework.aop.framework.ReflectiveMethodInvocation.proceed(ReflectiveMethodInvocation.java:163)
	at org.springframework.aop.aspectj.MethodInvocationProceedingJoinPoint.proceed(MethodInvocationProceedingJoinPoint.java:88)
	at com.webank.wedatasphere.linkis.server.restful.RestfulCatchAOP$$anonfun$1.apply(RestfulCatchAOP.scala:48)
	at com.webank.wedatasphere.linkis.server.restful.RestfulCatchAOP$$anonfun$1.apply(RestfulCatchAOP.scala:48)
	at com.webank.wedatasphere.linkis.common.utils.Utils$.tryCatch(Utils.scala:48)
	at com.webank.wedatasphere.linkis.server.package$.catchMsg(package.scala:57)
	at com.webank.wedatasphere.linkis.server.package$.catchIt(package.scala:89)
	at com.webank.wedatasphere.linkis.server.restful.RestfulCatchAOP.dealResponseRestful(RestfulCatchAOP.scala:47)
	at sun.reflect.NativeMethodAccessorImpl.invoke0(Native Method)
	at sun.reflect.NativeMethodAccessorImpl.invoke(NativeMethodAccessorImpl.java:62)
	at sun.reflect.DelegatingMethodAccessorImpl.invoke(DelegatingMethodAccessorImpl.java:43)
	at java.lang.reflect.Method.invoke(Method.java:498)
	at org.springframework.aop.aspectj.AbstractAspectJAdvice.invokeAdviceMethodWithGivenArgs(AbstractAspectJAdvice.java:644)
	at org.springframework.aop.aspectj.AbstractAspectJAdvice.invokeAdviceMethod(AbstractAspectJAdvice.java:633)
	at org.springframework.aop.aspectj.AspectJAroundAdvice.invoke(AspectJAroundAdvice.java:70)
	at org.springframework.aop.framework.ReflectiveMethodInvocation.proceed(ReflectiveMethodInvocation.java:174)
	at org.springframework.aop.interceptor.ExposeInvocationInterceptor.invoke(ExposeInvocationInterceptor.java:92)
	at org.springframework.aop.framework.ReflectiveMethodInvocation.proceed(ReflectiveMethodInvocation.java:185)
	at org.springframework.aop.framework.CglibAopProxy$DynamicAdvisedInterceptor.intercept(CglibAopProxy.java:688)
	at com.webank.wedatasphere.linkis.metadata.restful.api.DataSourceRestfulApi$$EnhancerBySpringCGLIB$$c7201aaf.queryDbsWithTables(<generated>)
	at sun.reflect.NativeMethodAccessorImpl.invoke0(Native Method)
	at sun.reflect.NativeMethodAccessorImpl.invoke(NativeMethodAccessorImpl.java:62)
	at sun.reflect.DelegatingMethodAccessorImpl.invoke(DelegatingMethodAccessorImpl.java:43)
	at java.lang.reflect.Method.invoke(Method.java:498)
	at org.glassfish.jersey.server.model.internal.ResourceMethodInvocationHandlerFactory$1.invoke(ResourceMethodInvocationHandlerFactory.java:81)
	at org.glassfish.jersey.server.model.internal.AbstractJavaResourceMethodDispatcher$1.run(AbstractJavaResourceMethodDispatcher.java:144)
	at org.glassfish.jersey.server.model.internal.AbstractJavaResourceMethodDispatcher.invoke(AbstractJavaResourceMethodDispatcher.java:161)
	at org.glassfish.jersey.server.model.internal.JavaResourceMethodDispatcherProvider$ResponseOutInvoker.doDispatch(JavaResourceMethodDispatcherProvider.java:160)
	at org.glassfish.jersey.server.model.internal.AbstractJavaResourceMethodDispatcher.dispatch(AbstractJavaResourceMethodDispatcher.java:99)
	at org.glassfish.jersey.server.model.ResourceMethodInvoker.invoke(ResourceMethodInvoker.java:389)
	at org.glassfish.jersey.server.model.ResourceMethodInvoker.apply(ResourceMethodInvoker.java:347)
	at org.glassfish.jersey.server.model.ResourceMethodInvoker.apply(ResourceMethodInvoker.java:102)
	at org.glassfish.jersey.server.ServerRuntime$2.run(ServerRuntime.java:309)
	at org.glassfish.jersey.internal.Errors$1.call(Errors.java:271)
	at org.glassfish.jersey.internal.Errors$1.call(Errors.java:267)
	at org.glassfish.jersey.internal.Errors.process(Errors.java:315)
	at org.glassfish.jersey.internal.Errors.process(Errors.java:297)
	at org.glassfish.jersey.internal.Errors.process(Errors.java:267)
	at org.glassfish.jersey.process.internal.RequestScope.runInScope(RequestScope.java:317)
	at org.glassfish.jersey.server.ServerRuntime.process(ServerRuntime.java:292)
	at org.glassfish.jersey.server.ApplicationHandler.handle(ApplicationHandler.java:1139)
	at org.glassfish.jersey.servlet.WebComponent.service(WebComponent.java:460)
	at org.glassfish.jersey.servlet.ServletContainer.service(ServletContainer.java:386)
	at org.glassfish.jersey.servlet.ServletContainer.service(ServletContainer.java:334)
	at org.glassfish.jersey.servlet.ServletContainer.service(ServletContainer.java:221)
	at org.eclipse.jetty.servlet.ServletHolder.handle(ServletHolder.java:865)
	at org.eclipse.jetty.servlet.ServletHandler$CachedChain.doFilter(ServletHandler.java:1655)
	at org.eclipse.jetty.websocket.server.WebSocketUpgradeFilter.doFilter(WebSocketUpgradeFilter.java:215)
	at org.eclipse.jetty.servlet.ServletHandler$CachedChain.doFilter(ServletHandler.java:1642)
	at com.webank.wedatasphere.linkis.server.security.SecurityFilter.doFilter(SecurityFilter.scala:101)
	at org.eclipse.jetty.servlet.ServletHandler$CachedChain.doFilter(ServletHandler.java:1642)
	at org.springframework.web.filter.CharacterEncodingFilter.doFilterInternal(CharacterEncodingFilter.java:200)
	at org.springframework.web.filter.OncePerRequestFilter.doFilter(OncePerRequestFilter.java:107)
	at org.eclipse.jetty.servlet.ServletHandler$CachedChain.doFilter(ServletHandler.java:1642)
	at org.springframework.boot.actuate.metrics.web.servlet.WebMvcMetricsFilter.filterAndRecordMetrics(WebMvcMetricsFilter.java:158)
	at org.springframework.boot.actuate.metrics.web.servlet.WebMvcMetricsFilter.filterAndRecordMetrics(WebMvcMetricsFilter.java:126)
	at org.springframework.boot.actuate.metrics.web.servlet.WebMvcMetricsFilter.doFilterInternal(WebMvcMetricsFilter.java:111)
	at org.springframework.web.filter.OncePerRequestFilter.doFilter(OncePerRequestFilter.java:107)
	at org.eclipse.jetty.servlet.ServletHandler$CachedChain.doFilter(ServletHandler.java:1642)
	at org.springframework.boot.actuate.web.trace.servlet.HttpTraceFilter.doFilterInternal(HttpTraceFilter.java:90)
	at org.springframework.web.filter.OncePerRequestFilter.doFilter(OncePerRequestFilter.java:107)
	at org.eclipse.jetty.servlet.ServletHandler$CachedChain.doFilter(ServletHandler.java:1642)
	at org.springframework.web.filter.RequestContextFilter.doFilterInternal(RequestContextFilter.java:99)
	at org.springframework.web.filter.OncePerRequestFilter.doFilter(OncePerRequestFilter.java:107)
	at org.eclipse.jetty.servlet.ServletHandler$CachedChain.doFilter(ServletHandler.java:1642)
	at org.springframework.web.filter.HttpPutFormContentFilter.doFilterInternal(HttpPutFormContentFilter.java:109)
	at org.springframework.web.filter.OncePerRequestFilter.doFilter(OncePerRequestFilter.java:107)
	at org.eclipse.jetty.servlet.ServletHandler$CachedChain.doFilter(ServletHandler.java:1642)
	at org.springframework.web.filter.HiddenHttpMethodFilter.doFilterInternal(HiddenHttpMethodFilter.java:93)
	at org.springframework.web.filter.OncePerRequestFilter.doFilter(OncePerRequestFilter.java:107)
	at org.eclipse.jetty.servlet.ServletHandler$CachedChain.doFilter(ServletHandler.java:1642)
	at org.springframework.web.filter.CharacterEncodingFilter.doFilterInternal(CharacterEncodingFilter.java:200)
	at org.springframework.web.filter.OncePerRequestFilter.doFilter(OncePerRequestFilter.java:107)
	at org.eclipse.jetty.servlet.ServletHandler$CachedChain.doFilter(ServletHandler.java:1642)
	at org.eclipse.jetty.servlet.ServletHandler.doHandle(ServletHandler.java:533)
	at org.eclipse.jetty.server.handler.ScopedHandler.handle(ScopedHandler.java:146)
	at org.eclipse.jetty.security.SecurityHandler.handle(SecurityHandler.java:548)
	at org.eclipse.jetty.server.handler.HandlerWrapper.handle(HandlerWrapper.java:132)
	at org.eclipse.jetty.server.handler.ScopedHandler.nextHandle(ScopedHandler.java:257)
	at org.eclipse.jetty.server.session.SessionHandler.doHandle(SessionHandler.java:1595)
	at org.eclipse.jetty.server.handler.ScopedHandler.nextHandle(ScopedHandler.java:255)
	at org.eclipse.jetty.server.handler.ContextHandler.doHandle(ContextHandler.java:1317)
	at org.eclipse.jetty.server.handler.ScopedHandler.nextScope(ScopedHandler.java:203)
	at org.eclipse.jetty.servlet.ServletHandler.doScope(ServletHandler.java:473)
	at org.eclipse.jetty.server.session.SessionHandler.doScope(SessionHandler.java:1564)
	at org.eclipse.jetty.server.handler.ScopedHandler.nextScope(ScopedHandler.java:201)
	at org.eclipse.jetty.server.handler.ContextHandler.doScope(ContextHandler.java:1219)
	at org.eclipse.jetty.server.handler.ScopedHandler.handle(ScopedHandler.java:144)
	at org.eclipse.jetty.server.handler.HandlerWrapper.handle(HandlerWrapper.java:132)
	at org.eclipse.jetty.server.Server.handle(Server.java:531)
	at org.eclipse.jetty.server.HttpChannel.handle(HttpChannel.java:352)
	at org.eclipse.jetty.server.HttpConnection.onFillable(HttpConnection.java:260)
	at org.eclipse.jetty.io.AbstractConnection$ReadCallback.succeeded(AbstractConnection.java:281)
	at org.eclipse.jetty.io.FillInterest.fillable(FillInterest.java:102)
	at org.eclipse.jetty.io.ChannelEndPoint$2.run(ChannelEndPoint.java:118)
	at org.eclipse.jetty.util.thread.strategy.EatWhatYouKill.runTask(EatWhatYouKill.java:333)
	at org.eclipse.jetty.util.thread.strategy.EatWhatYouKill.doProduce(EatWhatYouKill.java:310)
	at org.eclipse.jetty.util.thread.strategy.EatWhatYouKill.tryProduce(EatWhatYouKill.java:168)
	at org.eclipse.jetty.util.thread.strategy.EatWhatYouKill.run(EatWhatYouKill.java:126)
	at org.eclipse.jetty.util.thread.ReservedThreadExecutor$ReservedThread.run(ReservedThreadExecutor.java:366)
	at org.eclipse.jetty.util.thread.QueuedThreadPool.runJob(QueuedThreadPool.java:762)
	at org.eclipse.jetty.util.thread.QueuedThreadPool$2.run(QueuedThreadPool.java:680)
	at java.lang.Thread.run(Thread.java:748)
2021-07-06 17:50:02.198 INFO  [AsyncResolver-bootstrap-executor-0] com.netflix.discovery.shared.resolver.aws.ConfigClusterResolver 43 getClusterEndpoints - Resolving eureka endpoints via configuration
```


## 初始化数据表

```sh
mysql> show databases;
+--------------------+
| Database           |
+--------------------+
| dss                |
| hive               |
| information_schema |
| mysql              |
| performance_schema |
| sys                |
+--------------------+
6 rows in set (0.00 sec)

mysql> use dss 
Database changed
mysql> show tables;
+---------------------------------------------+
| Tables_in_dss                               |
+---------------------------------------------+
| cron_job                                    |
| dashboard                                   |
| dashboard_portal                            |
| davinci_statistic_duration                  |
| davinci_statistic_terminal                  |
| davinci_statistic_visitor_operation         |
| display                                     |
| display_slide                               |
| download_record                             |
| dss_application                             |
| dss_application_user_init_result            |
| dss_flow                                    |
| dss_flow_publish_history                    |
| dss_flow_relation                           |
| dss_flow_taxonomy                           |
| dss_flow_taxonomy_relation                  |
| dss_flow_version                            |
| dss_homepage_demo_instance                  |
| dss_homepage_demo_menu                      |
| dss_homepage_video                          |
| dss_onestop_menu                            |
| dss_onestop_menu_application                |
| dss_onestop_user_favorites                  |
| dss_project                                 |
| dss_project_applications_project            |
| dss_project_publish_history                 |
| dss_project_taxonomy                        |
| dss_project_taxonomy_relation               |
| dss_project_version                         |
| dss_user                                    |
| dss_workflow_node                           |
| dss_workspace                               |
| event_auth                                  |
| event_queue                                 |
| event_status                                |
| favorite                                    |
| linkis_application                          |
| linkis_config_key                           |
| linkis_config_key_tree                      |
| linkis_config_key_user                      |
| linkis_config_tree                          |
| linkis_cs_context_history                   |
| linkis_cs_context_id                        |
| linkis_cs_context_listener                  |
| linkis_cs_context_map                       |
| linkis_cs_context_map_listener              |
| linkis_datasource                           |
| linkis_datasource_env                       |
| linkis_datasource_type                      |
| linkis_datasource_type_env                  |
| linkis_datasource_type_key                  |
| linkis_develop_application                  |
| linkis_em_meta_data                         |
| linkis_em_resource_meta_data                |
| linkis_mdq_access                           |
| linkis_mdq_field                            |
| linkis_mdq_import                           |
| linkis_mdq_lineage                          |
| linkis_mdq_table                            |
| linkis_mdq_table_info                       |
| linkis_project_list                         |
| linkis_project_user                         |
| linkis_resource_lock                        |
| linkis_resources                            |
| linkis_resources_download_history           |
| linkis_resources_permission                 |
| linkis_resources_task                       |
| linkis_resources_version                    |
| linkis_task                                 |
| linkis_udf                                  |
| linkis_udf_manager                          |
| linkis_udf_shared_group                     |
| linkis_udf_shared_user                      |
| linkis_udf_tree                             |
| linkis_udf_user_load_info                   |
| linkis_user                                 |
| linkis_user_resource_meta_data              |
| linkis_var_key                              |
| linkis_var_key_user                         |
| mem_dashboard_widget                        |
| mem_display_slide_widget                    |
| organization                                |
| platform                                    |
| project                                     |
| qualitis_application                        |
| qualitis_application_task                   |
| qualitis_application_task_datasource        |
| qualitis_application_task_result            |
| qualitis_application_task_rule_alarm_config |
| qualitis_application_task_rule_simple       |
| qualitis_auth_list                          |
| qualitis_auth_permission                    |
| qualitis_auth_proxy_user                    |
| qualitis_auth_role                          |
| qualitis_auth_role_permission               |
| qualitis_auth_user                          |
| qualitis_auth_user_permission               |
| qualitis_auth_user_proxy_user               |
| qualitis_auth_user_role                     |
| qualitis_config_cluster_info                |
| qualitis_config_system                      |
| qualitis_project                            |
| qualitis_project_label                      |
| qualitis_project_user                       |
| qualitis_rule                               |
| qualitis_rule_alarm_config                  |
| qualitis_rule_datasource                    |
| qualitis_rule_datasource_mapping            |
| qualitis_rule_group                         |
| qualitis_rule_variable                      |
| qualitis_template                           |
| qualitis_template_mid_table_input_meta      |
| qualitis_template_output_meta               |
| qualitis_template_regexp_expr               |
| qualitis_template_statistic_input_meta      |
| qualitis_template_user                      |
| rel_project_admin                           |
| rel_role_dashboard                          |
| rel_role_dashboard_widget                   |
| rel_role_display                            |
| rel_role_display_slide_widget               |
| rel_role_portal                             |
| rel_role_project                            |
| rel_role_slide                              |
| rel_role_user                               |
| rel_role_view                               |
| rel_user_organization                       |
| role                                        |
| share_download_record                       |
| source                                      |
| star                                        |
| user                                        |
| view                                        |
| widget                                      |
+---------------------------------------------+
134 rows in set (0.01 sec)
```


```sh
cat /home/hadoop/.bashrc 

# Uncomment the following line if you don't like systemctl's auto-paging feature:
# export SYSTEMD_PAGER=

# User specific aliases and functions
#JDK
export JAVA_HOME=/etc/alternatives/jre_1.8.0_openjdk
#HADOOP
export HADOOP_CONF_DIR=/usr/local/hadoop-2.7.2/etc/hadoop
#Hive
export HIVE_CONF_DIR=/usr/local/apache-hive-1.2.1-bin/conf
#Spark
export SPARK_HOME=/usr/local/spark-2.4.8-bin-hadoop2.7
export SPARK_CONF_DIR=/usr/local/spark-2.4.8-bin-hadoop2.7/conf
export PYSPARK_ALLOW_INSECURE_GATEWAY=1  # Pyspark必须加的参数
```


# 前端可视化编辑器基于宜信的davinci 达芬奇

https://edp963.github.io/davinci/docs/zh/1.1-deployment

> Visualis与Davinci的功能区别

https://github.com/WeBankFinTech/Visualis/blob/master/visualis_docs/zh_CN/Visualis_Davinci_difference_cn.md


# 初始化登录的文档

为了方便用户使用，系统默认通过使用Linkis的部署用户名进行登录，比如是hadoop部署的可以直接通过 用户：hadoop，密码：hadoop(密码就是用户名)来进行登录。 首先输入前端容器地址：192.168.xx.xx:8888 接着输入用户名密码：hadoop/hadoop

注意： 如果要支持多用户登录，DSS的用户登录依赖Linkis，需要在linkis-GateWay的配置里面进行配置，Linkis-GateWay默认支持LDAP。

https://github.com/WeBankFinTech/DataSphereStudio/blob/master/docs/zh_CN/ch3/DSS_User_Manual.md

# linkis 基本配置

linkis.properties

WIKI

https://github.com/WeBankFinTech/Linkis/wiki

# 伴鱼数据中心

https://jishuin.proginn.com/p/763bfbd5e21f


## 如何将已有的内部系统作为DSS已集成系统？ 

Joe798 commented on 18 Oct 2020
https://github.com/WeBankFinTech/DataSphereStudio/wiki/Login
https://github.com/WeBankFinTech/DataSphereStudio/blob/master/docs/zh_CN/ch4/第三方系统接入DSS指南.md

阅读 wiki 和 md 了解到，token登录方式是给第三方系统访问Linkis和DSS使用的，在request的header或cookie中，写入Token-Code和Token-User两个参数。

已有一个内部系统 A ，A 系统有自己的用户体系，非LADP，没有SSO ，访问 A 系统需要先登录。
希望实现登录DSS后，在DSS首页的【已集成系统】点击 A 系统图标后直接进入，无须再登录 A 系统。

像这种场景要怎么处理？

@wushengyeyouya
 
Contributor
wushengyeyouya commented on 19 Oct 2020
Please implement a new AppJoint.

# azkaban 任务调度

https://azkaban.readthedocs.io/en/latest/