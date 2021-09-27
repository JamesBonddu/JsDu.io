# Django REST


## adstract class

https://stackoverflow.com/questions/33137165/django-rest-framework-abstract-class-serializer

参考:

https://www.django-rest-framework.org/api-guide/fields/#using-source


https://stackoverflow.com/questions/33137165/django-rest-framework-abstract-class-serializer

https://stackoverflow.com/questions/24048595/django-rest-framework-multitable-model-inheritance-modelserializers-and-nested

https://blog.auberginesolutions.com/blog/decide-serializer-class-dynamically-based-on-viewset-actions-in-django-rest-framework-drf/

https://www.thebookofjoel.com/django-rest-framework-dynamic-fields

https://juejin.im/post/5a68934551882573443cddf8


# Serializer relations

https://www.django-rest-framework.org/api-guide/relations/

# Django rest framework源码分析

django-rest-framework源码中到处都是
- 基于CBV class based views
原理：url-->view方法-->dispatch方法（反射执行其它方法：GET/POST/PUT/DELETE等等）
django-rest-framework overrides the dispatch method to provide functionality like authentication, permission, throttling.

https://www.django-rest-framework.org/tutorial/3-class-based-views/
- 面向对象的封装

https://www.cnblogs.com/derek1184405959/p/8712206.html

# select_for_update

查询集执行select_for_update()操作不是EventRegistration行之有效的方法。这将锁定指定的行，但是可能您要防止的冲突涉及创建new EventRegistrations。您的锁不会阻止这种情况。

相反，您可以在上获得一个锁Event。就像是：

https://stackoverflow.com/questions/52454982/django-transaction-and-select-for-update#:~:text=select_for_update%20is%20a%20database%20function%20option%20implemented%20using,ACID%20properties.%20To%20me%20your%20approach%20seems%20correct.


# 反向查询

```sh
Tom = Person.objects.get(id=1)
# 查询此人有多少车
# 方式一:
# Django默认每个主表对象都有一个外键的属性
# 可以通过它来查询所有属于主表的子表信息
# 查询方式：主表.子表_set()
# 返回值为一个queryset对象
Tom.Car_set().all()
# 方式二：
# 通过在外键中设置related_name属性值既可
Tom.cars.all()
# 方式三：
# 通过@property装饰器在model中预定义方法实现
Tom.all_cars
```

# django 中间件顺序

https://docs.djangoproject.com/en/3.2/ref/middleware/


# REST Framework

框架流程

dispatch中的initialize_request方法执行完成之后，还有执行一个重要方法是self.initial(request, *args, **kwargs)，这个方法也是APIView类里的。在这个方法里面初始化
被重新封装的request对象
实现功能:
- 版本处理
- 用户认证
- 权限
- 访问频率限制

```python
class APIView(View):

    # The following policies may be set at either globally, or per-view.
    renderer_classes = api_settings.DEFAULT_RENDERER_CLASSES
    parser_classes = api_settings.DEFAULT_PARSER_CLASSES
    authentication_classes = api_settings.DEFAULT_AUTHENTICATION_CLASSES
    throttle_classes = api_settings.DEFAULT_THROTTLE_CLASSES
    permission_classes = api_settings.DEFAULT_PERMISSION_CLASSES
    content_negotiation_class = api_settings.DEFAULT_CONTENT_NEGOTIATION_CLASS
    metadata_class = api_settings.DEFAULT_METADATA_CLASS
    versioning_class = api_settings.DEFAULT_VERSIONING_CLASS

    # Allow dependency injection of other settings to make testing easier.
    settings = api_settings

    schema = DefaultSchema()

        # Dispatch methods

    def initialize_request(self, request, *args, **kwargs):
        """
        Returns the initial request object.
        """
        parser_context = self.get_parser_context(request)

        return Request(
            request,
            parsers=self.get_parsers(),
            authenticators=self.get_authenticators(),
            negotiator=self.get_content_negotiator(),
            parser_context=parser_context
        )

    def initial(self, request, *args, **kwargs):
        """
        Runs anything that needs to occur prior to calling the method handler.
        """
        self.format_kwarg = self.get_format_suffix(**kwargs)

        # Perform content negotiation and store the accepted info on the request
        neg = self.perform_content_negotiation(request)
        request.accepted_renderer, request.accepted_media_type = neg

        # Determine the API version, if versioning is in use.
        version, scheme = self.determine_version(request, *args, **kwargs)
        request.version, request.versioning_scheme = version, scheme

        # Ensure that the incoming request is permitted
        self.perform_authentication(request)
        self.check_permissions(request)
        self.check_throttles(request)
```


https://www.cnblogs.com/eric_yi/p/8422373.html




https://pizzali.github.io/2018/12/07/DRF%E4%B9%8BREST%E8%A7%84%E8%8C%83%E4%BB%8B%E7%BB%8D%E5%8F%8AView%E8%AF%B7%E6%B1%82%E6%B5%81%E7%A8%8B%E5%88%86%E6%9E%90/