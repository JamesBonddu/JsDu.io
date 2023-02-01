# Spring Boot

## 启动命令
```sh
# config name是maven中指定的name
mvn -f pom.xml spring-boot:run -Dspring.config.name=mall-tiny
```

https://github.com/ityouknow/awesome-spring-boot

http://www.ityouknow.com/springboot/2019/02/27/most-star-spring-boot.html

http://www.ityouknow.com/spring-boot.html

http://springboot.fun/

https://spring.io/projects/spring-boot

## spring boot启动流程

https://www.cnblogs.com/theRhyme/p/11057233.html

https://segmentfault.com/a/1190000022119546

https://www.cnblogs.com/theRhyme/p/how-does-springboot-start.html

https://chenjiabing666.github.io/2020/11/20/SpringBoot%E5%90%AF%E5%8A%A8%E6%B5%81%E7%A8%8B%E6%BA%90%E7%A0%81%E5%88%86%E6%9E%90/

## spring bean生命周期

https://github.com/crossoverJie/JCSprout/blob/master/MD/spring/spring-bean-lifecycle.md

## spring aop

从静态代理中可以看出: 静态代理只能代理一个具体的类，如果要代理一个接口的多个实现的话需要定义不同的代理类。

需要解决这个问题就可以用到 JDK 的动态代理。

其中有两个非常核心的类:

java.lang.reflect.Proxy类。
java.lang.reflect.InvocationHandler接口。
Proxy 类是用于创建代理对象，而 InvocationHandler 接口主要你是来处理执行逻辑。

https://github.com/crossoverJie/JCSprout/blob/master/MD/SpringAOP.md


##  Spring Boot使用一个全局的配置文件 application.yml
- application.properties
- application.yml
配置文件一般放在src/main/resources目录或者类路径/config下，当然还有很多位置可
以放，它们会有不同优先级，后面会讲到。

application.yml的常用配置项

https://docs.spring.io/spring-boot/docs/current/reference/html/application-properties.html


## spring boot 配置Eureka、Ribbon和Feign

Feign是一款Java语言编写的HttpClient绑定器，在Spring Cloud微服务中用于实现微服务之间的声明式调用。
Feign是一个声明式的web service客户端，它使得编写web service客户端更为容易。创建接口，为接口添加注解，即可使用Feign。Feign可以使用Feign注解或者JAX-RS注解，还支持热插拔的编码器和解码器。Spring Cloud为Feign添加了Spring MVC的注解支持，并整合了Ribbon和Eureka来为使用Feign时提供负载均衡。

Ribbon 作为负载均衡，在客户端实现，服务段可以启动两个端口不同但servername一样的服务
Ribbon是Netflix发布的开源项目，主要功能是提供客户端的软件负载均衡算法，将Netflix的中间层服务连接在一起。Ribbon客户端组件提供一系列完善的配置项如连接超时，重试等。简单的说，就是在配置文件中列出Load Balancer后面所有的机器，Ribbon会自动的帮助你基于某种规则（如简单轮询，随机连接等）去连接这些机器。我们也很容易使用Ribbon实现自定义的负载均衡算法。简单地说，Ribbon是一个客户端负载均衡器。
Ribbon工作时分为两步：第一步先选择 Eureka Server, 它优先选择在同一个Zone且负载较少的Server；第二步再根据用户指定的策略，在从Server取到的服务注册列表中选择一个地址。其中Ribbon提供了多种策略，例如轮询、随机、根据响应时间加权等。

Hystrix作为熔断流量控制，在客户端实现，在方法上注解，当请求出错时可以调用注解中的方法返回
Hystrix熔断器，容错管理工具，旨在通过熔断机制控制服务和第三方库的节点,从而对延迟和故障提供更强大的容错能力。在Spring Cloud Hystrix中实现了线程隔离、断路器等一系列的服务保护功能。它也是基于Netflix的开源框架 Hystrix实现的，该框架目标在于通过控制那些访问远程系统、服务和第三方库的节点，从而对延迟和故障提供更强大的容错能力。Hystrix具备了服务降级、服务熔断、线程隔离、请求缓存、请求合并以及服务监控等强大功能。

Springboot 整合 SpringCloud组件-Feign(Ribbon/Hystrix)

https://blog.csdn.net/qq_35387940/article/details/94569189


https://www.cnblogs.com/crazymakercircle/p/11664812.html

