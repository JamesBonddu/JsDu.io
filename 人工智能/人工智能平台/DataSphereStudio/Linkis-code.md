# linkis

## linkis httpclient

用scala写的一个http服务发现负载均衡的请求器.

```scala
def build(): ClientConfig = new ClientConfig(serverUrl,
// 服务发现
discoveryEnabled, discoveryPeriod, discoveryTimeUnit, 
// 负载均衡
loadbalancerEnabled, loadbalancerStrategy, 
// 认证和链接重试
authenticationStrategy, connectTimeout, readTimeout, maxConnection, retryEnabled, retryHandler, authTokenKey, authTokenValue)
```

## 登录验证

```scala
import java.util.concurrent.ConcurrentHashMap
  private val userNameToAuthentications = new ConcurrentHashMap[String, Authentication]()
  def login(requestAction: Action, serverUrl: String): Authentication = {
    val key = getKey(requestAction, serverUrl)
    if(key == null) return null
    if(userNameToAuthentications.containsKey(key) && !isTimeout(userNameToAuthentications.get(key))) {
      val authenticationAction = userNameToAuthentications.get(key)
      authenticationAction.updateLastAccessTime()
      authenticationAction
    } else key.intern() synchronized {
      var authentication = userNameToAuthentications.get(key)
      if(authentication == null || isTimeout(authentication)) {
        authentication = tryLogin(requestAction, serverUrl)
        userNameToAuthentications.put(key, authentication)
      }
      authentication
    }
  }
```

## ConcurrentHashMap

并发容器
HashMap 底层是基于 数组 + 链表 组成的.

ConcurrentHashMap 采用了分段锁技术，其中 Segment 继承于 ReentrantLock。不会像 HashTable 那样不管是 put 还是 get 操作都需要做同步处理，理论上 ConcurrentHashMap 支持 CurrencyLevel (Segment 数组数量)的线程并发。每当一个线程占用锁访问一个 Segment 时，不会影响到其他的 Segment。

https://crossoverjie.top/2018/07/23/java-senior/ConcurrentHashMap/