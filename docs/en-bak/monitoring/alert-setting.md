# Alert Strategy Management

---

Guance supports the management of alert strategies for monitoring results by sending alert notifications, allowing you to timely understand abnormal data, discover and solve problems.

???+ warning "Default Alert Strategy"

    - When creating a monitor, you must select an alert strategy, with **Default** selected by default;
    - When an alert strategy is deleted, monitors under the deleted strategy will automatically be categorized under **Default**.


## Create {#create}

In Guance Workspace, go to **Monitoring > Alert Strategy Management**, and click on **Create** to add a new alert strategy. You can configure alert targets and alert aggregation for the strategy.

![img/monitor2.png](img/monitor2.png)

### Alert Name

The name of the current alert strategy.

### Notification Configuration

:material-numeric-1-circle-outline: Event Severity: Includes <u>Critical, Important, Warning, No Data, Information</u>. Based on the selected event severity, Guance supports associate [Alert Aggregation](#pattern) for alert notifications.

> For more details on event severity, see [Event Severity](monitor/event-level-description.md).

:material-numeric-2-circle-outline: Notification Targets: You can configure notification targets for individual severity levels. Multiple targets can be selected.

The object types are as follows:

| Object Type | Description |
| --- | --- |
| Workspace Member | Email notification, by adding notification targets in Management > [Member Management](../management/member-management.md). |
| Team | Email notification, a team can add multiple workspace members as notification targets by going to Management > [Member Management](../management/member-management.md) > Team Management. |
| Mailing Group | Email notification, a mailing group can add multiple teams as notification targets by going to Monitoring > [Notification Targets](notify-object.md). |
| DingTalk Robot, WeChat Robot, Lark Robot | Group notification, by adding notification targets in Monitoring > [Notification Targets](notify-object.md). |
| Webhook | User-defined, by adding notification targets in Monitoring > [Notification Targets](notify-object.md). |
| SMS | SMS notification, a SMS group can add multiple workspace members as notification targets by going to Monitoring > [Notification Targets](notify-object.md). SMS notification is not available in the Trial version of Guance. In other versions, SMS notification costs 0.1 yuan per message and is billed daily with no free quota. |

**Note**:

- Recovery Notification: When a previously sent alert event is recovered, Guance will send a recovery notification to the corresponding notification targets. For example, if an `Critical` notification is sent to a group for a specific event, when the status starts to recover, a recovery notification will be sent to the group.

- Notification Delay: Alert notifications are not sent immediately after generation and may be delayed by up to 1 minute due to data storage issues.

### Mute Alerting

If the same event is not very urgent but the frequency of alert notifications is high, you can reduce the frequency of alert notifications by setting the time interval for repeated alert notifications.

**Note**: After setting repeated alert notifications, events will continue to occur, but alert notifications will no longer be sent. The generated data will be stored in [Event](../events/index.md).

<img src="../img/alert-2.png" width="60%" >

### Alert Aggregation {#pattern}

:material-numeric-1-circle-outline: No Aggregation: Default configuration; in this mode, alert events will be aggregated every 20 seconds and sent as a single notification to the corresponding notification targets.

:material-numeric-2-circle-outline: Rule-based Aggregation: In this mode, you can choose from the following four aggregation rules and send alert notifications based on the aggregation period:

<img src="../img/alert.png" width="70%" >

| <div style="width: 150px"> Aggregation Rule </div> | Description |
| --- | --- |
| All | Based on the severity dimension configured in the alert strategy, alert notifications will be generated within the selected aggregation period. |
| Monitors / Smart Check / SLO | Based on the unique ID of the monitor, smart check detection rule, or SLO, alert notifications will be generated within the selected aggregation period. |
| Detection Dimension | Based on the detection dimension, such as `host`, alert notifications will be generated within the selected aggregation period. |
| Tags | By associate [global labels](../management/field-management.md) with [monitors](./monitor/index.md#tags), alert notifications will be generated within the selected aggregation period based on the tags; multiple tags can be selected.<br />:warning: If an event has multiple tag values, the alert notification will be sent based on the tag order configured on the page, and the relationship between multiple tag values is OR. |

:material-numeric-3-circle-outline: Intelligent Aggregation: In this mode, events generated within the aggregation period will be clustered and grouped based on the selected "Title" or "Content", and one alert notification will be generated for each group.

<img src="../img/alert-3.png" width="70%" >

- Aggregation Period: In rule-based aggregation mode, you can manually set a time range (1-30 minutes) within which newly generated events will be aggregated and sent as a single alert notification. If the aggregation period is exceeded, newly generated events will be aggregated into a new alert notification.

<img src="../img/alert-1.png" width="70%" >

## Strategy List

The list contains all the alert strategies in the current workspace. You can view the strategy name, associated monitors, alert aggregation and perform other related operations.

![img/monitor12.png](img/monitor12.png)

- Search: The alert strategy list supports searching based on the alert strategy name. 

- Batch Operations: You can select and delete specific alert strategies in batches. 

- Associated Monitors: Show the number of monitors under the alert strategy. Clicking on the number will navigate to the monitor to view the details of the monitors under the alert strategy. 

- Alert Aggregation: Display the current alert strategy's aggregation mode. 

- Alert Configuration: Click :material-bell-cog: to edit the current alert strategy. 

- Delete: When an alert strategy is deleted, monitors under the alert strategy will be automatically categorized under Default.
    
    - You can also click :material-crop-square: next to the name to select specific charts for batch deletion. 