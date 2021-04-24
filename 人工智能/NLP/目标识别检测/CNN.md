# CNN

网络组成由
卷积层 + 池化层 + 全链接层

卷积层

这个过程我们可以理解为我们使用一个过滤器（卷积核）来过滤图像的各个小区域，从而得到这些小区域的特征值。

池化层

上图中，我们可以看到，原始图片是20×20的，我们对其进行下采样，采样窗口为10×10，最终将其下采样成为一个2×2大小的特征图。降低数据的维度进行下采样.

https://easyai.tech/ai-definition/cnn/

# Faster RCNN

经过R-CNN和Fast RCNN的积淀，Ross B. Girshick在2016年提出了新的Faster RCNN，在结构上，Faster RCNN已经将特征抽取(feature extraction)，proposal提取，bounding box regression(rect refine)，classification都整合在了一个网络中，使得综合性能有较大提高，在检测速度方面尤为明显。

经典的检测方法生成检测框都非常耗时，如OpenCV adaboost使用滑动窗口+图像金字塔生成检测框；或如R-CNN使用SS(Selective Search)方法生成检测框。而Faster RCNN则抛弃了传统的滑动窗口和SS方法，直接使用Region Proposal Networks(RPN)生成检测框，这也是Faster R-CNN的巨大优势，能极大提升检测框的生成速度。

其实RPN最终就是在原图尺度上，设置了密密麻麻的候选Anchor。然后用cnn去判断哪些Anchor是里面有目标的positive anchor，哪些是没目标的negative anchor。所以，仅仅是个二分类而已！

RPN网络结构就介绍到这里，总结起来就是：
生成anchors -> softmax分类器提取positvie anchors -> bbox reg回归positive anchors -> Proposal Layer生成proposals

Proposal Layer负责综合所有 [公式] 变换量和positive anchors，计算出精准的proposal，送入后续RoI Pooling Layer。

https://zhuanlan.zhihu.com/p/31426458

https://zhuanlan.zhihu.com/p/145842317

https://www.cnblogs.com/wanghui-garcia/p/11156243.html

# LSTM

This decision is made by a sigmoid layer called the “forget gate layer.”
First, a sigmoid layer called the “input gate layer” decides which values we’ll update.

http://colah.github.io/posts/2015-08-Understanding-LSTMs/

https://www.zhihu.com/question/61265076

# CPTN

CNN学习的是感受野内的空间信息，LSTM学习的是序列特征。对于文本序列检测，显然既需要CNN抽象空间特征，也需要序列特征（毕竟文字是连续的）。

CTPN中使用双向LSTM，相比一般单向LSTM有什么优势？双向LSTM实际上就是将2个方向相反的LSTM连起来，如图4。


# YOLOv3

https://blog.csdn.net/qq_33869371/article/details/94894312

https://zhuanlan.zhihu.com/p/32525231

https://zhuanlan.zhihu.com/p/143747206

https://zhuanlan.zhihu.com/p/183261974


# 分割

https://tech.meituan.com/2020/05/21/cvpr2020-centermask.html

http://liangjie.xyz/blogs/Segmentation/


# RESNET

为什么要引入ResNet？
我们知道，网络越深，咱们能获取的信息越多，而且特征也越丰富。但是根据实验表明，随着网络的加深，优化效果反而越差，测试数据和训练数据的准确率反而降低了。这是由于网络的加深会造成梯度爆炸和梯度消失的问题。

：对输入数据和中间层的数据进行归一化操作，这种方法可以保证网络在反向传播中采用随机梯度下降（SGD），从而让网络达到收敛。但是，这个方法仅对几十层的网络有用，当网络再往深处走的时候，这种方法就无用武之地了。

为了让更深的网络也能训练出好的效果，何凯明大神提出了一个新的网络结构——ResNet。这个网络结构的想法主要源于VLAD（残差的想法来源）和Highway Network（跳跃连接的想法来源）



https://blog.csdn.net/sunny_yeah_/article/details/89430124