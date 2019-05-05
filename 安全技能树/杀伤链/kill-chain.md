# 杀伤链

什么是杀伤链?
“杀伤链”这个概念源自军事领域，它是一个描述攻击环节的六阶段模型，该理论也可以用来反制此类攻击（即反杀伤链）。
杀伤链有7个步骤:
- Reconnaissance
侦查阶段(收集信息的阶段)：从外部观察网络, 获取企业的资源和环境,了解目标的防备脆弱的位置.
- Weaponization
使用漏洞和后门制作一个可发送的武器载体.
- Delivery
载荷投递,比如钓鱼邮件.
- Exploitation
漏洞利用.
- Installation
在目标位置安装恶意软件.
- Command&control(c2)
为攻击者简建立远程控制目标系统的路径.
- Actions on objectives
攻击目的达成.

通过对攻击的建模,增强了对攻击的可见性,并丰富了分析师对对手策略,手段和程序的理解.


# ATT&CK模型

ATT&CK（ Adversarial Tactics, Techniques, and Common Knowledge）是一个反映各个攻击生命周期的攻击行为的模型和知识库。起源于一个项目，用于枚举和分类针对Microsoft Windows™系统的攻陷后的战术，技术和过程（TTP），以改进对恶意活动的检测。目前ATT&CK模型分为三部分，分别是PRE-ATT&CK，ATT&CK for Enterprise和ATT&CK for Mobile，其中PRE-ATT&CK覆盖攻击链模型的前两个阶段，ATT&CK for Enterprise覆盖攻击链的后五个阶段.

参考:

[lockheedmartin 杀伤链理论](https://www.lockheedmartin.com/en-us/capabilities/cyber/cyber-kill-chain.html)

[ATT&CK](https://attack.mitre.org/)

[ATT&CK中文站](https://huntingday.github.io/)

[ATT&CK 安全牛](https://www.aqniu.com/vendor/44748.html)

[ATT&CK Matrix](https://github.com/redcanaryco/atomic-red-team/)