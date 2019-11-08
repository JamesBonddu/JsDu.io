# 飞书机器人

图片自动回复机器人

1. 创建企业应用

2. 创建企业应用机器人

3. 获取用户组接口

4. bot 调用Send img接口,向指定群发送img
   - 先调用上传图片接口, 上传完成图片之后获取img_key
   - 通过获取的chat_id 或者user_id 发送图片

5. 订阅事件配置, 配置完成后监听接受消息事件
   获取@机器人的消息,并进行回复.
   需要开启获取群聊中用户 @ 机器人的消息权限.


6.

game[""]

"Mozilla/5.0 (compatible; MSIE 9.0; Windows NT 6.1; WOW64; Trident/5.0; SLCC2; .NET CLR 2.0.50727; .NET CLR 3.5.30729; .NET CLR 3.0.30729; Media Center PC 6.0; .NET4.0C; .NET4.0E; LBBROWSER)"

"Mozilla/5.0 (compatible; MSIE 9.0; Windows NT 6.1; WOW64; Trident/5.0; SLCC2; .NET CLR 2.0.50727; .NET CLR 3.5.30729; .NET CLR 3.0.30729; Media Center PC 6.0; .NET4.0C; .NET4.0E; QQBrowser/7.0.3698.400)"

"Mozilla/4.0 (compatible; MSIE 7.0; Windows NT 6.1; WOW64; Trident/5.0; SLCC2; .NET CLR 2.0.50727; .NET CLR 3.5.30729; .NET CLR 3.0.30729; Media Center PC 6.0; .NET4.0C; .NET4.0E) "


sudo systemctl enable supervisord
sudo systemctl enable nginx

```sh
[Unit]
Description=The nginx HTTP and reverse proxy server
After=network.target remote-fs.target nss-lookup.target

[Service]
Type=forking
PIDFile=/run/nginx.pid
# Nginx will fail to start if /run/nginx.pid already exists but has the wrong
# SELinux context. This might happen when running `nginx -t` from the cmdline.
# https://bugzilla.redhat.com/show_bug.cgi?id=1268621
ExecStartPre=/usr/bin/rm -f /run/nginx.pid
ExecStartPre=/usr/sbin/nginx -t
ExecStart=/usr/sbin/nginx -g 'daemon off;' -c /etc/nginx/nginx.conf
ExecReload=/bin/kill -s HUP $MAINPID
KillSignal=SIGQUIT
TimeoutStopSec=5
KillMode=process
PrivateTmp=true

[Install]
WantedBy=multi-user.target
```

sudo systemctl daemon-reload
sudo systemctl start nginx &
sudo systemctl start supervisord &


使用SELINUX, 之后 nginx 的user对相应目录没有权限还是不行

semanage port -a -t http_port_t -p tcp 9090
-a 失败 改用-m
sudo semanage port -m -t http_port_t -p tcp 9090

semanage port -a -t http_port_t -p tcp 8080

关闭SELINUX
```sh
[jsdu@satori-bi-lark-msg ~]$ sudo cat /etc/selinux/config

# This file controls the state of SELinux on the system.
# SELINUX= can take one of these three values:
#     enforcing - SELinux security policy is enforced.
#     permissive - SELinux prints warnings instead of enforcing.
#     disabled - No SELinux policy is loaded.
SELINUX=disabled
# SELINUXTYPE= can take one of three values:
#     targeted - Targeted processes are protected,
#     minimum - Modification of targeted policy. Only selected processes are protected.
#     mls - Multi Level Security protection.
SELINUXTYPE=targeted
```
shutdown -r now

sudo systemctl enable supervisord
sudo systemctl enable nginx

```sh
[bidev@hedwig-deploy-tmpl cicd]$ cat  /usr/lib/systemd/system/nginx.service
[Unit]
Description=The nginx HTTP and reverse proxy server
After=syslog.target network.target remote-fs.target nss-lookup.target

[Service]
Type=forking
PIDFile=/run/nginx.pid
# Nginx will fail to start if /run/nginx.pid already exists but has the wrong
# SELinux context. This might happen when running `nginx -t` from the cmdline.
# https://bugzilla.redhat.com/show_bug.cgi?id=1268621
ExecStartPre=/usr/bin/rm -f /run/nginx.pid
ExecStartPre=/usr/sbin/nginx -t
ExecStart=/usr/sbin/nginx -c /etc/nginx/nginx.conf
ExecReload=/usr/sbin/nginx -s reload -c /etc/nginx/nginx.conf
ExecStop=/bin/kill -s QUIT $MAINPID
KillSignal=SIGQUIT
TimeoutStopSec=5
KillMode=process
PrivateTmp=true

[Install]
WantedBy=multi-user.target



[jsdu@satori-bi-lark-msg ~]$ cat  /usr/lib/systemd/system/supervisord.service
[Unit]
Description=Process Monitoring and Control Daemon
After=rc-local.service nss-user-lookup.target

[Service]
Type=forking
ExecStart=/usr/bin/supervisord -c /etc/supervisord.conf

[Install]
WantedBy=multi-user.target
```

sudo systemctl enable redis
sudo systemctl start redis

参考:

https://stackoverflow.com/questions/25527790/explanation-of-polkitd-unregistered-authentication-agent


https://blog.csdn.net/ztguang/article/details/77056171


https://www.digitalocean.com/community/questions/403-forbidden-nginx-13-permission-denied

https://www.nginx.com/resources/wiki/start/topics/examples/systemd/
