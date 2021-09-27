# java

https://github.com/akullpp/awesome-java

# java 系统学习路径

https://www.zhihu.com/question/311758187


# JAVA 基础语法

## String

String 创建的字符串存储在公共池中，而 new 创建的字符串对象在堆上：

## 数组

```
dataType[] arrayRefVar;   // 首选的方法
或
dataType arrayRefVar[];  // 效果相同，但不是首选方法
```

## 抽象类总结规定

1. 抽象类不能被实例化(初学者很容易犯的错)，如果被实例化，就会报错，编译无法通过。只有抽象类的非抽象子类可以创建对象。

2. 抽象类中不一定包含抽象方法，但是有抽象方法的类必定是抽象类。

3. 抽象类中的抽象方法只是声明，不包含方法体，就是不给出方法的具体实现也就是方法的具体功能。

4. 构造方法，类方法（用 static 修饰的方法）不能声明为抽象方法。

5. 抽象类的子类必须给出抽象类中的抽象方法的具体实现，除非该子类也是抽象类。

## JAVA提供了强大的数据结构

Java 集合框架主要包括两种类型的容器，一种是集合（Collection），存储一个元素集合，另一种是图（Map），存储键/值对映射。Collection 接口又有 3 种子类型，List、Set 和 Queue，再下面是一些抽象类，最后是具体实现类，常用的有 ArrayList、LinkedList、HashSet、LinkedHashSet、HashMap、LinkedHashMap 等等。

在Java中的数据结构主要包括以下几种接口和类：
- 枚举（Enumeration）
- 位集合（BitSet）
- 向量（Vector）
- 栈（Stack）
- 字典（Dictionary）
- 哈希表（Hashtable）
- 属性（Properties）




## Stream

Java 8 API添加了一个新的抽象称为流Stream，可以让你以一种声明的方式处理数据。

Stream 使用一种类似用 SQL 语句从数据库查询数据的直观方式来提供一种对 Java 集合运算和表达的高阶抽象。

Stream API可以极大提高Java程序员的生产力，让程序员写出高效率、干净、简洁的代码。

这种风格将要处理的元素集合看作一种流， 流在管道中传输， 并且可以在管道的节点上进行处理， 比如筛选， 排序，聚合等。

元素流在管道中经过中间操作（intermediate operation）的处理，最后由最终操作(terminal operation)得到前面处理的结果。

+--------------------+       +------+   +------+   +---+   +-------+
| stream of elements +-----> |filter+-> |sorted+-> |map+-> |collect|
+--------------------+       +------+   +------+   +---+   +-------+



https://www.runoob.com/java/java-hashmap.html

## HashMap

https://tech.meituan.com/2016/06/24/java-hashmap.html

# 自定义注解

自定义注解之运行时注解(RetentionPolicy.RUNTIME)

https://blog.csdn.net/github_35180164/article/details/52118286

https://fangjian0423.github.io/2016/11/04/java-annotation-retentionpolicy/


# linkis-entrance

entrance是app接入的入口.



# java 语言机制

## java反射机制及Method.invoke方法

Reflection 是Java被视为动态（或准动态）语言的一个关键性质。这个机制允许程序在运行时透过Reflection APIs取得任何一个已知名称的class的内部信息，包括其modifiers（诸如public, static 等等）、superclass（例如Object）、实现之interfaces（例如Serializable），也包括fields和methods的所有信息，并可于运行时改变fields内容或调用methods。

一般而言，开发者社群说到动态语言，大致认同的一个定义是：“程序运行时，允许改变程序结构或变量类型，这种语言称为动态语言”。从这个观点看，Perl，Python，Ruby是动态语言，C++，Java，C#不是动态语言。
 
