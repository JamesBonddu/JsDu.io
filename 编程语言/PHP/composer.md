# composer

命令行

https://docs.phpcomposer.com/03-cli.html

安装

https://docs.phpcomposer.com/00-intro.html#Globally

https://pkg.phpcomposer.com/#how-to-install-composer

https://getcomposer.org/

https://blog.csdn.net/a1513049385/article/details/106214566/

设置镜像

https://pkg.phpcomposer.com/

```sh
php /usr/bin/composer.phar  config -g repo.packagist composer https://packagist.phpcomposer.com
```

# php7.3

https://blog.csdn.net/weixin_43992370/article/details/105879173

https://www.cnblogs.com/btsn/p/11244887.html

# 包管理工具的区别

pear
pecl
composer

https://segmentfault.com/a/1190000014714360


# 反向生成模型

Warning, you may end up overwriting your JetStream or any other scaffolding models. take backup of them before overwriting them.

If you are using MySQL and Laravel 5.1 or above you can use php artisan code:models from this package: reliese/laravel. All you need to do is:

> composer require reliese/laravel
Add the service provider to your config/app.php file Reliese\Coders\CodersServiceProvider::class
Publish the config file with
> php artisan vendor:publish --tag=reliese-models
Make sure your database is correctly configured in config/database.php and .env files.
And finally issue the command:
> php artisan code:models



https://stackoverflow.com/questions/30560485/create-models-from-database-in-laravel-5

https://www.wj0511.com/site/detail.html?id=203

https://learnku.com/laravel/t/2862/laravel-generates-a-model-model-file-from-an-existing-database-table


# phpstorm

https://confluence.jetbrains.com/display/PhpStorm/Previous+PhpStorm+Releases