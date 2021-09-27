# 添加生成表格


```sh
curl 'http://localhost:8080/jeecg-boot/online/cgform/api/addAll' \
  -H 'Connection: keep-alive' \
  -H 'sec-ch-ua: "Google Chrome";v="93", " Not;A Brand";v="99", "Chromium";v="93"' \
  -H 'sec-ch-ua-mobile: ?0' \
  -H 'User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/93.0.4577.82 Safari/537.36' \
  -H 'Content-Type: application/json;charset=UTF-8' \
  -H 'Accept: application/json, text/plain, */*' \
  -H 'tenant-id: 0' \
  -H 'X-Access-Token: eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJleHAiOjE2MzI2MzkyNjIsInVzZXJuYW1lIjoiYWRtaW4ifQ.RucChqa6Stb8yTC3zjsmn_n7ecYVIRqh2s3Jx62K2Z0' \
  -H 'sec-ch-ua-platform: "Windows"' \
  -H 'Origin: http://localhost:3000' \
  -H 'Sec-Fetch-Site: same-site' \
  -H 'Sec-Fetch-Mode: cors' \
  -H 'Sec-Fetch-Dest: empty' \
  -H 'Referer: http://localhost:3000/' \
  -H 'Accept-Language: zh-CN,zh;q=0.9,en;q=0.8,zh-TW;q=0.7' \
  --data-raw '{"head":{"tableName":"pms_category","tableTxt":"产品类别表","tableType":1,"formCategory":"demo","idType":"UUID","isCheckbox":"Y","themeTemplate":"normal","formTemplate":"1","scroll":1,"isPage":"Y","isTree":"N","isDesForm":"N","desFormCode":"","extConfigJson":"{\"reportPrintShow\":0,\"reportPrintUrl\":\"\",\"joinQuery\":0,\"modelFullscreen\":0,\"modalMinWidth\":\"\"}"},"fields":[{"dbFieldName":"id","dbFieldTxt":"主键","queryDictField":"","queryDictText":"","queryDefVal":"","queryDictTable":"","queryConfigFlag":"0","mainTable":"","mainField":"","fieldHref":"","dictField":"","dictText":"","fieldMustInput":"0","dictTable":"","fieldLength":"120","fieldDefaultValue":"","fieldExtendJson":"","converter":"","isShowForm":"0","isShowList":"0","sortFlag":"0","isReadOnly":"1","fieldShowType":"text","isQuery":"0","queryMode":"single","dbLength":"36","dbPointLength":"0","dbDefaultVal":"","orderNum":1,"dbType":"string","dbIsKey":"1","dbIsNull":"0","order_num":0},{"dbFieldName":"create_by","dbFieldTxt":"创建人","queryDictField":"","queryDictText":"","queryDefVal":"","queryDictTable":"","queryConfigFlag":"0","mainTable":"","mainField":"","fieldHref":"","dictField":"","dictText":"","fieldMustInput":"0","dictTable":"","fieldLength":"120","fieldDefaultValue":"","fieldExtendJson":"","converter":"","isShowForm":"0","isShowList":"0","sortFlag":"0","isReadOnly":"0","fieldShowType":"text","isQuery":"0","queryMode":"single","dbLength":"50","dbPointLength":"0","dbDefaultVal":"","orderNum":2,"dbType":"string","dbIsKey":"0","dbIsNull":"1","order_num":1},{"dbFieldName":"create_time","dbFieldTxt":"创建日期","queryDictField":"","queryDictText":"","queryDefVal":"","queryDictTable":"","queryConfigFlag":"0","mainTable":"","mainField":"","fieldHref":"","dictField":"","dictText":"","fieldMustInput":"0","dictTable":"","fieldLength":"120","fieldDefaultValue":"","fieldExtendJson":"","converter":"","isShowForm":"0","isShowList":"0","sortFlag":"0","isReadOnly":"0","fieldShowType":"datetime","isQuery":"0","queryMode":"single","dbLength":"20","dbPointLength":"0","dbDefaultVal":"","orderNum":3,"dbType":"Date","dbIsKey":"0","dbIsNull":"1","order_num":2},{"dbFieldName":"update_by","dbFieldTxt":"更新人","queryDictField":"","queryDictText":"","queryDefVal":"","queryDictTable":"","queryConfigFlag":"0","mainTable":"","mainField":"","fieldHref":"","dictField":"","dictText":"","fieldMustInput":"0","dictTable":"","fieldLength":"120","fieldDefaultValue":"","fieldExtendJson":"","converter":"","isShowForm":"0","isShowList":"0","sortFlag":"0","isReadOnly":"0","fieldShowType":"text","isQuery":"0","queryMode":"single","dbLength":"50","dbPointLength":"0","dbDefaultVal":"","orderNum":4,"dbType":"string","dbIsKey":"0","dbIsNull":"1","order_num":3},{"dbFieldName":"update_time","dbFieldTxt":"更新日期","queryDictField":"","queryDictText":"","queryDefVal":"","queryDictTable":"","queryConfigFlag":"0","mainTable":"","mainField":"","fieldHref":"","dictField":"","dictText":"","fieldMustInput":"0","dictTable":"","fieldLength":"120","fieldDefaultValue":"","fieldExtendJson":"","converter":"","isShowForm":"0","isShowList":"0","sortFlag":"0","isReadOnly":"0","fieldShowType":"datetime","isQuery":"0","queryMode":"single","dbLength":"20","dbPointLength":"0","dbDefaultVal":"","orderNum":5,"dbType":"Date","dbIsKey":"0","dbIsNull":"1","order_num":4},{"dbFieldName":"sys_org_code","dbFieldTxt":"所属部门","queryDictField":"","queryDictText":"","queryDefVal":"","queryDictTable":"","queryConfigFlag":"0","mainTable":"","mainField":"","fieldHref":"","dictField":"","dictText":"","fieldMustInput":"0","dictTable":"","fieldLength":"120","fieldDefaultValue":"","fieldExtendJson":"","converter":"","isShowForm":"0","isShowList":"0","sortFlag":"0","isReadOnly":"0","fieldShowType":"text","isQuery":"0","queryMode":"single","dbLength":"64","dbPointLength":"0","dbDefaultVal":"","orderNum":6,"dbType":"string","dbIsKey":"0","dbIsNull":"1","order_num":5},{"dbFieldName":"name_cn","dbFieldTxt":"中文名称","queryDictField":"","queryDictText":"","queryDefVal":"","queryShowType":"text","queryDictTable":"","queryConfigFlag":"1","mainTable":"","mainField":"","fieldHref":"","dictField":"","dictText":"","fieldValidType":"only","fieldMustInput":"1","dictTable":"","fieldLength":"120","fieldDefaultValue":"","fieldExtendJson":"","converter":"","isShowForm":"1","isShowList":"1","sortFlag":"0","isReadOnly":"0","fieldShowType":"text","isQuery":"1","queryMode":"single","dbLength":32,"dbPointLength":0,"dbDefaultVal":"","orderNum":7,"dbType":"string","dbIsKey":"0","dbIsNull":"1","order_num":6},{"dbFieldName":"name_en","dbFieldTxt":"英文名称","queryDictField":"","queryDictText":"","queryDefVal":"","queryShowType":"text","queryDictTable":"","queryConfigFlag":"0","mainTable":"","mainField":"","fieldHref":"","dictField":"","dictText":"","fieldMustInput":"0","dictTable":"","fieldLength":"120","fieldDefaultValue":"","fieldExtendJson":"","converter":"","isShowForm":"1","isShowList":"1","sortFlag":"0","isReadOnly":"0","fieldShowType":"text","isQuery":"0","queryMode":"single","dbLength":32,"dbPointLength":0,"dbDefaultVal":"","orderNum":8,"dbType":"string","dbIsKey":"0","dbIsNull":"1","order_num":7}],"indexs":[{"indexName":"name_cn_index","indexField":"name_cn","indexType":"unique"}],"deleteFieldIds":[],"deleteIndexIds":[]}' \
  --compressed

```

