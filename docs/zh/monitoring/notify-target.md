# 通知对象管理
---



设置告警事件的通知对象，包括系统[**默认通知对象**](#default)和[**自建通知对象**](#custom)。

## 默认通知对象 {#default}

系统提供默认通知渠道。配置时需指定事件通知的 [Webhook 地址](#webhook)，并定义[通知权限](#permission)，控制特定用户或角色操作通知对象规则。


???+ warning "注意"

    钉钉、企业微信和飞书机器人的告警通知每分钟合并发送一次，存在约一分钟延迟。

### 主要配置 {#webhook}

1. 定义当前通知对象的名称；
2. 为当前通知对象配置密钥/ Webhook 地址等信息：

:material-numeric-1-circle: [钉钉机器人](./notify-target-dingtalk.md)  
:material-numeric-2-circle: [企业微信机器人](./notify-target-wecom.md)    
:material-numeric-3-circle: [飞书机器人](./notify-target-lark.md)      
:material-numeric-4-circle: [Webhook 自定义](./notify-target-webhook.md)     
:material-numeric-5-circle: [短信组](./notify-target-sms.md)       
:material-numeric-6-circle: [简单 HTTP 请求](./notify-target-http.md)      
:material-numeric-7-circle: [Slack](./notify-target-slack.md)     
:material-numeric-8-circle: [Teams](./notify-target-teams.md)      

### 配置操作权限 {#permission}


设置通知对象的操作权限后，您当前工作空间的角色、团队成员以及空间用户将根据分配的权限，对通知对象执行相应的操作。

| 操作      | 说明   |
| ------- | ------- |
| 不开启该配置      | 跟随“通知对象配置管理”的[默认权限](../management/role-list.md)   |
| 开启该配置并选定自定义权限对象      | 此刻仅创建人和被赋予权限的对象可对该条通知对象设置的规则进行启用/禁用、编辑、删除操作   |
| 开启该配置，但并未选定自定义权限对象      | 则仅创建人拥有此通知对象的启用/禁用、编辑、删除权限   |


???+ warning "注意"

    当前工作空间的 Owner 角色不受此处操作权限配置影响。

## 自建通知对象 {#custom}

除系统默认通知对象外，还支持通过第三方 Func 接入外部通知渠道，将告警信息直接发送至本地 DataFlux Func。

> 具体操作步骤，可参考 [对接自建通知对象](https://<<< custom_key.func_domain >>>/doc/practice-guance-self-build-notify-function/)。

## 管理列表

成功添加的通知对象均可在**监控 > 通知对象管理**页面中进行查看。您可通过以下操作管理列表：


- 针对特定通知对象进行启用/禁用、修改或删除操作；
- 批量操作；
- 操作审计：点击即可跳转查看与该条通知对象规则相关的操作记录；
- 通过左侧快捷筛选，选定筛选条件后快速定位通知规则；
- 若通知对象规则未赋予您权限，则无法启用/禁用、编辑或删除。


<img src="../img/notify_rules_when_no_permission.png" width="60%" >

### 系统自动禁用

如果通知对象规则连续两天对外发送失败，系统会自动禁用该通知规则。在“快捷筛选 > 状态”下方，勾选按钮后即可快速查看所有被自动禁用的规则。

<img src="../img/rules_automatically_disabled.png" width="60%" >