尽管在这样的定义与分类下Java不是动态语言，它却有着一个非常突出的动态相关机制：Reflection。这个字的意思是“反射、映象、倒影”，用在Java身上指的是我们可以于运行时加载、探知、使用编译期间完全未知的classes。换句话说，Java程序可以加载一个运行时才得知名称的class，获悉其完整构造（但不包括methods定义），并生成其对象实体、或对其fields设值、或唤起其methods。这种“看透class”的能力（the ability of the program to examine itself）被称为introspection（内省、内观、反省）。Reflection和introspection是常被并提的两个术语。

https://www.likecs.com/show-134953.html

https://www.cnblogs.com/zhengtu2015/p/5829740.html

https://www.jianshu.com/p/3b311109050b


# Java并发编程：Callable、Future和FutureTask

https://www.cnblogs.com/dolphin0520/p/3949310.html

# java启动关闭服务的方法

```sh
#!/bin/sh

# 该脚本为Linux下启动java程序的脚本
#
# author: luandy
# date: 2021/1/15
#
# 特别注意：
# 该脚本使用系统kill命令来强制终止指定的java程序进程。
# 所以在杀死进程前，可能会造成数据丢失或数据不完整。如果必须要考虑到这类情况，则需要改写此脚本，
#
# 
# 根据实际情况来修改以下配置信息 ##################################

# JAVA应用程序的名称
APP_NAME=uid-consumer
# JAVA应用程序端口号
SERVER_PORT=9999
# jar包存放路径
JAR_PATH='/app/uid-consumer'
# jar包名称
JAR_NAME=uid-consumer-1.1.0-SNAPSHOT.jar
# PID 代表是PID文件
JAR_PID=$JAR_NAME\.pid
# 日志输出文件
LOG_FILE=logs

# java虚拟机启动参数
JAVA_OPTS="-Xms512m -Xmx512m -XX:MetaspaceSize=512m -XX:MaxMetaspaceSize=1024m -XX:ParallelGCThreads=4 -XX:+PrintGCDateStamps -XX:+PrintGCDetails -XX:+HeapDumpOnOutOfMemoryError -Dfile.encoding=utf-8"

# 根据实际情况来修改以上配置信息 ##################################


# 检查程序是否处于运行状态
is_exist() {
  # 查询出应用服务的进程id，grep -v 是反向查询的意思，查找除了grep操作的run.jar的进程之外的所有进程
  pid=`ps -ef|grep $JAR_NAME|grep -v grep|awk '{print $2}' `

  # [ ]表示条件测试。注意这里的空格很重要。要注意在'['后面和']'前面都必须要有空格
  # [ -z STRING ] 如果STRING的长度为零则返回为真，即空是真
  # 如果不存在返回0，存在返回1
  if [ -z "${pid}" ]; then
   return 0
  else
    return 1
  fi
}

# ######### Shell脚本中$0、$?、$!、$$、$*、$#、$@等的说明 #########

# $$ Shell本身的PID（ProcessID，即脚本运行的当前 进程ID号）
# $! Shell最后运行的后台Process的PID(后台运行的最后一个进程的 进程ID号)
# $? 最后运行的命令的结束代码（返回值）即执行上一个指令的返回值 (显示最后命令的退出状态。0表示没有错误，其他任何值表明有错误)
# $- 显示shell使用的当前选项，与set命令功能相同
# $* 所有参数列表。如"$*"用「"」括起来的情况、以"$1 $2 … $n"的形式输出所有参数，此选项参数可超过9个。
# $@ 所有参数列表。如"$@"用「"」括起来的情况、以"$1" "$2" … "$n" 的形式输出所有参数。
# $# 添加到Shell的参数个数
# $0 Shell本身的文件名
# $1～$n 添加到Shell的各参数值。$1是第1参数、$2是第2参数…。

# 服务启动方法
start() {
  is_exist
  if [ $? -eq "1" ]; then
    echo "$APP_NAME is already running pid is ${pid}"
  else
    # jar服务启动脚本
    nohup java $JAVA_OPTS -Xloggc:$LOG_FILE/gc/gclog.log -XX:HeapDumpPath=$LOG_FILE/gc/HeapDump.hprof -jar $JAR_PATH/$JAR_NAME >./$LOG_FILE/run.log 2>&1 &
    echo $! > $JAR_PID
    echo "start $APP_NAME successed pid is $! "
    tail -1000f $LOG_FILE/run.log
   fi
  }

# 服务停止方法
stop() {
  # is_exist
  pidf=$(cat $JAR_PID)
  # echo "$pidf" 
  echo "pid = $pidf begin kill $pidf"
  kill $pidf
  rm -rf $JAR_PID
  sleep 2
  # 判断服务进程是否存在
  is_exist
  if [ $? -eq "1" ]; then
    echo "pid = $pid begin kill -9 $pid"
    kill -9  $pid
    sleep 2
    echo "$APP_NAME process stopped！" 
  else
    echo "$APP_NAME is not running！"
  fi 
}

# 服务运行状态查看方法
status() {
  is_exist
  if [ $? -eq "1" ]; then
    echo "$APP_NAME is running，pid is ${pid}"
  else
    echo "$APP_NAME is not running！"
  fi
}

# 重启服务方法
restart() {
  # 调用服务停止命令
  stop
  # 调用服务启动命令
  start
}

# 帮助说明，用于提示输入参数信息
usage() {
    echo "Usage: sh run-service.sh [ start | stop | restart | status ]"
    exit 1
}

###################################
# 读取脚本的第一个参数($1)，进行判断
# 参数取值范围：{ start | stop | restart | status }
# 如参数不在指定范围之内，则打印帮助信息
###################################
#根据输入参数，选择执行对应方法，不输入则执行使用说明
case "$1" in
  'start')
    start
    ;;
  'stop')
    stop
    ;;
  'restart')
    restart
    ;;
  'status')
    status
    ;;
  *)
    usage
    ;;
esac
exit 0
```

