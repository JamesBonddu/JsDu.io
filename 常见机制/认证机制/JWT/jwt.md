# JWT机制

JWT 的三个部分依次如下。

Header（头部）
Payload（负载）
Signature（签名）

Header 部分是一个 JSON 对象，描述 JWT 的元数据，通常是下面的样子。


{
  "alg": "HS256",
  "typ": "JWT"
}
上面代码中，alg属性表示签名的算法（algorithm），默认是 HMAC SHA256（写成 HS256）；typ属性表示这个令牌（token）的类型（type），JWT 令牌统一写为JWT.


Payload 部分也是一个 JSON 对象，用来存放实际需要传递的数据。JWT 规定了7个官方字段，供选用。

iss (issuer)：签发人
exp (expiration time)：过期时间
sub (subject)：主题
aud (audience)：受众
nbf (Not Before)：生效时间
iat (Issued At)：签发时间
jti (JWT ID)：编号
除了官方字段，你还可以在这个部分定义私有字段，下面就是一个例子。


{
  "sub": "1234567890",
  "name": "John Doe",
  "admin": true
}
注意，JWT 默认是不加密的，任何人都可以读到，所以不要把秘密信息放在这个部分。

这个 JSON 对象也要使用 Base64URL 算法转成字符串。


Signature 部分是对前两部分的签名，防止数据篡改。

首先，需要指定一个密钥（secret）。这个密钥只有服务器才知道，不能泄露给用户。然后，使用 Header 里面指定的签名算法（默认是 HMAC SHA256），按照下面的公式产生签名。


HMACSHA256(
  base64UrlEncode(header) + "." +
  base64UrlEncode(payload),
  secret)
算出签名以后，把 Header、Payload、Signature 三个部分拼成一个字符串，每个部分之间用"点"（.）分隔，就可以返回给用户。

前面提到，Header 和 Payload 串型化的算法是 Base64URL。这个算法跟 Base64 算法基本类似，但有一些小的不同。

JWT 作为一个令牌（token），有些场合可能会放到 URL（比如 api.example.com/?token=xxx）。Base64 有三个字符+、/和=，在 URL 里面有特殊含义，所以要被替换掉：=被省略、+替换成-，/替换成_ 。这就是 Base64URL 算法。


参考:

http://www.ruanyifeng.com/blog/2018/07/json_web_token-tutorial.html

https://juejin.im/entry/5993a030f265da24941202c2

http://blog.didispace.com/learn-how-to-use-jwt-xjf/


https://jwt.io/

https://tools.ietf.org/html/rfc7519

# JWT refresh token flow

- 登录后，发送2个令牌（访问令牌，刷新令牌）以响应客户端。
- 访问令牌的有效期将更少，而刷新将具有较长的到期时间。
- 客户端（前端）将在其本地存储中存储刷新令牌，并在cookie中访问令牌。
- 客户端将使用访问令牌来调用API。但是，当它过期时，请从本地存储中选择刷新令牌，然后调用身份验证服务器API以获取新令牌。
- 您的身份验证服务器将公开一个API，该API将接受刷新令牌并检查其有效性并返回新的访问令牌。
- 刷新令牌过期后，将注销用户

https://auth0.com/blog/refresh-tokens-what-are-they-and-when-to-use-them/

https://zhuanlan.zhihu.com/p/52300092

https://stackoverflow.com/questions/27726066/jwt-refresh-token-flow


https://juejin.cn/post/6844903833273892871

# django simple jwt

```python
from rest_framework_simplejwt.tokens import RefreshToken

def get_tokens_for_user(user):
    refresh = RefreshToken.for_user(user)

    return {
        'refresh': str(refresh),
        'access': str(refresh.access_token),
    }
```

https://github.com/SimpleJWT/django-rest-framework-simplejwt/blob/f511e0aeabc24ec792c66f720f4a059ab1c4180c/docs/customizing_token_claims.rst

https://github.com/SimpleJWT/django-rest-framework-simplejwt/blob/master/docs/creating_tokens_manually.rst