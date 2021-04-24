# NLP

## 基本概念
词集模型：单词构成的集合，集合自然每个元素都只有一个，也即词集中的每个单词都只有一个。

词袋模型：在词集的基础上如果一个单词在文档中出现不止一次，统计其出现的次数（频数）。

词袋模型可以很好的表现文本由哪些单词组成，但是却无法表达出单词之间的前后关系，于是人们借鉴了词袋模型的思想，使用生成的词汇表对原有句子按照单词逐个进行编码。TensorFlow默认支持了这种模型：VocabularyProcessor.

Word2Vec模型

Word2Vec是Google在2013年开源的一款将词表征为实数值向量的高效工具，采用的模型有CBOW(Continuous Bag-Of-Words，即连续的词袋模型)和Skip-Gram 两种。Word2Vec通过训练，可以把对文本内容的处理简化为K维向量空间中的向量运算，而向量空间上的相似度可以用来表示文本语义上的相似度。因此，Word2Vec 输出的词向量可以被用来做很多NLP相关的工作，比如聚类、找同义词、词性分析等等。
CBOW模型能够根据输入周围n-1个词来预测出这个词本身，而Skip-gram模型能够根据词本身来预测周围有哪些词。也就是说，CBOW模型的输入是某个词A周围的n个单词的词向量之和，输出是词A本身的词向量，而Skip-gram模型的输入是词A本身，输出是词A周围的n个单词的词向量。 Word2Vec最常用的开源实现之一就是gensim

Word2Vec Tutorial

https://rare-technologies.com/word2vec-tutorial/

sogou实验室数据
http://www.sogou.com/labs/resource/cs.php


fasttext原理

fasttext提供了一种有效且快速的方式生成词向量以及进行文档分类。 fasttext模型输入一个词的序列，输出这个词序列属于不同类别的概率。fasttext模型架构和Word2Vec中的CBOW模型很类似。不同之处在于，fasttext预测标签，而CBOW模型预测中间词。

在词袋模型中，把单词当做独立的个体，没有考虑词前后的关系。比如"我打你"和“你打我“，使用词袋模型的话，这两句话是完全一样的。 词袋的特征向量均为[1, 1, 1]
n-gram是对词袋模型的一种改善，它会关注一个单词的前后关系，比如n-gram中最常见的2-gram，就关注单词的前一个词，比如"我打你",就可以拆分为"我打"和"打你"。这两句话一起建模的话，2-gram对应的特征为:
["我打"，"打你"，"你打"，"打我"]
"我打你"对应的特征向量为：
[1,1,0,0]

LDA
LDA（Latent Dirichlet Allocation）是一种文档主题模型，包含词、主题和文档三层结构.

TextRank
TextRank的思路来自于PageRank。PageRank最开始用来计算网页的重要性。整个互联网可以看作一张有向图，节点是网页。如果网页A存在到网页B的链接，那么有一条从网页A指向网页B的有向边，指向同一个网页的链接越多，该网页的重要性或者说PageRank值更大。
TextRank的原理和PageRank类似，一篇文档去掉停用词以后，每个单词相当于一个网页，有时候也会指定某些词性的单词才参与计算TextRank，比如名词和动词。网页有明显的指向关系，但是文档的单词之间只有前后关系，所以要指定一个滑动的窗口大小，比如前后5个单词。

# 处理中文的文档分类步骤

1. 数据源选取
2. 数据清洗
数据格式转换, 提取数据标签, 数据过滤选取.
3. 删除停用词 stopwords
4. 文档分类

    合并数据文件和标签文件, 替fasttext为文章打上`__label__`标签.

    加载数据清洗后的数据和标签, 随机划分成训练数据和测试数据，其中测试数据占20%。

    按照fasttext的格式要求保存成训练数据和测试数据.
5. 训练模型
6. 验证效果
    计算准确率和召回率

# BERT

BERT 代表来自 Transformer 的双向编码器表示（Bidirectional Encoder Representations from Transformers）。

https://github.com/yuanxiaosc/BERT_Paper_Chinese_Translation

https://github.com/Socialbird-AILab/BERT-Classification-Tutorial

https://github.com/huggingface/transformers


https://github.com/duoergun0729/nlp

https://radimrehurek.com/gensim/

https://github.com/duoergun0729/nlp/blob/master/%E9%A2%84%E6%B5%8BYelp%E7%BE%8E%E9%A3%9F%E8%AF%84%E5%88%86.md


# 中文词向量

https://www.52nlp.cn/tag/%E8%85%BE%E8%AE%AF%E4%B8%AD%E6%96%87%E8%AF%8D%E5%90%91%E9%87%8F

https://mlln.cn/2018/06/28/%E6%9C%80%E5%85%A8%E4%B8%AD%E6%96%87%E8%AF%8D%E5%90%91%E9%87%8F%E6%95%B0%E6%8D%AE%E4%B8%8B%E8%BD%BD-%E9%83%BD%E6%98%AF%E8%AE%AD%E7%BB%83%E5%A5%BD%E7%9A%84%E4%BC%98%E8%B4%A8%E5%90%91%E9%87%8F/

文本向量化的表示方法

https://zhuanlan.zhihu.com/p/42310942

https://www.cnblogs.com/dogecheng/p/11470196.html

## word2vec 中文分词

http://www.biegral.com/Index/View/a271557d-a105-45c7-b2a5-a4ecf13aab4e

https://segmentfault.com/a/1190000010129248

https://www.kesci.com/home/project/5be7e948954d6e0010632ef2

https://zhuanlan.zhihu.com/p/26306795

https://butlerwilson.com/super-short-chinese-text-similarity

https://wiki.shileizcc.com/confluence/pages/viewpage.action?pageId=42533348


文本相似度计算方法

https://cloud.tencent.com/developer/article/1077131

http://www.scikitlearn.com.cn/


## 停用词表 stopwords

https://github.com/goto456/stopwords


## jieba

词性分析

jieba.analyse.extract_tags(sentence, topK=20, withWeight=False, allowPOS=())
sentence 为待提取的文本
topK 为返回几个 TF/IDF 权重最大的关键词，默认值为 20
withWeight 为是否一并返回关键词权重值，默认值为 False
allowPOS 仅包括指定词性的词，默认值为空，即不筛选
jieba.analyse.TFIDF(idf_path=None) 新建 TFIDF 实例，idf_path 为 IDF 频率文件

https://www.cnblogs.com/Eliphaz/p/13360741.html

复合形容词

https://blog.csdn.net/ai327353506/article/details/102296204


# hanlp

https://hanlp.hankcs.com/docs/tutorial.html#visualization

https://www.hanlp.com/


https://zhuanlan.zhihu.com/p/57731823

ES + hanlp分词器

https://www.cnblogs.com/ibook360/p/8491977.html


11、search-guard 第三方工具

Search Guard 是 Elasticsearch 的安全插件。它为后端系统（如LDAP或Kerberos）提供身份验证和授权，并向Elasticsearch添加审核日志记录和文档/字段级安全性。

Search Guard所有基本安全功能（非全部）都是免费的，并且内置在Search Guard中。 Search Guard支持OpenSSL并与Kibana和logstash配合使用。

地址：https://www.oschina.net/p/searchguard

https://gitee.com/mirrors/SearchGuard