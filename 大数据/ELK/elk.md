# ELK

使用Docker快速安装部署ES和Kibana并配置IK中文分词器以及自定义分词拓展词库

https://blog.csdn.net/ju_362204801/article/details/109346187


https://github.com/maxyermayank/docker-compose-elasticsearch-kibana


## docker elk

https://github.com/deviantony/docker-elk

## elastic search 学习材料

https://www.elastic.co/guide/index.html

https://www.elastic.co/guide/cn/elasticsearch/guide/current/getting-started.html

es的docker版本处理

https://www.docker.elastic.co/r/elasticsearch/elasticsearch-oss

https://jasonkayzk.github.io/2019/10/04/%E5%9C%A8%E5%8D%95%E5%8F%B0%E6%9C%8D%E5%8A%A1%E5%99%A8%E9%83%A8%E7%BD%B2%E5%A4%9A%E4%B8%AAElasticSearch%E8%8A%82%E7%82%B9/

## kinbana配置

docker-compose -f docker-compose.yml up  -d

https://www.elastic.co/guide/cn/kibana/current/settings.html


设置最小内存

grep vm.max_map_count /etc/sysctl.conf
vm.max_map_count=262144

sysctl -w vm.max_map_count=280000

https://www.elastic.co/guide/en/elasticsearch/reference/current/docker.html#docker-cli-run-prod-mode

https://www.elastic.co/guide/en/elasticsearch/reference/master/docker.html


## 配置ES和Kibana的用户密码

https://blog.csdn.net/wsdc0521/article/details/106344974

https://www.cnblogs.com/snail90/p/11444393.html

https://blog.csdn.net/wsdc0521/article/details/106344974

开启x-pack功能

https://codingfundas.com/setting-up-elasticsearch-and-kibana-on-docker-with-x-pack-security-enabled/

docker x-pack config

https://umasrinivask.medium.com/dockerize-elasticsearch-kibana-with-x-packs-security-237589acb3fd

## ES可视化工具

https://zhuanlan.zhihu.com/p/105355487

https://www.yp14.cn/2020/02/06/Elasticsearch-%E5%8F%AF%E8%A7%86%E5%8C%96%E7%AE%A1%E7%90%86%E5%B7%A5%E5%85%B7/


## ES的IK分词插件

https://help.aliyun.com/document_detail/137928.html?spm=a2c4g.11186623.6.629.2393301dMQnO8j

aliyun 安装自定义插件

https://help.aliyun.com/document_detail/123559.html?spm=a2c4g.11186623.6.627.445c5437mHyHIH

ES插件

https://docs.aws.amazon.com/zh_cn/elasticsearch-service/latest/developerguide/aes-supported-plugins.html


# awsome es

https://github.com/dzharii/awesome-elasticsearch

https://github.com/ginobefun/awesome-elasticsearch-cn

https://elasticsearch.cn/

http://jolestar.com/elasticsearch-architecture/

# ES

https://elasticsearch.cn/article/6178

https://mp.weixin.qq.com/s/ySfjjd0R4H17IuqU_OmtmQ

文档信息提取到ES

我做了很多搜索，这是到目前为止我找到的方法的列表。

这是整体集成/插件页面:
https://www.elastic.co/guide/en/elasticsearch/plugins/master/integrations.html

这是Mapper附件的新替代品Injest插件:
https://www.elastic.co/guide/en/elasticsearch/plugins/current/ingest-attachment.html
有关如何使用它的发布:https://qbox.io/blog/index-attachments-files-elasticsearch-mapper
这是关于使用Injest与fs-crawler(dadoonet是Elastic开发人员)的优缺点的讨论:
https://discuss.elastic.co/t/mapper-attachment-plugin-vs-pre-parsing-and-extracting-content-from-binary-files/73764/10

这是文件系统搜寻器(FS搜寻器)插件:
https://github.com/dadoonet/fscrawler


这是Ambar文档搜索系统-他们有一个带有开源代码的github社区:
https://ambar.cloud/
https://github.com/RD17/ambar
https://blog.ambar.cloud/ingesting-documents-pdf-word-txt-etc-into-elasticsearch/
他们似乎使用两种数据库服务器类型(MongoDB和Redis)，不确定为什么。

这是Injest和Ambar都使用的Apache Tika(并且还通过Tesseract的使用提供了OCR，我听说Injest不支持)。
http://tika.apache.org/1.16/

同样，在Injest对Tika的使用中，仅支持文件类型的子集:
https://discuss.elastic.co/t/full-list-of-supported-document-formats-by-es/81149

我希望以上内容可以节省其他开发人员的时间，如果人们发现更多内容，他们将在下面进行评论。


https://www.coder.work/article/743339

