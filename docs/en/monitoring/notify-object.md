# Notification Targets Management
---

<!--
???- quote "Update Log"

    **2024.8.21**: Added enable/disable configuration.

    **2024.6.26**: Added permission configuration for editing and deleting notification targets.

    **2024.1.31**: Added notification target: **Simple HTTP Request**.

    **2023.9.21**: The **Email Group** type has been officially discontinued, but existing ones remain unaffected. Future use should be replaced by management > member management > team functionality.
-->

Set up notification targets for alert events, including system [**default notification targets**](#default) and [**user-defined notification targets**](#custom).

## Default Notification Targets {#default}

You can choose from the following 6 system default notification channels as alert notification targets:

- DingTalk Bot
- WeCom Bot
- Lark Bot
- Custom Webhook
- SMS Group
- Simple HTTP Request

When configuring, you need to specify the target [Webhook URL](#webhook). Additionally, you can [define related notification permissions](#permission) to control which users or roles can operate these notification target rules.

![](img/3.alert-inform_1.png)

**Note**: Alert notifications via DingTalk Bot, WeCom Bot, and Lark Bot are merged and sent once per minute, not triggered instantly. Therefore, there may be a delay of about one minute in notifications.

### Configure Webhook {#webhook}

#### DingTalk Bot {#dingding}

To adapt to the latest creation and usage model of DingTalk bots, you need to create an internal enterprise application bot on the DingTalk developer platform first.

> Refer to [Creation and Installation of Internal Enterprise Application Bots](https://open.dingtalk.com/document/orgapp/overview-of-development-process).

???- warning "Differences between Old and New DingTalk Bots"

    - DingTalk Platform: Creating a bot has changed from direct creation under **Group Management** to creating an application on the **Developer Platform**;
    - <<< custom_key.brand_name >>>: The latest DingTalk bot secret key configuration is no longer mandatory.

:material-numeric-1-circle: Create an internal enterprise application bot

- Apply for **developer privileges** on the DingTalk developer platform;

- Create an application:

<img src="../img/notify_001.png" width="60%" >

1. Select **App Development > DingTalk App > Create App**, then click to create an app;

2. After the app is created, click the :material-dots-vertical: icon under **App Details** to go to the bot configuration page and fill in the relevant configurations;

3. In the target group, click **Add Bot**, and select the newly created app bot from the list of enterprise bots;

4. Obtain the bot's Webhook URL by finding the new created app bot in bot management, clicking to view details, and copying the Webhook URL.

<img src="../img/notify_002.png" width="60%" >

**Note**: This bot is only used for receiving information and does not interact. The **message reception mode** configuration can be chosen arbitrarily, and the address can be left blank in HTTP mode.

:material-numeric-2-circle: Return to the DingTalk bot configuration page

- After successfully adding the bot to the DingTalk group, you can query the bot’s **signing** key and **Webhook** URL in the bot configuration details.

- Enter configuration information, including a custom notification target name, key, and Webhook URL.

<img src="../img/10_inform_03.png" width="60%" >


#### WeCom Bot {#work-weixin}

Select **WeCom Bot**, enter configuration information, including a custom notification target name and Webhook URL.

After successfully adding the bot to the WeCom group, you can query the bot’s specific **Webhook URL** in the bot configuration details.

<img src="../img/10_inform_04.png" width="70%" >

#### Lark Bot

Select **Lark Bot**, enter configuration information, including a custom notification target name, Webhook URL, and key.

<img src="../img/15.inform_feishu_1.png" width="70%" >

After successfully adding the bot to the Lark group, you can query the bot’s **signature verification** and **Webhook URL** in the bot configuration details.

<img src="../img/10_inform_06.png" width="60%" >


#### Custom Webhook {#custom-webhook}

Select **Custom Webhook**, enter the name, Webhook URL, and members information.

<img src="../img/10_inform_07.png" width="70%" >

The final external Webhook event notification contains the following content:

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
    "df_message"              : "web001 has issues\nCPU usage exceeds 90%\nMemory usage exceeds 90%",
    "df_dimension_tags"       : "{\"host\":\"web001\"}",
    "df_monitor_id"           : "monitor_xxxxxxxxxx",
    "df_monitor_name"         : "Anomaly Detection Name",
    "df_monitor_checker_id"   : "rul_xxxxxxxxxx",
    "df_monitor_checker_name" : "Anomaly Detection Project Name",
    "df_monitor_checker_value": "99",
    "df_event_link"           : "https://console.guance.com/keyevents/monitorChart?xxxxxxxxxx"
    "df_workspace_uuid"       : "wksp_xxxxxxxxxx",
    "df_workspace_name"       : "My Workspace",
    "Result"                  : 99,
    "...other additional fields": "omitted",

    // The following are legacy fields
    "date"          : 1625638440,
    "workspace_uuid": "wksp_xxxxxxxxxx",
    "workspace_name": "My Workspace",
}
```

:material-numeric-2-circle-outline: Synchronize and append workspace [Attribute Claims](../management/attribute-claims.md).

:material-numeric-3-circle-outline: When configuring Webhook notification targets, you can choose to configure members. After this Webhook notification target rule takes effect, besides passing the two types of event information mentioned above, it will also send the member information entered in the current configuration externally, facilitating different rule operations based on member information by third parties after receiving it.

This option includes all teams and workspace members within the current workspace:

<img src="../img/10_inform_08.png" width="70%" >

> Webhook custom notification sending content type supports JSON format only. For detailed information on each field, refer to [Event Generation](../events/index.md#fields).
>
> For more detailed practical documentation on custom Webhooks, refer to [<<< custom_key.brand_name >>> Webhook Custom Alert Notification Integration](https://<<< custom_key.func_domain >>>/doc/practice-guance-alert-webhook-integration/).



#### SMS

Select **SMS**, enter the required information. An SMS group can add multiple members simultaneously.

**Note**:

1. Members must first be invited into the workspace through **Management > Member Management** before they can be selected;   
2. SMS group alert notifications are merged and sent every minute, not immediately after generation, so there may be a delay of about one minute.

<img src="../img/10_inform_09.png" width="70%" >

#### Simple HTTP Request {#http}

Select **Simple HTTP Request**, enter the required information. When an event triggers an alert, the service sends all alert notifications to the custom Webhook URL.

<img src="../img/http.png" width="70%" >

### Configure Operation Permissions {#permission}

After setting up operation permissions for notification targets, your current workspace roles, team members, and space users will perform corresponding operations on notification targets according to the allocated permissions. This ensures that different users perform actions consistent with their roles and permission levels.

<img src="../img/permission.png" width="70%" >

- Not enabling this configuration: follows the [default permissions](../management/role-list.md) for [Notification Target Configuration Management];
- Enabling this configuration and selecting custom permission objects: only the creator and authorized objects can enable/disable, edit, or delete the notification target rules;
- Enabling this configuration without selecting custom permission objects: only the creator has the enable/disable, edit, and delete permissions for this notification target.

**Note**: The Owner role of the current workspace is not affected by this operation permission configuration.

## User-defined Notification Targets {#custom}

To further meet your actual business needs, in addition to the default notification targets provided by the system, you can integrate external notification channels via third-party **Func** and send alert information directly to local **DataFlux Func**.

> For specific operation steps, refer to [Integration with User-defined Notification Targets](https://<<< custom_key.func_domain >>>/doc/practice-guance-self-build-notify-function/).


## Management List

Successfully added notification targets can be viewed on the **Monitoring > Notification Targets Management** page. You can manage the list through the following operations.


1. You can enable/disable, modify, or delete specific notification targets at the operation location;
2. Batch operations;
3. Operation audit: click to jump to view operation records related to the notification target rule;
4. Quick filtering on the left side: select filtering conditions to quickly locate notification rules;
5. If you do not have permission for the notification target rule, you cannot enable/disable, edit, or delete it.


<img src="../img/notify-3.png" width="70%" >

### System Automatic Disablement

If a notification target rule fails to send externally for two consecutive days, the system will automatically disable that notification rule.

Under **Quick Filter > Status**, check the box to quickly view all automatically disabled rules.

![](img/notify-1.png)

## Further Reading


<font size=2>

<div class="grid cards" markdown>

- [<font color="coral"> :fontawesome-solid-arrow-right-long: &nbsp; **Alert Setting**</font>](../monitoring/alert-setting.md)

</div>

</font>