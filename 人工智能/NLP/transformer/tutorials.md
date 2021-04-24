# 教程

https://github.com/abhimishra91/pytorch-tutorials

git@github.com:abhimishra91/transformers-tutorials.git

https://hub.baai.ac.cn/

https://github.com/scutan90/DeepLearning-500-questions

https://github.com/microsoft/unilm


The notebook will be divided into seperate sections to provide a organized walk through for the process used. This process can be modified for individual use cases. The sections are:

机器学习的流程
- Importing Python Libraries and preparing the environment
- Importing and Pre-Processing the domain data
- Preparing the Dataset and Dataloader
- Creating the Neural Network for Fine Tuning
- Fine Tuning the Model
- Validating the Model Performance
- Saving the model and artifacts for Inference in Future

# Loss Function and Optimizer
- Loss Function and Optimizer and defined in the next cell.
- The Loss Function is used the calculate the difference in the output created by the model and the actual output.
- Optimizer is used to update the weights of the neural network to improve its performance.


# Further Reading
- You can refer to my [Pytorch Tutorials](https://github.com/abhimishra91/pytorch-tutorials) to get an intuition of Loss Function and Optimizer.
- [Pytorch Documentation for Loss Function](https://pytorch.org/docs/stable/nn.html#loss-functions)
- [Pytorch Documentation for Optimizer](https://pytorch.org/docs/stable/optim.html)
- Refer to the links provided on the top of the notebook to read more about DistiBERT. 

文本分类字段名称:
Index(['id', 'comment_text', 'toxic', 'severe_toxic', 'obscene', 'threat',
       'insult', 'identity_hate', 'list'],
      dtype='object')

	comment_text	list
159566	":::::And for the second time of asking, when ...	[0, 0, 0, 0, 0, 0]
159567	You should be ashamed of yourself \n\nThat is ...	[0, 0, 0, 0, 0, 0]
159568	Spitzer \n\nUmm, theres no actual article for ...	[0, 0, 0, 0, 0, 0]
159569	And it looks like it was actually you who put ...	[0, 0, 0, 0, 0, 0]
159570	"\nAnd ... I really don't think you understand...	[0, 0, 0, 0, 0, 0]


為了讓你直觀了解 BERT 運作，本文使用包含繁體與簡體中文的預訓練模型。 你可以在 Hugging Face 團隊的 repo 裡看到所有可從 PyTorch Hub 載入的 BERT 預訓練模型。截至目前為止有以下模型可供使用：

- bert-base-chinese
- bert-base-uncased
- bert-base-cased
- bert-base-german-cased
- bert-base-multilingual-uncased
- bert-base-multilingual-cased
- bert-large-cased
- bert-large-uncased
- bert-large-uncased-whole-word-masking
- bert-large-cased-whole-word-masking



## 停用词表 stopwords

BERT 裡頭有 5 個特殊 tokens 各司其職：

- [CLS]：在做分類任務時其最後一層的 repr. 會被視為整個輸入序列的 repr.
- [SEP]：有兩個句子的文本會被串接成一個輸入序列，並在兩句之間插入這個 token 以做區隔
- [UNK]：沒出現在 BERT 字典裡頭的字會被這個 token 取代
- [PAD]：zero padding 遮罩，將長度不一的輸入序列補齊方便做 batch 運算
- [MASK]：未知遮罩，僅在預訓練階段會用到

https://github.com/goto456/stopwords


# 分词

Among all the tokenization algorithms, we can highlight a few subtokens algorithms used in Transformers-based SoTA models : 

- [Byte Pair Encoding (BPE) - Neural Machine Translation of Rare Words with Subword Units (Sennrich et al., 2015)](https://arxiv.org/abs/1508.07909)
- [Word Piece - Japanese and Korean voice search (Schuster, M., and Nakajima, K., 2015)](https://research.google/pubs/pub37842/)
- [Unigram Language Model - Subword Regularization: Improving Neural Network Translation Models with Multiple Subword Candidates (Kudo, T., 2018)](https://arxiv.org/abs/1804.10959)
- [Sentence Piece - A simple and language independent subword tokenizer and detokenizer for Neural Text Processing (Taku Kudo and John Richardson, 2018)](https://arxiv.org/abs/1808.06226)

For each of the components above we provide multiple implementations:

- **Normalizer**: Lowercase, Unicode (NFD, NFKD, NFC, NFKC), Bert, Strip, ...
- **PreTokenizer**: ByteLevel, WhitespaceSplit, CharDelimiterSplit, Metaspace, ...
- **Model**: WordLevel, BPE, WordPiece
- **Post-Processor**: BertProcessor, ...
- **Decoder**: WordLevel, BPE, WordPiece, ...

# BERT fintune

https://zhuanlan.zhihu.com/p/62642374

https://leemeng.tw/attack_on_bert_transfer_learning_in_nlp.html

# practice 

```python
# 分词
token_ids = tokens['input_ids'][i]
token_str = [tokenizer.convert_ids_to_tokens(s) for s in tokens['input_ids'][i]]

input_tf = tokenizer("This is a sample input", return_tensors="tf")
"""
If set, will return tensors instead of list of python integers. Acceptable values are:

'tf': Return TensorFlow tf.constant objects.

'pt': Return PyTorch torch.Tensor objects.

'np': Return Numpy np.ndarray objects.
"""

```

# piplines

**pipelines** provides a high-level, easy to use,
API for doing inference over a variety of downstream-tasks, including: 

- ***Sentence Classification _(Sentiment Analysis)_***: Indicate if the overall sentence is either positive or negative, i.e. *binary classification task* or *logitic regression task*.
- ***Token Classification (Named Entity Recognition, Part-of-Speech tagging)***: For each sub-entities _(*tokens*)_ in the input, assign them a label, i.e. classification task.
- ***Question-Answering***: Provided a tuple (`question`, `context`) the model should find the span of text in `content` answering the `question`.
- ***Mask-Filling***: Suggests possible word(s) to fill the masked input with respect to the provided `context`.
- ***Summarization***: Summarizes the ``input`` article to a shorter article.
- ***Translation***: Translates the input from a language to another language.
- ***Feature Extraction***: Maps the input to a higher, multi-dimensional space learned from the data.

Pipelines encapsulate the overall process of every NLP process:
 
 1. *Tokenization*: Split the initial input into multiple sub-entities with ... properties (i.e. tokens).
 2. *Inference*: Maps every tokens into a more meaningful representation. 
 3. *Decoding*: Use the above representation to generate and/or extract the final output for the underlying task.

# ONNX

[ONNX](http://onnx.ai/) is open format for machine learning models. It allows to save your neural network's computation graph in a framework agnostic way, which might be particulary helpful when deploying deep learning models.

导出成ONNX格式
```python
from pathlib import Path
from transformers.convert_graph_to_onnx import convert

# Handles all the above steps for you
convert(framework="pt", model="bert-base-cased", output=Path("onnx/bert-base-cased.onnx"), opset=11)
```

Exporting models (either PyTorch or TensorFlow) is easily achieved through the conversion tool provided as part of 🤗 transformers repository.

Under the hood the process is sensibly the following:

- Allocate the model from transformers (PyTorch or TensorFlow)
- Forward dummy inputs through the model this way ONNX can record the set of operations executed
- Optionally define dynamic axes on input and output tensors
- Save the graph along with the network parameters
