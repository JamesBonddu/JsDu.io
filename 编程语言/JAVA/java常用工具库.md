# 常用工具库


## 集合类 CollectionUtils

Commons Collections增强了Java Collections Framework。 它提供了几个功能，使收集处理变得容易。 它提供了许多新的接口，实现和实用程序。 Commons Collections的主要功能如下

Bag - Bag界面简化了每个对象具有多个副本的集合。

BidiMap - BidiMap接口提供双向映射，可用于使用值使用键或键查找值。

MapIterator - MapIterator接口提供简单而容易的迭代迭代。

Transforming Decorators - 转换装饰器可以在将集合添加到集合时更改集合的每个对象。

Composite Collections - 在需要统一处理多个集合的情况下使用复合集合。

Ordered Map - 有序地图保留添加元素的顺序。

Ordered Set - 有序集保留了添加元素的顺序。

Reference map - 参考图允许在密切控制下对键/值进行垃圾收集。

Comparator implementations - 可以使用许多Comparator实现。

Iterator implementations - 许多Iterator实现都可用。

Adapter Classes - 适配器类可用于将数组和枚举转换为集合。

Utilities - 实用程序可用于测试测试或创建集合的典型集合论属性，例如union，intersection。 支持关闭。


```java
import org.apache.commons.collections.CollectionUtils;

List<String> list1 = Arrays.asList("A","A","A","C","B","B");
List<String> list2 = Arrays.asList("A","A","B","B");

// 交集
CollectionUtils.intersection(list1, list2);

// 并集
CollectionUtils.union(list1, list2);
```
集合的交集, 并集, 补集, 差集.


https://blog.csdn.net/qidasheng2012/article/details/83383389

https://commons.apache.org/proper/commons-collections/apidocs/org/apache/commons/collections4/CollectionUtils.html

## hutool常用工具库

https://www.bookstack.cn/read/hutool/a6819f05207359bb.md

## Lombok

Project Lombok 是一个 Java 库，可自动插入您的编辑器并构建工具，为您的 Java 增添趣味。
永远不要再编写另一个 getter 或 equals 方法，通过一个注释，您的类就有一个功能齐全的构建器，自动化您的日志变量等等。

Lombok这款插件正是依靠可插件化的Java自定义注解处理API（JSR 269: Pluggable Annotation Processing API）来实现在Javac编译阶段利用“Annotation Processor”对自定义的注解进行预处理后生成真正在JVM上面执行的“Class文件”。有兴趣的同学反编译带有Lombok注解的类文件也就一目了然了

@EqualsAndHashCode

Setting callSuper to true when you don't extend anything (you extend java.lang.Object) is a compile-time error, because it would turn the generated equals() and hashCode() implementations into having the same behaviour as simply inheriting these methods from java.lang.Object: only the same object will be equal to each other and will have the same hashCode. Not setting callSuper to true when you extend another class generates a warning, because unless the superclass has no (equality-important) fields, lombok cannot generate an implementation for you that takes into account the fields declared by your superclasses. You'll need to write your own implementations, or rely on the callSuper chaining facility. You can also use the lombok.equalsAndHashCode.callSuper config key.

```java
import lombok.experimental.Accessors;
@Accessors(chain = true)
```

lombok.assessors.chain=[true|false](default:false)
如果设置为true,没有任何类被@Accessors注解，或者有类被注解但是没有为chain参数显式赋值，则表现为@Accessors(chain=true)

https://blog.csdn.net/cc_smile0702/article/details/73521878


https://projectlombok.org/features/all

https://blog.csdn.net/ThinkWon/article/details/101392808

https://blog.didispace.com/java-lombok-how-to-use/

https://projectlombok.org/features/EqualsAndHashCode



## swagger

@ApiModel @ApiModelProperty

ApiModel 注解是作用在接口相关实体类上的注解，用来对该接口相关实体类添加额外的描述信息，常常和 @ApiModelProperty 注解配合使用。

ApiModelProperty 注解是作用在接口相关实体类的参数上的注解，用来对具体的接口相关实体类中的参数添加额外的描述信息，常常和 @ApiModel 注解关联使用，有时也会单独拿出来用。

