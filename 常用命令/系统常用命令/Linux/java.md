# java运行多个main函数的jar

```sh
java -cp myjar.jar MyClass
and

java -cp myjar.jar OtherMainClass
```

https://stackoverflow.com/questions/3976514/multiple-runnable-classes-inside-jar-how-to-run-them

# 重新生成iml文件
```sh
mvn idea:module
```

https://www.cco.xyz/archives/853


https://blog.51cto.com/u_15327484/3485296


# 将pom依赖打入jar包


方法一：使用maven-assembly-plugin插件打包
在pom.xml中配置：

```xml
    <build>
        <plugins>
            <plugin>
                <artifactId>maven-assembly-plugin</artifactId>
                <configuration>
                    <archive>
                        <manifest>
                            <mainClass>com.cloudera.hivejdbc.NoneKBSimple</mainClass>
                        </manifest>
                    </archive>
                    <descriptorRefs>
                        <descriptorRef>jar-with-dependencies</descriptorRef>
                    </descriptorRefs>
                </configuration>
                <executions>
                    <execution>
                        <id>make-assembly</id>
                        <phase>package</phase> <!-- packaging phase -->
                        <goals>
                            <goal>single</goal>
                        </goals>
                    </execution>
                </executions>
            </plugin>
        </plugins>
    </build>
```

https://www.cnblogs.com/zhangwuji/p/10040834.html

https://www.jianshu.com/p/9146cec6cc60


# maven 打包的插件

plugin| function
-|-
maven-jar-plugin|	maven 默认打包插件，用来创建 project jar
maven-shade-plugin|	用来打可执行包，executable(fat) jar
maven-assembly-plugin|	支持定制化打包方式，例如 apache 项目的打包方式


https://segmentfault.com/a/1190000016237395


# scala 项目打包的maven依赖

```xml
    <properties>
        <scala-maven-plugin.version>3.1.3</scala-maven-plugin.version>
        <scala.version>2.10.7</scala.version>
    </properties>

    <dependencies>
        <dependency>
            <groupId>org.scala-lang</groupId>
            <artifactId>scala-library</artifactId>
            <version>${scala.version}</version>
        </dependency>
        <dependency>
            <groupId>org.scala-lang</groupId>
            <artifactId>scala-compiler</artifactId>
            <version>${scala.version}</version>
        </dependency>
    </dependencies>




    <build>
        <plugins>

            <plugin>
                <groupId>org.apache.maven.plugins</groupId>
                <artifactId>maven-assembly-plugin</artifactId>
                <version>2.5.5</version>
                <configuration>
                    <archive>
                        <manifest>
                            <mainClass>com.demo.Hello</mainClass>
                        </manifest>
                    </archive>
                    <descriptorRefs>
                        <descriptorRef>jar-with-dependencies</descriptorRef>
                    </descriptorRefs>
                </configuration>
                <executions>
                    <execution>
                        <id>make-assembly</id>
                        <phase>package</phase>
                        <goals>
                            <goal>single</goal>
                        </goals>
                    </execution>
                </executions>
            </plugin>

            <plugin>
                <groupId>org.scala-tools</groupId>
                <artifactId>maven-scala-plugin</artifactId>
                <version>2.15.2</version>
                <executions>
                    <execution>
                        <goals>
                            <goal>compile</goal>
                            <goal>testCompile</goal>
                        </goals>
                    </execution>
                </executions>
            </plugin>
        </plugins>
    </build>
```


https://www.jianshu.com/p/fe8c86e7d927


# maven 打包spark应用去掉不需要的组件

