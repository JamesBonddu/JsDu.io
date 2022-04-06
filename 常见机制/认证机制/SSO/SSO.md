# Single Sign on
单系统登录解决方案的核心是cookie，cookie携带会话id在浏览器与服务器之间维护会话状态。但cookie是有限制的，这个限制就是cookie的域（通常对应网站的域名），浏览器发送http请求时会自动携带与该域匹配的cookie，而不是所有cookie

既然这样，为什么不将web应用群中所有子系统的域名统一在一个顶级域名下，例如“*.baidu.com”，然后将它们的cookie域设置为“baidu.com”，这种做法理论上是可以的，甚至早期很多多系统登录就采用这种同域名共享cookie的方式。

然而，可行并不代表好，共享cookie的方式存在众多局限。首先，应用群域名得统一；其次，应用群各系统使用的技术（至少是web服务器）要相同，不然cookie的key值（tomcat为JSESSIONID）不同，无法维持会话，共享cookie的方式是无法实现跨语言技术平台登录的，比如java、php、.net系统之间；第三，cookie本身不安全。

因此，我们需要一种全新的登录方式来实现多系统应用群的登录，这就是单点登录

阿里云支持基于SAML 2.0和OIDC的SSO（Single Sign On，单点登录），也称为身份联合登录。本文为您介绍企业如何使用自有的身份系统实现与阿里云的SSO。

SSO 的实现机制大体分为 Cookie 机制和 Session 机制两大类。

目前好点的开源单点登录产品 CAS（Central Authentication Service）就是采用 Cookie 机制。CAS 最早由耶鲁大学开发。2004年12月，CAS 成为 JA-SIG 中的一个项目。JA-SIG 全称是 Java Architectures Special Interest Group。CAS 的优点，如配置简单、客户端支持广泛、技术成熟等。

CAS 涉及 5 种票据： TGC 、 ST 、 PGT 、 PGTIOU 、 PT 。Ticket-granting cookie（TGC），是存放用户身份认证凭证的 cookie ，在浏览器和 CAS Server 间通讯时使用，并且只能基于 Https，是 CAS Server 用来明确用户身份的凭证；Service ticket（ST），是服务票据，服务的惟一标识码 , 由 CAS Server 通过 HTTP 发出，通过客户端浏览器到达业务服务器端。一个特定的服务只能有一个惟一的 ST； Proxy-Granting ticket（PGT），是由 CAS Server 颁发给拥有 ST 凭证的服务， PGT 绑定一个用户的特定服务，使其拥有向 CAS Server 申请，获得 PT 的能力； Proxy-Granting Ticket I Owe You（PGTIOU），是将通过凭证校验时的应答信息由 CAS Server 返回给 CAS Client ，同时，与该 PGTIOU 对应的 PGT 将通过回调链接传给 Web 应用。Web 应用负责维护 PGTIOU 与 PGT 之间映射关系的内容表； Proxy Ticket（PT），是应用程序代理用户身份对目标程序进行访问的凭证。


https://www.alibabacloud.com/help/zh/doc-detail/110499.htm

https://developer.aliyun.com/article/636281

https://cloud.tencent.com/developer/article/1166255

https://www.cnblogs.com/liuning8023/p/4874525.html



# CAS 开源实现

https://apereo.github.io/cas/6.4.x/index.html

https://www.jianshu.com/p/5a1eed54fe54

https://github.com/kawhii/sso

https://jbone.cn/guide/

https://www.cnblogs.com/liboware/p/12528573.html

https://bbs.huaweicloud.com/blogs/detail/296226

https://www.javaboy.org/2020/0605/springsecurity-cas-mysql.html

https://blog.csdn.net/xy140450/article/details/91872731

https://blog.csdn.net/weixin_42629433/article/details/84312660

# 华为one access

https://support.huaweicloud.com/bestpractice-oneaccess/oneaccess_05_0312.html

## SSO CAS

https://blog.csdn.net/javaloveiphone/article/details/52439613


Guava Cache

CacheBuilder.weigher(Weigher) 按权重来回收，CacheBuilder.maximumWeight(long)指定最大总权重。CacheBuilder.maximumSize(long)，CacheBuilder.maximumWeight(long)是互斥的，只能二选一。
expireAfterAccess(long, TimeUnit):缓存项在给定时间内没有被读/写访问 来回收

