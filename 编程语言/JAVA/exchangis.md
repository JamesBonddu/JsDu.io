# exchangis-eureka

/usr/lib/jvm/java-1.8.0-openjdk-1.8.0.292.b10-1.el8_4.x86_64/bin/java -Xms2g -Xmx2g -XX:+HeapDumpOnOutOfMemoryError -Dfile.encoding=UTF-8 -XX:HeapDumpPath=/data/code/exchangis-mysql8/wedatasphere-exchangis-0.5.0.RELEASE/modules/exchangis-eureka/bin/../logs -Dlog.path=/data/code/exchangis-mysql8/wedatasphere-exchangis-0.5.0.RELEASE/modules/exchangis-eureka/bin/../logs -Duser.dir=/data/code/exchangis-mysql8/wedatasphere-exchangis-0.5.0.RELEASE/modules/exchangis-eureka/bin/../ -Dserver.port=8500 -Ddata.path=/data/code/exchangis-mysql8/wedatasphere-exchangis-0.5.0.RELEASE/modules/exchangis-eureka/bin/../data -Dlogging.config=/data/code/exchangis-mysql8/wedatasphere-exchangis-0.5.0.RELEASE/modules/exchangis-eureka/bin/../conf/logback.xml -Deureka.hostname=DataSphereStudio-Test -classpath /data/code/exchangis-mysql8/wedatasphere-exchangis-0.5.0.RELEASE/modules/exchangis-eureka/bin/../lib/*:/data/code/exchangis-mysql8/wedatasphere-exchangis-0.5.0.RELEASE/modules/exchangis-eureka/bin/../conf:. com.webank.wedatasphere.exchangis.EurekaApplication


# exchangis-executor

/usr/lib/jvm/java-1.8.0-openjdk-1.8.0.292.b10-1.el8_4.x86_64/bin/java -Xms2g -Xmx2g -XX:+HeapDumpOnOutOfMemoryError -Dfile.encoding=UTF-8 -XX:HeapDumpPath=/data/code/exchangis-mysql8/wedatasphere-exchangis-0.5.0.RELEASE/modules/exchangis-executor/bin/../logs -Dlog.path=/data/code/exchangis-mysql8/wedatasphere-exchangis-0.5.0.RELEASE/modules/exchangis-executor/bin/../logs -Dsudo.user=root -Duser.dir=/data/code/exchangis-mysql8/wedatasphere-exchangis-0.5.0.RELEASE/modules/exchangis-executor/bin/../ -Dserver.port=9501 -Ddata.path=/data/code/exchangis-mysql8/wedatasphere-exchangis-0.5.0.RELEASE/modules/exchangis-executor/bin/../data -Dlogging.config=/data/code/exchangis-mysql8/wedatasphere-exchangis-0.5.0.RELEASE/modules/exchangis-executor/bin/../conf/logback-server.xml -classpath /data/code/exchangis-mysql8/wedatasphere-exchangis-0.5.0.RELEASE/modules/exchangis-executor/bin/../lib/*:/data/code/exchangis-mysql8/wedatasphere-exchangis-0.5.0.RELEASE/modules/exchangis-executor/bin/../conf:. com.webank.wedatasphere.exchangis.ExecutorApplication


# exchangis-gateway

/usr/lib/jvm/java-1.8.0-openjdk-1.8.0.292.b10-1.el8_4.x86_64/bin/java -Xms2g -Xmx2g -XX:+HeapDumpOnOutOfMemoryError -Dfile.encoding=UTF-8 -XX:HeapDumpPath=/data/code/exchangis-mysql8/wedatasphere-exchangis-0.5.0.RELEASE/modules/exchangis-gateway/bin/../logs -Dlog.path=/data/code/exchangis-mysql8/wedatasphere-exchangis-0.5.0.RELEASE/modules/exchangis-gateway/bin/../logs -Duser.dir=/data/code/exchangis-mysql8/wedatasphere-exchangis-0.5.0.RELEASE/modules/exchangis-gateway/bin/../ -Dserver.port=9503 -Ddata.path=/data/code/exchangis-mysql8/wedatasphere-exchangis-0.5.0.RELEASE/modules/exchangis-gateway/bin/../data -Dlogging.config=/data/code/exchangis-mysql8/wedatasphere-exchangis-0.5.0.RELEASE/modules/exchangis-gateway/bin/../conf/logback.xml -classpath /data/code/exchangis-mysql8/wedatasphere-exchangis-0.5.0.RELEASE/modules/exchangis-gateway/bin/../lib/*:/data/code/exchangis-mysql8/wedatasphere-exchangis-0.5.0.RELEASE/modules/exchangis-gateway/bin/../conf:. com.webank.wedatasphere.exchangis.WebApplication

# exchangis-service

 /usr/lib/jvm/java-1.8.0-openjdk-1.8.0.292.b10-1.el8_4.x86_64/bin/java -Xms2g -Xmx2g -XX:+HeapDumpOnOutOfMemoryError -Dfile.encoding=UTF-8 -XX:HeapDumpPath=/data/code/exchangis-mysql8/wedatasphere-exchangis-0.5.0.RELEASE/modules/exchangis-service/bin/../logs -Dlog.path=/data/code/exchangis-mysql8/wedatasphere-exchangis-0.5.0.RELEASE/modules/exchangis-service/bin/../logs -Duser.dir=/data/code/exchangis-mysql8/wedatasphere-exchangis-0.5.0.RELEASE/modules/exchangis-service/bin/../ -Dserver.port=9504 -Ddata.path=/data/code/exchangis-mysql8/wedatasphere-exchangis-0.5.0.RELEASE/modules/exchangis-service/bin/../data -Dlogging.config=/data/code/exchangis-mysql8/wedatasphere-exchangis-0.5.0.RELEASE/modules/exchangis-service/bin/../conf/logback.xml -classpath /data/code/exchangis-mysql8/wedatasphere-exchangis-0.5.0.RELEASE/modules/exchangis-service/bin/../lib/*:/data/code/exchangis-mysql8/wedatasphere-exchangis-0.5.0.RELEASE/modules/exchangis-service/bin/../conf:. com.webank.wedatasphere.exchangis.ServiceApplication


# 控制人员查看数据的权限

```java
//Bind authority scopes
security.bindAuthScope(element, security.externalDataAuthScopeGetter(getActualType()).get(element));


/**
 * @author davidhua
 * 2019/6/3
 */
