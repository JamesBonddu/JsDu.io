# openfeign

Feign是一个声明式的Web Service客户端。它的出现使开发Web Service客户端变得很简单。使用Feign只需要创建一个接口加上对应的注解，比如：FeignClient注解。Feign有可插拔的注解，包括Feign注解和JAX-RS注解。
Feign也支持编码器和解码器，Spring Cloud Open Feign对Feign进行增强支持Spring MVC注解，可以像Spring Web一样使用HttpMessageConverters等。
Feign是一种声明式、模板化的HTTP客户端。在Spring Cloud中使用Feign，可以做到使用HTTP请求访问远程服务，就像调用本地方法一样的，开发者完全感知不到这是在调用远程方法，更感知不到在访问HTTP请求。

OpenFeign的功能
1.可插拔的注解支持，包括Feign注解和JAX-RS注解。
2.支持可插拔的HTTP编码器和解码器（Gson，Jackson，Sax，JAXB，JAX-RS，SOAP）。
3.支持Hystrix和它的Fallback。
4.支持Ribbon的负载均衡。
5.支持HTTP请求和响应的压缩。
6.灵活的配置：基于 name 粒度进行配置
7.支持多种客户端：JDK URLConnection、apache httpclient、okhttp，ribbon）
8.支持日志
9.支持错误重试
10.url支持占位符
11.可以不依赖注册中心独立运行

https://blog.csdn.net/qq_43565087/article/details/106207867

OpenFeign把RestTemplete，Ribbon，Hystrix糅合在了一起，在使用时就可以更加方便，优雅地完成整个服务的暴露，调用等。避免做一些重复的复制粘贴接口URL，或者重复定义接口等。还是非常值得去学习的。

Ribbon是负责做负载均衡的组件。所以是可以通过配置设置负载均衡的策略。
openFeign实际上是已经引入了hystrix的相关jar包，所以可以直接使用，设置超时时间，超时后调用FallBack方法，实现熔断机制。

Feign的调用分为两层，Ribbon的调用和Hystrix的调用。但是高版本的Hystrix默认是关闭的。一般出现想这样的异常：Read timed out executing POST http://***，是由Ribbon引起，这样可以适当得调大一下Ribbon的超时时间


https://developer.aliyun.com/article/775626

https://segmentfault.com/a/1190000039889836

https://zhuanlan.zhihu.com/p/346273428

https://blog.csdn.net/zimou5581/article/details/89949852

https://www.cnblogs.com/unchain/p/13405814.html

# 报错

```sh
"com.netflix.client.ClientException: Load balancer does not have available server for client: exchangis-executor"
```

FeignClient

# ribbon configuration
ribbon:
  eager-load:
    enabled: true

https://cloud.tencent.com/developer/article/1482821

https://stackoverflow.com/questions/41401009/load-balancer-does-not-have-available-server-for-client

https://blog.csdn.net/weixin_41231928/article/details/103487700

## NoAvailableServerException

```sh
com.webank.wedatasphere.exchangis.route.exception.NoAvailableServerException: No available candidate servers
	at com.webank.wedatasphere.exchangis.route.MachineLoadRule.choose(MachineLoadRule.java:108)
	at com.webank.wedatasphere.exchangis.route.MachineLoadRule.choose(MachineLoadRule.java:65)
	at com.netflix.loadbalancer.BaseLoadBalancer.chooseServer(BaseLoadBalancer.java:736)
```

借大佬issue。 第三点exechangis-executor应该是修改conf/bootstrap.yml文件，将文件底部的name "" 修改为 name "eth0"(读取到的ip应该和eureka注册的ip一致)，修改完重启executor模块。感谢大佬的issue给了提示

https://www.gitmemory.com/issue/WeBankFinTech/Exchangis/80/870372840


## load balancer No available candidate servers 负载均衡无法选到正确的节点


