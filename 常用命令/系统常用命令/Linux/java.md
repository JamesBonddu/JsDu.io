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