# 添加代码生成

```sh
curl 'http://localhost:8080/jeecg-boot/online/cgform/api/doDbSynch/6ee186bf8fda4f09a3bff40602a190b4/normal' \
  -X 'OPTIONS' \
  -H 'Connection: keep-alive' \
  -H 'Accept: */*' \
  -H 'Access-Control-Request-Method: POST' \
  -H 'Access-Control-Request-Headers: tenant-id,x-access-token' \
  -H 'Origin: http://localhost:3000' \
  -H 'User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/93.0.4577.82 Safari/537.36' \
  -H 'Sec-Fetch-Mode: cors' \
  -H 'Sec-Fetch-Site: same-site' \
  -H 'Sec-Fetch-Dest: empty' \
  -H 'Referer: http://localhost:3000/' \
  -H 'Accept-Language: zh-CN,zh;q=0.9,en;q=0.8,zh-TW;q=0.7' \
  --compressed
```

# 代码生成-生成文件

```sh
curl 'http://localhost:8080/jeecg-boot/online/cgform/api/codeGenerate' \
  -H 'Connection: keep-alive' \
  -H 'sec-ch-ua: "Google Chrome";v="93", " Not;A Brand";v="99", "Chromium";v="93"' \
  -H 'sec-ch-ua-mobile: ?0' \
  -H 'User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/93.0.4577.82 Safari/537.36' \
  -H 'Content-Type: application/json;charset=UTF-8' \
  -H 'Accept: application/json, text/plain, */*' \
  -H 'tenant-id: 0' \
  -H 'X-Access-Token: eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJleHAiOjE2MzI2MzkyNjIsInVzZXJuYW1lIjoiYWRtaW4ifQ.RucChqa6Stb8yTC3zjsmn_n7ecYVIRqh2s3Jx62K2Z0' \
  -H 'sec-ch-ua-platform: "Windows"' \
  -H 'Origin: http://localhost:3000' \
  -H 'Sec-Fetch-Site: same-site' \
  -H 'Sec-Fetch-Mode: cors' \
  -H 'Sec-Fetch-Dest: empty' \
  -H 'Referer: http://localhost:3000/' \
  -H 'Accept-Language: zh-CN,zh;q=0.9,en;q=0.8,zh-TW;q=0.7' \
  --data-raw '{"projectPath":"D:\\projects\\turing\\data_ai\\jeecg-boot","jspMode":"one","ftlDescription":"产品类别表","jformType":"1","tableName_tmp":"pms_category","entityName":"PmsCategory","entityPackage":"com.turing","packageStyle":"service","codeTypes":"controller,service,dao,mapper,entity,vue","code":"6ee186bf8fda4f09a3bff40602a190b4","tableName":"pms_category"}' \
  --compressed
```