```sh
2021-07-16 16:39:25.109  INFO 583519 --- [ueue-Schedule-2] c.w.w.e.q.manager.QueueSchedulerManager  : Start to sync queue info
2021-07-16 16:39:28.569  INFO 583519 --- [ueue-Schedule-1] c.w.w.e.queue.manager.DbQueueManager     : Unlock queue id [1]
2021-07-16 16:39:28.610  INFO 583519 --- [ueue-Schedule-1] c.w.w.e.queue.manager.DbQueueManager     : Traversal queue => total [1], index [0], try to get the Consumer-Lock of queue
2021-07-16 16:39:28.625  INFO 583519 --- [ueue-Schedule-1] c.w.w.e.queue.manager.DbQueueManager     : Succeed in getting the Consumer-Lock of queue whose id  [1], name [public-queue-01]
2021-07-16 16:39:34.627  INFO 583519 --- [ueue-Schedule-1] c.w.w.e.queue.manager.DbQueueManager     : Unlock queue id [1]
2021-07-16 16:39:34.641  INFO 583519 --- [ueue-Schedule-1] c.w.w.e.queue.manager.DbQueueManager     : Traversal queue => total [1], index [0], try to get the Consumer-Lock of queue
2021-07-16 16:39:34.644  INFO 583519 --- [ueue-Schedule-1] c.w.w.e.queue.manager.DbQueueManager     : Succeed in getting the Consumer-Lock of queue whose id  [1], name [public-queue-01]
2021-07-16 16:39:40.109  INFO 583519 --- [ueue-Schedule-2] c.w.w.e.q.manager.QueueSchedulerManager  : Start to sync queue info
2021-07-16 16:39:40.655  INFO 583519 --- [ueue-Schedule-1] adBalancerFactory$FeignLabelLoadBalancer : set load balancer label:job_2
2021-07-16 16:39:40.656  INFO 583519 --- [ueue-Schedule-1] c.w.w.exchangis.route.MachineLoadRule    : Candidate nodes:[]
2021-07-16 16:39:40.656  WARN 583519 --- [ueue-Schedule-1] c.netflix.loadbalancer.BaseLoadBalancer  : LoadBalancer [exchangis-executor]:  Error choosing server for key job_2

com.webank.wedatasphere.exchangis.route.exception.NoAvailableServerException: No available candidate servers
        at com.webank.wedatasphere.exchangis.route.MachineLoadRule.choose(MachineLoadRule.java:108)
        at com.webank.wedatasphere.exchangis.route.MachineLoadRule.choose(MachineLoadRule.java:65)
        at com.netflix.loadbalancer.BaseLoadBalancer.chooseServer(BaseLoadBalancer.java:736)
```

## 调度失败的情况

