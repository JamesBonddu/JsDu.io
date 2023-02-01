
```py
pydolphinscheduler/tests/tasks/test_datax.py
from pydolphinscheduler.tasks.datax import CustomDataX, DataX

taskExecutionContext.getTaskParams()
parametersNode.getTaskParams()
```


海豚内部节点测试datax任务参数
```json
{
        "code": code,
        "name": name,
        "version": 1,
        "description": None,
        "delayTime": 0,
        "taskType": "DATAX",
        "taskParams": {
            "customConfig": 0,
            "dsType": "MYSQL",
            "dataSource": 1,
            "dtType": "MYSQL",
            "dataTarget": 1,
            "sql": command,
            "targetTable": target_table,
            "jobSpeedByte": 0,
            "jobSpeedRecord": 1000,
            "xms": 1,
            "xmx": 1,
            "preStatements": [],
            "postStatements": [],
            "localParams": [],
            "resourceList": [],
            "dependence": {},
            "conditionResult": {"successNode": [""], "failedNode": [""]},
            "waitStartTimeout": {},
        },
        "flag": "YES",
        "taskPriority": "MEDIUM",
        "workerGroup": "default",
        "environmentCode": None,
        "failRetryTimes": 0,
        "failRetryInterval": 1,
        "timeoutFlag": "CLOSE",
        "timeoutNotifyStrategy": None,
        "timeout": 0,
    }
```


注册海豚插件
```sh
[INFO] 2022-11-16 10:49:11.110 +0800 org.apache.dolphinscheduler.service.task.TaskPluginManager:[57] - Registering task plugin: DATAX - class org.apache.dolphinscheduler.plugin.task.datax.DataxTaskChannelFactory
```



# 创建任务定义的时候会修改或者更新ParametersNode

```java
ParametersNode
src/main/java/org/apache/dolphinscheduler/api/service/impl/TaskDefinitionServiceImpl.java

createTaskDefinition

createTaskBindsWorkFlow

updateTask

```

# command 获取参数

```java
// add command timezone
Schedule schedule = scheduleMapper.queryByProcessDefinitionCode(command.getProcessDefinitionCode());
if (schedule != null) {
    Map<String, String> commandParams = StringUtils.isNotBlank(command.getCommandParam()) ? JSONUtils.toMap(command.getCommandParam()) : new HashMap<>();
    commandParams.put(Constants.SCHEDULE_TIMEZONE, schedule.getTimezoneId());
    command.setCommandParam(JSONUtils.toJsonString(commandParams));
}
command.setId(null);
result = commandMapper.insert(command);
```

# AbstractCommandExecutor

```java
public abstract class AbstractCommandExecutor {}

ParametersNode
public ParametersNodeBuilder taskParams(String taskParams) {
    this.taskParams = taskParams;
    return this;
}
```

从DataxTaskExecutionContext获取数据源/目的的链接参数


```java
 public DataxTaskExecutionContext generateExtendedContext(ResourceParametersHelper parametersHelper) {}
```

```java
@AutoService(TaskChannelFactory.class)
public class DataxTaskChannelFactory implements TaskChannelFactory {

    @Override
    public String getName() {
        return "DATAX";
    }

    @Override
    public List<PluginParams> getParams() {
        return null;
    }

    @Override
    public TaskChannel create() {
        return new DataxTaskChannel();
    }
}

// src/main/java/org/apache/dolphinscheduler/plugin/task/datax/DataxTaskChannel.java
@Override
public AbstractParameters parseParameters(ParametersNode parametersNode) {
    return JSONUtils.parseObject(parametersNode.getTaskParams(), DataxParameters.class);
}
```

```java
// src/main/java/org/apache/dolphinscheduler/server/worker/runner/WorkerTaskExecuteRunnable.java

protected void beforeExecute() {
    TaskChannel taskChannel = taskPluginManager.getTaskChannelMap().get(taskExecutionContext.getTaskType());
    if (null == taskChannel) {
        throw new TaskPluginException(String.format("%s task plugin not found, please check config file.",
                taskExecutionContext.getTaskType()));
    }
    task = taskChannel.createTask(taskExecutionContext);
}
```


# worker run的主体流程

```java
@Override
public void run() {
    try {
        // 初始化任务
        initializeTask();
        // 开始执行任务之前
        beforeExecute();
        // 任务执行回调
        TaskCallBack taskCallBack = TaskCallbackImpl.builder().workerMessageSender(workerMessageSender)
                .masterAddress(masterAddress).build();
        executeTask(taskCallBack);
        // 任务执行之后
        afterExecute();
    }
}
```

# worker beforeExecute做了以下任务



# taskExecutionContext 设置taskParams的位置

