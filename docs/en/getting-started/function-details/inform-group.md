# Notification Grouping
---

Good notifications can bridge the gap with users, enabling timely, effective, and precise transmission of information. However, a large number of users are suffering from chaotic notification bombardments, receiving too many notifications daily which become annoying while useful information gets drowned in unimportant push messages. Especially during system development and operations, timely alerts and responses are crucial. Any delay in troubleshooting can result in significant losses. If system alert notifications get lost among numerous messages, users will be unable to identify current faults and take appropriate actions, leading to escalating losses over time and irreparable negative impacts on business.

<<< custom_key.brand_name >>> offers multi-channel notification grouping management, allowing you to meaningfully group notification information together and distribute it through various channels. This helps you gain a quick overview of more information, preventing redundant notifications and inefficient alerts caused by cross-information. Additionally, if your application notifications can be managed uniformly in groups, it will make it easier for you to configure notification targets and alert silencing.

## Prerequisites

You need to first create a [<<< custom_key.brand_name >>> account](https://<<< custom_key.brand_main_domain >>>), install DataKit on your host [DataKit Installation](../../datakit/datakit-install.md), enable the operation of relevant integrations, and proceed with data collection.

## Custom Grouping

Custom grouping allows you to create meaningful notification combinations, such as purpose and scope, notification channels, and notification targets. This will help you focus on allocating and managing routine message notifications, ensuring that information reaches the right people more accurately.

### Purpose and Scope

<<< custom_key.brand_name >>> supports you in building custom monitors according to your needs and managing alert notifications issued by these monitors via group labels. You can use the custom group label feature to group notifications with the same attributes or categories (such as: HOSTs, APM, user experience, SLOs, etc.), so that notifications for a specific purpose or scope are only sent to the corresponding responsible person, avoiding unnecessary cross-information and increasing the speed of notification processing.

When setting up custom monitor detection rules, simply **add group labels** to associate monitors uniformly, enabling centralized management of monitors under the same group.

![](../img/5.inform_group_1.png)

In the **Monitors** list, clicking the **Group Name** or the **Alert Notifications** button allows you to configure event notification levels, alert notification members, and alert silence durations for monitors within the same group.

![](../img/5.inform_group_2.png)

This aggregates your notification messages by group and automatically calculates "2 alerts from <<< custom_key.brand_name >>>", helping you reduce the number of notifications and handle related events more efficiently.

![](../img/5.inform_group_3.png)

### Notification Targets and Channels

With the rise of online working, group messages, personal notifications, email notifications, and task reminders keep coming in one after another. Grouping by notification channels can simplify things, meeting communication needs in more scenarios with fewer notifications and richer notification methods.

Through **Manage > Notification Targets**, set the notification targets for alert events (including DingTalk bots, WeCom bots, Lark bots, Webhook customizations, email groups, and SMS groups) to ensure that related anomaly detection notifications are pushed in real-time to the responsible parties.

- Email Groups: You can combine multiple workspace members as notification targets and have notifications distributed via email;
- DingTalk bots, WeCom bots, Lark bots: You can set workgroups as notification targets, achieving real-time information synchronization and task distribution;
- Webhook customization: Define your own notification method and content for greater flexibility;
- SMS: Set SMS notifications to meet different scene and terminal device requirements, providing more pathways for notifications to reach the relevant individuals and ensuring real-time delivery.

![](../img/5.inform_group_4.png)

## Unified Management

Unified message management centralizes and distributes notifications belonging to the same group. <<< custom_key.brand_name >>> helps you reduce ineffective information bombardment by supporting unified configuration of mute rules and notification targets for groups.

### Group Silencing

If an event is not very urgent but has a high alert notification frequency, you can reduce the frequency of alert notifications by setting alert silencing. <<< custom_key.brand_name >>>'s group silencing supports setting alert silencing for groups. Groups set to **alert silencing** will not send alert notifications during the silent period.

In the **Monitoring** function, click **Create Silence Rule** to start creating a new group silencing configuration, including setting the silent scope, silent duration, silent notification targets, notification content, and notification times.

![](../img/5.inform_group_5.png)

### Notification Target Management

As IT scales grow larger and systems become more complex, operations and maintenance work has been subdivided into network operations, system operations, software operations, basic environment operations, security engineers, etc. Each细分 position is responsible for maintaining and ensuring the high availability of a particular service. Binding notifications for a specific service to the responsible party enables point-to-point information transmission, increasing the effectiveness of notifications.

<<< custom_key.brand_name >>> supports configuring one or more notification targets uniformly for monitor groups. You can add **workspace members**, **email groups**, **DingTalk bots**, **WeCom bots**, **Lark bots**, and **Webhook customizations** as notification targets to achieve point-to-point information transmission.

![](../img/5.inform_group_6.png)