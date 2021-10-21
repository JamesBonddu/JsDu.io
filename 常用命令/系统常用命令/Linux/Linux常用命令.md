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

# 通过预检测请求, options 了解可用的请求头
curl -X OPTIONS https://github.com/ -i
```
https://developer.mozilla.org/zh-TW/docs/Web/HTTP/Methods/OPTIONS


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

# 根据进程名称杀进程
ps auxf|grep Exchangis|awk '{print $2}'|xargs kill -term
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
https://github.com/Supervisor/supervisor/issues/173

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


## bash mysql

https://stackoverflow.com/questions/8802131/execute-multiline-mysql-in-shellscript

## mysql store process

https://stackoverflow.com/questions/8149545/pass-array-to-mysql-stored-routine

https://blog.basilediougoant.com/2016/02/06/how-to-pass-an-array-to-mysql-stored-procedure/

## mysql export remote database data
```sql
mysql -umysqlusername -pmysqlpass databasename -B -e "select * from \`tablename\`;" | sed 's/\t/","/g;s/^/"/;s/$/"/;s/\n//g' > mysql_exported_table.csv
```
## mysql 导出指定表的数据

```sql
 mysqldump -hhost  -P3306 -uuser -ppwd database `cat table.txt` > table.sql
```

https://stackoverflow.com/questions/16834880/mysql-export-resultset-as-csv-from-remote-server


## 在目录下替换N/A为""

```sh
ls *.csv|xargs  sed -i  's~N/A~""~g' ${1}
ls *.csv|xargs  sed -i  's~""""~""~g' ${1}

ls csv | xargs -i wc -l csv/{$1}/江苏.csv | xargs -i ${1} | sum 
计算csv的总行数

# 将不同目录的git migration文件挪动到同一个下面注意会有同名文件删除
git status|grep migrations |xargs -I file mv file old_migrations/

# 创建附注Tag
git tag -a v0.1.2 -m "0.1.2版本"

# 指定ssh key 进行拉取
GIT_SSH_COMMAND='ssh -i ~/.ssh/id_rsa -o IdentitiesOnly=yes' git push origin master
```



# 查看mysql死锁进程并杀掉

```sh
SELECT * FROM INFORMATION_SCHEMA.INNODB_TRX;
```
# 查看顯卡使用情況

```sh
fang@ub ~/jsdu> nvidia-smi                                                                            (torch) 
Wed Mar 10 19:50:20 2021       
+-----------------------------------------------------------------------------+
| NVIDIA-SMI 450.102.04   Driver Version: 450.102.04   CUDA Version: 11.0     |
|-------------------------------+----------------------+----------------------+
| GPU  Name        Persistence-M| Bus-Id        Disp.A | Volatile Uncorr. ECC |
| Fan  Temp  Perf  Pwr:Usage/Cap|         Memory-Usage | GPU-Util  Compute M. |
|                               |                      |               MIG M. |
|===============================+======================+======================|
|   0  GeForce RTX 2070    Off  | 00000000:01:00.0 Off |                  N/A |
|  0%   46C    P8     4W / 175W |   7977MiB /  7979MiB |      0%      Default |
|                               |                      |                  N/A |
+-------------------------------+----------------------+----------------------+
|   1  GeForce RTX 2070    Off  | 00000000:05:00.0 Off |                  N/A |
| 27%   25C    P8    11W / 175W |      3MiB /  7982MiB |      0%      Default |
|                               |                      |                  N/A |
+-------------------------------+----------------------+----------------------+
                                                                               
+-----------------------------------------------------------------------------+
| Processes:                                                                  |
|  GPU   GI   CI        PID   Type   Process name                  GPU Memory |
|        ID   ID                                                   Usage      |
|=============================================================================|
|    0   N/A  N/A     12769      C   ...da3/envs/torch/bin/python     6757MiB |
|    0   N/A  N/A     12810      C   ...da3/envs/torch/bin/python     1217MiB |
+-----------------------------------------------------------------------------+

Fan：显示风扇转速，数值在0到100%之间，是计算机的期望转速，如果计算机不是通过风扇冷却或者风扇坏了，显示出来就是N/A； 
Temp：显卡内部的温度，单位是摄氏度；
Perf：表征性能状态，从P0到P12，P0表示最大性能，P12表示状态最小性能；
Pwr：能耗表示； 
Bus-Id：涉及GPU总线的相关信息； 
Disp.A：是Display Active的意思，表示GPU的显示是否初始化； 
Memory Usage：显存的使用率； 
Volatile GPU-Util：浮动的GPU利用率；
Compute M：计算模式； 