```java
// src/main/java/org/apache/dolphinscheduler/server/master/builder/TaskExecutionContextBuilder.java

public TaskExecutionContextBuilder buildTaskDefinitionRelatedInfo(TaskDefinition taskDefinition) {
    taskExecutionContext.setTaskTimeout(Integer.MAX_VALUE);
    if (taskDefinition.getTimeoutFlag() == TimeoutFlag.OPEN) {
        taskExecutionContext.setTaskTimeoutStrategy(taskDefinition.getTimeoutNotifyStrategy());
        if (taskDefinition.getTimeoutNotifyStrategy() == TaskTimeoutStrategy.FAILED
                || taskDefinition.getTimeoutNotifyStrategy() == TaskTimeoutStrategy.WARNFAILED) {
            taskExecutionContext.setTaskTimeout(
                    Math.min(taskDefinition.getTimeout() * SEC_2_MINUTES_TIME_UNIT, Integer.MAX_VALUE));
        }
    }
    taskExecutionContext.setTaskParams(taskDefinition.getTaskParams());
    return this;
}


// src/main/java/org/apache/dolphinscheduler/server/master/runner/task/BaseTaskProcessor.java

protected TaskExecutionContext getTaskExecutionContext(TaskInstance taskInstance) {
    AbstractParameters baseParam = taskPluginManager.getParameters(ParametersNode.builder()
            .taskType(taskInstance.getTaskType()).taskParams(taskInstance.getTaskParams()).build());
    Map<String, Property> propertyMap =
            curingParamsService.paramParsingPreparation(taskInstance, baseParam, processInstance);
    return TaskExecutionContextBuilder.get()
            .buildTaskInstanceRelatedInfo(taskInstance)
            .buildTaskDefinitionRelatedInfo(taskInstance.getTaskDefine())
            .buildProcessInstanceRelatedInfo(taskInstance.getProcessInstance())
            .buildProcessDefinitionRelatedInfo(taskInstance.getProcessDefine())
            .buildResourceParametersInfo(resources)
            .buildDataQualityTaskExecutionContext(dataQualityTaskExecutionContext)
            .buildK8sTaskRelatedInfo(k8sTaskExecutionContext)
            .buildBusinessParamsMap(businessParamsMap)
            .buildParamInfo(propertyMap)
            .create();
}

```


任务节点定义, 首先将相关的任务参数存储在 `t_ds_task_instance` 的 task_params里
```json
{"localParams":[],"resourceList":[],"customConfig":0,"dsType":"MYSQL","dataSource":1,"dtType":"MYSQL","dataTarget":1,"sql":"select park_name, carrier_category,name, area from carrier","targetTable":"target_carrier","jobSpeedByte":0,"jobSpeedRecord":1000,"preStatements":["truncate table target_carrier"],"postStatements":[],"xms":1,"xmx":1,"conditionResult":"null","dependence":"null","switchResult":"null","waitStartTimeout":null}
```

转换taskParams 通过 buildDataxJsonFile 转换为datax json文件

```java
public static DataSourceProcessor getDatasourceProcessor(DbType dbType) {
    Map<String, DataSourceProcessor> dataSourceProcessorMap = DataSourceProcessorProvider.getInstance().getDataSourceProcessorMap();
    if (!dataSourceProcessorMap.containsKey(dbType.name())) {
        throw new IllegalArgumentException("illegal datasource type");
    }
    return dataSourceProcessorMap.get(dbType.name());
}
```

```json
transformer

"content": [
{
    "reader": {},
    "writer": {},
    "transformer": [
        {
            "name": "dx_substr",
            "parameter":
                {
                "columnIndex":5,
                "paras":["1","3"]
                }
        },
        {
            "name": "dx_replace",
            "parameter":
                {
                "columnIndex":4,
                "paras":["3","4","****"]
                }
        },
        {
            "name": "dx_digest",
            "parameter":
                {
                "columnIndex":3,
                "paras":["md5", "toLowerCase"]
                }
        },
        {
            "name": "dx_groovy",
                "parameter":
                {
                    "code": "//groovy code//",
                    "extraPackage":[
                    "import somePackage1;",
                    "import somePackage2;"
                    ]
                }
        }
    ]
}]
```

```java
// 支持的数据源类型
public class DataSourceConstants {

    public static final String DATASOURCE = "datasource";

    /**
     * driver
     */
    public static final String ORG_POSTGRESQL_DRIVER = "org.postgresql.Driver";
    public static final String COM_MYSQL_CJ_JDBC_DRIVER = "com.mysql.cj.jdbc.Driver";
    public static final String COM_MYSQL_JDBC_DRIVER = "com.mysql.jdbc.Driver";
    public static final String ORG_APACHE_HIVE_JDBC_HIVE_DRIVER = "org.apache.hive.jdbc.HiveDriver";
    public static final String COM_CLICKHOUSE_JDBC_DRIVER = "ru.yandex.clickhouse.ClickHouseDriver";
    public static final String COM_ORACLE_JDBC_DRIVER = "oracle.jdbc.OracleDriver";
    public static final String COM_SQLSERVER_JDBC_DRIVER = "com.microsoft.sqlserver.jdbc.SQLServerDriver";
    public static final String COM_DB2_JDBC_DRIVER = "com.ibm.db2.jcc.DB2Driver";
    public static final String COM_PRESTO_JDBC_DRIVER = "com.facebook.presto.jdbc.PrestoDriver";
    public static final String COM_REDSHIFT_JDBC_DRIVER = "com.amazon.redshift.jdbc42.Driver";
    public static final String COM_ATHENA_JDBC_DRIVER = "com.simba.athena.jdbc.Driver";
}
```


