#!/bin/sh

# Ref: https://github.com/NaturalHistoryMuseum/scratchpads2/wiki/Install-Docker-and-Docker-Compose-(Centos-7)
# https://www.alibabacloud.com/help/zh/doc-detail/60742.htm
# install wget, git
function InstallWget()
{
  yum install -y wget
  yum groupinstall -y "Development Tools"
  yum install -y gettext-devel openssl-devel perl-CPAN perl-devel zlib-devel
}

Environment=/etc/profile
function InstallGo()
{
  wget https://dl.google.com/go/go1.12.linux-amd64.tar.gz -O go.tar.gz;
  tar -zxf go.tar.gz -C /home;
  echo "export PATH=$PATH:/home/go/bin" >> $Environment;
  source /etc/profile
}

function InstallGit()
{
  wget https://github.com/git/git/archive/v2.1.2.tar.gz -O git.tar.gz;
  tar -zxf git.tar.gz;
  cd git-* && 
  make configure &&
  ./configure --prefix=/usr/local &&
  make install;
}

function InstallDocker()
{
  yum install -y yum-utils device-mapper-persistent-data lvm2;
  yum-config-manager --add-repo http://mirrors.aliyun.com/docker-ce/linux/centos/docker-ce.repo;
  yum install -y docker-ce;
  systemctl enable docker.service 
  systemctl start docker.service
}

InstallWget
InstallGo
InstallGit
InstallDocker


