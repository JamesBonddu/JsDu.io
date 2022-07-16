1. API接口层获取sql语句

```scala
@At(path = Array("/run/script"), types = Array(GET, POST)){
    val sparkSession = getSession

    accessAuth(sparkSession)
    val jobInfo = JobManager.getJobInfo(
    param("owner"), param("jobType", MLSQLJobType.SCRIPT), param("jobName"), param("sql"),
    paramAsLong("timeout", -1L)
    )
    val context = createScriptSQLExecListener(sparkSession, jobInfo.groupId)

    def query = {
            if (paramAsBoolean("async", false)) {
            JobManager.asyncRun(sparkSession, jobInfo, () => {
                val urlString = param("callback")
                val maxTries = Math.max(0, paramAsInt("maxRetries", -1)) + 1
                try {
                ScriptSQLExec.parse(param("sql"), context,
                    skipInclude = paramAsBoolean("skipInclude", false),
                    skipAuth = paramAsBoolean("skipAuth", true),
                    skipPhysicalJob = paramAsBoolean("skipPhysicalJob", false),
                    skipGrammarValidate = paramAsBoolean("skipGrammarValidate", true))

                outputResult = getScriptResult(context, sparkSession)

                executeWithRetrying[HttpResponse](maxTries)(
                    RestUtils.httpClientPost(urlString,
                    Map("stat" -> s"""succeeded""",
                        "res" -> outputResult,
                        "jobInfo" -> JSONTool.toJsonStr(jobInfo))),
                    HttpStatus.SC_OK == _.getStatusLine.getStatusCode,
                    response => logger.error(s"Succeeded SQL callback request failed after ${maxTries} attempts, " +
                    s"the last response status is: ${response.getStatusLine.getStatusCode}.")
                )
}
```
2. 创建脚本SQL执行监听器
```scala
private def createScriptSQLExecListener(sparkSession: SparkSession, groupId: String) = {

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
