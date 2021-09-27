# Camelot


https://github.com/camelot-dev/camelot


表格提取工具

Tabula
pdfplumber
pdftables
pdf-table-extract


https://stackoverflow.com/questions/58837504/camelot-pdf-extraction-fail-parsing

## 格子处理

格子首先通过使用Ghostscript将PDF页面转换为图像，然后使用OpenCV应用一组形态学转换（侵蚀和膨胀）对其进行处理，以获取水平和垂直线段。

https://camelot-py.readthedocs.io/en/master/user/how-it-works.html#lattice

扩展晶格算法处理基于图像的pdf

```sh
pip install "camelot-py[cv]"
pip install python3-ghostscript

apt install tesseract-ocr -y
apt install tesseract-ocr-chi-tra -y
apt install tesseract-ocr-chi-sim -y

sudo apt-get install libmagickwand-dev -y
pip install pdfplumber
pip install pytesseract


pip install PyMuPDF

gs \
-o repairedCsKCH16YDk-ASRMnAA1MdCPJJCE535.pdf \
-sDEVICE=pdfwrite \
-dPDFSETTINGS=/prepress \
CsKCH16YDk-ASRMnAA1MdCPJJCE535.pdf

gs \
-o repairedCsKCIV6YAwqAPhiTAAX_JsqMKAU503.pdf \
-sDEVICE=pdfwrite \
-dPDFSETTINGS=/prepress \
CsKCIV6YAwqAPhiTAAX_JsqMKAU503.pdf

# magick wizard: wizard.jpg
# magick wizard.jpg win:
# https://docs.wand-py.org/en/latest/guide/install.html#install-imagemagick-on-windows

# 读取pdf权限
# https://stackoverflow.com/questions/52699608/wand-policy-error-error-constitute-c-readimage-412

```
https://github.com/atlanhq/camelot/issues/14

https://nanonets.com/blog/ocr-with-tesseract/



## pytesseract获取hocr

https://stackoverflow.com/questions/34248492/how-to-get-hocr-output-using-python-tesseract

https://gist.github.com/mndrake/134b8e71f414ffbc4d34131a91aa82e0

HOCR文件处理

https://github.com/kba/hocr-spec/blob/master/1.1/spec_zh_CN.md

tesseract安装

https://tesseract-ocr.github.io/tessdoc/Downloads

## pdf提取目录和表格

https://lidawn.github.io/2016/07/02//pdf-outline-table//

https://stackoverflow.com/questions/1918420/split-a-pdf-based-on-outline

pdf自动生成目录的工具
https://www.v2ex.com/t/693916


多个图片转成一个PDF

https://dev.to/techlearners/create-a-pdf-from-multiple-images-using-python-1l7o

多个PDF合并成一个
https://mind-node.net/merge-many-pdfs-with-python/

## 流处理

流可用于解析在单元格之间具有空格的表，以模拟表结构。它建立在PDFMiner的功能之上，该功能使用margin来将页面上的字符分为单词和句子。

PDF页面上的单词根据它们的y轴重叠部分被分组为文本行。

计算文本边缘，然后将其用于猜测PDF页面上有趣的表格区域。您可以阅读Anssi Nurminen的硕士学位论文，以了解有关此表检测技术的更多信息。[见第20、35和40页]

然后猜测每个表区域内的列数。这是通过计算每个文本行中的单词数模式来完成的。基于此模式，选择每个文本行中的单词以计算列x范围的列表。

然后使用位于当前列x范围内/外的单词来扩展当前列的列表。

最后，使用文本行的y范围和列x的范围来形成表格，并将在页面上找到的单词根据其x和y坐标分配给表格的单元格。

https://camelot-py.readthedocs.io/en/master/user/how-it-works.html#stream


