# datax ETL

https://lzyz.fun/bloglist/datax/


# datax


https://github.com/alibaba/DataX/blob/master/introduction.md

https://www.jianshu.com/p/b10fbdee7e56

https://dengchuncui.github.io/2020/10/22/%E3%80%90%E6%95%B0%E6%8D%AE%E5%90%8C%E6%AD%A5%E3%80%91DATAX%20%E5%B7%A5%E4%BD%9C%E5%8E%9F%E7%90%86%E5%8F%8A%E6%BA%90%E7%A0%81%E8%A7%A3%E8%AF%BB/

## datax 核心设计原理

DataX 核心主要由 Job、Task Group、Task、Channel 等概念组成：

1、Job

在 DataX 中用来描述一个源端到一个目的端的同步作业，是 DataX 数据同步面向用户的最小业务单元。一个Job 对应 一个 JobContainer， JobContainer 负责 Job 的全局切分、调度、前置语句和后置语句等工作。

2、Task Group

一组 Task 的集合，根据 DataX 的公平分配策略，公平地分配 Task 到对应的 TaskGroup 中。一个 TaskGroup 对应一个 TaskGroupContainer，负责执行一组 Task。

3、Task

Job 的最小执行单元，一个 Job 可根据 Reader 端切分策略，且分成若干个 Task，以便于并发执行。

Job、Task Group、Task 三者之间的关系可以用如下图表示：

配置中job.content.reader.parameter的value部分会传给Reader.Job；job.content.writer.parameter的value部分会传给Writer.Job ，Reader.Job和Writer.Job可以通过super.getPluginJobConf()来获取。

跟一般的生产者-消费者模式一样，Reader插件和Writer插件之间也是通过channel来实现数据的传输的。channel可以是内存的，也可能是持久化的，插件不必关心。插件通过RecordSender往channel写入数据，通过RecordReceiver从channel读取数据。

channel中的一条数据为一个Record的对象，Record中可以放多个Column对象，这可以简单理解为数据库中的记录和列。

https://objcoding.com/2020/09/06/datax/


https://github.com/alibaba/DataX/blob/master/dataxPluginDev.md

https://github.com/alibaba/DataX/blob/master/txtfilewriter/doc/txtfilewriter.md


## 商业版是DataWorks

https://help.aliyun.com/document_detail/146778.html

https://help.aliyun.com/document_detail/146777.html

# 常见问题


1.[DataX引擎配置错误，该问题通常是由于DataX安装错误引起，请联系您的运维解决 .]. - Job运行速度必须设置
在job下面增加节点（job 下面的 setting 加 speed ）：
```json
 "setting": {
            "speed": {
                "channel": 1
            }
        },
```

2.针对乱码的情况（mssql复制到mysql时中文都是问号）
在datax脚本文件中jdbcUrl项加上：?characterEncoding=utf8
或者 ?autoReconnect=true&useUnicode=true&characterEncoding=utf8&zeroDateTimeBehavior=convertToNull&useSSL=false
就是截图的位置：
[外链图片转存失败(img-jSlmLk0B-1564728858428)(_v_images/20190731204014629_23335.png)]
脚本内容调整为：
 "jdbcUrl":"jdbc:mysql://ip地址:端口/数据库名称?autoReconnect=true&useUnicode=true&characterEncoding=utf8",



# excel 读取报错

https://blog.csdn.net/weixin_40295575/article/details/81354099

```java
// Cell.CELL_TYPE_XXX: 的格式在POI4.0.1的版本是报错的，这种写法兼容哪个版本不清楚。
// 改为以下格式后正常：
// 复制代码
switch (cell.getCellType()) {
                case NUMERIC:

                    break;
                case STRING:
                    cellValue = cell.getStringCellValue();
                    break;
                case BOOLEAN:
                    cellValue = cell.getBooleanCellValue() + "";
                    break;
                case BLANK: //空值
                    cellValue = "";
                case ERROR:
                    cellValue = "非法字符";
                    break;
            }
        }
复制代码
```

https://www.cnblogs.com/fangjb/p/15263120.html

https://segmentfault.com/a/1190000022958692

# easy poi
https://howtodoinjava.com/java/library/readingwriting-excel-files-in-java-poi-tutorial/

# easy Excel

https://developer.aliyun.com/article/787306

https://blog.csdn.net/weixin_37610397/article/details/102657022

https://blog.csdn.net/Zack_tzh/article/details/107952599

# easy poi

https://blog.51cto.com/u_9771070/2722382

https://www.cnblogs.com/tester-ggf/p/13121582.html

https://opensource.afterturn.cn/doc/easypoi.html

http://doc.wupaas.com/docs/easypoi/easypoi-1c0u8m5qd3ksg


https://stackoverflow.com/questions/31844308/java-poi-the-supplied-data-appears-to-be-in-the-office-2007-xml


