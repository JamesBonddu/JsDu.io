# Linkis计算治理平台

## 编译

https://github.com/WeBankFinTech/Linkis-Doc/blob/master/zh_CN/Development_Documents/Linkis%E7%BC%96%E8%AF%91%E6%96%87%E6%A1%A3.md


## 主要功能
全局历史
资源管理
参数配置
全局配置
ECM配置[Engine Connection Manager]
微服务配置


Linkis JDBC模块设计的初衷是为了方便用户通过JDBC的方式，便捷的提交SQL任务到Linkis中执行，是客户端轻量化追求的一种体现，该模块的类大多以UJESSQL开头，表示JDBC模块属于linkis的ujes(Unified Job Execution Service，统一任务执行服务)模块的一部分。
Linkis的JDBC模块包含了五个关键的实现类：
- UJESSQLDriver
- UJESSQLConnection
- UJESSQLStatement
- UJESSQLPreStatement
- UJESSQLResultSet

以及许多额外的辅助类，例如数据库元数据UJESSQLDatabaseMetaData，任务执行返回的结果集元数据UJESSQLResultMetaData等。

https://github.com/WeBankFinTech/Linkis/wiki/Linkis-UJES%E8%AE%BE%E8%AE%A1%E6%96%87%E6%A1%A3

https://wforget.github.io/2020/11/01/Linkis-%E6%96%B0%E5%BC%95%E6%93%8E%E5%AE%9E%E7%8E%B0%E5%88%86%E4%BA%AB/


# linkis 公共增强服务

公共增强服务包含

## linkis-bml
## linkis-context-service
## linkis-datasource
## linkis-publicservice

## 展示所有job

```java
import com.webank.wedatasphere.linkis.httpclient.dws.annotation.DWSHttpMessageResult
import com.webank.wedatasphere.linkis.httpclient.dws.response.DWSResult

import scala.beans.BeanProperty


@DWSHttpMessageResult("/api/rest_j/v\\d+/jobhistory/list")
class JobListResult extends DWSResult {

  @BeanProperty
  var tasks: util.ArrayList[util.Map[String, Object]] = _
  @BeanProperty
  var totalPage: Int = _

}

@Target({ElementType.TYPE, ElementType.ANNOTATION_TYPE})
@Retention(RetentionPolicy.RUNTIME)
@Documented
public @interface DWSHttpMessageResult {
    /**
     * Open with [[com.webank.wedatasphere.linkis.common.Message]], specify the method of Message, support regular expressions
     * 与[[com.webank.wedatasphere.linkis.common.Message]]打通，指定Message的method，支持正则表达式
     */
    String value();
}
```


## 设置python引擎

