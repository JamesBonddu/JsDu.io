# Redis

Redis 作者曾经笑称Redis是一个数据结构服务器(data structures server).

## Redis的常见数据类型及其操作接口

- strings 类型及其操作

类型:

```c
struct sdshdr  {
    long len;
    long free;
    char buff[];
};
```

操作:
```sh
# 设置key对应的值为string类型的value
set name JSDu

# nx是not exist的意思, 若name这个key已经存在则返回0
setnx name JSDu0

# 设置skycolor=blue键值对,并设定其有效期是10秒
setex skycolor 10 blue

# setrange 设置指定key的字串, 由qq换为gmail邮箱
set email jsdu@qq.com

setrange email 4 gmail.com

# mset 一次设置多个key的值,成功返回ok表示所有值都设置了,失败返回0表示都没有被设置
mset key1 jsdu key2 jsdu-gf

# get 获取key对应的string值, 不存在则返回nil
get name
# 一次获取多个值, 对应值存在则返回,不存在则返回nil
mget key1 key2 key3

# 增加,减少
incr age # +1
incrby age 20 #若原来值不存在则会设置key,并认为原来的value为0

decr age
decrby age 20

# strlen 获取value长度
strlen name
```

- hashes 类型及其操作

Redis hash是一个string类型的field和value的映射表. 省内存的原因是新建一个hash对象时开始是用zipmap(alias small hash)来存储的.这个zipmap其实并不是hash table, 但是zipmap相比较正常的hash实现可以节省不少hash本身需要的一些元数据的存储开销.如果field或者value的大小超出一定限制后, Redis会在内部自动将zipmap替换成正常的hash实现,这个可以在配置文件中指定;
hash-max-zipmap-entries 64 #配置字段最多64个字节
hash-max-zipmap-value 512 #配置value最多512个字节

操作:

```sh
hset myhash field1 hi
# 同时设置hash的多个field
hmset myhash field1 hi field2 JSDu
# hget 获取指定的hash field
hget myhash field1
#获取全部只当的hash field
hmget myhash field1 field2 field3

# hexists 判断指定field是否存在
hexists myhash field1

hlen myhash

# 返回指定hash的field的数量
hdel myhash field1

hkeys myhash

hvals myhash
```

- lists 类型及操作

list是以一个链表结构,主要功能是push, pop, 获取一个范围的所有值等等. 操作中key理解为链表的名字.
Redis 的list类型其实就是一个每一个子元素都是string类型的双向链表.链表最大的长度是2^32.可以作为栈或者队列.

有意思的是list的pop操作还有阻塞版本的,当我们[lr]pop一个list对象时,若list为空或不存在则返回nil.但是阻塞版本的b[lr]pop可以阻塞,当然也可以加超时后再返回nil。

阻塞版本的pop主要时为了避免轮询. 比较用list实现一个工作队列, 执行任务的thread可以调用阻塞版本的pop去获取任务,这样就可以避免轮询去检查是否有任务存在.当任务来时工作线程可以立即返回, 避免轮询带来的延迟.

- sets类型及其操作

set时集合, 操作中key理解为集合的名字.

Redis的set是string类型的无序集合.

set是通过hash table实现的,所以CRD复杂度都是O(1). hash table会所在添加或者删除自动的调整大小. 需要注意的是调整hash table大小时需要同步(获取写锁)会阻塞其他读写操作, 可能不久后会改用跳表(skip list)来实现, 跳表已经在 sorted set中使用了.

## 服务器相关命令

```sh
ping

echo

select no

quit

dbsize

info

monitor

config get dir

# 删除当前现在数据库中的所有key
flushdb

# 删除所有数据库中的key
flushall
```

## Redis 高级实用特性

主从复制

简单事务控制


参考资料:

https://redislabs.com/redis-enterprise/redis-time-series/

https://redislabs.com/redis-best-practices/

https://redisbook.readthedocs.io/en/latest/index.html

https://juejin.im/post/5d86cf7f6fb9a06b211724e7

https://stackoom.com/question/2zJ72/%E5%9C%A8%E5%88%86%E5%B1%82%E6%95%B0%E6%8D%AE%E6%A8%A1%E5%9E%8B%E4%B8%AD%E4%BD%BF%E7%94%A8Redis%E8%BF%9B%E8%A1%8C%E5%A4%8D%E5%90%88%E7%B4%A2%E5%BC%95


https://stackoverflow.com/questions/44164152/composite-indexing-using-redis-in-a-hierarchical-data-model

# 缓存


https://juejin.im/post/5b849878e51d4538c77a974a

https://tech.meituan.com/2017/03/17/cache-about.html


缓存更新套路
https://coolshell.cn/articles/17416.

https://www.objectrocket.com/blog/how-to/top-5-redis-use-cases/


# 秒杀

https://mp.weixin.qq.com/s/gWSM7tE5z-_xh0PKtDhDTg

# 浏览器缓存

https://www.jianshu.com/p/54cc04190252


# 布隆过滤器

https://perphet.com/2019/03/%E5%88%9D%E8%AF%86%E5%B8%83%E9%9A%86%E8%BF%87%E6%BB%A4%E5%99%A8-Bloom-Filiter/
