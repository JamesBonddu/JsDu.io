https://www.cnblogs.com/guoyaohua/p/transformer.html


# tokenizer.encode_plus

最终会输出input句子的id

https://www.cnblogs.com/dogecheng/p/11907036.html

# nn.Linear()

PyTorch的nn.Linear()是用于设置网络中的全连接层的，需要注意的是全连接层的输入与输出都是二维张量，一般形状为[batch_size, size]，不同于卷积层要求输入输出是四维张量。

https://blog.csdn.net/qq_42079689/article/details/102873766

# automodel

https://huggingface.co/transformers/model_doc/auto.html?highlight=automodel#transformers.AutoModel

# model.eval()

https://stackoverflow.com/questions/60018578/what-does-model-eval-do-in-pytorch

# torch.multinomial

https://blog.csdn.net/monchin/article/details/79787621

https://pytorch.org/docs/stable/generated/torch.multinomial.html

# 并行编程

https://pytorch.org/docs/stable/pipeline.html

https://pytorch.org/docs/stable/generated/torch.nn.DataParallel.html?highlight=dataparallel#torch.nn.DataParallel

单机多卡训练
DataParallel（DP）：Parameter Server模式，一张卡位reducer，实现也超级简单，一行代码。
DistributedDataParallel（DDP）：All-Reduce模式，本意是用来分布式训练，但是也可用于单机多卡。

https://fyubang.com/2019/07/23/distributed-training3/

DDP 并行编程

https://pytorch.org/docs/stable/notes/ddp.html

DDP 在forward期间完成:
Initialization

All (or chosen) devices ids are saved in constructor and dimension along which data will be scattered (almost always 0 meaning it will be splitted to devices along batch)

Forward

This is done during every forward run:

- Inputs are scattered (tensors along dimensions, tuple, list, dict shallowed copied, other data is shared among threads).
- If there is only one device just return module(*args, **kwargs)
- If there are multiple devices, copy the network from source machine to other devices (it is done each time!)
- Run forward on each device with it's respective input
- Gather outputs from devices onto a single source device (concatenation of outputs) onto a source machine.
- Run the rest of the code, backprop, update weights on source machine etc.
- Source machine is the cuda:0 by default, but it can be chosen. Also weights are updated on a single device, only batch is scattered and the outputs gathered.

https://stackoverflow.com/questions/62857640/does-pytorchs-nn-dataparallel-load-the-same-model-in-each-gpu

# forward 和 backward 的hook

https://blog.paperspace.com/pytorch-hooks-gradient-clipping-debugging/

pytorch的hook机制之register_forward_hook

https://zhuanlan.zhihu.com/p/87853615

Hook support tracking

https://zhuanlan.zhihu.com/p/75054200

```python
def fn1(self, inputs):
    print("fn1", inputs)
    return (inputs[0] + 10,)

def fn2(self, inputs, outputs):
    print("fn2", inputs, outputs)

def fn3(self, inputs, outputs):
    print("fn3", inputs, outputs)
    return outputs + 30

class M(nn.Module):
    def forward(self, x):
        return x + 2

m = M()
m.register_forward_pre_hook(fn1)
m.register_forward_hook(fn2)
m.register_forward_hook(fn3)

scripted_m = torch.jit.script(m)
print("Eager result", m(torch.tensor(0)))
print("Script result", scripted_m(torch.tensor(0)))
```

https://github.com/pytorch/pytorch/issues/34329

https://likewind.top/2019/07/26/pytorch-hook/

(pytorch入门)pytorch上手（注意hook钩子）+visdom可视化+ipdb debug

https://blog.csdn.net/mingqi1996/article/details/85549172

https://www.kaggle.com/sironghuang/understanding-pytorch-hooks

# 前向传播和后向传播算法

Froward Propagation：向前传播算法，其实这个概念非常简单，就是从神经网络的输入，通过一层层的神经元层（先忽略加权求和、加偏差、激活函数等操作），获得一个输出的过程。

我们看个示意图：从输入X到一系列计算后得出Y的过程，我们叫做Forward Propagation。

https://blog.csdn.net/bitcarmanlee/article/details/78819025


https://zhuanlan.zhihu.com/p/49530779

# BertIntermediate

https://zhuanlan.zhihu.com/p/56326356

https://blog.csdn.net/cpluss/article/details/88418176

# nvidia-smi 命令含义

nvidia-smi - Persistence-M (Persistence Mode)

nvidia-smi -pm 1
1
后来发现了有一个貌似比较科学的方法
sudo nvidia-persistenced --persistence-mode

https://blog.csdn.net/chengyq116/article/details/103224622


https://blog.csdn.net/huangfei711/article/details/79230446

