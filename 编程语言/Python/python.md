# python

# 安全合集

https://github.com/uhub/awesome-python/blob/master/README.md

https://asmcn.icopy.site/awesome/awesome-security/

## python深入探究

https://devguide.python.org/appendix/#language-development-in-depth


## python获取子类

### __subclasses__

https://xz.aliyun.com/t/2308

https://ctf-wiki.github.io/ctf-wiki/pwn/linux/sandbox/python-sandbox-escape/

https://pyzh.readthedocs.io/en/latest/python-magic-methods-guide.html

https://stackoverflow.com/questions/35165669/is-there-a-pythonic-way-to-skip-decoration-on-a-subclass-method

https://help.semmle.com/wiki/display/PYTHON/Overwriting+attribute+in+super-class+or+sub-class

### 反射

https://stackoverflow.com/questions/34623610/how-to-use-the-subclasscheck-magic-method

`__init_subclass__`

https://stackoverflow.com/questions/45400284/understanding-init-subclass

https://stackoverflow.com/questions/9008444/how-to-warn-about-class-name-deprecation

https://www.hongweipeng.com/index.php/archives/1872/

https://stackoverflow.com/questions/45400284/understanding-init-subclass

https://www.python.org/dev/peps/pep-0487/

https://python-history.blogspot.com/search?updated-min=2009-01-01T00:00:00-08:00&updated-max=2010-01-01T00:00:00-08:00&max-results=19

`__instancecheck__`

https://stackoverflow.com/questions/47740953/why-isnt-instancecheck-being-called


### 抽象基类

https://docs.python.org/2/library/abc.html



https://null-byte.wonderhowto.com/how-to/hack-like-pro-python-scripting-for-aspiring-hacker-part-2-0159319/


## python 获取class里的functions

https://stackoverflow.com/questions/1911281/how-do-i-get-list-of-methods-in-a-python-class

inspect.getmembers(Command, predicate=inspect.ismethod)


https://jfine-python-classes.readthedocs.io/en/latest/call-a-class.html


## requests hook

https://alexwlchan.net/2017/10/requests-hooks/

https://requests-docs-ja.readthedocs.io/en/latest/user/advanced/

https://github.com/psf/requests/blob/bebf5250b0df1b922ff534e987a4481cc4dde99d/docs/user/advanced.rst

<<<<<<< HEAD
## python中的`__getstate_`和 `__setstate__`

```python
class SomeCls:
    def __init__(self, fname):
        self.name = fname
        self.file = open(fname)
    
    def __getstate__(self):
        od = self.__dict__.copy()
        del od['file']
        return od

    def __setstate__(self, state):
        fh = open(state['name'])
        self.name = state['name']
        self.file = fh

import pickle
obj = SomeCls('/dev/zero')
res = pickle.loads(pickle.dumps())
res.file.read()
```


https://stackoverflow.com/questions/1939058/simple-example-of-use-of-setstate-and-getstate
https://github.com/ray-project/ray/issues/1214

# python __init__

https://ericplayground.com/2018/07/11/python-packages-and-the-purpose-of-__init__-py-file/

同一目录引入所有文件

https://stackoverflow.com/questions/582723/how-to-import-classes-defined-in-init-py

https://effbot.org/zone/import-string.htm

动态引入文件
https://stackoverflow.com/questions/42401495/how-to-dynamically-import-modules

引入文件中的类

https://stackoverflow.com/questions/55067166/in-python-how-do-i-get-the-list-of-classes-defined-within-a-particular-file

# 权限控制

pycasbin

https://github.com/casbin/pycasbin

https://casbin.org/docs/zh-CN/supported-models

# 循环引用

https://www.cnblogs.com/Leon-The-Professional/p/10137405.html

# 常见库

点赞|收藏|follow|feed

https://django-activity-stream.readthedocs.io/en/latest/

https://github.com/justquick/django-activity-stream/blob/master/actstream/urls.py

https://www.zhihu.com/question/24590883
=======
## python list comprehjension 列表推导式

## python __getitem__ __setitem__ 语法糖

通过`__getitem__`或`__setitem__`方式后, 可以直接通过索引访问数据

https://stackoverflow.com/questions/43627405/understanding-getitem-method

## python测试框架

@pytest.fixture(scope=xxx)

function —— 函数级，即调用每个测试函数前，均会重新生成
fixtureclass —— 类级，调用每个测试类前，均会重新生成
fixturemodule —— 模块级，载入每个测试模块前，均会重新生成
fixturepackage —— 包级，载入每个包前，均会重新生成
fixturesession —— 会话级，运行所有用例前，只生成一次 fixture

conftest.py 用于

https://docs.pytest.org/en/latest/contents.html

https://www.cnblogs.com/nbkhic/p/7641202.html

https://juejin.im/post/5d896c31518825095103467c

http://kuanghy.github.io/2018/05/08/pytest

# import hook


https://stackoverflow.com/questions/43571737/how-to-implement-an-import-hook-that-can-modify-the-source-code-on-the-fly-using


https://docs.python.org/2.3/whatsnew/section-pep302.html

https://pymotw.com/3/pkgutil/

https://xion.org.pl/2012/05/06/hacking-python-imports/


https://stackoverflow.com/questions/2699287/what-is-path-useful-for

meta_path
https://dev.to/dangerontheranger/dependency-injection-with-import-hooks-in-python-3-5hap

https://gist.github.com/DangerOnTheRanger/027fc0af3bd010e8265e552c5b3ab4f1

https://www.blog.pythonlibrary.org/2016/05/27/python-201-an-intro-to-importlib/

import 機制

https://manikos.github.io/how-pythons-import-machinery-works


http://sinhub.cn/2019/05/python-import-machinery-part-two/


https://github.com/lihaoyi/macropy


https://python3-cookbook.readthedocs.io/zh_CN/latest/c10/p11_load_modules_from_remote_machine_by_hooks.html

https://python3-cookbook.readthedocs.io/zh_CN/latest/c10/p12_patching_modules_on_import.html



# wtf python

窥孔优化(peephole optimization)
https://en.wikipedia.org/wiki/Peephole_optimization