https://www.iocoder.cn/Ribbon/laoyuan/spring-cloud-feign-and-ribbon/


https://juejin.cn/post/6844904151483154446

## Spring data 提供和数据源相关的库

https://spring.io/projects/spring-data

## Spring cloud 提供分布式开发的工具

Spring Cloud 为开发者提供了快速构建分布式系统中一些常见模式的工具（例如配置管理、服务发现、断路器、智能路由、微代理、控制总线、一次性令牌、全局锁、领导选举、分布式会话、集群状态）。分布式系统的协调导致了样板模式，使用 Spring Cloud 开发人员可以快速建立实现这些模式的服务和应用程序。它们将适用于任何分布式环境，包括开发人员自己的笔记本电脑、裸机数据中心和托管平台（如 Cloud Foundry）。


> Spring Cloud Data Flow

Spring Cloud Data Flow 提供了为流和批处理数据管道创建复杂拓扑的工具。数据管道由使用Spring Cloud Stream或Spring Cloud Task微服务框架构建的Spring Boot应用程序组成。

Spring Cloud Data Flow 支持一系列数据处理用例，从 ETL 到导入/导出、事件流和预测分析。
Spring Flo 是一个 JavaScript 库，它为管道和简单图形提供了一个基本的可嵌入 HTML5 可视化构建器。该库用作Spring Cloud Data Flow中流构建器的基础。

Flo 包括集成流设计器的所有基本元素，例如连接器、控制节点、调色板、状态转换和图形拓扑——重要的是，有一个文本外壳、DSL 支持和一个图形画布，用于创建和审查综合工作流.

> Spring Shell

Spring Shell 项目的用户可以通过依赖 Spring Shell jar 并添加自己的命令（作为 spring bean 的方法）轻松构建功能齐全的 shell（又名命令行）应用程序。创建命令行应用程序可能很有用，例如与项目的 REST API 交互，或处理本地文件内容。

> Spring Statemachine

Spring Statemachine 是应用程序开发人员在 Spring 应用程序中使用状态机概念的框架。

# spring boot 项目结构

这在《阿里巴巴Java开发手册》中倒是做了一个所谓的严格区分，那本书上是这样去定义的：

- DO（Data Object）：与数据库表结构一一对应，通过DAO层向上传输数据源对象。
- DTO（Data Transfer Object）：数据传输对象，Service或Manager向外传输的对象。
- BO（Business Object）：业务对象。由Service层输出的封装业务逻辑的对象。
- AO（Application Object）：应用对象。在Web层与Service层之间抽象的复用对象模型，极为贴近展示层，复用度不高。
- VO（View Object）：显示层对象，通常是Web向模板渲染引擎层传输的对象。
- Query：数据查询对象，各层接收上层的查询请求。注意超过2个参数的查询封装，禁止使用Map类来传输。
老实讲，看到这么多对象的定义，我也是很蒙的。实际项目开发时，我觉得没有必要刻意照搬去定义这么多层对象，这样后续做对象转换工作都能烦skr人。

https://zhuanlan.zhihu.com/p/115403195

https://segmentfault.com/a/1190000022259581

# spring boot
https://gitee.com/52itstyle/spring-boot-pay

## 怎么启动关闭

https://www.cnblogs.com/linkstar/p/9815097.html

## spring boot 的yaml配置

https://www.baeldung.com/spring-boot-yaml-vs-properties#:~:text=Using%20application.yml%20vs%20application.properties%20in%20Spring%20Boot%201,4%20Spring%20Boot%20Usage.%20...%205%20Conclusion.%20

https://howtodoinjava.com/spring-boot2/logging/configure-logging-application-yml/

https://blog.csdn.net/An1090239782/article/details/106187110

##  自定义错误处理

https://thepracticaldeveloper.com/custom-error-handling-rest-controllers-spring-boot/


# mybatis

https://mybatis.org/mybatis-3/zh/index.html


https://mybatis.org/mybatis-3/zh/configuration.html

通过xml映射文件简化语句

https://mybatis.org/mybatis-3/zh/sqlmap-xml.html

动态SQL

https://mybatis.org/mybatis-3/zh/dynamic-sql.html

# spring boot Docker
http://www.ityouknow.com/springboot/2018/04/02/docker-favorites.html

# spring框架的核心概念