```sh
2021-07-16 17:20:31.594  INFO 583519 --- [Queue-Schedule-1] adBalancerFactory$FeignLabelLoadBalancer : set load balancer label:job_2
2021-07-16 17:20:31.601  INFO 583519 --- [Queue-Schedule-1] c.w.w.exchangis.route.MachineLoadRule    : Candidate nodes:[{"id":1,"address":"172.19.196.66:9501","heartbeatTime":"2021-07-16 09:20:08","status":0,"memRate":0.4352,"cpuRate":0.5559,"defaultNode":false}]
2021-07-16 17:20:31.601  INFO 583519 --- [Queue-Schedule-1] c.w.w.exchangis.route.MachineLoadRule    : Finally choose server:[172.19.196.66:9501]
2021-07-16 17:20:32.314  INFO 583519 --- [Queue-Schedule-1] c.w.w.e.j.s.impl.JobTaskServiceImpl      : run task 1627354652913831936 occurred exception, message: {"code":0,"data":{"executorAddress":"172.19.196.66:9501","status":"FAILD","message":"java.lang.RuntimeException: Task: 1627354652913831936 switch to user:'dss' failed","taskId":null,"execUser":"dss"},"message":"success"}
2021-07-16 17:20:32.495  INFO 583519 --- [Queue-Schedule-1] adBalancerFactory$FeignLabelLoadBalancer : set load balancer label:job_2
2021-07-16 17:20:32.497  INFO 583519 --- [Queue-Schedule-1] c.w.w.exchangis.route.MachineLoadRule    : Candidate nodes:[{"id":1,"address":"172.19.196.66:9501","heartbeatTime":"2021-07-16 09:20:08","status":0,"memRate":0.4352,"cpuRate":0.5559,"defaultNode":false}]
2021-07-16 17:20:32.497  INFO 583519 --- [Queue-Schedule-1] c.w.w.exchangis.route.MachineLoadRule    : Finally choose server:[172.19.196.66:9501]
2021-07-16 17:20:32.969  INFO 583519 --- [Queue-Schedule-1] c.w.w.e.j.s.impl.JobTaskServiceImpl      : run task 1627354652913831936 occurred exception, message: {"code":0,"data":{"executorAddress":"172.19.196.66:9501","status":"FAILD","message":"java.lang.RuntimeException: Task: 1627354652913831936 switch to user:'dss' failed","taskId":null,"execUser":"dss"},"message":"success"}
2021-07-16 17:20:33.009  INFO 583519 --- [Queue-Schedule-1] adBalancerFactory$FeignLabelLoadBalancer : set load balancer label:job_2
2021-07-16 17:20:33.010  INFO 583519 --- [Queue-Schedule-1] c.w.w.exchangis.route.MachineLoadRule    : Candidate nodes:[{"id":1,"address":"172.19.196.66:9501","heartbeatTime":"2021-07-16 09:20:08","status":0,"memRate":0.4352,"cpuRate":0.5559,"defaultNode":false}]
2021-07-16 17:20:33.010  INFO 583519 --- [Queue-Schedule-1] c.w.w.exchangis.route.MachineLoadRule    : Finally choose server:[172.19.196.66:9501]
2021-07-16 17:20:33.145  INFO 583519 --- [Queue-Schedule-1] c.w.w.e.j.s.impl.JobTaskServiceImpl      : run task 1627354652913831936 occurred exception, message: {"code":0,"data":{"executorAddress":"172.19.196.66:9501","status":"FAILD","message":"java.lang.RuntimeException: Task: 1627354652913831936 switch to user:'dss' failed","taskId":null,"execUser":"dss"},"message":"success"}
2021-07-16 17:20:33.146  INFO 583519 --- [Queue-Schedule-1] c.w.w.e.alarm.DefaultAlarmService        : AlarmTitle: [EXCHANGIS任务作业调度失败], AlarmLevel: [null], AlarmInfo: [任务名称:etl_student, JOB_ID: 2, TASK_ID: 1627354652913831936, 调度失败，请联系管理员处理。Please alarm(请通知): dss], AlarmReceivers: [dss]
2021-07-16 17:20:33.193  INFO 583519 --- [Queue-Schedule-1] c.w.w.e.j.s.impl.JobTaskServiceImpl      : remove element related task id: 1627354652913831936 from queue


// 报错发现此时已经有很多错误的节点了, truncate 对应的执行节点表
org.mybatis.spring.MyBatisSystemException: nested exception is org.apache.ibatis.exceptions.TooManyResultsException: Expected one result (or null) to be returned by selectOne(), but found: 7
	at org.mybatis.spring.MyBatisExceptionTranslator.translateExceptionIfPossible(MyBatisExceptionTranslator.java:77)
	at org.mybatis.spring.SqlSessionTemplate$SqlSessionInterceptor.invoke(SqlSessionTemplate.java:446)
```


```java
String jobIdStr = keyStr.substring(FeignConstants.LB_LABEL_PREFIX_JOB.length());
if(StringUtils.isNotBlank(jobIdStr)){
    long jobId = Long.valueOf(jobIdStr);
    candidates = jobExecNodeDao.getAvailsByJobId(jobId, machineLoadConf.getHeartBeatAvailInterval());
}
//retain all in hostPorts list
candidates.retainAll(hostPorts);
logger.info("Candidate nodes:" + Json.toJson(candidates, null));
                if(candidates.isEmpty()){
                    throw new NoAvailableServerException("No available candidate servers");
                }
```

## `exchangis_executor_node` 节点插入的时机

ExecNodeDao 的insert时


## dss 调度失败

