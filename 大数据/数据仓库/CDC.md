# CDC

数据同步是指数仓或者数据湖内的数据与上游业务库内的数据保持同步的状态。当上游业务库内的数据发生变更之后，下游的数仓/数据湖立即感知到数据变化，并将数据变化同步过来。在数据库中，这类场景称为Change Data Capture（CDC）场景。

CDC的实现方案比较多，但是大多是在数据库领域，相应的工具也比较多。在大数据领域，这方面的实践较少，也缺乏相应的标准和技术实现。通常您需要选择已有的引擎，利用它们的能力自己搭建一套CDC方案。常见的方案大概分为下面两类：

- 定期批量Merge方式：上游原始表捕获增量更新，将更新的数据输出到一个新的表中，下游仓库利用MERGE或UPSERT语法将增量表与已有表进行合并。这种方式要求表具有主键或者联合主键，且实时性也较差。另外，这种方法一般不能处理DELETE的数据，实际上用删除原表重新写入的方式支持了DELETE，但是相当于每次都重新写一次全量表，性能不可取，还需要有一个特殊字段来标记数据是否属于增量更新数据。
- 上游源表输出binlog（这里我们指广义的binlog，不限于MySQL），下游仓库进行binlog的回放。这种方案一般需要下游仓库能够具有实时回放的能力。但是可以将row的变化作为binlog输出，这样，只要下游具备INSERT、UPDATE、DELETE的能力就可以了。不同于第一种方案，这种方案可以和流式系统结合起来。binlog可以实时地流入注入Kafka的消息分发系统，下游仓库订阅相应的Topic，实时拉取并进行回放。

https://help.aliyun.com/document_detail/148382.html

## 数据变化捕获方案


https://blog.csdn.net/debug_fan/article/details/121035162

cdap中数据捕获

https://cdap.atlassian.net/wiki/spaces/CE/pages/1608810924/Change+Data+Capture

https://jishuin.proginn.com/p/763bfbd5c70c
