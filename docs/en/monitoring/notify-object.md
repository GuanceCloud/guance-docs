# Notification Targets
---

???- quote "Release Note"

    **September 21, 2023**: The **Email Group** type has been officially discontinued, but existing ones are not affected. The **Team** function under **Management > Member Management** can be used as a replacement.


Guance supports setting notification targets for alert events, including default notification targets (DingTalk, WeCom and Lark Robots, Webhook and SMS Groups) and custom notification targets.

> For information on how to set up alert notifications, see [Alert Setting](../monitoring/alert-setting.md).

## Default Notification Targets {#default}

To create a new notification target, go to **Monitoring > Notification Targets > Create** and select one of the following: DingTalk, WeCom and Lark Robots, Webhook and SMS Groups. Enter the corresponding configuration information and click **Confirm** to complete the creation of the notification target.

**Note**: The alert notifications for DingTalk, WeCom and Lark Robots are sent every minute in a merged format, rather than immediately after the event occurs. There may be a delay of about a minute.

![](img/3.alert-inform_1.png)

### 1. Create a DingTalk Robot {#dingding}

To create a new DingTalk Robot, go to **Monitoring > Notification Targets > Create** and select DingTalk Robot. Enter the configuration information, including a custom notification target name, key and webhook address.

<img src="../img/10_inform_02.png" width="70%" >

After successfully adding a DingTalk robot to a group, you can find the signing key and webhook address in the robot's configuration details.

<img src="../img/10_inform_03.png" width="70%" >


### 2. Create a WeCom Robot {#work-weixin}

To create a new WeCom Robot, go to **Monitoring > Notification Targets > Create** and select WeCom Robot. Enter the configuration information, including a custom notification target name and webhook address.

<img src="../img/10_inform_04.png" width="70%" >

After successfully adding a WeCom robot to a group, you can find the webhook address specific to that robot in the robot's configuration details.


### 3. Create a Lark Robot

To create a new Lark Robot, go to **Monitoring > Notification Targets > Create** and select Lark Robot. Enter the configuration information, including a custom notification target name, webhook address, and key.

<img src="../img/15.inform_feishu_1.png" width="70%" >

After successfully adding a Lark robot to a group, you can find the signature verification and webhook address in the robot's configuration details.

<img src="../img/10_inform_06.png" width="70%" >


### 4. Create a Webhook

To create a new Webhook, go to **Monitoring > Notification Targets > Create** and select Webhook. Enter the required information.

<img src="../img/10_inform_07.png" width="70%" >

The Webhook notification type is `HTTPRequest`, which sends a plain text POST request to the specified address. 

Assuming the user's configured address is `[<http://my-system/accept-webhook>](<http://my-system/accept-webhook>)`, the generated alert title and content are as follows:

Title:

```
Error in ECS
```

Content:

```
Your ECS has the following issues:
- High CPU usage (92%)
- High memory usage (81%)
```

The sent request will vary depending on the configured request type:

1. When bodyType is not specified or is text, the request details are as follows:

```http
POST <http://my-system/accept-webhook>
Content-Type: text/plain

Your ECS has issues

Your ECS has the following issues:
- High CPU usage (92%)
- High memory usage (81%)
```

In the above example, the first line is the event title `df_title`, followed by an empty line, and then the event content `df_message`.

2. When `bodyType` is `json`, the request details are as follows:

```http
POST <http://my-system/accept-webhook>
Content-Type: application/json

{
    "timestamp"               : 1625638440,
    "df_status"               : "warning",
    "df_event_id"             : "event-xxxxxxxxxx",
    "df_title"                : "web001 has issues",
    "df_message"              : "web001 has issues\\nCPU usage is greater than 90\\nMemory usage is greater than 90",
    "df_dimension_tags"       : "{\\"host\\":\\"web001\\"}",
    "df_monitor_id"           : "monitor_xxxxxxxxxx",
    "df_monitor_name"         : "Abnormal Detection",
    "df_monitor_checker_id"   : "rul_xxxxxxxxxx",
    "df_monitor_checker_name" : "Abnormal Detection Project",
    "df_monitor_checker_value": "99",
    "df_event_link"           : "<https://console.guance.com/keyevents/monitorChart?xxxxxxxxxx>",
    "df_workspace_uuid"       : "wksp_xxxxxxxxxx",
    "df_workspace_name"       : "My Workspace",
    "Result"                  : 99,
    "...more fields": "omitted",

    // The following are old version fields
    "date"          : 1625638440,
    "workspace_uuid": "wksp_xxxxxxxxxx",
    "workspace_name": "My Workspace"
}
```

**Note**: When synchronizing event information to an external system via Webhook, the workspace [attribute claims](../management/attribute-claims.md) will be appended.

> The Webhook notification only supports sending content in JSON format. For details of each field, see [Event Generation](../events/index.md#fields).
>
> 有For more detailed documentation on Webhook Custom, see [Guance Webhook Alert Notification Integration](https://func.guance.com/doc/practice-guance-alert-webhook-integration/).


### 5. Create an SMS Group

To create a new SMS Group, go to **Monitoring > Notification Targets > Create** and select SMS. Enter the required information. Multiple members can be added to an SMS group.

**Note**:

- Members need to be invited to join the workspace through **Management > Member Management** before they can be selected.
- The SMS group alert notifications are sent every minute in a merged format, rather than immediately after the event occurs. There may be a delay of about a minute.

<img src="../img/10_inform_09.png" width="70%" >

## Custom Notification Targets {#custom}

In addition to providing default notification targets, Guance also supports custom notification targets through third-party Func integration, allowing you to create your own notification targets and align them with relevant alert information.

> For more details, see [Integrating Custom Notification Targets](https://func.guance.com/doc/practice-guance-self-build-notify-function/).


## List Options

After successfully adding notification targets, you can view them on the **Monitoring > Notification Targets** page. You can modify or delete specific notification targets.

![](img/notify-1.png)



