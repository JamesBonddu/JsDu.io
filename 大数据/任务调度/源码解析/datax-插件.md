# datax 插件编写

https://blog.csdn.net/qq_39945938/article/details/117959051


# datax 脱敏

https://github.com/guohf/DataX-Masking


# 动态自定义 transformer

https://github.com/build2last/DIY-DataX-Transformer


# Datax 解析任务

构建的核心内容抽象 `DataxTaskExecutionContext` 结构如下

```java
public class DataxTaskExecutionContext implements Serializable {
    /**
     * dataSourceId
     */
    private int dataSourceId;

    /**
     * sourcetype
     */
    private DbType sourcetype;

    /**
     * sourceConnectionParams
     */
    private String sourceConnectionParams;

    /**
     * dataTargetId
     */
    private int dataTargetId;

    /**
     * targetType
     */
    private DbType targetType;

    /**
     * targetConnectionParams
     */
    private String targetConnectionParams;
}
```

构建 `DataxTaskExecutionContext` 过程如下:

```java
DataSourceParameters dbSource = (DataSourceParameters) parametersHelper.getResourceParameters(ResourceType.DATASOURCE, dataSource);
DataSourceParameters dbTarget = (DataSourceParameters) parametersHelper.getResourceParameters(ResourceType.DATASOURCE, dataTarget);

if (Objects.nonNull(dbSource)) {
    dataxTaskExecutionContext.setDataSourceId(dataSource);
    dataxTaskExecutionContext.setSourcetype(dbSource.getType());
    dataxTaskExecutionContext.setSourceConnectionParams(dbSource.getConnectionParams());
}

if (Objects.nonNull(dbTarget)) {
    dataxTaskExecutionContext.setDataTargetId(dataTarget);
    dataxTaskExecutionContext.setTargetType(dbTarget.getType());
    dataxTaskExecutionContext.setTargetConnectionParams(dbTarget.getConnectionParams());
}
```


