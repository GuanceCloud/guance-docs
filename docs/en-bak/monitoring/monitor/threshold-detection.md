# Threshold Detection
---

Threshold detection is used to monitor anomalies in metrics, logs, links and other data. Users can set threshold ranges and receive alerts and notifications when the metrics reach the thresholds. It supports detecting multiple metric data simultaneously and setting alert levels.

## Use Case

Support detection of metrics, logs, infrastructure, custom, events, APM, RUM, security check, and network data anomalies. For example, you can monitor issues such as high host memory usage.

## Setup


### Step 1: Detection Configuration

![](../img/monitor14.png)

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

:material-numeric-3-circle-outline: **Detection Metrics:** Set the detection data.

| Field | Description |
| --- | --- |
| Data Type | The current detected data type supports detecting data types such as Metrics, Logs, Infrastructure, Custom, Events, APM, RUM, Security Check and Network. |
| Measurements | The measurement where the current detection metric is located. *(take the "metric" data type as an example.)* |
| Metrics | The metric for which the current test is aimed. *(take the "metric" data type as an example.)* |
| Aggregation Algorithm | Contains Avg by (average), Min by (minimum), Max by (maximum), Sum by (sum), Last (Last), First by (first), Count by (data points), Count_distinct by (non-duplicate data points), p50 (median), p75 (75%), p90 (90%), p99 (99%). |
| Detection Dimension | The corresponding string type (keyword) fields in the configuration data can be selected as detection dimensions. At present, the detection dimensions support selecting up to three fields. Through the combination of fields of multiple detection dimensions, a certain detection object can be determined, and the guance will judge whether the statistical index corresponding to a detection object meets the threshold of trigger conditions, and if it meets the conditions, an event will be generated. *(For example, if the detection dimensions `host` and `host_ip` are selected, the detection object can be `{host: host1, host_ip: 127.0.0.1}`*) When the detection object is "log", the default detection dimensions are `status`, `host`, `service`, `source` and `filename`.  |
| Filtering | Metirc-based labels filter the data of detection metrics, limit the scope of detection data, and support adding one or more labels for screening. Non-metric data support fuzzy matching and fuzzy mismatching screening conditions. |
| Alias | Custom metrics name |
| Query Mode | Support simple query and expression query, refer to [query](../../scene/visual-chart/chart-query.md). |

:material-numeric-4-circle-outline: **Trigger Condition:** Set the trigger condition of alert level; You can configure any of the following trigger conditions: Critical, Error, Warning, No Data, or Information.

![](../img/monitor50.png)

Configure the trigger condition and severity. When the query result is multiple values, an event will be generated if any value meets the trigger condition.

> See [Event Levels](event-level-description.md). 

I. Alert levels: Critical (red), Important (orange), Warning (yellow): Based on the configured conditions using [operators](operator-description.md). 

> For `likeTrue` and `likeFalse` details, see [Truth Table Description](table-description.md). 


II. Alert levels: OK (green), Information (blue): Based on the configured number of detections, as explained below:

- One test is performed for each test task, if "test frequency = 5 minutes", then one test = 5 minutes
- You can customize the number of tests, such as "Test frequency = 5 minutes", then 3 tests = 15 minutes

| Level | Description |
| --- | --- |
| OK | After the detection rule takes effect, if the result of an urgent, important, or warning abnormal event returns to normal within the configured number of custom detections, a recovery alert event is generated. <br/>:warning: Recovery alert events are not affected by [Mute Alerting](../alert-setting.md). If no detection count is set for recovery alert events, the alert event will not recover and will always appear in the Events > Unrecovered Events List. |
| Information | Events are generated even for normal detection results. |

III. Alert level: No Data (gray): The no data state supports three configuration strategies: Trigger No-Data Event, Trigger Recovery Event, and Untrigger Event.

- The **Trigger No-Data Event**, **Trigger Recovery Event** and **Untrigger Event** are three configuration strategies supported for the no data staus.
- When configuring the data monitor for basic objects and custom objects, the **Trigger Recovery Event** strategy is selected by default.

### Step 2: Event Notification

![](../img/monitor15.png)

:material-numeric-5-circle-outline: **Event Title:** Set the event name of the alert trigger condition; support the use of [preset template variables](../event-template.md).

**Note**: In the latest version, the Monitor Name will be automatically generated based on the Event Title input. In older monitors, there may be inconsistencies between the Monitor Name and the Event Title. To enjoy a better user experience, please synchronize to the latest version as soon as possible. One-click replacement with event title is supported.

:material-numeric-6-circle-outline: **Event Content**: The content of the event notification sent when the trigger conditions are met. Support inputting text in Markdown format, previewing effects, the use of preset [associated links](link-description.md) and the use of preset [template variables](../event-template.md).

**Note**: Different alert notification objects support different Markdown syntax. For example, WeCom does not support unordered lists.

- Relevant Links: Automatically generate jump links based on detection metrics, supporting adjustment of filtering conditions and time range after inserting links. Usually, it is a fixed link address prefix, which includes the current domain name and workspace ID; you can also customize jump links.

Among them, if you need to insert a link to the dashboard, based on the above logic, you also need to supplement the ID and name of the dashboard, supporting adjustment of view variables and time range.

<img src="../../img/monitor-link.png" width="60%" >

**No Data Notification Configuration**: Support customizing the content of the no data notification. If not configured, the official default notification template will be automatically used.

![](../img/8.monitor_2.png)

:material-numeric-7-circle-outline: **Synchronously create Issue**: If abnormal events occur under this monitor, an issue for anomaly tracking will be created synchronously and delivered to the channel for anomaly tracking. You can go to [Incident](../../exception/index.md) > Your selected [Channel](../../exception/channel.md) to view it.

### Step 3: Alert Configuration

![](../img/5.monitor_4-1.png)


:material-numeric-8-circle-outline: **Alert Strategy**: After the monitoring meets the trigger conditions, immediately send an alert message to the specified notification targets. The [Alert Strategy](../alert-setting.md) includes the event level that needs to be notified, the notification targets and the mute alerting period.

### Step 4: Association

![](../img/monitor13.png)

:material-numeric-9-circle-outline: **Associate Dashboard**: Every monitor supports associating with a dashboard for quick navigation and viewing.

### Example

Monitor host memory Swap usage is too high.

![](../img/example10.png)