https://blog.csdn.net/lk142500/article/details/84992504

https://icode.best/i/61289130353464

# 文件格式區別
xlsx 对应的FileMagic为 OOXML
xls 对应的FileMagic为 OLE2

https://zh.wikipedia.org/zh-hans/Office_Open_XML

# wps云文檔

https://www.bookstack.cn/read/wps-doc/45371d00107cc712.md

https://open.wps.cn/docs/office

https://open.wps.cn/docs/doc-ai-open/access-know

http://blog.itpub.net/31563356/viewspace-2772151/

https://blog.csdn.net/qq_35977139/article/details/115540115


# 报错

## Datax配置错误

需要设置好
```java
public static final String DATAX_CORE_DATAXSERVER_ADDRESS = "core.dataXServer.address";

public static final String DATAX_CORE_DATAXSERVER_PROTOCOL = "core.dataXServer.protocol";
```


```sh
09:33:02.356 [job-0] ERROR com.alibaba.datax.core.job.JobContainer - Post report error
org.apache.http.client.ClientProtocolException: URI does not specify a valid host name: http:///api/v1/task/process/report
	at org.apache.http.impl.client.CloseableHttpClient.determineTarget(CloseableHttpClient.java:94)
	at org.apache.http.impl.client.CloseableHttpClient.execute(CloseableHttpClient.java:163)
	at org.apache.http.impl.client.CloseableHttpClient.execute(CloseableHttpClient.java:139)
	at com.alibaba.datax.core.util.HttpClientUtil.executeAndGet(HttpClientUtil.java:124)
	at com.alibaba.datax.core.job.JobContainer.logStatistics(JobContainer.java:744)
	at com.alibaba.datax.core.job.JobContainer.start(JobContainer.java:201)
	at com.alibaba.datax.core.Engine.start(Engine.java:98)
	at com.alibaba.datax.core.Engine.entry(Engine.java:177)
	at com.alibaba.datax.core.Engine.main(Engine.java:242)
```

https://segmentfault.com/a/1190000041022544

## datax-web
修改datax.job配置

- admin.addresses datax_admin部署地址，如调度中心集群部署存在多个地址则用逗号分隔，执行器将会使用该地址进行"执行器心跳注册"和"任务结果回调"；
- executor.appname 执行器AppName，每个执行器机器集群的唯一标示,执行器心跳注册分组依据；
- executor.ip 默认为空表示自动获取IP，多网卡时可手动设置指定IP，该IP不会绑定Host仅作为通讯实用；地址信息用于 "执行器注册" 和 "调度中心请求并触发任务"；
- executor.port 执行器Server端口号，默认端口为9999，单机部署多个执行器时，注意要配置不同执行器端口；
- executor.logpath 执行器运行日志文件存储磁盘路径,需要对该路径拥有读写权限;
- executor.logretentiondays 执行器日志文件保存天数,过期日志自动清理, 限制值大于等于3时生效; 否则, 如-1, 关闭自动清理功能；
- executor.jsonpath datax json临时文件保存路径
- pypath DataX启动脚本地址，例如：xxx/datax/bin/datax.py 如果系统配置DataX环境变量（DATAX_HOME），logpath、jsonpath、pypath可不配，log文件和临时json存放在环境变量路径下。


https://github.com/WeiYe-Jing/datax-web/blob/master/userGuid.md


## dataXserver


```sh

10:27:12.384 [job-0] INFO com.alibaba.datax.core.statistics.container.report.ProcessInnerReporter - Connect to localhost:80 [localhost/127.0.0.1, localhost/0:0:0:0:0:0:0:1] failed: Connection refused: connect
org.apache.http.conn.HttpHostConnectException: Connect to localhost:80 [localhost/127.0.0.1, localhost/0:0:0:0:0:0:0:1] failed: Connection refused: connect
	at org.apache.http.impl.conn.DefaultHttpClientConnectionOperator.connect(DefaultHttpClientConnectionOperator.java:151)
	at org.apache.http.impl.conn.PoolingHttpClientConnectionManager.connect(PoolingHttpClientConnectionManager.java:353)

10:39:42.592 [job-0] ERROR com.alibaba.datax.core.job.JobContainer - Post report error
org.apache.http.conn.HttpHostConnectException: Connect to localhost:80 [localhost/127.0.0.1, localhost/0:0:0:0:0:0:0:1] failed: Connection refused: connect

```

https://github.com/TianLangStudio/DataXServer

https://dengchuncui.github.io/2020/10/22/%E3%80%90%E6%95%B0%E6%8D%AE%E5%90%8C%E6%AD%A5%E3%80%91DATAX%20%E5%B7%A5%E4%BD%9C%E5%8E%9F%E7%90%86%E5%8F%8A%E6%BA%90%E7%A0%81%E8%A7%A3%E8%AF%BB/