半精度深度学习示例

https://github.com/NVIDIA/DeepLearningExamples

# Layoutlm

```python
ipdb> inputs.keys()
dict_keys(['input_ids', 'attention_mask', 'labels', 'bbox', 'token_type_ids'])
ipdb> inputs["token_type_ids"]
tensor([[0, 0, 0,  ..., 0, 0, 0],
        [0, 0, 0,  ..., 0, 0, 0],
        [0, 0, 0,  ..., 0, 0, 0],
        ...,
        [0, 0, 0,  ..., 0, 0, 0],
        [0, 0, 0,  ..., 0, 0, 0],
        [0, 0, 0,  ..., 0, 0, 0]], device='cuda:0')

# 词汇表中的输入序列标记的索引
ipdb> inputs["input_ids"].size()
torch.Size([32, 512])
# 每个输入序列标记的边界框。在范围内选择。
ipdb> inputs["bbox"].size()
torch.Size([32, 512, 4])
# 屏蔽以避免对填充令牌索引引起注意。在：中 选择的掩码值用于未屏蔽的令牌，已屏蔽的令牌。
ipdb> inputs["attention_mask"].size()
torch.Size([32, 512])
ipdb> inputs["labels"].size()
torch.Size([32, 512])
# 分段令牌索引以指示输入的第一部分和第二部分。在以下位置选择索引：对应于句子A令牌， 对应于句子B令牌
ipdb> inputs["token_type_ids"].size()
torch.Size([32, 512])
```

# 半精度训练

bert model parameters forward empty ,forward 过程中self.parameters() 为空


https://pytorch.org/blog/accelerating-training-on-nvidia-gpus-with-pytorch-automatic-mixed-precision/

https://nvidia.github.io/apex/amp.html

# forward过程

那么调用forward方法的具体流程是什么样的呢？具体流程是这样的：

以一个Module为例：
- 调用module的call方法
- module的call里面调用module的forward方法
- forward里面如果碰到Module的子类，回到第1步，如果碰到的是Function的子类，继续往下
- 调用Function的call方法
- Function的call方法调用了Function的forward方法。
- Function的forward返回值
- module的forward返回值
- 在module的call进行forward_hook操作，然后返回值。


https://www.cnblogs.com/guoyaohua/p/transformer.html

https://blog.csdn.net/xu380393916/article/details/97280035

https://blog.csdn.net/u011501388/article/details/84062483

## 并行时参数复制问题

https://github.com/pytorch/pytorch/issues/36035

https://github.com/pytorch/pytorch/blob/master/torch/nn/parallel/distributed.py

# pytorch 参数 Pytorch之parameters

我将为您分解。如您所知，张量是多维矩阵。原始形式的参数是张量，即多维矩阵。它对变量类进行子类化。

与模块关联时，会出现变量和参数之间的差异。当参数与作为模型属性的模块关联时，它会自动添加到参数列表中，并且可以使用“参数”迭代器进行访问。

https://zhuanlan.zhihu.com/p/115180541

https://stackoverflow.com/questions/50935345/understanding-torch-nn-parameter

# 参数

```python
LayoutlmConfig {
  "_name_or_path": "./unilm-base-cased",
  "attention_probs_dropout_prob": 0.1,
  "directionality": "bidi",
  "gradient_checkpointing": false,
  "hidden_act": "gelu",
  "hidden_dropout_prob": 0.1,
  "hidden_size": 768,
  "id2label": {
    "0": "LABEL_0",
    "1": "LABEL_1",
    "2": "LABEL_2",
    "3": "LABEL_3",
    "4": "LABEL_4",
    "5": "LABEL_5",
    "6": "LABEL_6",
    "7": "LABEL_7",
    "8": "LABEL_8",
    "9": "LABEL_9",
    "10": "LABEL_10",
    "11": "LABEL_11",
    "12": "LABEL_12"
  },
  "initializer_range": 0.02,
  "intermediate_size": 3072,
  "label2id": {
    "LABEL_0": 0,
    "LABEL_1": 1,
    "LABEL_10": 10,
    "LABEL_11": 11,
    "LABEL_12": 12,
    "LABEL_2": 2,
    "LABEL_3": 3,
    "LABEL_4": 4,
    "LABEL_5": 5,
    "LABEL_6": 6,
    "LABEL_7": 7,
    "LABEL_8": 8,
    "LABEL_9": 9
  },
  "label_smoothing": 0.0,
  "layer_norm_eps": 1e-12,
  "layer_norm_epsilon": 1e-05,
  "max_2d_position_embeddings": 1024,
  "max_position_embeddings": 512,
  "model_type": "bert",
  "num_attention_heads": 12,
  "num_hidden_layers": 12,
  "pad_token_id": 0,
  "pooler_fc_size": 768,
  "pooler_num_attention_heads": 12,
  "pooler_num_fc_layers": 3,
  "pooler_size_per_head": 128,
  "pooler_type": "first_token_transform",
  "position_embedding_type": "absolute",
  "transformers_version": "4.3.3",
  "type_vocab_size": 6,
  "use_cache": true,
  "vocab_size": 28996
}


```

