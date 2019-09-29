# Serverless

Serverless无服务器架构指的是由开发这实现的服务端逻辑运行在无状态的计算容器中,它由事件触发,完全被第三方管理, 其业务层面的状态被开发者使用的数据库和存储资源所记录.

Serverless目前还没有一个普遍公认的权威的定义。最新的一个定义是这样描述的：“无服务器架构是基于互联网的系统，其中应用开发不使用常规的服务进程。相反，它们仅依赖于第三方服务（例如AWS Lambda服务），客户端逻辑和服务托管远程过程调用的组合。”

在Serverless的世界里面，AWS扮演了一个非常重要的角色。但是AWS并不是唯一的Serverless架构服务的供应商。其他厂商，例如Google Cloud Functions、Microsoft Azure Functions、IBM OpenWhisk、Iron.io和Webtask等各种开源平台都提供了类似的服务。

Serverless架构是云的自然延伸,为了理解serverless, 回顾一下云计算的发展.

laas 本质是服务器租赁并提供基础设施外包服务.
Paas (Platform as a service)是构建在laaS上的一种平台服务,提供操作系统安装,监控和服务发现等功能, 用户只需要部署自己的应用即可,最早一代是Heroku. Paas上最广泛使用的技术就要数docker了,因为使用容器可以很清晰的描述应用程序,并保证环境一致性.

Serverless的定义, 它包含了两个领域BaaS(Backend as a Service) 和 FaaS(Function as a Service).

## Baas

BaaS后端即服务, 一般是一个个的API调用后端或别人已经实现好的程序逻辑,比如身份验证服务Auth0, 这些BaaS通常会用来管理数据.

## FaaS

FaaS(Function as a Service)函数即服务, FaaS是无服务器计算的一种形式,目前使用最广泛的是AWS的Lambada(AWS仍然只会向您收取代码的执行时间，无论它需要启动多少个容器实例要满足你的负载请求。例如，假设所有事件的总执行时间是相同的，在一个容器中按顺序调用Lambda 100次与在100个不同容器中同时调用100次Lambda的成本是 一样的。当然AWS Lambada也不会无限制的扩展实例个数，如果有人对你发起了DDos攻击怎么办，那么不就会产生高昂的成本吗？AWS是有默认限制的，默认执行Lambada函数最大并发数是1000). 它本质上是一种事件驱动的由消息触发的服务,FaaS供应商一般会集成各种同步和异步的事件源.

FaaS函数通常被描述为无状态，但更准确地说，需要持久化的FaaS函数的任何状态都需要在FaaS函数实例之外进行外部化。


https://martinfowler.com/articles/serverless.html

https://serverless.ink/

https://aws.amazon.com/cn/blogs/china/iaas-faas-serverless/

https://jimmysong.io/posts/what-is-serverless/

https://github.com/rootsongjc/awesome-cloud-native

https://serverless.com/