原文链接：https://blog.csdn.net/dcrmg/article/details/78146797


fang@ub ~/jsdu> nvidia-smi -q                                                                         (torch) 

==============NVSMI LOG==============

Timestamp                                 : Wed Mar 10 19:55:06 2021
Driver Version                            : 450.102.04
CUDA Version                              : 11.0

Attached GPUs                             : 2
GPU 00000000:01:00.0
    Product Name                          : GeForce RTX 2070
    Product Brand                         : GeForce
    Display Mode                          : Enabled
    Display Active                        : Disabled
    Persistence Mode                      : Disabled
    MIG Mode
        Current                           : N/A
        Pending                           : N/A
    Accounting Mode                       : Disabled
    Accounting Mode Buffer Size           : 4000
    Driver Model
        Current                           : N/A
        Pending                           : N/A
    Serial Number                         : N/A
    GPU UUID                              : GPU-b13cc585-b683-a9a8-ac8d-7541ac69a33c
    Minor Number                          : 0
    VBIOS Version                         : 90.06.18.00.9E
    MultiGPU Board                        : No
    Board ID                              : 0x100
    GPU Part Number                       : N/A
    Inforom Version
        Image Version                     : G001.0000.02.04
        OEM Object                        : 1.1
        ECC Object                        : N/A
        Power Management Object           : N/A
    GPU Operation Mode
        Current                           : N/A
        Pending                           : N/A
    GPU Virtualization Mode
        Virtualization Mode               : None
        Host VGPU Mode                    : N/A
    IBMNPU
        Relaxed Ordering Mode             : N/A
    PCI
        Bus                               : 0x01
        Device                            : 0x00
        Domain                            : 0x0000
        Device Id                         : 0x1F0210DE
        Bus Id                            : 00000000:01:00.0
        Sub System Id                     : 0x37C21458
        GPU Link Info
            PCIe Generation
                Max                       : 3
                Current                   : 1
            Link Width
                Max                       : 16x
                Current                   : 16x
        Bridge Chip
            Type                          : N/A
            Firmware                      : N/A
        Replays Since Reset               : 0
        Replay Number Rollovers           : 0
        Tx Throughput                     : 0 KB/s
        Rx Throughput                     : 0 KB/s
    Fan Speed                             : 0 %
    Performance State                     : P8
    Clocks Throttle Reasons
        Idle                              : Active
        Applications Clocks Setting       : Not Active
        SW Power Cap                      : Not Active
        HW Slowdown                       : Not Active
            HW Thermal Slowdown           : Not Active
            HW Power Brake Slowdown       : Not Active
        Sync Boost                        : Not Active
        SW Thermal Slowdown               : Not Active
        Display Clock Setting             : Not Active
    FB Memory Usage
        Total                             : 7979 MiB
        Used                              : 7977 MiB
        Free                              : 2 MiB
    BAR1 Memory Usage
        Total                             : 256 MiB
        Used                              : 11 MiB
        Free                              : 245 MiB
    Compute Mode                          : Default
    Utilization
        Gpu                               : 0 %
        Memory                            : 1 %
        Encoder                           : 0 %
        Decoder                           : 0 %
    Encoder Stats
        Active Sessions                   : 0
        Average FPS                       : 0
        Average Latency                   : 0
    FBC Stats
        Active Sessions                   : 0
        Average FPS                       : 0
        Average Latency                   : 0
    Ecc Mode
        Current                           : N/A
        Pending                           : N/A
    ECC Errors
        Volatile
            SRAM Correctable              : N/A
            SRAM Uncorrectable            : N/A
            DRAM Correctable              : N/A
            DRAM Uncorrectable            : N/A
        Aggregate
            SRAM Correctable              : N/A
            SRAM Uncorrectable            : N/A
            DRAM Correctable              : N/A
            DRAM Uncorrectable            : N/A
    Retired Pages
        Single Bit ECC                    : N/A
        Double Bit ECC                    : N/A
        Pending Page Blacklist            : N/A
    Remapped Rows                         : N/A
    Temperature
        GPU Current Temp                  : 45 C
        GPU Shutdown Temp                 : 94 C
        GPU Slowdown Temp                 : 91 C
        GPU Max Operating Temp            : 89 C
        Memory Current Temp               : N/A
        Memory Max Operating Temp         : N/A
    Power Readings
        Power Management                  : Supported
        Power Draw                        : 4.93 W
        Power Limit                       : 175.00 W
        Default Power Limit               : 175.00 W
        Enforced Power Limit              : 175.00 W
        Min Power Limit                   : 125.00 W
        Max Power Limit                   : 200.00 W
    Clocks
        Graphics                          : 300 MHz
        SM                                : 300 MHz
        Memory                            : 405 MHz
        Video                             : 540 MHz
    Applications Clocks
        Graphics                          : N/A
        Memory                            : N/A
    Default Applications Clocks
        Graphics                          : N/A
        Memory                            : N/A
    Max Clocks
        Graphics                          : 2100 MHz
        SM                                : 2100 MHz
        Memory                            : 7001 MHz
        Video                             : 1950 MHz
    Max Customer Boost Clocks
        Graphics                          : N/A
    Clock Policy
        Auto Boost                        : N/A
        Auto Boost Default                : N/A
    Processes
        GPU instance ID                   : N/A
        Compute instance ID               : N/A
        Process ID                        : 12769
            Type                          : C
            Name                          : /home/fang/.miniconda3/envs/torch/bin/python
            Used GPU Memory               : 6757 MiB
        GPU instance ID                   : N/A
        Compute instance ID               : N/A
        Process ID                        : 12810
            Type                          : C
            Name                          : /home/fang/.miniconda3/envs/torch/bin/python
            Used GPU Memory               : 1217 MiB

