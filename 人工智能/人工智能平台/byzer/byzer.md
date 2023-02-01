# byzer


# /run/script 运行脚本接口

```java
  @Parameters(Array(
    new Parameter(name = "sql", required = true, description = "MLSQL script content", `type` = "string", allowEmptyValue = false),
    new Parameter(name = "owner", required = false,
      description = "the user who execute this API and also will be used in MLSQL script automatically. " +
        "default: admin. Please set this owner properly.",
      `type` = "boolean", allowEmptyValue = false),
    new Parameter(name = "jobType", required = false, description = "script|stream|sql; default is script", `type` = "string", allowEmptyValue = false),
    new Parameter(name = "executeMode", required = false, description = "query|analyze; default is query", `type` = "string", allowEmptyValue = false),
    new Parameter(name = "jobName", required = false, description = "give the job you submit a name. uuid is ok.", `type` = "string", allowEmptyValue = false),
    new Parameter(name = "timeout", required = false, description = "set timeout value for your job. default is -1 which means it is never timeout. millisecond", `type` = "int", allowEmptyValue = false),
    new Parameter(name = "silence", required = false, description = "the last sql in the script will return nothing. default: false", `type` = "boolean", allowEmptyValue = false),
    new Parameter(name = "sessionPerUser", required = false, description = "If set true, the owner will have their own session otherwise share the same. default: false", `type` = "boolean", allowEmptyValue = false),
    new Parameter(name = "sessionPerRequest", required = false, description = "by default false", `type` = "boolean", allowEmptyValue = false),
    new Parameter(name = "async", required = false, description = "If set true ,please also provide a callback url use `callback` parameter and the job will run in background and the API will return.  default: false", `type` = "boolean", allowEmptyValue = false),
    new Parameter(name = "callback", required = false, description = "Used when async is set true. callback is a url. default: false", `type` = "string", allowEmptyValue = false),
    new Parameter(name = "maxRetries", required = false, description = "Max retries of request callback.", `type` = "int", allowEmptyValue = false),
    new Parameter(name = "skipInclude", required = false, description = "disable include statement. default: false", `type` = "boolean", allowEmptyValue = false),
    new Parameter(name = "skipAuth", required = false, description = "disable table authorize . default: true", `type` = "boolean", allowEmptyValue = false),
    new Parameter(name = "skipGrammarValidate", required = false, description = "validate mlsql grammar. default: true", `type` = "boolean", allowEmptyValue = false),
    new Parameter(name = "includeSchema", required = false, description = "the return value should contains schema info. default: false", `type` = "boolean", allowEmptyValue = false),
    new Parameter(name = "fetchType", required = false, description = "take/collect. default: collect", `type` = "string", allowEmptyValue = false),
    new Parameter(name = "enableQueryWithIndexer", required = false, description = "try query with indexer to speed. default: false", `type` = "boolean", allowEmptyValue = false)
  ))
  @Responses(Array(
    new ApiResponse(responseCode = "200", description = "", content = new Content(mediaType = "application/json",
      schema = new Schema(`type` = "string", format = """{}""", description = "")
    ))
  ))
  @At(path = Array("/run/script"), types = Array(GET, POST))
```

# 创建脚本SQL执行监听器

```java
val context = createScriptSQLExecListener(sparkSession, jobInfo.groupId)

private def createScriptSQLExecListener

    (sparkSession:SparkSession, groupId: String) = {

    val allPathPrefix = fromJson(param("allPathPrefix", "{}"), classOf[Map[String, String]])
    val defaultPathPrefix = param("defaultPathPrefix", "")
    val context = new ScriptSQLExecListener(sparkSession, defaultPathPrefix, allPathPrefix)
    val ownerOption = if (params.containsKey("owner")) Some(param("owner")) else None
    val userDefineParams = params.toMap.filter(f => f._1.startsWith("context.")).map(f => (f._1.substring("context.".length), f._2))
    ScriptSQLExec.setContext(new MLSQLExecuteContext(context, param("owner"), context.pathPrefix(None), groupId,
        userDefineParams ++ Map("__PARAMS__" -> JSONTool.toJsonStr(params().toMap))
    ))
    context.initFromSessionEnv
    context.addEnv("SKIP_AUTH", param("skipAuth", "true"))
    context.addEnv("HOME", context.pathPrefix(None))
    context.addEnv("OWNER", ownerOption.getOrElse("anonymous"))
    context
}
```

