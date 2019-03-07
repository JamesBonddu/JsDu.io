#!/bin/sh

function ChangeYum()
{
  cd /etc/yum.repos.d &&
  echo "curr_path:"${pwd} &&
  mv CentOS-Base.repo CentOS-Base.repo.bk &&
  curl -O http://mirrors.aliyun.com/repo/Centos-7.repo &&
  mv Centos-7.repo CentOS-Base.repo &&
  yum  -y update;
}


# Ref: https://linux.cn/article-8310-1.html
# https://stackoverflow.com/questions/5955548/how-do-i-use-sed-to-change-my-configuration-files-with-flexible-keys-and-values

function UpdateKernel()
{
  echo "Update Kernel!"
  rpm --import https://www.elrepo.org/RPM-GPG-KEY-elrepo.org;
  rpm -Uvh http://www.elrepo.org/elrepo-release-7.0-2.el7.elrepo.noarch.rpm;
  yum --enablerepo=elrepo-kernel install -y kernel-ml;  
  sed -i '/^GRUB_DEFAULT=/s/=.*/=0/' /etc/default/grub
  grub2-mkconfig -o /boot/grub2/grub.cfg

  echo "ready to reboot!"
  reboot
} 

echo "== ChangeYum! =="
ChangeYum
UpdateKernel