https://huggingface.co/transformers/v3.2.0/model_doc/layoutlm.html#layoutlmfortokenclassification


# 交叉熵 cross-entropy loss function

https://blog.csdn.net/chao_shine/article/details/89925762


# Parameter 和 buffer
如果您的模型中有参数，应将其保存在state_dict中并在其中进行恢复，但未经优化器训练，则应将其注册为缓冲区。不会在model.parameters（）中返回缓冲区，以使优化器获胜无需进行更新即可更改。
模型中需要保存下来的参数包括两种:

一种是反向传播需要被optimizer更新的，称之为 parameter
一种是反向传播不需要被optimizer更新，称之为 buffer

https://zhuanlan.zhihu.com/p/89442276

https://pytorch.org/docs/stable/generated/torch.nn.parameter.Parameter.html

https://stackoverflow.com/questions/57540745/what-is-the-difference-between-register-parameter-and-register-buffer-in-pytorch

# zero_grad

在中PyTorch，我们需要在开始进行反向传播之前将梯度设置为零，因为PyTorch会在随后的向后传递中累积梯度。在训练RNN时这很方便。因此，默认操作是在每次调用时累积（即求和）梯度loss.backward()。

https://stackoverflow.com/questions/48001598/why-do-we-need-to-call-zero-grad-in-pytorch

# pytorch 的autograd, backward 详解

如果我们需要计算某个Tensor的导数，那么我们需要设置其.requires_grad属性为True。为方便说明，在本文中对于这种我们自己定义的变量，我们称之为叶子节点(leaf nodes)，而基于叶子节点得到的中间或最终变量则可称之为结果节点。例如下面例子中的x则是叶子节点，y则是结果节点。

x = torch.rand(3, requires_grad=True)
y = x**2
z = x + x

另外一个Tensor中通常会记录如下图中所示的属性：

- data: 即存储的数据信息
- requires_grad: 设置为True则表示该Tensor需要求导
- grad: 该Tensor的梯度值，每次在计算backward时都需要将前一时刻的梯度归零，否则梯度值会一直累加，这个会在后面讲到。
- grad_fn: 叶子节点通常为None，只有结果节点的grad_fn才有效，用于指示梯度函数是哪种类型。例如上面示例代码中的y.grad_fn=<PowBackward0 at 0x213550af048>, z.grad_fn=<AddBackward0 at 0x2135df11be0>
- is_leaf: 用来指示该Tensor是否是叶子节点。

如果你知道向量的链式法则的话，应该很好理解的，假设是在z点backward，输入grad_tensors应该是目标函数(scalar)f对z的梯度，那么delta(f)/delta(x) = (delta(z)/delta(x))*delta(f)/delta(z)，后边的第二项就是传入的grad_tensors。“The graph is differentiated using the chain rule. If any of tensors are non-scalar (i.e. their data has more than one element) and require gradient, then the Jacobian-vector product would be computed, in this case the function additionally requires specifying grad_tensors. It should be a sequence of matching length, that contains the “vector” in the Jacobian-vector product, usually the gradient of the differentiated function w.r.t. corresponding tensors (None is an acceptable value for all tensors that don’t need gradient tensors).-https://pytorch.org/docs/stable/autograd.html”

https://zhuanlan.zhihu.com/p/83172023


autograd.Variable是torch.autograd中很重要的类。它用来包装Tensor，将Tensor转换为Variable之后，可以装载梯度信息。

https://zhuanlan.zhihu.com/p/29904755

# 2D卷积

https://www.allaboutcircuits.com/technical-articles/two-dimensional-convolution-in-image-processing/

# model.pth如何使用

https://pytorch-cn.readthedocs.io/zh/latest/torchvision/torchvision-models/

https://blog.csdn.net/qq_42698422/article/details/100547225

跨设备保存加载模型

https://zhuanlan.zhihu.com/p/73893187


## .pth和.bin的区别

https://github.com/pytorch/pytorch/issues/14864

https://stackoverflow.com/questions/57245332/what-are-the-difference-between-bin-and-pt-pytorch-saved-model-types

# torch 中contiguous

https://blog.csdn.net/gdymind/article/details/82662502


https://blog.csdn.net/u012419550/article/details/108120383