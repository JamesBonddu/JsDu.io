# 生成查询语句

## 创建一个notebook

在指定文件夹创建文件

```sh
curl 'http://47.103.78.125:9002/api/file' \
  -H 'Connection: keep-alive' \
  -H 'Accept: application/json, text/plain, */*' \
  -H 'Accept-Language: en' \
  -H 'User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/99.0.4844.51 Safari/537.36' \
  -H 'Content-Type: application/json' \
  -H 'Origin: http://47.103.78.125:9002' \
  -H 'Referer: http://47.103.78.125:9002/' \
  -H 'Cookie: language=zh_CN; sessionId=6c90da35-97e2-4821-b108-b4cb20bdaf9f; JSESSIONID=593A9F82079EE07C3125CEB7C33A35BE' \
  --data-raw '{"name":"jsdu","folder_id":"24","type":"notebook"}' \
  --compressed \
  --insecure ;
```

```sh
curl 'http://47.103.78.125:9002/api/file' \
  -H 'Connection: keep-alive' \
  -H 'Accept: application/json, text/plain, */*' \
  -H 'Accept-Language: en' \
  -H 'User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/99.0.4844.51 Safari/537.36' \
  -H 'Content-Type: application/json' \
  -H 'Origin: http://47.103.78.125:9002' \
  -H 'Referer: http://47.103.78.125:9002/' \
  -H 'Cookie: language=zh_CN; sessionId=6c90da35-97e2-4821-b108-b4cb20bdaf9f; JSESSIONID=593A9F82079EE07C3125CEB7C33A35BE' \
  --data-raw '{"name":"jsdu","folder_id":"24","type":"notebook"}' \
  --compressed \
  --insecure ;
curl 'http://47.103.78.125:9002/api/files/opened' \
  -X 'PUT' \
  -H 'Connection: keep-alive' \
  -H 'Accept: application/json, text/plain, */*' \
  -H 'Accept-Language: en' \
  -H 'User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/99.0.4844.51 Safari/537.36' \
  -H 'Content-Type: application/json' \
  -H 'Origin: http://47.103.78.125:9002' \
  -H 'Referer: http://47.103.78.125:9002/' \
  -H 'Cookie: language=zh_CN; sessionId=6c90da35-97e2-4821-b108-b4cb20bdaf9f; JSESSIONID=593A9F82079EE07C3125CEB7C33A35BE' \
  --data-raw '{"list":[{"id":"88","name":"jsdu","type":"notebook","uniq":"notebook_88","active":true},{"id":"35","name":"a","type":"notebook","label":"a","uniq":"notebook_35","active":false,"isPreviewMode":false,"mode":"edit"},{"id":"38","name":"rest请求响应","type":"notebook","label":"rest请求响应","uniq":"notebook_38","active":false,"isPreviewMode":false,"mode":"edit"},{"id":"34","name":"main","type":"notebook","label":"main","uniq":"notebook_34","active":false,"isPreviewMode":false,"mode":"edit"},{"id":"45","name":"rest数据集市","type":"notebook","label":"rest数据集市","uniq":"notebook_45","active":false,"isPreviewMode":false,"mode":"edit"},{"id":"55","name":"mysqlconn","type":"notebook","label":"mysqlconn","uniq":"notebook_55","active":false,"isPreviewMode":false,"mode":"edit"},{"id":"84","name":"refresh_data_about_industry_code","type":"notebook","label":"refresh_data_about_industry_code","uniq":"notebook_84","active":false,"isPreviewMode":false,"mode":"edit"},{"id":"42","name":"ck_etl","type":"notebook","label":"ck_etl","uniq":"notebook_42","active":false,"isPreviewMode":false,"mode":"edit"},{"id":"56","name":"dwd_enterprise","type":"notebook","label":"dwd_enterprise","uniq":"notebook_56","active":false,"isPreviewMode":false,"mode":"edit"},{"id":"41","name":"concat_scala_udf","type":"notebook","label":"concat_scala_udf","uniq":"notebook_41","active":false,"isPreviewMode":false,"mode":"edit"},{"id":"48","name":"testds","type":"notebook","label":"testds","uniq":"notebook_48","active":false,"isPreviewMode":false,"mode":"edit"},{"id":"50","name":"01_User_Instructions","type":"notebook","commit_id":"e689c030-5bff-402c-90b5-9c55ad14bf57","is_demo":true,"label":"01_User_Instructions","uniq":"notebook_50_e689c030-5bff-402c-90b5-9c55ad14bf57","active":false,"isPreviewMode":false,"mode":"edit"}]}' \
  --compressed \
  --insecure ;
curl 'http://47.103.78.125:9002/api/files' \
  -H 'Connection: keep-alive' \
  -H 'Accept: application/json, text/plain, */*' \
  -H 'Accept-Language: en' \
  -H 'User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/99.0.4844.51 Safari/537.36' \
  -H 'Referer: http://47.103.78.125:9002/' \
  -H 'Cookie: language=zh_CN; sessionId=6c90da35-97e2-4821-b108-b4cb20bdaf9f; JSESSIONID=593A9F82079EE07C3125CEB7C33A35BE' \
  --compressed \
  --insecure ;
curl 'http://47.103.78.125:9002/api/files/opened' \
  -H 'Connection: keep-alive' \
  -H 'Accept: application/json, text/plain, */*' \
  -H 'Accept-Language: en' \
  -H 'User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/99.0.4844.51 Safari/537.36' \
  -H 'Referer: http://47.103.78.125:9002/' \
  -H 'Cookie: language=zh_CN; sessionId=6c90da35-97e2-4821-b108-b4cb20bdaf9f; JSESSIONID=593A9F82079EE07C3125CEB7C33A35BE' \
  --compressed \
  --insecure ;
curl 'http://47.103.78.125:9002/api/settings/env' \
  -H 'Connection: keep-alive' \
  -H 'Accept: application/json, text/plain, */*' \
  -H 'Accept-Language: en' \
  -H 'User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/99.0.4844.51 Safari/537.36' \
  -H 'Referer: http://47.103.78.125:9002/' \
  -H 'Cookie: language=zh_CN; sessionId=6c90da35-97e2-4821-b108-b4cb20bdaf9f; JSESSIONID=593A9F82079EE07C3125CEB7C33A35BE' \
  --compressed \
  --insecure ;
curl 'http://47.103.78.125:9002/api/schedule/task?&entity_type=notebook&entity_id=88' \
  -H 'Connection: keep-alive' \
  -H 'Accept: application/json, text/plain, */*' \
  -H 'Accept-Language: en' \
  -H 'User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/99.0.4844.51 Safari/537.36' \
  -H 'Referer: http://47.103.78.125:9002/' \
  -H 'Cookie: language=zh_CN; sessionId=6c90da35-97e2-4821-b108-b4cb20bdaf9f; JSESSIONID=593A9F82079EE07C3125CEB7C33A35BE' \
  --compressed \
  --insecure ;
curl 'http://47.103.78.125:9002/api/notebook/88' \
  -H 'Connection: keep-alive' \
  -H 'Accept: application/json, text/plain, */*' \
  -H 'Accept-Language: en' \
  -H 'User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/99.0.4844.51 Safari/537.36' \
  -H 'Referer: http://47.103.78.125:9002/' \
  -H 'Cookie: language=zh_CN; sessionId=6c90da35-97e2-4821-b108-b4cb20bdaf9f; JSESSIONID=593A9F82079EE07C3125CEB7C33A35BE' \
  --compressed \
  --insecure ;
curl 'http://47.103.78.125:9002/api/job/8eeaea80-f765-4ddc-ba31-824e1c4f0b6e/log' \
  -H 'Connection: keep-alive' \
  -H 'Accept: application/json, text/plain, */*' \
  -H 'Accept-Language: en' \
  -H 'User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/99.0.4844.51 Safari/537.36' \
  -H 'Referer: http://47.103.78.125:9002/' \
  -H 'Cookie: language=zh_CN; sessionId=6c90da35-97e2-4821-b108-b4cb20bdaf9f; JSESSIONID=593A9F82079EE07C3125CEB7C33A35BE' \
  --compressed \
  --insecure ;
curl 'http://47.103.78.125:9002/api/job/fa8143e4-bfdc-43ea-a5f0-8552e37c1805/log' \
  -H 'Connection: keep-alive' \
  -H 'Accept: application/json, text/plain, */*' \
  -H 'Accept-Language: en' \
  -H 'User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/99.0.4844.51 Safari/537.36' \
  -H 'Referer: http://47.103.78.125:9002/' \
  -H 'Cookie: language=zh_CN; sessionId=6c90da35-97e2-4821-b108-b4cb20bdaf9f; JSESSIONID=593A9F82079EE07C3125CEB7C33A35BE' \
  --compressed \
  --insecure ;
curl 'http://47.103.78.125:9002/api/job/a059b07f-37fb-427d-ab1b-410d8e507f1e/log' \
  -H 'Connection: keep-alive' \
  -H 'Accept: application/json, text/plain, */*' \
  -H 'Accept-Language: en' \
  -H 'User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/99.0.4844.51 Safari/537.36' \
  -H 'Referer: http://47.103.78.125:9002/' \
  -H 'Cookie: language=zh_CN; sessionId=6c90da35-97e2-4821-b108-b4cb20bdaf9f; JSESSIONID=593A9F82079EE07C3125CEB7C33A35BE' \
  --compressed \
  --insecure ;
curl 'http://47.103.78.125:9002/api/job/8603e9be-12ea-4ebb-b3fa-0b55438e1a15/log' \
  -H 'Connection: keep-alive' \
  -H 'Accept: application/json, text/plain, */*' \
  -H 'Accept-Language: en' \
  -H 'User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/99.0.4844.51 Safari/537.36' \
  -H 'Referer: http://47.103.78.125:9002/' \
  -H 'Cookie: language=zh_CN; sessionId=6c90da35-97e2-4821-b108-b4cb20bdaf9f; JSESSIONID=593A9F82079EE07C3125CEB7C33A35BE' \
  --compressed \
  --insecure ;
curl 'http://47.103.78.125:9002/api/job/6fc7873f-46e4-4f26-976d-a88b4030ce5b/log' \
  -H 'Connection: keep-alive' \
  -H 'Accept: application/json, text/plain, */*' \
  -H 'Accept-Language: en' \
  -H 'User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/99.0.4844.51 Safari/537.36' \
  -H 'Referer: http://47.103.78.125:9002/' \
  -H 'Cookie: language=zh_CN; sessionId=6c90da35-97e2-4821-b108-b4cb20bdaf9f; JSESSIONID=593A9F82079EE07C3125CEB7C33A35BE' \
  --compressed \
  --insecure ;
curl 'http://47.103.78.125:9002/api/job/1354c3a0-9fcb-430d-bbd4-42168ea2e76a/log' \
  -H 'Connection: keep-alive' \
  -H 'Accept: application/json, text/plain, */*' \
  -H 'Accept-Language: en' \
  -H 'User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/99.0.4844.51 Safari/537.36' \
  -H 'Referer: http://47.103.78.125:9002/' \
  -H 'Cookie: language=zh_CN; sessionId=6c90da35-97e2-4821-b108-b4cb20bdaf9f; JSESSIONID=593A9F82079EE07C3125CEB7C33A35BE' \
  --compressed \
  --insecure ;
curl 'http://47.103.78.125:9002/api/job/fb3e1099-9c90-4c14-907b-929cc9e37914/log' \
  -H 'Connection: keep-alive' \
  -H 'Accept: application/json, text/plain, */*' \
  -H 'Accept-Language: en' \
  -H 'User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/99.0.4844.51 Safari/537.36' \
  -H 'Referer: http://47.103.78.125:9002/' \
  -H 'Cookie: language=zh_CN; sessionId=6c90da35-97e2-4821-b108-b4cb20bdaf9f; JSESSIONID=593A9F82079EE07C3125CEB7C33A35BE' \
  --compressed \
  --insecure ;
curl 'http://47.103.78.125:9002/api/job/045de15d-93f5-4507-a809-3c142e67af8f/log' \
  -H 'Connection: keep-alive' \
  -H 'Accept: application/json, text/plain, */*' \
  -H 'Accept-Language: en' \
  -H 'User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/99.0.4844.51 Safari/537.36' \
  -H 'Referer: http://47.103.78.125:9002/' \
  -H 'Cookie: language=zh_CN; sessionId=6c90da35-97e2-4821-b108-b4cb20bdaf9f; JSESSIONID=593A9F82079EE07C3125CEB7C33A35BE' \
  --compressed \
  --insecure ;
curl 'http://47.103.78.125:9002/api/job/c4b8bfeb-088d-4ecc-958e-22fd25daf781/log' \
  -H 'Connection: keep-alive' \
  -H 'Accept: application/json, text/plain, */*' \
  -H 'Accept-Language: en' \
  -H 'User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/99.0.4844.51 Safari/537.36' \
  -H 'Referer: http://47.103.78.125:9002/' \
  -H 'Cookie: language=zh_CN; sessionId=6c90da35-97e2-4821-b108-b4cb20bdaf9f; JSESSIONID=593A9F82079EE07C3125CEB7C33A35BE' \
  --compressed \
  --insecure
```

