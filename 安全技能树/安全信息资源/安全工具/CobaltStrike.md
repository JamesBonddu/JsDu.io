# CobaltStrike

## 侦察 Reconnaissance
利用 System profile系统分析器发现目标系统的客户端应用程序.

## 后渗透 Post Exploitation
Beacon是CobaltStrike的有效载荷,可用来执行powershell脚本,记录键盘,截图屏幕,下载文件,生成其他有效负载等.

## 攻击包 Attack Packages

将文件转换为木马:
- Java Applet攻击
- Microsoft Office文档
- Microsoft Windows程序
- 网站克隆工具

## 隐蔽沟通 Covert Communication
信标的网络指标具有可塑性.加载C2配置文件使其看起来像另一个攻击者.使用HTTP,HTTPS,和DNS去egress a network.通过SMB协议,使用命名管道去控制信标,点对点.

## 鱼叉网络钓鱼

发送钓鱼邮件

## 浏览器透视
使用浏览器数据透视图以双因素身份验证和访问网站作为目标.

## 合作

连接到 teamserver共享数据,实时通讯以及参与过程中控制受到危害的系统.

## 报告和记录

根据红队的活动提供一个时间表和指标单,这些报告旨在使我们的同行在安全运营中收益。可以导出为PDF和MS Word.

信标的HTTP指标由Malleable C2配置文件控制.它指定如何转换数据并将其存储在事务中.转换和存储数据的相同配置文件也可以从事务中提取和恢复数据。

```sh
# 启动时指定配置文件
./teamserver [外部IP] [密码] [/path/to/my.profile]
# c2lint检查通信配置文件的语法,应用一些额外的检查甚至随机数据对配置文件进行单元测试.
./c2lint  [/path/to/my.profile]

# 配置文件参考
https://github.com/rsmudge/Malleable-C2-Profiles
```

参考:

[cobaltstrike](https://www.cobaltstrike.com/)

[CobaltStrike 安装](https://blog.csdn.net/qq_36374896/article/details/83961496)

[cobaltstrike 安装破解教程](https://www.cnblogs.com/haq5201314/p/7040832.html)

[DLL Hijacking 和 COM Hijacking Bypass UAC](https://zhuanlan.zhihu.com/p/55025929)

[Malleable Command and Control](https://www.cobaltstrike.com/help-malleable-c2)