public enum DataAuthScope {
    /**
     * Authority scope
     */
    ALL, READ, WRITE, DELETE, EXECUTE, DATA_READ, DATA_WRITE;
}
```

# 调度执行sql

```java
// 查询计算节点
// http://localhost:9503/api/v1/exec/node/list/DATAX
@RequestMapping(value= "/list/{tab:[.\\d\\w_-]+}", method = RequestMethod.GET)
public Response<Object> listByTab(HttpServletRequest request, @PathVariable("tab")String tab){
    String userName = util.getUserName(request);
    Set<ExecutorNode> nodes = new HashSet<>(execNodeInfoService.getExecNodesByAppUserAndTab(userName, tab));
    //Get default nodes
    List<ExecutorNode> defaultNodes = execNodeInfoService.getDefaultNodeListByTab(tab);
    nodes.addAll(defaultNodes);
    return new Response<>().successResponse(nodes);
}
```

```js
// 显示任务状态

methods: {
    statusFilter(Data) {
        switch (Data.status) {
            case 'SUCCESS':
                return {color: 'SUCCESS', lable: that.$t('message.newAllPage.Executesuccessfully')};
            case 'RUNNING':
                return {color: 'RUNNING', lable: that.$t('message.newAllPage.Intheoperationofthe')};
            case 'FAILD':
                return {color: 'FAILD', lable: that.$t('message.newAllPage.Onfailure')};
            case 'RUNNING_TIMEOUT':
                return {color: 'RUNNING_TIMEOUT', lable: that.$t('message.newAllPage.Runatimeout')};
            case 'COMMIT':
                return {color: 'COMMIT', lable: that.$t('message.newAllPage.Inthequeue')};
            case 'KILL':
                return {color: 'KILL', lable: that.$t('message.newAllPage.Hasstopped')};
            default:
                return {color: '', lable: '---'};
        }
    }
},