TGT:用来存储登入用户身份的的重要票据，一旦用户成功登入到CAS服务器后，CAS服务器就会生成一个TGT,并存储在CAS服务器端。最为重要的是确保TGT是全局唯一的
TGC:是一个存储TGT的Cookie。当登入到CAS服务器后，CAS会在浏览器中存储它，这样下次登入时传回CAS服务器进行登入验证，只有借助Https传输通道，TGC才会被传回CAS服务器


ServerWebExchange
ServerWebExchange的注释： ServerWebExchange是一个HTTP请求-响应交互的契约。提供对HTTP请求和响应的访问，并公开额外的服务器端处理相关属性和特性，如请求属性。

其实，ServerWebExchange命名为服务网络交换器，存放着重要的请求-响应属性、请求实例和响应实例等等，有点像Context的角色。

https://blog.csdn.net/z595746437/article/details/89322403

https://segmentfault.com/a/1190000038697460

https://www.cnblogs.com/fdzang/p/11812348.html

https://mp.weixin.qq.com/s/fYAM85_JVNpmj7uo8jFbNQ

https://mp.weixin.qq.com/s/uoGbw7Gffn2nkVmoqUWDUQ


# SSO CAS 流程

CAS官网上的标准流程，具体流程如下：

用户访问app系统，app系统是需要登录的，但用户现在没有登录。
跳转到CAS server，即SSO登录系统，以后图中的CAS Server我们统一叫做SSO系统。 SSO系统也没有登录，弹出用户登录页。
用户填写用户名、密码，SSO系统进行认证后，将登录状态写入SSO的session，浏览器（Browser）中写入SSO域下的Cookie。
SSO系统登录完成后会生成一个ST（Service Ticket），然后跳转到app系统，同时将ST作为参数传递给app系统。
app系统拿到ST后，从后台向SSO发送请求，验证ST是否有效。
验证通过后，app系统将登录状态写入session并设置app域下的Cookie。


1. CAS 基础协议执行步骤如下：
2) 访问服务：用户发送请求访问应用系统（可称为CAS客户端）提供的受保护的服务资源。
3) 重定向认证：CAS客户端分析HTTP请求中没有Service Ticket（即ST）或SessionID，说明用户
还没有进行身份认证。于是，重定向用户请求到CAS服务器进行身份认证，并把用户此次访问CAS客户端的URL作为参
数（service）传递给CAS服务器。
3) 用户认证：CAS服务器接收到身份认证请求后转向登录页面，用户提供认证信息后进行身份认
证。身份认证成功后，CAS服务器以SSL方式给浏览器返回一个TGC（用户身份信息凭证，用于以后获取ST）。
4) 发放票据：CAS服务器会产生一个随机的ST，然后重定向到CAS客户端。
5) 验证票据：CAS客户端收到ST后，向CAS服务器验证票据ST的合法性，验证通过后，允许用户访
问客户端服务。
6) 传输用户信息：CAS服务器验证票据ST通过后，传输用户认证结果信息给客户端。

————————————————
版权声明：本文为CSDN博主「好好生活_」的原创文章，遵循CC 4.0 BY-SA版权协议，转载请附上原文出处链接及本声明。
原文链接：https://blog.csdn.net/hu_zhiting/article/details/64443773

## 认证代码

src/main/java/com/webank/wedatasphere/exchangis/auth/AuthController.java

认证TK
modules/exchangis-executor/data/token/server.tk




Service ticket（ST），是服务票据，服务的惟一标识码
src/main/java/com/webank/wedatasphere/exchangis/common/auth/scheduler/ServTokenRefresh.java


- AuthenticationInterceptor 认证拦截器
验证token, 触发更新token
登录认证未通过时sendRedirect跳转到
```java
private void sendRedirect(HttpServletRequest request, HttpServletResponse response) throws IOException {
    StringBuilder redirectBuilder = new StringBuilder();
    String loginUrl = conf.authLoginUrl();
    redirectBuilder.append(loginUrl);
    if(conf.authCasSwitch()) {
        //Append CAS parameters
        redirectBuilder.append("?")
                .append(SSO_REDIRECT_SERVICE + "=").append(URLEncoder.encode(conf.gatewayUrl(), "UTF-8"));
        if (StringUtils.isNotBlank(conf.casSystemId())) {
            redirectBuilder.append("&" + SSO_REDIRECT_SYSTEMID + "=").append(conf.casSystemId());
        }
    }
```