# 获取执行结果

```java
  private def getScriptResult(context: ScriptSQLExecListener, sparkSession: SparkSession): String = {
    val result = new StringBuffer()
    val includeSchema = param("includeSchema", "false").toBoolean
    val fetchType = param("fetchType", "collect")
    if (includeSchema) {
      result.append("{")
    }
    context.getLastSelectTable() match {
      case Some(table) =>
        // result hook
        var df = sparkSession.table(table)
        df = ResultRenderManager.call(ResultResp(df, table)).df
        if (includeSchema) {
          result.append(s""" "schema":${df.schema.json},"data": """)
        }

        if (context.env().getOrElse(MLSQLEnvKey.CONTEXT_SYSTEM_TABLE, "false").toBoolean) {
          result.append("[" + WowJsonInferSchema.toJson(df).mkString(",") + "]")
        } else {
          val outputSize = paramAsInt("outputSize", 5000)
          val jsonDF = limitOrNot {
            df.limit(outputSize)
          }.toJSON
          val scriptJsonStringResult = fetchType match {
            case "collect" => jsonDF.collect().mkString(",")
            case "take" => df.toJSON.take(outputSize).mkString(",")
          }
          result.append("[" + scriptJsonStringResult + "]")
        }
      case None =>
        if (!includeSchema) {
          result.append("[]")
        }

    }
    if (includeSchema) {
      result.append("}")
    }
    return result.toString
  }
```


# job manager api

```java
  @Parameters(Array())
  @Responses(Array(
    new ApiResponse(responseCode = "200", description = "", content = new Content(mediaType = "application/json",
      schema = new Schema(`type` = "string", format = """{}""", description = "")
    ))
  ))
  @At(path = Array("/runningjobs"), types = Array(GET, POST))
```

# 停止任务

```java
  @Action(
    summary = "kill specific job", description = ""
  )
  @Parameters(Array(
    new Parameter(name = "groupId", required = false, description = "the job id", `type` = "string", allowEmptyValue = false),
    new Parameter(name = "jobName", required = false, description = "the job name", `type` = "string", allowEmptyValue = false)
  ))
  @Responses(Array(
    new ApiResponse(responseCode = "200", description = "", content = new Content(mediaType = "application/json",
      schema = new Schema(`type` = "string", format = """{}""", description = "")
    ))
  ))
  @At(path = Array("/killjob"), types = Array(GET, POST))
```

# run script 实际执行的地方

RunScriptExecutor

