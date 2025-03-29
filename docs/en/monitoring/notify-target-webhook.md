# Custom Webhook 

## Notification Details

The final outgoing Webhook event notification includes the following content:

### Event Information

`bodyType` is `json` text:

```http
POST http://my-system/accept-webhook
Content-Type: application/json

{
    "timestamp"               : 1625638440,
    "df_status"              : "warning",
    "df_event_id"            : "event-xxxxxxxxxx",
    "df_title"               : "web001 has an issue",
    "df_message"             : "web001 has an issue\nCPU usage is greater than 90\nMemory usage is greater than 90",
    "df_dimension_tags"      : "{\"host\":\"web001\"}",
    "df_monitor_id"          : "monitor_xxxxxxxxxx",
    "df_monitor_name"        : "Name of Anomaly Detection",
    "df_monitor_checker_id"  : "rul_xxxxxxxxxx",
    "df_monitor_checker_name": "Name of Anomaly Detection Item",
    "df_monitor_checker_value": "99",
    "df_event_link"          : "https://<<< custom_key.studio_main_site >>>/keyevents/monitorChart?xxxxxxxxxx"
    "df_workspace_uuid"      : "wksp_xxxxxxxxxx",
    "df_workspace_name"      : "My Workspace",
    "Result"                 : 99,
    "...other additional fields": "omitted",

    // The following are legacy fields
    "date"          : 1625638440,
    "workspace_uuid": "wksp_xxxxxxxxxx",
    "workspace_name": "My Workspace",
}
```

## Synchronized Additional Workspace Attribute Claims

> For more details, refer to [Attribute Claims](../management/attribute-claims.md).

## Select Members

When configuring Webhook notification targets, you can choose to configure members. After this Webhook notification target rule takes effect, in addition to passing the two types of event information mentioned above, Webhook will also send out the member information entered in the current configuration, making it convenient for subsequent third parties to perform different rule operations based on the member information.

Here, selectable members include all teams and workspace members within the current workspace:

<img src="../img/webhook_members.png" width="70%" >

> The type of content sent in custom Webhook notifications only supports JSON format. For details about each field, refer to [Event Generation](../events/index.md#fields).
>
> For a more detailed practical document on custom Webhooks, refer to [<<< custom_key.brand_name >>> Custom Webhook Alert Notification Integration](https://<<< custom_key.func_domain >>>/doc/practice-guance-alert-webhook-integration/).