SSO CAS 认证的首次登陆, 例如，原始应用的地址是 http://www.itil.com/，转向 CAS 服务器的单点登录页面 https://secure.oa.com/cas/login?service=http://www.itil.com/auth.aspx；

src/main/java/com/webank/wedatasphere/exchangis/common/auth/interceptors/AuthenticationInterceptor.java

- 首次登陆cookie中不包含默认的SSO的cookie`UM-SSO-BDP`, 返回用户名,密码登陆页面.
- 输入用户名密码进行跳转登陆, 登陆成功在cookie中记录 `UM-SSO-BDP`,并在response中返回服务票证 Service
Ticket（即ST）或SessionID {"X-AUTH-ID": "admin"}
  - auth认证-login
  src/main/java/com/webank/wedatasphere/exchangis/auth/AuthController.java
  用户传递username, password到server端,server端返回X_AUTH_ID为userName {"X-AUTH-ID": "admin"}
```json
{"code":0,"data":{"userType":2,"updateTime":"2021-12-23 17:28:26","createTime":"2021-12-23 17:28:26","role":"super","X-AUTH-ID":"admin"},"message":"success"}
```
src/main/java/com/webank/wedatasphere/exchangis/gateway/auth/AuthEntranceFilter.java
```java
if(response.getCode() == 0) {
    Map<String, String> jsonMap = response.getData();
    String loginId = jsonMap.getOrDefault(AuthConstraints.X_AUTH_ID, "");
    if (StringUtils.isNotBlank(loginId)) {
        AuthTokenBean tokenBean = new AuthTokenBean();
        tokenBean.getHeaders().put(AuthConstraints.X_AUTH_ID, loginId);
        tokenBean.getHeaders().put(AuthConstraints.HOST_PORT,
                String.format("%s:%s", InetAddress.getLocalHost().getHostAddress() , serverPort));
        tokenBean.getClaims().putAll(jsonMap);
        String token = tokenBuilder.build(tokenBean);
        addCookie(ResponseCookie.from(DEFAULT_SSO_COOKIE, token)
                .path("/").httpOnly(true).secure(false)
                .maxAge(Duration.ofDays(1)).build());
        LOG.info("Add token: " + token.substring(0, 6) + "**** to login response");
    }
}
```
设置客户端的TGC cookie, cookie的编码规则在Ticket-granting cookie（TGC），是存放用户身份认证凭证的 cookie ，在浏览器和 CAS Server 间通讯时使用，并且只能基于 Https，是 CAS Server 用来明确用户身份的凭证；
src/main/java/com/webank/wedatasphere/exchangis/common/auth/AuthTokenHelper.java
```java
String time = format.format(Calendar.getInstance().getTime());
headers.put(AuthConstraints.SSO_TOKEN_TIMESTAMP, time);
String alg = headers.get(AuthTokenBean.ALG_NAME);
Base64.Encoder encoder = Base64.getEncoder();
String self = encoder.encodeToString(Objects.requireNonNull(Json.toJson(headers, Map.class)).getBytes(DEFAULT_CHARSET))
        + PART_SPLIT + encoder.encodeToString(Objects.requireNonNull(Json.toJson(claims, Map.class)).getBytes(DEFAULT_CHARSET));
builder.append(self).append(PART_SPLIT);
AuthTokenBean.Type type = AuthTokenBean.Type.of(alg);
String auth = getAuthString(type, tokenSecret +self, time);
```
- CAS服务器会产生一个随机的ST，然后重定向到CAS客户端。

```java
String body = authTokenService.refreshServerToken(authConfiguration.authTokenServRefreshId(),
        authConfiguration.authTokenServRefreshPwd());
if(StringUtils.isNotBlank(body)){
    System.setProperty(AuthConstraints.ENV_SERV_TOKEN, body);
    LOG.info("Get Token:" + body.substring(0, 12) + "*******");
    String storePath = authConfiguration.authTokenServRefreshStore();
    if(StringUtils.isNotBlank(storePath) && !storePath.equals(TOKEN_NO_STORE_FLAG)){
        storeToken(body, storePath);
        System.setProperty(AuthConstraints.ENV_SERV_TOKEN_PATH, storePath);
    }
}
```

- 通过客户端的cookie中包含的token, 验证并取出其中的token, 同之前加密规则处理后的cookie进行结果对比.