```sh
2021-07-16 17:49:22.752  INFO 617343 --- [Queue-Schedule-1] adBalancerFactory$FeignLabelLoadBalancer : set load balancer label:job_2
2021-07-16 17:49:22.789  INFO 617343 --- [Queue-Schedule-1] c.w.w.exchangis.route.MachineLoadRule    : Candidate nodes:[{"id":1,"address":"172.19.196.66:9501","heartbeatTime":"2021-07-16 09:48:37","status":0,"memRate":0.4195,"cpuRate":0.5292,"defaultNode":false}]
2021-07-16 17:49:22.790  INFO 617343 --- [Queue-Schedule-1] c.w.w.exchangis.route.MachineLoadRule    : Finally choose server:[172.19.196.66:9501]
2021-07-16 17:49:23.190  INFO 617343 --- [Queue-Schedule-1] c.w.w.e.j.s.impl.JobTaskServiceImpl      : run task 1627364701883207680 occurred exception, message: {"code":0,"data":{"executorAddress":"172.19.196.66:9501","status":"FAILD","message":"java.lang.RuntimeException: Task: 1627364701883207680 switch to user:'dss' failed","taskId":null,"execUser":"dss"},"message":"success"}
2021-07-16 17:49:23.288  INFO 617343 --- [Queue-Schedule-1] adBalancerFactory$FeignLabelLoadBalancer : set load balancer label:job_2
2021-07-16 17:49:23.293  INFO 617343 --- [Queue-Schedule-1] c.w.w.exchangis.route.MachineLoadRule    : Candidate nodes:[{"id":1,"address":"172.19.196.66:9501","heartbeatTime":"2021-07-16 09:48:37","status":0,"memRate":0.4195,"cpuRate":0.5292,"defaultNode":false}]
2021-07-16 17:49:23.294  INFO 617343 --- [Queue-Schedule-1] c.w.w.exchangis.route.MachineLoadRule    : Finally choose server:[172.19.196.66:9501]
2021-07-16 17:49:23.546  INFO 617343 --- [Queue-Schedule-1] c.w.w.e.j.s.impl.JobTaskServiceImpl      : run task 1627364701883207680 occurred exception, message: {"code":0,"data":{"executorAddress":"172.19.196.66:9501","status":"FAILD","message":"java.lang.RuntimeException: Task: 1627364701883207680 switch to user:'dss' failed","taskId":null,"execUser":"dss"},"message":"success"}
2021-07-16 17:49:23.622  INFO 617343 --- [Queue-Schedule-1] adBalancerFactory$FeignLabelLoadBalancer : set load balancer label:job_2
2021-07-16 17:49:23.627  INFO 617343 --- [Queue-Schedule-1] c.w.w.exchangis.route.MachineLoadRule    : Candidate nodes:[{"id":1,"address":"172.19.196.66:9501","heartbeatTime":"2021-07-16 09:48:37","status":0,"memRate":0.4195,"cpuRate":0.5292,"defaultNode":false}]
2021-07-16 17:49:23.627  INFO 617343 --- [Queue-Schedule-1] c.w.w.exchangis.route.MachineLoadRule    : Finally choose server:[172.19.196.66:9501]
2021-07-16 17:49:23.748  INFO 617343 --- [Queue-Schedule-1] c.w.w.e.j.s.impl.JobTaskServiceImpl      : run task 1627364701883207680 occurred exception, message: {"code":0,"data":{"executorAddress":"172.19.196.66:9501","status":"FAILD","message":"java.lang.RuntimeException: Task: 1627364701883207680 switch to user:'dss' failed","taskId":null,"execUser":"dss"},"message":"success"}
2021-07-16 17:49:23.753  INFO 617343 --- [Queue-Schedule-1] c.w.w.e.alarm.DefaultAlarmService        : AlarmTitle: [EXCHANGIS任务作业调度失败], AlarmLevel: [null], AlarmInfo: [任务名称:etl_student, JOB_ID: 2, TASK_ID: 1627364701883207680, 调度失败，请联系管理员处理。Please alarm(请通知): dss], AlarmReceivers: [dss]
2021-07-16 17:49:23.774  INFO 617343 --- [Queue-Schedule-1] c.w.w.e.j.s.impl.JobTaskServiceImpl      : remove element related task id: 1627364701883207680 from queue

# 执行失败情况2
2021-07-19 10:22:54.110  INFO 1557196 --- [ueue-Schedule-2] c.w.w.e.q.manager.QueueSchedulerManager  : Start to sync queue info
2021-07-19 10:22:54.403  INFO 1557196 --- [pool-3-thread-1] c.w.w.e.c.a.scheduler.ServTokenRefresh   : Get Token:eyJhbGxvd2Vk*******
2021-07-19 10:22:54.651  INFO 1557196 --- [eduler_Worker-9] c.w.w.e.j.s.impl.JobTaskServiceImpl      : Start to check task alive in batch
2021-07-19 10:22:54.654  INFO 1557196 --- [eduler_Worker-9] c.w.w.e.j.s.impl.JobTaskServiceImpl      : Fetched running task, result size: 2, lastId: 1628338745679941632, batchSize: 1000
2021-07-19 10:22:54.665  INFO 1557196 --- [pool-2-thread-4] c.w.w.e.s.c.bean.TaskAliveCheckBean      : Task jobId: [2], taskId: [1628337643039363072] is not alive, change the task status to [FAILD]
2021-07-19 10:22:54.673  INFO 1557196 --- [pool-2-thread-5] c.w.w.e.s.c.bean.TaskAliveCheckBean      : Task jobId: [2], taskId: [1628338745679941632] is not alive, change the task status to [FAILD]
2021-07-19 10:22:54.700  INFO 1557196 --- [pool-2-thread-5] c.w.w.e.alarm.DefaultAlarmService        : AlarmTitle: [EXCHANGIS任务作业执行失败], AlarmLevel: [null], AlarmInfo: [任务名称:etl_student, JOB_ID: 2, TASK_ID: 1628338745679941632, 运行失败，请登录EXCHANGIS查看详细日志。Please alarm(请通知): dss], AlarmReceivers: [dss]
2021-07-19 10:22:54.700  INFO 1557196 --- [pool-2-thread-4] c.w.w.e.alarm.DefaultAlarmService        : AlarmTitle: [EXCHANGIS任务作业执行失败], AlarmLevel: [null], AlarmInfo: [任务名称:etl_student, JOB_ID: 2, TASK_ID: 1628337643039363072, 运行失败，请登录EXCHANGIS查看详细日志。Please alarm(请通知): dss], AlarmReceivers: [dss]
2021-07-19 10:22:54.786  INFO 1557196 --- [duler_Worker-10] c.w.w.e.s.c.bean.TaskQueueRepairBean     : Task queue repair threshold [60]
2021-07-19 10:22:54.788  INFO 1557196 --- [duler_Worker-10] c.w.w.e.s.c.bean.TaskQueueRepairBean     : Repair queue element {"id":1628337643039363072,"qid":1,"enqTime":1626661213000,"pollTime":1626661214000,"createTime":1626660925000,"enqCount":2,"version":19,"delayTime":1626661200000,"delayCount":8,"status":1}
2021-07-19 10:22:54.790  INFO 1557196 --- [duler_Worker-10] c.w.w.e.s.c.bean.TaskQueueRepairBean     : Delete duplicate element {"id":1628337643039363072,"qid":1,"enqTime":1626661213000,"pollTime":1626661214000,"createTime":1626660925000,"enqCount":2,"version":19,"delayTime":1626661200000,"delayCount":8,"status":1}
2021-07-19 10:22:54.792  INFO 1557196 --- [duler_Worker-10] c.w.w.e.s.c.bean.TaskQueueRepairBean     : Repair queue element {"id":1628338745679941632,"qid":1,"enqTime":1626661203000,"pollTime":1626661214000,"createTime":1626661188000,"enqCount":2,"version":3,"delayTime":1626661188000,"delayCount":0,"status":1}
2021-07-19 10:22:54.793  INFO 1557196 --- [duler_Worker-10] c.w.w.e.s.c.bean.TaskQueueRepairBean     : Delete duplicate element {"id":1628338745679941632,"qid":1,"enqTime":1626661203000,"pollTime":1626661214000,"createTime":1626661188000,"enqCount":2,"version":3,"delayTime":1626661188000,"delayCount":0,"status":1}
2021-07-19 10:22:56.412  INFO 1557196 --- [ueue-Schedule-1] c.w.w.e.queue.manager.DbQueueManager     : Unlock queue id [1]
```

