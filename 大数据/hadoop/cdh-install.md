#!/bin/bash

function install_dep {
    yum -y install yum-utils createrepo unzip chkconfig python bind-utils psmisc libxslt zlib sqlite cyrus-sasl-plain cyrus-sasl-gssapi fuse fuse-libs redhat-lsb postgresql* portmap mod_ssl openssl openssl-devel python-psycopg2 MySQL-python python-devel telnet pcre-devel gcc gcc-c++ httpd;
    yum update -y;
}


function start_httpd {
    systemctl enable  httpd.service;
    systemctl restart httpd.service;
}

function create_cm_repo {
    mkdir -p /var/www/hml/cm;
    # 将在“2.1CM下载”中，下载需要的文件，后面要放在本地yum云中，提供访问在添加完需要资源后，使用工具和本地的yum源创建联系，其中repodata是yum联系创建的
    createrepo /var/www/html/cm;
}

# 安装java 设置环境变量

```sh
function install_java {
    rpm -ivh /data/dep/cdh6.3.2安装包/cm6.3.1/oracle-j2sdk1.8-1.8.0+update181-1.x86_6.rpm

    rpm -ivh /data/oracle-j2sdk1.8-1.8.0+update181-1.x86_6.rpm
}

# export JAVA_HOME=/usr/java/jdk1.8.0_181-cloudera
# export CLASSPATH=.:$CLASSPATH:$JAVA_HOME/lib
# export PATH=$PATH:$JAVA_HOME/bin
```

# 设置主机名 (所有节点)

function set_hostname {
    # 各台机器上设置hostname
    hostnamectl set-hostname cdh01
    hostnamectl set-hostname cdh02
    hostnamectl set-hostname cdh03
    hostnamectl set-hostname cdh0

    #cat /etc/hosts    
    #172.19.211.138 cdh01
    #172.19.211.137 cdh02
    #172.19.211.139 cdh03
    #172.19.211.10 cdh0
}

# 禁用透明大页 (所有节点)

```sh
cat /sys/kernel/mm/transparent_hugepage/defrag
cat /sys/kernel/mm/transparent_hugepage/enabled
echo 'echo never > /sys/kernel/mm/transparent_hugepage/defrag' >> /etc/rc.d/rc.local
echo 'echo never > /sys/kernel/mm/transparent_hugepage/enabled' >> /etc/rc.d/rc.local
chmod +x /etc/rc.d/rc.local

echo 'vm.swappiness=10' >> /etc/sysctl.conf
sysctl -p

已启用透明大页面压缩，可能会导致重大性能问题。请运行“echo never > /sys/kernel/mm/transparent_hugepage/defrag”和“echo never > /sys/kernel/mm/transparent_hugepage/enabled”以禁用此设置，然后将同一命令添加到 /etc/rc.local 等初始化脚本中，以便在系统重启时予以设置。以下主机将受到影响:
```
对于数据库应用，不推荐使用 THP.主要的原因是这类数据库大部分访问内存的方式是分散的,并不是访问连续的页面,而这样的访问模式,
就会造成内存的碎片化.访问的page 不也不是大量连续性的. 并且在不启用THP 时申请KB的内存时,
LINUX会分配相应的内存给应用, 但如果是在系统级别启用了THP,则类似数据库申请内存时,即使申请的值是KB ,
但分配是会以大于KB例如 2MB 来进行分配,这样数据库申请使用内存的方式也会出现问题,和相关的损耗.
# https://blog.51cto.com/wang/3601866


# 设置阿里源

```sh
#1.备份原镜像文件，便于后期恢复 
cd /etc/yum.repos.d/ mv CentOS-Base.repo CentOS-Base.repo.backup 
#2.下载阿里云的CentOS-Base.repo 到/etc/yum.repos.d/ 
wget -O /etc/yum.repos.d/CentOS-Base.repo http://mirrors.aliyun.com/repo/Centos-7.repo 
#3. 清除缓存 
yum clean all 
#. 生成缓存 
yum makecache
```

# 添加mysql驱动包

