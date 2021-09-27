# 数据仓库


https://open.163.com/newview/movie/free?pid=HFVMCRJAL&mid=DFVMEDHJ7

https://www.xiaoheidiannao.com/68761.html

https://g.yuque.com/xiaokunlong/va45ay/owrykg?language=en-us

## 数据工程师教程

https://github.com/0xnr/awesome-bigdata


https://github.com/san089/Udacity-Data-Engineering-Projects


https://github.com/dimgold/ETL_with_Python/blob/master/ETL_with_Python.ipynb

https://dbaplus.cn/news-73-2934-1.html


丁香园COVID-19数据仓库

https://github.com/BlankerL/DXY-COVID-19-Data/blob/master/README.md


https://manual.sensorsdata.cn/sa/latest/guide_metadata_dimension-7540415.html

APM数据仓库

https://github.com/Appdynamics/AppDynamics.DEXTER


https://github.com/iam-mhaseeb/Skytrax-Data-Warehouse

Airbnb数据仓库

https://github.com/matkosoric/Airbnb-Data-Model

https://github.com/naderAsadi/Udacity-Data-Engineering-Projects/blob/master/Airflow-Data-Pipelines/README.md

# 华为数据仓库设计方案

https://www.huaweicloud.com/articles/82b67712cabc74252eb3efe12aff7914.html


目前严选数据把模型分为三层，ods，dw 和 dm 层。其中 ods 是操作数据层，保留最原始的数据；dw 包含 dwd 和 dws 层，这两层共同组成中间层；dm 是应用层，基于 dw 层做汇总加工，满足各产品、分析师和业务方的需求。


ODS 层（操作数据层）：不对外开放，把业务系统数据同步到数仓。数据格式保留业务系统的数据格式；目前主要通过 datahub 解析 binlog 来实现的，目前严选的 ods 层数据同步主要以全量数据为主。

DWD 层（明细层）：对外开放，主要作用是沉淀一些公共的逻辑，常用维度属性的关联等，下游经常在一起使用的模型会在这一层做宽表处理，减少事实表和维表的关联，减少重复的关联加工。

DWS 层（汇总层）：对外开放，主要沉淀严选数据的公共指标，dws 层是整个严选数据对外开放和使用的核心，是严选最核心的数据资产。

DIM 层（维表）：对外开放，主要是一些常用维表，比如商品维表、sku 维表、渠道维表。

DM 层（应用层）：对产品开放使用，支持数据产品、报表的使用，主要是不公用复杂指标的汇总和计算。


https://www.infoq.cn/article/hfzrkt7ye6xflgaz9sep


数据分层

https://www.kancloud.cn/grass1314521/data_warehouse_in_action/490402

有赞数据仓库

https://tech.youzan.com/dw-in-youzan/


## ODS层如何处理

然后对于数据清洗，居士个人建议是尽量少做清洗，如果在这一层做清洗，建议只在几种情况下做清洗：

简单的数据标准化，比如表和字段命名

默认值填充，比如性别为空的都补0

清洗规则十分明确，比如说说字段拆解：

接收到的json数据拆成多个明确字段

https://blog.csdn.net/zhaodedong/article/details/100402120


# 时间维度表

https://docs.microsoft.com/zh-cn/analysis-services/multidimensional-models/create-a-time-dimension-by-generating-a-time-table?view=asallproducts-allversions

https://github.com/dantezhao/data-group/issues/1

## mysql 创建时间维度表的方式

https://www.huaweicloud.com/articles/9a32491f09a3ab0c2d8aeab331ecde9f.html

https://ask.hellobi.com/question/6363

https://www.jianshu.com/p/c7661d2019fb

## 地区维度表

https://open.163.com/newview/movie/free?pid=HFVMCRJAL&mid=DFVMEDHJ7

## 事实表,维度表，聚合表

https://blog.csdn.net/u010670689/article/details/79989826

https://cloud.tencent.com/developer/article/1514589


https://blog.csdn.net/zhaodedong/article/details/104604247


https://cloud.tencent.com/developer/article/1551875


## 数据仓库推进

https://bigdata.51cto.com/art/202010/628337.htm

https://canehealth.com/tag/datawarehouse/


## 数据增量同步

我们逐步转向CDC (Change Data Capture) + Merge的技术方案，即实时Binlog采集 + 离线处理Binlog还原业务数据这样一套解决方案。Binlog是MySQL的二进制日志，记录了MySQL中发生的所有数据变更，MySQL集群自身的主从同步就是基于Binlog做的。