https://cloud.tencent.com/developer/article/1780384





# JPA（Java Persistence API） 和JDBC的区别

JDBC是数据库访问标准
JPA 是 ORM 的标准;
JPA 是对象关系映射的标准。这是一种允许您在代码和数据库表中的对象之间进行映射的技术。这可以对开发人员“隐藏”SQL，以便他们处理的只是 Java 类，而提供程序允许您保存它们并神奇地加载它们。大多数情况下，XML 映射文件或 getter 和 setter 上的注释可用于告诉 JPA 提供程序您的对象上的哪些字段映射到 DB 中的哪些字段。最著名的 JPA 提供程序是Hibernate，因此它是开始具体示例的好地方。

https://stackoverflow.com/questions/11881548/jpa-or-jdbc-how-are-they-different

# java框架中分层的含义

https://blog.csdn.net/Mr_wilson_liu/article/details/104172717


# vscode debug java

VS Code for Java 支持两种模式，轻量级和标准。轻量级模式，语言服务器只解析源文件和JDK；在标准模式下，导入的依赖项被解析，项目由语言服务器构建。当您需要一个超级快速启动的轻量级环境来处理源文件时，轻量级模式最适合，例如，阅读源代码、在源代码和 JDK 之间导航、查看大纲和 Javadoc 以及检测和修复语法错误。此外，在源文件和 JDK 范围内支持代码完成。

轻量级模式不解析导入的依赖项，也不构建项目，因此不支持运行、调试、重构、linting 或检测语义错误。要使这些功能可用，您需要将工作区从轻量模式切换到标准模式。

您可以通过java.server.launchMode使用以下选项进行配置来控制要启动的模式：

Hybrid（默认） - 首先，工作区以轻量模式打开。如果您的工作区包含未解析的 Java 项目，系统将询问您是否切换到标准模式。如果您选择Later，它将保持轻量级模式。您可以单击状态栏上的服务器模式图标手动切换到标准模式。
Standard - 工作区以标准模式打开。
LightWeight- 工作区以轻量级模式打开。您可以单击状态栏上的服务器模式图标手动切换到标准模式。


