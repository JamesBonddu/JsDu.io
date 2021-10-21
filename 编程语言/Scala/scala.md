# Scala

Scala 是一种现代多范式编程语言，旨在以简洁、优雅和类型安全的方式表达常见的编程模式。它无缝集成了面向对象和函数式语言的特性。

https://docs.scala-lang.org/getting-started/index.html

https://www.scala-lang.org/

https://github.com/lauris/awesome-scala

https://docs.scala-lang.org/tour/tour-of-scala.html

# scala 练习网站

https://www.scala-exercises.org/

# 安装
除了管理 JVM，它还安装了有用的命令行工具： Ammonite、 coursier、scala（Scala REPL 和脚本运行程序）、scalac（Scala 编译器）、 sbt和 scalafmt。

https://docs.scala-lang.org/getting-started/index.html#next-steps

sbt 安装

```sh
root@iZuf6dazrfkcp2hvovep4iZ:/data/mlsqlstack/mlsql-api-console/src/main/java/tech/mlsql# sbt
downloading sbt launcher 1.5.4

copying runtime jar...
[info] [launcher] getting org.scala-sbt sbt 1.5.4  (this may take some time)...



[info] [launcher] getting Scala 2.12.14 (for sbt)...
[info] Updated file /data/mlsqlstack/mlsql-api-console/src/main/java/tech/mlsql/project/build.properties: set sbt.version to 1.5.4
[info] welcome to sbt 1.5.4 (Ubuntu Java 11.0.11)
[info] loading project definition from /data/mlsqlstack/mlsql-api-console/src/main/java/tech/mlsql/project
[info] Updating 
https://repo1.maven.org/maven2/jline/jline/2.14.6/jline-2.14.6.pom
  100.0% [##########] 19.4 KiB (66.5 KiB / s)
https://repo1.maven.org/maven2/org/fusesource/jansi/jansi/1.12/jansi-1.12.pom
  100.0% [##########] 3.6 KiB (4.4 KiB / s)
https://repo1.maven.org/maven2/org/fusesource/jansi/jansi-project/1.12/jansi-project-1.12.pom
  100.0% [##########] 11.5 KiB (19.7 KiB / s)
https://repo1.maven.org/maven2/org/fusesource/fusesource-pom/1.11/fusesource-pom-1.11.pom
  100.0% [##########] 14.2 KiB (50.5 KiB / s)
[info] Resolved  dependencies
[info] Fetching artifacts of 
https://repo1.maven.org/maven2/jline/jline/2.14.6/jline-2.14.6.jar
  100.0% [##########] 262.5 KiB (1.0 MiB / s)
[info] Fetched artifacts of 
[info] set current project to mlsql (in build file:/data/mlsqlstack/mlsql-api-console/src/main/java/tech/mlsql/)
[info] sbt server started at local:///root/.sbt/1.0/server/e6d45626543f36fc4109/sock
[info] started sbt server
sbt:mlsql> 
sbt:mlsql> 
sbt:mlsql> 
sbt:mlsql> 
sbt:mlsql> 
```

https://stackoverflow.com/questions/13711395/install-sbt-on-ubuntu

https://www.scala-sbt.org/1.x/docs/zh-cn/Installing-sbt-on-Linux.html

https://www.scala-sbt.org/1.x/docs/zh-cn/Getting-Started.html

# scala框架

https://www.infoq.cn/article/scala-technology

# quill 

Quill 提供了一种引用域特定语言 ( QDSL ) 来在 Scala 中表达查询并以目标语言执行它们。该库的核心旨在支持多种目标语言，目前以结构化查询语言 ( SQL ) 和 Cassandra 查询语言 ( CQL ) 为特色。

https://github.com/getquill/quill

https://getquill.io/


# 语法

https://www.runoob.com/scala/scala-tutorial.html

包导入

https://docs.scala-lang.org/zh-cn/tour/packages-and-imports.html

## scala 使用Option、Some、None，避免使用null

https://blog.csdn.net/JasonDing1354/article/details/46788787

https://www.runoob.com/scala/scala-options.html

## scala和java容器的转换

你可能想要像访问Scala容器一样访问某个Java容器，或者你可能想将一个Scala容器像Java容器一样传递给某个Java方法。在Scala中，这是很容易的，因为Scala提供了大量的方法来隐式转换所有主要的Java和Scala容器类型。其中提供了如下的双向类型转换：