```java
@Override
public void init() {
    workDir = new File(WorkSpace.createLocalDirIfNotExist(getExecConfig().getJobLogDir(),
            getJobId(),  getTaskId()));
    taskLog = new DefaultLocalTaskLog(new File(workDir, logFileName()));
    initInternal();
    String execUser = getExecUser();
    //try to switch user, change the owner of working directory
    if(needToSwitchUser(execUser)){
        int code = changeOwnerRecursive(workDir, execUser);
        if(code != 0){
            throw new RuntimeException("Task: " + getTaskId() + " switch to user:'" + execUser + "' failed");
        }
    }
}
```

## 预先准备任务执行需要的资源

```java

/**JobExecutor  
    * Allocate resource for process and execute
    * @param taskProcess
    * @return
    */
private Future<Integer> allocAndExec(TaskProcess taskProcess)throws TaskResAllocException{
    //Get lock for allocating
    alloc.lock();
    boolean exec = false;
    boolean preAlloc = true;
    try{
        Resource resource = this.taskProcess.getResource();
        //Pre allocate
        if(null != resourceManager){
            preAlloc = resourceManager.allocate(resource);
        }
        if(preAlloc) {
            LOG.info("Pre-allocate task [{}] resource success, " +
                    "resource:["+ Json.toJson(resource, null) + "]", TaskProcessUtils.getTaskId(taskProcess));
            //execute and allocate actually
            return taskProcess.executeAsync();
        }else{
            LOG.info("Pre-allocate task:[" + TaskProcessUtils.getTaskId(taskProcess) + "]  resource failed," +
                    " resource:[" + Json.toJson(resource, null)+ "]");
            throw new TaskResAllocException();
        }
    }finally{
        notAlloc.signalAll();
        alloc.unlock();
    }
}
```