Apache Tika
比较有名的内容提取工具
FsCrawler
使用java 开发，内部使用了Tika
Ambar
nodejs，python应用开发，轻量，支持基于docker 的快速部署，同时支持各种文档类型，ocr。。

https://www.cnblogs.com/rongfengliang/p/10796940.html

# ES 本地文档搜索系统



https://www.guitang.fun/coding/coding-a-local-search-engine/

https://www.twblogs.net/a/5d032ed5bd9eee47d34ba00f/?lang=zh-cn

https://yemilice.com/2020/07/29/elasticsearch%E6%A3%80%E7%B4%A2pdf%E5%92%8Coffice%E6%96%87%E6%A1%A3%E7%9A%84%E6%96%B9%E6%A1%88%E6%B5%8B%E8%AF%84/

https://xingzuoshe.cn/fscrawler-for-elasticsearch.html

fscrawler

https://github.com/dadoonet/fscrawler

https://www.guitang.fun/coding/coding-a-local-search-engine/

经过我的发力工作（Google/baidu）,现在市面上流行这么几种方案
- Elasticsearch 官方插件 ingest-attachment
- 第三方开源服务 fscrawler
- 大数据平台 Ambari

https://yemilice.com/2020/07/29/elasticsearch%E6%A3%80%E7%B4%A2pdf%E5%92%8Coffice%E6%96%87%E6%A1%A3%E7%9A%84%E6%96%B9%E6%A1%88%E6%B5%8B%E8%AF%84/

# ingest attachment

https://blog.csdn.net/m0_37739193/article/details/86421246


https://blog.csdn.net/xiaojuge/article/details/90634042

https://blog.csdn.net/m0_37739193/article/details/86421246

https://github.com/gui66497/booksearch

https://fscrawler.readthedocs.io/en/latest/installation.html

https://github.com/typesense/typesense

# slor

https://www.wpsolr.com/zh-CN/

https://www.cnblogs.com/jajian/p/9801154.html

## es 加 ingest-attachment 插件

https://www.linode.com/docs/guides/a-guide-to-elasticsearch-plugins/

https://github.com/elastic/elasticsearch/blob/master/docs/plugins/ingest-attachment.asciidoc


# CBOR格式

https://www.jianshu.com/p/76adec5e61f8


https://www.elastic.co/guide/en/elasticsearch/plugins/current/ingest-attachment.html


https://www.elastic.co/guide/en/elasticsearch/plugins/current/analysis-phonetic.html


## 创建pipline

https://www.elastic.co/guide/en/elasticsearch/reference/master/ingest.html

https://www.elastic.co/guide/en/elasticsearch/plugins/current/ingest-attachment-cbor.html

## es hq

https://blog.csdn.net/UbuntuTouch/article/details/104186692


## es插件 IK分词器

https://github.com/medcl/elasticsearch-analysis-ik/releases

https://juejin.cn/post/6844904117668708360


https://blog.csdn.net/supermao1013/article/details/84075282

## es lda 主题分词

https://github.com/bscottm/elastic-lda/blob/master/doc/design/SDD.md

https://pkghosh.wordpress.com/2018/07/18/improving-elastic-search-query-result-with-query-expansion-using-topic-modeling/

## es DSL

https://elasticsearch-dsl.readthedocs.io/en/latest/



# 案例

https://www.infoq.cn/article/uybdhohjdkj8tezdqhlx


# es插入

一日一技：Elasticsearch批量插入时，存在就不插入
https://bbs.huaweicloud.com/blogs/219444

https://www.kingname.info/2019/09/25/es-not-insert-if-exists/


## Kibana使用教程

https://my.oschina.net/abensky/blog/4287495


## django-haystack
https://github.com/django-haystack/django-haystack


## ES加权标签

https://conan.is/blogging/weighted-elasticsearch.html

https://www.cnblogs.com/jajian/p/10465519.html

基于标签的推荐

http://yingxiaosheji.com/a/1/2017/0628/79.html

基于内容的推荐

首先澄清一个误解，基于内容的推荐包含有标签的推荐，但并不等于标签的推荐，标签只是基于内容推荐的一小部分。

标签、关键词、实体、分类、主题、词嵌入向量等，都是内容推荐中的一些手段。

标签的分类方法通常比指标要少一些

之所以这么说，是因为指标能描述的对象范围更广，对事物的描述能做维度更全面、颗粒度更细，而标签对事物（用于对人的描述比较多）的描述则是更深入、更形象的。

按照标签的变化性分为静态标签和动态标签；
按照标签的指代和评估指标的不同，可分为定性标签和定量标签；
按照标签体系分级分层的方式，可以分为一级标签、二级标签、三级标签等，每一个层级的标签相当于一个业务维度的切面；
按照复杂程度分为：
基础标签、规则标签和模型标签——基础标签通常是写实的，与指标有较高的重合度，比如身高、体重等；
规则标签一般是有一些简单的规则来控制，符合某种规则时才生成相应的标签；模型标签一般需要通过某些机器学习算法来生成。

