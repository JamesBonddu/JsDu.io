# laravel 核心

## 控制反转, 依赖注入

只需要通过构造函数参数传递就可以实现, 其实这就是"控制反转". 不需要自己内容修改, 改成由外部传递. 这种由外部负责其依赖需求的行为, 我们可以称其为控制反转Ioc.



https://learnku.com/docs/laravel-core-concept/5.5/

# laravel model

https://learnku.com/articles/6356/laravel-eloquent-usage

# 技术选型

敏感词过滤
https://github.com/FireLustre/php-dfa-sensitive
https://packagist.org/packages/lustre/php-dfa-sensitive

validate rule验证

https://learnku.com/articles/39289

# laravel pbkdf2 密碼加密

https://laraveldeve.blogspot.com/2017/09/pbkdf2-sha-256-in-laravel.html

https://stackoverflow.com/questions/39310898/django-password-in-php

laravel 的APP_KEY

https://learnku.com/laravel/t/41250


https://www.shuzhiduo.com/A/ke5j2G0X5r/

# laravel源码解读

https://www.jianshu.com/p/b7ea3f2a55f6


社交名媛

https://github.com/laravel/socialite

dacat admin

http://dcatadmin.com/docs/2.x/introduction.html


# laravel oss 

https://segmentfault.com/a/1190000018384162

https://developer.aliyun.com/article/649902

https://packagist.org/packages/jacobcyl/ali-oss-storage

设置上传options为public

https://help.aliyun.com/document_detail/88473.html?spm=a2c4g.11186623.6.1258.3cd97a74d6dIej


# 权限控制

https://learnku.com/articles/5662/two-great-laravel-rights-management-packages-recommended

# laravel EasySms 短信

https://github.com/overtrue/easy-sms

https://github.com/yl/easysms-notification-channel

# 修改admin_user的最佳方式

```md
At first create a migration to add new column to existing table by run artisan command:

php artisan make:migration add_email_to_admin_users
Open this migration file under database/migrations and add:

public function up()
{
    Schema::table('admin_users', function($table) {
        $table->string('email');
    });
}

public function down()
{
    Schema::table('admin_users', function($table) {
        $table->dropColumn('email');
    });
}
Then you can run your migrations:

php artisan migrate
So the email column is added to the admin_user table.

Next, you may want to add an email field to the form in users page. It is best not to modify the files in the vendor directory. The best way is to create a controller and a route to override the original users route.

Create app/Admin/Controllers/CustomUserController.php :

<?php

namespace App\Admin\Controllers;

use Encore\Admin\Controllers\UserController;

class CustomUserController extends UserController
{
    public function grid()
    {
        //...
        $grid->id('ID')->sortable();
        $grid->username(trans('admin.username'));
        $grid->name(trans('admin.name'));
        $grid->email('Email');
        //...
    }

    public function form()
    {
        //...
        $form->display('id', 'ID');
        $form->text('username', trans( 'admin.username'))->rules('required');
        $form->text('name', trans( 'admin.name' ) )->rules('required');
        $form->text('email', 'Email')->rules('required|email|unique:admin_users.email');
        //...
    }
}
And override the builtin users routes in app/Admin/routes.php:

Admin::registerAuthRoutes();

// you should put this after `Admin::registerAuthRoutes();`
Route::resource('admin/auth/users', \App\Admin\Controllers\CustomUserController::class)->middleware(config('admin.route.middleware'));
Open users page and you can find the grid and form are changed


```

https://github.com/z-song/laravel-admin/issues/1739

https://github.com/z-song/laravel-admin/issues/1724

# select 表单联动的方式

https://learnku.com/articles/39996

# laravel 设置端口
```sh
php artisan serve --host=0.0.0.0 --port=8000
```
https://stackoverflow.com/questions/17990820/set-port-for-php-artisan-php-serve

# laravel nginx 配置

https://learnku.com/articles/25861

https://learnku.com/articles/43290

# laravel 自动加载机制

https://learnku.com/articles/42458

https://segmentfault.com/a/1190000014948542

http://reader.epubee.com/books/mobile/e9/e9cce853fcf7945394698043673e5902/text00007.html

# laravel filemanager

https://github.com/UniSharp/laravel-filemanager-example-5.3

# Tinymce富文本编辑器 ...

https://github.com/Qsnh/meedus

# 设置禁用

```php
use Encore\Admin\Grid;

Grid::init(function (Grid $grid) {

    $grid->disableActions();

    $grid->disablePagination();

    $grid->disableCreateButton();

    $grid->disableFilter();

    $grid->disableRowSelector();

    $grid->disableColumnSelector();

    $grid->disableTools();

    $grid->disableExport();

    $grid->actions(function (Grid\Displayers\Actions $actions) {
        $actions->disableView();
        $actions->disableEdit();
        $actions->disableDelete();
    });
});
```