GPU 00000000:05:00.0
    Product Name                          : GeForce RTX 2070
    Product Brand                         : GeForce
    Display Mode                          : Disabled
    Display Active                        : Disabled
    Persistence Mode                      : Disabled
    MIG Mode
        Current                           : N/A
        Pending                           : N/A
    Accounting Mode                       : Disabled
    Accounting Mode Buffer Size           : 4000
    Driver Model
        Current                           : N/A
        Pending                           : N/A
    Serial Number                         : N/A
    GPU UUID                              : GPU-5feaad6f-89e7-0a87-176f-6d96ce187460
    Minor Number                          : 1
    VBIOS Version                         : 90.06.2E.40.DC
    MultiGPU Board                        : No
    Board ID                              : 0x500
    GPU Part Number                       : N/A
    Inforom Version
        Image Version                     : G001.0000.02.04
        OEM Object                        : 1.1
        ECC Object                        : N/A
        Power Management Object           : N/A
    GPU Operation Mode
        Current                           : N/A
        Pending                           : N/A
    GPU Virtualization Mode
        Virtualization Mode               : None
        Host VGPU Mode                    : N/A
    IBMNPU
        Relaxed Ordering Mode             : N/A
    PCI
        Bus                               : 0x05
        Device                            : 0x00
        Domain                            : 0x0000
        Device Id                         : 0x1F0210DE
        Bus Id                            : 00000000:05:00.0
        Sub System Id                     : 0x12FE10DE
        GPU Link Info
            PCIe Generation
                Max                       : 3
                Current                   : 1
            Link Width
                Max                       : 16x
                Current                   : 4x
        Bridge Chip
            Type                          : N/A
            Firmware                      : N/A
        Replays Since Reset               : 0
        Replay Number Rollovers           : 0
        Tx Throughput                     : 0 KB/s
        Rx Throughput                     : 0 KB/s
    Fan Speed                             : 27 %
    Performance State                     : P8
    Clocks Throttle Reasons
        Idle                              : Not Active
        Applications Clocks Setting       : Not Active
        SW Power Cap                      : Active
        HW Slowdown                       : Not Active
            HW Thermal Slowdown           : Not Active
            HW Power Brake Slowdown       : Not Active
        Sync Boost                        : Not Active
        SW Thermal Slowdown               : Not Active
        Display Clock Setting             : Not Active
    FB Memory Usage
        Total                             : 7982 MiB
        Used                              : 3 MiB
        Free                              : 7979 MiB
    BAR1 Memory Usage
        Total                             : 256 MiB
        Used                              : 3 MiB
        Free                              : 253 MiB
    Compute Mode                          : Default
    Utilization
        Gpu                               : 0 %
        Memory                            : 0 %
        Encoder                           : 0 %
        Decoder                           : 0 %
    Encoder Stats
        Active Sessions                   : 0
        Average FPS                       : 0
        Average Latency                   : 0
    FBC Stats
        Active Sessions                   : 0
        Average FPS                       : 0
        Average Latency                   : 0
    Ecc Mode
        Current                           : N/A
        Pending                           : N/A
    ECC Errors
        Volatile
            SRAM Correctable              : N/A
            SRAM Uncorrectable            : N/A
            DRAM Correctable              : N/A
            DRAM Uncorrectable            : N/A
        Aggregate
            SRAM Correctable              : N/A
            SRAM Uncorrectable            : N/A
            DRAM Correctable              : N/A
            DRAM Uncorrectable            : N/A
    Retired Pages
        Single Bit ECC                    : N/A
        Double Bit ECC                    : N/A
        Pending Page Blacklist            : N/A
    Remapped Rows                         : N/A
    Temperature
        GPU Current Temp                  : 25 C
        GPU Shutdown Temp                 : 94 C
        GPU Slowdown Temp                 : 91 C
        GPU Max Operating Temp            : 89 C
        Memory Current Temp               : N/A
        Memory Max Operating Temp         : N/A
    Power Readings
        Power Management                  : Supported
        Power Draw                        : 11.93 W
        Power Limit                       : 175.00 W
        Default Power Limit               : 175.00 W
        Enforced Power Limit              : 175.00 W
        Min Power Limit                   : 125.00 W
        Max Power Limit                   : 200.00 W
    Clocks
        Graphics                          : 300 MHz
        SM                                : 300 MHz
        Memory                            : 405 MHz
        Video                             : 540 MHz
    Applications Clocks
        Graphics                          : N/A
        Memory                            : N/A
    Default Applications Clocks
        Graphics                          : N/A
        Memory                            : N/A
    Max Clocks
        Graphics                          : 2100 MHz
        SM                                : 2100 MHz
        Memory                            : 7001 MHz
        Video                             : 1950 MHz
    Max Customer Boost Clocks
        Graphics                          : N/A
    Clock Policy
        Auto Boost                        : N/A
        Auto Boost Default                : N/A
    Processes                             : None


