# Transformer的解释

http://jalammar.github.io/illustrated-transformer/

https://terrifyzhao.github.io/2019/01/11/Transformer%E6%A8%A1%E5%9E%8B%E8%AF%A6%E8%A7%A3.html

https://www.tensorflow.org/tutorials/text/transformer?hl=zh-cn

# BERT

https://blog.csdn.net/jiaowoshouzi/article/details/89073944

BERT的transformer网络结构学习到什么

Bert的Transformer低层学了表层特征，中间层学了句法特征，高层学了语义特征

https://easyai.tech/blog/what-does-bert-and-transformer-learn/

https://easyai.tech/ai-definition/


# Transformer模型深度解读起源发展

https://mp.weixin.qq.com/s/VHTiELTGTPXf3TURS6eXyw

query对应的是需要 「被表达」 的序列(称为序列A)，key和value对应的是 「用来表达」A的序列(称为序列B)。其中key和query是在同一高维空间中的(否则无法用来计算相似程度)，value不必在同一高维空间中，最终生成的output和value在同一高维空间中。上面这段巨绕的话用一句更绕的话来描述一下就是:

>❝
序列A和序列B在高维空间    中的高维表达  的每个位置 _「分别」 _ 和    计算相似度，产生的权重作用于序列B在高维空间  中的高维表达    ，获得序列A在高维空间  中的高维表达  ❞


Encoder部分中只存在self-attention，而Decoder部分中存在self-attention和cross-attention

【self-attention】encoder中的self-attention的query, key, value都对应了源端序列(即A和B是同一序列)，decoder中的self-attention的query, key, value都对应了目标端序列。

【cross-attention】decoder中的cross-attention的query对应了目标端序列，key, value对应了源端序列(每一层中的cross-attention用的都是encoder的最终输出)

- query(M*dqk)    和Key(N*dqk)      的维度必须一致，Value    和Query/Key的维度可以不一致。
- Key (N*dqk)   和Value(N*dv)    的长度必须一致.Key和Value本质上对应了同一个Sequence在不同空间的表达。


为什么要做multi-head attention？

也就是说，这样可以在不改变参数量的情况下增强每一层attention的表现力。 Multi-head Attention的本质是，在 「参数总量保持不变」 的情况下，将同样的query, key, value映射到原来的高维空间的「不同子空间」中进行attention的计算，在最后一步再合并不同子空间中的attention信息。这样降低了计算每个head的attention时每个向量的维度，在某种意义上防止了过拟合；

## <b>Transformer 资料汇总, 从概要到应用 </b>

https://mp.weixin.qq.com/s/_IZWOEtrcVcgLv1e2mkL6w

整体介绍

https://theaisummer.com/transformer/

自己实现einsum的多头注意的transforms

https://theaisummer.com/einsum-attention/

### einops

https://github.com/arogozhnikov/einops

### ACT adaptive-computation-time

https://distill.pub/2016/augmented-rnns/#adaptive-computation-time

# 安装

1. 先安装pytorch
2. 安装transformers

查看CUDA版本号
```sh
turing@ub:/opt$ cat  /usr/local/cuda/version.txt
CUDA Version 10.2.89
nvcc --version

# 参见
# https://pytorch.org/get-started/locally/#start-locally
# https://mirrors.tuna.tsinghua.edu.cn/help/pypi/
pip3  install torch torchvision torchaudio -i  https://pypi.douban.com/simple/

pip3 install transformers ipython -i  https://pypi.douban.com/simple/
```

https://blog.csdn.net/wcy23580/article/details/88723035



## CUDA設置多GPU并行

https://developer.nvidia.com/how-to-cuda-python

https://pytorch.org/docs/stable/cuda.html


```python
import torch.nn as nn

model=nn.DataParallel(model,device_ids=[0,1,2]) # multi-GPU
```

https://www.zhihu.com/question/67726969


https://pytorch.org/docs/stable/notes/cuda.html


# DataParallel 转为 DistributedDataParallel

到目前为止，Pytorch不支持 self.parameters()在内部调用DataParallel，这会导致当前问题。即使固定的是，这是直截了当后，Pytorch也不支持调用 self.ParameterList和self.ParameterDict，这也用于TransfoXL，这将导致另一个问题。由于Pytorch会将人们从移开DataParallel，他们不太可能很快就解决此问题。最后，以非BC方式解决此问题将变得更加困难，因为更改模型的组织方式意味着无法加载以前的检查点。同时，您可以DistributedDataParallel改用。

https://github.com/huggingface/transformers/issues/8145


将`DataParallel` 转为`DistributedDataParallel`， 同时保障`torch.nn.parallel.DistributedDataParallel`正确初始化


https://blog.csdn.net/weixin_42388228/article/details/103067973

## pytorch 分布式训练

init_method 参数就是多进程通信的方式，前文说了通过命令行 args.dist_url 传入即可，单机多卡直接无脑 TCP 就行，又快又稳，比如：tcp://127.0.0.1:8009，随便选一个没有被占用的端口即可。
backend 参数可以参考 PyTorch Distributed Backends，也就是分布式训练的底层实现，GPU 用 nccl，CPU 用 gloo，不用选了。

https://zhuanlan.zhihu.com/p/76638962

https://murphypei.github.io/blog/2020/09/pytorch-distributed

https://zhuanlan.zhihu.com/p/76638962


https://blog.csdn.net/weixin_40087578/article/details/87186613

https://kangsheng.xyz/2020/08/13/pytorch%E4%B8%AD%E5%8D%95%E6%9C%BA%E5%A4%9A%E5%8D%A1%E8%AE%AD%E7%BB%83/



# Transformer XL

https://www.bookstack.cn/read/huaxiaozhuan-ai/spilt.3.8c42358a11926b2f.md

https://indexfziq.github.io/2019/06/25/TransformerXL/

源码解读

https://blog.csdn.net/Magical_Bubble/article/details/89060213


## model.generate

https://github.com/huggingface/transformers/blob/c4d4e8bdbd25d9463d41de6398940329c89b7fb6/src/transformers/generation_utils.py#L101

https://huggingface.co/blog/how-to-generate

https://blog.csdn.net/ACM_hades/article/details/104742528

https://lonepatient.top/2019/07/14/transformer_xl

## 模型加载和下游任务使用

https://dxzmpk.github.io/2020/04/23/HuggingFace-transformers%E7%B3%BB%E5%88%97%E7%9A%84%E4%BB%8B%E7%BB%8D%E4%BB%A5%E5%8F%8A%E5%9C%A8%E4%B8%8B%E6%B8%B8%E4%BB%BB%E5%8A%A1%E4%B8%AD%E7%9A%84%E4%BD%BF%E7%94%A8/