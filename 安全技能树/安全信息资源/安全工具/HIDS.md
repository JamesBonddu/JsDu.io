## HIDS

OSSEC分为三部分:
Manager(or Server): Agents通过1514/udp端口连接Server,agents可以通过这个端口和server沟通.
Agents

Systemd 中的service分为 agent和server:
- server

agentless.service
analysisd.service
csyslog.service
dbd.service
execd.service
logcollector.service
maild.service
monitord.service
remoted.service

参考:

[ossec-hids github](https://github.com/ossec/ossec-hids)

[ossec doc](http://www.ossec.net/docs/index.html)