注意：以上三步在所有服务器都要配置
四.Cloudera Manager部署
第一步：安装CM server及agent
第二步：所有节点修改agent配置
第三步：初始化scm数据库
结果为： All done, your SCM database is configured correctly! ，表示初始化成功。
第四步：启动CM server及agent
yum install -y oracle-j2sdk1.8-1.8.0+update181-1.x86_6
vim /etc/profile 
export JAVA_HOME=/usr/java/jdk1.8.0_181-cloudera 
export CLASSPATH=.:$JAVA_HOME/jre/lib/rt.jar:$JAVA_HOME/lib/dt.jar:$JAVA_HOME/lib/tools.jar 
export PATH=:$JAVA_HOME/bin:$PATH 
source /etc/profile

mkdir -p /usr/share/java && cp /data/mysql-connector-java-8.0.18.jar  /usr/share/java/mysql-connector-java.jar


# 下载配置Mysql的rpm安装包

```sh
mkdir -p /baicdt/softwares/mysql_rpm 
cd /baicdt/softwares/mysql_rpm 
#1.下载rpm包 
wget https://repo.mysql.com//mysql80-community-release-el7-3.noarch.rpm 
#2.安装myaql源 
yum localinstall -y mysql80-community-release-el7-3.noarch.rpm 
#3.检查MySQL源是否安装成功，此时查到的安装包的版本都是mysql5.8版本的 
yum repolist enabled | grep "mysql.*-community.*"
#.修改yum源配置文件，获取自己想要安装的mysql5.7版本 
vim /etc/yum.repos.d/mysql-community.repo
#下载速度较慢，需等待一段时间 
yum -y install mysql-community-server

systemctl enable mysqld
systemctl restart mysqld
# mysql安装完成之后，在 /var/log/mysqld.log 文件中给root生成了一个默认密码。通过以下命令找到密码
grep 'temporary password' /var/log/mysqld.log

# 修改密码并给予远程登录权限
mysql> set password=password('Atguigu.12356');
mysql> grant all privileges on *.* to 'root' @'%' identified by 'Atguigu.12356';
mysql> flush privileges;
```


# 创建CDH数据库

```sql
-- mysql5.7
CREATE DATABASE scm DEFAULT CHARACTER SET utf8; 
CREATE USER 'scm'@'%' IDENTIFIED BY 'scm'; 
GRANT ALL PRIVILEGES ON scm.* TO 'scm'@'%' IDENTIFIED BY 'scm'; 
GRANT ALL PRIVILEGES ON *.* TO 'scm'@'%' IDENTIFIED BY 'scm' WITH GRANT OPTION;

CREATE DATABASE amon DEFAULT CHARACTER SET utf8; 
CREATE USER 'amon'@'%' IDENTIFIED BY 'amon'; 
GRANT ALL PRIVILEGES ON amon.* TO 'amon'@'%' IDENTIFIED BY 'amon'; 
GRANT ALL PRIVILEGES ON *.* TO 'amon'@'%' IDENTIFIED BY 'amon' WITH GRANT OPTION; 
CREATE DATABASE hive DEFAULT CHARACTER SET utf8; 
CREATE USER 'hive'@'%' IDENTIFIED BY 'hive'; 
GRANT ALL PRIVILEGES ON hive.* TO 'hive'@'%' IDENTIFIED BY 'hive'; 
GRANT ALL PRIVILEGES ON *.* TO 'hive'@'%' IDENTIFIED BY 'hive' WITH GRANT OPTION; 
CREATE DATABASE hue DEFAULT CHARACTER SET utf8; 
CREATE USER 'hue'@'%' IDENTIFIED BY 'hue'; 
GRANT ALL PRIVILEGES ON hue.* TO 'hue'@'%' IDENTIFIED BY 'hue'; 
GRANT ALL PRIVILEGES ON *.* TO 'hue'@'%' IDENTIFIED BY 'hue' WITH GRANT OPTION; 
CREATE DATABASE oozie DEFAULT CHARACTER SET utf8; 
CREATE USER 'oozie'@'%' IDENTIFIED BY 'oozie'; 
GRANT ALL PRIVILEGES ON oozie.* TO 'oozie'@'%' IDENTIFIED BY 'oozie'; 
GRANT ALL PRIVILEGES ON *.* TO 'oozie'@'%' IDENTIFIED BY 'oozie' WITH GRANT OPTION; 
-- 刷新mysql的权限列表 
FLUSH PRIVILEGES;
```