ok = authTokenHelper.validate(token, conf.tokenInvalid());

- 认证token信息通过, 返回用户的信息
```java
String token = AppUtil.getCookieValue(request, AuthConstraints.DEFAULT_SSO_COOKIE);
Map<String, String> message = new HashMap<>(2^4);
if(null != token){
    message = authTokenHelper.getAuthMessage(token);
}
String username = message.get("loginid");
UserInfo user = userInfoService.selectByUsername(username);
```
src/main/java/com/webank/wedatasphere/exchangis/auth/AuthController.java


# cas client实现


https://my.oschina.net/u/4504531/blog/4864868

https://www.cnblogs.com/eguid/p/6821622.html

https://github.com/apereo/java-cas-client


https://laravelacademy.org/post/9775


https://blog.csdn.net/u010475041/article/details/78094251

# cas 单点登录

《CAS单点路上的风风雨雨》

1. 下载与编译
 下载地址：https://github.com/apereo/cas-overlay-template
  建议选择5.2.6版本，高版本cas有jdk要求
 此版本自带tomcat，打出的war包在Mac或者linux上可以通过java -jar启动
 maven仓库地址建议改为默认，虽然慢点，但是所有依赖都能下载到
2. 目录权限
 注意/etc目录有可能是指向/private/etc目录，在/etc目录下操作是没有权限的，通过添加用户组并给用户赋权，或者修改log4j2的baseDir和application.yml的server.ssl.key-store的值
3. 生成keystore以供tomcat配置https访问
 命令：keytool -genkeypair -alias cas -keyalg RSA -keysize 2048 -keypass changeit -storepass changeit -keystore /etc/cas/thekeystore -dname "CN=cas.example.org,OU=liuyx.com,O=liuyx,L=JiNan,ST=JiNan,C=CN"
4. 改为从数据库读取用户
5. 给客户端的jre添加和服务端对应的证书（证书库的密码是：changeit）
 生成证书：keytool -exportcert -alias cas -keystore /etc/cas/thekeystore -file /etc/cas/keystore.cer -storepass changeit
 导入证书：keytool -import -alias cas -keystore /Library/Java/JavaVirtualMachines/jdk1.8.0_181.jdk/Contents/Home/jre/lib/security/cacerts -file /etc/cas/keystore.cer
 查询证书：keytool -list -keystore /Library/Java/JavaVirtualMachines/jdk1.8.0_181.jdk/Contents/Home/jre/lib/security/cacerts ( | grep cas)
 删除证书：keytool -delete -alias cas -keystore  /Library/Java/JavaVirtualMachines/jdk1.8.0_181.jdk/Contents/Home/jre/lib/security/cacerts

https://dacurry-tns.github.io/deploying-apereo-cas/building_server_install-and-test-the-cas-application.html

http://blog.felixfly.top/2019/07/08/Cas/CAS%E4%B9%8B%E6%9C%8D%E5%8A%A1%E7%AB%AF/

https://cloud.tencent.com/developer/ask/65479

## keytool使用方法

https://www.cnblogs.com/xdp-gacl/p/3750965.html


# SSO REST

https://apereo.github.io/cas/6.1.x/installation/Rest-Authentication.html

https://github.com/apereo/cas/blob/master/docs/cas-server-documentation/protocol/REST-Protocol.md


https://blog.csdn.net/u010475041/article/details/78442603


https://chayedankase.github.io/2020/01/30/CASRestful/

https://www.xncoding.com/2019/01/05/security/cas03.html

http://www.ibloger.net/article/3120.html

https://github.com/X-rapido/CAS_SSO_Record

http://www.ibloger.net/article/3053.html

http://www.ibloger.net/article/3135.html


https://mp.weixin.qq.com/s/HM4tvrf5kVpA4lUx04k3Ng

https://apereo.atlassian.net/wiki/spaces/CASUM/overview

# CAS Server 配置文件介绍

Cas Server 中所有的配置文件都是放在 WEB-INF 目录及其子目录下的。