## DATAX 自定义转换json的方法

```sh
# 设置参数
customConfig = 1
json	String	自定义配置	customConfig=1时生效
localParams	Array	自定义参数	customConfig=1时生效
```

# datax DataxParameters 拼装过程
DataxParameters
```java
// 通过 `getTaskParams` 直接拼装出来所需要的参数了
dataXParameters = JSONUtils.parseObject(taskExecutionContext.getTaskParams(), DataxParameters.class);
```


```json
{
    "localParams": [],
    "resourceList": [],
    "customConfig": 0,
    "dsType": "MYSQL",
    "dataSource": 1,
    "dtType": "MYSQL",
    "dataTarget": 1,
    "sql": "select park_name, carrier_category,name, area from carrier",
    "targetTable": "target_carrier",
    "jobSpeedByte": 0,
    "jobSpeedRecord": 1000,
    "preStatements": [
        "truncate table target_carrier"
    ],
    "postStatements": [],
    "xms": 1,
    "xmx": 1,
    "conditionResult": "null",
    "dependence": "null",
    "switchResult": "null",
    "waitStartTimeout": null,
    "json": {}
}
```

# 对应json的任务是

```json
{
    "setting": {},
    "job": {
        "setting": {
            "speed": {
                "channel": 2
            }
        },
        "content": [
            {
                "reader": {
                    "name": "txtfilereader",
                    "parameter": {
                        "path": "https://www.stats.govt.nz/assets/Uploads/Annual-enterprise-survey/Annual-enterprise-survey-2021-financial-year-provisional/Download-data/annual-enterprise-survey-2021-financial-year-provisional-csv.csv",
                        "encoding": "UTF-8",
                        "column": ["*"],
                        "fieldDelimiter": ","
                    }
                },
                "writer": {
                    "name": "streamwriter",
                    "parameter": {
                        "print":true,
                        "encoding": "UTF-8"
                    }
                }
            }
        ]
    }
}
```

```java
{
    "job": {
        "setting": {
            "speed": {
                 "channel":1
            }
        },
        "content": [
            {
                "reader": {
                    "name": "mysqlreader",
                    "parameter": {
                        "username": "root",
                        "password": "root",
                        "connection": [
                            {
                                "querySql": [
                                    "select db_id,on_line_flag from db_info where db_id < 10;"
                                ],
                                "jdbcUrl": [
                                    "jdbc:mysql://bad_ip:3306/database",
                                    "jdbc:mysql://127.0.0.1:bad_port/database",
                                    "jdbc:mysql://127.0.0.1:3306/database"
                                ]
                            }
                        ]
                    }
                },
                "writer": {
                    "name": "streamwriter",
                    "parameter": {
                        "print": false,
                        "encoding": "UTF-8"
                    }
                }
            }
        ]
    }
}
```

```java
// 自定义json直接从 `dataXParameters`获取全部的参数
if (dataXParameters.getCustomConfig() == Flag.YES.ordinal()) {
    json = dataXParameters.getJson().replaceAll("\\r\\n", "\n");
} else {
    /**
    - 拼装 content
    - 拼装 setting
    - 拼装 job
    - 拼装 core
    */

    ObjectNode job = JSONUtils.createObjectNode();
    job.putArray("content").addAll(buildDataxJobContentJson());
    job.set("setting", buildDataxJobSettingJson());

    ObjectNode root = JSONUtils.createObjectNode();
    root.set("job", job);
    root.set("core", buildDataxCoreJson());
    json = root.toString();
}
```


# datax相关设计

```java
// 反射获取字段对应的值
// https://stackoverflow.com/questions/13400075/reflection-generic-get-field-value
Field field = object.getClass().getDeclaredField(fieldName);
field.setAccessible(true);
Object value = field.get(object)
```

https://docs.thinkingdata.cn/ta-manual/latest/technical_document/ta_tool/datax/inner_plugin/ta-data-writer.html#_3-2-%E5%8F%82%E6%95%B0%E8%AF%B4%E6%98%8E

https://docs.thinkingdata.cn/ta-manual/latest/technical_document/ta_tool/datax/outer_plugin/ta-datax-writer.html


https://gitee.com/felixWangCom/datax-all/tree/master

https://github.com/wgzhao/Addax
