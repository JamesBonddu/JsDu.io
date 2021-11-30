# xray


xray --url http://example.com/ --json-output report.json
xray --url http://example.com/ --html-output front-vuln.html
xray --url http://example.com/ --json-output report.json

https://github.com/chaitin/xray/releases/tag/1.8.2

https://zhuanlan.zhihu.com/p/78132359

https://www.cnblogs.com/cheuhxg/p/14649555.html

https://xray.cool/

https://blog.xray.cool/h

# 登录页面渗透测试

https://cloud.tencent.com/developer/article/1507905

https://www.cnblogs.com/backlion/p/14288456.html

# 漏洞样例

https://docs.xray.cool/assets/report_example.html

# poc编辑示例

为了帮助大家更好的理解 poc 中各部分的作用，此处先介绍一下一个 yaml poc 的执行过程。

在一个 yaml poc 从文件加载到 go 的某个结构后，会首先对表达式进行预编译和静态类型检查，这一过程主要作用于 yaml 中的 set 和 expression 部分，这两部分是 yaml poc 的关键，主要用到了 CEL 表达式。

pocassist 借鉴了 xray 的 poc 框架 phantasm ，通过 CEL 表达式定义 poc。

https://pocassist.jweny.top/pocedit/

https://github.com/jweny/pocassist

https://github.com/knownsec/404StarLink#community


https://docs.xray.cool/#/guide/high_quality_poc


https://zhuanlan.zhihu.com/p/55204575

# xray 内置的poc

```yml
name: poc-yaml-laravel-improper-webdir
manual: true
transport: http
rules:
    r0:
        request:
            cache: true
            method: GET
            path: /storage/logs/laravel.log
            follow_redirects: false
        expression: response.status == 200 && (response.content_type.contains("plain") || response.content_type.contains("octet-stream")) && (response.body.bcontains(b"vendor\\laravel\\framework") || response.body.bcontains(b"vendor/laravel/framework")) && (response.body.bcontains(b"stacktrace") || response.body.bcontains(b"Stack trace"))
expression: r0()
detail:
    author: Dem0ns (https://github.com/dem0ns)
    links:
        - https://github.com/dem0ns/improper


name: poc-yaml-laravel-debug-info-leak
manual: true
transport: http
rules:
    r0:
        request:
            cache: true
            method: POST
            path: /
            follow_redirects: false
        expression: response.status == 405 && response.body.bcontains(b"MethodNotAllowedHttpException") && response.body.bcontains(b"Environment &amp; details") && (response.body.bcontains(b"vendor\\laravel\\framework\\src\\Illuminate\\Routing\\RouteCollection.php") || response.body.bcontains(b"vendor/laravel/framework/src/Illuminate/Routing/RouteCollection.php"))
expression: r0()
detail:
    author: Dem0ns (https://github.com/dem0ns)
    links:
        - https://github.com/dem0ns/improper/tree/master/laravel/5_debug
```

整个POC是一个键值对，其包含3个键：

- name: string
- rules: []Rule
- detail: map[string]string

name是POC的名字，我们使用一个英文字母、数字和短横线进行表示，如poc-yaml-thinkphp523-rce。

rules是一个由规则（Rule）组成的列表，后面会描述如何编写Rule，并将其组成rules。

detail是一个键值对，内部存储需要返回给xray引擎的内容，如果无需返回内容，可以忽略。

如果说Rule是一个POC的灵魂，那么expression表达式就是Rule的灵魂。

https://github.com/chaitin/xray/tree/master/pocs

https://github.com/chaitin/xray/blob/master/pocs/laravel-improper-webdir.yml

https://zhuanlan.zhihu.com/p/78334648

https://github.com/google/cel-spec

https://forum.butian.net/share/160

# CEL表达式

spring使用SpEL表达式，struts2使用OGNL表达式，xray使用了编译性语言Golang，所以为了实现动态执行一些规则，我们使用了Common Expression Language (CEL)表达式。


https://github.com/google/cel-spec

https://phith0n.github.io/xray-poc-generation/


https://www.exploit-db.com/


# nuclei

https://github.com/projectdiscovery/nuclei