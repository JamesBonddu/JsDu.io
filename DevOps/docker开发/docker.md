## Docker 搭建数据采集环境

## Docker源码解析

http://blog.daocloud.io/docker-source-code-analysis-part1/

## Docker Hub

```sh
/etc/init/docker.conf

# 拉取hub
docker run -d -p 5000:5000 --restart=always -v /opt/data/registry:/var/lib/registry --name registry registry

# 标记本地镜像
docker tag nginx:latest hubip:5000/nginx:latest

# 推送
docker push hubip:5000/nginx:latest

# 拉取
docker pull hubip:5000/nginx:latest
```

[]()
## Kafka



### 环境搭建

```
# 下载镜像
docker pull wurstmeister/zookeeper
docker pull wurstmeister/kafka

# 启动zookeeperjplock/zookeeper

docker run -d -h zk-host --name zookeeper -p 2181:2181 -t jplock/zookeeper

# 启动kafka容器
docker run -d --name kafka --publish 9092:9092  --env KAFKA_ZOOKEEPER_CONNECT=(zookeeper_IP)172.17.0.3:2181 --env KAFKA_ADVERTISED_HOST_NAME=(宿主机IP)10.255.175.79 --env KAFKA_ADVERTISED_PORT=9092 --volume /home/jsdu/kafka-store:/home/jsdu/kafka-store wurstmeister/kafka:latest

# 进入容器
docker exec -it ${CONTAINER ID} /bin/bash

```



## HBase



配置

```
# cat hbase-env.sh
export HBASE_CLASSPATH=/hbase/lib/

export HBASE_MANAGES_ZK=false


bash-4.4# cat /hbase/conf/hbase-site.xml
<?xml version="1.0"?>
<?xml-stylesheet type="text/xsl" href="configuration.xsl"?>
<configuration>
  <property>
    <name>hbase.cluster.distributed</name>
    <value>true</value>
  </property>
  <property>
    <name>hbase.rootdir</name>
    <value>file:///home/jsdu/hbase-store</value>
  </property>
  <property>
    <name>hbase.master.info.port</name>
    <value>60010</value>
  </property>
  <property>
      <name>hbase.zookeeper.quorum</name>
      <value>ip</value> ！！！！改为宿主机IP
  </property>
  <property>
      <name>hbase.zookeeper.property.clientPort</name>
      <value>2181</value>
  </property>
</configuration>


bash-4.4# cat zookeeper.log
java.io.IOException: Could not find my address: master in list of ZooKeeper quorum servers
	at org.apache.hadoop.hbase.zookeeper.HQuorumPeer.writeMyID(HQuorumPeer.java:149)
	at org.apache.hadoop.hbase.zookeeper.HQuorumPeer.main(HQuorumPeer.java:70)



#修改宿主机的/etc/hosts
ip master
```





HBase 启动命令



```
docker run -d  --mount type=bind,source=/home/jsdu/hbase-store/,target=/home/jsdu/hbase-store/ -p 8080:8080 -p 8085:8085 -p 9090:9090 -p 9095:9095 -p 16000:16000 -p 16010:16010 -p 16201:16201 -p 16301:16301  --name hbase harisekhon/hbase:1.3
```



```
docker run -d -h hbase-host --mount type=bind,source=/home/jsdu/hbase-store/,target=/home/jsdu/hbase-store/ -p 8080:8080 -p 8085:8085 -p 9090:9090 -p 9095:9095 -p 16000:16000 -p 16010:16010 -p 16201:16201 -p 16301:16301  -p 8765:8765 --name hbase cef60bc6ebe5 /entrypoint.sh


 cat hbase.tar |docker import - hbasejsdu

```

docker run -d  --mount type=bind,source=/home/jsdu/hbase-store/,target=/home/jsdu/hbase-store/ -p 8080:8080 -p 8085:8085 -p 9090:9090 -p 9095:9095 -p 16000:16000 -p 16010:16010 -p 16201:16201 -p 16301:16301  -p 8765:8765 --name hbase hbase /entrypoint.sh



