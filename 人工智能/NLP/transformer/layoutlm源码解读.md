
https://www.msra.cn/zh-cn/news/features/layoutlm-v2

https://huggingface.co/transformers/v3.2.0/model_doc/layoutlm.html

# 信息抽取三个最重要/最受关注的子任务：

实体抽取
也就是命名实体识别，包括实体的检测（find）和分类（classify）
关系抽取
通常我们说的三元组（triple） 抽取，一个谓词（predicate）带 2 个形参（argument），如 Founding-location(IBM,New York)
事件抽取
相当于一种多元关系的抽取

https://lonepatient.top/2018/09/16/knowledge-extraction-entity-and-relationshaip


LayoutLMForSequenceClassification 
LayoutLM模型，其顶部具有序列分类头（在合并的输出顶部位于线性层），例如用于文档图像分类任务，例如RVL-CDIP数据集。

LayoutLMForMaskedLM
带有语言建模头的LayoutLM模型。徐益恒，李明浩，崔磊，黄少涵，魏如和周明在LayoutLM中提出了LayoutLM模型：用于文档图像理解的文本和布局的预训练。

LayoutLMForTokenClassification
LayoutLM模型，其令牌标记头位于顶部（隐藏状态输出顶部的线性层），例如用于序列标记（信息提取）任务，例如FUNSD 数据集和SROIE数据集。



# 实体识别

实体识别用于关系抽取

https://nanonets.com/blog/named-entity-recognition-ner-information-extraction/

飞桨做实体识别

https://www.jiqizhixin.com/articles/2019-09-23-12

https://tech.meituan.com/2020/07/23/ner-in-meituan-nlp.html

# CDIP数据集

RVL-CDIP（瑞尔森视觉实验室复杂文档信息处理）数据集由16类40万张灰度图像组成，每类25,000张图像。有320,000个训练图像，40,000个验证图像和40,000个测试图像。图像的大小应使其最大尺寸不超过1000像素。
其中类别按以下顺序编号为0到15：
- 信
- 形式
- 电子邮件
- 手写的
- 广告
- 科学报告
- 科学出版物
- 规格
- 文件夹
- 新闻文章
- 预算
- 发票
- 介绍
- 问卷调查
- 恢复
备忘录

http://www.cs.cmu.edu/~aharley/rvl-cdip/

https://medium.com/analytics-vidhya/rvl-cdip-ryerson-vision-lab-complex-document-information-processing-aa30b00a2b1e


# data/rvl-cdip

从rvl_cdip数据集中解析hocr文件, 得到examples, labels和features 转换为TensorDataset。


https://github.com/microsoft/unilm/blob/86414ea699c282a5d9ff133271b98bb59497a468/layoutlm/layoutlm/data/rvl_cdip.py


根据提取的信息类别， 目前信息抽取的核心 研究内容可以划分为命名实体识别(Named Entity
Recognition, NER)、关系抽取(Relation Extraction)、事件抽取和信息集成（Information Integration）

# Sequence_labeling 序列标注

https://en.wikipedia.org/wiki/Sequence_labeling

序列标注（Sequence Tagging）是NLP中最基础的任务，应用十分广泛，如分词、词性标注（POS tagging）、命名实体识别（Named Entity Recognition，NER）、关键词抽取、语义角色标注（Semantic Role Labeling）、槽位抽取（Slot Filling）等实质上都属于序列标注的范畴。

https://cloud.tencent.com/developer/article/1598228

https://github.com/sgrvinod/a-PyTorch-Tutorial-to-Sequence-Labeling

深度学习用于序列标注中的论文及代码集锦

https://www.huaweicloud.com/articles/95e02b3faec8e62f40d993bf58f2b66b.html


## 序列标注方法BIO、BIOSE、IOB、BILOU、BMEWO、BMEWO+的异同

BIOES
- B stands for 'beginning' (signifies beginning of an NE)
- I stands for 'inside' (signifies that the word is inside an NE)
- O stands for 'outside' (signifies that the word is just a regular word outside of an NE)
- E stands for 'end' (signifies that the word is the end of an NE)
- S stands for 'singleton'(signifies that the single word is an NE )

https://zhuanlan.zhihu.com/p/147537898

预训练的LayoutLM模型在三个文档图像理解任务上进行了微调，包括表单理解任务，收据理解任务以及文档图像分类任务。对于了解表单和收据的任务，LayoutLM会为每个令牌预测{B，I，E，S，O}标签，并使用顺序标签来检测数据集中的每种实体。对于文档图像分类任务，LayoutLM使用CLS令牌的表示形式预测类标签。

## CLS 

CLS：special classification embedding，用于分类的向量，会聚集所有的分类信息。

https://plmsmile.github.io/2018/12/15/52-bert/

# DocBank的文档语义结构

The DocBank dataset consists of 500K document pages with 12 types of semantic units.

Abstract	Author	Caption	Date	Equation	Figure	Footer	List	Paragraph	Reference	Section	Table	Title	Total


语义结构

http://linguistics-ontology.org/gold/2010/SemanticUnit



# 成熟的文档产品

泰岳语义工厂_文档结构化_PDF表格提取/解析/抽取/分析

https://market.aliyun.com/products/57124001/cmapi033220.html#sku=yuncode2722000001

https://github.com/liuhuanyong/TextGrapher


# 语义单位 Minimal Semantic Units in Text Analysis

BSU（basic semantic unit):
1、语义信息可以被获得通过基本语义信息单元和构建基本语义信息连接网络。
语义信息连接网络和详细信息见论文《Abstractive Multi-document Summarization with Semantic Infor- mation Extraction》。
2、BSU是由一个三元组组成：actor-action-receiver
它能检测重要内容，并且包含足够的语义信息去帮助句子生成。
一些action可能没有receiver参数。
例如：
“Flight MH370 - disappear” , “Flight MH370 - leave - Kuala Lumpur”是两个BSU。前者没有接收参数，而后者有接收参数。

The eligible action indicator is restricted to be a predicate verb; the eligible actor and re- ceiver arguments are noun phrase.

合格的action被限制为一个谓语动词;符合条件的actor和receiver是名词短语。


https://www.youtube.com/watch?v=iO8Jeqf55_U


https://blog.csdn.net/qq_32458499/article/details/80986819

# 语义搜索

https://stackoverflow.com/questions/60186935/how-to-build-semantic-search-for-a-given-domain

https://www.youtube.com/watch?v=4fMZnunTRF8


https://github.com/topics/semantic-search

https://github.com/agrawal-rohit/stackoverflow-semantic-search

# 预训练
## 预训练模型 Pre-trained Models for NLP

目前神经网络在进行训练的时候基本都是基于后向传播（Back Propagation，BP）算法，通过对网络模型参数进行随机初始化，然后利用优化算法优化模型参数。但是在标注数据很少的情况下，通过神经网络训练出的模型往往精度有限，“预训练”则能够很好地解决这个问题，并且对一词多义进行建模。

预训练是通过大量无标注的语言文本进行语言模型的训练，得到一套模型参数，利用这套参数对模型进行初始化，再根据具体任务在现有语言模型的基础上进行精调。预训练的方法在自然语言处理的分类和标记任务中，都被证明拥有更好的效果。

https://easyai.tech/ai-definition/pre-train/

https://leovan.me/cn/2020/03/pre-trained-model-for-nlp/

http://xtf615.com/2020/11/28/Pretrain-Models/