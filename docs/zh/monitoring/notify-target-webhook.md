# Webhook 自定义 

## 通知详情

最终对外发送的 Webhook 事件通知包含以下内容：

### 事件信息

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

## 同步追加工作空间属性声明

> 更多详情，可参考 [属性声明](../management/attribute-claims.md)。

## 选择成员

在配置 Webhook 通知对象时，可选择配置成员。该条 Webhook 通知对象规则生效后，Webhook 除了会传递上面两种事件信息外，还会将当前配置内输入的成员信息一同对外发送，以便利后续第三方接收到后可以根据成员信息做不同的规则操作。

此处可选成员包含当前工作空间内的所有团队和工作空间成员：

<img src="../img/webhook_members.png" width="70%" >

> Webhook 自定义通知发送内容的类型仅支持使用 JSON 格式，各字段的详情可参考 [事件产生](../events/index.md#fields)。
>
> 有关 Webhook 自定义更详细的实践文档，可参考 [<<< custom_key.brand_name >>> Webhook 自定义告警通知集成](https://<<< custom_key.func_domain >>>/doc/practice-guance-alert-webhook-integration/)。