```java
@ApiModelProperty(value = "Address", name = "addLines",
    example = "[\"AddLine1\",\"AddLine2\",\"AddLine3\",\"AddLine4\"]")
```


https://stackoverflow.com/questions/40989038/swagger-apimodelproperty-example-value-for-liststring-property

https://docs.swagger.io/javadocs/swagger-core/1.3.5/annotations/com/wordnik/swagger/annotations/ApiModelProperty.html

http://www.imooc.com/wiki/swaggerlesson/apimodelproperty.html

## mybatisplus

```java
import com.baomidou.mybatisplus.annotation.TableName;
import com.baomidou.mybatisplus.annotation.IdType;
import java.util.Date;
import com.baomidou.mybatisplus.annotation.TableId;

@Data
@EqualsAndHashCode(callSuper = false)
@TableName("ums_admin")
@ApiModel(value="UmsAdmin对象", description="后台用户表")
public class UmsAdmin implements Serializable {

    private static final long serialVersionUID=1L;

    @TableId(value = "id", type = IdType.AUTO)
    private Long id;
    s
    @ApiModelProperty(value = "头像")
    private String icon;
}

import com.macro.mall.tiny.modules.ums.model.UmsAdmin;
import com.baomidou.mybatisplus.core.mapper.BaseMapper;
import org.apache.ibatis.annotations.Param;

import java.util.List;

/**
 * <p>
 * 后台用户表 Mapper 接口
 * </p>
 *
 * @author macro
 * @since 2020-08-21
 */
public interface UmsAdminMapper extends BaseMapper<UmsAdmin> {

    /**
     * 获取资源相关用户ID列表
     */
    List<Long> getAdminIdList(@Param("resourceId") Long resourceId);

}
```

model 定义数据表和字段;
mapper
dto

### mybatis plus 设置雪花算法

- ASSIGN_ID 雪花算法
- ASSIGN_UUID uuid算法
- AUTO 自增ID

```java
@Data
public class UserInfo {
    @TableId(type = IdType.ASSIGN_ID)
    private Long id;
    private String userName;
    private String passWord;
}
```

https://www.cnblogs.com/mark5/p/14268122.html

https://www.hangge.com/blog/cache/detail_2904.html


### BaseMapper 提供基础的CURD接口

BaseMapper已实现的基础CURD方法

Save 类
```java
// 插入一条记录（选择字段，策略插入）
boolean save(T entity);
// 插入（批量）
boolean saveBatch(Collection<T> entityList);
// 插入（批量）
boolean saveBatch(Collection<T> entityList, int batchSize);
```

SaveOrUpdate

```java
// TableId 注解存在更新记录，否插入一条记录
boolean saveOrUpdate(T entity);
// 根据updateWrapper尝试更新，否继续执行saveOrUpdate(T)方法
boolean saveOrUpdate(T entity, Wrapper<T> updateWrapper);
// 批量修改插入
boolean saveOrUpdateBatch(Collection<T> entityList);
// 批量修改插入
boolean saveOrUpdateBatch(Collection<T> entityList, int batchSize);
```


Update类

```java
// 根据 UpdateWrapper 条件，更新记录 需要设置sqlset
boolean update(Wrapper<T> updateWrapper);
// 根据 whereEntity 条件，更新记录
boolean update(T entity, Wrapper<T> updateWrapper);
// 根据 ID 选择修改
boolean updateById(T entity);
// 根据ID 批量更新
boolean updateBatchById(Collection<T> entityList);
// 根据ID 批量更新
boolean updateBatchById(Collection<T> entityList, int batchSize);
```

https://blog.csdn.net/u011870022/article/details/110705281


https://www.hxstrive.com/subject/mybatis_plus.htm?id=263

https://mp.baomidou.com/guide/faq.html


## mybatis-plus 通过 intercepts

拦截器、字段填充器、类型处理器、表名替换、SqlInjector(联合主键处理)

https://blog.csdn.net/sunxiaoju/article/details/109660493

https://blog.csdn.net/weixin_37703281/article/details/102751544