settings.json 参数配置

https://code.visualstudio.com/docs/java/java-debugging#_configuration-options

https://github.com/microsoft/vscode-java-debug/blob/main/Configuration.md

## spring boot debug方式

```sh
mvnDebug spring-boot:run -Xdebug -Xrunjdwp:transport=dt_socket,address=8000,server=y,suspend=y
```

Then you can attach from vs code, a sample launch.json looks like:
```json
{
 "version": "0.2.0",
  "configurations": [
    {
      "type": "java",
      "name": "Debug (Launch)",
      "request": "launch",
      "mainClass": "",
      "args": ""
    },
    {
      "type": "java",
      "name": "Debug (Attach)",
      "request": "attach",
      "hostName": "localhost",
      "port": 8000
    }
  ] 
}
```

## 使用spring boot dashboard对应的命令是

```sh
 cd /data/code/Exchangis/modules/eureka ; /usr/bin/env /usr/lib/jvm/java-1.8.0-openjdk-1.8.0.292.b10-1.el8_4.x86_64/bin/java -Dcom.sun.management.jmxremote -Dcom.sun.management.jmxremote.port=44307 -Dcom.sun.management.jmxremote.authenticate=false -Dcom.sun.management.jmxremote.ssl=false -Djava.rmi.server.hostname=localhost -Dspring.application.admin.enabled=true -Dspring.jmx.enabled=true -Dfile.encoding=UTF-8 -cp /tmp/cp_3vcd3xoiqu1i6q8ip7odciu6h.jar com.webank.wedatasphere.exchangis.EurekaApplication 
```

https://stackoverflow.com/questions/43322171/how-to-debug-a-java-maven-spring-boot-app-in-vs-code

## maven debug调试

maven文件的debug配置选项

1. 添加maven的springboot插件

```xml
<project>
  ...
  <build>
    <!-- To define the plugin version in your parent POM -->
    <pluginManagement>
      <plugins>
        <plugin>
          <groupId>org.springframework.boot</groupId>
          <artifactId>spring-boot-maven-plugin</artifactId>
          <version>2.2.1.RELEASE</version>
        </plugin>
        ...
      </plugins>
    </pluginManagement>
    <!-- To use the plugin goals in your POM or parent POM -->
    <plugins>
      <plugin>
        <groupId>org.springframework.boot</groupId>
        <artifactId>spring-boot-maven-plugin</artifactId>
        <version>2.2.1.RELEASE</version>
      </plugin>
      ...
    </plugins>
  </build>
  ...
</project>
```


```xml
<project>
  ...
  <build>
    ...
    <plugins>
      ...
      <plugin>
        <groupId>org.springframework.boot</groupId>
        <artifactId>spring-boot-maven-plugin</artifactId>
        <version>2.2.1.RELEASE</version>
        <configuration>
          <jvmArguments>
            -Xdebug -Xrunjdwp:transport=dt_socket,server=y,suspend=y,address=5005
          </jvmArguments>
        </configuration>
        ...
      </plugin>
      ...
    </plugins>
    ...
  </build>
  ...
</project>
```

```sh
mvn spring-boot:run -Dspring-boot.run.jvmArguments="-Xdebug -Xrunjdwp:transport=dt_socket,server=y,suspend=y,address=5005"

@REM set MAVEN_OPTS=-Xdebug -Xnoagent -Djava.compiler=NONE -Xrunjdwp:transport=dt_socket,server=y,suspend=y,address=8000
```

https://docs.spring.io/spring-boot/docs/2.2.1.RELEASE/maven-plugin//examples/run-debug.html

https://www.baeldung.com/spring-debugging

https://docs.spring.io/spring-boot/docs/2.2.1.RELEASE/maven-plugin//index.html

https://shengulong.github.io/blog/2019/07/23/maven%E6%8F%92%E4%BB%B6%E8%B0%83%E8%AF%95%E6%96%B9%E6%B3%95/