```scala
  def execute(): (Int, String) = {
    val silence = paramAsBoolean("silence", false)
    val sparkSession = getSession
    val includeSchema = param("includeSchema", "false").toBoolean
    var outputResult: String = if (includeSchema) "{}" else "[]"
    try {
      val jobInfo = JobManager.getJobInfo(
        param("owner"), param("jobType", MLSQLJobType.SCRIPT), param("jobName"), param("sql"),
        paramAsLong("timeout", -1L)
      )
      val context = createScriptSQLExecListener(sparkSession, jobInfo.groupId)

      def query = {
        if (paramAsBoolean("async", false)) {
          val htp = findService[HttpTransportService](classOf[HttpTransportService])
          JobManager.asyncRun(sparkSession, jobInfo, () => {
            try {
              ScriptSQLExec.parse(param("sql"), context,
                skipInclude = paramAsBoolean("skipInclude", false),
                skipAuth = paramAsBoolean("skipAuth", true),
                skipPhysicalJob = paramAsBoolean("skipPhysicalJob", false),
                skipGrammarValidate = paramAsBoolean("skipGrammarValidate", true))

              outputResult = getScriptResult(context, sparkSession)
              htp.post(new Url(param("callback")),
                Map("stat" -> s"""succeeded""",
                  "res" -> outputResult,
                  "jobInfo" -> JSONTool.toJsonStr(jobInfo)).asJava)
            } catch {
              case e: Exception =>
                e.printStackTrace()
                val msgBuffer = ArrayBuffer[String]()
                if (paramAsBoolean("show_stack", false)) {
                  format_full_exception(msgBuffer, e)
                }
                htp.post(new Url(param("callback")),
                  Map("stat" -> s"""failed""",
                    "msg" -> (e.getMessage + "\n" + msgBuffer.mkString("\n")),
                    "jobInfo" -> JSONTool.toJsonStr(jobInfo)
                  ).asJava)
            }
          })
        } else {
          JobManager.run(sparkSession, jobInfo, () => {
            ScriptSQLExec.parse(param("sql"), context,
              skipInclude = paramAsBoolean("skipInclude", false),
              skipAuth = paramAsBoolean("skipAuth", true),
              skipPhysicalJob = paramAsBoolean("skipPhysicalJob", false),
              skipGrammarValidate = paramAsBoolean("skipGrammarValidate", true)
            )
            if (!silence) {
              outputResult = getScriptResult(context, sparkSession)
            }
          })
        }
      }

      def analyze = {
        ScriptSQLExec.parse(param("sql"), context,
          skipInclude = false,
          skipAuth = true,
          skipPhysicalJob = true,
          skipGrammarValidate = true)
        context.preProcessListener.map(f => JSONTool.toJsonStr(f.analyzedStatements.map(_.unwrap))) match {
          case Some(i) => outputResult = i
          case None =>
        }
      }

      params.getOrElse("executeMode", "query") match {
        case "query" => query
        case "analyze" => analyze
        case executeMode: String =>
          AppRuntimeStore.store.getController(executeMode) match {
            case Some(item) =>
              outputResult = Class.forName(item.customClassItem.className).
                newInstance().asInstanceOf[CustomController].run(params().toMap + ("__jobinfo__" -> JSONTool.toJsonStr(jobInfo)))
            case None => throw new RuntimeException(s"no executeMode named ${executeMode}")
          }
      }

    } catch {
      case e: Exception =>
        val msg = ExceptionRenderManager.call(e)
        return (500, msg.str.get)
    } finally {
      if (this._autoClean) {
        RequestCleanerManager.call()
        cleanActiveSessionInSpark
      }
    }
    return (200, outputResult)
  }
```

# 内置的ET

```scala
  wow("ShowCommand")
  wow("EngineResource")
  wow("HDFSCommand")
  wow("NothingET")
  wow("ModelCommand")
  wow("MLSQLEventCommand")
  wow("KafkaCommand")
  wow("DeltaCompactionCommand")
  wow("DeltaCommandWrapper")
  wow("ShowTablesExt")
  register("DTF", "tech.mlsql.ets.tensorflow.DistributedTensorflow")
  wow("PythonCommand")
  wow("SchedulerCommand")
  wow("PluginCommand")
  wow("Ray")
  wow("RunScript")
  wow("PrintCommand")
  wow("IteratorCommand")

  register("IfCommand", "tech.mlsql.ets.ifstmt.IfCommand")
  register("ElifCommand", "tech.mlsql.ets.ifstmt.ElifCommand")
  register("ThenCommand", "tech.mlsql.ets.ifstmt.ThenCommand")
  register("FiCommand", "tech.mlsql.ets.ifstmt.FiCommand")
  register("ElseCommand", "tech.mlsql.ets.ifstmt.ElseCommand")

  register("XGBoostExt", "tech.mlsql.ets.XGBoostExt")
  register("EmptyTableWithSchema","tech.mlsql.ets.EmptyTableWithSchema")


  AppRuntimeStore.store.registerResultRender("ShowFileTable", "tech.mlsql.ets.ShowFileTable")


class AppRuntimeStore(val store: KVStore, val listener: Option[AppSRuntimeListener] = None)
  extends ControllerRuntimeStore
    with LoadSaveRuntimeStore
    with RequestCleanerRuntimeStore
    with ExceptionRenderRuntimeStore with ResultRenderRuntimeStore {

}
```

# Datalake 中设置plugin的安装位置

```scala
object DataLake {
  val RUNTIME_KEY = "spark.mlsql.datalake.path"
  val USER_KEY = "streaming.datalake.path"
  val DELTA_LAKE_OVERWRITE_HIVE = "spark.mlsql.datalake.overwrite.hive"
}

val dataLake = new DataLake(spark)

    val hdfsPath = PathFun(dataLake.identifyToPath(TABLE_FILES)).add("store").add("plugins")
    saveStream(pluginName, fileLen, hdfsPath.toPath, fieldValue, inputStream, spark.sparkContext.hadoopConfiguration)
    HDFSOperatorV2.deleteDir("." + hdfsPath.toPath + ".crc")
    (fieldValue, PathFun(hdfsPath.toPath).add(fieldValue).toPath)
```