```sh
curl 'http://47.101.149.152:8088/api/rest_j/v1/configuration/saveFullTree' \
  -H 'Proxy-Connection: keep-alive' \
  -H 'Accept: application/json, text/plain, */*' \
  -H 'User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/91.0.4472.124 Safari/537.36' \
  -H 'Content-language: zh-CN' \
  -H 'Content-Type: application/json;charset=UTF-8' \
  -H 'Origin: http://47.101.149.152:8088' \
  -H 'Referer: http://47.101.149.152:8088/' \
  -H 'Accept-Language: zh-CN,zh;q=0.9,en;q=0.8,zh-TW;q=0.7' \
  -H 'Cookie: bdp-user-ticket-id=M7UZXQP9Ld3mUkoBAIiLU5INwlm6vSXg2HLiVea4FcQ=' \
  --data-raw '{"fullTree":[{"name":"队列资源","description":null,"settings":[{"id":26,"key":"wds.linkis.rm.client.memory.max","description":"取值范围：1-100，单位：G","name":"python驱动器内存使用上限","defaultValue":"20G","validateType":"Regex","validateRange":"^([1-9]\\d{0,1}|100)(G|g)$","level":1,"engineType":"python","treeName":"队列资源","valueId":30,"configValue":"","configLabelId":8,"unit":null,"isUserDefined":false,"hidden":false,"advanced":false},{"id":27,"key":"wds.linkis.rm.client.core.max","description":"取值范围：1-128，单位：个","name":"python驱动器核心个数上限","defaultValue":"10","validateType":"Regex","validateRange":"^(?:[1-9]\\d?|[1234]\\d{2}|128)$","level":1,"engineType":"python","treeName":"队列资源","valueId":31,"configValue":"","configLabelId":8,"unit":null,"isUserDefined":false,"hidden":false,"advanced":false},{"id":28,"key":"wds.linkis.rm.instance","description":"范围：1-20，单位：个","name":"python引擎最大并发数","defaultValue":"10","validateType":"NumInterval","validateRange":"[1,20]","level":1,"engineType":"python","treeName":"队列资源","valueId":32,"configValue":"","configLabelId":8,"unit":null,"isUserDefined":false,"hidden":false,"advanced":false}]},{"name":"python引擎设置","description":null,"settings":[{"id":29,"key":"wds.linkis.engineconn.java.driver.memory","description":"取值范围：1-2，单位：G","name":"python引擎初始化内存大小","defaultValue":"1g","validateType":"Regex","validateRange":"^([1-2])(G|g)$","level":1,"engineType":"python","treeName":"python引擎设置","valueId":33,"configValue":"","configLabelId":8,"unit":null,"isUserDefined":false,"hidden":false,"advanced":false},{"id":30,"key":"python.version","description":"取值范围：python2,python3","name":"python版本","defaultValue":"python2","validateType":"OFT","validateRange":"[\"python3\",\"python2\"]","level":1,"engineType":"python","treeName":"python引擎设置","valueId":51,"configValue":"python3","configLabelId":25,"unit":null,"isUserDefined":true,"hidden":false,"advanced":false,"validateRangeList":[{"name":"python3","value":"python3"},{"name":"python2","value":"python2"}]}]}],"creator":"IDE"}' \
  --compressed \
  --insecure
```

## 新增应用

```sh
curl 'http://47.101.149.152:8088/api/rest_j/v1/configuration/createFirstCategory' \
  -H 'Connection: keep-alive' \
  -H 'Accept: application/json, text/plain, */*' \
  -H 'User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/91.0.4472.124 Safari/537.36' \
  -H 'Content-language: zh-CN' \
  -H 'Content-Type: application/json;charset=UTF-8' \
  -H 'Origin: http://47.101.149.152:8088' \
  -H 'Referer: http://47.101.149.152:8088/' \
  -H 'Accept-Language: zh-CN,zh;q=0.9,en;q=0.8,zh-TW;q=0.7' \
  -H 'Cookie: bdp-user-ticket-id=M7UZXQP9Ld3mUkoBAIiLU438y/1UvQzN2HLiVea4FcQ=' \
  --data-raw '{"categoryName":"python3IDE","description":"python3IDE"}' \
  --compressed \
  --insecure

curl 'http://47.101.149.152:8088/api/rest_j/v1/configuration/getFullTreesByAppName?creator=IDE' \
  -H 'Connection: keep-alive' \
  -H 'Accept: application/json, text/plain, */*' \
  -H 'User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/91.0.4472.124 Safari/537.36' \
  -H 'Content-language: zh-CN' \
  -H 'Referer: http://47.101.149.152:8088/' \
  -H 'Accept-Language: zh-CN,zh;q=0.9,en;q=0.8,zh-TW;q=0.7' \
  -H 'Cookie: bdp-user-ticket-id=M7UZXQP9Ld3mUkoBAIiLU438y/1UvQzN2HLiVea4FcQ=' \
  --compressed \
  --insecure
```

## 修改ECM信息

