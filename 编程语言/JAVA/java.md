# java

https://github.com/akullpp/awesome-java

# java 系统学习路径

https://www.zhihu.com/question/311758187


# JAVA 基础语法


## 多态
Java中多态其实是一种运行期的状态。为了实现运行期的多态，或者说是动态绑定，需要满足三个条件：

- 有类继承或者接口实现
- 子类要重写父类的方法
- 父类的引用指向子类的对象

## 求值策略
当进行方法调用的时候，需要把实际参数传递给形式参数，那么传递的过程中到底传递的是什么东西呢？
求值策略定义何时和以何种顺序求值给函数的实际参数、什么时候把它们代换入函数、和代换以何种形式发生。

求值策略分为两大基本类，基于如何处理给函数的实际参数，分位严格的和非严格的。
在严格求值中有几个关键的求值策略是我们比较关心的，那就是传值调用（Call by value）、传引用调用（Call by reference）以及传共享对象调用（Call by sharing）。
- 传值调用（值传递）
在传值调用中，实际参数先被求值，然后其值通过复制，被传递给被调函数的形式参数。因为形式参数拿到的只是一个"局部拷贝"，所以如果在被调函数中改变了形式参数的值，并不会改变实际参数的值。
- 传引用调用（引用传递）
在传引用调用中，传递给函数的是它的实际参数的隐式引用而不是实参的拷贝。因为传递的是引用，所以，如果在被调函数中改变了形式参数的值，改变对于调用者来说是可见的。
- 传共享对象调用（共享对象传递）
传共享对象调用中，先获取到实际参数的地址，然后将其复制，并把该地址的拷贝传递给被调函数的形式参数。因为参数的地址都指向同一个对象，所以我们称也之为"传共享对象"，所以，如果在被调函数中改变了形式参数的值，调用者是可以看到这种变化的。

引用数据类型参数(如对象)也按值传递给方法。这意味着，当方法返回时，传入的引用仍然引用与以前相同的对象。但是，如果对象字段具有适当的访问级别，则可以在方法中更改这些字段的值。其实Java中使用的求值策略就是传共享对象调用，也就是说，Java会将对象的地址的拷贝传递给被调函数的形式参数。

https://hollischuang.github.io/toBeTopJavaer/#/basics/object-oriented/java-pass-by

## 包装类
既然 Java 中为了提高效率，提供了八种基本数据类型，为什么还要提供包装类呢？

这个问题，其实前面已经有了答案，因为 Java 是一种面向对象语言，很多地方都需要使用对象而不是基本数据类型。比如，在集合类中，我们是无法将 int 、double 等类型放进去的。因为集合的容器要求元素是 Object 类型。

为了让基本类型也具有对象的特征，就出现了包装类型，它相当于将基本类型“包装起来”，使得它具有了对象的性质，并且为其添加了属性和方法，丰富了基本类型的操作。

### 拆箱与装箱
那么，有了基本数据类型和包装类，肯定有些时候要在他们之间进行转换。比如把一个基本数据类型的 int 转换成一个包装类型的 Integer 对象。

我们认为包装类是对基本类型的包装，所以，把基本数据类型转换成包装类的过程就是打包装，英文对应于 boxing，中文翻译为装箱。

既然 Java 提供了自动拆装箱的能力，那么，我们就来看一下，到底是什么原理，Java 是如何实现的自动拆装箱功能。
自动拆箱
```java
public static void main(String[] args) {
  Integer integer = 1; //装箱
  int i = integer; //拆箱
}
```
反编译后
```java
public static void main(String[] args) {
  Interger integer = Integer.valueOf(1);
  int i = integer.intValue();
}
```
int 的自动装箱都是通过 Integer.valueOf() 方法来实现的，Integer 的自动拆箱都是通过 integer.intValue 来实现的.
自动装箱都是通过包装类的 valueOf() 方法来实现的.自动拆箱都是通过包装类对象的 xxxValue() 来实现的。
自动拆装箱的原理
- 将基本数据类型放入集合内
- 包装类型和基本类型的大小比较
- 包装类型的运算
- 三目运算符的使用
- 函数参数与返回值

