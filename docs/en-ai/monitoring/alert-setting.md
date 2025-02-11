# Alert Policy
---

When the [monitor](./monitor/index.md) detects an anomaly, it creates an incident record. By associating monitors with alert policies, timely notifications can be sent to relevant parties.

In addition to basic features such as name, description, timezone, and operation permissions, Guance provides the ability to define how alerts are notified based on **severity levels and members**. It also includes escalation notification functionality and allows customizing notification times.

To handle ongoing incidents or meet specific alert conditions, you can set up repeat alert rules to control notification frequency. When sending notifications, you can choose whether to aggregate them for more efficient communication.

<!--

## Concept Explanation

| Term | Description |
| --- | --- |
| Notification Timezone | Defines the timezone in which the current alert notification is sent. The default shows the current [workspace timezone](../management/index.md#workspace). If not configured by the owner or administrator, it defaults to `UTC+8`. |
| Incident Severity | Indicates the urgency of the incident. Available severities include **Critical, Major, Warning, Data Gap, Info, All**. |
| [Alert Escalation](#upgrade) | Simple notification configurations based on severity or members may not meet business needs. If a monitor detects multiple identical incidents within a short period, it might indicate a persistent issue. To avoid repetitive notifications, you can set rules to escalate continuous incidents to critical notifications and send them to designated recipients for timely attention and resolution. |
| [Custom Notification Time](#custom) | Set the exact time for notifications using both periodic and time dimensions. |
| [Repeat Alerts](#repeat) | You can specify a time interval during which the same incident will suppress repeated notifications. Even if [incident](../events/index.md) data continues to occur, the system only records but does not resend alerts. Event records can be viewed in the Explorer. For example, if an incident is not urgent but has high notification frequency, you can reduce the frequency by setting a repeat alert interval. |
| [Alert Aggregation](#pattern) | Define how event data is aggregated before sending notifications: no aggregation, rule-based aggregation, or intelligent aggregation. In the latter two modes, events are merged according to specified rules before being sent. |
| [Aggregation Period](#cycle) | Merge new events within a specified number of minutes into a single alert notification. Once this period exceeds, new events will be included in the next alert notification. |

-->


## Start Creating {#create}

1. Define the name of the current alert policy.
2. Optionally input a description for the policy.
3. Select the [associated monitors](#with_monitor).
4. Choose the notification timezone.
5. Select alert policies that trigger notifications based on [severity](#simple) or [members](#member).
6. Choose the time range for repeat alert suppression (mute duration).
7. Optionally select the [alert aggregation](#pattern) mode to determine the final aggregation form of notifications.
8. Optionally add [operation permissions](#permission) to the policy rules.
9. Click save to create the policy successfully.

### Associate Monitors {#with_monitor}

On the configuration page, you can click to select monitors associated with the current alert policy; you can also quickly create new monitors to adapt to new scenarios.

![Associate Monitors](../img/with_monitor.png)

### Notification Rule Configuration {#config}

???+ warning "Configuration Notes"

    - Recovery Notifications: When a previously sent incident alert recovers, Guance sends recovery notifications to the corresponding notification targets. For example, if a `Critical` notification was sent to a group for a related event, when this state starts recovering, a recovery notification will be sent to the group.
    - Notification Delay: Alert notifications are not sent immediately upon generation due to data indexing issues, resulting in a maximum delay of 1 minute.

Currently, two types of notification configurations are supported: based on severity and based on members.

The former involves selecting a severity level and defining notification targets for that type of incident. If [filter conditions](#filter) are set, they further restrict the event data scope under a certain severity level before sending notifications.

The latter involves first selecting members or teams and defining the event data they need to focus on or be responsible for. Within this data scope, you can then define severity levels and corresponding notification targets, achieving strong association between events and targets.

#### :material-numeric-1-circle: Severity-Based Notification Configuration {#simple}

Define notification targets for each severity level.

![Severity-Based Notification Configuration](../img/notice-config.png)

1. Select [incident severity](monitor/event-level-description.md).

    - A severity level can be selected multiple times.
    - Based on the selected severity, you can link [alert aggregation](#pattern).

2. Select the notification targets for incidents at this severity level.

| <div style="width: 210px">Type</div>      | Description      |
| ----------- | ---------------- |
| Workspace Members      | Email notifications; viewable in Management > Member Management.      |
| Teams      | Email notifications; a team can include multiple workspace members, viewable in Management > Member Management > Team Management.      |
| Email Groups      | Email notifications; an email group can include multiple teams, viewable in Monitoring > Notification Targets Management.      |
| DingTalk/WeCom/Flying Book Bots      | Group notifications; viewable in Monitoring > Notification Targets Management.      |
| Webhook Custom      | User-defined; viewable in Monitoring > Notification Targets Management.      |
| SMS      | SMS notifications; an SMS group can include multiple workspace members, viewable in Monitoring > Notification Targets Management.<br />SMS notifications are not available in the Free Plan; other plans charge 0.1 yuan per message, billed daily, with no free quota.      |
| Custom External Email      | Enter an email address and press Enter; available only to Commercial Plan and Deployment Plan users.      |


#### :material-numeric-2-circle: Member-Based Notification Configuration {#member}

Configure notification rules based on members for precise point-to-point alert notifications. In one alert rule, you can configure different notification scopes, severities, methods, and custom notification time ranges for multiple member groups.

![Member-Based Notification Configuration](../img/rule-1.png)

1. Define the name of the notification rule.
2. Select the members and teams to notify.
3. Add filter conditions to match tags.
4. For filtered event data, set corresponding notification targets for different severity levels.
5. Optionally enable [custom notification time range](#custom) configuration.

**Note**: If you configure multiple custom notification time ranges, Guance matches them from top to bottom, ultimately applying the first matching time range for alert notifications.


### Add Filter Conditions {#filter}

Adding specific filter conditions can:

- Further refine the data scope for severity-based notifications;
- Limit members or teams to focus on events matching specific tags.

After adding filters, **only events that meet both severity requirements and filter conditions will trigger notifications**, enabling more precise incident notification management.

![Filter Conditions](../img/rule-filter.png)

![Filter Conditions Example](../img/rule-filter-1.png)

Clicking the filter button automatically retrieves fields from the current workspace, allowing you to set filter conditions using **equals, not equals, wildcard, negated wildcard, and regex match**. Multiple conditions for the same `key` field are ORed, while conditions for different `key` fields are ANDed.

You can configure filters directly via the UI or use regular expressions for more complex conditions, achieving finer-grained settings.

**Note**: Each alert rule can only have one set of filter conditions, which can contain one or more filter rules combined for condition evaluation.


### Alert Escalation {#upgrade}

If a monitor frequently detects incidents of the same severity within a short period, it may indicate a persistent issue. In such cases, additional notification targets may be needed to resolve the issue. By setting escalation rules, when incidents persist, the system automatically escalates them to critical notifications and sends them to designated recipients for timely attention and resolution.

![Escalation Notification](../img/upgrade-notice.png)

If a notification rule has two escalations:

- If incidents of the same severity continue, Guance checks the time interval to determine if escalation is needed.
- After sending the first escalation notification, Guance evaluates the second escalation interval to decide if another escalation notification should be sent.

**Note**:

- Each rule can have up to 2 escalations.
- Each escalation triggers only once without repeated alerts.


### Custom Notification Time {#custom}

While automatic notifications are triggered instantly upon detecting anomalies, you can also set specific times for notifications.

![Custom Notification Time](../img/notice-config-1.png)

1. Modify the configuration name as needed.
2. Divide the event cycle based on day, week, month, or custom dimensions:

    - If choosing custom, upload a CSV file, and Guance will automatically fill in dates based on the file. The date format must be `YYYY/MM/DD`, and the file can contain up to 365 dates.

3. Limit the time of day for events and send notifications based on the selected time intervals, e.g., selecting `09:00 - 10:00` means that any incidents occurring within this hour will match this custom configuration.

4. After configuring cycles and times, select the alert severity and notification targets.

**Note**:

- In a single custom notification configuration within the same alert policy, if multiple rules are configured, incidents will match rules in order from top to bottom, and notifications will be sent based on the first matching rule. If no rule matches, no notification is sent.

- When configuring monitors, if [multiple alert policies](./monitor/mutation-detection.md#alert) are selected, incidents generated after the monitor is enabled will match the selected alert policies separately.


### Repeat Alerts {#repeat}

After setting repeat alert notifications, within a specified time range, event data will continue to be generated but no further alert notifications will be sent. Generated data records will be stored in the Explorer.

**Note**: If you choose the "Permanent" repeat alert option, Guance sends only the initial alert notification and does not repeat subsequent notifications.

### Alert Aggregation {#pattern}

:material-numeric-1-circle-outline: No Aggregation: Default configuration; in this mode, alert events are merged every 20 seconds and sent as a single notification to the target.

:material-numeric-2-circle-outline: Rule-Based Aggregation: In this mode, you can choose one of four aggregation rules and set the aggregation period to send alert notifications:

| <div style="width: 150px"> Aggregation Rule </div>     | Description      |
| ----------- | ---------------- |
| All      | Generates alert notifications based on the severity dimension configured in the alert policy within the selected aggregation period.      |
| Monitor/Smart Check/SLO      | Generates alert notifications based on the unique ID of the monitor, smart check, or SLO, linked to the aggregation period.      |
| Detection Dimension      | Generates alert notifications based on the detection dimension, such as `host`, linked to the aggregation period.      |
| Tags      | Multi-select; links [global tags](../management/field-management.md) with [monitors](./monitor/index.md#tags), generating alert notifications based on the aggregation period.<br />:warning: If an event has multiple tag values, it matches the highest-priority tag based on the configuration order, with multiple tag values ORed.    |

:material-numeric-3-circle-outline: Intelligent Aggregation: In this mode, events generated within the aggregation period are clustered based on the selected `title` or `content`, with each cluster forming a single alert notification.

:material-numeric-4-circle-outline: AI Aggregation: Uses Guance's large model to merge monitoring alerts, reducing redundancy and avoiding numerous duplicate alerts in a short time.

#### Aggregation Period {#cycle}

In rule-based and intelligent aggregation modes, you can manually set a time range (1-30 minutes).

![Aggregation Period](../img/alert-1.png)

During this period, new events are aggregated into a single alert notification. If the period exceeds, new events are aggregated into a new alert notification.


### Operation Permissions {#permission}

Setting operation permissions for alert policies ensures that roles, team members, and workspace users can perform actions based on assigned permissions.

- Not enabling this configuration: follows the [default permissions](../management/role-list.md) for "Alert Policy Configuration Management".
- Enabling this configuration and selecting custom permission objects: only the creator and assigned permission objects can enable/disable, edit, or delete the alert policy.
- Enabling this configuration but not selecting custom permission objects: only the creator has the enable/disable, edit, or delete permissions.

**Note**: The Owner role in the current workspace is unaffected by these operation permission settings.

## More Reading

<font size=2>

<div class="grid cards" markdown>

- [<font color="coral"> :fontawesome-solid-arrow-right-long: &nbsp; **Manage Alert Policy List**</font>](./config-alert-setting.md)

</div>

<div class="grid cards" markdown>

- [<font color="coral"> :fontawesome-solid-arrow-right-long: &nbsp; **Alert Policy: More Granular Notification Target Configuration**</font>](./alert-strategy.md)

</div>

</font>