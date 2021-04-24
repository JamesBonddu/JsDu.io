```php
<?php
// 数组
$array = array(
    "foo" => "bar",
    42    => 24,
    "multi" => array(
         "dimensional" => array(
             "array" => "foo"
         )
    )
);
var_dump($array)
var_dump($array[42])
var_dump($array["multi"]["dimensional"]["array"])

// object
class foo
{
    function do_foo()
    {
        echo "Doing foo.";
    }
}

$bar = new foo;
$bar->do_foo();
$obj = (object) array('1' => 'foo');
var_dump(key($obj)); // 'string(1)'

// foreach

function foo(iterable $iterable) {
    foreach ($iterable as $value) {
        // ...
    } 
}

?>
```

# callback

PHP是将函数以string形式传递的。 可以使用任何内置或用户自定义函数，但除了语言结构例如：array()，echo，empty()，eval()，exit()，isset()，list()，print 或 unset()。

一个已实例化的 object 的方法被作为 array 传递，下标 0 包含该 object，下标 1 包含方法名。 在同一个类里可以访问 protected 和 private 方法。

静态类方法也可不经实例化该类的对象而传递，只要在下标 0 中包含类名而不是对象。自 PHP 5.2.3 起，也可以传递 'ClassName::methodName'。


# 函数

```php
<?php
function sum(...$numbers) 
{
    $acc = 0;
    foreach ($numbers as $n)
    {
        $acc += $n;
    }
    return $acc;
}

echo sum(1, 2, 3, 4);
echo sum(...[1,2,3,4]);
?>
```

# 类与对象

PHP 5 中的新特性包括访问控制，抽象类和 final 类与方法，附加的魔术方法，接口，对象复制和类型约束。

# 命名空间

https://www.php.net/manual/zh/language.namespaces.rationale.php


# php 工具

php study

https://www.xp.cn/download.html

php myadmin

https://www.phpmyadmin.net/downloads/


# xdebug 插件安装需要注意


VC版本和TS版本
PHP7.3版本

https://www.kres.cn/27.html

https://xdebug.org/download

http://www.nowamagic.net/librarys/veda/detail/2333

https://blog.csdn.net/zeng133/article/details/83820890

调试插件历史版本

https://xdebug.org/download/historical

# 更新

https://stackoverflow.com/questions/38843202/what-is-different-between-save-create-function-in-laravel-5

https://stackoverflow.com/questions/27175551/laravel-modelcreate-or-model-save

# 查找

```php
find()
findOrFail()
first()
firstOrFail()
get()
list()
toArray()
```

https://stackoverflow.com/questions/33027047/what-is-the-difference-between-find-findorfail-first-firstorfail-get

# PHP内核

https://www.php.net/manual/zh/internals2.ze1.zendapi.php


# error

```sh
  [InvalidArgumentException]
  Package hirak/prestissimo has a PHP requirement incompatible with your PHP version, PHP extensions and Composer ver
  sion
```

https://stackoverflow.com/questions/48004979/how-to-use-the-respective-php-version-name-prior-to-composer

# 书籍

现代PHP新特性
https://xueyuanjun.com/books/modern-php

https://linux.cn/article-10870-1.html

# 基础语法

## 字符串相加


This is because PHP uses the period character . for string concatenation, not the plus character +. Therefore to append to a string you want to use the .= operator:

https://stackoverflow.com/questions/9050685/can-you-append-strings-to-variables-in-php

## php发送请求的方式

https://learnku.com/articles/5396/how-many-ways-does-php-send-http-requests

https://stackoverflow.com/questions/5647461/how-do-i-send-a-post-request-with-php

https://www.wangyd.com/post/62

# foreach array_chunk
https://stackoverflow.com/questions/12448199/foreach-with-array-chunk-in-php-and-with-multiple-arrays

# php string contains 

```php
$a = 'How are you?';

if (strpos($a, 'are') !== false) {
    echo 'true';
}
```

https://stackoverflow.com/questions/4366730/how-do-i-check-if-a-string-contains-a-specific-word

# php install extensions

```sh
sudo apt install openssl php-common php-curl php-json php-mbstring php-mysql php-xml php-zip
```

https://stackoverflow.com/questions/40815984/how-to-install-all-required-php-extensions-for-laravel


# php

https://shockerli.net/post/php-awesome/


https://www.twle.cn/c/yufei/phpmmethod/phpmmethod-basic-construct.html