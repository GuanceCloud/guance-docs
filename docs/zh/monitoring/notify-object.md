# 通知对象管理
---

<!--
???- quote "更新日志"

    **2024.8.21**：新增启用/禁用配置。

    **2024.6.26**：新增编辑和删除通知对象的权限配置。

    **2024.1.31**：新增通知对象：**简单 HTTP 请求**。

    **2023.9.21**：**邮件组**类型正式下架，已创建的不受影响。后续使用管理 > 成员管理 > 团队功能代替。
-->

设置告警事件的通知对象，包括系统[**默认通知对象**](#default)和[**自建通知对象**](#custom)。

## 默认通知对象 {#default}

您可以选择以下 6 种系统默认通知渠道作为告警通知对象：

- 钉钉机器人
- 企业微信机器人
- 飞书机器人
- Webhook 自定义
- 短信组
- 简单 HTTP 请求

配置时，您需要指定事件通知的目标 [Webhook 地址](#webhook)。此外，您还可以[定义相关通知权限](#permission)，以控制哪些用户或角色可以操作这些通知对象规则。

![](img/3.alert-inform_1.png)

**注意**：钉钉机器人、企业微信机器人和飞书机器人的告警通知会每分钟合并发送一次，而不是即时触发。因此，通知可能存在大约一分钟的延迟。

### 配置 Webhook {#webhook}

#### 钉钉机器人 {#dingding}

为了适配最新的钉钉机器人创建和使用模式，您需先在钉钉开发平台创建企业内部应用机器人。

> 可参考 [企业内部应用机器人的创建和安装](https://open.dingtalk.com/document/orgapp/overview-of-development-process)。

???- warning "钉钉机器人新旧区别"

    - 钉钉平台：创建机器人从**群管理**直接创建变更为在**开发平台创建应用**；   
    - <<< custom_key.brand_name >>>：最新的钉钉机器人密钥配置为非必填项。

:material-numeric-1-circle: 创建企业内部应用机器人

- 申请钉钉开发平台**开发者权限**；

- 创建应用：

<img src="../img/notify_001.png" width="60%" >

1. 选择**应用开发 > 钉钉应用 > 创建应用**，单击创建应用；

2. 应用创建完成后，点击 :material-dots-vertical: 图标下的**应用详情**，前往机器人配置页面填写相关配置；

3. 在目标群里点击**添加机器人**，在企业机器人列表中选择新创建的应用机器人；

4. 获取机器人 Webhook 地址，在机器人管理找到新创建的应用机器人，点击查看详情，复制 Webhook 地址。

<img src="../img/notify_002.png" width="60%" >

**注意**：此处使用机器人仅用于接收信息，不存在交互，**消息接收模式**配置可任意选择，HTTP 模式下地址可以为空。

:material-numeric-2-circle: 回到钉钉机器人配置页面

- 钉钉群组成功添加机器人之后，在机器人配置详情中可查询该机器人的**加签**密钥和 **Webhook** 地址。

- 输入配置信息，包括自定义的通知对象名称、密钥和 Webhook 地址。

<img src="../img/10_inform_03.png" width="60%" >



#### 企业微信机器人 {#work-weixin}

选择**企业微信机器人**，输入配置信息，包括自定义的通知对象名称、Webhook 地址。

企业微信群组成功添加机器人之后，在机器人配置详情中可查询该机器人特有的 **Webhook 地址**。

<img src="../img/10_inform_04.png" width="70%" >

#### 飞书机器人 {#lark}

选择**飞书机器人**，输入配置信息，包括自定义的通知对象名称、Webhook 地址和密钥。

<img src="../img/15.inform_feishu_1.png" width="70%" >

飞书群组成功添加机器人之后，在机器人配置详情中可查询该机器人的**签名校验**和 **Webhook 地址**。

<img src="../img/10_inform_06.png" width="60%" >


#### Webhook 自定义 {#custom-webhook}

选择 **Webhook 自定义**，输入名称、Webhook 地址和成员等信息。

<img src="../img/10_inform_07.png" width="70%" >

最终对外发送的 Webhook 事件通知包含以下内容：

:material-numeric-1-circle-outline: 事件信息：

`bodyType` 为 `json` 文本：

```http
POST http://my-system/accept-webhook
Content-Type: application/json

{
    "timestamp"               : 1625638440,
    "df_status"               : "warning",
    "df_event_id"             : "event-xxxxxxxxxx",
    "df_title"                : "web001存在问题",
    "df_message"              : "web001存在问题\nCPU使用率大于90\n内存使用率大于90",
    "df_dimension_tags"       : "{\"host\":\"web001\"}",
    "df_monitor_id"           : "monitor_xxxxxxxxxx",
    "df_monitor_name"         : "异常检测名",
    "df_monitor_checker_id"   : "rul_xxxxxxxxxx",
    "df_monitor_checker_name" : "异常检测项目名",
    "df_monitor_checker_value": "99",
    "df_event_link"           : "https://<<< custom_key.studio_main_site >>>/keyevents/monitorChart?xxxxxxxxxx"
    "df_workspace_uuid"       : "wksp_xxxxxxxxxx",
    "df_workspace_name"       : "我的工作空间",
    "Result"                  : 99,
    "...其他更多字段": "略",

    // 以下为旧版字段
    "date"          : 1625638440,
    "workspace_uuid": "wksp_xxxxxxxxxx",
    "workspace_name": "我的工作空间",
}
```

:material-numeric-2-circle-outline: 同步追加工作空间[属性声明](../management/attribute-claims.md)。

:material-numeric-3-circle-outline: 在配置 Webhook 通知对象时，可选择配置成员。该条 Webhook 通知对象规则生效后，Webhook 除了会传递上面两种事件信息外，还会将当前配置内输入的成员信息一同对外发送，以便利后续第三方接收到后可以根据成员信息做不同的规则操作。

此处可选成员包含当前工作空间内的所有团队和工作空间成员：


<img src="../img/10_inform_08.png" width="70%" >

> Webhook 自定义通知发送内容的类型仅支持使用 JSON 格式，各字段的详情可参考 [事件产生](../events/index.md#fields)。
>
> 有关 Webhook 自定义更详细的实践文档，可参考 [<<< custom_key.brand_name >>> Webhook 自定义告警通知集成](https://<<< custom_key.func_domain >>>/doc/practice-guance-alert-webhook-integration/)。



#### 短信 {#sms}

选择**短信**，输入所需信息。短信组可同时添加多个成员。

**注意**：

1. 成员需要先在**管理 > 成员管理**中邀请加入到工作空间后才可选择；   
2. 短信组告警通知是每分钟合并了发送，并不是产生后立刻发送，会存在约一分钟的延迟。

<img src="../img/10_inform_09.png" width="70%" >

#### 简单 HTTP 请求 {#http}

选择**简单 HTTP 请求**，输入所需信息，当产生的事件触发告警时，服务会向自定义的 Webhook 地址发送事件所有的告警通知。

<img src="../img/http.png" width="70%" >

### 配置操作权限 {#permission}


设置通知对象的操作权限后，您当前工作空间的角色、团队成员以及空间用户将根据分配的权限，对通知对象执行相应的操作。这确保了不同用户根据其角色和权限级别进行符合配置的操作。

<img src="../img/permission.png" width="70%" >


- 不开启该配置：跟随【通知对象配置管理】的[默认权限](../management/role-list.md)；
- 开启该配置并选定自定义权限对象：此刻仅创建人和被赋予权限的对象可对该条通知对象设置的规则进行启用/禁用、编辑、删除操作；
- 开启该配置，但并未选定自定义权限对象：则仅创建人拥有此通知对象的启用/禁用、编辑、删除权限。

**注意**：当前工作空间的 Owner 角色不受此处操作权限配置影响。



## 自建通知对象 {#custom}

为进一步满足您实际业务的需求，除了系统默认提供的通知对象外，还支持通过第三方 **Func** 接入外部通知渠道，将告警信息直接发送至本地 **DataFlux Func**。

> 具体操作步骤，可参考 [对接自建通知对象](https://<<< custom_key.func_domain >>>/doc/practice-guance-self-build-notify-function/)。


## 管理列表

成功添加的通知对象均可在**监控 > 通知对象管理**页面中进行查看。您可通过以下操作管理列表。


1. 您可在操作处针对特定通知对象进行启用/禁用、修改或删除操作；
2. 批量操作；
3. 操作审计：点击即可跳转查看与该条通知对象规则相关的操作记录；
4. 通过左侧快捷筛选，选定筛选条件后快速定位通知规则；
5. 若通知对象规则未赋予您权限，则无法启用/禁用、编辑或删除。


<img src="../img/notify-3.png" width="70%" >

### 系统自动禁用

如果通知对象规则连续两天对外发送失败，系统会自动禁用该通知规则。

在**快捷筛选 > 状态**下方，勾选按钮后即可快速查看所有被自动禁用的规则。

![](img/notify-1.png)

## 更多阅读


<font size=2>

<div class="grid cards" markdown>

- [<font color="coral"> :fontawesome-solid-arrow-right-long: &nbsp; **告警设置**</font>](../monitoring/alert-setting.md)

</div>

</font>