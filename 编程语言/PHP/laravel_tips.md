
# 邮件发送

https://learnku.com/docs/laravel/7.x/mail/7488

https://blog.mailtrap.io/send-email-in-laravel/

mailgun 竞品

https://postmarkapp.com/compare/mailgun-alternative

多个邮箱driver驱动切换

https://learnku.com/laravel/t/3285/resolved-how-to-make-laravel-53-support-multiple-mail-driver-and-can-switch-in-operation

https://github.com/someniceone/laravel-switchable-mail/blob/master/README.zh_CN.md

https://www.lagou.com/lgeduarticle/121325.html

http://wap.mail.163.com/xm/static/html/163_3.html

生成mailable类

php artisan make:mail Welcom

创建通知

php artisan make:notification Welcome

发送mailable Email
https://medium.com/q-software/sending-emails-using-laravel-mailable-257c8964243c

https://laracasts.com/discuss/channels/laravel/laravel-53-using-mailable-inside-a-notification

send email in queue

php artisan make:job SendWelcomeJob

https://blog.mailtrap.io/laravel-mail-queue/

https://dev.to/skipperhoa/send-email-using-queue-in-laravel-5-8-48o9

传递html content
https://stackoverflow.com/questions/26139931/laravel-mail-pass-string-instead-of-view


邮件发送问题:
1. 国内国外的邮箱driver选择以及动态切换driver
2. 邮件模板制作
3. 邮件信息收发记录
4. 邮件推送的场景总结【注册成功欢迎， 找回密码，获得奖励？，邀请注册】
5. 邮件是要在管理后台进行手动推送还是有些固定模板进行推送？
6. 针对单个用户进行邮件推送, 针对用户群体进行邮件推送.
7. 邮件发送记录和推送记录是两个概念.

laravel相关问题:
1. 如何在制作定制化view以处理定制化页面需求
2. 如何动态保存不同的邮件模板以供定制化模板邮件推送
数据表设计问题:
【邮件模块】对应的邮件发送记录表和推送记录表需要相应地调整, 【需求上】 邮件推送是针对单个用户进行推送还是对用户群体进行推送? 邮件发送记录和推送记录.
【积分模块】积分管理部分的积分管理规则表和积分奖励表也需要进行调整, 【需求上】 积分表中某个用户的积分记录的交互逻辑.
【评论模块】评论处后台管理功能需要进一步明确，【需求上】按照单一评论进行审核的目的是什么，是不是需要按照某个主题，问题，之类的粒度进行管理.

## 邮件发送配置证书

php 7.3 以上版本，laravel 发送邮件错误：stream_socket_client()
错误信息：

Swift_TransportException

Connection could not be established with host smtp.126.com :stream_socket_client(): SSL operation failed with code 1. OpenSSL Error messages: error:1416F086:SSL routines:tls_process_server_certificate:certificate verify failed
 
错误原因：php openssl 没有加载 ca 证书 , 下载个 ca 证书 配置下php.ini 即可
解决步骤：
1.进入自己安装的php目录的

2.下载ca证书：wget http://curl.haxx.se/ca/cacert.pem 或者 直接下载：http://curl.haxx.se/ca/cacert.pem

3.编辑 php.ini：vim php.ini

4.找到openssl.cafile配置项，修改为openssl.cafile=/usr/local/php/etc/cacert.pem

   该路径是步骤2下载的cacert.pem目录

https://www.cnblogs.com/cocoqi/p/12426893.html

# laravel 修改时间

```php
$grid->column('updated_at')->display(function ($updated_at) {
    return // format $updated_at
});
A better way is to use trait in the model to modify the default format of laravel.

use Encore\Admin\Traits\DefaultDatetimeFormat;

class YorModel extends Model
{
    use DefaultDatetimeFormat;
}

// You can check Date Mutators: https://laravel.com/docs/5.3/eloquent-mutators#date-mutators
// You need set in your User model column from_date in $dates array and then you can change format in $dateFormat
// The another option is also put this method to your User model:

public function getFromDateAttribute($value) {
    return \Carbon\Carbon::parse($value)->format('d-m-Y');
}
```

https://github.com/z-song/laravel-admin/issues/4903

https://stackoverflow.com/questions/40038521/change-the-date-format-in-laravel-view-page


# trait 含义

```php
<?php
class Base {
    public function sayHello() {
        echo 'Hello ';
    }
}

trait SayWorld {
    public function sayHello() {
        parent::sayHello();
        echo 'World!';
    }
}

class MyHelloWorld extends Base {
    use SayWorld;
}

$o = new MyHelloWorld();
$o->sayHello();
?>
```


# 将checkbox处理为字符串

https://blog.csdn.net/hfut_wowo/article/details/88071333

https://www.programmersought.com/article/61476033491/

## 表格修改 验证

rules 表格验证