# PluginHook 监听mlsql

```scala
object PluginHook extends Logging {
  private val apps = List(
    "tech.mlsql.plugins.app.pythoncontroller.PythonApp",
    "tech.mlsql.plugins.mlsql_watcher.MLSQLWatcher",
    "tech.mlsql.plugins.sql.profiler.ProfilerApp",
    "tech.mlsql.autosuggest.app.MLSQLAutoSuggestApp",
    "tech.mlsql.plugins.ets.ETApp",
    "tech.mlsql.plugins.healthy.App"
  )
```

# engine 内部数据存储

```scala
object DBStore {
  private var _store: DBStore = new DeltaLakeDBStore

  def store = {
    assert(_store != null, "DBStore is not initialed")
    _store
  }

  def set(store: DBStore) = _store = store
}

val dataLake = new DataLake(spark)
require(dataLake.isEnable, "please set -streaming.datalake.path enable delta db mode")
val finalPath = dataLake.identifyToPath(tableName)

object DataLake {
  val RUNTIME_KEY = "spark.mlsql.datalake.path"
  val USER_KEY = "streaming.datalake.path"
  val DELTA_LAKE_OVERWRITE_HIVE = "spark.mlsql.datalake.overwrite.hive"
}
```

# byzer 运行阶段
```scala
object Stage extends Enumeration {
  type stage = Value
  val include = Value("include")
  val preProcess = Value("preProcess")
  val auth = Value("auth")
  val physical = Value("physical")
  val grammar = Value("grammar")
}

```

# spark submmit MLSQLScript

```scala
/**
 * When using this plugin, please set these parameters as shown below:
 * streaming.rest=false
 * streaming.spark.service=false
 * streaming.mlsql.script.path=the file path of mlsql script (support for hdfs://, file://, http://)
 * streaming.runtime_hooks=tech.mlsql.runtime.SparkSubmitMLSQLScriptRuntimeLifecycle
 * streaming.mlsql.script.owner=XXXXX
 * streaming.mlsql.script.jobName=SparkSubmitTest
 */
class SparkSubmitMLSQLScriptRuntimeLifecycle extends MLSQLPlatformLifecycle with Logging {
```


# byzer include支持的语法

```scala
object IncludeAdaptor {
  val mapping = Map[String, String](
    "hdfs" -> "streaming.dsl.mmlib.algs.includes.HDFSIncludeSource",
    "http" -> "streaming.dsl.mmlib.algs.includes.HTTPIncludeSource",
    "store" -> "tech.mlsql.dsl.includes.StoreIncludeSource",
    "plugin" -> "tech.mlsql.dsl.includes.PluginIncludeSource",
    "lib" -> "tech.mlsql.dsl.includes.LibIncludeSource",
    "local" -> "tech.mlsql.dsl.includes.ScriptIncludeSource",
    "project" -> "tech.mlsql.dsl.includes.ProjectIncludeSource",

    "function" -> "streaming.dsl.mmlib.algs.includes.analyst.HttpBaseDirIncludeSource",
    "view" -> "streaming.dsl.mmlib.algs.includes.analyst.HttpBaseDirIncludeSource",
    "table" -> "streaming.dsl.mmlib.algs.includes.analyst.HttpBaseDirIncludeSource",
    "job" -> "streaming.dsl.mmlib.algs.includes.analyst.HttpBaseDirIncludeSource"
  )
```

## byzer notebook 处理带有include语句的执行方法