[B+树](https://www.cnblogs.com/vincently/p/4526560.html)

## 安装Thrift

```
apk add python2
apk add --update py-pip
pip install thrift

```



## 修改配置文件



## 安装Phoenix

```
/hbase/bin/hbase shell
version 看到1.3
# 下载phoenix 对应版本的安装包
wget  http://120.52.51.13/www.apache.org/dyn/closer.lua/phoenix/apache-phoenix-4.14.1-HBase-1.3/bin/apache-phoenix-4.14.1-HBase-1.3-bin.tar.gz

bash-4.4# mv phoenix-4.14.1-HBase-1.3-server.jar /hbase/lib/
bash-4.4# mv phoenix-core-4.14.1-HBase-1.3.jar /hbase/lib/
mv phoenix-4.14.1-HBase-1.3-queryserver.jar /hbase/bin

8765 端口对外开放

https://www.cnblogs.com/linbingdong/p/5832112.html
```







参考:

https://www.jianshu.com/p/dc4ec7f4feae

http://phoenix.apache.org/installation.html

https://www.cnblogs.com/frankdeng/p/9536450.html

[Hbase里zookeeper配置](https://blog.csdn.net/xx1710/article/details/66967804)

[Phoenix客户端配置](https://dxysun.com/2018/09/11/HBaseForPhoenix/)



java.io.IOException: Could not find my address: master in list of ZooKeeper quorum servers

http://lsr1991.github.io/2015/03/26/hbase-installation-guide/

java.net.UnknownHostException: f640d6053229: f640d6053229: Name does not resolve

https://stackoverflow.com/questions/6484275/java-net-unknownhostexception-invalid-hostname-for-server-local



[Hbase和zk的关系](https://www.2bowl.info/hbase%E4%B8%8Ezookeeper%E4%B9%8B%E9%97%B4%E7%9A%84%E5%85%B3%E7%B3%BB/)

Hbase里的Zookeeper的端口2181转换为宿主机的端口



iptables -t nat -A  DOCKER -p tcp --dport 2182 -j DNAT --to-destination 172.17.0.2:2181



[docker 给容器加端口映射](https://stackoverflow.com/questions/19335444/how-do-i-assign-a-port-mapping-to-an-existing-docker-container)

[zookeeper运维](https://www.hollischuang.com/archives/1208)






[HBase namespace常用操作](https://blog.csdn.net/opensure/article/details/46470969)

[HBase namespace含义](https://stackoverflow.com/questions/34129079/namespace-in-hbase)

[HBase书籍](http://hbase.apache.org/book.html#client)

[HBase 图形化管理界面](https://community.hortonworks.com/questions/47798/hbase-graphical-client.html)

[awesome hbase](https://github.com/rayokota/awesome-hbase)

[cherry](http://docs.cherrypy.org/en/latest/tutorials.html)

[HBase 删表](https://www.tutorialspoint.com/hbase/hbase_delete_data.htm)

[docker 查看 启动命令](https://stackoverflow.com/questions/27380641/see-full-command-of-running-stopped-container-in-docker)





参考:

[docker kafka](https://www.cnblogs.com/yxlblogs/p/10115672.html)

[kafka Doc](https://kafka.apache.org/quickstart)


[docker logs日志记录](https://www.ibm.com/developerworks/community/blogs/132cfa78-44b0-4376-85d0-d3096cd30d3f/entry/Docker_%E5%A6%82%E4%BD%95%E6%94%AF%E6%8C%81%E5%A4%9A%E7%A7%8D%E6%97%A5%E5%BF%97%E6%96%B9%E6%A1%88_%E6%AF%8F%E5%A4%A95%E5%88%86%E9%92%9F%E7%8E%A9%E8%BD%AC_Docker_%E5%AE%B9%E5%99%A8%E6%8A%80%E6%9C%AF_88?lang=en)



# python docker

https://docs.google.com/presentation/d/10vFQfEUvpf7qYyksNqiy-bAxcy-bvF0OnUElCOtTTRc/edit#slide=id.p

https://github.com/Fewbytes/rubber-docker


# docker 网络

https://docs.docker.com/compose/compose-file/compose-file-v3/#network_mode

https://docs.docker.com/compose/compose-file/compose-file-v3/#driver-1

## docker 设置静态ip

https://stackoverflow.com/questions/61949319/docker-compose-giving-static-ip-in-network-mode-bridge

https://blog.csdn.net/weixin_43931625/article/details/108059916


# dokcer namespace

- UTS namespace
UTS(UNIX Time-sharing System)namespace提供了主机名与域名的隔离，这样每个docke容器就可以拥有独立的主机名和域名了，在网络上可以被视为一个独立的节点，而非宿主机上的一个进程。docker中，每个镜像基本都以自身所提供的服务名称来命名镜像的hostname，且不会对宿主机产生任何影响，其原理就是使用了UTS namespace.


- 进程间通信(Inter-Process Communication，IPC)涉及的IPC资源包括常见的信号量、消息队列和共享内存。申请IPC资源就申请了一个全局唯一的32位ID，所以IPC namespace中实际上包含了系统IPC标识符以及实现POSIX消息队列的文件系统。在同一个IPC namespace下的进程彼此可见，不同IPC namespace下的进程则互相不可见。
目前使用IPC namespace机制的系统不多，其中比较有名的有PostgreSQL。Docker当前也使用IPC namespace实现了容器与宿主机、容器与容器之间的IPC隔离。

- PID namespace
PID namespace隔离非常实用，它对进程PID重新标号，即两个不同namespace下的进程可以有相同的PID。每个PID namespace都有自己的计数程序。内核为所有的PID namespace维护了一个树状结构，最顶层的是系统初始时创建的，被称为root namespace，它创建的心PID namespace被称为child namespace(树的子节点)，洱源县的PID namespace就是新创建的PID namespace的parent namespace(树的父节点)。通过这种方式，不同的PID namespace会形成一个层级体系。所属的父节点可以看到子节点中的进程，并可以通过信号等方式对子节点中的进程产生影响。



http://www.yunweipai.com/34731.html

https://www.cnblogs.com/sammyliu/p/5878973.html