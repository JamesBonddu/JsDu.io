# docvqa

http://docvqa.org/


# layoutlm

Distinct from previous text-based pre-trained models, LayoutLM uses 2-D position embeddings and image embeddings in addition to the conventional text embeddings.
. During the pre-training stage,
two training objectives are used, which are 
1) a masked visual-language model and 
2) multi-label document classification. 

Different from the vanilla LayoutLM model where image embeddings are combined in the fine-tuning stage, we integrate the image information in the pre-training stage in LayoutLMv2 by taking advantage of the Transformer architecture to learn the cross-modality interaction between visual and textual information.

https://github.com/microsoft/unilm/tree/master/layoutlm

https://www.msra.cn/zh-cn/news/features/layoutlm-v2

https://huggingface.co/transformers/v3.2.0/model_doc/layoutlm.html

https://www.groundai.com/project/layoutlm-pre-training-of-text-and-layout-for-document-image-understanding/1

## layoutlm模型架构

Text Embedding We recognize text and serialize it in a reasonable reading order using off-theshelf OCR tools and PDF parsers. Following the common practice, we use WordPiece (Wu et al.,
2016) to tokenize the text sequence and assign each token to a certain segment si ∈ {[A], [B]}.
Then, we add a [CLS] at the beginning of the token sequence and a [SEP] at the end of each text segment.

Visual Embedding We use ResNeXt-FPN (Xie et al., 2016; Lin et al., 2017) architecture as the
backbone of the visual encoder. Given a document page image I, it is resized to 224 × 224 then fed
into the visual backbone. After that, the output feature map is average-pooled to a fixed size with the
width being W and height being H. Next, it is flattened into a visual embedding sequence of length
W H. A linear projection layer is then applied to each visual token embedding in order to unify the
dimensions.



Layout Embedding The layout embedding layer aims to embed the spatial layout information
represented by token bounding boxes in which corner coordinates and box shapes are identified explicitly. Following the vanilla LayoutLM, we normalize and discretize all coordinates to integers in
the range [0, 1000], and use two embedding layers to embed x-axis features and y-axis features separately. Given the normalized bounding box of the i-th text/visual token boxi = (x0, x1, y0, y1, w, h),
the layout embedding layer concatenates six bounding box features to construct a token-level layout
embedding, aka the 2D positional embedding
li = Concat(PosEmb2Dx(x0, x1, w),PosEmb2Dy(y0, y1, h)), 0 ≤ i < W H + L
Note that CNNs perform local transformation, thus the visual token embeddings can be mapped
back to image regions one by one with neither overlap nor omissi



Multi-modal Encoder with Spatial-Aware Self-Attention Mechanism The encoder concatenates visual embeddings {v0, ..., vWH−1} and text embeddings {t0, ..., tL−1} to a unified sequence
X and fuses spatial information by adding the layout embeddings to get the first layer input x(0).

x(0)i = Xi + li, where X = {v0, ..., vWH−1, t0, ..., tL−1}

Following the architecture of Transformer, we build our multi-modal encoder with a stack of multihead self-attention layers followed by a feed-forward networ

. However, the original self-attention Work in progress mechanism can only implicitly capture the relationship between the input tokens with the absolute
position hints. In order to efficiently model local invariance in the document layout, it is necessary to insert relative position information explicitly. Therefore, we introduce the spatial-aware self-attention mechanism into the self-attention layers. The original self-attention mechanism captures the correlation between query xi and key xj by projecting the two vectors and calculating the
attention score
αij =
1
√
dhead

xiWQ
 xjWK
T
We jointly model the semantic relative position and spatial relative position as bias terms and explicitly add them to the attention sco

## 预训练

Masked Visual-Language Modeling Similar to the vanilla LayoutLM, we use the Masked
Visual-Language Modeling (MVLM) to make the model learn better in the language side with the cross-modality clues. We randomly mask some text tokens and ask the model to recover the masked token.


Text-Image Alignment In addition to the MVLM, we propose the Text-Image Alignment (TIA)
as a fine-grained cross-modality alignment task. In the TIA task, some text tokens are randomly selected, and their image regions are covered on the document image. We call this operation covering
to avoid confusion with the masking operation in MVLM. During the pre-training, a classification layer is built above the encoder output

Text-Image Matching Furthermore, a coarse-grained cross-modality alignment task, Text-Image Matching (TIM) is applied during the pre-training stage.

预训练设置

Pre-training LayoutLMv2 We train LayoutLMv2 models with two different parameter sizes.
We set hidden size d = 768 in LayoutLMv2BASE and use a 12-layer 12-head Transformer encoder. While in the LayoutLMv2LARGE, d = 1024 and its encoder has 24 Transformer layers
with 16 heads. Visual backbones in the two models use the same ResNeXt101-FPN architecture. The numbers of parameters are 200M and 426M approximately for LayoutLMv2BASE and
LayoutLMv2LARGE, respectively.


# 数据集合要求

DocBank数据集样本
我们使用原始的pdf名称作为前缀，并且页面索引从0开始。

每个样本都包含六个文件：

{prefix} _color.pdf：将结构的字体颜色更改为特定于结构的颜色后生成的pdf文件。
{prefix} _black.pdf：将结构的字体颜色更改为黑色后生成的pdf文件，与原始pdf相似。
{prefix} _ {page_index} .jpg：“ _ color.pdf”中页面的图像。
{prefix} _ {page_index} _ori.jpg：“ _ black.pdf”中页面的图像。
{prefix} _ {page_index} _ann.jpg：此示例页面的注释图。
出于可视化目的给出了前五个文件，以下文件是模型所需的唯一文件。

