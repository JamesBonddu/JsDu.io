# Django

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

https://stackoverflow.com/questions/8609192/differentiate-null-true-blank-true-in-django

## django admin

https://docs.djangoproject.com/en/2.2/ref/contrib/admin/

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