# 启动任务命令

```bash
curl 'http://192.168.203.130:9503/api/v1/jobinfo/run/1?userName=admin' \
  -H 'Connection: keep-alive' \
  -H 'Accept: application/json, text/plain, */*' \
  -H 'X-Requested-With: XMLHttpRequest' \
  -H 'User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/96.0.4664.93 Safari/537.36' \
  -H 'Content-language: zh-cn' \
  -H 'Referer: http://192.168.203.130:9503/' \
  -H 'Accept-Language: zh-CN,zh;q=0.9,en;q=0.8,zh-TW;q=0.7' \
  -H 'Cookie: UM-SSO-BDP=eyJob3N0X3BvcnQiOiIxOTIuMTY4LjIwMy4xMzA6OTUwMyIsIlgtQVVUSC1JRCI6ImFkbWluIiwidGstdGltZSI6IjIwMjExMjEyMjI1OTQ5IiwiYWxnIjoiTUQ1In0%3D%2CeyJ1cGRhdGVUaW1lIjoiMjAyMS0xMi0wOCAxODo0NzowNSIsInVzZXJUeXBlIjoyLCJyb2xlIjoic3VwZXIiLCJjcmVhdGVUaW1lIjoiMjAyMS0xMi0wOCAxODo0NzowNSIsIlgtQVVUSC1JRCI6ImFkbWluIn0%3D%2C1ba0d2717864d8fd3e9ff45df33e2808' \
  --compressed \
  --insecure
```


