# spark 练习

## spark demo 

https://github.com/apache/spark/tree/master/examples/src/main

```sh
hdfs dfs -copyFromLocal hh.md /tmp/hh.md
[root@cdh01 tmp]# hdfs dfs -cat /tmp/hh.md
jsdu
sadaasd

spark-shell
scala> val textFile = spark.read.textFile("hdfs:///tmp/hh.md")
textFile: org.apache.spark.sql.Dataset[String] = [value: string]

scala> textFile.first()
res0: String = jsdu                                                             
scala> textFile.count()
res1: Long = 2
```

# CDH 集群提交Spark作业原理及过程分析

CDH版本的Spark，采用的是yarn模式，在提交spark作业时，默认采用的是yarn-client模式，通过在客户端环境中配置`HADOOP_CONF_DIR和HIVE_CONF_DIR`变量即可指定集群相关信息。

https://mp.weixin.qq.com/s/C5ZPX3K_sDRFWAlgbdyPSg


# CDH 启动Spark Thrift

https://www.cnblogs.com/yaowentao/p/13048664.html

# spark2.4.0 CDH6.3.2链接

```xml
<properties>
        <maven.compiler.source>8</maven.compiler.source>
        <maven.compiler.target>8</maven.compiler.target>
        <spark.version>2.4.0-cdh6.3.2</spark.version>
        <hive.version>2.1.1-cdh6.3.2</hive.version>
    </properties>

    <dependencies>
        <dependency>
            <groupId>org.apache.spark</groupId>
            <artifactId>spark-sql_2.11</artifactId>
            <version>${spark.version}</version>
        </dependency>
        <dependency>
            <groupId>org.apache.spark</groupId>
            <artifactId>spark-core_2.11</artifactId>
            <version>${spark.version}</version>
        </dependency>
        <dependency>
            <groupId>org.apache.spark</groupId>
            <artifactId>spark-hive_2.11</artifactId>
            <version>${spark.version}</version>
            <exclusions>
                <exclusion>
                    <artifactId>hive-metastore</artifactId>
                    <groupId>org.spark-project.hive</groupId>
                </exclusion>
                <exclusion>
                    <artifactId>hive-exec</artifactId>
                    <groupId>org.spark-project.hive</groupId>
                </exclusion>
            </exclusions>
        </dependency>
<!--        <dependency>-->
<!--            <groupId>org.apache.hive</groupId>-->
<!--            <artifactId>hive-metastore</artifactId>-->
<!--            <version>${hive.version}</version>-->
<!--        </dependency>-->
        <dependency>
            <groupId>org.apache.hive</groupId>
            <artifactId>hive-exec</artifactId>
            <version>${hive.version}</version>
            <exclusions>
                <exclusion>
                    <groupId>*</groupId>
                    <artifactId>*</artifactId>
                </exclusion>
            </exclusions>
        </dependency>
    </dependencies>
```

https://blog.csdn.net/su_cicada/article/details/112263102


# 本地写好spark程序远程提交到CDH执行

https://stackoverflow.com/questions/49265613/submit-a-spark-job-on-a-yarn-cluster-from-a-remote-client

https://theckang.github.io/2015/12/31/remote-spark-jobs-on-yarn.html

https://github.com/cindysz110/blog/issues/27

https://www.jianshu.com/p/9b2b79f61072

https://blog.51cto.com/lovebetterworld/2839941

https://www.pianshen.com/article/93731308151/



# spark 本地开发以及远程debug设置

https://blog.csdn.net/weixin_45366499/article/details/108518504

https://blog.csdn.net/ping_hu/article/details/77513429

https://blog.csdn.net/zmx729618/article/details/73549583

https://sparkbyexamples.com/spark/spark-setup-run-with-scala-intellij/

