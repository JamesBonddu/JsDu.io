# Maven 插件

## maven 配置阿里云镜像源
第一步:修改maven根目录下的conf文件夹中的setting.xml文件，内容如下：

```xml
<mirrors>
    <mirror>
      <id>alimaven</id>
      <name>aliyun maven</name>
      <url>http://maven.aliyun.com/nexus/content/groups/public/</url>
      <mirrorOf>central</mirrorOf>        
    </mirror>
  </mirrors>
```
第二步: pom.xml文件里添加
```xml
<repositories>  
        <repository>  
            <id>alimaven</id>  
            <name>aliyun maven</name>  
            <url>http://maven.aliyun.com/nexus/content/groups/public/</url>  
            <releases>  
                <enabled>true</enabled>  
            </releases>  
            <snapshots>  
                <enabled>false</enabled>  
            </snapshots>  
        </repository>  
</repositories>  
```

https://blog.csdn.net/Hello_World_QWP/article/details/82459915

https://juejin.cn/post/6969921446537592845

## maven 使用本地包

https://stackoverflow.com/questions/4955635/how-to-add-local-jar-files-to-a-maven-project

## Maven打包插件之——maven-jar-plugin、maven-assembly-plugin、maven-shade-plugin

打包插件是把class文件，配置文件打包成一个jar(war或者其他格式)的包。而且可执行jar包中包含或者不包含相应的依赖包包，当不包含相应的依赖包时，我们需要建立lib目录，且jar和lib目录在同级别目录。

maven-jar-plugin

可执行jar包与依赖包是分开的，需要建立lib目录来存放所需的依赖包，且jar包与lib目录在同级别目录.

### maven-assembly-plugin 配置文件说明

执行cmd
```sh
mvn assembly:assembly
```

https://www.cnblogs.com/zhangtan/p/7645241.html


http://maven.apache.org/plugins/maven-assembly-plugin/assembly.html



## maven-assembly-plugin

http://maven.apache.org/plugins/maven-assembly-plugin/index.html

https://iogogogo.github.io/2020/01/02/maven-assembly/

https://blog.gavinzh.com/2018/05/25/how-to-use-maven-assembly-plugin/

## 静态代码检查工具

PMD|JaCoCo|sonar

https://blog.csdn.net/liuzhupeng/article/details/106907422