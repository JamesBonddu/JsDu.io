# 注解

https://cloud.tencent.com/developer/article/1772324

# 请求注解
## @PathVariable、@RequestBody和@RequestParam使用场景

@PathVariable是spring3.0的一个新功能：接收请求路径中占位符的值

https://blog.csdn.net/sswqzx/article/details/84194979

https://www.cnblogs.com/codeluojay/p/13997558.html#:~:text=PathVari,VC%E5%B0%B1%E5%8F%AF%E4%BB%A5%E8%8E%B7%E5%8F%96%E5%88%B0

## RESTEasy:@FormParam、@PathParam、@QueryParam、@HeaderParam、@CookieParam、@MatrixParam说明
你可以使用下面的注释绑定HTTP请求REST风格的Web服务：

@FormParam
@PathParam
@QueryParam
@HeaderParam
@CookieParam
@MatrixParam


@QueryParam将查询参数"zip"注入到方法参数"zip"

https://www.cnblogs.com/chen-lhx/p/5599806.html

# @Valid+BindingResult进行controller参数校验

@Valid与@Validated注解

https://blog.csdn.net/zhenwei1994/article/details/81460419

https://blog.csdn.net/FU250/article/details/80247930

https://docs.spring.io/spring-framework/docs/4.3.10.RELEASE_to_4.3.11.RELEASE/Spring%20Framework%204.3.11.RELEASE/org/springframework/validation/BindingResult.html

https://blog.csdn.net/justry_deng/article/details/86571671

# @Component vs @Repository 和 @Service

@Service 和 @Repository是@Component 的特例。它们在技术上是相同的，但我们将它们用于不同的目的。

https://www.baeldung.com/spring-component-repository-service

https://learnku.com/articles/32522


# @Autowired, @Resource and @Inject


## @Resource装配顺序

该@Resource注解是的一部分，JSR-250注解集，并打包在javaEE。此注解具有以下执行路径，按优先级列出：

按名称匹配
按类型匹配
按预选赛匹配
这些执行路径适用于 setter 和字段注入。

(1). 如果同时指定了name和type，则从Spring上下文中找到唯一匹配的bean进行装配，找不到则抛出异常;

(2). 如果指定了name，则从上下文中查找名称（id）匹配的bean进行装配，找不到则抛出异常;

(3). 如果指定了type，则从上下文中找到类型匹配的唯一bean进行装配，找不到或者找到多个，都会抛出异常;

(4). 如果既没有指定name，又没有指定type，则自动按照byName方式进行装配；如果没有匹配，则回退为一个原始类型进行匹配，如果匹配则自动装配；

https://blog.csdn.net/loophome/article/details/91375333

当我们在xml里面为类配置注入对象时，会发现xml文件会越来越臃肿，维护起来很麻烦。这时候我们可以使用注解这种机制来为类配置注入对象。

Java为我们提供了 javax.annotation.Resource这个注解。

spring框架提供了org.springframework.beans.factory.annotation.Autowired。

一般情况下我们使用 javax.annotation.Resource这个注解，因为这样我们就能实现和spring框架的解藕。

@Resource的作用相当于@Autowired，只不过@Autowired按byType自动注入。

https://www.baeldung.com/spring-annotations-resource-inject-autowire

https://www.cnblogs.com/sharpest/p/7724706.html

https://juejin.cn/post/6847902215928037383


# 请求响应

HttpServletResponse和HttpServletRequest的简介

https://blog.csdn.net/Jsagacity/article/details/80143842

# @Transactional

spring 的事务注解.

https://blog.csdn.net/u013929527/article/details/102596243


# Produces和Consumes注解
@Produces(MediaType.APPLICATION_JSON)
@Consumes(MediaType.APPLICATION_JSON)

produces：它的作用是指定返回值类型，不但可以设置返回值类型还可以设定返回值的字符编码；

consumes： 指定处理请求的提交内容类型（Content-Type），例如application/json, text/html;

https://blog.csdn.net/zhanyu1/article/details/82849490

# @Retention

```java

import java.lang.annotation.ElementType;
import java.lang.annotation.Retention;
import java.lang.annotation.RetentionPolicy;
import java.lang.annotation.Target;

//.RetentionPolicy.RUNTIME —— 这种类型的Annotations将被JVM保留,所以他们能在运行时被JVM或其他使用反射机制的代码所读取和使用.
@Retention(RetentionPolicy.RUNTIME)
@Target({ElementType.METHOD})
public @interface DSSWorkspaceUM {
    String value() default "";
}

```

元注解的作用就是负责注解其他注解。Java5.0定义了4个标准的meta-annotation类型，它们被用来提供对其它 annotation类型作说明。Java5.0定义的元注解：
1. @Target
2. @Retention
3. @Documented
4. @Inherited


@Target：

