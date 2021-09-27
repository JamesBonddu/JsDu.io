# Django

django 启动流程
https://juejin.im/post/5c4d0e916fb9a049ed313f46

## Django

MTV Model Template View

Django的密码存储位置

Django authentication and login

python manage.py startapp floder name

参考:

https://docs.djangoproject.com/en/2.2/topics/auth/passwords/
https://developer.mozilla.org/en-US/docs/Learn/Server-side/Django/Authentication

https://docs.djangoproject.com/en/2.2/topics/auth/

https://www.cnblogs.com/liwenzhou/p/8296964.html

https://docs.djangoproject.com/en/2.2/topics/migrations/


### 1062-duplicate-entry

参考:

https://stackoverflow.com/questions/38015891/django-db-utils-integrityerror-1062-duplicate-entry-for-user-id

### django filter的用法和设计

参考:

https://django-filter.readthedocs.io/en/master/ref/filters.html

### django models Model state

django.db.models.base.ModelState

### django models manager

django.db.models.manager.Manager

objects.all() 获取到model对象
objects.values() 获取所有的值


参考:

https://docs.djangoproject.com/zh-hans/2.2/_modules/django/db/models/manager/

### Foreignkey 在添加和删除时需要注意

参考:

https://docs.djangoproject.com/en/2.2/ref/models/fields/

http://www.learningaboutelectronics.com/Articles/ForeignKey-in-Django.php


## django blank is true

blank=True表示该字段在代码层面可不可以不传值，如果blank=False（默认情况），但是通过Model创建对象时却没有给该字段赋值，Django会报错。

null=True表示该字段在数据库层面可不可以不传值，如果null=False（默认情况），写入数据库时该字段没有赋值，或者赋值为None，则数据库会报错。

那为什么说要尽量少用null=True呢？是因为数据库表的一列中只要有一个null值，那么这一列的索引都会失效。null会导致数据库查询性能的大幅下降。

https://stackoverflow.com/questions/8609192/
differentiate-null-true-blank-true-in-django

https://cloud.tencent.com/developer/news/359530

## django admin

https://docs.djangoproject.com/en/2.2/ref/contrib/admin/

## django __unicode__

https://segmentfault.com/q/1010000006121303/

## django annotate

https://stackoverflow.com/questions/21837227/annotate-group-dates-by-month-year-in-django

## django filter queryset

https://stackoverflow.com/questions/18448468/django-how-to-filter-using-queryset-to-get-subset-of-objects


## django Q objects

https://bradmontgomery.net/blog/adding-q-objects-in-django/

## django 外键过滤

https://stackoverflow.com/questions/11508744/django-models-filter-by-foreignkey

https://stackoverflow.com/questions/1981524/django-filtering-on-foreign-key-properties


## 获取外键值

https://stackoverflow.com/questions/26986342/how-to-get-foreignkey-value-for-specific-field-in-django-view


## 通过xadmin获取某个父类的平台model

https://stackoverflow.com/questions/6928692/how-to-express-a-one-to-many-relationship-in-django
https://stackoverflow.com/questions/9174059/search-by-foreign-key-id-in-admin

## django 选择distinct

https://docs.djangoproject.com/en/1.9/ref/models/querysets/#django.db.models.query.QuerySet.distinct



## python manage.py migrate

每次修改完`models.py`时, 需要重新*makemigrations*, 删除数据库中migrations记录,migrations下生成的文件, 之前生成的相关表.
在执行*python manage.py migrate*

## django auth

django 的权限和分组管理

https://docs.djangoproject.com/en/2.2/ref/contrib/auth/

https://docs.djangoproject.com/en/2.2/topics/auth/

https://www.cnblogs.com/zhumengke/articles/11106179.html


## Django ORM调优

https://ewp.gma.mybluehost.me/2018/11/04/django-orm-optimization-tips/


## exclude some field from values

https://stackoverflow.com/questions/16854659/exclude-field-from-values-or-values-list

## django csrf bypass

https://blog.knownsec.com/2016/10/django-csrf-bypass_cve-2016-7401/
https://strcpy.me/index.php/archives/753/
https://www.leavesongs.com/HTML/zhihu-xss-worm.html

## 不能添加外键约束

https://stackoverflow.com/questions/15534977/mysql-cannot-add-foreign-key-constraint
https://stackoverflow.com/questions/18391034/cannot-resolve-table-name-close-to
https://www.percona.com/blog/2017/04/06/dealing-mysql-error-code-1215-cannot-add-foreign-key-constraint/

