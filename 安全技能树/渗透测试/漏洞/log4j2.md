# log4j2 JNDI遠程注入漏洞


https://xz.aliyun.com/t/6633

https://kingx.me/Exploit-Java-Deserialization-with-RMI.html

https://bbs.ichunqiu.com/thread-62322-1-1.html


RMI通信

RMI核心特点之一就是动态类加载，如果当前JVM中没有某个类的定义，它可以从远程URL去下载这个类的class，动态加载的对象class文件可以使用Web服务的方式进行托管。这可以动态的扩展远程应用的功能，RMI注册表上可以动态的加载绑定多个RMI应用。对于客户端而言，服务端返回值也可能是一些子类的对象实例，而客户端并没有这些子类的class文件，如果需要客户端正确调用这些子类中被重写的方法，则同样需要有运行时动态加载额外类的能力。客户端使用了与RMI注册表相同的机制。RMI服务端将URL传递给客户端，客户端通过HTTP请求下载这些类。

这个概念比较重要，JNDI注入的利用方法中也借助了动态加载类的思路。


https://blog.csdn.net/lmy86263/article/details/72594760

https://blog.csdn.net/qq_38376348/article/details/114767587


# rmi远程发布错误

java.lang.ClassNotFoundException: XXX (no security manager: RMI class loader disabled)
https://www.cnblogs.com/arebirth/p/errorrmisecuritymanager.html