网络上能比较常见的打包 Scals 项目的方法，大多是引入了 org.scala-tools.maven-scala-plugin 插件(https://mvnrepository.com/artifact/org.scala-tools/maven-scala-plugin)，其配置方式如下：

```xml
<plugin>
    <groupId>org.scala-tools</groupId>
    <artifactId>maven-scala-plugin</artifactId>
    <version>2.15.2</version>
    <configuration>
        <recompileMode>modified-only</recompileMode>
    </configuration>
    <executions>
        <execution>
            <id>main-scalac</id>
            <phase>process-resources</phase>
            <goals>
                <goal>add-source</goal>
                <goal>compile</goal>
            </goals>
        </execution>
    </executions>
</plugin>
```
该插件从2011年起就没有更新过，官网地址也已失效，无法找到有效的支持文档

方法二：通过新插件指定外部依赖
经过搜索，找到了一款新插件：https://mvnrepository.com/artifact/net.alchim31.maven/scala-maven-plugin，pom.xml 中这样配置：

```xml
<plugin>
    <groupId>net.alchim31.maven</groupId>
    <artifactId>scala-maven-plugin</artifactId>
    <version>3.2.1</version>
    <executions>
        <execution>
            <id>scala-compile-first</id>
            <phase>process-resources</phase>
            <goals>
                <goal>add-source</goal>
                <goal>compile</goal>
            </goals>
        </execution>
        <execution>
            <id>scala-test-compile</id>
            <phase>process-test-resources</phase>
            <goals>
                <goal>add-source</goal>
                <goal>testCompile</goal>
            </goals>
        </execution>
    </executions>
    <configuration>
        <args>
            <!-- 编译时使用 libs 目录下的 jar 包，通过 mvn scala:help 查看说明 -->
            <arg>-extdirs</arg>
            <arg>${project.basedir}/libs</arg>
        </args>
        <scalaVersion>2.11.8</scalaVersion>
    </configuration>
</plugin>
```


https://blog.csdn.net/u013998466/article/details/105297609

https://bbs.huaweicloud.com/blogs/192523

# maven 打包插件

plugin|	function
-|-
maven-jar-plugin|	maven 默认打包插件，用来创建 project jar	
maven-shade-plugin|	用来打可执行包，executable(fat) jar	http://maven.apache.org/plugins/maven-shade-plugin/examples/includes-excludes.html
maven-assembly-plugin|	支持定制化打包方式，例如 apache 项目的打包方式	http://maven.apache.org/plugins/maven-assembly-plugin/usage.html


https://bbs.huaweicloud.com/blogs/232329

https://run-zheng.github.io/2019/11/06/maven-shade-plugin/


# hdfs 命令

http://lxw1234.com/archives/2015/08/452.htm

# yarn 常用命令

```sh
yarn  application -list  打印任务信息
yarn application -status application_1436784252938_0022 查看任务状态
yarn applicaton -kill  applicationId  kill 任务
```

https://cloud.tencent.com/developer/article/1807709


```sh
yarn-client is Equivalent to yarn with --deploy-mode client, which is preferred to `yarn-client`

yarn-cluster is Equivalent to yarn with --deploy-mode cluster, which is preferred to `yarn-cluster`

So yarn-client and yarn-cluster are deprecated.
```


https://www.quora.com/When-should-apache-spark-be-run-in-yarn-cluster-mode-vs-yarn-client-mode-A-use-case-example-for-both-approaches-would-be-more-helpful


# jvm 寻找class的顺序

1. Bootstrap classes

属于Java 平台核心的class,比如java.lang.String等.及rt.jar等重要的核心级别的class.这是由JVM Bootstrap class loader来载入的.一般是放置在{java_home}\jre\lib目录下

2. Extension classes

基于Java扩展机制,用来扩展Java核心功能模块.比如Java串口通讯模块comm.jar.一般放置在{Java_home}\jre\lib\ext目录下

3. User classes

开发人员或其他第三方开发的Java程序包.通过命令行的-classpath或-cp,或者通过设置CLASSPATH环境变量来引用.JVM通过放置在{java_home}\lib\tools.jar来寻找和调用用户级的class.常用的javac也是通过调用tools.jar来寻找用户指定的路径来编译Java源程序.这样就引出了User class路径搜索的顺序或优先级别的问题.

3.1 缺省值:调用Java或javawa的当前路径(.),是开发的class所存在的当前目录
3.2 CLASSPATH环境变量设置的路径.如果设置了CLASSPATH,则CLASSPATH的值会覆盖缺省值
3.3 执行Java的命令行-classpath或-cp的值,如果制定了这两个命令行参数之一,它的值会覆盖环境变量CLASSPATH的值
3.4 -jar 选项:如果通过java -jar 来运行一个可执行的jar包,这当前jar包会覆盖上面所有的值.换句话说,-jar 后面所跟的jar包的优先级别最高,如果指定了-jar选项,所有环境变量和命令行制定的搜索路径都将被忽略.JVM APPClassloader将只会以jar包为搜索范围.
有关可执行jar有许多相关的安全方面的描述,可以参考http://java.sun.com/docs/books/tutorial/jar/ 来全面了解.
这也是为什么应用程序打包成可执行的jar包后,不管你怎么设置classpath都不能引用到第三方jar包的东西了.



# java 运行时指定外部jar包

因为使用“-jar”选项（形如：java -jar xxx.jar ）来运行一个可执行的jar包时，jar包会覆“-cp”的值。
换句话说，-jar 后面所跟的jar包的优先级别最高。如果指定了-jar选项，所有环境变量和命令行制定的搜索路径都将被忽略。JVM APPClassloader将只会以jar包为搜索范围.

Java 命令行提供了如何扩展bootStrap 级别class的简单方法.

-Xbootclasspath: 完全取代基本核心的Java class 搜索路径.不常用,否则要重新写所有Java 核心class
-Xbootclasspath/a: 后缀。将classpath添加在核心class搜索路径后面。常用!!
-Xbootclasspath/p: 前缀。将classpath添加在核心class搜索路径前面.不常用,避免引起不必要的冲突.


https://blog.csdn.net/sayyy/article/details/811207490

https://blog.csdn.net/w47_csdn/article/details/80254459

# Java中path，-classpath，-Djava.library.path的功能和区别


- -Djava.library.path
指定非java类包的位置（如：dll，so）

如运行jar包:

```sh

java -cp a.jar:b.jar:./libs/* -Djava.library.path=./libs com.test.Main param1 param2

-cp：声明依赖的a.jar，b.jar和libs下面所有的jar包；

-Djava.library.path：指定依赖的非Java库文件路径，也放在libs目录下面；
```

https://www.cnblogs.com/lujiango/p/9619524.html


# spark 依赖外部三方jar包

park-submit的时候如何引入外部jar包
在通过spark-submit提交任务时，可以通过添加配置参数来指定
–driver-class-path 外部jar包 –jars 外部jar包

方法一：spark-submit –jars

根据spark官网，在提交任务的时候指定–jars，用逗号分开。这样做的缺点是每次都要指定jar包，如果jar包少的话可以这么做，但是如果多的话会很麻烦。

命令：spark-submit --master yarn-client --jars .jar,.jar

方法二：extraClassPath

提交时在spark-default中设定参数，将所有需要的jar包考到一个文件里，然后在参数中指定该目录就可以了，较上一个方便很多：

spark.executor.extraClassPath=/home/hadoop/wzq_workspace/lib/* spark.driver.extraClassPath=/home/hadoop/wzq_workspace/lib/*

需要注意的是,你要在所有可能运行spark任务的机器上保证该目录存在，并且将jar包考到所有机器上。这样做的好处是提交代码的时候不用再写一长串jar了，缺点是要把所有的jar包都拷一遍。


https://www.jianshu.com/p/79509eccc611

https://www.shuzhiduo.com/A/mo5kPw7Qdw/

https://blog.csdn.net/u011291276/article/details/96429844

https://cloud.tencent.com/developer/article/1054347