https://stackoverflow.com/questions/10028214/add-foreign-key-to-existing-table?rq=1

https://stackoverflow.com/questions/14122031/how-to-remove-constraints-from-my-mysql-table

https://stackoverflow.com/questions/18930084/mysql-error-1215-hy000-cannot-add-foreign-key-constraint


## django filter !=

https://stackoverflow.com/questions/844556/filtering-for-empty-or-null-names-in-a-queryset

https://stackoverflow.com/questions/687295/how-do-i-do-a-not-equal-in-django-queryset-filtering

## Django debug panel

https://www.bedjango.com/blog/how-debug-django-useful-tips/


## django signals
https://docs.djangoproject.com/en/3.0/topics/signals/


## django backends log

https://docs.djangoproject.com/en/3.0/topics/logging/


## django 的traceback机制


https://pycoders-weekly-chinese.readthedocs.io/en/latest/issue8/Notes-on-tracing-code-execution-in-Django-and-Python.html

<<<<<<< HEAD
# Django 信号 singal

https://www.cnblogs.com/Neeo/articles/11601851.html

# Django 开发环境, 生产环境配置

https://stackoverflow.com/questions/10664244/django-how-to-manage-development-and-production-settings

# Django 项目布局参考

https://dev.to/wemake-services/managing-djangos-settings-37ao

https://www.codingforentrepreneurs.com/blog/staging-django-production-development

https://simpleisbetterthancomplex.com/tips/2017/07/03/django-tip-20-working-with-multiple-settings-modules.html

https://realpython.com/python-application-layouts/

# Django 添加自定义testRunner

```python
# Credit:
# http://birdhouse.org/blog/2015/03/25/django-unit-tests-against-unmanaged-databases/
# https://www.caktusgroup.com/blog/2010/09/24/simplifying-the-testing-of-unmanaged-database-models-in-django/

from django.test.runner import DiscoverRunner


class ManagedModelTestRunner(DiscoverRunner):
    """
    Test runner that automatically makes all unmanaged models in your Django
    project managed for the duration of the test run, so that one doesn't need
    to execute the SQL manually to create them.
    """

    def __init__(self, **kwargs):
        from django.apps import apps

        super(ManagedModelTestRunner, self).__init__(**kwargs)

        # for a in apps.get_apps():
        #     print("Found app %s" % (a))

        # NOTE: apps must be registered in INSTALLED_APPS in settings.py before their models appear here
        all_models = apps.get_models()
        # for m in all_models:
        #     print("Found model %s - Managed:%s" % (m, m._meta.managed))

        self.unmanaged_models = [m for m in all_models if not m._meta.managed]

    def setup_test_environment(self, *args, **kwargs):
        for m in self.unmanaged_models:
            m._meta.managed = True
            # print("Modifying model %s to be managed for testing - Managed:%s" % (m, m._meta.managed))
        super(ManagedModelTestRunner, self).setup_test_environment(*args, **kwargs)

    def teardown_test_environment(self, *args, **kwargs):
        super(ManagedModelTestRunner, self).teardown_test_environment(*args, **kwargs)
        # reset unmanaged models
        for m in self.unmanaged_models:
            m._meta.managed = False
            # print("Resetting model %s to be unmanaged - Managed:%s" % (m, m._meta.managed))


self.settings.TEST_RUNNER = "xman.runners.ManagedModelTestRunner"
```

django 小技巧
https://simpleisbetterthancomplex.com/tips/2016/08/19/django-tip-12-disabling-migrations-to-speed-up-unit-tests.html

https://simpleisbetterthancomplex.com/tips/

# django + scrapy

https://www.dinofizzotti.com/blog/2018-10-14-carbalert-part-2-django-and-scrapy/

# 泛型外键

https://stackoverflow.com/questions/40148630/understanding-django-genericforeignkey-and-genericrelation

https://stackoverflow.com/questions/20895429/how-exactly-do-django-content-types-work

https://docs.djangoproject.com/en/3.1/ref/contrib/contenttypes/

https://www.liujiangblog.com/blog/44/

# django 默認的密碼加密

pbkdf2_sha256

bcrypt

https://cryptobook.nakov.com/mac-and-key-derivation/pbkdf2


