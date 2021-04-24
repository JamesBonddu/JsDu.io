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


<<<<<<< HEAD:数据库/Redis/redis.md

# python 操作redis


redis.setex('jsdu', 10000,'are you ok')
redis.get('jsdu')

https://realpython.com/python-redis/

https://redis-py.readthedocs.io/en/stable/

# 命名规范

https://developer.aliyun.com/article/531067
https://club.perfma.com/article/210671

# redis key 多长

embstr

https://mp.weixin.qq.com/s?spm=a2c6h.12873639.0.0.753b1feeSHhrXx&__biz=Mzg2NTEyNzE0OA==&mid=2247483663&idx=1&sn=7c4ad441eaec6f0ff38d1c6a097b1fa4&chksm=ce5f9e8cf928179a2c74227da95bec575bdebc682e8630b5b1bb2071c0a1b4be6f98d67c37ca&scene=21#wechat_redirect

https://blog.csdn.net/XiyouLinux_Kangyijie/article/details/78045385

http://redisbook.com/preview/object/string.html

转化cache key

```python
def make_cache_key(*args, **kwargs):
    path = request.path
    args = str(hash(frozenset(request.args.items())))
    lang = get_locale()
    return (path + args + lang).encode('utf-8')
```

https://stackoverflow.com/questions/9413566/flask-cache-memoize-url-query-string-parameters-as-well

# redis cache

https://rednafi.github.io/digressions/python/database/2020/05/25/python-redis-cache.html

https://flask-caching.readthedocs.io/en/latest/ 

https://wizardforcel.gitbooks.io/flask-extension-docs/content/flask-cache.html

https://stackoverflow.com/questions/14228985/what-does-key-prefix-do-for-flask-cache

使用自己的cache_key
https://stackoverflow.com/questions/9413566/flask-cache-memoize-url-query-string-parameters-as-well/14264116#14264116

flask_cache 的key
https://github.com/sh4nks/flask-caching/blob/5eef6738430a6887fce03552cb2438501e3dc741/flask_caching/__init__.py


# 制作一个 redis

https://redis.io/topics/protocol

http://charlesleifer.com/blog/building-a-simple-redis-server-with-python/

If you use CLOCK-Pro algorithm with (or instead) dictionary. Then you'll get cache functionality, which will evict least needed data on overflow. 
https://bitbucket.org/SamiLehtinen/pyclockpro

LIRS 缓存算法
https://en.wikipedia.org/wiki/LIRS_caching_algorithm


# redis GEO

GEOADD Sicily 13.36666 38.116666 2
ZREM restaurants Falafel

https://luoming1224.github.io/2019/04/08/[redis%E5%AD%A6%E4%B9%A0%E7%AC%94%E8%AE%B0]redis%E4%B8%ADGeo%E5%91%BD%E4%BB%A4%E4%BB%8B%E7%BB%8D/


https://stackoverflow.com/questions/39253946/how-to-remove-an-item-from-a-redis-geohash


# redis 的key设计

https://blog.csdn.net/babykakaluo/article/details/9822381

https://blog.codingnow.com/2011/11/dev_note_2.html

https://cloud.tencent.com/developer/article/1551803

https://my.oschina.net/u/3266761/blog/4559530

## redis 分页排序查询

https://www.cnblogs.com/michaeldonghan/p/12184975.html

https://liu-xin.me/2015/11/17/%E5%9C%A8Redis%E4%B8%AD%E8%BF%9B%E8%A1%8C%E5%88%86%E9%A1%B5%E6%8E%92%E5%BA%8F%E6%9F%A5%E8%AF%A2/


redis 分页查询

https://github.com/zatosource/zato-redis-paginator


http://xiaorui.cc/archives/6192