> PDFminner报错
```sh
pdfminer.psparser.PSSyntaxError: Invalid dictionary construct: [/'Dest', /'', /b'\xd9', /b'\x0e', /b'\x86', /b'p\x82\x17\xe1\x8a\xed\x91\x07HS', /b'#', 7, /b'B\x11,\xe4\xa8\xf8', /'Border', [0, 0, 0], /'Type', /'Annot', /'Rect', [69.36, 659.6, 201.84, 673.04], /'Subtype', /'Link'] 
```
https://github.com/pdfminer/pdfminer.six/issues/555

## ghostscript

Ghostscript是PostScript®  语言和PDF文件的解释器。这是在任何可用的GNU GPL Affero许可证或  许可用于商业用途从ARTIFEX软件公司。它已经进行了30多年的积极开发，并已在此期间移植到多个不同的系统中。Ghostscript由PostScript解释器层和图形库组成。

https://ghostscript.com/doc/current/Install.htm


ghostscript 处理pdf

https://www.cnblogs.com/xbblogs/p/11801000.html

https://xz.aliyun.com/t/6392

https://beta.4hou.com/technology/12941.html

# allennlp-models

https://github.com/allenai/allennlp-models


# 获取文本样式

https://pymupdf.readthedocs.io/en/latest/index.html

# pdf 文档结构

https://www.jianshu.com/p/35a0d30b1085

http://www.ityouknow.com/python/2020/01/02/python-pdf-107.html

https://realpython.com/creating-modifying-pdf/


## 获取pdf文本和其文本的坐标

```python
from pdfminer.pdfparser import PDFParser
from pdfminer.pdfdocument import PDFDocument
from pdfminer.pdfpage import PDFPage
from pdfminer.pdfpage import PDFTextExtractionNotAllowed
from pdfminer.pdfinterp import PDFResourceManager
from pdfminer.pdfinterp import PDFPageInterpreter
from pdfminer.pdfdevice import PDFDevice
from pdfminer.layout import LAParams
from pdfminer.converter import PDFPageAggregator
import pdfminer

# Open a PDF file.
fp = open('/Users/me/Downloads/test.pdf', 'rb')

# Create a PDF parser object associated with the file object.
parser = PDFParser(fp)

# Create a PDF document object that stores the document structure.
# Password for initialization as 2nd parameter
document = PDFDocument(parser)

# Check if the document allows text extraction. If not, abort.
if not document.is_extractable:
    raise PDFTextExtractionNotAllowed

# Create a PDF resource manager object that stores shared resources.
rsrcmgr = PDFResourceManager()

# Create a PDF device object.
device = PDFDevice(rsrcmgr)

# BEGIN LAYOUT ANALYSIS
# Set parameters for analysis.
laparams = LAParams()

# Create a PDF page aggregator object.
device = PDFPageAggregator(rsrcmgr, laparams=laparams)

# Create a PDF interpreter object.
interpreter = PDFPageInterpreter(rsrcmgr, device)

def parse_obj(lt_objs):

    # loop over the object list
    for obj in lt_objs:

        # if it's a textbox, print text and location
        if isinstance(obj, pdfminer.layout.LTTextBoxHorizontal):
            print "%6d, %6d, %s" % (obj.bbox[0], obj.bbox[1], obj.get_text().replace('\n', '_'))

        # if it's a container, recurse
        elif isinstance(obj, pdfminer.layout.LTFigure):
            parse_obj(obj._objs)

# loop over all pages in the document
for page in PDFPage.create_pages(document):

    # read the page into a layout object
    interpreter.process_page(page)
    layout = device.get_result()

    # extract text from this object
    parse_obj(layout._objs)
```

https://stackoverflow.com/questions/22898145/how-to-extract-text-and-text-coordinates-from-a-pdf-file


## 获取文本内容和文本里面的对象

https://github.com/jsvine/pdfplumber#objects

# 解析文档目录

https://blog.csdn.net/steve_cui/article/details/82285871


