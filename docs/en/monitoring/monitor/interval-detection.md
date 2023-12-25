# Interval Detection
---


For the selected detection interval time range, abnormal detection is performed on the indicator data. When the percentage of mutated abnormal data points exceeds the set percentage, an interval detection abnormal event is generated. It is commonly used for monitoring stable trends in data/metrics.

## Use Case

It is applied to monitoring stable trends in data/metrics. For example, when the percentage of abnormal data points with a sudden mutation in host CPU usage rate exceeds 10% in the past 1 day, an abnormal event is generated.

## Setup

In "Monitor", click "+ New Monitor", select "Interval Detection", and enter the Interval Detection Rule Configuration page.

### Step 1: Detection Configuration

![](../img/monitor19.png)

:material-numeric-1-circle-outline: **Detection Frequency:** The execution frequency of detection rules automatically matches the detection interval selected by users.

:material-numeric-2-circle-outline: **Detection Interval:** The time range of detection index query when each task is executed. You can choose 15m, 30m, 1h, 4h, 12h and 1d.

| Detection Interval (Drop-down Option) | Detection Frequency | 
| --- | --- | 
| 15m | 5m |
| 30m | 5m |
| 1h | 15m |
| 4h | 30m |
| 12h | 1h |
| 1d | 1h |

:material-numeric-3-circle-outline: **Detection Metrics:** Monitoring metric Data.

| Field | Description |
| --- | --- |
| Data Type | Only metric data is supported at present |
| Measurements | Measurement where the current detection metric is located |
| Metrics | Metrics for current detection |
| Aggregation Algorithm | Contains Avg by (average), Min by (minimum), Max by (maximum), Sum by (sum), Last (Last), First by (first), Count by (data points), Count_distinct by (non-duplicate data points), p50 (median), p75 (75%), p90 (90%), p99 (99%) |
| Detection Dimension | The corresponding string type (keyword) fields in the configuration data can be selected as detection dimensions. At present, the detection dimensions support selecting up to three fields. Through the combination of fields of multiple detection dimensions, a certain detection object can be determined, and Guance will judge whether the statistical metric corresponding to a detection object meets the threshold of trigger conditions, and if it meets the conditions, an event will be generated. *(For example, if the instrumentation dimensions `host` and `host_ip` are selected, the instrumentation object can be `{host: host1, host_ip: 127.0.0.1}`.)* |
| Filtering | Metric-based labels filter the data of detecting metrics, limit the range of detected data; support adding one or more labels to filter; support fuzzy matching and fuzzy mismatching screening conditions. |
| Alias | Custom metrics name |
| Query Mode | Support simple query and expression query; see [query](../../scene/visual-chart/chart-query.md) |


:material-numeric-4-circle-outline: **Trigger Condition:** Set trigger conditions for alert levels: You can configure any of the following trigger conditions: Critical, Error, Warning, No Data, or Information. Set the trigger condition of alert level. Support three forms of data comparison: upward (data rise), downward (data fall), upward or downward.

![](../img/monitor52.png)

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

:material-numeric-5-circle-outline: **Event Title:** Set the event name for the alert trigger conditions, support the use of [preset template variables](../event-template.md).

**Note**: In the latest version, the Monitor Name will be automatically generated based on the Event Title input. In older monitors, there may be inconsistencies between the Monitor Name and the Event Title. To enjoy a better user experience, please synchronize to the latest version as soon as possible. One-click replacement with event title is supported.

:material-numeric-6-circle-outline: **Event Content**: The content of the event notification sent when the trigger conditions are met. Support inputting text in Markdown format, previewing effects, the use of preset [associated links](link-description.md) and the use of preset [template variables](../event-template.md).

**Note**: Different alert notification objects support different Markdown syntax. For example, WeCom does not support unordered lists.

:material-numeric-7-circle-outline: **Alert Strategy**: After the monitoring meets the trigger conditions, immediately send an alert message to the specified notification targets. The [Alert Strategy](../alert-setting.md) includes the event level that needs to be notified, the notification targets and the mute alerting period.

:material-numeric-8-circle-outline: **Synchronously create Issue**: If abnormal events occur under this monitor, an issue for anomaly tracking will be created synchronously and delivered to the channel for anomaly tracking. You can go to [Incident](../../exception/index.md) > Your selected [Channel](../../exception/channel.md) to view it.

### Step 3: Association

![](../img/monitor13.png)

:material-numeric-9-circle-outline: **Associate Dashboard**: Every monitor supports associating with a dashboard for quick navigation and viewing.

### Example

When the data points with abnormal cpu utilization rate exceed 10% in the last hour, abnormal events will occur.

![](../img/example03.png)
