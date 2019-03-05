# CentOS7 联网配置

```sh
cd /etc/sysconfig/network-scripts/; mv ifcfg-eno16777736 ifcfg-eth0 #重命名网卡文件

[root@monitor network-scripts]# cat /etc/sysconfig/grub #编辑grub信息

GRUB_TIMEOUT=5

GRUB_DISTRIBUTOR="(sed 's, release .*,,g' /etc/system-release)"

GRUB_DEFAULT=saved

GRUB_DISABLE_SUBMENU=true

GRUB_TERMINAL_OUTPUT="console"

GRUB_CMDLINE_LINUX="crashkernel=auto rd.lvm.lv=centos/root rd.lvm.lv=centos/swap rhgb net.ifnames=0 biosdevname=0  quiet"

GRUB_DISABLE_RECOVERY="true"

 

[root@linuxidc.com network-scripts]#  grub2-mkconfig -o /boot/grub2/grub.cfg #重新生成启动菜单

Generating grub configuration file ...

Found linux image: /boot/vmlinuz-3.10.0-327.el7.x86_64

Found initrd image: /boot/initramfs-3.10.0-327.el7.x86_64.img

Found linux image: /boot/vmlinuz-0-rescue-fce34a37d59940fcb01759910e40ece1

Found initrd image: /boot/initramfs-0-rescue-fce34a37d59940fcb01759910e40ece1.img

done

[root@linuxidc.com network-scripts]# reboot  #必须重启系统才可生效

[root@centos7 ~]# vi /etc/sysconfig/network-scripts/route-enp0s3 # 添加永久静态路由
10.15.150.0/24 via 192.168.150.253 dev enp0s3
10.25.250.0/24 via 192.168.150.253 dev enp0s3

重启计算机，或者重新启用设备enp0s3才能生效。
[root@centos7 ~]# nmcli dev connect enp0s3

systemctl stop NetworkManager  #暂时关闭

systemctl disable NetworkManager  #永久关闭
```



参考:

[CentOS7 设置eth0网卡](https://www.linuxidc.com/Linux/2017-06/144973.htm)

[CentOS7 关闭network-manager](https://www.cnblogs.com/clown000000/p/9833606.html)

[CentOS7 设置默认路由](https://www.cnblogs.com/panblack/p/Centos7_Static_Routes.html)