标签的应用场景主要集中于CRM领域，尤其适合于用户运营。比如：客户画像、新增获客、沉默用户激活、存量客户维系、数据建模、数据可视化等。

指标最擅长的应用是监测、分析、评价和建模，标签最擅长的应用是标注、刻画、分类和特征提取。

特别需要指出的是，由于对结果的标注也是一种标签，所以在自然语言处理和机器学习相关的算法应用场景下，标签对于监督式学习有重要价值，只是单纯的指标难以做到的；而指标在任务分配、绩效管理等领域的作用，也是标签无法做到的。

http://www.woshipm.com/pd/4202594.html

http://www.woshipm.com/data-analysis/4337716.html


## ES的mapping设置

index_options	
索引选项控制添加到倒排索引（Inverted Index）的信息，这些信息用于搜索（Search）和高亮显示：

docs：只索引文档编号(Doc Number)；
freqs：索引文档编号和词频率（term frequency）；
positions：索引文档编号，词频率和词位置（序号）；
offsets：索引文档编号，词频率，词偏移量（开始和结束位置）和词位置（序号）。
默认情况下，被分析的字符串（analyzed string）字段使用 positions，其他字段默认使用 docs。

此外，需要注意的是 index_option 是 elasticsearch 特有的设置属性；临近搜索和短语查询时，index_option 必须设置为 offsets，同时高亮也可使用 postings highlighter。


similarity	
指定文档相似度算法（也可以叫评分模型）：

BM25：es 5 之后的默认设置。


# 高亮

高亮性能分析
Elasticsearch 提供了三种高亮器，分别是默认的 highlighter 高亮器、postings-highlighter 高亮器和 fast-vector-highlighter 高亮器。

默认的 highlighter 是最基本的高亮器。highlighter 高亮器实现高亮功能需要对 _source 中保存的原始文档进行二次分析，其速度在三种高亮器里最慢，优点是不需要额外的存储空间。postings-highlighter 高亮器实现高亮功能不需要二次分析，但是需要在字段的映射中设置 index_options 参数的取值为 offsets，即保存关键词的偏移量，速度快于默认的 highlighter 高亮器。例如，配置 comment 字段使用 postings-highlighter 高亮器，映射如下：


# 聚合

Elasticsearch 是一个分布式的全文搜索引擎，索引和搜索是 Elasticsearch 的基本功能。事实上，Elasticsearch 的聚合（Aggregations）功能也十分强大，允许在数据上做复杂的分析统计。Elasticsearch 提供的聚合分析功能主要有指标聚合（metrics aggregations）、桶聚合（bucket aggregations）、管道聚合（pipeline aggregations）和矩阵聚合（matrix aggregations）四大类，管道聚合和矩阵聚合官方说明是在试验阶段，后期会完全更改或者移除，这里不再对管道聚合和矩阵聚合进行讲解。

https://github.com/dzharii/awesome-elasticsearch

## ES脚本

https://www.knowledgedict.com/tutorial/elasticsearch-script.html


## Elasticsearch Analyzer（分析器）组成、配置、执行顺序等详解
Elasticsearch 不管是索引任务还是搜索工作，都需要经过 es 的 analyzer（分析器），至于分析器，它分为内置分析器和自定义的分析器。分析器进一步由字符过滤器（Character Filters）、分词器（Tokenizer）和词元过滤器（Token Filters）三部分组成。

# ES性能优化

https://www.knowledgedict.com/tutorial/elasticsearch-opt.html


# painless脚本

https://www.elastic.co/guide/en/elasticsearch/painless/current/painless-debugging.html


https://www.elastic.co/guide/en/elasticsearch/reference/current/modules-scripting-using.html

## 脚本使用建议

https://cloud.tencent.com/developer/article/1507715

kibana脚本fields中使用无痛脚本

https://www.elastic.co/cn/blog/using-painless-kibana-scripted-fields

# 防止映射爆炸

https://www.elastic.co/guide/en/elasticsearch/reference/current/mapping-settings-limit.html


# tags的更新逻辑

通过script和upsert更新文档

http://xiaorui.cc/archives/2368

https://segmentfault.com/a/1190000038298121


https://note.yuchaoshui.com/blog/post/yuziyue/Elasticsearch-update-API


标签体系

https://blog.csdn.net/weixin_38087443/article/details/108071729

https://blog.csdn.net/weixin_44318830/article/details/114006105

https://blog.csdn.net/weixin_44318830/article/details/114006105


内容标签表
用户标签表
标签表
维护标签bitmap

https://zhuanlan.zhihu.com/p/341371753

