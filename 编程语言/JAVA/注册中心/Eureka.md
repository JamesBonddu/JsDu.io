# Eureka

服务发现的目标是要抽象程序标识并对程序状态进行动态管理。一旦涉及到管理，我们第一个想到的是什么？集权、集中、统一，设置一个机构等等。Eureka 也是如此，要管理这些程序，先要有一个统一的管理中心，这个统一的管理中心就是--注册中心。

## 服务的注册与发现

微服务独立部署、具有清晰的边界，服务之间通过远程调用来构建复杂的业务功能。那为什么要引用服务注册与发现呢？服务注册与发现具体要解决什么问题？
1）屏蔽，解耦服务之间相互依赖的细节
2）对微服务进行动态管理


理清服务端、客户端、生产者，消费者四个基本概念



将注册中心作为服务发现中的管理者是个不错的主意。就像公司一样，从职责上对员工进行划分，比如：出钱的--老板，找活干的--产品经理，监督干活的--项目经理，正真干活的--程序员，背锅的--初级程序员。



为了理解沟通方便，服务发现对管理者与非管理者也进行了划分，负责管理的注册中心--服务端，负责具体完成任务的程序--客户端，这就是服务器端与客户端的概念。



通过服务端与客户端的概念，从职责上对程序进行了区分，但是，对于具体干活的客户端，还有一个问题：那就是它们之间的调用关系错综复杂，能不能从调用关系这个维度对客户端再进行区分呢？



答案是肯定的，因此，对于客户端又分为生产者，消费者的概念。例如，一个任务需要两个程序协调合作，程序 A 调用程序 B，调用方也就是程序 A 叫--消费者，被调用方也就是程序 B 叫--生产者。


我将 Eureka 基本运行流程抽象为七个步骤，当然这七个步骤并不是严格的顺序执行，更不是官方的说法，只是让我们更好的理解 Eureka 的工作流程，这 7 个步骤分别如下：

1、客户端发起服务注册；

2、服务端保存信息至注册表；

3、客户端定时发送心跳请求；

4、服务端服务剔除与自我保护

5、客服端发送服务下线请求

6、客户端获取服务端注册表；

7、客户端整合服务发现；


https://xie.infoq.cn/article/e4c9866b723b7c4f9cc272050

https://thepracticaldeveloper.com/spring-boot-service-discovery-eureka/

服务注册与发现

- Eureka Server：提供服务注册和发现
- Service Provider：服务提供方，将自身服务注册到Eureka，从而使服务消费方能够找到
- Service Consumer：服务消费方，从Eureka获取注册服务列表，从而能够消费服务。

https://www.cnblogs.com/qdhxhz/p/9357502.html


https://xie.infoq.cn/article/c6139a5776e139d1b76b2e856


## ds replicas是什么

https://blog.csdn.net/u012817635/article/details/80189579

https://lw900925.github.io/spring-cloud/spring-cloud-eureka.html


# 单独的服务注册到eureka

CAP理论是分布式架构中重要理论


一致性(Consistency) (所有节点在同一时间具有相同的数据)


可用性(Availability) (保证每个请求不管成功或者失败都有响应)


分隔容忍(Partition tolerance) (系统中任意信息的丢失或失败不会影响系统的继续运作)

作者：程序开发者社区
链接：https://juejin.cn/post/6858052002094514189
来源：稀土掘金
著作权归作者所有。商业转载请联系作者获得授权，非商业转载请注明出处。

https://juejin.cn/post/6858052002094514189


https://blog.csdn.net/u014320421/article/details/78272678/

https://blog.csdn.net/liuying1802028915/article/details/105031626


单独服务注册到多个eureka中心

https://blog.csdn.net/kingwinstar/article/details/119348444

https://spring-cloud-alibaba-group.github.io/github-pages/hoxton/zh-cn/index.html