redis更新分数
```python
from flask import current_app
from sqlalchemy import func

from cache.statistic import UserArticleCountStorage, UserFollowingsCountStorage, UserFansCountStorage
from models import db
from models.news import Article


def __fix_statistic(cls):
    try:
        # 先到mysql中查询数据
        ret = cls.db_query()
        # 校正redis数据
        cls.reset(ret)
    except BaseException as e:
        current_app.logger.error(e)
        raise e


def fix_statistic(app):
    """修正统计数据"""

    with app.app_context():

        # 校正所有用户的作品数量
        __fix_statistic(UserArticleCountStorage)

        # 校正所有用户的关注数量
        __fix_statistic(UserFollowingsCountStorage)

        # 校正所有用户的分析数量
        __fix_statistic(UserFansCountStorage)

from flask import current_app
from redis import StrictRedis, RedisError
from sqlalchemy import func

from models import db
from models.news import Article


class BaseCountStorage:
    """统计基类"""
    key = ''

    @classmethod
    def get(cls, user_id):
        """
        获取指定用户的统计数

        :param user_id: 指定的用户
        :return: 统计数量
        """
        redis = current_app.redis_slave  # type: StrictRedis
        try:
            # 取指定用户的分值
            count = redis.zscore(cls.key, user_id)
        except RedisError as e:
            current_app.logger.error(e)
            raise e

        if count:
            return int(count) if int(count) > 0 else 0
        else:
            return 0

    @classmethod
    def incr(cls, user_id):
        """给指定的用户的统计数量+1"""
        redis = current_app.redis_master  # type: StrictRedis
        try:
            redis.zincrby(cls.key, user_id)
        except RedisError as e:
            current_app.logger.error(e)
            raise e
#   核心逻辑封装到这里(提示1)
    @classmethod
    def reset(cls, db_query_ret):
        """重置数据"""

        # 删除redis中的数据
        pipe = current_app.redis_master.pipeline(transaction=False)
        pipe.delete(cls.key)

        # 将mysql中的数据写入redis
        for user_id, count in db_query_ret:
            pipe.zadd(cls.key, count, user_id)

        pipe.execute()  # 批量发送给redis


class UserArticleCountStorage(BaseCountStorage):
    """用户作品数量统计类

    count:user:arts  zset  [{value: 用户id, score: 作品数}, {}]
    """
    key = 'count:user:arts'  # 设置键
    
# mysql的查询封装到这里(提示2)
    @classmethod
    def db_query(cls):
        return db.session.query(Article.user_id, func.count(Article.id)).filter(
            Article.status == Article.STATUS.APPROVED).group_by(Article.user_id).all()


class UserFollowingsCountStorage(BaseCountStorage):
    """用户关注数量统计类

    count:user:followings  zset  [{value: 用户id, score: 关注数}, {}]
    """
    key = 'count:user:followings'  # 设置键
# mysql的查询封装到这里(提示3)
    @classmethod
    def db_query(cls):
        return db.session.query(Article.user_id, func.count(Article.id)).filter(
            Article.status == Article.STATUS.APPROVED).group_by(Article.user_id).all()


class UserFansCountStorage(BaseCountStorage):
    """用户粉丝数量统计类
    count:user:fans  zset  [{value: 用户id, score: 粉丝数}, {}]
    """
    key = 'count:user:fans'  # 设置键
# mysql的查询封装到这里(提示4)
    @classmethod
    def db_query(cls):
        return db.session.query(Article.user_id, func.count(Article.id)).filter(
            Article.status == Article.STATUS.APPROVED).group_by(Article.user_id).all()
```
https://blog.csdn.net/Jack_yun_feng/article/details/96205519


## redis 书籍核心概念

https://redislabs.com/ebook/part-2-core-concepts/chapter-3-commands-in-redis/3-5-sorted-sets/

## 标签设计

https://gakkil.gitee.io/2019/01/02/redis-zhong-key-de-she-ji-ji-qiao/

## 点赞排行榜

https://www.mdeditor.tw/pl/gfCP


Redis 基础、高级特性与性能调优


https://learnku.com/articles/25070

## django redis 存储

https://realpython.com/caching-in-django-with-redis/

## redis 删除zset中的item

相关SSDB-API
zrange：zrange name offset limit，根据下标索引区间 [offset, offset + limit) 获取 key-score 对, 下标从 0 开始. zrrange 是反向顺序获取.（注意! 本方法在 offset 越来越大时, 会越慢!）

zkeys：zkeys name key_start score_start score_end limit，列出 zset 中的 key 列表

zscan：zscan name key_start score_start score_end limit，列出 zset 中处于区间 (key_start+score_start, score_end] 的 key-score 列表. 如果 key_start 为空, 那么对应权重值大于或者等于 score_start 的 key 将被返回. 如果 key_start 不为空, 那么对应权重值大于 score_start 的 key, 或者大于 key_start 且对应权重值等于 score_start 的 key 将被返回.也就是说, 返回的 key 在 (key.score == score_start && key > key_start || key.score > score_start), 并且key.score <= score_end 区间. 先判断 score_start, score_end, 然后判断 key_start._，("", “”] 表示整个区间.

zclear：zclear name，删除 zset 中的所有 key.

zremrangebyscore：zremrangebyscore name start end，删除权重处于区间 [start,end] 的元素.

zremrangebyrank：zremrangebyrank name start end，删除位置处于区间 [start,end] 的元素.

zdel：zdel name key，获取 zset 中的指定 key.

multi_zdel ：multi_zdel name key1 key2 …，批量删除 zset 中的 key.

https://blog.csdn.net/u014654002/article/details/105289288

=======
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
>>>>>>> c2a1203da667ebeb9f0cd68b9a536f88b9e69f7c:缓存/Redis/redis.md
