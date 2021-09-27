
https://blog.lirui.me/posts/1dfe7706/

https://cloud.tencent.com/developer/article/1340036

[docker kafka](https://www.cnblogs.com/yxlblogs/p/10115672.html)

[kafka Doc](https://kafka.apache.org/quickstart)


# kafka客户端

https://github.com/confluentinc/confluent-kafka-python

https://github.com/dpkp/kafka-python

scrapy + kafka 链接

https://jacky-wangjj.github.io/2019/05/Scrapy_Kafka_MongoDB/

scrapy 布隆过滤器

https://my.oschina.net/u/4349237/blog/3504754


## kafka常用命令

https://blog.csdn.net/laoyang360/article/details/79028851

kafka创建topic

https://matt33.com/2017/07/21/kafka-topic-create/


kafka创建topic

```sh
bin/kafka-topics.sh --create --zookeeper localhost:2181 --replication-factor 1 --partitions 1 --topic spiderpolicy

kafka-topics --create --zookeeper zoo1:2181 --replication-factor 1 --partitions 1 --topic spiderpolicy

kafka-topics --delete --zookeeper zoo1:2181 --topic spider_policy

# 执行爬虫命令
dc exec --workdir=/opt/server/crawler app scrapy crawl nj_policy -a area=all

dc exec redis redis-cli

root@t20-develop:/opt/guide# dc exec redis redis-cli
127.0.0.1:6379> keys *
1) "nj_policy:bloomfilter"
127.0.0.1:6379> del "nj_policy:bloomfilter"


docker-compose restart app
dc -f docker-compose.yml  up -d

```

https://kafka.apache.org/documentation/

# kafka集群监控
滴滴kafka manager

https://github.com/didi/Logi-KafkaManager

conduktor 的kafka客户端

https://www.conduktor.io/download/


# 实时数仓-mysql业务数据采集到kafka的ODS层(Canal+Protobuf+Kafka)

https://blog.csdn.net/weixin_43861104/article/details/112554951


命名规范： ODS 层实时数据源主要包括两种。



一种是在离线采集时已经自动生产的 DDMQ 或者是 Kafka topic，这类型的数据命名方式为采集系统自动生成规范为：cn-binlog-数据库名-数据库名 eg：cn-binlog-ihap_fangyuan-ihap_fangyuan

一种是需要自己进行采集同步到 kafka topic 中，生产的 topic 命名规范同离线类似：ODS 层采用：realtime_ods_binlog_{源系统库/表名}/ods_log_{日志名} eg: realtime_ods_binlog_ihap_fangyuan




https://www.infoq.cn/article/6yeuobfmgmvlztdvpjnz


## ODS数据层搭建

https://www.taodudu.cc/news/show-2127303.html

# kafka可视化工具 eagle

https://mp.weixin.qq.com/s/V3niDxdT_PiTbru80UGz4A

# 滴滴Logi-KafkaManager

https://github.com/didi/Logi-KafkaManager/issues/89