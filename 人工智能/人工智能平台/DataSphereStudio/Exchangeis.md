# exchangis

## 报错
mvn clean install 过程中

```sh
Failed to execute goal on project exchangis-service: Could not resolve dependencies for project com.webank.wedatasphere.exchangis:exchangis-service:jar:0.5.0.RELEASE: Could not find artifact org.pentaho:pentaho-aggdesigner-algorithm:jar:5.1.5-jhyde in nexus-aliyun
```
https://developer.aliyun.com/article/78124

https://gitee.com/WeBank/Exchangis/issues/I1I7OE?skip_mobile=true

## 安装流程

https://github.com/WeBankFinTech/Exchangis/blob/master/docs/zh_CN/ch1/exchangis_deploy_cn.md

https://github.com/WeBankFinTech/Exchangis/blob/master/docs/zh_CN/ch1/exchangis_user_manual_cn.md


## 登录逻辑


`AuthConfiguration.enable` 对应auth.switch开关.它会调用*refresh* 函数.
```sh
String body = authTokenService.refreshServerToken(authConfiguration.authTokenServRefreshId(),
                    authConfiguration.authTokenServRefreshPwd());
```
会不断地刷新`auth.token.servRefresh.id:id`

```sh
[root@cdh06 wedatasphere-exchangis-0.5.0.RELEASE]# cat modules/exchangis-service/conf/auth.properties
auth.switch=true
auth.login.url=/api/v1/auth/login
auth.redirect.url=/api/v1/auth/redirect
auth.secret=rsa_private_key.pem
auth.cas.switch=false
auth.cas.systemId=5014
auth.token.invalid=30
#Token refresh
auth.token.servRefresh.interval=300
auth.token.servRefresh.id=exchangis_service
auth.token.servRefresh.pwd=udes@2018

[root@cdh06 wedatasphere-exchangis-0.5.0.RELEASE]# cat modules/exchangis-executor/conf/auth.properties
auth.switch=true
auth.login.url=/api/v1/auth/login
auth.token.invalid=30
#token\u5237\u65B0\u95F4\u9694
auth.token.servRefresh.interval=300
auth.token.servRefresh.id=exchangis_executor
auth.token.servRefresh.pwd=udes@2018
auth.token.servRefresh.store=${data.path}/token/server.tk
```


AuthenticationInterceptor中间件, 判断auth的配置是开启或者关闭的

UserInfoSyncInterceptor用于用户信息同步