{prefix} _ {page_index} .txt：此示例页面的注释。
注释格式
每行包含一个令牌及其以下信息：

边界框（（x0，y0），（x1，y1））->（x0，y0，x1，y1）
颜色（R，G，B）
字形
标签
指数	0	1个	2个	3	4	5	6	7	8	9
内容	代币	00	00	11	11	[R	G	乙	字体名称	标签


# 目标检测(Object Detection)和分割

https://zhuanlan.zhihu.com/p/96931265

detectron2

https://github.com/facebookresearch/detectron2.git

detectron2 model zoo更多模型

https://github.com/facebookresearch/detectron2/blob/master/MODEL_ZOO.md

https://github.com/facebookresearch/detectron2/tree/master/projects

mmdetection

https://github.com/open-mmlab/mmdetection


# detectron2 物体检测和分割.

https://www.ershicimi.com/p/997ec02556c83a9904e4742b0ed253cd

https://rosenfelder.ai/Instance_Image_Segmentation_for_Window_and_Building_Detection_with_detectron2/

https://blog.paperspace.com/object-detection-segmentation-with-detectron2-on-paperspace-gradient/

# detectron2的输入和输出

## 输入
模型的输入是一个list[dict]，每个dict是一个样本的图像以及标注信息，具体如下：

- “image”: (C, H, W)格式的Tensor，cfg.INPUT.FORMAT决定图像的channel格式，默认是BGR格式，模型侧会采用cfg.MODEL.PIXEL_{MEAN,STD}对image进行归一化；
- “instances”: Instances实例，包括这些字段：gt_boxes，gt_classes，gt_masks，gt_keypoints，不同的模型需求不一样；
- “proposals”：Instances实例，RPN产生的结果，用于Faster R-CNN等模型输入，包括proposal_boxes和objectness_logits字段；
- “height”, “width”：模型最终输出时的图像大小，不一定和image的size一致，比如你做了resize，但是模型最终可以还原到原来的大小；
- “sem_seg”: (H, W)格式的Tensor，用于语义分割GT，类别从0开始（其实detectron是支持分割的，这是一个亮点）；

## 输出

模型在训练时输出的是dict[str->Scalar Tensor]，即各个部分的loss用于模型训练，重点是测试的输出格式，模型输出也是一个list[dict]，每个image对应一个dict：

- “instances”: Instances实例，包括:pred_boxes， scores， pred_classes，pred_masks，pred_keypoints，也是模型不同包含字段有不同；
- “sem_seg”: (num_categories, H, W)格式的Tensor，语义分割预测结果；
- “proposals”：Instances实例，包括:proposal_boxes和objectness_logits，RPN的输出；
- “panoptic_seg”: (Tensor, list[dict])，全景分割结果；

https://detectron2.readthedocs.io/en/latest/tutorials/models.html

# Detectron2 
我们使用开源框架Detectron2 [Wu et al。，2019]在TableBank上训练模型。Detectron2是用于对象检测研究的高质量和高性能代码库，它支持许多最新算法。

安装

python -m pip install detectron2 -f \
  https://dl.fbaipublicfiles.com/detectron2/wheels/cu102/torch1.8/index.html

https://github.com/facebookresearch/detectron2/blob/master/INSTALL.md

https://github.com/doc-analysis/TableBank

https://www.ershicimi.com/p/ce818d7f614ce672c691f0b9955e14d9

# 数据标注

https://github.com/mingx9527/Data_Label_Tools

https://blog.csdn.net/Jay_Josby/article/details/103569721

## Detectron2 

https://detectron2.readthedocs.io/en/latest/tutorials/getting_started.html

使用自定义数据集

https://detectron2.readthedocs.io/en/latest/tutorials/datasets.html

https://colab.research.google.com/drive/16jcaJoc6bCFAQ96jDe2HwtXj7BMD_-m5

使用Detectron2制做自己COCO格式的检测数据集

https://blog.csdn.net/weixin_36047799/article/details/102969779

# 设置国内源

https://blog.csdn.net/a_zhangpengjie/article/details/110003580

# OCR文本识别

使用tesseract做文本识别, 生成hocr文件.

```sh
tesseract testing/eurotext.png testing/eurotext-eng -l eng hocr
```

https://docs.ropensci.org/tesseract/reference/ocr.html

https://github.com/tesseract-ocr/tesseract

https://tesseract-ocr.github.io/tessdoc/

## 提高识别度的技巧

https://tesseract-ocr.github.io/tessdoc/ImproveQuality.html


## HORC 文件格式

https://gaurav-neema.medium.com/ocring-identifying-page-structure-tesseract-hocr-760f3031f3ac


# 文档PDF训练步骤

1.收集PDF

2.手动对数据集进行标注, 数据集的格式需要确定。
如何将数据输入模型？输入数据要求属于某些格式，如YOLO格式、PASCAL VOC格式、COCO格式等。Detectron2接受COCO格式的数据集。数据集的COCO格式由一个JSON文件组成，该文件包含图像的所有细节，如大小、注释（即边界框坐标）、与其边界框对应的标签等。

自定义数据结构到COCO格式的转换
https://colab.research.google.com/drive/1q-gwQteO79r8sX59oYnHYCNtP9zXWFPN?usp=sharing

数据格式:
PASCAL VOC、ImageNet和COCO的标注形式，其中PASCAL VOC和ImageNet使用同样的xml标注格式，COCO为json标注格式。

https://zhuanlan.zhihu.com/p/138067316

3.制作标注数据数据集dataloader, 作为使用Detectron2训练图形model的输入.
4.使用Detectron2训练图形model的输出.