```java
// 发送查询
try {
    engineService.runScript(
            new EngineService.RunScriptParams()
                    .withJobName(jobInfo.getJobId())
                    .withIncludeSchema(true)
                    .withSql(jobInfo.getContent()));
} catch (Exception ex) {
    // update job status to FAILED if exception happened
    jobInfo.setFinishTime(new Timestamp(System.currentTimeMillis()));
    jobInfo.setStatus(JobInfo.JobStatus.FAILED);
    jobService.updateByJobId(jobInfo);
    throw ex;
}


  @ApiOperation("Get Script Content")
    @PostMapping("/script/include")
    public String executeScript(@RequestParam(value = "owner") String owner,
                                                       @RequestParam(value = "path") String path) {

        IncludePathParser.IncludePath includePath = IncludePathParser.parse(path);

        if (includePath == null) {
            return "include path can not be resolved.";
        }
        Integer folderId = null;
        if (includePath.getFolder() != null) {
            NotebookFolder folder = folderService.findFolder(owner, includePath.getFolder());
            if (folder == null) {
                return "can not find folder";
            }
            folderId = folder.getId();
        }

        NotebookInfo notebookInfo = notebookService.find(owner, includePath.getNotebook(), folderId);
        if (notebookInfo == null) {
            return "can not find notebook.";
        }
        List<CellInfo> cellInfoList = notebookService.getCellInfos(notebookInfo.getCellList());
        if (includePath.getCellId() != null) {
            if (cellInfoList == null || cellInfoList.size() < includePath.getCellId()) {
                return "can not find cell id.";
            }
            return cellInfoList.get(includePath.getCellId() - 1).getContent();
        }
        StringBuilder buff = new StringBuilder();
        for (CellInfo cellInfo : cellInfoList) {
            buff.append(cellInfo.getContent());
            buff.append("\n");
        }

        return buff.toString();
    }

```


# byzer可以保存的数据表格的形式

```scala
object TableType {
  val HIVE = TableTypeMeta("hive", Set("hive"))
  val CUSTOME = TableTypeMeta("custom", Set("custom"))
  val BINLOG = TableTypeMeta("binlog", Set("binlog"))
  val HBASE = TableTypeMeta("hbase", Set("hbase"))
  val HDFS = TableTypeMeta("hdfs", Set("parquet",
    "binlogRate", "json", "csv", "image",
    "text", "xml", "excel", "libsvm", "delta", "rate", "streamParquet"))
  val HTTP = TableTypeMeta("http", Set("http"))
  val JDBC = TableTypeMeta("jdbc", Set("jdbc", "streamJDBC"))
  val ES = TableTypeMeta("es", Set("es"))
  val REDIS = TableTypeMeta("redis", Set("redis"))
  val KAFKA = TableTypeMeta("kafka", Set("kafka", "kafka8", "kafka9", "adHocKafka"))
  val SOCKET = TableTypeMeta("socket", Set("socket"))
  val MONGO = TableTypeMeta("mongo", Set("mongo"))
  val SOLR = TableTypeMeta("solr", Set("solr", "streamSolr"))
  val TEMP = TableTypeMeta("temp", Set("temp", "jsonStr", "script", "csvStr", "mockStream", "console", "webConsole"))
  val API = TableTypeMeta("api", Set("mlsqlAPI", "mlsqlConf"))
  val WEB = TableTypeMeta("web", Set("crawlersql"))
  val GRAMMAR = TableTypeMeta("grammar", Set("grammar"))
  val SYSTEM = TableTypeMeta("system", Set("_mlsql_", "model", "modelList", "modelParams", "modelExample", "modelExplain"))
  val UNKNOW = TableTypeMeta("unknow", Set("unknow"))

  def from(str: String) = {
    List(BINLOG, UNKNOW, KAFKA, SOCKET, REDIS, HIVE, HBASE, HDFS, HTTP, JDBC, ES, MONGO, SOLR, TEMP, API, WEB, GRAMMAR, SYSTEM, CUSTOME).filter(f => f.includes.contains(str)).headOption
  }

  def toIncludesList = {
    List(BINLOG, UNKNOW, KAFKA, SOCKET, REDIS, HIVE, HBASE, HDFS, HTTP, JDBC, ES, MONGO, SOLR, TEMP, API, WEB, GRAMMAR, SYSTEM, CUSTOME).flatMap(f => f.includes).toList
  }

  def toList = {
    List(BINLOG, UNKNOW, KAFKA, SOCKET, REDIS, HIVE, HBASE, HDFS, HTTP, JDBC, ES, MONGO, SOLR, TEMP, API, WEB, GRAMMAR, SYSTEM, CUSTOME).map(f => f.name)
  }
}
```

## mysql数据源支持的保存参数