## 异步执行相关任务调度

```java
// executeAsync

    @Override
    public Future<Integer> executeAsync() {
        try {
            process = executeInternal();
            if (process == null){
                throw new TaskResAllocException("process == null");
            }
            long end = System.currentTimeMillis() + WAIT_FOR_ALLOCATE_TIME * 1000;
            boolean allocate = checkIfAlloc();
            boolean alive = true;
            while(!allocate  && System.currentTimeMillis() < end){
                Thread.sleep(CHECK_ALLOCATE_INTERVAL);
                allocate = checkIfAlloc();
                if (!alive){
                    break;
                }
                alive = process.isAlive();
            }
            if(!allocate){
                throw new TaskResAllocException();
            }
            return new JavaProcessFuture();
        }catch(Exception e){
            throw new TaskResAllocException(e.getMessage(), e);
        }
    }

```

## 选择执行引擎

```java
// ExecutorServiceImpl
return TaskProcessUtils.buildTaskProcess(req.getEngine(), jobId, taskId, execUser0, taskConfig,
                        configuration, req.getEngineParams());

// 引擎启动时设置user.dir有问题导致无法创建成功pid文件
public static void main(String[] args) {
    int exitCode = 0;
    LOG.info("start to run");
    String workDir = System.getProperty("user.dir");
    if(StringUtils.isBlank(workDir)){
        exitCode = 1;
    }else {
        try {
            //Write current process's pid into file
            savePID(workDir);
            //Set security manager
            System.setSecurityManager(new ThreadLocalSecurityManager());
            Engine.entry(args);
            removePID(workDir);
        } catch (Throwable e) {
            exitCode = 1;
            LOG.error("\n\n该任务最可能的错误原因是:\n" + ExceptionTracker.trace(e));
            if (e instanceof DataXException) {
                DataXException tempException = (DataXException) e;
                ErrorCode errorCode = tempException.getErrorCode();
                if (errorCode instanceof FrameworkErrorCode) {
                    FrameworkErrorCode tempErrorCode = (FrameworkErrorCode) errorCode;
                    exitCode = tempErrorCode.toExitValue();
                }
            }
            //Throw OutOfMemoryError
            Throwable cause = e;
            try {
                while (null != cause) {
                    if (cause instanceof OutOfMemoryError) {
                        throw (OutOfMemoryError) cause;
                    }
                    cause = cause.getCause();
                }
            }finally{
                System.exit(exitCode);
            }
        }
    }
    System.exit(exitCode);
}
```


## 真实执行命令的语句, 切换到对应的用户执行相应的语句