https://www.cnblogs.com/xiaoxing/p/5836835.html

# springboot核心概念

从全局上看，Spring 是Bean容器（Core Container），提供Bean的管理，支持不同类型的Context实现（例如基于XML配置与Annotation配置、Application场景与Web 场景）；在Bean容器的基础上，通过面向切面编程（AOP）技术与消息机制进行更多场景的支持，例如数据访问、Web服务等。

## Spring--IoC(Inversion of Control) 控制反转和DI(Dependency Injection)依赖注入

Spring的IoC容器在实现控制反转和依赖注入的过程中,可以划分为两个阶段:

- 容器启动阶段
- bean实例化阶段

IoC容器及IoC容器如何获取对象间的依赖关系
Spring中提供了两种IoC容器：

- BeanFactory
- ApplicationContext

https://segmentfault.com/a/1190000038367647

https://mijack.github.io/%E7%90%86%E8%A7%A3spring%E7%B3%BB%E5%88%97/2020/06/14/What-is-the-inversion-of-control/

理解spring 系列

https://mijack.github.io/%E7%90%86%E8%A7%A3spring%E7%B3%BB%E5%88%97/2020/06/07/understanding-spring-preface/

## AOP的理解

https://juejin.cn/post/6959094175216173087

## springboot 中的核心容器

Spring全家桶大家都很熟悉了，从原来的SpringMVC到现在的SpringBoot。核心容器包括了Beans、Core、Context、SpEL。

- core和beans模块提供了整个框架最基础的部分，包括了IOC和DI。
- Context建立在Core和Beans模块提供的基础之上：他提供了框架式访问对象的方式
- core、beans、context构成了Spring的骨架
- SpEL:提供了一种强大的用于在运行时操作对象的表达式语言

https://www.cnblogs.com/gongchenglion/articles/11674598.html


# spring web security

WebSecurityConfigurerAdapter

https://cloud.tencent.com/developer/article/1670933

https://stackoverflow.com/questions/31995221/correct-use-of-websecurity-in-websecurityconfigureradapter


## spring security 登录流程

https://mp.weixin.qq.com/s?__biz=MzI1NDY0MTkzNQ==&mid=2247488026&idx=2&sn=3bd96d91e822abf753a8e91142e036be&scene=21#wechat_redirect

# spring 设置上传文件大小

```java
spring.http.multipart.max-file-size=10MB # 单个文件
spring.http.multipart.max-request-size=10MB # 单次请求，例如一个请求有多文件
```

https://blog.csdn.net/enthan809882/article/details/115626183

# 异常处理

@RestControllerAdvice作用及原理
如果全部异常处理返回json，那么可以使用 @RestControllerAdvice 代替 @ControllerAdvice ，这样在方法上就可以不需要添加 @ResponseBody。


异常处理方式一. @ExceptionHandler
异常处理方式二. 实现HandlerExceptionResolver接口
异常处理方式三. @ControllerAdvice+@ExceptionHandler

https://www.cnblogs.com/lvbinbin2yujie/p/10574812.html

https://www.cnblogs.com/UncleWang001/p/10949318.html


# springSecurity 多种登录方式

网上用的比较多的方式是UserDetailsService方案，这种方案难以实现多种登录方式。本文用Filter+Manager+Provider+Token的方案实现多种登录方式。

jeecg-boot默认带的是JwtFilter

https://juejin.cn/post/6914959662529904653

同一用户同一角色的不同登录方式支持
shiro realm

CustomShiroFilter
ShiroConfig

https://blog.csdn.net/zhourenfei17/article/details/88826911

https://greenhathg.github.io/2019/09/02/SpringBoot+Shiro+Jwt%E5%A1%AB%E5%9D%91-1/


## 同一用户的多种登录方式 JWT + Shiro

用户名 + 手机号登录使用shiro realm支持


spring security 支持同一用户多种登录方式

JWT 需要支持多种用户token方式
根据loginType决定登录方式

https://www.ruanyifeng.com/blog/2018/07/json_web_token-tutorial.html

https://segmentfault.com/a/1190000042038695

https://www.shouxicto.com/article/2179.html

https://blog.csdn.net/cckevincyh/article/details/79629022


### 在 Shiro 配置多Realm 可以通过如下两种方式：

方式一 在 ModularRealmAuthenticator 中配置多个Realm
方式一 在 SecurityManager 中配置多个Realm

