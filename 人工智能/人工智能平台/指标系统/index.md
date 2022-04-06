# 指标系统

指标库是数据中台的一部分，其目的主要是为经营分析，为BI报表系统的业务场景服务的，将常用的指标根据数据标准整理加工，存在在指标库中，每个指标有自己的标签及元数据信息，用户可以直接在指标库中搜索自己想要的指标；指标一般已经有特定提出的需求了，而中台的构建是不仅基于现在的东西，还要展望以后的可能遇到的各种情况，所以它整合的数据肯定要比指标库要更多。中台是一套强调资源整合、能力沉淀的平台体系，上对前台各系统提供公共的、强有力的业务支撑，下为数据的整合及应用提供保障。

作者：元年科技
链接：https://www.zhihu.com/question/343207389/answer/1621532710
来源：知乎
著作权归作者所有。商业转载请联系作者获得授权，非商业转载请注明出处。

指标系统 EasyIndex

https://sf.163.com/product/easyindex

https://sq.sf.163.com/blog/article/591433097523941376


# 搭建多维指标查询系统

开源OLAP产品：
Mondrian:咱们预研选型的OLAP引擎产品，http://mondrian.pentaho.org Mondrian是开源世界中最为有名的OLAP Server特色是功能强大,易学易用，被评价为“穷人最适合的OLAP产品”



JPivot : http://jpivot.sourceforge.net/ 一个OLAP的客户端，使用XML+XSL来展示OLAP的数据，虽然咱们老是说Mondrian + JPivot ，可是其实Mondrian官方都说他们是当心翼翼的分开Mondrian + JPivot的，因此你能够任意选择OLAP Server 和 OLAP Client 的组合的，JPivot 也支持MSSQL Server的 OLAP 数据源的.



Palo : http://www.imppalo.com/   一个MOLAP实现，已经有商业化公司运行了，产品相对成熟，若是你看过RoadMap 那一篇的话，你就应该已经知道spagoBI的roadmap里面已经开始要支持Palo了.



JPalo : http://www.jpalo.com/  一个基于Palo的Java客户端，基于eclipse的RCP 技术，并提供API访问Palo的Server 。SpagoBI 在RoadMap中也计划支持这对组合，Mondrian + JPivot 的竞争对手.



Cubulus OLAP : http://cubulus.sourceforge.net/  一个OLAP Server + Client ， Python写的，目前支持mySQL,PostgreSQL , SQLite .看来还很不成熟。

# Saiku + Kylin


https://tech.youzan.com/kylin-mondrian-saiku/

https://github.com/mustangore/kylin-mondrian-interaction

https://kylin.apache.org/cn_blog/2019/05/23/saiku-kylin-molap/

https://cn.kyligence.io/blog/apache-kylin-saiku-olap/

https://www.cnblogs.com/liqiu/p/5203196.html

https://www.infoq.cn/article/practice-evolution-and-structure-system-of-juanpi-bi

https://coffee.pmcaff.com/article/2845313197702272/pmcaff?utm_source=forum

https://juejin.cn/post/6983441706439933982

## StarRocks

https://www.starrocks.com/zh-CN/blog/beikezhaofang

## DORIS

https://ai.baidu.com/forum/topic/show/984100


## 猛犸指标系统

https://www.secrss.com/articles/15465

## kyligence + byzer

https://cn.kyligence.io/metrics-store/

https://cn.kyligence.io/open-source-community/

## saiku

http://lxw1234.com/search/hive+%E5%88%86%E6%9E%90/

http://lxw1234.com/archives/2016/05/659.htm

# Mondrain

业界一般使用Mondrian，是SAIKU+Mondrian一起使用，SAIKU还带了界面，使用很方便。但是我们作为一个线上系统，肯定是有自己的前端的。此外，为了让指标配置规范还，系统化，我们引入了原数据管理服务，管理Mondrian的Schema和指标配置，因此我们的方案主要是三块：QueryServer+MetaServer+Mondrian。详细架构如下图所示：

https://saiku-documentation.readthedocs.io/en/latest/

https://mondrian.pentaho.com/documentation/schema.php

https://tech.youzan.com/kylin-mondrian-saiku/

https://github.com/mustangore/kylin-mondrian-interaction

https://kylin.apache.org/cn_blog/2019/05/23/saiku-kylin-molap/

https://www.slideshare.net/lukehan/5-apache-kylin-apache-kylin-meetup-shanghai

https://github.com/pentaho/mondrian

https://zhuanlan.zhihu.com/p/454633751

https://juejin.cn/post/6931635437282787335

https://www.shangmayuan.com/a/a3ba138b2d9a475d8f88778a.html

https://cn.kyligence.io/blog/olap-mondrian-non-functional-optimization/

https://blog.csdn.net/shenliang1985/article/details/80026966

http://lxw1234.com/archives/2016/05/647.htm



https://www.infoq.cn/article/qgvyuf9kl4wljio8ufvy

## 数据指标体系

https://segmentfault.com/a/1190000040692859

https://blog.51cto.com/u_15349018/3833099

# Data Focus

https://www.datafocus.ai/infos/21115.html

https://www.datafocus.ai/infos/study

指标管理系统设计

https://www.cnblogs.com/niceshot/p/13640630.html

https://www.infoq.cn/article/bxudbggfc6q6mx0f2r3x

https://help.fanruan.com/dvg/doc-view-49.html


1. 以统一的指标表存放所有的指标数据
2.
指标id	指标code	指标value	日期分区
