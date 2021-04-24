# laravel

https://learnku.com/docs/laravel/5.5

https://learnku.com/docs/laravel-kernel/preface/6943

API

https://laravel.com/api/8.x/Illuminate/Database/Eloquent/SoftDeletes.html

# laracasts

https://laracasts.com/

https://learnku.com/articles/22175


```sh
yum install php-mbstring -y

# Install or enable PHP's pdo extension.
yum install php-xml -y

php -r "echo phpinfo();"

# Install or enable PHP's pdo extension.

composer search laravel
composer global require laravel/laravel -vvv
# 添加Telescope调试工具 若是本地就需要加上--dev
composer require laravel/telescope
php artisan telescope:install
php artisan migrate

# 反向生成models
php artisan code:models

# 绑定模型的CURD
php artisan make:controller NewsController --resource --model=CmsNews

# 启动服务
php artisan serve

# 发布

# 视频播放
php artisan vendor:publish --tag=laravel-admin-media-player

php artisan vendor:publish --provider="Encore\Admin\AdminServiceProvider"
# 视频解析
php artisan vendor:publish --provider="ProtoneMedia\LaravelFFMpeg\Support\ServiceProvider"

# summernot text
php artisan vendor:publish --provider='Overtrue\LaravelSummernote\SummernoteServiceProvider'

composer require jxlwqq/quill
php artisan vendor:publish --tag=laravel-admin-quill

# sudo apt install ffmpeg
# wang editor发布 TODO:

# 
# 生成路由权限列表
php artisan admin:permissions

# publish 资源
php artisan admin:publish

php artisan admin:controller App\Models\CmsNews
php artisan admin:controller App\Models\CmsBoard
php artisan admin:controller App\Models\CmsBanner
php artisan admin:controller App\Models\UserEmailRecord
```

# laravel 请求生命周期

https://learnku.com/docs/laravel/5.5/lifecycle/1288

# laravel 的event事件机制

https://learnku.com/articles/20712

https://learnku.com/articles/6657/model-events-and-observer-in-laravel

https://learnku.com/articles/5465/event-realization-principle-of-laravel-model

# 深入laravel核心

https://learnku.com/docs/laravel-core-concept/5.5/laravel/3018

# 项目教程

https://codecasts.com/

https://geixue.com/

https://learnku.com/laravel/courses

https://learnku.com/docs/laravel/8.x/installation/9354


# 语法

```php
// 路由方法
Route::get($uri, $callback);
Route::post($uri, $callback);
Route::put($uri, $callback);
Route::patch($uri, $callback);
Route::delete($uri, $callback);
Route::options($uri, $callback);

Route::match(['get', 'post'], '/', function () {
    //
});

Route::get('posts/{post}/comments/{comment}', function ($postId, $commentId) {
    //
});


// 限流器
use Illuminate\Cache\RateLimiting\Limit;
use Illuminate\Support\Facades\RateLimiter;

RateLimiter::for('global', function (Request $request) {
    return Limit::perMinute(1000);
});

// 访问当前路由
$route = Route::current();
$name = Route::currentRouteName();
$action = Route::currentRouteAction();
```

路由方法:
https://learnku.com/docs/laravel/8.x/routing/9365


## 控制器

Laravel 的资源路由通过单行代码即可将典型的「CURD (增删改查)」路由分配给控制器。例如，你希望创建一个控制器来处理保存 "照片" 应用的所有 HTTP 请求。

```php
/* 
php artisan make:controller NewsController --resource


会自动生成CURD方法

获取request请求
*/

namespace App\Http\Controllers;

use Illuminate\Http\Request;

class UserController extends Controller
{
    /**
     * 更新指定的用户
     *
     * @param  Request  $request
     * @param  string  $id
     * @return Response
     */
    public function update(Request $request, $id)
    {
        //
    }
}

$url = $request->url();
$method = $request->method();
$input = $request->all();
$name = $request->query("name");

```

# model添加custom function

类似于django的model的property function