```scala
  override def save(writer: DataFrameWriter[Row], config: DataSinkConfig): Unit = {
    var dbtable = config.path
    // if contains splitter, then we will try to find dbname in dbMapping.
    // otherwize we will do nothing since elasticsearch use something like index/type
    // it will do no harm.
    val format = config.config.getOrElse("implClass", fullFormat)
    if (config.path.contains(dbSplitter)) {
      val Array(_dbname, _dbtable) = config.path.split(toSplit, 2)
      ConnectMeta.presentThenCall(DBMappingKey(format, _dbname), options => {
        dbtable = _dbtable
        writer.options(options)
      })
    }
    writer.mode(config.mode)
    //load configs should overwrite connect configs
    writer.options(config.config)
    config.config.get("partitionByCol").map { item =>
      writer.partitionBy(item.split(","): _*)
    }

    config.config.get("idCol").map { item =>
      import org.apache.spark.sql.jdbc.DataFrameWriterExtensions._
      val extraOptions = ScalaReflect.fromInstance[DataFrameWriter[Row]](writer)
        .method("extraOptions").invoke()
        .asInstanceOf[{def toMap[T, U](implicit ev: _ <:< (T, U)): scala.collection.immutable.Map[T, U] }].toMap[String,String]
      val jdbcOptions = new JDBCOptions(extraOptions + ("dbtable" -> dbtable))
      writer.upsert(Option(item), jdbcOptions, config.df.get)
    }.getOrElse {
      writer.option("dbtable", dbtable)
      writer.format(format).save(dbtable)
    }
  }
```

## spark DataFrameWriter


public DataFrameWriter<T> mode(SaveMode saveMode)
Specifies the behavior when data or table already exists. Options include:
- SaveMode.Overwrite: overwrite the existing data.
- SaveMode.Append: append the data.
- SaveMode.Ignore: ignore the operation (i.e. no-op).
- SaveMode.ErrorIfExists: throw an exception at runtime.


https://spark.apache.org/docs/2.3.1/sql-programming-guide.html

https://spark.apache.org/docs/latest/api/java/org/apache/spark/sql/DataFrameWriter.html

https://spark.apache.org/docs/latest/api/python/reference/api/pyspark.sql.DataFrameWriter.saveAsTable.html

saveastable的options存储信息

JDBC形式支持的options参数

```scala
  val JDBC_URL = newOption("url")
  val JDBC_TABLE_NAME = newOption("dbtable")
  val JDBC_QUERY_STRING = newOption("query")
  val JDBC_DRIVER_CLASS = newOption("driver")
  val JDBC_PARTITION_COLUMN = newOption("partitionColumn")
  val JDBC_LOWER_BOUND = newOption("lowerBound")
  val JDBC_UPPER_BOUND = newOption("upperBound")
  val JDBC_NUM_PARTITIONS = newOption("numPartitions")
  val JDBC_QUERY_TIMEOUT = newOption("queryTimeout")
  val JDBC_BATCH_FETCH_SIZE = newOption("fetchsize")
  val JDBC_TRUNCATE = newOption("truncate")
  val JDBC_CASCADE_TRUNCATE = newOption("cascadeTruncate")
  val JDBC_CREATE_TABLE_OPTIONS = newOption("createTableOptions")
  val JDBC_CREATE_TABLE_COLUMN_TYPES = newOption("createTableColumnTypes")
  val JDBC_CUSTOM_DATAFRAME_COLUMN_TYPES = newOption("customSchema")
  val JDBC_BATCH_INSERT_SIZE = newOption("batchsize")
  val JDBC_TXN_ISOLATION_LEVEL = newOption("isolationLevel")
  val JDBC_SESSION_INIT_STATEMENT = newOption("sessionInitStatement")
  val JDBC_PUSHDOWN_PREDICATE = newOption("pushDownPredicate")
  val JDBC_PUSHDOWN_AGGREGATE = newOption("pushDownAggregate")
  val JDBC_PUSHDOWN_LIMIT = newOption("pushDownLimit")
  val JDBC_PUSHDOWN_TABLESAMPLE = newOption("pushDownTableSample")
  val JDBC_KEYTAB = newOption("keytab")
  val JDBC_PRINCIPAL = newOption("principal")
  val JDBC_TABLE_COMMENT = newOption("tableComment")
  val JDBC_REFRESH_KRB5_CONFIG = newOption("refreshKrb5Config")
  val JDBC_CONNECTION_PROVIDER = newOption("connectionProvider")
```


