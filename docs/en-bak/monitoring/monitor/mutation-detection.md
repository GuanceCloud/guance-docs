# Change Detection
---

By comparing the absolute or relative (%) change values of the same metric in two different time periods, it is possible to determine if there are any abnormal conditions. This method is commonly used to track the peak value or data changes of a specific metric. When abnormal conditions occur, events can be recorded more accurately.

## Use Cases

Change detection can be used to monitor recent and long-term relative changes/relative change rates. For example, when you set the percentage difference between the average value of the connection count metric for MySQL in the last 15 minutes and the average value in the last 1 day to be >500, it means that a warning should be triggered when the average connection count in the last fifteen minutes exceeds five times the average connection count in the last day.

It is recommended to use statistical functions such as AVG, MAX, MIN, etc., and avoid using the last function.

## Setup

### Step 1: Detection Configuration

![](../img/monitor22.png)

:material-numeric-1-circle-outline: **Detection Metrics:** Monitoring Metric Data. It supports comparing the difference or difference percentage of the metric in two time periods.

| Field | Description |
| --- | --- |
| Data Type | At present, only "metric" data is supported |
| Measurements | Measurement where the current detection metric is located |
| Metrics | Metrics for current detection |
| Aggregation Algorithm | Contain Avg by (average), Min by (minimum), Max by (maximum), Sum by (sum), Last (Last), First by (first), Count by (data points), Count_distinct by (non-duplicate data points), p50 (median), p75 (75%), p90 (90%), p99 (99%) |
| Detection Dimension | The corresponding string type (keyword) fields in the configuration data can be selected as detection dimensions. At present, the detection dimensions support selecting up to three fields. Through the combination of fields of multiple detection dimensions, a certain detection object can be determined, and the guance will judge whether the statistical index corresponding to a detection object meets the threshold of trigger conditions, and if it meets the conditions, an event will be generated. (For example, if the detection dimensions `host` and `host_ip` are selected, the detection object can be `{host: host1, host_ip: 127.0.0.1}`.) |
| Filtering | Metric-based labels filter the data of detecting metrics, limit the range of detected data, support adding one or more labels to filter, and support fuzzy matching and fuzzy mismatching screening conditions. |
| Alias | Custom metrics name |
| Query Mode | Support simple query and expression query, refer to [query](../../scene/visual-chart/chart-query.md) |

The selectable **detection intervals** for time periods are 15m, 30m, 1h, 4h, 12h and 1d.

**Note**: The "1d" and "1h" detection intervals compare the difference or percentage difference of detection metrics within the same time range. Other detection intervals compare the difference or percentage difference of detection metrics between two time periods.

![](../img/1.monitor_1.png)

![](../img/1.monitor_2.png)

| Detection Interval (Drop-down oOption) | Detection Frequency | 
| --- | --- | 
| 15m | 5m |
| 30m | 5m |
| 1h | 15m |
| 4h | 30m |
| 12h | 1h |
| 1d | 1h |

:material-numeric-2-circle-outline: **Detection Frequency:** The execution frequency of the detection rule automatically matches the detection interval with a larger time range among the two detection intervals selected by the user.

:material-numeric-3-circle-outline: **Trigger Condition:** Set the trigger condition of alert level. Support three forms of data comparison: upward (data rise), downward (data fall), upward or downward.

![](../img/monitor51.png)

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

After the detection rule comes into effect, there is no data detected for the first time and there is no data continuously, and no data alert event is generated; If there is data detected and the data report is broken within the configured self-defined detection time range, an alert event without data will be generated.

### Step 2: Event Notification

![](../img/monitor15.png)

:material-numeric-4-circle-outline: **Event Title:** Set the event name of the alert trigger condition; support the use of [preset template variables](../event-template.md).

**Note**: In the latest version, the Monitor Name will be automatically generated based on the Event Title input. In older monitors, there may be inconsistencies between the Monitor Name and the Event Title. To enjoy a better user experience, please synchronize to the latest version as soon as possible. One-click replacement with event title is supported.

:material-numeric-5-circle-outline: **Event Content**: The content of the event notification sent when the trigger conditions are met. Support inputting text in Markdown format, previewing effects, the use of preset [associated links](link-description.md) and the use of preset [template variables](../event-template.md).

**Note**: Different alert notification objects support different Markdown syntax. For example, WeCom does not support unordered lists.

:material-numeric-6-circle-outline: **Alarm Strategy:** After the monitoring meets the trigger conditions, immediately send an alert message to the specified notification targets. The [Alert Strategy](../alert-setting.md) includes the event level that needs to be notified, the notification targets and the mute alerting period.

:material-numeric-7-circle-outline: **Synchronously create Issue**: If abnormal events occur under this monitor, an issue for anomaly tracking will be created synchronously and delivered to the channel for anomaly tracking. You can go to [Incident](../../exception/index.md) > Your selected [Channel](../../exception/channel.md) to view it.

### Step 3: Association

![](../img/monitor13.png)

:material-numeric-8-circle-outline: **Associate Dashboard**: Every monitor supports associating with a dashboard for quick navigation and viewing.

### Example

When the percentage difference between the last 15 minutes and the average of the last day is more than 90, it means that the average cpu utilization of the last 15 minutes exceeds 90% of the average cpu utilization of the last day.

![](../img/example05.png)