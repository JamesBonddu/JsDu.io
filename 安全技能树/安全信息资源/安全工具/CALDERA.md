### CALDERA

CALDERA专注于后渗透阶段.它包含一个逻辑编码,用于描述该技术的要求(前置条件)和技术的效果(后置条件).
对手仿真的核心是red team,但是对手仿真不是使用攻击者的一般心态,而是采用特定现实世界对手的方法,参与的重点是让仿真团队和防御者共同努力改进系统,网络和防御过程,以更好地检测对手生命周期中使用的技术.

限制: 1.决定不模仿C2,原因是已经存在几种模拟C2网络流量的工具.通过关注仿真的其他方面产生更大的影响.
    - 实用角度: CALDERA最初是为测试基于主机的防御和传感器而创建的.基于主机的防御主要使用主机上的活动而不是网络上的。
    - 哲学角度: C2协议很容易改变,且由很多变化,不同的差异会很大.

```sh
git clone https://github.com/mitre/caldera.git --recursive
docker-compose up
```

默认账户密码
username: admin
password: caldera

Logic是CALDERA能够自动运行的核心部分.每一个敌手动作,称为步骤在CALDERA包含的步骤的要求和影响的逻辑描述.
CALDERA解析这些逻辑描述,以告知何时可以运行Step并预测Ste的结果.这让CALDERA通过迭代检测给定当前状态的那些步骤是可以执行的,选择步骤,然后根据逻辑规则生成该步骤的输出状态来生成[计划][planning]

[caldera](https://caldera.readthedocs.io/en/latest/)

[docker-compose install](https://docs.docker.com/compose/install/)

[caldera install](https://caldera.readthedocs.io/en/latest/installation.html)

[AI planning](https://www.isi.edu/~blythe/cs541/)