https://jiamaoxiang.top/2020/03/24/%E5%9F%BA%E4%BA%8ECanal%E4%B8%8EFlink%E5%AE%9E%E7%8E%B0%E6%95%B0%E6%8D%AE%E5%AE%9E%E6%97%B6%E5%A2%9E%E9%87%8F%E5%90%8C%E6%AD%A5-%E4%BA%8C/

https://www.analysys.cn/article/detail/20019149

数据仓库选型

大数据领域开源OLAP引擎包括但是不限于Hive、Druid、Hawq、Presto、Impala、Sparksql、Clickhouse、Greenplum等等。

https://yq.aliyun.com/articles/691541 
https://dwz.cn/qwcuWD4L https://tech.meituan.com/2018/10/18/meishi-data-flink.html http://lxw1234.com/archives/2017/07/867.html 
https://www.codercto.com/a/47662.html

## clickhouse做数据仓库存储组件

https://jiankunking.com/sentry-high-availability-deploy.html

https://github.com/getsentry/snuba

https://xiaoyue26.github.io/2019/07/06/2019-07/%E7%B2%97%E4%BF%97%E7%90%86%E8%A7%A3clickhouse/



# 数据层
分层	数据描述	生成计算工具	存储媒介
ODS	原始数据，日志和业务数据	日志服务器，maxwell/canal	kafka
DWD	根据数据对象为单位进行分流，比如订单、页面访问等等。	FLINK	kafka
DWM	对于部分数据对象进行进一步加工，比如独立访问、跳出行为。依旧是明细数据。	FLINK	kafka
DIM	维度数据	FLINK	HBase
DWS	根据某个维度主题将多个事实数据轻度聚合，形成主题宽表。	FLINK	Clickhouse
ADS	把 Clickhouse 中的数据根据可视化需要进行筛选聚合。	Clickhouse, SQL	可视化展示


https://blog.csdn.net/wuxintdrh/article/details/114528105

## MaxCompute

https://help.aliyun.com/document_detail/114631.html?spm=a2c4g.11186623.6.612.6cc0745dYv5ShX

# 数据仓库实践

## 元数据管理

https://blog.csdn.net/cfy_fantasyxx/article/details/103004560

https://tech.youzan.com/youzan-metadata/

https://zhuanlan.zhihu.com/p/36136675

https://cxliang.gitbooks.io/datapm/content/di-2-zhang-shu-ju-cai-96c6-qing-xi/yuan-shu-ju-guan-li.html

http://www.woshipm.com/pd/4075615.html


### 书籍

https://www.zhihu.com/question/52365580

### 竞品

https://manual.sensorsdata.cn/sa/latest/guide_metadata-22252521.html

## 维度建模

https://jiamaoxiang.top/2020/07/11/%E6%95%B0%E4%BB%93-%E5%A4%A7%E6%95%B0%E6%8D%AE%E6%97%B6%E4%BB%A3-%E7%BB%B4%E5%BA%A6%E5%BB%BA%E6%A8%A1%E8%BF%87%E6%97%B6%E4%BA%86%E5%90%97/

# 推荐系统

1、基于内容的推荐 Python的话，推荐考察一下gensim：gensim: Topic modelling for humans。 Java的话，可以考虑easyrec：easyrec :: open source recommendation engine另外可以考虑类似solr或Elasticsearch的MoreLikeThis或直接基于lucene  term vector方案（例如semanticvectors  https://github.com/semanticvectors/semanticvectors）。
2、协同过滤除了采用mahout外，目前我知道很多公司推荐引擎都转向spark MLLib（底层算法可以采用mahout）或GraphLab。有几个完整解决方案的项目推荐考察一下（prediction、seldon都是基于spark的）：prediction: PredictionIO Open Source Machine Learning Serverseldon: Seldon - Open Source Machine Learning for Enterpriseoryx(以前叫Myrrix)：cloudera/oryx: Simple real-time large-scale machine learning infrastructure.编辑于 2016-01-28

https://www.bilibili.com/read/cv5726013/

https://www.jianshu.com/p/981e4f065544

https://www.zhihu.com/question/39121455


基于内容推荐
gensim

基于标签推荐
Simple Tag-based、Normal Tag-based、Tag-based-Tfidf 

https://www.cnblogs.com/laiyaling/p/14040569.html

https://www.6aiq.com/article/1600384604366