```php
class Company extends Model
{
    protected $table = 'companies';

    // get detail by id
    static function detail($id)
    {
        return self::find($id)->toArray();
    }

    // get list by condition
    static function list($name = '')
    {
        if ( !empty($name) ) return self::where('name', 'LIKE', $name)->get()->toArray();
        else return self::all()->toArray();
    }
}
```
https://stackoverflow.com/questions/37692482/laravel-how-to-add-a-custom-function-in-an-eloquent-model

## model 处理

默认情况下，Eloquent 预期你的数据表中存在 created_at 和 updated_at 两个字段 。如果你不想让 Eloquent 自动管理这两个列， 请将模型中的 $timestamps 属性设置为 false

在使用之前，你需要在模型上指定 fillable 或 guarded 属性，因为所有的 Eloquent 模型都默认不可进行批量赋值。

事件触发

Eloquent 模型触发几个事件，允许你挂接到模型生命周期的如下节点： retrieved、creating、created、updating、updated、saving、saved、deleting、deleted、restoring 和 restored。事件允许你每当特定模型保存或更新数据库时执行代码。每个事件通过其构造器接受模型实例。

retrieved 事件在现有模型从数据库中查找数据时触发。当新模型每一次保存时，creating 和 created 事件被触发。如果数据库中已经存在模型并且调用了 save 方法，updating / updated 事件被触发。这些情况下，saving / saved 事件也被触发。

```php
namespace App\Models;

use App\Events\UserDeleted;
use App\Events\UserSaved;
use Illuminate\Foundation\Auth\User as Authenticatable;

class User extends Authenticatable
{
    use Notifiable;

    /**
     * 模型的事件映射
     *
     * @var array
     */
    protected $dispatchesEvents = [
        'saved' => UserSaved::class,
        'deleted' => UserDeleted::class,
    ];
}
```
## model上的观察者

如果在一个模型上监听了多个事件，可以使用观察者来将这些监听器组织到一个单独的类中。观察者类的方法名映射到你希望监听的 Eloquent 事件。 这些方法都以模型作为其唯一参数。make:observer Artisan 命令可以快速建立新的观察者类：

```php
php artisan make:observer UserObserver --model=User
```

https://learnku.com/docs/laravel/8.x/eloquent/9406#defining-models

## 使用日志

```php
namespace App\Http\Controllers;

use App\Http\Controllers\Controller;
use App\Models\User;
use Illuminate\Support\Facades\Log;

class UserController extends Controller
{
    /**
     * 显示给定用户的配置信息
     *
     * @param  int  $id
     * @return Response
     */
    public function showProfile($id)
    {
        Log::info('Showing user profile for user: '.$id);

        return view('user.profile', ['user' => User::findOrFail($id)]);
    }
}
```

# 添加menu
Open http://localhost:8000/admin/auth/menu, add menu link and refresh the page, then you can find a link item in left menu bar.

Where uri fills in the path part that does not contain the prefix of the route, such as the full path http://localhost:8000/admin/demo/users, just input demo/users, If you want to add an external link, just fill in the full url, such as http://laravel-admin.org/.


http://localhost:8000/admin/auth/menu

# 调整登录

https://laravel-admin.org/posts/30

## Http请求库

https://learnku.com/docs/laravel/8.x/http-client/9394

## 发送邮件


```sh
php artisan make:mail OrderShipped --markdown=emails.orders.shipped
```
可以生成markdown格式的邮件.

https://learnku.com/docs/laravel/8.x/mail/9395


# 扩展包
时间处理扩展包 Carbon 
或者是提供完整 BDD 测试框架的扩展包 Behat。

# 数据库

```php
// 数据库配置文件
config/databases.php

// 数据库查询
namespace App\Http\Controllers;

use App\Htpp\Controllers\Controller;
use Illuminate\Support\Facades\DB;

class UserController extends Controller
{
    public function index()
    {
        $user = DB::select('select * from users where active = ?', [1]);
        DB::insert('insert into users (id, name) values (?,?)', [1, 'Dayle']);

        $affected = DB::update('update users set votes = 100 where name = ?', ['John'])

        return view('user.index', ['users' => $users]);
    }
}
```

https://learnku.com/docs/laravel/8.x/database/9400

## Eloquent ORM

https://learnku.com/docs/laravel/8.x/eloquent-collections/9408

## 插入带外键的关系

