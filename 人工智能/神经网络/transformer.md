# Transformer

如何使用向量来计算自注意力，然后来看它实怎样用矩阵来实现。

## 编码器

计算自注意力的:
第一步就是从每个编码器的输入向量（每个单词的词向量）中生成三个向量。也就是说对于每个单词，我们创造一个Q查询向量、一个K键向量和一个V值向量。

- 这三个向量是通过词嵌入与三个权重矩阵后相乘创建的。什么是查询向量、键向量和值向量向量？
    query对应的是需要 「被表达」 的序列(称为序列A)，key和value对应的是 「用来表达」A的序列(称为序列B)。

    自注意力的另一种解释就是在编码某个单词时，就是将所有单词的表示（值向量）进行加权求和，而权重是通过该词的表示（键向量）与被编码词表示（查询向量）的点积并通过softmax得到。

第二步是计算得分。假设我们在为这个例子中的第一个词“Thinking”计算自注意力向量，我们需要拿输入句子中的每个单词对“Thinking”打分。这些分数决定了在编码单词“Thinking”的过程中有多重视句子的其它部分。

打分的分数是通过打分单词的K键向量与Q查询向量点积来计算的.

原始 Transformer[1] 中使用 Positional Encoding 生成固定的位置表示序列的顺序：

到目前为止，我们对模型的描述缺少了一种理解输入单词顺序的方法。
为了解决这个问题，Transformer为每个输入的词嵌入添加了一个向量。这些向量遵循模型学习到的特定模式，这有助于确定每个单词的位置，或序列中不同单词之间的距离。
这里的直觉是，将位置向量添加到词嵌入中使得它们在接下来的运算中，能够更好地表达的词与词之间的距离。

残差模块：

在继续进行下去之前，我们需要提到一个编码器架构中的细节：在每个编码器中的每个子层（自注意力、前馈网络）的周围都有一个残差连接，并且都跟随着一个“层-归一化”步骤。

顶端编码器的输出之后会变转化为一个包含:

向量K（键向量）和V（值向量）的注意力向量集 。

attention可以有很多种计算方式:加性attention、点积attention，还有带参数的计算方式。着重介绍一下点积attention的公式:
sum(softmax((q * k) / sqrt Dk) * v) 中q和k的维度要保存一致, sqrt Dk这个缩放因子的作用是归一化.

## 解码器

Encoder部分中只存在self-attention，而Decoder部分中存在self-attention和cross-attention
【self-attention】encoder中的self-attention的query, key,value都对应了源端序列(即A和B是同一序列)，decoder中的self-attention的query, key, value都对应了目标端序列。

【cross-attention】decoder中的cross-attention的query对应了目标端序列，key,value对应了源端序列(每一层中的cross-attention用的都是encoder的最终输出)

参考:

https://mp.weixin.qq.com/s/6RPxTdDcxJ050oAp34Ofdw

https://mp.weixin.qq.com/s/BfWCRF54FJAocrgRIyeNkw

https://mp.weixin.qq.com/s/12WE_A2GQF-M2ajcVlXyEg


The Annotated Transformer的中文注释版
https://zhuanlan.zhihu.com/p/107889011