```sh
2021-07-19 10:20:23.535  INFO 1567000 --- [      Thread-23] c.w.w.exchangis.executor.JobExecutor     : Pre-allocate task [1628338745679941632] resource success, resource:[{"resourceId":1628338745679941632,"memByte":1073741824,"cpuCore":0}]
2021-07-19 10:20:23.535  INFO 1567000 --- [      Thread-23] c.w.w.e.e.t.p.datax.DataxTaskProcess     : Run Command:sudo su jsdu -c "/usr/lib/jvm/java-11-openjdk/bin/java -Xmx1024m -Xms1024m -classpath /data/code/Exchangis/modules/executor/core/engine/datax/lib/*:. -XX:+HeapDumpOnOutOfMemoryError -Dfile.encoding=UTF-8 -Djava.security.egd=file:///dev/urandom -Dloglevel=info -Dlogback.statusListenerClass=ch.qos.logback.core.status.NopStatusListener -Ddatax.home=/data/code/Exchangis/modules/executor/core/engine/datax -Dlog.file.name=out.log -Dlogback.configurationFile=/data/code/Exchangis/modules/executor/core/engine/datax/conf/log/logback.xml -Dserver.address=172.19.196.66:9501 com.alibaba.datax.core.Engine -jobid 1628338745679941632 -job /data/code/Exchangis/data/2_1628338745679941632/job.json -mode standalone"
```


# 到执行节点执行命令报错
```sh
[root@DataSphereStudio-Test Exchangis]# sudo su jsdu -c "/usr/lib/jvm/java-11-openjdk/bin/java -Xmx1024m -Xms1024m -classpath /data/code/Exchangis/modules/executor/core/engine/datax/lib/*:. -XX:+HeapDumpOnOutOfMemoryError -Dfile.encoding=UTF-8 -Djava.security.egd=file:///dev/urandom -Dloglevel=info -Dlogback.statusListenerClass=ch.qos.logback.core.status.NopStatusListener -Ddatax.home=/data/code/Exchangis/modules/executor/core/engine/datax -Dlog.file.name=out.log -Dlogback.configurationFile=/data/code/Exchangis/modules/executor/core/engine/datax/conf/log/logback.xml -Dserver.address=172.19.196.66:9501 com.alibaba.datax.core.Engine -jobid 1628340978056302592 -job /data/code/Exchangis/data/2_1628340978056302592/job.json -mode standalone"
Error: Could not find or load main class com.alibaba.datax.core.Engine
Caused by: java.lang.ClassNotFoundException: com.alibaba.datax.core.Engine
```

## 执行命令的代码

```java
 @Override
    public Process executeInternal() {
        String execUser = getExecUser();
        Method method = getMethod();
        String command = "";
        // --jvm=-Xms -Xmx
        String maxMemory = getTaskConfig().getString(JOB_ADVANCE_MAX_MEMORY, DEFAULT_JVM_HEAP_MEMORY).toLowerCase();
        long mMemory = MemUtils.convertToMB(Long.parseLong(maxMemory.substring(0, maxMemory.length() - 1)),
                maxMemory.substring(maxMemory.length() - 1));
        if(method == Method.PYTHON){
            command = StringUtils.join(new String[]{
                    getExecConfig().getEngineDataXPythonShell(), getExecConfig().getEngineDataXPythonScript(),
                    getExecConfig().getEngineDataXConfFile(),
                    "--" + JOB_ID_CMD + "=" + getTaskId(),
                    "--jvm='-Xms" + mMemory + "m -Xmx" + mMemory + "m'",
                    "-p'" +
                    " -D" + EXEC_USER_CMD + "=" + execUser +
                    " -D" + LOG_FILE_NAME_CMD + "=" + logFileName() +
                    " -D" + SERVER_ADDRESS_CMD + "=" + StringUtils.substringAfter(AppUtil.getIpAndPort(), "http://") +
                    "'"}, " ");
        }else{
            JavaCommandBuilder builder = new JavaCommandBuilder(MachineInfo.getProcPath(),
                    getExecConfig().getEngineDataXJavaMainClass())
                    .Xmx(mMemory, MemUtils.StoreUnit.MB).Xms(mMemory, MemUtils.StoreUnit.MB)
                    .classPath(getExecConfig().getEngineDataXJavaClassPath())
                    .prop("-D" + LOG_LEVEL_CMD, "info")
                    .prop("-D" + LOGBACK_LISTENER_CMD, NopStatusListener.class.getName())
                    .prop("-D" + HOME_CMD, dataXHome)
                    .prop("-D" + LOG_FILE_NAME_CMD,  logFileName())
                    .prop("-D" + LOGBACK_CONF_CMD, getExecConfig().getEngineDataXJavaLogConf())
                    .prop("-D" + SERVER_ADDRESS_CMD, StringUtils.substringAfter(AppUtil.getIpAndPort(), "http://"))
                    .cmdProp("-" + JOB_ID_CMD, String.valueOf(getTaskId()))
                    .cmdProp("-" + JOB_CMD, this.workDir.getAbsolutePath() + File.separator + getExecConfig().getEngineDataXConfFile())
                    .cmdProp("-" + MODE_CMD, "standalone");
            command = builder.build();
        }
        if(needToSwitchUser(execUser)){
            command = "sudo su " + execUser + " -c \"" + command + "\"";
        }
        LOG.info("Run Command:{}", command);
        Map<String,String> env = new HashMap<>(4);
        LOG.trace("Add token path {} to env", System.getProperty(AuthConstraints.ENV_SERV_TOKEN_PATH));
        try {
            ProcessBuilder builder = RunShell.createProcBuilder(command, env, this.workDir);
            return builder.start();
        } catch (Exception e) {
            LOG.error("Execute DataX occurred error: "+ e.getMessage(), e);
            throw new RuntimeException(e);
        }
    }
```