https://github.com/pengjunlee/coder_source/blob/d0af669fbf23e3cbd68b8231ad8bfa72ac326931/source/_posts/%E5%AE%89%E5%85%A8%E6%A1%86%E6%9E%B6/Shiro%E8%AE%A4%E8%AF%81%E9%AB%98%E7%BA%A7%E9%85%8D%E7%BD%AE.md

https://github.com/yiminyangguang520/shiro-sample/blob/2309424461d213764c84a39454d1397cf1e97015/spring-boot-shiro-mulit-realm-app-sample/src/main/java/com/lee/config/ShiroConfig.java

https://github.com/Kevin091827/kevin_blog/blob/29ea5447793f2d86b46076f7830a53be22a94353/shiro/shiro%E5%AD%A6%E4%B9%A0%E7%AC%94%E8%AE%B0%EF%BC%88%E5%9B%9B%EF%BC%89.md

https://github.com/Kevin091827/kevin_blog/blob/29ea544779/shiro/shiro%E5%AD%A6%E4%B9%A0%E7%AC%94%E8%AE%B0%EF%BC%88%E4%B8%80%EF%BC%89.md

### shiro

https://www.iocoder.cn/Spring-Boot/Shiro/

https://developer.aliyun.com/article/844718

https://blog.csdn.net/leisure_life/article/details/104697225

手机号登陆直接走登陆认证, 验证用户是否存在之后直接进行jwt认证颁发token