| Property Name  |  Meaning |
|---|---|
|url|The JDBC URL to connect to. The source-specific connection properties may be specified in the URL. e.g., jdbc:postgresql://localhost/test?user=fred&password=secret|
|dbtable |The JDBC table that should be read. Note that anything that is valid in a FROM clause of a SQL query can be used. For example, instead of a full table you could also use a subquery in parentheses.|
|driver |The class name of the JDBC driver to use to connect to this URL.|
|partitionColumn, lowerBound, upperBound|	These options must all be specified if any of them is specified. In addition, numPartitions must be specified. They describe how to partition the table when reading in parallel from multiple workers. partitionColumn must be a numeric column from the table in question. Notice that lowerBound and upperBound are just used to decide the partition stride, not for filtering the rows in table. So all rows in the table will be partitioned and returned. This option applies only to reading.|
|numPartitions|	The maximum number of partitions that can be used for parallelism in table reading and writing. This also determines the maximum number of concurrent JDBC connections. If the number of partitions to write exceeds this limit, we decrease it to this limit by calling coalesce(numPartitions) before writing.|
|fetchsize|	The JDBC fetch size, which determines how many rows to fetch per round trip. This can help performance on JDBC drivers which default to low fetch size (eg. Oracle with 10 rows). This option applies only to reading.|
|batchsize|	The JDBC batch size, which determines how many rows to insert per round trip. This can help performance on JDBC drivers. This option applies only to writing. It defaults to 1000.|
|isolationLevel|	The transaction isolation level, which applies to current connection. It can be one of NONE, READ_COMMITTED, READ_UNCOMMITTED, REPEATABLE_READ, or SERIALIZABLE, corresponding to standard transaction isolation levels defined by JDBC's Connection object, with default of READ_UNCOMMITTED. This option applies only to writing. Please refer the documentation in java.sql.Connection.|
|sessionInitStatement|	After each database session is opened to the remote DB and before starting to read data, this option executes a custom SQL statement (or a PL/SQL block). Use this to implement session initialization code. Example: option("sessionInitStatement", """BEGIN execute immediate 'alter session set "_serial_direct_read"=true'; END;""")|
|truncate|	This is a JDBC writer related option. When SaveMode.Overwrite is enabled, this option causes Spark to truncate an existing table instead of dropping and recreating it. This can be more efficient, and prevents the table metadata (e.g., indices) from being removed. However, it will not work in some cases, such as when the new data has a different schema. It defaults to false. This option applies only to writing.|
|createTableOptions|	This is a JDBC writer related option. If specified, this option allows setting of database-specific table and partition options when creating a table (e.g., CREATE TABLE t (name string) ENGINE=InnoDB.). This option applies only to writing.|
|createTableColumnTypes|	The database column data types to use instead of the defaults, when creating the table. Data type information should be specified in the same format as CREATE TABLE columns syntax (e.g: "name CHAR(64), comments VARCHAR(1024)"). The specified types should be valid spark sql data types. This option applies only to writing.|
|customSchema|	The custom schema to use for reading data from JDBC connectors. For example, "id DECIMAL(38, 0), name STRING". You can also specify partial fields, and the others use the default type mapping. For example, "id DECIMAL(38, 0)". The column names should be identical to the corresponding column names of JDBC table. Users can specify the corresponding data types of Spark SQL instead of using the defaults. This option applies only to reading.|

其中，partitionColumn, lowerBound, upperBound,numPartitions 用来控制加载表的并行度。如果你
加载数据太慢，那么可以调整着几个参数。


https://stackoverflow.com/questions/31487254/spark-what-options-can-be-passed-with-dataframe-saveastable-or-dataframewriter

https://jaceklaskowski.gitbooks.io/mastering-spark-sql/content/spark-sql-CatalogTable.html

https://stackoverflow.com/questions/50677318/spark-read-jdbc-custom-schema

https://analyticshut.com/custom-schema-to-spark-dataframe/


https://www.oreilly.com/library/view/learning-spark-2nd/9781492050032/ch04.html


https://spark.apache.org/docs/latest/sql-data-sources-jdbc.html

https://analyticshut.com/custom-schema-to-spark-dataframe/


# load 加载数据

load

DataFrameReader
jdbc


# jdbc 保存很慢
https://blog.csdn.net/lovetechlovelife/article/details/112471839
