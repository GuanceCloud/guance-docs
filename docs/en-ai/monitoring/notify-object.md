# Notification Targets Management
---

???- quote "Changelog"

    **2024.8.21**: Added enable/disable configuration.

    **2024.6.26**: Added permission configuration for editing and deleting notification targets.

    **2024.1.31**: Added notification target: **Simple HTTP Request**.

    **2023.9.21**: The **Email Group** type has been officially discontinued, but existing ones remain unaffected. Use the team feature under management > member management instead.


Guance supports setting up notification targets for alert events, including system [**default notification targets**](#default) and [**user-defined notification targets**](#custom).

## Default Notification Targets {#default}

Choose from six channels as notification targets: DingTalk bot, Work WeChat bot, Feishu bot, custom Webhook, SMS group, and simple HTTP request. Configure the [Webhook address](#webhook) to send event notifications. Additionally, you can [define related notification permissions](#permission) to control which users or roles can operate these notification target rules.

![](img/3.alert-inform_1.png)

**Note**: DingTalk bots, Work WeChat bots, and Feishu bots consolidate and send alerts every minute, not immediately upon generation, so there will be **approximately a one-minute delay**.

### Configure Webhook {#webhook}

#### DingTalk Bot {#dingtalk}

To adapt to the latest creation and usage model of DingTalk bots, you need to first create an internal application bot on the DingTalk developer platform. After completion, log in to Guance to create a new DingTalk bot.

> Refer to [Creation and Installation of Internal Application Bots](https://open.dingtalk.com/document/orgapp/overview-of-development-process).

???- warning "Differences between old and new DingTalk bots"

    - DingTalk Platform: Creating bots has changed from direct creation in **Group Management** to creating applications on the **Developer Platform**.
    - Guance: The latest DingTalk bot secret key configuration is no longer mandatory.

:material-numeric-1-circle: Create an internal application bot

- Apply for **developer permissions** on the DingTalk developer platform;

- Create an application:

<img src="../img/notify_001.png" width="60%" >

1. Select **Application Development > DingTalk Application > Create Application**, click to create an application;

2. After the application is created, click the :material-dots-vertical: icon's **Application Details**, go to the bot configuration page and fill in the relevant configurations;

3. In the target group, click **Add Bot**, select the newly created application bot from the enterprise bot list;

4. Obtain the bot Webhook address by finding the newly created application bot in bot management, clicking view details, and copying the Webhook address.

<img src="../img/notify_002.png" width="60%" >

**Note**: This bot is used only for receiving information and does not require interaction. The **message reception mode** can be configured arbitrarily, and the address can be left blank in HTTP mode.

:material-numeric-2-circle: Return to the DingTalk bot configuration page

- After successfully adding the bot to the DingTalk group, you can query the bot's **signing** key and **Webhook** address in the bot configuration details.

- Enter the configuration information, including a custom notification target name, key, and Webhook address.

<img src="../img/10_inform_03.png" width="60%" >

<!--
<img src="../img/10_inform_02.png" width="70%" >
-->


#### Work WeChat Bot {#work-weixin}

Select **Work WeChat Bot**, enter the configuration information, including a custom notification target name and Webhook address.

After successfully adding the bot to the Work WeChat group, you can query the bot's specific **Webhook** address in the bot configuration details.

<img src="../img/10_inform_04.png" width="70%" >

#### Feishu Bot

Select **Feishu Bot**, enter the configuration information, including a custom notification target name, Webhook address, and key.

<img src="../img/15.inform_feishu_1.png" width="70%" >

After successfully adding the bot to the Feishu group, you can query the bot's **signature verification** and **Webhook** address in the bot configuration details.

<img src="../img/10_inform_06.png" width="60%" >


#### Custom Webhook {#custom-webhook}

Select **Custom Webhook**, enter the name, Webhook address, and member information.

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
    "df_monitor_checker_name" : "Anomaly Detection Item Name",
    "df_monitor_checker_value": "99",
    "df_event_link"           : "https://console.guance.com/keyevents/monitorChart?xxxxxxxxxx"
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

:material-numeric-2-circle-outline: Synchronize additional workspace [Attribute Claims](../management/attribute-claims.md).

:material-numeric-3-circle-outline: When configuring Webhook notification targets, you can choose to configure members. After this Webhook notification target rule takes effect, in addition to the two types of event information mentioned above, the current configured member information will also be sent externally to facilitate different rule operations by third parties based on member information.

This includes all teams and workspace members within the current workspace:

<img src="../img/10_inform_08.png" width="70%" >

> Webhook custom notifications only support JSON format for sending content. For detailed field descriptions, refer to [Event Generation](../events/index.md#fields).
>
> For more detailed practical documentation on custom Webhooks, refer to [Guance Webhook Custom Alert Notification Integration](https://func.guance.com/doc/practice-guance-alert-webhook-integration/).



#### SMS

Select **SMS**, enter the required information. An SMS group can add multiple members simultaneously.

**Note**:

1. Members must first be invited into the workspace via **Management > Member Management** before they can be selected;
2. SMS group alert notifications are consolidated and sent every minute, not immediately upon generation, so there will be approximately a one-minute delay.

<img src="../img/10_inform_09.png" width="70%" >

#### Simple HTTP Request {#http}

Select **Simple HTTP Request**, enter the required information. When an event triggers an alert, the service sends all alert notifications to the custom Webhook address.

<img src="../img/http.png" width="70%" >

### Configure Operation Permissions {#permission}


After setting up operation permissions for notification targets, users in your current workspace, including roles, team members, and space users, will perform corresponding operations based on assigned permissions. This ensures that different users perform operations according to their roles and permission levels.

<img src="../img/permission.png" width="70%" >


- If this configuration is not enabled: Follow the [default permissions](../management/role-list.md) for [notification target configuration management];
- If this configuration is enabled and custom permission objects are selected: Only the creator and the assigned permission objects can enable/disable, edit, or delete the notification target rules;
- If this configuration is enabled but no custom permission objects are selected: Only the creator has the permission to enable/disable, edit, or delete the notification target rules.

**Note**: The Owner role of the current workspace is not affected by this operation permission configuration.

<!--

**Note**:

1. The owner of the current workspace defaults to having the permissions to create, edit, and delete this notification target;
2. The creator of the current notification target configuration rule defaults to having the permissions to edit and delete this notification target.
-->

## User-defined Notification Targets {#custom}

To further meet your actual business needs, in addition to the default notification targets provided by Guance, you can integrate external notification channels through third-party Func to notify directly to local DataFlux Func.

> For specific steps, refer to [Connecting User-defined Notification Targets](https://func.guance.com/doc/practice-guance-self-build-notify-function/).


## Management List

Successfully added notification targets can be viewed on the **Monitoring > Notification Targets Management** page. You can manage the list through the following operations.


1. You can enable/disable, modify, or delete specific notification targets from the operation section;
2. Batch operations;
3. Operation audit: Click to view the operation records related to the notification target rules;
4. Quick filter on the left side: Quickly locate notification rules after selecting filtering conditions;
5. If you do not have permission for the notification target rules, you cannot enable/disable, edit, or delete them.


<img src="../img/notify-3.png" width="70%" >

### System Auto-disable

If a notification target rule fails to send externally for two consecutive days, Guance will automatically disable the notification rule.

Under **Quick Filter > Status**, check the button to quickly view all automatically disabled rules.

![](img/notify-1.png)

## Further Reading


<font size=3>

<div class="grid cards" markdown>

- [<font color="coral"> :fontawesome-solid-arrow-right-long: &nbsp; **Alert Settings**</font>](../monitoring/alert-setting.md)

</div>

</font>