```sh
2021-12-13 00:51:23.600 [job-1681708287759880192] INFO  FileHelper - add file [/home/jsdu/apps/wedatasphere-exchangis-0.5.0.RELEASE/images/zh_CN/ch1/architecture.png] as a candidate to be read.
2021-12-13 00:51:23.600 [job-1681708287759880192] INFO  FileHelper - add file [/home/jsdu/apps/wedatasphere-exchangis-0.5.0.RELEASE/images/zh_CN/ch1/task_list.png] as a candidate to be read.
2021-12-13 00:51:23.600 [job-1681708287759880192] INFO  FileHelper - add file [/home/jsdu/apps/wedatasphere-exchangis-0.5.0.RELEASE/images/zh_CN/ch1/executor_management.png] as a candidate to be read.
2021-12-13 00:51:23.601 [job-1681708287759880192] INFO  FileHelper - add file [/home/jsdu/apps/wedatasphere-exchangis-0.5.0.RELEASE/images/zh_CN/ch1/data_source_list.png] as a candidate to be read.
2021-12-13 00:51:23.601 [job-1681708287759880192] INFO  FileHelper - add file [/home/jsdu/apps/wedatasphere-exchangis-0.5.0.RELEASE/images/zh_CN/ch1/transport_type.png] as a candidate to be read.
2021-12-13 00:51:23.601 [job-1681708287759880192] INFO  FileHelper - add file [/home/jsdu/apps/wedatasphere-exchangis-0.5.0.RELEASE/images/zh_CN/ch1/data_source_new.png] as a candidate to be read.
2021-12-13 00:51:23.601 [job-1681708287759880192] INFO  FileHelper - add file [/home/jsdu/apps/wedatasphere-exchangis-0.5.0.RELEASE/images/zh_CN/ch1/job_config.png] as a candidate to be read.
2021-12-13 00:51:23.601 [job-1681708287759880192] INFO  FileHelper - add file [/home/jsdu/apps/wedatasphere-exchangis-0.5.0.RELEASE/images/zh_CN/ch1/job_config_source.png] as a candidate to be read.
2021-12-13 00:51:23.601 [job-1681708287759880192] INFO  FileHelper - add file [/home/jsdu/apps/wedatasphere-exchangis-0.5.0.RELEASE/images/zh_CN/ch1/system_appuser.png] as a candidate to be read.
2021-12-13 00:51:23.601 [job-1681708287759880192] INFO  FileHelper - add file [/home/jsdu/apps/wedatasphere-exchangis-0.5.0.RELEASE/images/zh_CN/ch1/system_appuser_bind.png] as a candidate to be read.
2021-12-13 00:51:23.601 [job-1681708287759880192] INFO  FileHelper - add file [/home/jsdu/apps/wedatasphere-exchangis-0.5.0.RELEASE/images/zh_CN/ch1/system_executive_user.png] as a candidate to be read.
2021-12-13 00:51:23.601 [job-1681708287759880192] INFO  FileHelper - add file [/home/jsdu/apps/wedatasphere-exchangis-0.5.0.RELEASE/images/zh_CN/ch1/hive_model_new.png] as a candidate to be read.
2021-12-13 00:51:23.601 [job-1681708287759880192] INFO  FileHelper - add file [/home/jsdu/apps/wedatasphere-exchangis-0.5.0.RELEASE/images/zh_CN/ch1/job_info.png] as a candidate to be read.
2021-12-13 00:51:23.601 [job-1681708287759880192] INFO  FileHelper - add file [/home/jsdu/apps/wedatasphere-exchangis-0.5.0.RELEASE/images/zh_CN/ch1/mysql_model_new.png] as a candidate to be read.
2021-12-13 00:51:23.601 [job-1681708287759880192] INFO  FileHelper - add file [/home/jsdu/apps/wedatasphere-exchangis-0.5.0.RELEASE/images/communication.png] as a candidate to be read.
2021-12-13 00:51:23.601 [job-1681708287759880192] INFO  FileHelper - add file [/home/jsdu/apps/wedatasphere-exchangis-0.5.0.RELEASE/LICENSE] as a candidate to be read.
2021-12-13 00:51:23.601 [job-1681708287759880192] INFO  FileHelper - add file [/home/jsdu/apps/wedatasphere-exchangis-0.5.0.RELEASE/README.md] as a candidate to be read.
2021-12-13 00:51:23.601 [job-1681708287759880192] INFO  FileHelper - add file [/home/jsdu/apps/wedatasphere-exchangis-0.5.0.RELEASE.tar.gz] as a candidate to be read.
2021-12-13 00:51:23.601 [job-1681708287759880192] INFO  FileHelper - add file [/home/jsdu/apps/job.json] as a candidate to be read.
2021-12-13 00:51:23.602 [job-1681708287759880192] INFO  ExcelReader$Job - The number of files to read is: [1515]
2021-12-13 00:51:23.604 [job-1681708287759880192] INFO  JobContainer - Loading processors, sourcePath: [proc/src]
2021-12-13 00:51:23.604 [job-1681708287759880192] INFO  JobContainer - Loading processors finished, []
2021-12-13 00:51:23.609 [job-1681708287759880192] ERROR JobContainer - Exception when job run
com.alibaba.datax.common.exception.DataXException: Code:[TxtFileWriter-00], Description:[您的参数配置错误.]. - 您指定的文件路径 : [/tmp/out/hh.json] 创建失败.
	at com.alibaba.datax.common.exception.DataXException.asDataXException(DataXException.java:26)
	at com.alibaba.datax.plugin.writer.txtfilewriter.TxtFileWriter$Job.validateParameter(TxtFileWriter.java:77)
	at com.alibaba.datax.plugin.writer.txtfilewriter.TxtFileWriter$Job.init(TxtFileWriter.java:41)
	at com.alibaba.datax.core.job.JobContainer.initJobWriter(JobContainer.java:822)
	at com.alibaba.datax.core.job.JobContainer.init(JobContainer.java:340)
	at com.alibaba.datax.core.job.JobContainer.start(JobContainer.java:126)
	at com.alibaba.datax.core.Engine.start(Engine.java:98)
	at com.alibaba.datax.core.Engine.entry(Engine.java:177)
	at com.alibaba.datax.core.Engine.main(Engine.java:242)
2021-12-13 00:51:24.562 [job-1681708287759880192] INFO  StandAloneJobContainerCommunicator - Total 0 records, 0 bytes | Speed 0B/s, 0 records/s | Error 0 records, 0 bytes |  All task WaitWriterTime 0.000s |  All task WaitReaderTime 0.000s | Percentage 0.00%
2021-12-13 00:51:24.563 [job-1681708287759880192] ERROR Engine -

该任务最可能的错误原因是:
com.alibaba.datax.common.exception.DataXException: Code:[TxtFileWriter-00], Description:[您的参数配置错误.]. - 您指定的文件路径 : [/tmp/out/hh.json] 创建失败.
	at com.alibaba.datax.common.exception.DataXException.asDataXException(DataXException.java:26)
	at com.alibaba.datax.plugin.writer.txtfilewriter.TxtFileWriter$Job.validateParameter(TxtFileWriter.java:77)
	at com.alibaba.datax.plugin.writer.txtfilewriter.TxtFileWriter$Job.init(TxtFileWriter.java:41)
	at com.alibaba.datax.core.job.JobContainer.initJobWriter(JobContainer.java:822)
	at com.alibaba.datax.core.job.JobContainer.init(JobContainer.java:340)
	at com.alibaba.datax.core.job.JobContainer.start(JobContainer.java:126)
	at com.alibaba.datax.core.Engine.start(Engine.java:98)
	at com.alibaba.datax.core.Engine.entry(Engine.java:177)
	at com.alibaba.datax.core.Engine.main(Engine.java:242)

2021-12-13 00:51:24.564 [Thread-0] INFO  JobContainer - shutdown job container and clean the dirty data
2021-12-13 00:51:24.564 [Thread-0] INFO  JobContainer - invoke destroy method

```
