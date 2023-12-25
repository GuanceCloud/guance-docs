# Notification Object Management
---

Guance supports you to set notification objects of alarm events through "Management"-"Notification Object Management", including Dingding robot, enterprise WeChat robot, flying book robot, Webhook customization, mail group and SMS group. Refer to the documentation [alarm settings](../monitoring/alert-setting.md) for how to set up alarm notifications.


## New Notification Object

Enter "Management"-"Notification Object Management", click "New Notification Object", select "Nail Robot"/"Enterprise WeChat Robot"/"Feishu Robot"/"Webhook Custom"/"Mail Group"/"SMS Group", enter the corresponding configuration information, and click "Confirm" to complete the new notification object.

![](img/10.inform_1.png)

### 1. New nailing robot {#dingding}

Enter "Management"-"Notification Object Management", click "New Notification Object", select "Nailing Robot", and enter configuration information, including custom notification object name, key and Webhook address.

???+ warning

    The nail robot alarm notification is sent every minute, not immediately after it is generated, and there will be a delay of about one minute.

![](img/10_inform_02.png)

钉钉机器人的配置信息支持您通过在**钉钉群组**添加机器人之后，在机器人配置详情中查询该机器人**「加签」密钥和「Webhook」地址。**

![](img/10_inform_03.png)


### 2. Build a New Enterprise WeChat Robot {#work-weixin}

Enter "Management"-"Notification Object Management", click "New Notification Object", select "Enterprise WeChat Robot", and enter configuration information, including custom notification object name and Webhook address.

???+ attention
    
    Enterprise WeChat robot alarm notification is combined and sent every minute, not immediately after it is generated, and there will be a delay of about one minute.

![](img/10_inform_04.png)

The configuration information of enterprise WeChat robot supports you to query the unique **Webhook address** of the robot in the robot configuration details after adding the robot to **enterprise WeChat group**.


### 3. New Flying Book Robot

Enter "Management"-"Notification Object Management", click "New Notification Object", select "Flying Book Robot", and enter configuration information, including custom notification object name, Webhook address and key. 

???+ attention
    
    The alarm notification of flying book robot is sent every minute, not immediately after it is generated, and there will be a delay of about one minute. 

![](img/15.inform_feishu_1.png)

飞书机器人的配置信息支持您通过在**飞书群组**添加机器人之后，在机器人配置详情中查询该机器人**「签名校验」和「Webhook地址」。**

![](img/10_inform_06.png)


### 4. New Webhook Customization

Enter "Management"-"Notification Object Management", click "New Notification Object", select "Webhook Customization", and enter the required information.

![](img/10_inform_07.png)

Webhook custom notification type `HTTPRequest` sends a plain text POST request to the specified address.  

Assuming the user-configured address is `[http://my-system/accept-webhook](http://my-system/accept-webhook)`, the resulting alarm header and content are:  

Title: 

```
There is a problem with your ECS 
```

Content:

```
Your ECS has the following issues:
- High CPU utilization (92%)
- Overused memory (81%)
```

The requests sent will vary according to the type of request configured:

:material-numeric-1-circle-outline: When `bodyType` is not specified or `text`, the request details are as follows:

```http
POST http://my-system/accept-webhook
Content-Type: text/plain

There is a problem with your ECS

Your ECS has the following issues:
- High CPU utilization （92%）
- Overused memory (81%）
```

Where 1st is the event header `df_title`, 2nd is a blank line, and everything thereafter is the event content`df_message`。

:material-numeric-2-circle-outline: When `bodyType` is `json`, the request details are as follows:

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

Note: Webhook supports only the json format for the type of content sent by custom notifications. See the document [event generation](../events/generating.md).

For more detailed practice documentation on Webhook customization, please refer to《[Guance Webhook custom alert notification integration](../dataflux-func/guance-alert-webhook-integration.md)》

### 5. Create a New Message Group

Enter "Management"-"Notification Object Management", click "New Notification Object", select "Mail Group", and enter the required information. Mail groups can add more than one member at a time.

???+ warning

    - Members need to be invited to join the workspace in "Management"-"Member Management" before they can be selected.
    - Mail group alert notifications are sent every minute combined, not immediately after they are generated, with a delay of about one minute.

![](img/10_inform_08.png)

### 6. Create a New SMS Group

Enter "Management"-"Notification Object Management", click "New Notification Object", select "SMS", and enter the required information. SMS groups can add more than one member at a time.

???+ warning

    - Members need to be invited to join the workspace in "Management"-"Member Management" before they can be selected.
    - SMS group alerts are sent every minute combined, not immediately after generation, with a delay of about one minute.

![](img/10_inform_09.png)

## Modify/Delete Notification Object

After the notification object has been successfully added, it can be viewed on the Management-Notification Object Management page. At the same time, you can modify or delete the notification objects in each list.