```sql
CREATE DATABASE scm DEFAULT CHARACTER SET utf8; 
CREATE USER 'scm'@'%' IDENTIFIED BY 'scm';
GRANT ALL PRIVILEGES ON scm.* TO 'scm'@'%'; 
GRANT ALL PRIVILEGES ON *.* TO 'scm'@'%' WITH GRANT OPTION;

CREATE DATABASE amon DEFAULT CHARACTER SET utf8; 
CREATE USER 'amon'@'%' IDENTIFIED BY 'amon'; 
GRANT ALL PRIVILEGES ON amon.* TO 'amon'@'%'; 
GRANT ALL PRIVILEGES ON *.* TO 'amon'@'%' WITH GRANT OPTION;

CREATE DATABASE hive DEFAULT CHARACTER SET utf8; 
CREATE USER 'hive'@'%' IDENTIFIED BY 'hive'; 
GRANT ALL PRIVILEGES ON hive.* TO 'hive'@'%'; 
GRANT ALL PRIVILEGES ON *.* TO 'hive'@'%' WITH GRANT OPTION; 

CREATE DATABASE hue DEFAULT CHARACTER SET utf8; 
CREATE USER 'hue'@'%' IDENTIFIED BY 'hue'; 
GRANT ALL PRIVILEGES ON hue.* TO 'hue'@'%'; 
GRANT ALL PRIVILEGES ON *.* TO 'hue'@'%' WITH GRANT OPTION; 

CREATE DATABASE oozie DEFAULT CHARACTER SET utf8; 
CREATE USER 'oozie'@'%' IDENTIFIED BY 'oozie'; 
GRANT ALL PRIVILEGES ON oozie.* TO 'oozie'@'%'; 
GRANT ALL PRIVILEGES ON *.* TO 'oozie'@'%' WITH GRANT OPTION; 

-- 刷新mysql的权限列表 
FLUSH PRIVILEGES;
```


https://www.cnblogs.com/ttzzyy/p/1307277.html

https://mp.weixin.qq.com/s/P0UMXT01WxWqR0J3ZDqBpQ

# 创建本地repo方便下载cm文件

```sh
[root@cdh01 dep]# cd  /var/www/html/cm6.3.1/
[root@cdh01 cm6.3.1]# createrepo .

[root@cdh01 cm6.3.1]# cat /etc/yum.repos.d/cloudera-manager.repo
[cloudera-manager.repo]
name=os_repo 
baseurl=http://xxx/cm6.3.1 
enabled=true 
gpgcheck=false

yum clean all
yum makecache

yum list | grep cloudera-manager

[root@cdh01 cm6.3.1]# yum list | grep cloudera-manager
cloudera-manager-agent.x86_6            6.3.1-16658.el7             cloudera-manager.repo
cloudera-manager-daemons.x86_6          6.3.1-16658.el7             cloudera-manager.repo
cloudera-manager-server.x86_6           6.3.1-16658.el7             cloudera-manager.repo
cloudera-manager-server-db-2.x86_6      6.3.1-16658.el7             cloudera-manager.repo
enterprise-debuginfo.x86_6              6.3.1-16658.el7             cloudera-manager.repo

[root@cdh01 cm6.3.1]# scp -r /etc/yum.repos.d/cloudera-manager.repo root@cdh02:/etc/yum.repos.d/
cloudera-manager.repo                                                                       100%  106   08.8KB/s   00:00    
[root@cdh01 cm6.3.1]# scp -r /etc/yum.repos.d/cloudera-manager.repo root@cdh03:/etc/yum.repos.d/
cloudera-manager.repo                                                                       100%  106   39.7KB/s   00:00    
[root@cdh01 cm6.3.1]# scp -r /etc/yum.repos.d/cloudera-manager.repo root@cdh0:/etc/yum.repos.d/
cloudera-manager.repo                                                                       100%  106   22.0KB/s   00:00 


yum clean all && yum makecache && yum list | grep cloudera-manager
```

