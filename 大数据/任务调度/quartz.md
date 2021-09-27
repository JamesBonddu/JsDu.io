# quartz

```yml
quartz:
    properties:
    org:
        quartz:
        scheduler:
            instanceName: clusteredScheduler
            instanceId: AUTO
        jobStore:
            class: org.quartz.impl.jdbcjobstore.JobStoreTX
            driverDelegateClass: org.quartz.impl.jdbcjobstore.StdJDBCDelegate
            tablePrefix: EXCHANGIS_QRTZ_
            isClustered: true
            clusterCheckinInterval: 10000
            useProperties: false
            acquireTriggersWithinLock: true
        threadPool:
            class: org.quartz.simpl.SimpleThreadPool
            threadCount: 10
            threadPriority: 5
            threadsInheritContextClassLoaderOfInitializingThread: true
```

https://www.w3cschool.cn/quartz_doc/

https://blog.csdn.net/noaman_wgs/article/details/80984873

https://github.com/quartz-scheduler/quartz

https://segmentfault.com/a/1190000038401111

https://www.baeldung.com/quartz

## spring 整合quartz

https://www.jianshu.com/p/df13ec7d9169