UCG推荐
bitmap

https://leriou.github.io/2017-12-29-user-tag-sys-on-bitmap/

https://www.6aiq.com/article/1600384604366




# 召回系统

排序阶段使用FM模型、GBDT+LR模型、DNN模型

https://zhuanlan.zhihu.com/p/58160982

https://segmentfault.com/a/1190000038334828

https://www.6aiq.com/article/1609351219514

https://www.infoq.cn/article/qfl1nxcxhuxv723imb7v

http://www.csuldw.com/2019/02/06/2019-02-06-recommendation-with-neural-network-embeddings/


https://www.jiqizhixin.com/articles/2020-07-21-16

https://tech.youzan.com/you-zan-tui-jian-xi-tong-guan-jian-ji-zhu/

FM召回

https://help.aliyun.com/document_detail/150032.html

https://yonigottesman.github.io/recsys/pytorch/elasticsearch/2020/02/18/fm-torch-to-recsys.html

# es作为召回组件

https://zhuanlan.zhihu.com/p/53349817

https://juejin.cn/post/6885249555898728455

https://cloud.tencent.com/developer/article/1526302

https://segmentfault.com/a/1190000037527653

https://juejin.cn/post/6844903988643495943

# 召回 !!

https://juejin.cn/post/6885249555898728455#heading-14

https://www.cnblogs.com/gczr/p/12564617.html

语义召回
https://blog.csdn.net/qq_16949707/article/details/114672466

https://yuerblog.cc/2018/01/09/elasticsearch-custom/

ES召回基于BM25召回
除了基本的文本匹配召回，还需要通过构建 query 意图 tag 召回或进行语义匹配召回等多路召回来提升搜索语义相关性以及保证召回的多样性。

https://zhuanlan.zhihu.com/p/349993294

https://www.6aiq.com/article/1588904027930

https://www.infoq.cn/article/oei9cvwfaeflcsopedqa

## 推荐系统环节

四个环节分别是：召回、粗排、精排和重排。召回目的如上所述；有时候因为每个用户召回环节返回的物品数量还是太多，怕排序环节速度跟不上，所以可以在召回和精排之间加入一个粗排环节，通过少量用户和物品特征，简单模型，来对召回的结果进行个粗略的排序，在保证一定精准的前提下，进一步减少往后传送的物品数量，粗排往往是可选的，可用可不同，跟场景有关。之后，是精排环节，使用你能想到的任何特征，可以上你能承受速度极限的复杂模型，尽量精准地对物品进行个性化排序。排序完成后，传给重排环节，传统地看，这里往往会上各种技术及业务策略，比如去已读、去重、打散、多样性保证、固定类型物品插入等等，主要是技术产品策略主导或者为了改进用户体验的。

https://zhuanlan.zhihu.com/p/100019681

### 召回

http://www.woshipm.com/pd/2051274.html


# 数据湖

https://ranying666.github.io/2020/12/16/datalake/

# ETL 

https://missfoxw.github.io/pdi-kettle/#/README

https://segmentfault.com/a/1190000015157700

https://segmentfault.com/a/1190000038308664

https://www.xplenty.com/blog/top-7-etl-tools/

## talend

https://www.talend.com/

https://help.talend.com/r/dIDZNNMEsN71~UPJfVIEOQ/bNBoyM2pE4S~6K_QgSZJQA

airflow + talend

https://www.talend.com/blog/2019/01/04/an-introduction-to-apache-airflow-and-talend-orchestrate-your-containerized-data-integration-and-big-data-jobs/

http://xuzhenxue.cn/2018/07/28/airflow-ETL/

https://www.cnblogs.com/xiongnanbin/p/11978541.html

## Kettle

https://blog.csdn.net/zzq900503/article/details/78543778

https://www.kettle.net.cn/

https://developer.aliyun.com/article/69991

# 元数据管理

Marquez

https://blog.csdn.net/LinkTime_Cloud/article/details/107165503

datahub

https://github.com/linkedin/datahub

https://datahubproject.io/docs/quickstart/

Amundsen

https://github.com/amundsen-io/amundsen

https://www.amundsen.io/amundsen/

https://www.cnblogs.com/rongfengliang/p/10975833.html

https://blog.csdn.net/zhouyan8603/article/details/107994102

# 数据治理平台

http://www.soolco.com/post/93469_1_1.html

https://codingnote.cc/zh-hk/p/256938/


https://juejin.cn/post/6888577283569745927