# JSON4S

在Scala环境下已经至少有6种Json解析的类库很用了很相似的抽象语法树(AST),而JSON4S这个项目的目标就是提供一个单一的AST树供其他Scala类库来使用。

http://kubicode.me/2015/05/24/Scala/Study-And-User-JSON4S/


# Antlr4

Antlr4（Another Tool for Language Recognition）是一款基于Java开发的开源的语法分析器生成工具，能够根据语法规则文件生成对应的语法分析器，广泛应用于DSL构建，语言词法语法解析等领域。现在在非常多的流行的框架中都用使用，例如，在构建特定语言的AST方面，CheckStyle工具，就是基于Antlr来解析Java的语法结构的（当前Java Parser是基于JavaCC来解析Java文件的，据说有规划在下个版本改用Antlr来解析），还有就是广泛应用在DSL构建上，著名的Eclipse Xtext就有使用Antlr。

https://www.cnblogs.com/huaweiyun/p/14334037.html

## AspectJ

切片和加hook类似

```java
import org.aspectj.lang.ProceedingJoinPoint;
import org.aspectj.lang.Signature;
import org.aspectj.lang.annotation.Around;
import org.aspectj.lang.annotation.Aspect;
import org.aspectj.lang.annotation.Pointcut;
import org.aspectj.lang.reflect.MethodSignature;
```

AspectJ提供了两套强大的机制:

第一套是切面语法。就是网上到处都是的那种所谓"AspectJ使用方法"，这套东西做到了将决定是否使用切面的权利还给了切面。在写切面的时候就可以决定哪些类的哪些方法会被代理，从而从逻辑上不需要侵入业务代码。由于这套语法实在是太有名，导致很多人都误以为AspectJ等于切面语法，其实不然。

第二套是织入工具。刚才讲到切面语法能够让切面从逻辑上与业务代码解耦，但是从操作上来讲，当JVM运行业务代码的时候，他甚至无从得知旁边还有个类想横插一刀。。。这个问题大概有两种解决思路，一种就是提供注册机制，通过额外的配置文件指明哪些类受到切面的影响，不过这还是需要干涉对象创建的过程；另外一种解决思路就是在编译期(或者类加载期)我们优先考虑一下切面代码，并将切面代码通过某种形式插入到业务代码中，这样业务代码不就知道自己被“切”了么？这种思路的一个实现就是aspectjweaver，就是这里的织入工具。

https://blog.mythsman.com/post/5d301cf2976abc05b34546be/

https://www.cnblogs.com/yxx123/p/6665736.html


# java security

## Principal

https://download.oracle.com/technetwork/java/javase/6/docs/zh/api/java/security/class-use/Principal.html

https://www.cnblogs.com/cat520/p/13059855.html

## SecurityContextHolder

保留系统当前的安全上下文细节, 其中就包括使用系统的用户信息.

```java
UsernamePasswordAuthenticationToken authentication = new UsernamePasswordAuthenticationToken(userDetails, null, userDetails.getAuthorities());
SecurityContextHolder.getContext().setAuthentication(authentication);
token = jwtTokenUtil.generateToken(userDetails);
//            updateLoginTimeByUsername(username);
insertLoginLog(username);
```


https://www.cnblogs.com/longfurcat/p/9417912.html


## security grantedauthority

```java
import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.core.authority.SimpleGrantedAuthority;
import org.springframework.security.core.userdetails.UserDetails;



    @Override
    public Collection<? extends GrantedAuthority> getAuthorities() {
        //返回当前用户的角色
        return resourceList.stream()
                .map(role ->new SimpleGrantedAuthority(role.getId()+":"+role.getName()))
                .collect(Collectors.toList());
    }

```

## 静态代理,JDK和CGLIB代理, AOP + Ioc

切面（ASPECT）：横切关注点被模块化的特殊对象。即，它是一个类。

通知（Advice）：切面必须要完成的工作。即，它是类中的一个方法。

目标（Target）：被通知对象。

代理（Proxy）：向目标对象应用通知之后创建的对象。

切入点（PointCut）：切面通知执行的“地点”的定义。

