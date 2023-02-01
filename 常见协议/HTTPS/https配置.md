# https配置

## 使用 acme.sh 配置https

```sh
curl https://get.acme.sh | sh -s email=mymail@example.com

wget -O -  https://get.acme.sh | sh -s email=mymail@example.com
acme.sh --set-default-ca --server letsencrypt

# 配置认证信息到acme配置文件
export Ali_Key="sdfsdfsdfljlbjkljlkjsdfoiwje"
export Ali_Secret="jlsdflanljkljlfdsaklkjflsa"

echo "export DOH_USE=3" >> acme.sh.env
source acme.sh.env

# 安装证书到指定位置
acme.sh --install-cert -d *.example.com \
--cert-file /usr/local/nginx/ssl/cert.pem \
--key-file /usr/local/nginx/ssl/key.pem \
--ca-file /usr/local/nginx/ssl/ca.pem \
--fullchain-file /usr/local/nginx/ssl/fullchain.pem \
--reloadcmd "service nginx force-reload"

# 申请泛域名证书
acme.sh --issue --dns dns_ali -d domain-name  -d *.domain-name --use-wget

# nginx 配置
server {
	listen 443 ssl;
	listen [::]:443 ssl;
	server_name disk.example.com;
	ssl_certificate	/usr/local/nginx/ssl/cert.pem;
	ssl_certificate_key	/usr/local/nginx/ssl/key.pem;

	location / {
		proxy_redirect off;
		proxy_set_header Host $host;
		proxy_set_header X-Real-IP $remote_addr;
		proxy_set_header X-Real-Port $remote_port;
		proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;
		proxy_pass http://127.0.0.1:8080;
	}
}
```


https://www.bilibili.com/read/cv15876438/