public enum ExecuteStatus {
    /**
     * COMMIT:1, RUNNING:2, KILL:3, SUCCESS:4, FAIL:5, TIMEOUT:6
     */
    NONE(-1), COMMIT(1),RUNNING(2),KILL(3),SUCCESS(4),FAILD(5), RUNNING_TIMEOUT(6);
    private int value;
    ExecuteStatus(int value){
        this.value = value;
    }

    public int getValue() {
        return value;
    }
}
```

```java
// 添加执行任务信息
// http://localhost:9503/api/v1/jobinfo/add

//Generate job task
JobTask jobTask = new JobTask(jobInfo,  "api",  userName0);

// Before running task, bind and relate executive user and nodes
bindAndRelateExecNodesAndUser(jobInfo.getExecNodes(), jobInfo.getExecNodeNames(), jobInfo.getExecUser());
// 将任务加入队列
jobTaskService.insertTaskAndAddToQueue(jobTask, paramsList);

// 添加任务到队列
@Override
@Transactional(rollbackFor = Exception.class)
public void insertTaskAndAddToQueue(JobTask task, List<JobTaskParams> params) {
    task.setId(idGenerator.nextId());
    jobTaskDao.insert(task);
    params.forEach(param -> param.setTaskId(task.getId()));
    addTaskParams(params);
    addTaskToQueue(task);
}

// 添加任务到队列的具体实现
private void addTaskToQueue(JobTask task){
    Queue<QueueElement> queue = queueManager.chooseQueue();
    if(null == queue){
        throw new EndPointException("udes.jobtaskservice.execute.queue.failed", null);
    }

    QueueElement element = new QueueElement();
    element.setId(task.getId());
    element.setStatus(0);
    queue.add(element);
    LOG.info("Add task {} to queue id: {} successfully", Json.toJson(task, null), element.getQid());
}

// QueueSchedulerManager 队列调度管理器 loop 循环
dbQueueManager
syncQueueFromDb
executorService


// 拿到队列中任务进行运行

boolean result = jobTaskService.runTask(element);
                                    if (!result) {
                                        //add in queue again
                                        chooseQueue().add(element);
                                    }
                                
// 存在执行节点通过负载均衡选择节点执行任务

response = balanceRunService.run(FeignConstants.LB_LABEL_PREFIX_JOB
                + jobTask.getJobId(), req);

```

## queue中的状态

```mysql
mysql> select * from exchangis_queue_elements;
+---------------------+-----+--------+---------------------+-----------+-----------+---------------------+-------------+---------+---------------------+
| sid                 | qid | status | enq_time            | poll_time | enq_count | delay_time          | delay_count | version | create_time         |
+---------------------+-----+--------+---------------------+-----------+-----------+---------------------+-------------+---------+---------------------+
| 1625903855218855936 |   1 |      0 | 2021-07-12 17:04:25 | NULL      |         1 | 2021-07-15 17:21:11 |        7076 |   14152 | 2021-07-12 17:04:25 |
| 1626961978767577088 |   1 |      0 | 2021-07-15 15:09:01 | NULL      |         1 | 2021-07-15 17:21:23 |         243 |     486 | 2021-07-15 15:09:01 |
| 1626987902091268096 |   1 |      0 | 2021-07-15 16:52:02 | NULL      |         1 | 2021-07-15 17:21:23 |          55 |     110 | 2021-07-15 16:52:02 |
| 1626989343535140864 |   1 |      0 | 2021-07-15 16:57:46 | NULL      |         1 | 2021-07-15 17:21:35 |          44 |      88 | 2021-07-15 16:57:46 |
| 1626989910718287872 |   1 |      0 | 2021-07-15 17:00:01 | NULL      |         1 | 2021-07-15 17:21:35 |          40 |      80 | 2021-07-15 17:00:01 |
+---------------------+-----+--------+---------------------+-----------+-----------+---------------------+-------------+---------+---------------------+
5 rows in set (0.00 sec)

