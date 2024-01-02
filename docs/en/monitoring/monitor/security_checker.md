# Scheck Anomaly Detection
---

Security Check is used to monitor vulnerabilities, anomalies, and risks in the workspace's systems, containers, networks, and more. You can trigger alarms by setting the occurrence frequency of detection indicators to promptly identify and manage security threats.

## Use Case

Support monitoring vulnerabilities, anomalies, and risks in Network, Storage, Database, System, Webserver and Container.

## Setup


### Step 1: Detection Configuration

![](../img/monitor27.png)

:material-numeric-1-circle-outline: **Detection Frequency:** The execution frequency of detection rules, including 1m/5m/15/30m/1h/6h (5m is selected by default).

:material-numeric-2-circle-outline: **Detection Interval:** The time range of detection index query when each task is executed. The optional detection interval will be different due to the influence of detection frequency. 

| Detection Frequency | Detection Interval (Drop-down Option) |
| --- | --- |
| 1m | 1m/5m/15m/30m/1h/3h |
| 5m | 5m/15m/30m/1h/3h |
| 15m | 15m/30m/1h/3h/6h |
| 30m | 30m/1h/3h/6h |
| 1h | 1h/3h/6h/12h/24h |
| 6h | 6h/12h/24h |

:material-numeric-3-circle-outline: **Detection Metrics:** Monitor the number of check events containing the set fields in the Security Check within a certain time range; adding label filtering pairs for screening is supported.

| Field | Description |
| --- | --- |
| Type | Event classification, support: `network`，`storage`，`database`，`system`，`webserver`，`container` |
| Host | Hostname |
| Level | Check event level, support: `info`，`warning`，`critical` |
| Tag | Based on the metric label, the data of detection metric is screened and the detection data range is limited. Support to add one or more label filters, and support fuzzy matching and fuzzy mismatching filters. |
| Detection Dimension | The corresponding string type (keyword) fields in the configuration data can be selected as detection dimensions. At present, the detection dimensions support selecting up to three fields. Through the combination of fields of multiple detection dimensions, a certain detection object can be determined, and the guance will judge whether the statistical index corresponding to a detection object meets the threshold of trigger conditions, and if it meets the conditions, an event will be generated. *(For example, if the instrumentation dimensions `host` and `host_ip` are selected, the instrumentation object can be `{host: host1, host_ip: 127.0.0.1}`.)* |


:material-numeric-4-circle-outline:  **Trigger Condition:** Set the trigger condition of alert level; You can configure any of the following trigger conditions: Critical, Error, Warning, No Data, or Information.

![](../img/monitor58.png)

Configure the trigger condition and severity. When the query result is multiple values, an event will be generated if any value meets the trigger condition.

> See [Event Levels](event-level-description.md). 

I. Alert levels: Critical (red), Important (orange), Warning (yellow): Based on the configured conditions using [operators](operator-description.md). 

II. Alert levels: OK (green), Information (blue): Based on the configured number of detections, as explained below:

- One test is performed for each test task, if "test frequency = 5 minutes", then one test = 5 minutes
- You can customize the number of tests, such as "Test frequency = 5 minutes", then 3 tests = 15 minutes

| Level | Description |
| --- | --- |
| OK | After the detection rule takes effect, if the result of an urgent, important, or warning abnormal event returns to normal within the configured number of custom detections, a recovery alert event is generated. <br/>:warning: Recovery alert events are not affected by [Mute Alerting](../alert-setting.md). If no detection count is set for recovery alert events, the alert event will not recover and will always appear in the Events > Unrecovered Events List. |
| Information | Events are generated even for normal detection results. |


III. Alert level: No Data (gray): The no data state supports three configuration strategies: Trigger No-Data Event, Trigger Recovery Event, and Untrigger Event.

### Step 2: Event Notification

![](../img/monitor15.png)

:material-numeric-5-circle-outline: **Event Title:** Set the event name of the alert trigger condition; support the use of [preset template variables](../event-template.md).

**Note**: In the latest version, the Monitor Name will be automatically generated based on the Event Title input. In older monitors, there may be inconsistencies between the Monitor Name and the Event Title. To enjoy a better user experience, please synchronize to the latest version as soon as possible. One-click replacement with event title is supported.

:material-numeric-6-circle-outline: **Event Content**: The content of the event notification sent when the trigger conditions are met. Support inputting text in Markdown format, previewing effects, the use of preset [associated links](link-description.md) and the use of preset [template variables](../event-template.md).

**Note**: Different alert notification objects support different Markdown syntax. For example, WeCom does not support unordered lists.

:material-numeric-7-circle-outline: **Alert Strategy**: After the monitoring meets the trigger conditions, immediately send an alert message to the specified notification targets. The [Alert Strategy](../alert-setting.md) includes the event level that needs to be notified, the notification targets and the mute alerting period.

:material-numeric-8-circle-outline: **Synchronously create Issue**: If abnormal events occur under this monitor, an issue for anomaly tracking will be created synchronously and delivered to the channel for anomaly tracking. You can go to [Incident](../../exception/index.md) > Your selected [Channel](../../exception/channel.md) to view it.

### Step 3: Association

![](../img/monitor13.png)

:material-numeric-9-circle-outline: **Associate Dashboard**: Every monitor supports associating with a dashboard for quick navigation and viewing.

### Example

Detect whether there are abnormal problems in the system.

![](../img/example09.png)
