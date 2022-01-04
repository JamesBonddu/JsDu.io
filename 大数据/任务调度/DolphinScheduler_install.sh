# 伪集群方式

yum install -y psmisc sshpass

# 创建用户需使用 root 登录
useradd dolphinscheduler

# 添加密码
echo "Turing@dolphinscheduler" | passwd --stdin dolphinscheduler

# 配置 sudo 免密
sed -i '$adolphinscheduler  ALL=(ALL)  NOPASSWD: NOPASSWD: ALL' /etc/sudoers
sed -i 's/Defaults    requirett/#Defaults    requirett/g' /etc/sudoers

# 修改目录权限，使得部署用户对 dolphinscheduler-bin 目录有操作权限
chown -R dolphinscheduler:dolphinscheduler dolphinscheduler-bin

wget https://downloads.mysql.com/archives/get/p/3/file/mysql-connector-java-5.1.47.tar.gz
tar -xvf mysql-connector-java-5.1.47.tar.gz

cp mysql-connector-java-5.1.47/mysql-connector-java-5.1.47.jar apache-dolphinscheduler-2.0.1-bin/lib/

docker exec -it mysql_db_1 mysql -uroot -pTuringExchangis@666


mysql -uroot -p

mysql> CREATE DATABASE dolphinscheduler DEFAULT CHARACTER SET utf8 DEFAULT COLLATE utf8_general_ci;

# 修改 {user} 和 {password} 为你希望的用户名和密码
mysql> GRANT ALL PRIVILEGES ON dolphinscheduler.* TO '{user}'@'%' IDENTIFIED BY '{password}';
mysql> GRANT ALL PRIVILEGES ON dolphinscheduler.* TO '{user}'@'localhost' IDENTIFIED BY '{password}';

GRANT ALL PRIVILEGES ON dolphinscheduler.* TO 'root'@'%' IDENTIFIED BY 'TuringExchangis@666';
GRANT ALL PRIVILEGES ON dolphinscheduler.* TO 'root'@'localhost' IDENTIFIED BY 'TuringExchangis@666';
flush privileges;

mysql> flush privileges;

# 修改正确配置之后执行创建海豚基础数据库的命令
/data/dep/dophinescheduler/apache-dolphinscheduler-2.0.1-bin/conf/config/install_config.conf

bash script/create-dolphinscheduler.sh