mysql> select * from exchangis_queue_info;
+----+-----------------+-------------+----------+---------+---------------------------+---------------------+---------------------+
| id | qname           | description | priority | is_lock | lock_host                 | lock_time           | create_time         |
+----+-----------------+-------------+----------+---------+---------------------------+---------------------+---------------------+
|  1 | public-queue-01 | none        |       -1 |       1 | http://172.19.196.66:9504 | 2021-07-15 17:21:05 | 2021-07-08 16:31:08 |
+----+-----------------+-------------+----------+---------+---------------------------+---------------------+---------------------+
1 row in set (0.00 sec)
```

# 安装脚本

```sh
yum install git mysql nginx mysql-server maven java-1.8.0-openjdk java-1.8.0-openjdk-devel java-11-openjdk java-11-openjdk-devel -y
yum install nodejs npm -y

[root@iZuf62jr8hyu2q5ak8cnlqZ code]# systemctl enable nginx
Created symlink /etc/systemd/system/multi-user.target.wants/nginx.service → /usr/lib/systemd/system/nginx.service.
[root@iZuf62jr8hyu2q5ak8cnlqZ code]# systemctl restart nginx[root@iZuf62jr8hyu2q5ak8cnlqZ code]# systemctl enable nginx
Created symlink /etc/systemd/system/multi-user.target.wants/nginx.service → /usr/lib/systemd/system/nginx.service.
[root@iZuf62jr8hyu2q5ak8cnlqZ code]# systemctl restart nginx
systemctl enable mysqld
systemctl restart mysqld

```

## maven setting.xml 配置

```sh
    <mirror>
      <id>mvnrepository</id>
      <mirrorOf>mvnrepository</mirrorOf>
      <url>http://mvnrepository.com/</url>
    </mirror>

    <mirror>
      <id>alimaven</id>
      <name>aliyun maven</name>
      <url>http://maven.aliyun.com/nexus/content/groups/public/</url>
      <mirrorOf>central</mirrorOf>
    </mirror>

    <mirror>
        <id>aliyunmaven</id>
        <mirrorOf>*</mirrorOf>
        <name>阿里云spring插件仓库</name>
        <url>https://maven.aliyun.com/repository/spring-plugin</url>
    </mirror>

    <mirror>
        <id>repo2</id>
        <name>Mirror from Maven Repo2</name>
        <url>https://repo.spring.io/plugins-release/</url>
        <mirrorOf>central</mirrorOf>
    </mirror>
```

## 安装dss-appjoint-auth jar

```sh
mvn clean install 
[INFO] Installing /data/code/DataSphereStudio/dss-appjoint-auth/target/dss-appjoint-auth-0.9.1.jar to /root/.m2/repository/com/webank/wedatasphere/dss/dss-appjoint-auth/0.9.1/dss-appjoint-auth-0.9.1.jar
[INFO] Installing /data/code/DataSphereStudio/dss-appjoint-auth/pom.xml to /root/.m2/repository/com/webank/wedatasphere/dss/dss-appjoint-auth/0.9.1/dss-appjoint-auth-0.9.1.pom
[INFO] Installing /data/code/DataSphereStudio/dss-appjoint-auth/target/dss-appjoint-auth-0.9.1-javadoc.jar to /root/.m2/repository/com/webank/wedatasphere/dss/dss-appjoint-auth/0.9.1/dss-appjoint-auth-0.9.1-javadoc.jar
```