- 在 WEB-INF/classes 下的配置文件有：
- cas-theme-default.properties：该文件存放的是 css 文件的路径，用户可以在这里指定使用的 css 文件为自定义的 css 文件，也可以更改配置文件中对应的 css 文件已更改默认的样式。
- 系列 messages_*.properties：国际化支持对应的资源文件。
- default_views.properties 和 protocol_views.properties：Cas Server 中使用到的视图配置文件，用于定义对应视图的处理类及其文件路径。
- log4j.xml：log4j 的配置文件。
- 在 WEB-INF 根目录下的配置文件有：
- web.xml：这个文件就是大伙熟悉的 web.xml 文件。
- cas-servlet.xml：该文件是 Cas Server 使用到的 Spring MVC 的配置文件，里面定义了一些 Controller 及 View 相关的内容。
- cas.properties：该文件是 Cas Server 配置的主要文件。与 Spring 相关的所有配置使用的外部属性都定义在这个文件中。
- deployerConfigContext.xml：该文件是专为 Cas Server 部署人员抽取出来的一个文件，其中的内容通常都是 Cas Server 部署人员需要进行更改的内容。
- login-webflow.xml：登录使用到的 Spring Web Flow 配置文件。
- restlet-servlet.xml：使用到的 Restful API 的相关配置。
- WEB-INF/spring-configuration：该目录中存放的是 Cas Server 加载的 Spring 相关的配置文件。
- WEB-INF/unused-spring-configuration：该目录中存放的是没有用到，但是有需要时可以将它们 copy 到 spring-configuration 目录下的文件。
- 在 WEB-INF/spring-configuration 目录下的配置文件是 Cas Server 中使用到的所有与 Spring 相关的配置文件，具体有：
- applicationContext.xml：该文件中定义了主要使用的 bean，通常不需要修改。
- argumentExtractorsConfiguration.xml：该文件中定义了需要使用的协议，默认只有 CAS 和 SAML 是可用的。
- log4jConfiguration.xml：log4j 初始化对应的配置。
- propertyFileConfigure.xml：用于指定外部属性文件的位置，默认指定的就是前面提到的 cas.properties 文件。
- securityContext.xml：这是 Cas Server 中使用到的 Spring Security 相关内容的配置文件，默认不需要进行修改。
- ticketExpirationPolicies.xml：用于指定 TicketGranting Ticket 和 Service Ticket 的过期策略，一般不需要修改。
- ticketGrantingTicketCookieGenerator.xml：TicketGranting Ticket 对应的 CookieGenerator 的配置。
- ticketRegistry.xml：DefaultTicketRegistry 对应的配置。
- uniqueIdGenerators.xml：唯一主键生成相关的配置。
- warnCookieGenerator.xml：用于生成警告的 CookieGenerator 对应配置。


## sso-client



拦截子系统未登录用户请求，跳转至sso认证中心

接收并存储sso认证中心发送的令牌

与sso-server通信，校验令牌的有效性

建立局部会话

拦截用户注销请求，向sso认证中心发送注销请求

接收sso认证中心发出的注销请求，销毁局部会话



## sso-server



验证用户的登录信息

创建全局会话

创建授权令牌

与sso-client通信发送令牌

校验sso-client令牌有效性

系统注册

接收sso-client注销请求，注销所有会话



接下来，我们按照原理来一步步实现sso吧！


## 如何添加cas service

service的存储方式有以下几种：
1、InMemoryServiceRegistryDaoImpl
2、JsonServiceRegistryDao
3、JpaServiceRegistryDaoImpl：如果启用了oauth，因为每一个第三方都被认为是一个service，最好存储在数据库中，管理方便
4、MongoServiceRegistryDao

cas默认配置是使用InMemoryServiceRegistryDaoImpl，当然JsonServiceRegistryDao也比较常见

原文链接：https://blog.csdn.net/matthewei6/article/details/50700278

https://blog.csdn.net/pyycsd/article/details/102803177

https://apereo.github.io/cas/6.4.x/services/Service-Management.html

## 客户端如何验证ST

cas ticke验证方式大体上讲有2个体系：

AbstractTicketValidationFilter，基于Filter的ticket的验证；
AbstractUrlBasedTicketValidator，基于TicketValidator的验证；

https://blog.csdn.net/l714417743/article/details/107846942

https://www.cnblogs.com/Jeely/p/11949637.html

https://mp.weixin.qq.com/s/_B_4YbKEsjNUd_hGDGHFAA

## node 集成cas

https://nickma1986.github.io/homeblog/CAS/


## CAS 客户端 验证ST票据超时

https://blog.csdn.net/zhmz1326/article/details/52279740?locationNum=3


