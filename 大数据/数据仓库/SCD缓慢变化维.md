# SCD缓慢变化维

因为事实表存储的是维度表的代理键而非自然键，因此在历史数据的查询中会以历史的维度值进行计算。同时在维度值更新后的相关数据自然使用的是新的代理键。完美的解决了大部分缓慢变化维情况。

自增ID一般是代理键,标识记录的唯一性;
记录实体的标识一般是自然键, 标识记录实体的唯一性;


https://www.sqlshack.com/implementing-slowly-changing-dimensions-scds-in-data-warehouses/

https://juejin.cn/post/6844904137419669517

https://zhuanlan.zhihu.com/p/336501748

https://help.aliyun.com/document_detail/295435.html

# 缓慢变化维数据如何更新

https://blog.csdn.net/u014337370/article/details/110677017