https://www.cnblogs.com/xiaoxi666/p/9570826.html

https://stackoverflow.com/questions/2935375/debugging-in-maven/

https://stackoverflow.com/questions/29310760/debugging-in-maven-with-mvndebug-command

https://blog.csdn.net/wxyFighting/article/details/9408153

## jdwp远程调试

JDWP（Java Debug Wire Protocol）是一个为 Java 调试而设计的一个通讯交互协议，它定义了调试器和被调试程序之间传递的信息的格式。

```sh
/usr/bin/env /usr/lib/jvm/java-11-openjdk/bin/java -agentlib:jdwp=transport=dt_socket,server=n,suspend=y,address=localhost:43913 -Dfile.encoding=UTF-8 @/tmp/cp_2ywdgo2zxu68j4x42k6y9gz6q.argfile com.webank.wedatasphere.exchangis.ServiceApplication 
```

通过远程调试端口对exchangis的serviceapp进行调试

https://qsli.github.io/2018/08/12/jdwp/

https://docs.oracle.com/javase/8/docs/technotes/guides/troubleshoot/introclientissues005.html

jdwp调试分析方法

https://medium.com/@z2hteam/static-analysis-and-debugging-on-android-using-smalidea-jdwp-and-adb-c4c18d68abf2

https://iqeq00.gitbook.io/microservices-book/springboot/jdwp


# vscode 配log4j

java Dlog.path Duser.dir Dserver.port Dlogging.config vscode 配置

# spring boot 中bootstrap.yml的作用

https://www.baeldung.com/spring-cloud-bootstrap-properties

https://www.cnblogs.com/blognetspace/p/8469033.html


# 编写自定义注解


https://mp.weixin.qq.com/s?__biz=MzI4Njg5MDA5NA==&mid=2247484113&idx=1&sn=f5fd35b2f7dc45a256fee170cad0cdc9&chksm=ebd743d0dca0cac6a8fed8caf09f0d561b0358dece9b8e746e1e6726bca093287cf515638349&scene=21###wechat_redirect


# gson库的使用

```java
// 基本数据类型解析
Gson gson = new Gson();
int i = gson.fromJson("100", int.class);
double d = gson.fromJson("\"99.1\"", double.class);

// 基本数据类型生成
String jsonNumber = gson.toJson(101);

// POJO类的生成与解析
public class User {
  public String name;
  public int age;
}

User user = new User("李四", 25);
String jsonObj = gson.toJson(user);

String jsonString = "{\"name\":\"张三\",\"age\":24}";
User user = gson.fromJson(jsonString, User.class);
```

https://github.com/google/gson

https://www.cnblogs.com/qinxu/p/9504412.html

# factory工厂模式


工厂模式主要是为创建对象提供过渡接口，以便将创建对象的具体过程屏蔽隔离起来，达到提高灵活性的目的。
工厂模式可以分为三类:

- 简单工厂模式（Simple Factory）
- 工厂方法模式（Factory Method）
- 抽象工厂模式（Abstract Factory）


工厂方法模式和简单工厂模式在定义上的不同是很明显的。
工厂方法模式的核心是一个抽象工厂类,而不像简单工厂模式, 把核心放在一个实类上。
工厂方法模式可以允许很多实的工厂类从抽象工厂类继承下来, 从而可以在实际上成为多个简单工厂模式的综合,从而推广了简单工厂模式。

无论是简单工厂模式，工厂方法模式，还是抽象工厂模式，他们都属于工厂模式，在形式和特点上也是极为相似的，他们的最终目的都是为了解耦。在使用时，我们不必去在意这个模式到底工厂方法模式还是抽象工厂模式，因为他们之间的演变常常是令人琢磨不透的。经常你会发现，明明使用的工厂方法模式，当新需求来临，稍加修改，加入了一个新方法后，由于类中的产品构成了不同等级结构中的产品族，它就变成抽象工厂模式了；而对于抽象工厂模式，当减少一个方法使的提供的产品不再构成产品族之后，它就演变成了工厂方法模式。所以，在使用工厂模式时，只需要关心降低耦合度的目的是否达到了。

