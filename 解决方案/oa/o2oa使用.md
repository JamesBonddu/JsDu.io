# 使用手册

## 系统内置角色权限说明

https://www.yuque.com/o2oa/course/un97gd

O2OA平台内置19种不同的系统角色，适应于各类应用的权限控制。本篇主要简单讲述初平台拥有的角色列表以及如何对指定的应用进行权限设置

组织管理
角色管理

|角色名称|角色中文名称|角色功能说明|
| :--- | :--- | :---|
|QueryManager|数据中心管理员|可以在数据中心进行视图管理，统计管理等操作|
|AttendanceManager|考勤系统管理员|可以管理考勤系统，拥有数据导入，分析，统计的权限|
|BSSManager|论坛系统管理员|可以在论坛系统中创建栏目、版块，以及对其进行各类权限设置|
|CalendarManager|日程管理系统管理员|拥有在日程管理应用中进行系统设置，权限配置等权限|
|CRMManager|客户关系系统管理员|可以在客户关系管理系统中进行各类设置和权限管理|
|CMSManager|信息管理系统管理员|可以在信息管理系统中进行栏目、分类的管理以及各类权限的管理|
|OKRManager|目标管理系统管理员|可以在目标和工作管理系统中进行各类配置管理|
|RoleManager|角色管理系统管理员|可以在组织管理-角色管理中进行所有角色信息的各类管理操作|
|PortalManager|门户管理系统管理员|可以在门户管理平台中进行门户应用的创建以及各类管理操作|
|OrganizationManager|组织管理系统管理员|可以在组织管理-组织架构中进行组织架构、人员、群组以及角色相关的配置和管理功能创建以及各类管理操作|
|ProcessPlatformCreator|流程应用创建者|可以在流程应用管理平台中对流程应用进行创建操作|
|MeetingManager|会议管理系统管理员|可以在会议管理系统中对会议室，办公楼以及系统设置进行各类管理操作|
|ProcessPlatformManager|流程平台系统管理员|可以在流程应用管理平台中对流程应用进行创建，对流程、表单、视图以及权限进行各类管理操作|
|GroupManager|群组信息管理员|可以在组织管理-群组信息管理中对群组信息进行各类管理操作|
|PersonManager|人员信息管理员|可以在组织管理-人员信息管理中对人员信息进行各类管理操作|
|UnitManager|组织信息管理员|可以在组织管理-组织架构中对组织信息进行各类管理操作|
|Manager|系统管理员|可以对平台各个系统进行各类管理操作|
|MessageManager|消息管理员|可以对系统中产生的消息进行管理|
|SearchPrivilege|搜索管理员|可以跨权限对系统内容进行搜索|


流程管理平台
应用权限

可用范围：可以使用该应用，即在办公中心可以看到该应用。
管理者：可以管理该应用以及开发设计。

流程权限

启动人：可启动该流程的人员。
启动组织：可启动该流程的组织(即该组织下的所有人员都可以启动流程)。
注：如果“启动人”，“启动组织”不配置人员或组织；那么全部人员可以启动该流程。
管理者：对该流程下的所有文档有编辑保存权限。
阅读者：对该流程下的所有文档有查看权限。

内容管理平台
栏目权限

可见范围：可在信息平台看到该栏目。
发布者：可以发布该栏目信息。
管理者：可以对该栏目进行管理设计。

分类权限

可见范围：可在信息平台看到该分类。
发布者：可以发布该分类信息。
管理者：可以对该分类进行管理设计。

数据中心平台
视图配置

带权限：该视图显示满足范围里配置条件并且当前登录人员有权限查看的文档。
忽略：该视图显示满足范围里配置条件的所有文档。

系统设置
系统部署-模块部署

点击编辑

是否可见：菜单栏是否可见(当选择否时，可访问列表和拒绝访问列表设置无效)。
可访问列表：可以在菜单栏看到该应用。
拒绝访问列表：在菜单栏看不到该应用。


## 使用交互命令行


```sh
root@iZuf6dazrfkcp2hvovep4iZ:/data/oa/o2server# ./console_linux.sh 
console start, type close to exit console.

help
read command:help
 help                                   show usage message.
 start|stop [all]                       start stop all enable server.
 start|stop data                        start stop data server.
 start|stop storage                     start stop storage server.
 start|stop center                      start stop center server.
 start|stop application                 start stop application server.
 start|stop web                         start stop web server.
 setPassword (oldpasswd) (newpasswd)    change initial manager password.
 create encrypt key                     create random RSA key.
 version                                show available update version.
 exit                                   exit after stop.
 ctl -<argument> option                 system control command, no argument display help.
```

## 修改密码

https://www.o2oa.net/course/nw7x8d.html

## 创建组织架构及个人信息

https://www.yuque.com/o2oa/course/iu1r2u


## 报销流程审批设计

https://www.yuque.com/o2oa/course/sg3dge