```java
/**
    * 手机号登录接口
    *
    * @param jsonObject
    * @return
    */
@ApiOperation("手机号登录接口")
@PostMapping("/phoneLogin")
public Result<JSONObject> phoneLogin(@RequestBody JSONObject jsonObject) {
    Result<JSONObject> result = new Result<JSONObject>();
    String phone = jsonObject.getString("mobile");

    //校验用户有效性
    SysUser sysUser = sysUserService.getUserByPhone(phone);
    result = sysUserService.checkUserIsEffective(sysUser);
    if (!result.isSuccess()) {
        return result;
    }

    String smscode = jsonObject.getString("captcha");
    Object code = redisUtil.get(phone);
    if (!smscode.equals(code)) {
        result.setMessage("手机验证码错误");
        return result;
    }
    //用户信息
    userInfo(sysUser, result);
    //添加日志
    baseCommonService.addLog("用户名: " + sysUser.getUsername() + ",登录成功！", CommonConstant.LOG_TYPE_1, null);

    return result;
}


/**
    * 用户信息
    *
    * @param sysUser
    * @param result
    * @return
    */
private Result<JSONObject> userInfo(SysUser sysUser, Result<JSONObject> result) {
    String syspassword = sysUser.getPassword();
    String username = sysUser.getUsername();
    // 生成token
    String token = JwtUtil.sign(username, syspassword);
    // 设置token缓存有效时间
    redisUtil.set(CommonConstant.PREFIX_USER_TOKEN + token, token);
    redisUtil.expire(CommonConstant.PREFIX_USER_TOKEN + token, JwtUtil.EXPIRE_TIME * 2 / 1000);

    // 设置 redis: key=token, value=userInfo
    HashMap<String, String> userInfo = new HashMap<>();
    List<String> role = sysUserService.getRole(username);
    userInfo.put("id", sysUser.getId());
    userInfo.put("username", sysUser.getUsername());
    userInfo.put("realname", sysUser.getRealname());
    userInfo.put("role", role.get(0));

    String userInfoStr = JSON.toJSONString(userInfo);

    redisUtil.set(token, userInfoStr);
    System.out.println(userInfoStr);
    redisUtil.expire(token, JwtUtil.EXPIRE_TIME * 2 / 1000);

    // 获取用户部门信息
    JSONObject obj = new JSONObject();
    List<SysDepart> departs = sysDepartService.queryUserDeparts(sysUser.getId());
    obj.put("departs", departs);
    if (departs == null || departs.size() == 0) {
        obj.put("multi_depart", 0);
    } else if (departs.size() == 1) {
        sysUserService.updateUserDepart(username, departs.get(0).getOrgCode());
        obj.put("multi_depart", 1);
    } else {
        //查询当前是否有登录部门
        // update-begin--Author:wangshuai Date:20200805 for：如果用戶为选择部门，数据库为存在上一次登录部门，则取一条存进去
        SysUser sysUserById = sysUserService.getById(sysUser.getId());
        if (oConvertUtils.isEmpty(sysUserById.getOrgCode())) {
            sysUserService.updateUserDepart(username, departs.get(0).getOrgCode());
        }
        // update-end--Author:wangshuai Date:20200805 for：如果用戶为选择部门，数据库为存在上一次登录部门，则取一条存进去
        obj.put("multi_depart", 2);
    }
    obj.put("token", token);
    obj.put("userInfo", sysUser);
    obj.put("sysAllDictItems", sysDictService.queryAllDictItems());
    result.setResult(obj);
    result.success("登录成功");
    return result;
}


@Bean("securityManager")
public DefaultWebSecurityManager securityManager() {
    ...
    /*
    * 关闭shiro自带的session，详情见文档
    * http://shiro.apache.org/session-management.html#SessionManagement-
    * StatelessApplications%28Sessionless%29
    */
    DefaultSubjectDAO subjectDAO = new DefaultSubjectDAO();
    DefaultSessionStorageEvaluator defaultSessionStorageEvaluator = new DefaultSessionStorageEvaluator();
    defaultSessionStorageEvaluator.setSessionStorageEnabled(false);
    subjectDAO.setSessionStorageEvaluator(defaultSessionStorageEvaluator);
    securityManager.setSubjectDAO(subjectDAO);
    //自定义缓存实现,使用redis
    securityManager.setCacheManager(redisCacheManager());
}

// 认证的token

/**
 * @Author Scott
 * @create 2018-07-12 15:19
 * @desc
 **/
public class JwtToken implements AuthenticationToken {

	private static final long serialVersionUID = 1L;
	private String token;
    private String loginType;

    public JwtToken(String token) {
        this.token = token;
    }

    public JwtToken(String token, String loginType) {
        this.token = token;
        this.loginType = loginType;
    }

    @Override
    public Object getPrincipal() {
        return token;
    }

    @Override
    public Object getCredentials() {
        return token;
    }
}


/**
 * @Description: 鉴权登录拦截器
 * @Author: Scott
 * @Date: 2018/10/7
 **/
@Slf4j
public class JwtFilter extends BasicHttpAuthenticationFilter {
}



/**
ShiroRealm 主要功能是, 实现用户认证和实现权限认证.

添加MyShiroRealm并继承AuthorizingRealm，实现其中的两个方法。
doGetAuthenticationInfo：实现用户认证，通过服务加载用户信息并构造认证对象返回。
doGetAuthorizationInfo：实现权限认证，通过服务加载用户角色和权限信息设置进去。
*/
@Component
@Slf4j
public class ShiroRealm extends AuthorizingRealm {

}

// 认证完成后可以通过获取Subject获取到当前登陆用户.
// 1.根据当前用户过滤(当前用户), 2.根据流程状态过滤(未提交流程)
LoginUser sysUser = (LoginUser) SecurityUtils.getSubject().getPrincipal();



// 通过JwtFilter过滤器
@Slf4j
public class JwtFilter extends BasicHttpAuthenticationFilter {
/**
    *
    */
@Override
protected boolean executeLogin(ServletRequest request, ServletResponse response) throws Exception {
    HttpServletRequest httpServletRequest = (HttpServletRequest) request;
    String token = httpServletRequest.getHeader(CommonConstant.X_ACCESS_TOKEN);
    // TODO: jsdu添加登录类型字段辅助多用户表,多登录方式登录
    String loginType = httpServletRequest.getHeader(CommonConstant.LOGIN_TYPE);

    // update-begin--Author:lvdandan Date:20210105 for：JT-355 OA聊天添加token验证，获取token参数
    if(token == null){
        token = httpServletRequest.getParameter("token");
    }
    // update-end--Author:lvdandan Date:20210105 for：JT-355 OA聊天添加token验证，获取token参数


    // realm登录
    JwtToken jwtToken = new JwtToken(token, loginType);
    // 提交给realm进行登入，如果错误他会抛出异常并被捕获
    getSubject(request, response).login(jwtToken);
    // 如果没有抛出异常则代表登入成功，返回true
    return true;
}
```

## 不同用户表登录支持

https://blog.csdn.net/qq_26383975/article/details/109462695

https://blog.csdn.net/u012702547/article/details/107330001

sa-token认证框架

https://github.com/dromara/sa-token