https://developer.aliyun.com/article/238431

https://blog.csdn.net/eson_15/article/details/51223124

https://blog.csdn.net/qq_36629833/article/details/90764881

https://blog.csdn.net/hguisu/article/details/7505909?spm=a2c6h.12873639.0.0.54b14d86OIefaU

https://www.w3cschool.cn/java/java-factory-pattern.html


# java 反射

获取所有的子类
```java
List<Class<? extends T>> factoryClasses = getReflections(clazz).getSubTypesOf(clazz)
                .stream().filter(c -> !com.webank.wedatasphere.linkis.common.utils.ClassUtils.isInterfaceOrAbstract(c)).collect(Collectors.toList());
```

https://dunwu.github.io/javacore/basics/java-reflection.html


# 接口 interface

有时必须从几个类中派生出一个子类，继承它们所有的属性和方法。但是，Java不支持多重继承。有了接口，就可以得到多重继承的效果。

接口(interface)是抽象方法和常量值的定义的集合。

从本质上讲，接口是一种特殊的抽象类，这种抽象类中只包含常量和方法的定义，而没有变量和方法的实现。


https://blog.csdn.net/qq_44871442/article/details/102590978

https://blog.csdn.net/sun_shine56/article/details/86621481

# Collection<? extends T> 和Collection<T>的区别

```java
class Animal { }
class Horse extends Animal { }

private static void specific(List<Animal> param) { }
private static void wildcard(List<? extends Animal> param) { }
```
如果没有扩展语法，您只能在签名中使用确切的类
> specific(new ArrayList<Horse>()); // <== compiler error
使用通配符扩展，您可以允许 Animal 的任何子类
> wildcard(new ArrayList<Horse>());  // <== OK


# ConcurrentHashMap 緩存

https://blog.csdn.net/sureSand/article/details/82190636

# java stream map的使用

https://blog.csdn.net/qq_41135605/article/details/109494073


# java :: double colon操作符 方法参考

```
语法：<classname or instancename>::<methodname>
```


https://stackoverflow.com/questions/20001427/double-colon-operator-in-java-8

https://javapapers.com/core-java/java-method-reference/

# java 泛型中 <? extends E> 和 <? super E>
的区别

```md
PECS法则：生产者（Producer）使用extends，消费者（Consumer）使用super
1、生产者
       如果你需要一个提供E类型元素的集合，使用泛型通配符<? extends E>。它好比一个生产者，可以提供数据。
2、消费者
       如果你需要一个只能装入E类型元素的集合，使用泛型通配符<? super E>。它好比一个消费者，可以消费你提供的数据。
3、既是生产者也是消费者
       既要存储又要读取，那就别使用泛型通配符。
```

https://www.cnblogs.com/xiarongjin/p/8309755.html


# 读取文件的方法


https://www.baeldung.com/reading-file-in-java

# java 方法的调用

非静态方法调用
静态方法调用
方法之间的调用

https://www.php.cn/java/base/436519.html



## 遍历方式

### 遍历ArrayList

```java
import java.util.*;

public class Test {
  public static void main(String[] args) {
    List<String> list = new ArrayList<String>();
    list.add("hi");
    list.add("jsdu");

    // 方式1
    for (String str : list) {
      System.out.println(str);
    }

    // 方式2
    String[] strArray = new String[list.size()];
    list.toArray(strArray);
    for(int i=0; i<strArray.length; i++)
    {
      System.out.println(strArray[i]);
    }

    // 方式3
    Iterator<String> iter = list.iterator();
    while(iter.hasNext())
    {
      System.out.prinln(iter.next());
    }
  }
}
```

### 遍历Map

