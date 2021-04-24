
# pyspider

https://blog.csdn.net/lang_niu/article/details/104501473

# scrapy 发送post请求

https://stackoverflow.com/questions/17625053/how-to-send-post-data-in-start-urls-of-the-scrapy-spider

# django + scrapy 的步驟

http://www.xefan.com/archives/83887.html


https://blog.csdn.net/weixin_37719937/article/details/103591108

https://blog.csdn.net/ITcainiaoyizhan/article/details/86020564

# scrapy 框架总结

https://www.jianshu.com/p/cecb29c04cd2

scrapy-redis 原理

https://mp.weixin.qq.com/s/dDrHA41-9_hdAbXvzXUBKg

https://mp.weixin.qq.com/s/D4NaqB9zUyPjkiwY3fnvlw

## scrapy redis 去重
https://mp.weixin.qq.com/s/P9qUMxRTS1ER8mYhJzyzhw

https://github.com/LiuXingMing/Scrapy_Redis_Bloomfilter

https://cloud.tencent.com/developer/article/1421475

https://blog.csdn.net/Bone_ACE/article/details/54139500

https://blog.csdn.net/Bone_ACE/article/details/53099042

## crawlab

https://github.com/crawlab-team/crawlab/blob/master/README-zh.md

https://demo-pro.crawlab.cn/#/home


# dns-prefetch

https://developer.mozilla.org/en-US/docs/Web/Performance/dns-prefetch

# datax 做数据处理

https://github.com/alibaba/DataX


# crawlab

```
version: '3.3'
services:
  master: 
    image: tikazyq/crawlab:latest
    container_name: master
    environment:
      CRAWLAB_SERVER_MASTER: "Y"
      CRAWLAB_MONGO_HOST: "mongo"
      CRAWLAB_REDIS_ADDRESS: "redis"
    ports:    
      - "8080:8080"
    depends_on:
      - mongo
      - redis
  mongo:
    image: mongo:latest
    restart: always
    ports:
      - "27017:27017"
  redis:
    image: redis:latest
    restart: always
    ports:
      - "6379:6379"
```

git clone https://github.com/crawlab-team/crawlab.git

docker-compose -f docker-compose.local.yml up -d

https://github.com/crawlab-team/crawlab/blob/master/README-zh.md

# 布隆过滤器 

https://gaoconghui.github.io/2018/07/%E5%B8%83%E9%9A%86%E8%BF%87%E6%BB%A4%E5%99%A8%E6%89%A9%E5%AE%B9%E4%BB%A5%E5%8F%8A%E5%88%A0%E9%99%A4%E8%BF%87%E6%9C%9F%E6%95%B0%E6%8D%AE/

https://www.git2get.com/av/97160448.html

# 增量爬取
https://www.zhihu.com/question/19793879


https://github.com/BetaCatPro/Joint-spiders


# 爬虫智能限速

scrapy 爬虫配置

```sh
#===>第二部分：并发与延迟<===
#1、下载器总共最大处理的并发请求数,默认值16
CONCURRENT_REQUESTS = 120

#2、每个域名能够被执行的最大并发请求数目，默认值8
CONCURRENT_REQUESTS_PER_DOMAIN = 16
```

https://www.cnblogs.com/longyunfeigu/p/9494408.html

## 队列爬取设置

因为scrapy使用的是后进先出队列，基本可以看成是深度优先（DFO）。如果需要设置广度优先（BFO），可以在settings中添加以下代码。另外当DEPTH_PRIORITY为正值时越靠广度优先，负值则越靠深度优先，默认值为0

settings中设置方法

```sh
DEPTH_PRIORITY = 1
SCHEDULER_DISK_QUEUE = 'scrapy.squeues.PickleFifoDiskQueue'
SCHEDULER_MEMORY_QUEUE = 'scrapy.squeues.FifoMemoryQueue'
```

https://www.jianshu.com/p/ee6eaabdde0e