# 快速配置菜单路由

参数|	描述
:-|:-
菜单名字|	测试树列表
菜单请求URL|	/hr/JeecgTreeDemoList
菜单组件路径|	/hr/JeecgTreeDemoList


```sql
 INSERT INTO `sys_permission`(`id`, `parent_id`, `name`, `url`, `component`, `component_name`, `redirect`, `menu_type`, `perms`, `perms_type`, `sort_no`, `always_show`, `icon`, `is_route`, `is_leaf`, `keep_alive`, `hidden`, `description`, `status`, `del_flag`, `rule_flag`, `create_by`, `create_time`, `update_by`, `update_time`, `internal_or_external`) VALUES ('121008911426059sc94', '2a470fc0c3954d9dbb61de6d80846549', '测试树列表', '/hr/JeecgTreeDemoList', 'erp/hr/JeecgTreeDemoList', NULL, NULL, 1, NULL, '1', 1.00, 0, NULL, 1, 1, 1, 0, NULL, '1', 0, 1, 'admin', '2019-12-26 14:45:02', 'admin', '2020-01-06 14:24:14', 0);
```

## 添加产品类型目录

```sh
curl 'http://localhost:8080/jeecg-boot/sys/permission/add' \
  -H 'Connection: keep-alive' \
  -H 'sec-ch-ua: "Google Chrome";v="93", " Not;A Brand";v="99", "Chromium";v="93"' \
  -H 'sec-ch-ua-mobile: ?0' \
  -H 'User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/93.0.4577.82 Safari/537.36' \
  -H 'Content-Type: application/json;charset=UTF-8' \
  -H 'Accept: application/json, text/plain, */*' \
  -H 'X-TIMESTAMP: 20210926150524' \
  -H 'X-Sign: E8A5B869D9108AF063CEAF091F95D8C9' \
  -H 'tenant-id: 0' \
  -H 'X-Access-Token: eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJleHAiOjE2MzI2MzkyNjIsInVzZXJuYW1lIjoiYWRtaW4ifQ.RucChqa6Stb8yTC3zjsmn_n7ecYVIRqh2s3Jx62K2Z0' \
  -H 'sec-ch-ua-platform: "Windows"' \
  -H 'Origin: http://localhost:3000' \
  -H 'Sec-Fetch-Site: same-site' \
  -H 'Sec-Fetch-Mode: cors' \
  -H 'Sec-Fetch-Dest: empty' \
  -H 'Referer: http://localhost:3000/' \
  -H 'Accept-Language: zh-CN,zh;q=0.9,en;q=0.8,zh-TW;q=0.7' \
  --data-raw '{"status":"1","permsType":"1","sortNo":"1","route":true,"menuType":"0","name":"产品管理","url":"/pmscategory","component":"views/pms/modules","icon":"appstore"}' \
  --compressed
```


http://doc.jeecg.com/2043936


## JEECG 开发流程


https://www.bilibili.com/video/BV1Y541147m1?p=11


# BPM 

jBPM是用于构建业务应用程序以帮助自动化业务流程和决策的工具包。

jBPM 起源于 BPM（业务流程管理），但它已经发展到使用户能够选择他们自己的业务自动化路径。它提供了各种功能，可将业务逻辑简化和外部化为可重用资产，例如案例、流程、决策表等。

业务流程 (BPMN2)
案例管理（BPMN2 和 CMMN）
决策管理 ( DMN )
业务规则 (DRL)
业务优化（求解器）
jBPM 可以用作独立服务或嵌入到自定义服务中。它不强制要求使用任何框架，它可以成功地用于

传统 JEE 应用程序 - war/ear 部署
SpringBoot 或 Thorntail（以前称为 WildFly Swarm）- uberjar 部署
独立的java程序

下面是一些工作流引擎产品列表：

轻量级工作流引擎，如：Camunda，Activiti，JBoss jBPM。
BPM套件遵循“零代码”方法，如：IBM，Pega，Software AG。
带DSL的纯状态机，如：Amazon Simple Workflow，Netflix conductor。
简单的“事件反应机器”，如：IFTTT，Zapier，Microsoft Flow。
大数据或ETL的数据流框架，如：Spring Cloud数据流，Apache Airflow。

https://www.jbpm.org/

https://www.jdon.com/workflow-bpm.html

https://github.com/zhangqiangboss/WorkflowAndCamunda