```
curl 'http://47.101.149.152:8088/api/rest_j/v1/linkisManager/modifyEMInfo' \
  -X 'PUT' \
  -H 'Connection: keep-alive' \
  -H 'Accept: application/json, text/plain, */*' \
  -H 'User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/91.0.4472.124 Safari/537.36' \
  -H 'Content-language: zh-CN' \
  -H 'Content-Type: application/json;charset=UTF-8' \
  -H 'Origin: http://47.101.149.152:8088' \
  -H 'Referer: http://47.101.149.152:8088/' \
  -H 'Accept-Language: zh-CN,zh;q=0.9,en;q=0.8,zh-TW;q=0.7' \
  -H 'Cookie: bdp-user-ticket-id=M7UZXQP9Ld3mUkoBAIiLU438y/1UvQzN2HLiVea4FcQ=' \
  --data-raw '{"instance":"iZuf62jr8hyu2q5ak8cnlqZ:9102","labels":[{"labelKey":"emInstance","stringValue":"linkis-cg-engineconnmanager-iZuf62jr8hyu2q5ak8cnlqZ:9102"},{"labelKey":"serverAlias","stringValue":"linkis-cg-engineconnmanager"}],"emStatus":"Healthy","applicationName":"linkis-cg-engineconnmanager"}' \
  --compressed \
  --insecure ;
curl 'http://47.101.149.152:8088/api/rest_j/v1/linkisManager/listAllEMs' \
  -H 'Connection: keep-alive' \
  -H 'Accept: application/json, text/plain, */*' \
  -H 'User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/91.0.4472.124 Safari/537.36' \
  -H 'Content-language: zh-CN' \
  -H 'Referer: http://47.101.149.152:8088/' \
  -H 'Accept-Language: zh-CN,zh;q=0.9,en;q=0.8,zh-TW;q=0.7' \
  -H 'Cookie: bdp-user-ticket-id=M7UZXQP9Ld3mUkoBAIiLU438y/1UvQzN2HLiVea4FcQ=' \
  --compressed \
  --insecure
```


## linkis cli 客户端

```sh
[hadoop@iZuf62jr8hyu2q5ak8cnlqZ linkis]$ bash ./bin/linkis-cli --help
[INFO] LogFile path: /data/apps/dss-stack/linkis/logs/linkis-cli/linkis-client.hadoop.log.20210726141927915696436
[INFO] User does not provide usr-configuration file. Will use default config
Usage: linkis-cli [OPTIONS] 
        command for all types of jobs supported by Linkis
Options:
        --gatewayUrl <String>
                specify linkis gateway url
                default by: 
                optional:true
        --authStg <String>
                specify linkis authentication strategy
                default by: 
                optional:true
        --authKey <String>
                specify linkis authentication key(tokenKey)
                default by: 
                optional:true
        --authVal <String>
                specify linkis authentication value(tokenValue)
                default by: 
                optional:true
        --userConf <String>
                specify user configuration file path(absolute)
                default by: 
                optional:true
        --kill <String>
                specify linkis taskId for job to be killed
                default by: 
                optional:true
        --status <String>
                specify linkis taskId for querying job status
                default by: 
                optional:true
        --help <Boolean>
                false
                default by: false
                optional:true
        -engineType <String>
                specify linkis engineType for this job
                default by: 
                optional:true
        -codeType <String>
                specify linkis runType for this job
                default by: 
                optional:true
        -code <String>
                specify code that you want to execute
                default by: 
                optional:true
        -codePath <String>
                specify file path that contains code you want to execute
                default by: 
                optional:true
        -scriptPath <String>
                specify remote path for your uploaded script
                default by: 
                optional:true
        -submitUser <String>
                specify submit user for this job
                default by: 
                optional:true
        -proxyUser <String>
                specify proxy user who executes your code in Linkis server-side
                default by: 
                optional:true
        -creator <String>
                specify creator for this job
                default by: 
                optional:true
        -outPath <String>
                specify output path for resultSet. If not specified, then output reset to screen(stdout)
                default by: 
                optional:true

MapOptions:
        -confMap <HashMap>
                specify configurationMap(startupMap) for your job. You can put any start-up parameters into this Map(e.g. spark.executor.instances). Input format: -confMap key1=value1 -confMap key2=value2
                default by: null
                optional:true
        -varMap <SpecialMap>
                specify variables map. Variables is for key-word substitution. Use '${key}' to specify key-word. Input substitution rule as follow: -varMap key1=value1 -varMap key2=value2
                default by: null
                optional:true
        -labelMap <HashMap>
                specify label map. You can put any Linkis into this Map. Input format: -labelMap labelName1=labelValue1 -labelMap labelName2=labelValue2
                default by: null
                optional:true
        -sourceMap <HashMap>
                specify source map. Input format: -sourceMap key1=value1 -sourceMap key2=value2
                default by: null
                optional:true


############Execute Success!!!########
```