> @Target说明了Annotation所修饰的对象范围：Annotation可被用于 packages、types（类、接口、枚举、Annotation类型）、类型成员（方法、构造方法、成员变量、枚举值）、方法参数和本地变量（如循环变量、catch参数）。在Annotation类型的声明中使用了target可更加明晰其修饰的目标。

　　作用：用于描述注解的使用范围（即：被描述的注解可以用在什么地方）

　　取值(ElementType)有：

　　　　1.CONSTRUCTOR:用于描述构造器
　　　　2.FIELD:用于描述域
　　　　3.LOCAL_VARIABLE:用于描述局部变量
　　　　4.METHOD:用于描述方法
　　　　5.PACKAGE:用于描述包
　　　　6.PARAMETER:用于描述参数
　　　　7.TYPE:用于描述类、接口(包括注解类型) 或enum声明

https://www.cnblogs.com/gmq-sh/p/4798194.html

https://www.cnblogs.com/panxuejun/p/6089297.html


# Component

```scala
import org.springframework.stereotype.Component

@Component
class BMLService extends JavaLog{

}
```

# @EnableCaching 緩存注解


@EnableCaching：启用缓存功能
开启缓存功能，配置类中需要加上这个注解，有了这个注解之后，spring才知道你需要使用缓存的功能，其他和缓存相关的注解才会有效，spring中主要是通过aop实现的，通过aop来拦截需要使用缓存的方法，实现缓存的功能。

@Cacheable：赋予缓存功能


https://cloud.tencent.com/developer/article/1441904


https://segmentfault.com/a/1190000011069802

http://www.itsoku.com/article/308


# Springboot 下ModelAndView的使用

Spring MVC中  Model只是用来传输数据的，并不会进行业务的寻址。ModelAndView 却是可以进行业务寻址的.

ModelAndView 介绍：
- ModelAndView 用于后台与前端页面交互；
- 可以用于重定向与转发到指定页面，
- 可以保存数据然后渲染到页面

servlet重定向有两种方式，一种是forward，另一种就是redirect。forward是服务器内部重定向，客户端并不知道服务器把你当前请求重定向到哪里去了，地址栏的url与你之前访问的url保持不变。redirect则是客户端重定向，是服务器将你当前请求返回，然后给个状态标示给你，告诉你应该去重新请求另外一个url，具体表现就是地址栏的url变成了新的url。


路由跳转的方法
```java
（1）我在后台一个controller跳转到另一个controller，为什么有这种需求呢，是这样的。我有一个列表页面，然后我会进行新增操作，新增在后台完成之后我要跳转到列表页面，不需要传递参数，列表页面默认查询所有的。
    方式一：使用ModelAndView
    return new ModelAndView("redirect:/toList");
    这样可以重定向到toList这个方法
    方式二：返回String
                return "redirect:/ toList ";
    其它方式：其它方式还有很多，这里不再做介绍了，比如说response等等。这是不带参数的重定向。

（2）第二种情况，列表页面有查询条件，跳转后我的查询条件不能丢掉，这样就需要带参数的了，带参数可以拼接url

    方式一：自己手动拼接url

                new ModelAndView("redirect:/toList？param1="+value1+"&param2="+value2);
                这样有个弊端，就是传中文可能会有乱码问题。

    方式二：用RedirectAttributes，这个是发现的一个比较好用的一个类
                这里用它的addAttribute方法，这个实际上重定向过去以后你看url，是它自动给你拼了你的url。
                使用方法：

                 attr.addAttribute("param", value);
                return "redirect:/namespace/toController";
                这样在toController这个方法中就可以通过获得参数的方式获得这个参数，再传递到页面。过去的url还是和方式一一样的。

（3）带参数不拼接url页面也能拿到值（重点是这个）
        一般我估计重定向到都想用这种方式：

        @RequestMapping("/save")
public String save(@ModelAttribute("form") Bean form,RedirectAttributes attr)
               throws Exception {


    String code =  service.save(form);
    if(code.equals("000")){
        attr.addFlashAttribute("name", form.getName());
        attr.addFlashAttribute("success", "添加成功!");
        return "redirect:/index";
    }else{
        attr.addAttribute("projectName", form.getProjectName());
        attr.addAttribute("enviroment", form.getEnviroment());
        attr.addFlashAttribute("msg", "添加出错!错误码为："+rsp.getCode().getCode()+",错误为："+rsp.getCode().getName());
        return "redirect:/maintenance/toAddConfigCenter";
    }
}```

https://www.cnblogs.com/alsf/p/9134552.html

https://www.cnblogs.com/tanzq/p/8687267.html

https://blog.csdn.net/ITBigGod/article/details/79685610


# @Validated/@Valid注解使用和BindingResult

https://blog.csdn.net/qq_17589751/article/details/104769801
