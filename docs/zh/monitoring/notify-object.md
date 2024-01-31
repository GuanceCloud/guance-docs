# 通知对象管理
---

???- quote "更新日志"

    **2024.1.31**：新增通知对象——**简单 http 请求**

    **2023.9.21**：**邮件组**类型正式下架，已创建的不受影响。后续使用管理 > 成员管理 > 团队功能代替。


观测云支持设置告警事件的通知对象，包括系统**默认通知对象**（钉钉机器人、企业微信机器人、飞书机器人、Webhook 自定义、短信组和简单 http 请求）和**自建通知对象**。

> 关于如何设置告警通知，可参考 [告警设置](../monitoring/alert-setting.md)。

## 默认通知对象 {#default}

进入**监控 > 通知对象管理 > 新建通知对象**，选择钉钉机器人、企业微信机器人、飞书机器人、Webhook自定义、短信、简单 http 请求后，输入对应配置信息后，点击**确认**即可完成新建通知对象。

**注意**：钉钉机器人、企业微信机器人、飞书机器人告警通知是每分钟合并了发送，并不是产生后立刻发送，会存在约一分钟的延迟。

![](img/3.alert-inform_1.png)

### 1、新建钉钉机器人 {#dingding}

为了适配最新的钉钉机器人创建和使用模式，用户需先在钉钉开发平台创建企业内部应用机器人，创建完成后，登录观测云新建钉钉机器人。

> 可参考[企业内部应用机器人的创建和安装](https://open.dingtalk.com/document/orgapp/overview-of-development-process)。

???+ warning "钉钉机器人新旧区别"

    - 钉钉平台：创建机器人从**群管理**直接创建变更为在**开发平台创建应用**；   
    - 观测云：最新的钉钉机器人密钥配置为非必填项。

1）创建企业内部应用机器人

- 申请钉钉开发平台**开发者权限**；

- 创建应用。

创建步骤：

步骤一：选择**应用开发 > 钉钉应用 > 创建应用**，单击创建应用。

![](img/notify_001.png)

步骤二：点击应用详情，在机器人配置页面填写相关配置后发布即可。

![](img/notify_002.png)

**注意**：此处使用机器人仅用于接收信息，不存在交互，**消息接收模式**配置可任意选择，HTTP 模式下地址可以为空。

步骤三：在目标群里点击**添加机器人**，在企业机器人列表中选择新创建的应用机器人，点击添加、完成。

步骤四：获取机器人 Webhook 地址，在机器人管理找到新创建的应用机器人，点击查看详情，复制 Webhook 地址。

2）登录观测云，配置钉钉机器人

进入**监控 > 通知对象管理 > 新建通知对象**，选择**钉钉机器人**，输入配置信息，包括自定义的通知对象名称、密钥和 Webhook 地址。

<img src="../img/10_inform_02.png" width="70%" >

钉钉群组成功添加机器人之后，在机器人配置详情中可查询该机器人的**加签**密钥和 **Webhook** 地址。

<img src="../img/10_inform_03.png" width="70%" >


### 2、新建企业微信机器人 {#work-weixin}

选择**企业微信机器人**，输入配置信息，包括自定义的通知对象名称、Webhook 地址。

<img src="../img/10_inform_04.png" width="70%" >

企业微信群组成功添加机器人之后，在机器人配置详情中可查询该机器人特有的 **Webhook 地址**。

### 3、新建飞书机器人

选择**飞书机器人**，输入配置信息，包括自定义的通知对象名称、Webhook 地址和密钥。

<img src="../img/15.inform_feishu_1.png" width="70%" >

飞书群组成功添加机器人之后，在机器人配置详情中可查询该机器人的**签名校验**和 **Webhook 地址**。

<img src="../img/10_inform_06.png" width="70%" >


### 4、新建 Webhook 自定义

选择 **Webhook 自定义**，输入所需信息。

<img src="../img/10_inform_07.png" width="70%" >

Webhook 自定义通知类型为 `HTTPRequest`，会向指定的地址发送纯文本 POST 请求。 

假设用户配置的地址为 `[http://my-system/accept-webhook](http://my-system/accept-webhook)`，产生的告警标题和内容分别为: 

标题：

```
您的 ECS 存在问题
```

内容：

```
您的 ECS 存在以下问题: 
- CPU 使用率过高(92%) 
- 内存使用率过高(81%)
```

发送的请求会根据所配置的请求类型不同而不同：

1）当 `bodyType` 不指定或为 `text` 时，请求详情如下：

```http
POST http://my-system/accept-webhook
Content-Type: text/plain

您的 ECS 存在问题

您的 ECS 存在以下问题：
- CPU 使用率过高（92%）
- 内存使用率过高（81%）
```

其中，第 1 行为事件标题 `df_title`，第 2 行为空行，之后所有内容为事件内容 `df_message`。

2）当 `bodyType` 为 `json` 时，请求详情如下：

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
    "df_event_link"           : "https://console.guance.com/keyevents/monitorChart?xxxxxxxxxx"
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

**注意**：在 Webhook 对外同步事件信息时，会同步追加工作空间[属性声明](../management/attribute-claims.md)。

> Webhook 自定义通知发送内容的类型仅支持使用 JSON 格式，各字段的详情可参考 [事件产生](../events/index.md#fields)。
>
> 有关 Webhook 自定义更详细的实践文档，可参考 [观测云 Webhook 自定义告警通知集成](https://func.guance.com/doc/practice-guance-alert-webhook-integration/)。

<!--
### 5、新建邮件组

进入**监控 > 通知对象管理 > 新建通知对象**，选择**邮件组**，输入所需信息。邮件组可同时添加多个成员。

???+ warning

    - 成员需要先在**管理 > 成员管理**中邀请加入到工作空间后才可选择；   
    - 邮件组告警通知是每分钟合并了发送，并不是产生后立刻发送，会存在约一分钟的延迟。

![](img/10_inform_08.png)
-->

### 5、新建短信

选择**短信**，输入所需信息。短信组可同时添加多个成员。

**注意**：

- 成员需要先在**管理 > 成员管理**中邀请加入到工作空间后才可选择；   
- 短信组告警通知是每分钟合并了发送，并不是产生后立刻发送，会存在约一分钟的延迟。

<img src="../img/10_inform_09.png" width="70%" >

### 6、新建简单 HTTP 请求 {#http}

选择**简单 HTTP 请求**，输入所需信息：

<img src="../img/http.png" width="70%" >


## 自建通知对象 {#custom}

观测云除提供默认通知对象外，还支持您通过第三方 Func 接入外部通知渠道形式，实现自建通知对象并对齐发送相关告警信息。

> 更多详情，可参考 [对接自建通知对象](https://func.guance.com/doc/practice-guance-self-build-notify-function/)。


## 通知对象列表操作

成功添加通知对象后，可在**监控 > 通知对象管理**页面中进行查看。您可修改或删除特定通知对象。

![](img/notify-1.png)



