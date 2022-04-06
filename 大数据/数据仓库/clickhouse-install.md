```sh
sudo yum install yum-utils
sudo rpm --import https://repo.clickhouse.com/CLICKHOUSE-KEY.GPG
sudo yum-config-manager --add-repo https://repo.clickhouse.com/rpm/stable/x86_64

sudo yum install -y clickhouse-server clickhouse-client

sudo systemctl start clickhouse-server
sudo systemctl stop clickhouse-server
sudo systemctl status clickhouse-server
```

https://www.jianshu.com/p/43dbc4ad5de2

https://blog.51cto.com/feko/2738319
