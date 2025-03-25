# Notification Targets Management
---

<!--
???- quote "Update Log"

    **2024.8.21**: Added enable/disable configuration.

    **2024.6.26**: Added permission configuration for editing and deleting notification targets.

    **2024.1.31**: Added notification target: **Simple HTTP Request**.

    **2023.9.21**: The **Mail Group** type has been officially phased out, but existing ones will remain unaffected. Subsequent usage should be replaced by Management > Member Management > Team Function.
-->

Set up the notification targets for alert events, including system [**Default Notification Targets**](#default) and [**Custom Notification Targets**](#custom).

## Default Notification Targets {#default}

You can choose from the following 6 system default notification channels as alert notification targets:

- DingTalk Bot
- WeCom Bot
- Lark Bot
- Custom Webhook
- SMS Group
- Simple HTTP Request

When configuring, you need to specify the target [Webhook address](#webhook). Additionally, you can [define relevant notification permissions](#permission) to control which users or roles can operate these notification target rules.

![](img/3.alert-inform_1.png)

**Note**: Alert notifications for DingTalk bots, WeCom bots, and Lark bots are sent once per minute in a merged manner, rather than being triggered instantly. Therefore, there may be approximately a one-minute delay in notifications.

### Configure Webhook {#webhook}

#### DingTalk Bot {#dingding}

To adapt to the latest creation and usage model of DingTalk bots, you must first create an internal enterprise application bot on the DingTalk development platform.

> You can refer to [Creating and Installing Internal Enterprise Application Bots](https://open.dingtalk.com/document/orgapp/overview-of-development-process).

???- warning "Differences Between Old and New DingTalk Bots"

    - DingTalk Platform: Creating a bot has changed from directly creating under **Group Management** to creating an application on the **Development Platform**;
    - <<< custom_key.brand_name >>>: The secret key configuration for the latest DingTalk bot is no longer mandatory.

:material-numeric-1-circle: Create an internal enterprise application bot

- Apply for **Developer Permissions** on the DingTalk development platform;

- Create an application:

<img src="../img/notify_001.png" width="60%" >

1. Select **Application Development > DingTalk Application > Create Application**, click to create the application;

2. After the application is created, click the :material-dots-vertical: icon's **Application Details**, go to the bot configuration page and fill in related configurations;

3. In the target group, click **Add Bot**, select the newly created application bot from the enterprise bot list;

4. Obtain the bot Webhook address, find the newly created application bot in bot management, click to view details, and copy the Webhook address.

<img src="../img/notify_002.png" width="60%" >

**Note**: Here, the bot is only used to receive information, there is no interaction, so the **Message Receiving Mode** configuration can be chosen arbitrarily, and the address can be left blank in HTTP mode.

:material-numeric-2-circle: Return to the DingTalk bot configuration page

- After successfully adding the DingTalk group bot, you can query the bot’s **Signature Key** and **Webhook Address** in the bot configuration details.

- Input configuration information, including a custom notification target name, key, and Webhook address.

<img src="../img/10_inform_03.png" width="60%" >


#### WeCom Bot {#work-weixin}

Select **WeCom Bot**, input configuration information, including a custom notification target name and Webhook address.

After successfully adding a bot to a WeCom group, you can query the bot’s unique **Webhook Address** in the bot configuration details.

<img src="../img/10_inform_04.png" width="70%" >

#### Lark Bot {#lark}

Select **Lark Bot**, input configuration information, including a custom notification target name, Webhook address, and key.

<img src="../img/15.inform_feishu_1.png" width="70%" >

After successfully adding a bot to a Lark group, you can query the bot’s **Signature Verification** and **Webhook Address** in the bot configuration details.

<img src="../img/10_inform_06.png" width="60%" >


#### Custom Webhook {#custom-webhook}

Select **Custom Webhook**, input name, Webhook address, and member information.

<img src="../img/10_inform_07.png" width="70%" >

The final external Webhook event notifications include the following content:

:material-numeric-1-circle-outline: Event Information:

`bodyType` is `json` text:

```http
POST http://my-system/accept-webhook
Content-Type: application/json

{
    "timestamp"               : 1625638440,
    "df_status"               : "warning",
    "df_event_id"             : "event-xxxxxxxxxx",
    "df_title"                : "web001 has issues",
    "df_message"              : "web001 has issues\nCPU usage greater than 90\nMemory usage greater than 90",
    "df_dimension_tags"       : "{\"host\":\"web001\"}",
    "df_monitor_id"           : "monitor_xxxxxxxxxx",
    "df_monitor_name"         : "Anomaly Detection Name",
    "df_monitor_checker_id"   : "rul_xxxxxxxxxx",
    "df_monitor_checker_name" : "Anomaly Detection Item Name",
    "df_monitor_checker_value": "99",
    "df_event_link"           : "https://<<< custom_key.studio_main_site >>>/keyevents/monitorChart?xxxxxxxxxx"
    "df_workspace_uuid"       : "wksp_xxxxxxxxxx",
    "df_workspace_name"       : "My Workspace",
    "Result"                  : 99,
    "...other more fields": "omitted",

    // The following are old version fields
    "date"          : 1625638440,
    "workspace_uuid": "wksp_xxxxxxxxxx",
    "workspace_name": "My Workspace",
}
```

:material-numeric-2-circle-outline: Synchronize and append workspace [Attribute Claims](../management/attribute-claims.md).

:material-numeric-3-circle-outline: When configuring Webhook notification targets, you can choose to configure members. After this Webhook notification target rule takes effect, besides passing the two types of event information above, Webhook will also send the member information entered in the current configuration externally, facilitating subsequent third-party actions based on member information.

Here, selectable members include all teams and workspace members within the current workspace:

<img src="../img/10_inform_08.png" width="70%" >

> The content type for custom Webhook notifications only supports JSON format. For details about each field, refer to [Event Generation](../events/index.md#fields).
>
> For more detailed practice documentation on custom Webhooks, refer to [<<< custom_key.brand_name >>> Custom Webhook Alert Notification Integration](https://<<< custom_key.func_domain >>>/doc/practice-guance-alert-webhook-integration/).



#### SMS {#sms}

Select **SMS**, input required information. An SMS group can add multiple members simultaneously.

**Note**:

1. Members need to be invited into the workspace via **Management > Member Management** before they can be selected;   
2. SMS group alert notifications are sent in a consolidated manner every minute, not immediately after generation, resulting in approximately a one-minute delay.

<img src="../img/10_inform_09.png" width="70%" >

#### Simple HTTP Request {#http}

Select **Simple HTTP Request**, input required information. When an event triggers an alert, the service sends all alert notifications to the custom Webhook address.

<img src="../img/http.png" width="70%" >

### Configure Operation Permissions {#permission}

After setting the operation permissions for notification targets, the roles, team members, and space users of your current workspace will perform corresponding operations on notification targets according to the allocated permissions. This ensures that different users perform operations consistent with their roles and permission levels.

<img src="../img/permission.png" width="70%" >


- Not enabling this configuration: Follows the [default permissions](../management/role-list.md) of the "Notification Target Configuration Management";
- Enabling this configuration and selecting custom permission objects: Only the creator and authorized objects can enable/disable, edit, or delete the rules set for this notification target;
- Enabling this configuration without selecting custom permission objects: Only the creator has the permissions to enable/disable, edit, or delete this notification target.

**Note**: The Owner role of the current workspace is not affected by the operation permission configuration here.



## Custom Notification Targets {#custom}

To further meet your actual business needs, in addition to the default notification targets provided by the system, it also supports integrating external notification channels through third-party **Func**, sending alert information directly to the local **DataFlux Func**.

> Specific operation steps can be found in [Integrating Custom Notification Targets](https://<<< custom_key.func_domain >>>/doc/practice-guance-self-build-notify-function/).


## Management List

All successfully added notification targets can be viewed on the **Monitoring > Notification Targets Management** page. You can manage the list via the following operations.


1. You can enable/disable, modify, or delete specific notification targets at the action location;
2. Batch operations;
3. Operation audit: Click to jump and view the operation records related to this notification target rule;
4. Quick filter via the sidebar allows you to quickly locate notification rules after selecting filtering conditions;
5. If the notification target rule does not grant you permission, you cannot enable/disable, edit, or delete it.


<img src="../img/notify-3.png" width="70%" >

### System Automatic Disablement

If a notification target rule fails to send externally for two consecutive days, the system will automatically disable this notification rule.

Under **Quick Filter > Status**, check the box to quickly view all automatically disabled rules.

![](img/notify-1.png)

## Further Reading


<font size=2>

<div class="grid cards" markdown>

- [<font color="coral"> :fontawesome-solid-arrow-right-long: &nbsp; **Alert Setting**</font>](../monitoring/alert-setting.md)

</div>

</font>