```


# 查看GPU信息

sudo apt install screenfetch -y

https://askubuntu.com/questions/5417/how-to-get-the-gpu-info


# dns_probe_finished_nxdomain

https://kinsta.com/knowledgebase/dns_probe_finished_nxdomain/


# OSError: [Errno 28] No space left on device

```sh
df -h
cd /
du -m --max-depth=1

du -h --max-depth=1du

sudo du -hsx /home/* | sort -rh | head -10
```

https://stackoverflow.com/questions/6998083/python-causing-ioerror-errno-28-no-space-left-on-device-results-32766-h

https://blog.csdn.net/A_L_A_N/article/details/97102988

https://www.cnblogs.com/yingsong/p/9468260.html

# NVME盘挂载

https://blog.csdn.net/weiweiliulu/article/details/103990458

# k8s

```sh
# 删除k8s

kubeadm reset -f
rm -rf /etc/cni /etc/kubernetes /var/lib/dockershim /var/lib/etcd /var/lib/kubelet /var/run/kubernetes ~/.kube/*
iptables -F && iptables -X
iptables -t nat -F && iptables -t nat -X
iptables -t raw -F && iptables -t raw -X
iptables -t mangle -F && iptables -t mangle -X
systemctl restart docker
```

https://stackoverflow.com/questions/44698283/how-to-completely-uninstall-kubernetes

https://www.kuboard.cn/install/install-k8s.html#%E7%A7%BB%E9%99%A4worker%E8%8A%82%E7%82%B9%E5%B9%B6%E9%87%8D%E8%AF%95

# docker

docker stop $(docker ps|awk '{print $1}')

docker rm -f $(docker ps -a | awk '{print $1}')
docker network rm  $(docker network ls | awk '{print $1}')

docker rm -f $(docker ps -a |  grep "dockercompose*"  | awk '{print $1}')

docker network rm  $(docker network ls |  grep "docker-compose*"  | awk '{print $1}')

# 查看正在运行的进程的输出

```sh
# 您可以通过proc文件系统访问输出。

tail -f /proc/<pid>/fd/1
# 1= stdout，2= stderr
```

https://unix.stackexchange.com/questions/58550/how-to-view-the-output-of-a-running-process-in-another-bash-session


# 拷贝一个文件中相关行到另外一个

```sh
sed -n '10,15p' file1.txt > file2.txt
```

https://stackoverflow.com/questions/47298469/how-to-copy-lines-10-to-15-of-a-file-into-another-file-in-unix


# yarn install

https://linuxize.com/post/how-to-install-yarn-on-ubuntu-20-04/