```php
// Get the video of the comment relation
$video = Video::find(Input::get('video_id')) ;

// Use the associate method to include
// the id of the others model
$comment = new Comment;
$comment->content = 'content';
$comment->user()->associate(Auth::user());
$comment->video()->associate($video);
$comment->save();
```

https://stackoverflow.com/questions/22884898/insert-laravel-model-with-multiple-foreign-keys

https://stackoverflow.com/questions/47647492/how-to-select-foreign-key-value-in-laravel

Laravel-admin 选取外键列

```php

$grid->column('board_id', __('模块'))->display(function($boardId) {
    return CmsBoard::find($boardId)->title;
});

// 外键选类别
$form->select('board_id')->options(CmsBoard::all()->pluck('title', 'id'));
```

https://github.com/z-song/laravel-admin/blob/6c5e47bcd73c8a85c3e747beadc55ee0ac630e6e/src/Grid/Column.php


## UUID

https://learnku.com/laravel/t/2538/extended-recommendation-laravel-uuid-universal-unique-identifier

https://zhuanlan.zhihu.com/p/149228467

https://medium.com/binary-cabin/automatically-generating-a-uuid-on-your-laravel-models-b8b9c3599e2b


https://nova.moe/laravel-use-uuid-as-primary-key-with-custom-authentication-fields/

composer require ramsey/uuid

https://learnku.com/articles/22688

https://gist.github.com/ratiw/f528c13a8c69c06d9cfd

https://packagist.org/packages/dyrynda/laravel-model-uuid

https://www.larablocks.com/package/dyrynda/laravel-model-uuid


## 调试工具

```sh
# 配置文件位于`config/telescope.php`
'enabled' => env('TELESCOPE_ENABLED', true),
```

https://learnku.com/docs/laravel/8.x/telescope/9424

http://xdebug.org/

https://segmentfault.com/a/1190000011332021

https://learnku.com/articles/5281/php-debug-visual-studio-code-debugging-plug-in

https://www.zhihu.com/question/20348619


## 代码生成器

scaffold-interface

https://learnku.com/docs/laravel-specification/7.x/code-generator/7612

https://labs.infyom.com/laravelgenerator/


## 外部库资源

https://packagist.org/packages/reliese/laravel

https://ecosystem.laravel.io/

https://learnku.com/articles/40507

https://asmcn.icopy.site/awesome/awesome-laravel/

# 速查表

https://learnku.com/docs/laravel-cheatsheet/8.x

https://learnku.com/laravel/t/38446

# 项目

https://github.com/chiraggude/awesome-laravel

https://github.com/jxlwqq/awesome-laravel-admin

https://github.com/z-song/demo.laravel-admin.org

https://www.akveo.com/blog/20-best-free-laravel-admin-templates-2020-and-premium

https://learnku.com/articles/39723


# laravel 处理配置

```php
// 简单数组
MY_ARRAY_VALUE=1,2,HOUSE,CAT
explode(',', env('MY_ARRAY_VALUE'));
// 多维数组
SETTING={"k1":"v1", "k2":"v2"}
(array)json_decode(env('SETTING'));


// 读取配置信息 在Tinker
echo config('app.timezone');

// 获取环境变量
env('APP_DEBUG')
getenv('APP_DEBUG')
$_ENV['APP_DEBUG']
$_SERVER['APP_DEBUG']
```


https://learnku.com/laravel/wikis/25999


# Laradock

laradock使用phpstorm debug代码
https://learnku.com/articles/24389

https://segmentfault.com/a/1190000015862008

https://learnku.com/articles/16233/laradock-deployment-larabbs

https://learnku.com/articles/4838/deploy-the-laravel-or-notadd-environment-using-laradock-10-minutes

# 隐藏某些具体列

https://stackoverflow.com/questions/23612221/how-to-exclude-certains-columns-while-using-eloquent/43885078

# 修改laravel admin数据来源

https://www.cc430.cn/index.php/archives/695/

# laravel service provider 概念

Service Providers (服务提供者) 是 Laravel 「引导」过程的核心。这个「引导」过程可以理解成「电脑从按下开机按钮到完全进入桌面」这段时间系统干的事。

https://learnku.com/articles/6189/laravel-service-provider-detailed-concept