# 使用cas-overlay-template搭建cas服务器

https://segmentfault.com/a/1190000013728604?utm_source=tag-newest




已经解决了，原因是：CAS Server自带的REST API，仅支持默认UsernamePasswordCredential，我的项目中自定义扩展了UsernamePasswordCredential，所以需要在自定义验证Handler中做个判断，如果请求的Credential类型为org.apereo.cas.authentication.UsernamePasswordCredential, 就是REST请求来的，直接返回对应的UsernamePasswordCredential对象即可。

https://segmentfault.com/q/1010000015419288


service行为配置

https://blog.csdn.net/Anumbrella/article/details/82119246


# 自定义认证方式[添加验证码之类]

https://blog.csdn.net/u010475041/article/details/78420322

https://blog.csdn.net/zhouzhiwengang/article/details/97926358


跨域问题

https://blog.csdn.net/u011943534/article/details/118462857


# 代理认证

https://www.youcl.com/info/2261

# TGT的存储位置

https://apereo.github.io/cas/6.0.x/ticketing/Configuring-Ticketing-Components.html

TGT默认的存储位置

https://apereo.github.io/cas/6.0.x/ticketing/Default-Ticket-Registry.html

https://blog.csdn.net/qq_21355765/article/details/106692154


# 过期策略

```json
{
  "@class" : "org.apereo.cas.services.RegexRegisteredService",
  "serviceId" : "^https://.+",
  "name" : "sample service",
  "id" : 100,
  "expirationPolicy": {
    "@class": "org.apereo.cas.services.DefaultRegisteredServiceExpirationPolicy",
    "deleteWhenExpired": true,
    "notifyWhenDeleted": false,
    "expirationDate": "2017-10-05"
  }
}
```

https://apereo.github.io/cas/6.0.x/services/Configuring-Service-Expiration-Policy.html

# 流程

## 申请票证

Request a Service Ticket

```sh
POST /cas/v1/tickets/{TGT id} HTTP/1.0

service={form encoded parameter for the service url}
```

```sh
curl --location --request POST 'http://192.168.203.130:8443/cas/v1/tickets' \
--header 'Content-Type: application/x-www-form-urlencoded' \
--header 'Cookie: TGC=eyJhbGciOiJIUzUxMiJ9.ZXlKNmFYQWlPaUpFUlVZaUxDSmhiR2NpT2lKa2FYSWlMQ0psYm1NaU9pSkJNVEk0UTBKRExVaFRNalUySW4wLi42cnd3SUNSZk1VdDM3SVVZeVlzYXVnLnhTVWxNeVlOM2FyTkdRalFya19iMGxvUEY4Nmhhc1BrMTVnd3RGajJVY1F0d0p0RHpUU1hCN29iSW9BSW42NklsNkYwVXNvMDBIU1ZzU0w0cTNYcGpWb1NJclo5SzVoUUEzM3dVT2dlMWJ5SzNXbEFlZG9RY0JlS3ZLT25oNmgzc3V6dVN4ZkFxNzJIVTVnT2w0eEU0ZXl0ZlczckN3RmZCY29aTkVUei1DR2htSGFJN240VDVEenJUbVgxYTN0Y0Yxaml0WHptMVJjVV82RHZwSTE5R3dWaUFmaGFrRFNNR0dNNDVBWFlDR3N6WVBUd3VPQXVEMDM0WXBGRmFtWVAuc1NOSjZwU2NHMngwM3U2ckNmbVItUQ==.U2XRyKMfuPntM6PCdMx38-SHp-x5dJCTWX3K4CGYIjRtkcFNUN_GoFId_ISfbpJSKtMnniRkmUe9Tm4fmSdFvQ' \
--data-urlencode 'username=admin' \
--data-urlencode 'password=admin' \
--data-urlencode 'service=http://192.168.203.130:9503/api/v1/cas/login'
```


# web.xml

https://blog.csdn.net/believejava/article/details/43229361

## 验证service 票证 ST
Validate Service Ticket
```sh
GET /cas/p3/serviceValidate?service={service url}&ticket={service ticket}
```

https://cloud.tencent.com/developer/article/1750698



# 自定义验证逻辑

https://blog.csdn.net/weixin_43549578/article/details/91865185

# cookie解析

https://blog.csdn.net/ghsau/article/details/20395681

# 源码解读

https://www.jianshu.com/p/a44014bc461f