## 在命令执行的前后可以添加hook的代码

```java
    private void addHooksToJobExecutor(JobExecutor newJobExecutor){
        //add timeout hook
        newJobExecutor.addHook(JobExecutor.Hook.TASK_TIMEOUT, (taskProcess, message)->{
            long jobId = TaskProcessUtils.getJobId(taskProcess);
            long taskId = TaskProcessUtils.getTaskId(taskProcess);
            LOG.info("Task jobId [{}],taskId [{}] timeout ,message {}", jobId, taskId, message);
            Response<String> rsp = callBackService.notifyTaskTimeout(taskId, message);
            if(rsp.getCode() == 0){
                LOG.info("Notify task [{}] timeout, success", taskId);
            }else{
                LOG.error("Notify task [{}] timeout error, message {}", taskId, rsp.getMessage());
            }
        });
        //add hook to remove container when the task ends
        newJobExecutor.addHook(JobExecutor.Hook.TASK_END, (taskProcess, message) ->
                jobContainerManager.removeContainer(TaskProcessUtils.getTaskId(taskProcess)));
    }
```

## sigara 报错

```sh
org.springframework.beans.factory.BeanCreationException: Error creating bean with name 'executorController': Injection of resource dependencies failed; nested exception is org.springframework.beans.factory.BeanCreationException: Error creating bean with name 'executorServiceImpl': Injection of resource dependencies failed; nested exception is org.springframework.beans.factory.BeanCreationException: Error creating bean with name 'localResourceManager': Invocation of init method failed; nested exception is java.lang.UnsatisfiedLinkError: 'void org.hyperic.sigar.Mem.gather(org.hyperic.sigar.Sigar)'
```

```java
@Component
public class ResourceConfiguration {
    @Value("${executor.resource.threshold.cpu}")
    private double thresholdCpu;

    @Value("${executor.resource.threshold.memory}")
    private double thresholdMem;

    public double getThresholdCpu() {
        return thresholdCpu;
    }


    public double getThresholdMem() {
        return thresholdMem;
    }

}
```

缺少sigar依赖库

```sh
no libsigar-amd64-linux.so in java.library.path: [/usr/java/packages/lib, /usr/lib64, /lib64, /lib, /usr/lib]
org.hyperic.sigar.SigarException: no libsigar-amd64-linux.so in java.library.path: [/usr/java/packages/lib, /usr/lib64, /lib64, /lib, /usr/lib]
        at org.hyperic.sigar.Sigar.loadLibrary(Sigar.java:172)
        at org.hyperic.sigar.Sigar.<clinit>(Sigar.java:100)
```

配置sigar的依赖, 将

```sh
export LD_LIBRARY_PATH=/data/code/Exchangis/modules/executor/core/src/main/native/
```

https://blog.csdn.net/u014694028/article/details/49514539

https://cloud.tencent.com/developer/article/1455972

https://github.com/hyperic/sigar

https://blog.csdn.net/xiaozhegaa/article/details/79920243

https://www.cnblogs.com/mr-totoro/p/4974979.html

https://www.cnblogs.com/luoruiyuan/p/5603771.html

# eureka配置含义

https://blog.csdn.net/qq_24983911/article/details/104171852

https://www.cnblogs.com/fm98/p/14011794.html