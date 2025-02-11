# Notification Grouping
---

Effective notifications can bridge the gap with users, enabling timely, efficient, and precise information dissemination. However, many users are overwhelmed by chaotic notifications, receiving too many messages daily that are often irrelevant, burying useful information in unimportant push notifications. This is especially critical during system development and operations, where timely alerts and responses are essential. Delays in troubleshooting can cause significant losses. If system alert notifications are buried among numerous other messages, users may not be able to identify current issues and take appropriate actions, leading to escalating losses over time and potentially irreversible negative impacts on business.

Guance provides multi-channel notification grouping management, allowing you to meaningfully combine notification information and distribute it through various channels. This helps you gain a clearer overview of more information, preventing duplicate notifications and inefficient alerts caused by overlapping information. Additionally, if your application notifications can be managed uniformly in groups, it will make it easier for you to configure notification targets and alert silencing.

## Prerequisites

You need to first create a [Guance account](https://www.guance.com), and install DataKit on your host machine [Install DataKit](../../datakit/datakit-install.md) to enable relevant integrations for data collection.

## Custom Grouping

Custom grouping allows you to create meaningful notification combinations based on purpose, scope, notification channels, and notification targets. This helps you centrally allocate and manage daily required message notifications, ensuring more accurate delivery of information to relevant individuals.

### Purpose and Scope

Guance supports creating custom monitors based on your needs and managing alert notifications from these monitors via group labels. You can use the custom group label feature to group notifications by the same attribute or category (such as hosts, APM, user experience, SLOs, etc.), ensuring that notifications for a specific purpose or scope are sent only to the corresponding responsible person. This avoids unnecessary information overlap and increases the speed of notification handling.

When defining custom monitor detection rules, simply **add a group label** to associate monitors uniformly, allowing centralized management of monitors within the same group.

![](../img/5.inform_group_1.png)

In the **Monitors** list, click the **Group Name** or the **Alert Notification** button to centrally configure event notification levels, alert notification members, and alert silence durations for monitors within the same group.

![](../img/5.inform_group_2.png)

This aggregates your notification messages into groups and automatically calculates "2 alerts from Guance," helping you reduce the number of notifications and focus on related events.

![](../img/5.inform_group_3.png)

### Notification Targets and Channels

With the rise of online work, group messages, personal notifications, email notifications, and to-do items can be overwhelming. Grouping by notification channels can streamline this process, reducing the number of notifications and providing richer notification methods to meet more communication needs.

Through **Management > Notification Targets Management**, set up notification targets for alert events (including DingTalk bots, WeChat Work bots, Feishu bots, custom Webhooks, email groups, and SMS groups) to ensure real-time delivery of anomaly detection notifications to the relevant responsible parties.

- Email Groups: You can combine multiple workspace members as notification targets and distribute notifications via email.
- DingTalk bots, WeChat Work bots, Feishu bots: Set workgroup notifications for real-time information synchronization and task distribution.
- Custom Webhooks: Define notification methods and content for greater flexibility.
- SMS: Set up SMS notifications to meet different scenarios and terminal device needs, ensuring more paths to reach relevant individuals and guaranteeing timeliness.

![](../img/5.inform_group_4.png)

## Unified Management

Unified message management centralizes and distributes notifications from the same group, helping reduce unnecessary information overload. Guance supports unified configuration of silencing rules and notification targets for groups to minimize ineffective notifications.

### Group Silencing

If an event is not extremely urgent but has a high alert frequency, you can reduce the alert frequency by setting up alert silencing. Guance's group silencing feature allows you to set alert silencing for a group. Monitors in a **silenced** group will not send alert notifications during the specified silent period.

In the **Monitoring** function, click **Create Silence Rule** to start configuring a new group silencing rule, including setting the silence scope, silence duration, silence notification targets, notification content, and notification timing.

![](../img/5.inform_group_5.png)

### Notification Target Management

As IT scales and systems become more complex, operations have evolved from initial hardware maintenance to specialized roles such as network operations, system operations, software operations, infrastructure operations, and security engineers. Each role is responsible for maintaining the high availability of specific services. Binding service notifications to the relevant responsible parties ensures point-to-point information delivery, increasing the effectiveness of notifications.

Guance supports configuring one or more notification targets for monitor groups. You can add **workspace members**, **email groups**, **DingTalk bots**, **WeChat Work bots**, **Feishu bots**, and **custom Webhooks** as notification targets to achieve point-to-point information delivery.

![](../img/5.inform_group_6.png)