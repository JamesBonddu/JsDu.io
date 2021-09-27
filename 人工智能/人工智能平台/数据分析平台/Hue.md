# HUE

https://github.com/SimonHoiberg/Hue-Debugger-UI

## hue demo

https://demo.gethue.com/hue

# 安装踩坑

https://www.cnblogs.com/zlslch/p/6819622.html

# HUE的身份验证

desktop.auth.backend.OAuthBackend

https://docs.gethue.com/administrator/configuration/server/#authentication

控制登录超时时间

[desktop]
[[auth]]
idle_session_timeout=600

# HUE 的debug方式

https://docs.gethue.com/developer/development/#debugging-tips-and-tricks

# 界面的自定义

https://docs.gethue.com/administrator/configuration/server/#customization

# 编辑器

## SQL Autocomplete SQL自动补全
Install a patched jison

## ace编辑器
tools/ace-editor 下的文件后，运行以下命令构建 ace.js

https://github.com/ajaxorg/ace

https://docs.gethue.com/administrator/configuration/apps/

## knockoutjs

https://knockoutjs.com/

## SQL解析

There are several parsers in Hue already (e.g. one for Impala, one for Hive..) and a generic SQL that is used for other dialects. The parsers are written using a bison grammar and are generated with jison. 

## bison + jison的语法解析器

Bison 是一种通用解析器生成器，可将带注释的上下文无关文法转换为使用LALR (1) 解析器表的确定性 LR 或广义 LR (GLR) 解析器 。作为一项实验性功能，Bison 还可以生成IELR (1) 或规范的 LR(1) 解析器表。一旦您精通 Bison，您就可以使用它来开发各种语言解析器，从简单的桌面计算器中使用的解析器到复杂的编程语言。

Bison 与 Yacc 向上兼容：所有正确编写的 Yacc 语法都应该与 Bison 一起使用而无需更改。任何熟悉 Yacc 的人都应该能够轻松使用 Bison。您需要精通 C 或 C++ 编程才能使用 Bison。Java 也被支持作为一项实验性功能。

## 语法解析器的形式语法

bison的语法文件.形式语法是一种数学结构。要为 Bison 定义语言，您必须编写一个用 Bison 语法表达语法的文件

### 语法规则

http://dinosaur.compilertools.net/bison/bison_6.html#SEC41

http://dinosaur.compilertools.net/bison/bison_6.html#SEC34

jison的一些例子:

https://github.com/zaach/jison/blob/master/examples/README

> 参考

https://www.gnu.org/software/bison/

https://www.gnu.org/software/bison/manual/bison.html

http://dinosaur.compilertools.net/bison/bison_4.html

https://github.com/zaach/jison

https://docs.gethue.com/developer/development/#sql-parsers

# HUE通过Livy和spark进行交互


https://docs.gethue.com/user/querying/#spark