# groovy方法

Groovy 是 用于Java虚拟机的一种敏捷的动态语言，它是一种成熟的面向对象编程语言，既可以用于面向对象编程，又可以用作纯粹的脚本语言。使用该种语言不必编写过多的代码，同时又具有闭包和动态语言中的其他特性。

https://blog.csdn.net/a906998248/article/details/46444967

https://www.w3cschool.cn/groovy/groovy_overview.html

http://cndoc.github.io/groovy-doc-cn/


# groovy实战

https://wizardforcel.gitbooks.io/ibm-j-pg/content/6.html

http://docs.groovy-lang.org/docs/latest/html/documentation/core-domain-specific-languages.html

https://developer.aliyun.com/article/2357

## groovy dsl

https://lesofn.com/archives/shi-yong-groovy-gou-jian-dsl

## scala和groovy的区别

它们都是JVM的面向对象语言，具有lambda和闭包，并与Java进行互操作。除此之外，他们是非常不同的。

Groovy是一种“动态”语言，它不仅是动态类型的，而且支持动态元编程。

Scala是一种“静态”语言，因为它是静态类型化的，除了在Java中所能做的笨拙工作之外，实际上没有动态元编程。注意，Scala的静态类型系统实际上比Java更加统一和复杂。

Groovy在语法上受到Java的影响，但语义上更受Ruby等语言的影响。

Scala在语法上受到Ruby和Java的影响。它在语义上更受Java、SML、Haskell和一种叫做gBeta的非常模糊的OO语言的影响。

Groovy由于处理Java重载的方式而具有“意外”的多重调度。

Scala是单次调度，但有SML启发的模式匹配来处理多个调度所要处理的一些问题。然而，如果多个分派只能在运行时类型上进行调度，Scala的模式匹配可以根据运行时类型、值或两者进行分派。模式匹配还包括语法上令人愉快的变量绑定。很难过分强调单功能本身在Scala中编程是多么令人愉快。

Scala和Groovy都支持混合继承的一种形式(尽管Scala称它们为特性)。

Scala既支持部分函数应用程序，也支持语言级别的运行，Groovy有一个笨拙的“curry”方法来执行部分函数应用程序。

Scala直接进行尾递归优化。我不相信Groovy会这么做。这在函数式编程中很重要，但在命令式编程中则不太重要

默认情况下，Scala和Groovy都会被急切地计算出来。然而，Scala支持按名称调用参数.。Groovy不能按名称调用，必须使用闭包进行模拟。

Scala有一个“for理解”，它是在其他语言中发现的列表理解的泛化(从技术上讲，它们是单语理解，再加上一点--介于Haskell的do和C#的LINQ之间)。

Scala没有“静态”字段、内部类、方法等概念--它使用的是单例对象。Groovy使用静态概念。

Scala没有像Groovy那样构建算术运算符的选择，在Scala中，可以非常灵活地命名方法。

Groovy有用于处理NULL的Elvis运算符。Scala程序员更喜欢使用选项类型，而不是使用NULL，但是如果您愿意，在Scala中编写Elvis运算符很容易。

最后，还有谎言，还有该死的谎言，还有一些基准测试。计算机语言基准测试游戏将Scala排在比Groovy快得多(速度是Groovy的两倍到93倍)之间，同时保持了大致相同的源代码大小。

我肯定有很多，很多不同的地方，我还没有说过。但希望这能给你一个要点。

他们之间有竞争吗？Groovy真正的竞争对手是JRuby和Jython。


https://cloud.tencent.com/developer/ask/79253

https://www.cnblogs.com/liuning8023/p/4635454.html

https://segmentfault.com/a/1190000021901060

## java中调用groovy脚本

Groovy是构建在JVM上的一个轻量级动态语言，其是Java实现的，与Java语法类是，能很好的与Java代码结合，及扩展现有代码。

Java在语音动态性方面只能通过反射，且参数传递格式很严格不是很灵活，而Groovy是构建在JVM上的一个轻量级动态语言，其是Java实现的，与Java语法类是，能很好的与Java代码结合，及动态扩展现有代码。

Java中可以通过GroovyScriptEngine、GroovyClassLoader、GroovyShell、ScriptEngineManager等方式调用Groovy，以及在实际项目中的运用。

https://yaoyinglong.github.io/Blog/Java/%E5%B7%A5%E5%85%B7/Java%E4%B8%AD%E8%B0%83%E7%94%A8Groovy%E8%84%9A%E6%9C%AC/

## groovy发送网络请求

```groovy
// GET
def get = new URL("https://httpbin.org/get").openConnection();
def getRC = get.getResponseCode();
println(getRC);
if (getRC.equals(200)) {
    println(get.getInputStream().getText());
}

// POST
def post = new URL("https://httpbin.org/post").openConnection();
def message = '{"message":"this is a message"}'
post.setRequestMethod("POST")
post.setDoOutput(true)
post.setRequestProperty("Content-Type", "application/json")
post.getOutputStream().write(message.getBytes("UTF-8"));
def postRC = post.getResponseCode();
println(postRC);
if (postRC.equals(200)) {
    println(post.getInputStream().getText());
}
```

https://stackoverflow.com/questions/25692515/groovy-built-in-rest-http-client