## 向指定的notebook添加数据

```bash
curl 'http://47.103.78.125:9002/api/notebook/38' \
  -X 'PUT' \
  -H 'Connection: keep-alive' \
  -H 'Accept: application/json, text/plain, */*' \
  -H 'Accept-Language: en' \
  -H 'User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/99.0.4844.51 Safari/537.36' \
  -H 'Content-Type: application/json' \
  -H 'Origin: http://47.103.78.125:9002' \
  -H 'Referer: http://47.103.78.125:9002/' \
  -H 'Cookie: language=zh_CN; sessionId=6c90da35-97e2-4821-b108-b4cb20bdaf9f; JSESSIONID=593A9F82079EE07C3125CEB7C33A35BE' \
  --data-raw $'{"cell_list":[{"id":"125","content":"-- 引入udf\\n-- include local.`turing/UDF/concat_udf.concatScalaUDF`\\n\\n-- get 请求获取内容\\n-- http://data.jszwfw.gov.cn:8118/extranet/openportal/pages/resource/resourcelist.html?industry=M\\nSET REST_URL=\\"http://data.jszwfw.gov.cn:8118/extranet/rest/dataOpen/getProvideDepartment?%7B%22token%22:null,%22usertype%22:null,%22params%22:%7B%22ouName%22:%22%22,%22ouType%22:2,%22key%22:%22%22%7D%7D\\";\\n\\n\\nload Rest.`$REST_URL` where\\n`config.connect-timeout`=\\"10s\\"\\nand `config.method`=\\"post\\"\\nand `header.content-type`=\\"application/x-www-form-urlencoded; charset=UTF-8\\"\\n-- 如果失败，会连续尝试三次\\nand `config.retry`=\\"3\\"\\nand `config.cookie`=\\"jisCUSSESSIONID=27010646-6f66-483b-bd4d-49258d0e00cf\\"\\nas apiTable;\\n\\n-- 将rest的二进制返回转换为string的表格\\nselect cast(content as string) as content from apiTable as respTb;\\n\\n-- 一层层直接展平响应的json\\nrun respTb AS JsonExpandExt.`` where inputCol=\\"content\\" AS resp1;\\n\\n-- 通过变量获取sql的输出\\nset respjson=`select cast(custom as string) from resp1 as dt` where type=\\"sql\\";\\n\\n-- 通过select get_json_object获取json的某些字段进行统计\\nSELECT get_json_object(\'\'\'${respjson}\'\'\', \\"$\\") as field1,\\nget_json_object(\'\'\'${respjson}\'\'\', \\"$.ouList\\") as field2\\nas tb2;\\n\\n-- 将指定层级字段直接转换成表格\\nset ouListjson=`select cast(field2 as string) from tb2 as dt` where type=\\"sql\\";\\nload jsonStr.`ouListjson` as tb3;\\n\\n\\n-- select concatScalaUDF(name) from tb3 as output;\\n-- 对比校验ouList中的count\\n-- select sum(resourceCount) from tb3 as output;","job_id":"fb3e1099-9c90-4c14-907b-929cc9e37914","editType":"Byzer-lang","status":"COMPLETED","loadingResult":false}]}' \
  --compressed \
  --insecure ;
curl 'http://47.103.78.125:9002/api/notebook/38' \
  -H 'Connection: keep-alive' \
  -H 'Accept: application/json, text/plain, */*' \
  -H 'Accept-Language: en' \
  -H 'User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/99.0.4844.51 Safari/537.36' \
  -H 'Referer: http://47.103.78.125:9002/' \
  -H 'Cookie: language=zh_CN; sessionId=6c90da35-97e2-4821-b108-b4cb20bdaf9f; JSESSIONID=593A9F82079EE07C3125CEB7C33A35BE' \
  --compressed \
  --insecure
```