```java
ObjectNode job = JSONUtils.createObjectNode();
job.putArray("content").addAll(buildDataxJobContentJson());
job.set("setting", buildDataxJobSettingJson());

ObjectNode root = JSONUtils.createObjectNode();
root.set("job", job);
root.set("core", buildDataxCoreJson());
json = root.toString();



/**
* build datax job config
*
* @return collection of datax job config JSONObject
*/
private List<ObjectNode> buildDataxJobContentJson() {

    BaseConnectionParam dataSourceCfg = (BaseConnectionParam) DataSourceUtils.buildConnectionParams(
            dataxTaskExecutionContext.getSourcetype(),
            dataxTaskExecutionContext.getSourceConnectionParams());

    BaseConnectionParam dataTargetCfg = (BaseConnectionParam) DataSourceUtils.buildConnectionParams(
            dataxTaskExecutionContext.getTargetType(),
            dataxTaskExecutionContext.getTargetConnectionParams());

    List<ObjectNode> readerConnArr = new ArrayList<>();
    ObjectNode readerConn = JSONUtils.createObjectNode();

    ArrayNode sqlArr = readerConn.putArray("querySql");
    for (String sql : new String[]{dataXParameters.getSql()}) {
        sqlArr.add(sql);
    }

    ArrayNode urlArr = readerConn.putArray("jdbcUrl");
    urlArr.add(DataSourceUtils.getJdbcUrl(DbType.valueOf(dataXParameters.getDsType()), dataSourceCfg));

    readerConnArr.add(readerConn);

    ObjectNode readerParam = JSONUtils.createObjectNode();
    readerParam.put("username", dataSourceCfg.getUser());
    readerParam.put("password", decodePassword(dataSourceCfg.getPassword()));
    readerParam.putArray("connection").addAll(readerConnArr);

    ObjectNode reader = JSONUtils.createObjectNode();
    reader.put("name", DataxUtils.getReaderPluginName(dataxTaskExecutionContext.getSourcetype()));
    reader.set("parameter", readerParam);

    List<ObjectNode> writerConnArr = new ArrayList<>();
    ObjectNode writerConn = JSONUtils.createObjectNode();
    ArrayNode tableArr = writerConn.putArray("table");
    tableArr.add(dataXParameters.getTargetTable());

    writerConn.put("jdbcUrl", DataSourceUtils.getJdbcUrl(DbType.valueOf(dataXParameters.getDtType()), dataTargetCfg));
    writerConnArr.add(writerConn);

    ObjectNode writerParam = JSONUtils.createObjectNode();
    writerParam.put("username", dataTargetCfg.getUser());
    writerParam.put("password", decodePassword(dataTargetCfg.getPassword()));

    String[] columns = parsingSqlColumnNames(dataxTaskExecutionContext.getSourcetype(),
            dataxTaskExecutionContext.getTargetType(),
            dataSourceCfg, dataXParameters.getSql());

    ArrayNode columnArr = writerParam.putArray("column");
    for (String column : columns) {
        columnArr.add(column);
    }
    writerParam.putArray("connection").addAll(writerConnArr);

    if (CollectionUtils.isNotEmpty(dataXParameters.getPreStatements())) {
        ArrayNode preSqlArr = writerParam.putArray("preSql");
        for (String preSql : dataXParameters.getPreStatements()) {
            preSqlArr.add(preSql);
        }

    }

    if (CollectionUtils.isNotEmpty(dataXParameters.getPostStatements())) {
        ArrayNode postSqlArr = writerParam.putArray("postSql");
        for (String postSql : dataXParameters.getPostStatements()) {
            postSqlArr.add(postSql);
        }
    }

    ObjectNode writer = JSONUtils.createObjectNode();
    writer.put("name", DataxUtils.getWriterPluginName(dataxTaskExecutionContext.getTargetType()));
    writer.set("parameter", writerParam);

    List<ObjectNode> contentList = new ArrayList<>();
    ObjectNode content = JSONUtils.createObjectNode();
    content.set("reader", reader);
    content.set("writer", writer);
    contentList.add(content);

    return contentList;
}

/**
* build datax setting config
*
* @return datax setting config JSONObject
*/
private ObjectNode buildDataxJobSettingJson() {

    ObjectNode speed = JSONUtils.createObjectNode();

    speed.put("channel", DATAX_CHANNEL_COUNT);

    if (dataXParameters.getJobSpeedByte() > 0) {
        speed.put("byte", dataXParameters.getJobSpeedByte());
    }

    if (dataXParameters.getJobSpeedRecord() > 0) {
        speed.put("record", dataXParameters.getJobSpeedRecord());
    }

    ObjectNode errorLimit = JSONUtils.createObjectNode();
    errorLimit.put("record", 0);
    errorLimit.put("percentage", 0);

    ObjectNode setting = JSONUtils.createObjectNode();
    setting.set("speed", speed);
    setting.set("errorLimit", errorLimit);

    return setting;
}

private ObjectNode buildDataxCoreJson() {

    ObjectNode speed = JSONUtils.createObjectNode();
    speed.put("channel", DATAX_CHANNEL_COUNT);

    if (dataXParameters.getJobSpeedByte() > 0) {
        speed.put("byte", dataXParameters.getJobSpeedByte());
    }

    if (dataXParameters.getJobSpeedRecord() > 0) {
        speed.put("record", dataXParameters.getJobSpeedRecord());
    }

    ObjectNode channel = JSONUtils.createObjectNode();
    channel.set("speed", speed);

    ObjectNode transport = JSONUtils.createObjectNode();
    transport.set("channel", channel);

    ObjectNode core = JSONUtils.createObjectNode();
    core.set("transport", transport);

    return core;
}
```


1. Controller接口接收DataxJobDTO参数
2. 针对不同的参数解析成对应的reader和writer
3. 组装逻辑代码, 将源和目的拼凑成一个datax job对应的json
4. 返回给前端完整的源-目的job对应完整的json
5. 通过`task-definition` 和 `task-instance` 等定义传递完整的job json