## 如何正确定义接口的返回值

我们可以发现，虽然Model3和Model4中的成员变量的名称不同，一个是success，另外一个是isSuccess，但是他们自动生成的getter和setter方法名称都是isSuccess和setSuccess。


在Java体系中，共用三种常量池。分别是字符串常量池、Class常量池和运行时常量池。
> Class 常量池

Class常量池可以理解为是Class文件中的资源仓库。 Class文件中除了包含类的版本、字段、方法、接口等描述信息外，还有一项信息就是常量池(constant pool table)，用于存放编译器生成的各种字面量(Literal)和符号引用(Symbolic References)。 Class是用来保存常量的一个媒介场所，并且是一个中间场所。在JVM真的运行时，需要把常量池中的常量加载到内存中。
HelloWorld.class文件中的前八个字母是cafe babe，这就是Class文件的魔数（Java中的”魔数”）

我们需要知道的是，在Class文件的4个字节的魔数后面的分别是4个字节的Class文件的版本号（第5、6个字节是次版本号，第7、8个字节是主版本号，我生成的Class文件的版本号是52，这时Java 8对应的版本。也就是说，这个版本的字节码，在JDK 1.8以下的版本中无法运行）在版本号后面的，就是Class常量池入口了。

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

## Set
Set主要分为两类:
1、TreeSet 是二叉树实现的，TreeSet中的数据是自动排好序的，不允许放入 null值

TreeSet的底层是TreeMap的keySet()，而TreeMap是基于红黑树实现的，红黑树是一种平衡二叉查找树，它能保证任何一个节点的左右子树的高度差不会超过较矮的那棵的一倍。

TreeMap是按key排序的，元素在插入TreeSet时compareTo()方法要被调用，所以TreeSet中的元素要实现Comparable接口。TreeSet作为一种Set，它不允许出现重复元素。TreeSet是用compareTo()来判断重复元素的。

2、HashSet 是哈希表实现的，HashSet中的数据是无序的，可以放入 null值，但只能放入一个null，两者中的值都不能重复，就如数据库中的唯一约束

在HashSet中，基本的操作都是由HashMap底层实现的，因为HashSet底层是用HashMap存储数据的。当向HashSet中添加元素的时候，首先计算元素的hashCode值，然后通过扰动计算和按位与的方式计算出这个元素的存储位置，如果这个位置为空，就将元素添加进去；如果不为空，则用equals方法比较元素是否相等，相等就不添加，否则找一个空位添加。

## HashMap

ConcurrentHashMap和HashMap的实现方式不一样，虽然都是使用桶数组实现的，但是还是有区别，ConcurrentHashMap对桶数组进行了分段，而HashMap并没有。

ConcurrentHashMap在每一个分段上都用锁进行了保护。HashMap没有锁机制。所以，前者线程安全的，后者不是线程安全的。

https://hollischuang.github.io/toBeTopJavaer/#/basics/java-basic/HashMap-HashTable-ConcurrentHashMap

https://tech.meituan.com/2016/06/24/java-hashmap.html

## Copy-On-Write

Copy-On-Write简称COW，是一种用于程序设计中的优化策略。其基本思路是，从一开始大家都在共享同一个内容，当某个人想要修改这个内容的时候，才会真正把内容Copy出去形成一个新的内容然后再改，这是一种延时懒惰策略。从JDK1.5开始Java并发包里提供了两个使用CopyOnWrite机制实现的并发容器,它们是CopyOnWriteArrayList和CopyOnWriteArraySet。CopyOnWrite容器非常有用，可以在非常多的并发场景中使用到.