```md
SECRET_KEY¶
默认值：（''空字符串）

特定Django安装的密钥。这用于提供 加密签名，并且应设置为唯一的，不可预测的值。

django-admin startproject自动将随机生成的内容添加SECRET_KEY到每个新项目。

键的使用不应假定它是文本或字节。每次使用都应经历force_str()或 force_bytes()将其转换为所需的类型。

如果SECRET_KEY未设置，Django将拒绝启动。

警告

将此价值保密。

以已知的方式运行Django会SECRET_KEY破坏Django的许多安全保护措施，并可能导致特权提升和远程代码执行漏洞。

密钥用于：

如果您使用的会话后端不是或使用默认 会话，则所有会话。django.contrib.sessions.backends.cacheget_session_auth_hash()
如果使用或， 则显示 所有消息。CookieStorageFallbackStorage
所有PasswordResetView令牌。
密码签名的任何用法，除非提供了不同的密钥。
如果旋转密钥，则以上所有内容都会失效。秘密密钥不用于用户密码，密钥旋转不会影响它们。

注意

为方便起见settings.py，创建的默认文件会创建一个唯一的文件。django-admin startprojectSECRET_KEY
```

https://docs.djangoproject.com/en/3.1/topics/signing/

# SECRECT_KEY的作用

https://stackoverflow.com/questions/15170637/effects-of-changing-djangos-secret-key

# JSON Field 和ARRAY Field

https://gist.github.com/laymonage/b53a1acbbab36b77776cd526b48fd2a5
=======
## django migrations如何检测变化

https://realpython.com/digging-deeper-into-migrations/

https://realpython.com/django-migrations-a-primer/


https://stackoverflow.com/questions/1355150/when-saving-how-can-you-check-if-a-field-has-changed


## django queryset manager

https://simpleisbetterthancomplex.com/tips/2016/08/16/django-tip-11-custom-manager-with-chainable-querysets.html


## django 事务

https://stackoverflow.com/questions/27163351/django-transaction-atomic-guarantees-atomic-read-write


https://realpython.com/transaction-management-with-django-1-6/

# post-save信号

https://stackoverflow.com/questions/13014411/django-post-save-signal-implementation

https://docs.djangoproject.com/en/3.2/ref/signals/

https://www.programmersought.com/article/23601752690/

# 安装微软字体

```sh
apt install fontconfig -y

fc-cache -f -v

https://www.unixtutorial.org/how-to-install-ttf-fonts-in-linux/

root@xxxx:/opt/webapp/xman# fc-list
/usr/share/fonts/truetype/dejavu/DejaVuSerif-Bold.ttf: DejaVu Serif:style=Bold
/usr/share/fonts/truetype/dejavu/DejaVuSansMono.ttf: DejaVu Sans Mono:style=Book
/usr/share/fonts/truetype/dejavu/DejaVuSans.ttf: DejaVu Sans:style=Book
/usr/share/fonts/truetype/dejavu/DejaVuSans-Bold.ttf: DejaVu Sans:style=Bold
/usr/share/fonts/truetype/dejavu/DejaVuSansMono-Bold.ttf: DejaVu Sans Mono:style=Bold
/usr/share/fonts/custom/msyh.ttf: Microsoft YaHei,微软雅黑:style=Regular,Normal,obyčejné,Standard,Κανονικά,Normaali,Normál,Normale,Standaard,Normalny,Обычный,Normálne,Navadno,Arrunta
/usr/share/fonts/truetype/dejavu/DejaVuSerif.ttf: DejaVu Serif:style=Book
```

# django 商品死锁

`select_for_update`

https://stackoverflow.com/questions/10935850/when-to-use-select-for-update

https://stackoverflow.com/questions/28191146/avoiding-mysql-deadlock-in-django-orm


mysql死锁

https://segmentfault.com/a/1190000020111518


死锁检测
```mysql
mysql> select @@innodb_deadlock_detect;
+--------------------------+
| @@innodb_deadlock_detect |
+--------------------------+
|                        1 |
+--------------------------+
1 row in set (0.00 sec)

mysql> select @@transaction_isolation;
+-------------------------+
| @@transaction_isolation |
+-------------------------+
| REPEATABLE-READ         |
+-------------------------+
1 row in set (0.00 sec)


```
https://www.cnblogs.com/wy123/p/12724252.html

pt-deadlock-logger 死锁监控

https://www.percona.com/doc/percona-toolkit/LATEST/pt-deadlock-logger.html


## 可重复读隔离级别

https://sqlperformance.com/2014/04/t-sql-queries/the-repeatable-read-isolation-level

https://blog.csdn.net/zzze0101/article/details/91345033



