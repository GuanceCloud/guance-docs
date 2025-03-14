# Notification Grouping
---

Effective notifications can bridge the gap with users, enabling timely, efficient, and precise information dissemination. However, many users are overwhelmed by disorganized notifications, receiving too many messages that obscure important alerts amidst trivial ones. This is especially critical during system development and operations, where timely alerts and responses are essential. Any delay in troubleshooting can result in significant losses. If system alert notifications are buried among numerous messages, users may miss current issues and fail to take appropriate actions, leading to escalating losses and irreparable negative impacts on business.

<<< custom_key.brand_name >>> offers multi-channel notification grouping management, allowing you to meaningfully combine notification information and distribute it through various channels. This helps you gain a clear overview of more information, preventing duplicate notifications and inefficient alerts caused by overlapping information. Additionally, if your application notifications can be managed uniformly in groups, it will be easier for you to configure notification targets and alert silencing.

## Prerequisites

You need to first create a [<<< custom_key.brand_name >>> account](https://<<< custom_key.brand_main_domain >>>), and install DataKit on your host [Install DataKit](../../datakit/datakit-install.md) to enable relevant integrations and collect data.

## Custom Grouping

Custom grouping allows you to create meaningful notification combinations based on purpose, scope, notification channels, and notification targets. This helps you centrally allocate and manage daily notifications, ensuring that information reaches the right people more accurately.

### Purpose and Scope

<<< custom_key.brand_name >>> supports creating custom monitors according to your needs and managing alert notifications from these monitors via group labels. You can use the custom group label feature to group notifications of the same attribute or category (such as hosts, APM, user experience, SLOs, etc.), ensuring that notifications for a specific purpose or scope are sent only to the responsible parties, avoiding unnecessary overlaps and increasing notification processing speed.

When configuring monitoring rules for custom monitors, simply **add group labels** to associate monitors under the same group, allowing centralized management of monitors within the same group.

![](../img/5.inform_group_1.png)

In the **Monitors** list, click the **Group Name** or the **Alert Notification** button to centrally configure event notification levels, alert notification members, and alert silence durations for monitors in the same group.

![](../img/5.inform_group_2.png)

This aggregates your notification messages by group and automatically calculates "2 alerts from <<< custom_key.brand_name >>>," helping you reduce notification entries and focus on relevant events.

![](../img/5.inform_group_3.png)

### Notification Targets and Channels

With the rise of online work, group messages, personal notifications, email notifications, and task reminders can be overwhelming. Grouping by notification channels can streamline this complexity, reducing the number of notifications while enriching the notification methods to meet communication needs in various scenarios.

Through **Manage > Notification Targets Management**, set up notification targets for alert events (including DingTalk bots, WeCom bots, Lark bots, Webhook custom, email groups, and SMS groups) to ensure real-time delivery of anomaly detection notifications to the responsible parties.

- Email Groups: You can combine multiple workspace members as notification targets and distribute notifications via email.
- DingTalk bots, WeCom bots, Lark bots: Set up workgroups as notification targets for real-time information synchronization and task distribution.
- Webhook Custom: Define your own notification method and content for greater flexibility.
- SMS: Set up SMS notifications to meet different scene and device requirements, ensuring more pathways to reach relevant individuals and guaranteeing timeliness.

![](../img/5.inform_group_4.png)

## Unified Management

Unified message management centralizes and distributes notifications from the same group, reducing unnecessary information overload. <<< custom_key.brand_name >>> supports configuring unified mute rules and notification targets for groups to minimize ineffective information bombardment.

### Group Muting

If an event is not very urgent but has a high alert frequency, you can reduce the alert notification frequency by setting up alert muting. <<< custom_key.brand_name >>>'s group muting feature allows you to set alert silencing for groups. Monitors in a **muted** group do not send alert notifications during the mute period.

In the **Monitoring** function, click **Create Mute Rule** to start configuring a new group mute rule, including setting mute scope, mute duration, mute notification targets, notification content, and notification time.

![](../img/5.inform_group_5.png)

### Notification Target Management

As IT scales and systems become more complex, operations and maintenance have evolved from hardware maintenance into specialized roles such as network operations, system operations, software operations, infrastructure operations, and security engineers. Each role must maintain and ensure the high availability of specific services. Binding service notifications to the responsible parties ensures point-to-point information delivery, increasing notification effectiveness.

<<< custom_key.brand_name >>> supports configuring one or more notification targets for monitor groups. You can add **workspace members**, **email groups**, **DingTalk bots**, **WeCom bots**, **Lark bots**, and **Webhook custom** as notification targets to achieve point-to-point information delivery.

![](../img/5.inform_group_6.png)