CopyOnWriteArrayList相当于线程安全的ArrayList，CopyOnWriteArrayList使用了一种叫写时复制的方法，当有新元素add到CopyOnWriteArrayList时，先从原有的数组中拷贝一份出来，然后在新的数组做写操作，写完之后，再将原来的数组引用指向到新数组。

ConcurrentSkipListMap 和 ConcurrentHashMap 的主要区别：
- 底层实现方式不同。ConcurrentSkipListMap底层基于跳表。ConcurrentHashMap底层基于Hash桶和红黑树。
- ConcurrentHashMap不支持排序。ConcurrentSkipListMap支持排序。

> fail-fast机制
> 我们通常说的Java中的fail-fast机制，默认指的是Java集合的一种错误检测机制。当多个线程对部分集合进行结构上的改变的操作时，有可能会产生fail-fast机制，这个时候就会抛出ConcurrentModificationException（后文用CME代替）。CMException，当方法检测到对象的并发修改，但不允许这种修改时就抛出该异常。在Java中， 如果在foreach 循环里对某些集合元素进行元素的 remove/add 操作的时候，就会触发fail-fast机制，进而抛出CMException。

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


# Synchronized的使用

在编程中，经常需要用到同步，这里讲一下synchronized关键字的相关知识

1.使用方式
修饰一个代码块，被修饰的代码块称为同步代码块，作用范围是大括号{}括起来的代码；
修饰一个方法，被修饰的方法称为同步方法，其作用范围是整个方法；
修改一个静态方法，作用范围是整个静态方法；
修改一个类，作用范围是synchronized后面括号括起来的部分。


https://blog.csdn.net/qq_38011415/article/details/89047812

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


# AtomicReference

AtomicReference类提供了一个可以原子读写的对象引用变量。 原子意味着尝试更改相同AtomicReference的多个线程（例如，使用比较和交换操作）不会使AtomicReference最终达到不一致的状态。 AtomicReference甚至有一个先进的compareAndSet（）方法，它可以将引用与预期值（引用）进行比较，如果它们相等，则在AtomicReference对象内设置一个新的引用。


https://www.jianshu.com/p/5521ae322743


# java 文件写入

https://www.cnblogs.com/rinack/p/14173936.html


# java 构造函数和字段初始化顺序

https://blog.csdn.net/bboyfeiyu/article/details/21964645


# mybatis

## 时间格式处理 createtime

https://blog.csdn.net/zwjyyy1203/article/details/104654424

https://xie.infoq.cn/article/1a7cd6ab43ce4f3c7cc6d611a


# 传入参数

https://www.cnblogs.com/guanghe/p/9317476.html

# mybatis类映射拦截器和分页拦截器

https://docs.spring.io/spring-framework/docs/current/javadoc-api/org/springframework/web/servlet/handler/MappedInterceptor.html


# mybatis 升级mybatis-plus

https://segmentfault.com/a/1190000024416279

https://www.cnblogs.com/pigll/p/13646240.html


# springboot interceptor 拦截器

拦截器(Interceptor)同 Filter 过滤器一样，它俩都是面向切面编程——AOP 的具体实现（AOP切面编程只是一种编程思想而已）。

你可以使用 Interceptor 来执行某些任务，例如在 Controller 处理请求之前编写日志，添加或更新配置......

在 Spring中，当请求发送到 Controller 时，在被Controller处理之前，它必须经过 Interceptors（0或更多）。

Spring Interceptor是一个非常类似于Servlet Filter 的概念 。

对于过滤器和拦截器的区别， 知乎@Kangol LI 的回答很不错。

过滤器（Filter）：当你有一堆东西的时候，你只希望选择符合你要求的某一些东西。定义这些要求的工具，就是过滤器。
拦截器（Interceptor）：在一个流程正在进行的时候，你希望干预它的进展，甚至终止它进行，这是拦截器做的事情。

https://github.com/CodingDocs/springboot-guide/blob/master/docs/basis/springboot-interceptor.md