连接点（JointPoint）：与切入点匹配的执行点。

AOP的相关术语
通知（Advice）
通知描述了切面要完成的工作以及何时执行。比如我们的日志切面需要记录每个接口调用时长，就需要在接口调用前后分别记录当前时间，再取差值。

前置通知（Before）：在目标方法调用前调用通知功能；
后置通知（After）：在目标方法调用之后调用通知功能，不关心方法的返回结果；
返回通知（AfterReturning）：在目标方法成功执行之后调用通知功能；
异常通知（AfterThrowing）：在目标方法抛出异常后调用通知功能；
环绕通知（Around）：通知包裹了目标方法，在目标方法调用之前和之后执行自定义的行为。
连接点（JoinPoint）
通知功能被应用的时机。比如接口方法被调用的时候就是日志切面的连接点。

切点（Pointcut）
切点定义了通知功能被应用的范围。比如日志切面的应用范围就是所有接口，即所有controller层的接口方法。

切面（Aspect）
切面是通知和切点的结合，定义了何时、何地应用通知功能。

引入（Introduction）
在无需修改现有类的情况下，向现有的类添加新方法或属性。

织入（Weaving）
把切面应用到目标对象并创建新的代理对象的过程。


https://www.cnblogs.com/best/p/5679656.html

http://www.macrozheng.com/#/technology/aop_log


# Arthas 使用方法

```sh
[INFO] Try to attach process 11700
[INFO] Attach process 11700 success.
[INFO] arthas-client connect 127.0.0.1 3658
  ,---.  ,------. ,--------.,--.  ,--.  ,---.   ,---.
 /  O  \ |  .--. ''--.  .--'|  '--'  | /  O  \ '   .-'
|  .-.  ||  '--'.'   |  |   |  .--.  ||  .-.  |`.  `-.
|  | |  ||  |\  \    |  |   |  |  |  ||  | |  |.-'    |
`--' `--'`--' '--'   `--'   `--'  `--'`--' `--'`-----'


wiki       https://arthas.aliyun.com/doc
tutorials  https://arthas.aliyun.com/doc/arthas-tutorials.html
version    3.5.4
main_class
pid        11700
time       2021-09-24 15:04:16
```

对应的web界面是:

```sh
http://127.0.0.1:3658/
```

Arthas 是Alibaba开源的Java诊断工具，深受开发者喜爱。在线排查问题，无需重启；动态跟踪Java代码；实时监控JVM状态。

Arthas 支持JDK 6+，支持Linux/Mac/Windows，采用命令行交互模式，同时提供丰富的 Tab 自动补全功能，进一步方便进行问题的定位和诊断。

当你遇到以下类似问题而束手无策时，Arthas可以帮助你解决：
- 这个类从哪个 jar 包加载的？为什么会报各种类相关的 Exception？
- 我改的代码为什么没有执行到？难道是我没 commit？分支搞错了？
- 遇到问题无法在线上 debug，难道只能通过加日志再重新发布吗？
- 线上遇到某个用户的数据处理有问题，但线上同样无法 debug，线下无法重现！
- 是否有一个全局视角来查看系统的运行状况？
- 有什么办法可以监控到JVM的实时运行状态？
- 怎么快速定位应用的热点，生成火焰图？


https://arthas.aliyun.com/doc/

https://arthas.aliyun.com/doc/arthas-tutorials.html?language=cn&id=arthas-basics

http://www.macrozheng.com/#/reference/arthas_start


# 钻石依赖问题

https://blog.csdn.net/john1337/article/details/96825349

# shiro的ip白名单问题

https://www.kancloud.cn/iotdev/vue_java_springboot_antd_iot/1972298

https://www.moyundong.com/java/springboot2/14springboot%E9%9B%86%E6%88%90shiro.html


https://segmentfault.com/a/1190000022631899

https://www.cnblogs.com/LeeScofiled/p/10511948.html

https://cloud.tencent.com/developer/article/1367702

https://www.iocoder.cn/Shiro/xiaoqiyiye/ShiroFilterFactoryBean/

https://syshlang.com/96db3174/
