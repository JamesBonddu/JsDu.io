# jeecg-boot

http://www.jeecg.com/doc/quickstart

http://doc.jeecg.com/2043868

## 基础环境搭建

http://doc.jeecg.com/2043872

## 自定义代码模板生成器

http://doc.jeecg.com/2307274

## 多个数据源配置

http://doc.jeecg.com/2043947

## 常见问题

http://doc.jeecg.com/2043926

# jimu开源平台

http://www.jeecg.com/doc/download


# 积木代码解读

核心模块

```mvn
<modules>
    <module>jeecg-boot-base</module>
    <module>jeecg-boot-module-system</module>
    <module>jeecg-boot-module</module>
    <module>hitechpark-modules</module>
    <module>jeecg-boot-platform</module>
    <module>metrics</module>
    <!-- 新增元数据模块-->
    <module>metadata</module>
    <!-- 新增数据管理模块-->
    <module>datamanager</module>
    <!-- 微服务开发解开注释
        <module>jeecg-boot-starter</module>
        <module>jeecg-cloud-module</module>-->
</modules>
```

## jeecg-boot-base
积木基础代码

- jeecg-boot-base-api
  存放常用api的接口的地方
- jeecg-boot-base-core
  存放分页, 配置, oss/minio存储, 日志记录, 加密, 数据权限和常用工具的地方.
- jeecg-boot-base-tools

### threadPoolConfig

```java
// 使用Spring封装的异步线程池
ThreadPoolTaskExecutor executor = new ThreadPoolTaskExecutor();
// 初始化线程数
executor.setCorePoolSize(corePoolSize);
// 最大线程数
executor.setMaxPoolSize(maxPoolSize);
// 缓冲队列
executor.setQueueCapacity(queueCapacity);
// 允许空闲时间/秒
executor.setKeepAliveSeconds(keepAliveSeconds);
// 线程池名前缀-方便日志查找
executor.setThreadNamePrefix(threadNamePrefix);
executor.setRejectedExecutionHandler(new ThreadPoolExecutor.CallerRunsPolicy());
executor.setWaitForTasksToCompleteOnShutdown(waitForTasksToCompleteOnShutdown);
executor.setAwaitTerminationSeconds(awaitTerminationSeconds);
// 初始化
executor.initialize();
```

JDK 提供了四种内置拒绝策略，我们要理解并记住，有如下的四种：
1、DiscardPolicy: 默默丢弃无法处理的任务，不予任何处理
2、DiscardOldestPolicy: 丢弃队列中最老的任务, 尝试再次提交当前任务
3、AbortPolicy: 直接抛异常，阻止系统正常工作。
4、CallerRunsPolicy: 将任务分给调用线程来执行,运行当前被丢弃的任务，这样做不会真的丢弃任务，但是提交的线程性能有可能急剧下降。

https://blog.csdn.net/u010834071/article/details/80655777


## jeecg-boot-system

- cas
单点登录
- quartz
定时任务使用
quartzJob curd

Scheduler、Job 、JobDetail、Trigger四个类.

@PersistJobDataAfterExecution
@PersistJobDataAfterExecution：告诉Quartz在成功执行了Job实现类的execute方法后（没有发生任何异常），更新JobDetail中JobDataMap的数据，使得该JobDetail实例在下一次执行的时候，JobDataMap中是更新后的数据，而不是更新前的旧数据。
@DisallowConcurrentExecution

```yaml
## quartz定时任务,采用数据库方式
quartz:
job-store-type: jdbc
initialize-schema: embedded
#设置自动启动，默认为 true
auto-startup: true
#启动时更新己存在的Job
overwrite-existing-jobs: true
properties:
    org:
    quartz:
        scheduler:
        instanceName: MyScheduler
        instanceId: AUTO
        jobStore:
        class: org.quartz.impl.jdbcjobstore.JobStoreTX
        driverDelegateClass: org.quartz.impl.jdbcjobstore.StdJDBCDelegate
        tablePrefix: QRTZ_
        isClustered: true
        misfireThreshold: 60000
        clusterCheckinInterval: 10000
        threadPool:
        class: org.quartz.simpl.SimpleThreadPool
        threadCount: 10
        threadPriority: 5
        threadsInheritContextClassLoaderOfInitializingThread: true
```

```java
/**
    * 添加定时任务
    *
    * @param jobClassName
    * @param cronExpression
    * @param parameter
    */
private void schedulerAdd(String jobClassName, String cronExpression, String parameter) {
    try {
        // 启动调度器
        scheduler.start();

        // 构建job信息
        JobDetail jobDetail = JobBuilder.newJob(getClass(jobClassName).getClass()).withIdentity(jobClassName).usingJobData("parameter", parameter).build();

        // 表达式调度构建器(即任务执行的时间)
        CronScheduleBuilder scheduleBuilder = CronScheduleBuilder.cronSchedule(cronExpression);

        // 按新的cronExpression表达式构建一个新的trigger
        CronTrigger trigger = TriggerBuilder.newTrigger().withIdentity(jobClassName).withSchedule(scheduleBuilder).build();

        scheduler.scheduleJob(jobDetail, trigger);
    } catch (SchedulerException e) {
        throw new JeecgBootException("创建定时任务失败", e);
    } catch (RuntimeException e) {
        throw new JeecgBootException(e.getMessage(), e);
    }catch (Exception e) {
        throw new JeecgBootException("后台找不到该类名：" + jobClassName, e);
    }
}
```

https://www.jianshu.com/p/06c4307214b7

https://blog.csdn.net/wh_07/article/details/111063023

- message
消息通知


## jeecg-boot-oa

oa和activity 工作流引擎

功能模块包含
- im在线聊天
    EoaChatUserGroup
    群和讨论组表成员表

    EoaChatUser
    用户表

    EoaChatRealTime
    用户实时消息表

    EoaChatOffMessage
    离线消息表

    EoaChatHistorical
    用户历史消息表

    EoaChatGrouping
    组

    EoaChatGroup
    组

    EoaChatFriend
    朋友

    EoaCharUserGrouping
    组和朋友

    EoaCharMsg
    消息盒子

- email邮件
邮件类别表; 邮件附件表; 邮件信息表; 邮件往来记录表;

- 文件管理


https://blog.xxleee.com/pages/ecology/activiti/introduction/
