# APM Metrics Detection
---

APM Metrics Detection is used to monitor the metric data of APM within the workspace. By setting threshold ranges, alerts can be triggered when the metrics reach the threshold. 

## Use Cases

- Support monitoring the metric data of all/single services in APM;
- Support counting the number of links that meet the conditions within a specified time period, and trigger an exception event when the custom threshold is exceeded.

## Setup

### Step 1: Detection Configuration

![](../img/monitor17.png)

:material-numeric-1-circle-outline: **Detection Frequency:** The execution frequency of detection rules, including 1m/5m/15/30m/1h/6h (5m is selected by default).

:material-numeric-2-circle-outline: **Detection Interval:** The time range of detection metric query when each task is executed. The optional detection interval will be different due to the influence of detection frequency. 

| Detection Frequency | Detection Interval (Drop-down Option) |
| --- | --- |
| 1m | 1m/5m/15m/30m/1h/3h |
| 5m | 5m/15m/30m/1h/3h |
| 15m | 15m/30m/1h/3h/6h |
| 30m | 30m/1h/3h/6h |
| 1h | 1h/3h/6h/12h/24h |
| 6h | 6h/12h/24h |

:material-numeric-3-circle-outline: **Detection Metrics:** Set the metrics of detection data. Setting metric data within a certain time range in the list of all/single services in the workspace is supported.

- **Service Metrics**

| <div style="width: 150px">Field</div> | Description |
| --- | --- |
| Service | Support monitoring of metric data for all/individual services in the current workspace, with the option to select all or select individually.|
| Metrics | The specific metrics for monitoring include the number of requests, number of error requests, error request rate, average requests per second, average response time, P50 response time, P75 response time, P90 response time, P99 response time, etc. |
| Filtering | Based on labels for metrics, the data can be filtered to limit the range of monitoring. It supports adding one or multiple label filters, with support for fuzzy matching and fuzzy non-matching conditions.  |
| Detection Dimension | The string type (keyword) fields in the configuration data can all be selected as dimensions for monitoring. Currently, up to three fields can be selected as monitoring dimensions. Through the combination of multiple monitoring dimensions, a specific monitoring object can be determined. Guance will determine whether the statistical metrics for a certain monitoring object meet the threshold of the triggering conditions. If the conditions are met, an event will be generated.<br/><br/>*For example, by selecting the monitoring dimensions `host` and `host_ip`, the monitoring object can be `{host: host1, host_ip: 127.0.0.1}`.* |

- **Link Statistics**

Count the number of links that meet the conditions within the specified time, and trigger abnormal events when exceeding the custom threshold. It can be used for service link exception error notification.

![](../img/6.monitor14.2.png)

| <div style="width: 150px">Field</div> | Description |
| --- | --- |
| Source | The data source of the current detection metric is supported by selecting all (`*`) or specifying a single data source |
| Filtering | Through the label filter link span, the range of detected data is limited, and one or more label filters are supported. |
| Aggregation Algorithm | “*” is selected by default, and the corresponding function is count. If other fields are selected, the function automatically changes to Count distinct. |
| Detection Dimension | The string type (keyword) fields in the configuration data can all be selected as dimensions for monitoring. Currently, up to three fields can be selected as monitoring dimensions. Through the combination of multiple monitoring dimensions, a specific monitoring object can be determined. Guance will determine whether the statistical metrics for a certain monitoring object meet the threshold of the triggering conditions. If the conditions are met, an event will be generated.<br/><br/>*For example, by selecting the monitoring dimensions `host` and `host_ip`, the monitoring object can be `{host: host1, host_ip: 127.0.0.1}`.*  |

:material-numeric-4-circle-outline: **Trigger Condition**: Set trigger conditions for alert levels; You can configure any of the following trigger conditions: Critical, Error, Warning, No Data, or Information.


Configure trigger conditions and severity. When there are multiple values in the query result, an event is generated if any value meets the trigger conditions.

> See [Event Levels](event-level-description.md). 

I. Alert levels: Critical (red), Important (orange), Warning (yellow): Based on the configured conditions using [operators](operator-description.md).


II. Alert levels: OK (green), Information (blue): Based on the configured number of detections, as explained below:

- Each execution of a detection task counts as 1 detection. For example, with a detection frequency of 5 minutes, 1 detection equals 5 minutes.
- You can customize the number of detections. For example, with a detection frequency of 5 minutes, 3 detections equal 15 minutes.  


| Level | Description |
| --- | --- |
| OK | After the detection rule takes effect, if the result of an urgent, important, or warning abnormal event returns to normal within the configured number of custom detections, a recovery alert event is generated. <br/>:warning: Recovery alert events are not affected by [Mute Alerting](../alert-setting.md). If no detection count is set for recovery alert events, the alert event will not recover and will always appear in the Events > Unrecovered Events List. |
| Information | Events are generated even for normal detection results. |




III. Alert level: No Data (gray): The no data state supports three configuration strategies: Trigger No-Data Event, Trigger Recovery Event, and Untrigger Event.

### Step 2: Event Notification

![](../img/8.monitor_1.png)

:material-numeric-5-circle-outline: **Event Title**: Set the event name for the alert trigger conditions, support the use of [preset template variables](../event-template.md).

**Note**: In the latest version, the Monitor Name will be automatically generated based on the Event Title input. In older monitors, there may be inconsistencies between the Monitor Name and the Event Title. To enjoy a better user experience, please synchronize to the latest version as soon as possible. One-click replacement with event title is supported.

:material-numeric-6-circle-outline: **Event Content**: The content of the event notification sent when the trigger conditions are met. Support inputting text in Markdown format, previewing effects, the use of preset [associated links](link-description.md) and the use of preset [template variables](../event-template.md).

**Note**: Different alert notification targets support different Markdown syntax. For example, WeCom does not support unordered lists.

**No Data Notification Configuration**: Support customizing the content of the no data notification. If not configured, the official default notification template will be automatically used.

![](../img/8.monitor_2.png)

:material-numeric-7-circle-outline: **Alert Strategy**: After the monitoring meets the trigger conditions, immediately send an alert message to the specified notification targets. The [Alert Strategy](../alert-setting.md) includes the event level that needs to be notified, the notification targets and the mute alerting period.

:material-numeric-8-circle-outline: **Synchronously create Issue**: If abnormal events occur under this monitor, an issue for anomaly tracking will be created synchronously and delivered to the channel for anomaly tracking. You can go to [Incident](../../exception/index.md) > Your selected [Channel](../../exception/channel.md) to view it.

### Step 3: Association

![](../img/5.monitor_4.png)

:material-numeric-9-circle-outline: **Associate Dashboard**: Every monitor supports associating with a dashboard for quick navigation and viewing.

### Example

The following image shows the configuration of monitoring the P90 response time of a detection chain service:

![](../img/example01.png)