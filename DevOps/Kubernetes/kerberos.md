# kerberos 认证

Kerberos 是一种基于加密 Ticket 的身份认证协议。Kerberos 主要由三个部分组成：Key Distribution Center (即KDC)、Client 和 Service。

客户端会先访问两次KDC，然后再访问目标Service，如：HTTP服务。

Key Distribution Center（即 KDC）, 是 Kerberos 的核心组件，主要由三个部分组成：

- Kerberos Database: 包含了一个 Realm 中所有的 principal、密码与其他信息。（默认：Berkeley DB）
- Authentication Service(AS): 进行用户信息认证，为客户端提供 Ticket Granting Tickets(TGT)。
- Ticket Granting Service(TGS): 验证 TGT 与 Authenticator，为客户端提供 Service Tickets。

https://zhuanlan.zhihu.com/p/266491528

http://www.h3c.com/cn/d_201309/922101_30005_0.htm

# flink on k8s

https://www.infoq.cn/article/TK7f60T0Kbt82Oh0mka5