```sh
Iterator               <=>     java.util.Iterator
Iterator               <=>     java.util.Enumeration
Iterable               <=>     java.lang.Iterable
Iterable               <=>     java.util.Collection
mutable.Buffer         <=>     java.util.List
mutable.Set            <=>     java.util.Set
mutable.Map            <=>     java.util.Map
mutable.ConcurrentMap  <=>     java.util.concurrent.ConcurrentMap
```

https://docs.scala-lang.org/zh-cn/overviews/collections/conversions-between-java-and-scala-collections.html

https://blog.csdn.net/u013256816/article/details/80057661

## scala中下划线的用法 _

https://www.baeldung.com/scala/underscore

https://github.com/Baeldung/scala-tutorials

## Scala的BeanProperty注解

封装：属性私有，提供共有的set/get方法
scala中提供了一个注解@BeanProperty 能够自动生成java的get/set方法.

scala中可以使用java的API，java的很多API都要求有 get/set方法，scala为了兼容java提供了@BeanProperty.
@BeanProperty注解不能用于private修饰的属性上

   

https://blog.csdn.net/weixin_42796403/article/details/111227575


# scala map转换



https://stackoverflow.com/questions/25635803/difference-between-mapvalues-and-transform-in-map

# scala map和mapValues

https://blog.bruchez.name/posts/mapmap-vs-mapmapvalues/


# Scala 的 groupBy 身份如何工作？

"aaabbbccccdd"

val list = str.groupBy(identity).toList.sortBy(_._1).map(_._2)
让我们逐项逐项进行。第一个是 groupBy，它将使用鉴别器函数传递的键列表对您的字符串进行分区，在您的情况下是身份。鉴别器函数将应用于屏幕中的每个字符，所有返回相同结果的字符将被组合在一起。如果我们想将字母 a 与其他字母分开，我们可以将其x => x == 'a'用作我们的鉴别器函数。这会将您的字符串字符分组到映射中此函数的返回值（真或假）中：

 Map(false -> bbbccccdd, true -> aaa)
通过使用identity，这是一种“不错”的说法x => x，我们得到了一个地图，其中每个字符在地图中被分开，在您的情况下：

Map(c -> cccc, a -> aaa, d -> dd, b -> bbb)
然后，我们在地图转换成一个元组列表(char,String) 与toList。

按字符排序，sortBy并保留字符串以map获得最终结果。

https://stackoverflow.com/questions/19165977/how-does-scalas-groupby-identity-work

# scala 数据类型

数据类型|	描述
-|-
Byte	8位有符号补码整数。|数值区间为 -128 到 127
Short	16位有符号补码整数。|数值区间为 -32768 到 32767
Int	32位有符号补码整数。|数值区间为 -2147483648 到 2147483647
Long	64位有符号补码整数。|数值区间为 -9223372036854775808 到 9223372036854775807
Float	32 位| IEEE 754 标准的单精度浮点数
Double	64 位| IEEE 754 标准的双精度浮点数
Char	16位无符号Unicode字符| 区间值为 U+0000 到 U+FFFF
String	|字符序列
Boolean	|true或false
Unit	|表示无值，和其他语言中void等同。用作不返回任何结果的方法的结果类型。Unit只有一个实例值，写成()。
Null	|null 或空引用
Nothing	|Nothing类型在Scala的类层级的最底端；它是任何其他类型的子类型。
Any	|Any是所有其他类的超类
AnyRef	|AnyRef类是Scala里所有引用类(reference class)的基类

# scala for 循环

```scala
// i to j 
var a = 0;
for( a <- 1 to 10){
  println("Value of a: " + a);
}

// until 循环
for( a <- 1 until 10){
  println("Value of a: " + a);
}

// 循环集合
val numList = List(1,2,3,4,5,6,7,8,9,10);
for( a <- numList ){
  println("Value of a: " + a);
}

// 在循环中进行过滤
/*
for( var x <- List
      if condition1; if condition2...
   ){
   statement(s);
}
*/
for( a <- umList if a != 3; if a < 4){
  println("Value of a: " + a);
}
```

# scala 方法与函数

Scala 有方法与函数，二者在语义上的区别很小。Scala 方法是类的一部分，而函数是一个对象可以赋值给一个变量。换句话来说在类中定义的函数即是方法。

Scala 中的方法跟 Java 的类似，方法是组成类的一部分。

Scala 中的函数则是一个完整的对象，Scala 中的函数其实就是继承了 Trait 的类的对象。

Scala 中使用 val 语句可以定义函数，def 语句定义方法。

```scala
def functionName ([参数列表]) : [return type] = {
   function body
   return [expr]
}
```