https://laravel-news.com/laravel-validation-101-controllers-form-requests-and-rules

https://laravel-admin.org/docs/zh/1.x/model-form-validation
https://laravel-admin.org/docs/zh/1.x/model-form-callback

## 定制action列

https://laravel-admin.org/docs/en/model-grid-custom-actions#row-action

批量修改column的actions列表示增删改查

https://github.com/z-song/laravel-admin/issues/431


# 自定義 view

php artisan vendor:publish --tag=public --force

在`resource/views`定义`jsdu.blade.php`前端界面, 在界面里使用view("jsdu")进行使用. 针对`laravel-admin`使用`bootstrap.php`加载js


https://github.com/z-song/laravel-admin/issues/943

https://laravel.com/docs/5.4/packages#views

https://learnku.com/docs/laravel/8.x/blade/9377

https://github.com/z-song/laravel-admin/issues/879

分析blade
https://learnku.com/articles/39493

自定义页面

https://github.com/z-song/laravel-admin/issues/2149

https://github.com/z-song/laravel-admin/issues/1686

https://laravel-admin.readthedocs.io/zh_CN/stable/en/content-layout/

https://laravel-admin.readthedocs.io/zh_CN/stable/zh/content-layout/

直接使用vue的组件
https://github.com/z-song/laravel-admin/issues/2692

默认数据源
https://learnku.com/docs/dcat-admin/2.x/data-source/8096

# model 设置默认值类似于 softdeletes

https://stackoverflow.com/questions/39912372/how-to-set-the-default-value-of-an-attribute-on-a-laravel-model

https://learnku.com/articles/4142/on-the-quest-softdeletes-laravel

https://medium.com/@DarkGhostHunter/laravel-are-soft-deletes-really-slow-753c3444602e

使用soft delete

https://stackoverflow.com/questions/22426165/laravel-soft-delete-posts


# 自定义工具

https://laravel-admin.org/docs/en/model-grid-custom-toolss

# 事件响应

https://learnku.com/articles/13515/summary-of-the-usage-of-laravel-event-system

# laravel hook 生命周期

https://stackoverflow.com/questions/14902231/laravel-hook-into-eloquent-pre-and-post-save-for-every-model

https://learnku.com/laravel/t/29612

model的生命周期

```php
对于您的情况，您也可以使用以下方法：

// Put this code in your Article Model

public static function boot() {

    parent::boot();

    static::created(function($article) {
        Event::fire('article.created', $article);
    });

    static::updated(function($article) {
        Event::fire('article.updated', $article);
    });

    static::deleted(function($article) {
        Event::fire('article.deleted', $article);
    });
}
另外，您需要在中注册监听器App\Providers\EventServiceProvider：

protected $listen = [
    'article.created' => [
        'App\Handlers\Events\ArticleEvents@articleCreated',
    ],
    'article.updated' => [
        'App\Handlers\Events\ArticleEvents@articleUpdated',
    ],
    'article.deleted' => [
        'App\Handlers\Events\ArticleEvents@articleDeleted',
    ],
];
还要确保已在App\Handlers\Events文件夹/目录中创建了处理程序以处理该事件。例如，article.created处理程序可能是这样的：

<?php namespace App\Handlers\Events;

use App\Article;
use App\Services\Email\Mailer; // This one I use to email as a service class

class ArticleEvents {

    protected $mailer = null;

    public function __construct(Mailer $mailer)
    {
        $this->mailer = $mailer;
    }

    public function articleCreated(Article $article)
    {
        // Implement mailer or use laravel mailer directly
        $this->mailer->notifyArticleCreated($article);
    }

    // Other Handlers/Methods...
}
```

https://stackoverflow.com/questions/51601102/laravel-eloquent-what-is-lifecycle-of-eloquent-model

https://blog.pusher.com/advanced-laravel-eloquent-usage/

https://www.youtube.com/watch?v=7GUaH6BI_V0&feature=youtu.be

https://laravel-news.com/laravel-model-events-getting-started

https://www.cnblogs.com/jxl1996/p/10339563.html


https://laracasts.com/discuss/channels/eloquent/listen-to-any-saveupdatecreate-event-for-any-model

# laravel with eager loading

https://laravel.com/docs/5.1/eloquent-relationships#eager-loading

https://9iphp.com/web/laravel/laravel-eager-loading-with-specific-columns.html

# laravel 如何构建实时流

https://pusher.com/tutorials/activity-feed-laravel

https://github.com/viraj-khatavkar/activity-feed-pusher

https://github.com/laracasts/Build-An-Activity-Feed-in-Laravel

# laravel 的事件机制

https://learnku.com/articles/37171

https://segmentfault.com/a/1190000014082263

https://segmentfault.com/a/1190000016634974

django 是基于signal的事件机制;  laravel模型上自带事件机制.

https://www.yoseph.tech/python/event-driven-programing-in-django