```python
作者：Emrys
链接：https://www.zhihu.com/question/344805337/answer/1116258929
来源：知乎
著作权归作者所有。商业转载请联系作者获得授权，非商业转载请注明出处。

import re
import sys

from distutils.version import LooseVersion
from os.path import exists, splitext
from PyPDF2 import PdfFileReader, PdfFileWriter


is_python2 = LooseVersion(sys.version) < '3'


def _get_parent_bookmark(current_indent, history_indent, bookmarks):
    '''The parent of A is the nearest bookmark whose indent is smaller than A's
    '''
    assert len(history_indent) == len(bookmarks)
    if current_indent == 0:
        return None
    for i in range(len(history_indent) - 1, -1, -1):
        # len(history_indent) - 1   ===>   0
        if history_indent[i] < current_indent:
            return bookmarks[i]
    return None

def addBookmark(pdf_path, bookmark_txt_path, page_offset):
    if not exists(pdf_path):
        return "Error: No such file: {}".format(pdf_path)
    if not exists(bookmark_txt_path):
        return "Error: No such file: {}".format(bookmark_txt_path)

    with open(bookmark_txt_path, 'r', encoding='utf-8') as f:
        bookmark_lines = f.readlines()
    reader = PdfFileReader(pdf_path)
    writer = PdfFileWriter()
    writer.cloneDocumentFromReader(reader)

    maxPages = reader.getNumPages()
    bookmarks, history_indent = [], []
    # decide the level of each bookmark according to the relative indent size in each line
    #   no indent:          level 1
    #     small indent:     level 2
    #       larger indent:  level 3
    #   ...
    for line in bookmark_lines:
        line2 = re.split(r'\s+', unicode(line.strip(), 'utf-8')) if is_python2 else re.split(r'\s+', line.strip())
        if len(line2) == 1:
            continue

        indent_size = len(line) - len(line.lstrip())
        parent = _get_parent_bookmark(indent_size, history_indent, bookmarks)
        history_indent.append(indent_size)

        title, page = ' '.join(line2[:-1]), int(line2[-1]) - 1
        if page + page_offset >= maxPages:
            return "Error: page index out of range: %d >= %d" % (page + page_offset, maxPages)
        new_bookmark = writer.addBookmark(title, page + page_offset, parent=parent)
        bookmarks.append(new_bookmark)

    out_path = splitext(pdf_path)[0] + '-new.pdf'
    with open(out_path,'wb') as f:
        writer.write(f)

    return "The bookmarks have been added to %s" % out_path

if __name__ == "__main__":
    import sys
    args = sys.argv
    if len(args) != 4:
        print("Usage: %s [pdf] [bookmark_txt] [page_offset]" % args[0])
    else:
        print(addBookmark(args[1], args[2], int(args[3])))
```

https://www.zhihu.com/question/344805337


光学解析文字
https://github.com/hwalsuklee/awesome-deep-text-detection-recognition


pdfminer 提取文本位置

https://stackoverflow.com/questions/22898145/how-to-extract-text-and-text-coordinates-from-a-pdf-file?noredirect=1

https://okfnlabs.org/blog/2016/04/19/pdf-tools-extract-text-and-data-from-pdfs.html


textract提取文字

https://github.com/deanmalmgren/textract


abbyy

https://github.com/barrer/scan-helper

# CCKS2019-Task5

，PDF已成为电子文档发行和数字化信息传播的一个标准，其广泛应用于学术界的交流以及各类公告的发行。如何从非结构化的PDF文档中抽取结构化数据是知识图谱领域所面临的一大挑战。本文利用Adobe公司开发的Acrobat DC SDK对PDF进行格式转换，从半结构化的中间文件进行信息抽取。相比已有的开源PDF解析方法，Acrobat导出的中间文件保存了更完整更准确的表格和文本段落信息，能应用于不同需求的信息抽取任务。

https://github.com/houking-can/CCKS2019-Task5

https://blog.csdn.net/houking_can/article/details/105450367

https://www.bilibili.com/read/cv9320134