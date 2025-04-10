# Notification Targets Management
---



Set the notification targets for alert events, including system [**default notification targets**](#default) and [**self-built notification targets**](#custom).

## Default Notification Targets {#default}

The system provides default notification channels. When configuring, you need to specify the event notification [Webhook URL](#webhook) and define [notification permissions](#permission) to control operations on notification targets by specific users or roles.


???+ warning "Note"

    DingTalk, WeCom, and Lark bot alert notifications are merged and sent once per minute, with about a one-minute delay.

### Main Configuration {#webhook}

1. Define the name of the current notification target;
2. Configure secrets/Webhook URLs for the current notification target:

    - [DingTalk Bot](./notify-target-dingtalk.md)  
    - [WeCom Bot](./notify-target-wecom.md)    
    - [Lark Bot](./notify-target-lark.md)      
    - [Custom Webhook](./notify-target-webhook.md)     
    - [SMS Group](./notify-target-sms.md)       
    - [Simple HTTP Request](./notify-target-http.md)      
    - [Slack](./notify-target-slack.md)     
    - [Teams](./notify-target-teams.md)      

### Configuration of Operation Permissions {#permission}


After setting the operation permissions for notification targets, the roles, team members, and workspace users in your current workspace will perform corresponding operations on notification targets based on assigned permissions.

| Action      | Description   |
| ------- | ------- |
| Do not enable this configuration      | Follow the [default permissions](../management/role-list.md) for "Notification Target Configuration Management"   |
| Enable this configuration and select custom permission objects      | Only the creator and authorized objects can enable/disable, edit, or delete rules set for this notification target   |
| Enable this configuration but do not select any custom permission objects      | Only the creator has the permission to enable/disable, edit, or delete this notification target   |


???+ warning "Note"

    The Owner role in the current workspace is not affected by the operation permission settings here.

## Self-Built Notification Targets {#custom}

In addition to the system's default notification targets, it also supports integrating external notification channels via third-party Funcs, sending alert information directly to local DataFlux Func.

> For detailed steps, refer to [Integrating Self-Built Notification Targets](https://<<< custom_key.func_domain >>>/doc/practice-guance-self-build-notify-function/).

## Management List

Successfully added notification targets can be viewed on the **Monitoring > Notification Targets Management** page. You can manage the list through the following actions:


- Enable/disable, modify, or delete specific notification targets;
- Batch operations;
- Audit operations: Click to jump and view operation records related to the rules of this notification target;
- Quick filtering: Select filtering conditions from the left-side shortcuts to quickly locate notification rules;
- If the notification target rule does not grant you permission, you cannot enable/disable, edit, or delete it.


<img src="../img/notify_rules_when_no_permission.png" width="60%" >

### System Automatic Disablement

If a notification target rule fails to send externally for two consecutive days, the system will automatically disable that notification rule. Under "Quick Filtering > Status," check the box to quickly view all automatically disabled rules.

<img src="../img/rules_automatically_disabled.png" width="60%" >