https://refactoring.guru/design-patterns/observer/python/example

https://www.liujiangblog.com/course/django/170

https://github.com/django/django/blob/c53af5661313079d022553b6c775e6c4f8d34927/django/dispatch/dispatcher.py#L19

https://docs.djangoproject.com/en/3.1/topics/signals/

# 播放视频

https://github.com/laracasts/VideoJS-Events-and-AJAX


# 访问器

https://learnku.com/articles/25109?order_by=vote_count&

# laravel blade
https://stackoverflow.com/questions/43868766/laravel-5-2-showing-a-table-using-a-blade-view

# laravel admin 定制image功能

https://learnku.com/articles/28587


# orm查找的区别 

https://stackoverflow.com/questions/33027047/what-is-the-difference-between-find-findorfail-first-firstorfail-get


# ffmpeg获取视频时长

https://segmentfault.com/a/1190000003804078

https://segmentfault.com/q/1010000004349546

https://github.com/protonemedia/laravel-ffmpeg

# 打印出raw sql

https://www.sunzhongwei.com/print-laravel-eloquent-corresponding-raw-sql-database-query-log

# editor + oss 上传

> wang editor

https://learnku.com/articles/7670/the-use-of-wangeditor-and-laravel-in-multi-image-upload

https://blog.csdn.net/stand_forever/article/details/99543080

https://blog.csdn.net/LJFPHP/article/details/78858797

> ueditor

https://learnku.com/laravel/t/3594/oss-3

> filemanager + oss

https://unisharp.github.io/laravel-filemanager/

https://github.com/iiDestiny/laravel-filesystem-oss

# grpc 和laravel整合

grpc和Protobuf编译器

下表列出了grpc和protobuf版本之间的兼容性：

```md
grpc	protobuf
v1.0.0	3.0.0（GA）
v1.0.1	3.0.2
v1.1.0	3.1.0
v1.2.0	3.2.0
v1.2.0	3.2.0
v1.3.4	3.3.0
v1.3.5	3.2.0
v1.4.0	3.3.0
v1.6.0	3.4.0
```

核心概念介绍

https://grpc.io/docs/what-is-grpc/core-concepts/

## 下载

下载链接 gRPC

https://pecl.php.net/package/grpc

https://pecl.php.net/package/protobuf

https://stackoverflow.com/questions/61119784/how-to-use-grpc-from-php-and-windows-10-with-the-grpc-php-plugin

https://github.com/aaapi-net/protoc-windows-gen-plugins

https://learnku.com/articles/36277

Protocol Buffers v3.15.6

https://github.com/protocolbuffers/protobuf/releases


https://cloud.google.com/php/grpc?hl=zh-cn#windows


https://anakinsun.com/post/php-laravel-grpc/

https://juejin.cn/post/6844903957190426638

https://grpc.io/docs/languages/php/basics/

# redis geo add

https://learnku.com/articles/9273/developing-simple-nearby-dynamic-functions-using-laravel


php redis 扩展

sudo apt-get install php-redis

https://pecl.php.net/package/redis

https://www.xiabingbao.com/php/2017/08/27/window-php-redis.html

https://stackoverflow.com/questions/25230399/fatal-error-class-redis-not-found/51582912

# 认证

https://laravelacademy.org/post/21991

 Laravel Jetstream 

https://learnku.com/laravel/t/49799

https://www.jianshu.com/p/c6bde998b87b

# laravel should queue

https://stackoverflow.com/questions/48370140/laravel-shouldqueue-how-does-it-work

https://learnku.com/articles/20712

https://learnku.com/docs/laravel/8.x/queues/9398#generating-job-classes

https://learnku.com/articles/53037

异步任务调用

http://kailian.github.io/2019/04/14/laravel-job


# `queue:work` 和 `queue:listen` 的区别

三种情况:
queue:work 默认只执行一次队列请求，当请求执行完成后就终止；
queue:listen 监听队列请求，只要运行着，就能一直接受请求，除非手动终止；
queue:work --daemon 同 listen 一样，只要运行着，就能一直接受请求，不一样的地方是在这个运行模式下，当新的请求到来的时候，不重新加载整个框架 , 而是直接 fire 动作.
能看出来，queue:work --daemon 是最高级的，一般推荐使用这个来处理队列监听.


https://keer.me/laravel-queuework-queuelisten-diff.html

https://kb.kaifa99.com/others/post_12937410

https://learnku.com/laravel/t/325/the-difference-between-queuelisten-and-queuework-daemon

https://swoole.app/2017/08/11/laravel%E9%98%9F%E5%88%97%E4%BD%BF%E7%94%A8%E6%B3%A8%E6%84%8F%E9%97%AE%E9%A2%98/

队列分发源码分析

https://learnku.com/articles/7037/laravel-queue-analysis-of-message-queue-tasks-and-distribution-source-code