# 获取生成的语句内容

```java
获取notebook的content内容

@Slf4j
@RestController
@RequestMapping("api/service/")
@Api("The documentation about notebook open api.")
public class NotebookApiService {

    @Autowired
    private NotebookService notebookService;

    @ApiOperation("Get Notebook Content")
    @GetMapping("/notebook/{id}")
    public Response<NotebookDTO> getNotebook(HttpServletRequest request, @PathVariable("id") @NotNull Integer id) {
```

# 执行查询语句接口

https://docs.mlsql.tech/mlsql-stack/api/run-script.html


## 查询数据库名称

```sql
SELECT *
FROM information_schema.schemata
```

## 查询某个数据库的所有数据表
```sql
set @tb_schema="ds";
SELECT
  table_name, engine, table_type, table_comment, create_time, update_time
FROM information_schema.tables
where table_schema = @tb_schema;
```

## 查询某个数据表的所有数据字段

```sql
set @tb_schema="ds";
set @tb_name="ods_enterprise_2020_0224";
SELECT column_name, column_comment, data_type FROM information_schema.columns WHERE
TABLE_SCHEMA = @tb_schema and table_name = @tb_name;
```

https://stackoverflow.com/questions/193780/how-can-i-find-all-the-tables-in-mysql-with-specific-column-names-in-them