```java
import java.util.*;

public class Test {
  public static void main(String[] args) {
    Map<String, String> map = new HashMap<String, String>();
    map.put("k1", "v1");
    map.put("k2", "v2");
    map.put("k3", "v3");

    // 方式1
    for (String key: map.keySet()) {
      System.out.println("key=" + key + "and value=" + map.get(key));
    }

    //  Map.KeySet 使用iterator遍历
    Iterator<String> iter = map.keySet().iterator();
    while (iterator.hasNext()) {
      Integer key = iterator.next();
      String value = map.get(key);
      System.out.println("key=" + key + "val = "  + value);
    }

    // Map.entrySet使用iterator遍历
    Iterator<Map.Entry<String, String>> entries = map.entrySet().iterator();
    while (entries.hasNext()) {
      Map.Entry<String, Stirng> entry = entries.next();
      System.out.println(entry);
    }

    // Map.KeySet遍历
    for (String key : map.keySet()) {
      System.out.println("key=" + key + "val = "  + map.get(key));
    }


    // Map.entry遍历
    for (Map.entry<String, String> entry: map.entrySet()) {
      System.out.println("key=" + entry.getKey() + "val = "  + entry.getValue());
    }

    // lambda ForEach遍历
    map.ForEach((k, v) -> System.out.println("key=" + k + "val = "  + v));
  }
}
```

https://segmentfault.com/a/1190000039224130


# Class Loader

它是用来加载 Class 的。它负责将 Class 的字节码形式转换成内存形式的 Class 对象。字节码可以来自于磁盘文件 *.class，也可以是 jar 包里的 *.class，也可以来自远程服务器提供的字节流，字节码的本质就是一个字节数组 []byte，它有特定的复杂的内部格式。

JVM 中内置了三个重要的 ClassLoader，分别是 BootstrapClassLoader、ExtensionClassLoader 和 AppClassLoader。

BootstrapClassLoader 负责加载 JVM 运行时核心类，这些类位于 JAVA_HOME/lib/rt.jar 文件中，我们常用内置库 java.xxx.* 都在里面，比如 java.util.*、java.io.*、java.nio.*、java.lang.* 等等。这个 ClassLoader 比较特殊，它是由 C 代码实现的，我们将它称之为「根加载器」。

ExtensionClassLoader 负责加载 JVM 扩展类，比如 swing 系列、内置的 js 引擎、xml 解析器 等等，这些库名通常以 javax 开头，它们的 jar 包位于 JAVA_HOME/lib/ext/*.jar 中，有很多 jar 包。

AppClassLoader 才是直接面向我们用户的加载器，它会加载 Classpath 环境变量里定义的路径中的 jar 包和目录。我们自己编写的代码以及使用的第三方 jar 包通常都是由它来加载的。

那些位于网络上静态文件服务器提供的 jar 包和 class文件，jdk 内置了一个 URLClassLoader，用户只需要传递规范的网络路径给构造器，就可以使用 URLClassLoader 来加载远程类库了。URLClassLoader 不但可以加载远程类库，还可以加载本地路径的类库，取决于构造器中不同的地址形式。ExtensionClassLoader 和 AppClassLoader 都是 URLClassLoader 的子类，它们都是从本地文件系统里加载类库。

AppClassLoader 可以由 ClassLoader 类提供的静态方法 getSystemClassLoader() 得到，它就是我们所说的「系统类加载器」，我们用户平时编写的类代码通常都是由它加载的。当我们的 main 方法执行的时候，这第一个用户类的加载器就是 AppClassLoader。

https://blog.csdn.net/briblue/article/details/54973413

https://zhuanlan.zhihu.com/p/51374915

## SOFA STACK
SOFAArk 是可以解决钻石依赖的版本管理工具.


https://www.sofastack.tech/guides/sofastack-demos/

https://github.com/sofastack/sofa-ark

https://www.sofastack.tech/projects/sofa-boot/sofa-ark-readme/

https://github.com/sofastack