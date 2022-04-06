# Fegin

Feign 是一个 Java 到 HTTP 的客户端绑定器，灵感来自于 Retrofit 和 JAXRS-2.0 以及 WebSocket。Feign 的第一个目标是降低将 Denominator  无变化的绑定到 HTTP APIs 的复杂性，而不考虑 ReSTfulness。
Feign 使用 Jersey 和 CXF 等工具为 ReST 或 SOAP 服务编写 java 客户端。此外，Feign 允许您在 Apache HC 等http 库之上编写自己的代码。Feign 以最小的开销将代码连接到 http APIs，并通过可定制的解码器和错误处理（可以写入任何基于文本的 http APIs）将代码连接到 http APIs。

https://juejin.cn/post/6844904195829547022


## HandlerInterceptor
HandlerInterceptor拦截器我想大家都并不陌生，最常用的登录拦截、或是权限校验、或是防重复提交、或是根据业务像12306去校验购票时间,总之可以去做很多的事情。

- preHandle：在业务处理器处理请求之前被调用。预处理，可以进行编码、安全控制、权限校验等处理；
- postHandle：在业务处理器处理请求执行完成后，生成视图之前执行。后处理（调用了Service并返回ModelAndView，但未进行页面渲染），有机会修改ModelAndView （这个博主就基本不怎么用了）；
- afterCompletion：在DispatcherServlet完全处理完请求后被调用，可用于清理资源等。返回处理（已经渲染了页面）；
接下来让我们来实现一个登陆 and 访问权限校验的拦截器吧

1.拦截器是基于java的反射机制的，而过滤器是基于函数回调。
2.拦截器不依赖与servlet容器，过滤器依赖与servlet容器。
3.拦截器只能对Controller请求起作用，而过滤器则可以对几乎所有的请求起作用。
4.拦截器可以访问Controller上下文、值栈里的对象，而过滤器不能访问。
5.在Controller的生命周期中，拦截器可以多次被调用，而过滤器只能在容器初始化时被调用一次。
6.拦截器可以获取IOC容器中的各个bean，而过滤器就不行，这点很重要，在拦截器里注入一个service，可以调用业务逻辑。


https://blog.csdn.net/zhibo_lv/article/details/81699360


https://blog.csdn.net/weixin_34274029/article/details/91946706

https://cloud.tencent.com/developer/article/1421041


# Spring Interceptor和Servlet Filter

https://segmentfault.com/a/1190000039996829?utm_source=sf-similar-article
