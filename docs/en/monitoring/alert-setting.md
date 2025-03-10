# Alert Strategies
---

When [Monitors](./monitor/index.md) detect anomalies, they automatically create incident records. By associating monitors with alert strategies, you can ensure that relevant alert notifications are sent to designated recipients in a timely manner.

The configuration of alert strategies not only provides basic features such as name, description, time zone, and operational permissions but also supports flexible definition of notification methods from two dimensions: **Alert Level** and **Notification Targets**. Additionally, you can configure escalation notifications for alert strategies to handle emergencies. At the same time, alert strategies allow you to customize notification times to meet the needs of different scenarios.

For ongoing incidents or specific alert conditions, you can set up repeat alert rules to control notification frequency flexibly. When sending notifications, you can also choose whether to aggregate notification content, delivering information more efficiently and concisely to recipients.

<!--

## Concepts

| Term | Description |
| --- | --- |
| Notification Time Zone | Defines the time zone in which current alert notifications are sent. This defaults to the current [workspace time zone](../management/index.md#workspace). If no configuration is set by owners or administrators, it defaults to the `UTC+8` time zone. |
| Incident Level | Indicates the urgency of an anomaly event. Available levels include **Critical, Major, Warning, Data Gap, Info, All**. |
| [Alert Escalation](#upgrade) | Sometimes simple notification configurations based on level or members do not meet business needs. If a monitor detects multiple occurrences of the same-level anomaly within a short period, it may indicate a persistent issue. To avoid repeated notifications, you can set rules to escalate ongoing anomalies to critical alerts and notify designated recipients to ensure timely attention and resolution. |
| [Custom Notification Time](#custom) | Set specific notification send times using cycles and time dimensions. |
| [Repeat Alerts](#repeat) | You can specify a time interval during which the same event's alert notifications are suppressed. Even if [event](../events/index.md) data continues to be generated, the system will only record but not resend alerts. Event records can be viewed in the event explorer. For example, if an event is not very urgent but has a high alert frequency, you can reduce the frequency by setting a repeat alert notification interval. |
| [Alert Aggregation](#pattern) | Define event data to be sent unaggregated, rule-aggregated, or intelligently aggregated. In the latter two modes, events are merged according to corresponding aggregation rules before being sent. |
| [Aggregation Cycle](#cycle) | Based on rule-based and intelligent aggregation modes, new events within a certain number of minutes are combined into a single alert notification. Once this cycle exceeds, newly occurring events will be included in the next alert notification. |
-->


## Create New {#create}

1. Define the name of the current alert strategy;
2. Optionally input a description for the strategy;
3. Select associated [monitors](#with_monitor);
4. Choose the notification time zone;
5. Choose to configure the alert strategy based on [level](#simple) or based on [members](#member) to trigger notifications;
6. Select the time range for repeat alerts (original alert silence);
7. Optionally choose the [alert aggregation](#pattern) mode to determine the final aggregation form of the alert notification;
8. Optionally add [operational permissions](#permission) to the strategy rules;
9. Click save to successfully create the strategy.

### Associate Monitors {#with_monitor}

On the configuration page, you can click to select monitors associated with the current alert strategy; you can also quickly create new monitors to adapt to new scenarios as needed.

![Associate Monitors](../img/with_monitor.png)

### Notification Rule Configuration {#config}

???+ warning "Configuration Notes"

    - Recovery Notifications: When a previously sent anomaly alert event recovers, the system sends recovery notifications to the corresponding notification targets. For example, if a `Critical` notification was sent to a group for a specific event, when the status starts recovering, a recovery notification will be sent to this group.
    - Notification Delay: Alert notifications are not sent immediately upon generation due to data storage issues and may have a maximum delay of 1 minute.

Currently, two types of notification configurations are supported: level-based and member-based.

In the former, after selecting an event level, you set notification targets for that type of anomaly event. If [filter conditions](#filter) are set, they further restrict the scope of event data under that level, ultimately notifying the target.

In the latter, you first select members or teams, defining the scope of event data they need to pay attention to or manage. Within this data, you then define event levels and corresponding notification targets, achieving strong association between events and targets.

#### :material-numeric-1-circle: Level-Based Notification Configuration {#simple}

Define notification targets for each alert level.

![Notification Configuration](../img/notice-config.png)

1. Select [event levels](monitor/event-level-description.md).

    - A single event level can be selected multiple times;
    - Based on the selected event level, you can link [alert aggregation](#pattern).

2. Choose the notification targets for events at this level.

| <div style="width: 210px">Type</div>      | Description      |
| ----------- | ---------------- |
| Workspace Members      | Email notifications; viewable under Management > Member Management.      |
| Teams      | Email notifications; a team can add multiple workspace members, viewable under Management > Member Management > Team Management.      |
| Email Groups      | Email notifications; an email group can add multiple teams, viewable under Monitoring > Notification Targets Management.      |
| DingTalk/WeCom/Lark Bots      | Group notifications; viewable under Monitoring > Notification Targets Management.      |
| Webhook Custom      | User-defined; viewable under Monitoring > Notification Targets Management.      |
| SMS      | SMS notifications; an SMS group can add multiple workspace members, viewable under Monitoring > Notification Targets Management.<br />[Free Plan](../plans/trail.md) does not support SMS notifications, other versions charge 0.1 yuan per message, billed daily, with no free quota.      |
| Custom External Email      | Enter an email address directly; only available for Commercial Plan and Deployment Plan users.      |

#### :material-numeric-2-circle: Member-Based Notification Configuration {#member}

Configure notification rules based on members to achieve precise point-to-point alert notifications. In a single alert rule, you can configure different notification scopes, levels, methods, and custom notification time ranges for multiple groups of members.

![Member-Based Rule](../img/rule-1.png)

1. Define the name of the notification rule;
2. Select the members and teams to be notified;
3. Add filter conditions to match labels;
4. For filtered event data, set corresponding notification targets for different event levels;
5. Optionally enable [custom notification time range](#custom) configuration.

**Note**: If you configure multiple custom notification time ranges, the system will match them in order from top to bottom and use the first matching time range's notification rule to send alerts.


### Add Filter Conditions {#filter}

Whether configuring notifications based on levels or members, adding specific filter conditions can:

- Further refine the data scope for level-based notifications;
- Limit members or teams to focus on events that match specific labels.

After adding filters, **only events that meet both level requirements and filter conditions will trigger notifications**, enabling more precise management of anomaly event notifications.

![Filter Rules](../img/rule-filter.png)

![Filter Example](../img/rule-filter-1.png)

Clicking the filter button retrieves the current workspace fields and sets filter conditions in `key:value` format. You can choose from the following match types: equals, not equals, wildcard, inverted wildcard, and regular expression. Multiple filter conditions for the same `key` field are OR relationships, while different `key` fields are AND relationships.

You can configure filter conditions in two ways:

- Directly select fields and set conditions on the page.
- Write regular expressions for more complex filtering logic to meet detailed configuration needs.

**Note**: Each alert rule can only add one set of filter conditions, which can contain one or more filter rules. The system combines all rules for condition filtering.

### Escalation Notifications {#upgrade}

If a monitor frequently detects the same-level anomalies within a short period, it might indicate a persistent issue. In such cases, you can add escalation notification rules. When anomalies persist, the system will automatically escalate them to critical alerts and notify designated recipients to ensure timely attention and resolution.

![Escalation Notification](../img/upgrade-notice.png)

If a notification rule configures two escalation notifications:

- When the same-level alerts continue to occur, the system checks the time intervals to determine whether to send the first escalation notification;
- After sending the first escalation notification, the system evaluates the second escalation notification's time interval to decide if a second escalation notification should be sent.

**Note**:
- Each notification rule supports up to two escalation notifications.
- Each escalation notification triggers only once without repeated alerts.

### Custom Notification Time {#custom}

While the discussed scenarios mainly focus on immediate notifications triggered upon detecting anomalies, you can also set specific notification send times as needed.

![Custom Notification Time](../img/notice-config-1.png)

1. Modify the configuration name as needed;
2. Divide event periods based on day, week, month, or custom dimensions;

    - If choosing custom, upload a CSV file, and the system will auto-fill based on the dates in the file. The date format must be `YYYY/MM/DD`, with a maximum of 365 dates.

3. Limit the event generation time based on the selected cycle and send notifications within the specified time window, e.g., selecting `09:00 - 10:00` means events generated within this hour will match the custom configuration;

4. Complete the cycle and time-related configurations, then select alert levels and notification targets.

**Note**:

- In a single custom notification configuration under one alert strategy, if multiple rules are configured, events will be matched in top-to-bottom order, and alerts will be sent based on the first matching rule. If no rule matches, no notification will be sent.

- When configuring monitors and [selecting multiple alert strategies](./monitor/mutation-detection.md#alert), abnormal events will match each selected alert strategy separately after the monitor is enabled.


### Repeat Alerts {#repeat}

Setting repeat alert notifications ensures that although event data continues to generate within a certain time range, no additional alert notifications are sent. Generated data records will be stored in the event explorer.

**Note**: If you choose the "Permanent" repeat alert option, the system sends only the initial alert notification and does not repeat subsequent notifications.

### Alert Aggregation {#pattern}

:material-numeric-1-circle-outline: Unaggregated: Default configuration; in this mode, alert events are merged into a single notification every 20 seconds and sent to the corresponding notification targets;

:material-numeric-2-circle-outline: Rule Aggregation: In this mode, you can choose from four aggregation rules and send alert notifications based on the aggregation cycle:


| <div style="width: 150px"> Aggregation Rule </div>     | Description      |
| ----------- | ---------------- |
| All      | Based on the alert strategy's level dimension, generate corresponding alert notifications within the selected aggregation cycle.      |
| Monitor/Security Check/SLO      | Aggregate notifications based on unique IDs of monitors, security checks, or SLOs linked to the aggregation cycle.      |
| Detection Dimension      | Generate alert notifications based on detection dimensions linked to the aggregation cycle, e.g., `host`.      |
| Tags      | Multi-select; link [global tags](../management/field-management.md) with [monitors](./monitor/index.md#tags) to generate corresponding alert notifications based on the aggregation cycle.<br />:warning: If an event has multiple tag values, it will match the highest-priority tag based on the page configuration order, with multiple tag values having an OR relationship.    |

:material-numeric-3-circle-outline: Intelligent Aggregation: In this mode, events within the aggregation cycle are clustered based on selected `title` or `content`, with each cluster generating a single alert notification.

:material-numeric-4-circle-outline: AI Aggregation: Use <<< custom_key.brand_name >>>'s large model to merge monitoring alerts, reducing redundancy and avoiding a large number of duplicate alerts within a short period.

#### Aggregation Cycle {#cycle}

In rule-based and intelligent aggregation modes, you can manually set a time range (1-30 minutes).

![Aggregation Cycle](../img/alert-1.png)

Within this time frame, new events will be aggregated into a single alert notification. If the aggregation cycle exceeds, new events will be included in the next alert notification.

### Operational Permissions {#permission}

After setting operational permissions for alert strategies, roles, team members, and workspace users in your current workspace will perform operations on alert strategies according to assigned permissions. This ensures that different users operate according to their roles and permission levels.

- Not enabling this configuration: Follow the [default permissions](../management/role-list.md) for "Alert Strategy Configuration Management";
- Enabling this configuration and selecting custom permission objects: Only creators and authorized objects can enable/disable, edit, or delete the rules of this alert strategy;
- Enabling this configuration but not selecting custom permission objects: Only the creator has the permissions to enable/disable, edit, or delete this alert strategy.

**Note**: The Owner role in the current workspace is not affected by these operational permission settings.

## Further Reading

<font size=2>

<div class="grid cards" markdown>

- [<font color="coral"> :fontawesome-solid-arrow-right-long: &nbsp; **Manage Alert Strategy List**</font>](./config-alert-setting.md)

</div>

<div class="grid cards" markdown>

- [<font color="coral"> :fontawesome-solid-arrow-right-long: &nbsp; **Alert Strategies: More Refined Notification Target Configurations**</font>](./alert-strategy.md)

</div>

</font>