# 安装CDH的CM和Agent


```sh
# 主节点执行
sudo yum -y install cloudera-manager-daemons cloudera-manager-agent cloudera-manager-server

# 其它节点执行
sudo yum -y install cloudera-manager-daemons cloudera-manager-agent


# 在主节点（hadoop102.example.com）执行以下命令，启动Server 和 Agent
systemctl start cloudera-scm-server cloudera-scm-agent

# 在其余节点执行以下命令，启动Agent 
systemctl start cloudera-scm-agent

# 停掉主节点的httpd服务
systemctl stop httpd
systemctl disable httpd
```

https://mp.weixin.qq.com/s/P0UMXT01WxWqR0J3ZDqBpQ

## 配置Cloudera Manager Agent

vim /etc/cloudera-scm-agent/config.ini

修改内容如下，将server_host参数改为Cloudera Manager Server所在节点的主机名

```sh
[root@cdh01 ~]# cat /etc/cloudera-scm-agent/config.ini
# Configuration file for cloudera-scm-agent.
# Please note that this file supports multi-line values.  Multi-line
# values are indicated by indenting following lines with a space.
#
# If you have whitespace in front of a parameter name, it will be
# read as a continuation of the previous parameter value.  Please
# be careful not to leave spaces in front of parameter names.
#
# To check if this file has spaces in front of parameters names
# you can do a grep like this:
#  grep '^[[:blank:]]' /etc/cloudera-scm-agent/config.ini

[General]
# Hostname of the CM server.
server_host=cdh01
```

## 执行cm数据库初始化脚本

```sh
/opt/cloudera/cm/schema/scm_prepare_database.sh --host cdh01 --scm-host cdh01 mysql scm root Turingcdh@666


JAVA_HOME=/usr/java/jdk1.8.0_181-cloudera
Verifying that we can write to /etc/cloudera-scm-server
Creating SCM configuration file in /etc/cloudera-scm-server
Executing:  /usr/java/jdk1.8.0_181-cloudera/bin/java -cp /usr/share/java/mysql-connector-java.jar:/usr/share/java/oracle-connector-java.jar:/usr/share/java/postgresql-connector-java.jar:/opt/cloudera/cm/schema/../lib/* com.cloudera.enterprise.dbutil.DbCommandExecutor /etc/cloudera-scm-server/db.properties com.cloudera.cmf.db.
logj:ERROR Could not find value for key logj.appender.A
logj:ERROR Could not instantiate appender named "A".
Loading class `com.mysql.jdbc.Driver'. This is deprecated. The new driver class is `com.mysql.cj.jdbc.Driver'. The driver is automatically registered via the SPI and manual loading of the driver class is generally unnecessary.
[2021-10-11 15:2:09,263] INFO     0[main] - com.cloudera.enterprise.dbutil.DbCommandExecutor.testDbConnection(DbCommandExecutor.java) - Successfully connected to database.
All done, your SCM database is configured correctly!
```

# 部署CDH

1.上传CDH parcel到Cloudera Manager Server
节点的/opt/cloudera/parcel-repo路径下，上传CDH所需parcel



2.为parcel文件生成SHA1校验文件

```sh
sha1sum CDH-6.3.2-1.cdh6.3.2.p0.160555-el7.parcel | awk '{ print $1 }' > CDH-6.3.2-1.cdh6.3.2.p0.160555-el7.parcel.sha
```

3.更改parcel文件所有者

```sh
chown -R cloudera-scm:cloudera-scm /opt/cloudera/parcel-repo/*
```

.重启Cloudera Manager，令其识别到本地库


sudo systemctl restart cloudera-scm-serve


# web CM页面安装时注意repo的配置

将自定义存储库设置为
http://cdh01/cm6.3.1


https://www.blog.kamisamak.com/cloudera-cdh-6-3-2-centos7%e7%a6%bb%e7%ba%bf%e5%ae%89%e8%a3%85/

# CDH 上再安装其它版本的spark

https://blog.csdn.net/data2tech/article/details/117283334

https://www.cndba.cn/dave/article/3392

# Alluxio集群搭建并整合CDH

https://www.cnblogs.com/daemonyue/p/12979054.html