# NLG概述

- 第一步：内容确定 – Content Determination
作为第一步，NLG 系统需要决定哪些信息应该包含在正在构建的文本中，哪些不应该包含。通常数据中包含的信息比最终传达的信息要多。

- 第二步：文本结构 – Text Structuring

确定需要传达哪些信息后，NLG 系统需要合理的组织文本的顺序。例如在报道一场篮球比赛时，会优先表达「什么时间」「什么地点」「哪2支球队」，然后再表达「比赛的概况」，最后表达「比赛的结局」。

- 第三步：句子聚合 – Sentence Aggregation

不是每一条信息都需要一个独立的句子来表达，将多个信息合并到一个句子里表达可能会更加流畅，也更易于阅读。

- 第四步：语法化 – Lexicalisation

当每一句的内容确定下来后，就可以将这些信息组织成自然语言了。这个步骤会在各种信息之间加一些连接词，看起来更像是一个完整的句子。

- 第五步：参考表达式生成 – Referring Expression Generation|REG

这个步骤跟语法化很相似，都是选择一些单词和短语来构成一个完整的句子。不过他跟语法化的本质区别在于“REG需要识别出内容的领域，然后使用该领域（而不是其他领域）的词汇”。

- 第六步：语言实现 – Linguistic Realisation

最后，当所有相关的单词和短语都已经确定时，需要将它们组合起来形成一个结构良好的完整句子。

1. Content determination: Deciding which information to include in the text
under construction,
2. Text structuring: Determining in which order information will be presented in the text,
3. Sentence aggregation: Deciding which information to present in individual
sentences,
4. Lexicalisation: Finding the right words and phrases to express information,
5. Referring expression generation: Selecting the words and phrases to identify domain objects,
6. Linguistic realisation: Combining all words and phrases into well-formed
sentences.

NLG的三种典型应用:
- 能够大规模的产生个性化内容
- 帮助人类洞察数据，让数据更容易理解
- 加速内容生产

https://devopedia.org/natural-language-generation

https://easyai.tech/ai-definition/nlg/

https://devopedia.org/natural-language-generation

现在GPT2是怎么处理NLG过程的

https://dickeysingh.com/2020/02/10/natural-language-generation-from-structured-data/

## NLP 生成文本的方式
自回归（auto-regressive）语言生成是基于这样一个假设，即整个序列的概率分布可以分解为下一个词条件分布的乘积，

其中  为初始上下文序列， 为你想要生成序列的长度（可调整）。

接下去我们将会详细介绍目前主流的解码方法，包括
- Greedy search
贪婪搜索简单地选择具有最高概率的单词作为它的下一个单词，在每一步考虑，
- Beam search
「Beam Search」 通过在每个时间步保留最可能的几个假设数，并最终选择总体概率最高的一组假设，从而降低了丢失隐藏的高概率单词序列的风险。

- Top-K sampling
来自FAIR的论文Hierarchical Neural Story Generation[7]介绍了一种简单但十分有效的采样策略，称为Top-K Sampling。在Top-K Sampling中，将挑选出K个最有可能的下一个单词，并且仅在这K个下一个单词之间重新为它们分配概率。GPT2就是采用了这种采样方案，这也是其生成故事效果不错的原因之一。

- Top-p sampling
在Top-p采样中，不是从仅最可能的K个单词中采样，而是从其累积概率超过一个阈值  的最小可能单词集中进行选择，然后将这组单词重新分配概率。

https://cloud.tencent.com/developer/article/1620772

https://github.com/ivanlai/Conditional_Text_Generation/blob/master/Keyword_extract.py

https://huggingface.co/blog/how-to-generate

GPT2 生成长文本

https://towardsdatascience.com/how-to-fine-tune-gpt-2-so-you-can-generate-long-form-creative-writing-7a5ae1314a61


使用GPT2怎么生成文本

https://code.oursky.com/ai-text-generator-text-generation-with-a-gpt2-model/

https://blog.paperspace.com/generating-text-summaries-gpt-2/

# 可视化理解GPT2生成

https://towardsdatascience.com/openai-gpt-2-understanding-language-generation-through-visualization-8252f683b2f8

# BERT结构解析

https://towardsdatascience.com/deconstructing-bert-part-2-visualizing-the-inner-workings-of-attention-60a16d86b5c1

https://tech.meituan.com/2019/11/14/nlp-bert-practice.html

https://github.com/jessevig/bertviz

BERT和GPT2对比

https://blog.csdn.net/weixin_48185819/article/details/106534995

# NLG知名博客

## 如何学习nlg

https://ehudreiter.com/2018/01/16/learn-about-nlg/

https://en.wikipedia.org/wiki/Natural-language_generation

SimpleNLG教程

https://github.com/simplenlg/simplenlg/wiki/Section-0-%E2%80%93-SimpleNLG-Tutorial

https://zhuanlan.zhihu.com/p/100290117

# GPT2


https://openai.com/blog/better-language-models/

https://github.com/openai/gpt-2/

https://github.com/mymusise/gpt2-quickly

BERT和GPT2区别

https://www.scribendi.ai/comparing-bert-and-gpt-2-as-language-models-to-score-the-grammatical-correctness-of-a-sentence/

## WYSIWYM 所见即所得文本交互技术 适用于论文八股

https://en.wikipedia.org/wiki/WYSIWYM_(interaction_technique)

http://mcs.open.ac.uk/nlg/old_projects/wysiwym/

http://mcs.open.ac.uk/nlg/SWAT/


# 预训练模型

https://lonepatient.top/2021/01/20/awesome-pretrained-chinese-nlp-models

https://www.msra.cn/zh-cn/news/features/ccai-2020-ming-zhou

https://github.com/bojone/chinese-gen

# 保存模型

https://pytorch.org/tutorials/beginner/saving_loading_models.html


https://www.cnblogs.com/massquantity/p/9511694.html

# 文本生成

https://github.com/hscspring/All4NLP

https://github.com/ChenChengKuan/awesome-text-generation

https://github.com/asyml/texar

https://www.casl-project.ai/

https://github.com/asyml/texar-pytorch

https://huggingface.co/blog/how-to-generate


# 文本模板生成

在 Visual Studio 中，T4 文本模板是文本块与可生成文本文件的控制逻辑的混合体。 控制逻辑被编写为 Visual C# 或 Visual Basic中的程序代码的片段。 使用 Visual Studio 2015 Update 2 及更高版本时，可在 T4 模板指令中使用 C# 6.0 版功能。 所生成的文件可以是任何类型的文本，例如网页、资源文件或任何语言的程序源代码。
T4 文本模板有两种类型：运行时和设计时。

https://docs.microsoft.com/zh-cn/visualstudio/modeling/design-time-code-generation-by-using-t4-text-templates?view=vs-2019


https://cloud.tencent.com/developer/article/1032874

https://docs.microsoft.com/en-us/visualstudio/modeling/code-generation-and-t4-text-templates?view=vs-2019

http://www.clariusconsulting.net/

https://www.monodevelop.com/



# 后台CMS joomlass

https://www.joomlass.com/joomla-tutorial/joomla-primary

https://www.eee-eee.com/joomla-downloads/joomla-extension-download.html
