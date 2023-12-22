# Outlier Detection
---

To detect outliers in the metrics/statistical data of the detection objects within a specific group, an algorithm is used. If there is a significant inconsistency beyond a certain threshold, it will trigger an abnormal event for outlier detection, which can be used for subsequent alert tracking.

## Use Cases

Users can configure suitable distance parameters based on the characteristics of indicator data to trigger emergency events. For example, you can monitor individual host memory usage rates that deviate significantly from other hosts.

## Setup


### Step 1: Detection Configuration

![](../img/monitor34.png)

:material-numeric-1-circle-outline: **Detection Frequency:** The execution frequency of detection rules automatically matches the detection interval selected by users.

:material-numeric-2-circle-outline: **Detection Interval:** The time range of detection index query when each task is executed. You can choose 15m, 30m, 1h, 4h, 12h and 1d.

| Detection Interval (Drop-down Option) | Default Detection Frequency | 
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
| Data Type | At present, only "metric" data is supported. |
| Measurements | Measurement where the current detection metric is located. |
| Metrics | The metric where the current detection metric is located. |
| Aggregation Algorithm | Contain Avg by (average), Min by (minimum), Max by (maximum), Sum by (sum), Last (Last), First by (first), Count by (data points), Count_distinct by (non-duplicate data points), p50 (median), p75 (75%), p90 (90%), p99 (99%).  |
| Filtering | The corresponding string type (keyword) fields in the check configuration data can be selected as the check dimension. At present, the check dimension supports selecting up to three fields. Through the combination of fields of multiple detection dimensions, a certain detection object can be determined, and the guance will judge whether the statistical index corresponding to a detection object meets the threshold of trigger conditions, and if it meets the conditions, an event will be generated. *(For example, if the instrumentation dimensions `host` and `host_ip` are selected, the instrumentation object can be `{host: host1, host_ip: 127.0.0.1}`.)* |
| Detection Dimension | Metric-based labels filter the data of detecting metrics, limit the range of detected data, support adding one or more labels to filter, and support fuzzy matching and fuzzy mismatching screening conditions. |
| Alias | Custom metrics name. |
| Query Mode | Support simple query and expression query, refer to [query](../../scene/visual-chart/chart-query.md). |

:material-numeric-4-circle-outline: **Trigger Condition:** Set the trigger condition of alert level; You can configure any of the following trigger conditions: Critical, OK, No Data, or Information.



![](../img/monitor53.png)

Configure the trigger condition and severity. When the query result is multiple values, an event will be generated if any value meets the trigger condition.

| Level | Description |
| --- | --- |
| Critical (red) | Use the DBSCAN algorithm to configure the appropriate distance parameter based on the metrics data characteristics to trigger a critical event. The distance parameter represents the maximum distance between two samples, which are considered adjacent, and is not the maximum limit of distance within a cluster. (float, default=0.5) <br />:warning: You can choose to configure any floating point value between range(0-3.0). If not configured, the default distance parameter is 0.5. A larger distance setting will result in fewer outlier points detected, while a smaller distance value may detect a large number of outliers. Setting a distance value too large can result in no outliers being detected. Therefore, it is necessary to set the appropriate distance parameter based on different data characteristics. |
| OK (green) | Users can configure the number of consecutive normal detections required after a critical abnormal event is triggered to generate an OK event. This is used to determine if the abnormal event has returned to OK. It is recommended to configure this. |
| Information (blue) | An information event is triggered when the normal detection result does not meet any of the conditions for triggering critical, error, warning, OK, or no-data events. This indicates that there are no abnormalities in the detection result. |
| No Data (gray) | When there is no data for the detection metric, users can configure whether to trigger an event, trigger a no-data event, or trigger a recovery event based on the configured conditions. |

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

Take host memory metric outlier detection as an example.

Configure the monitor to generate an alert when the maximum distance parameter between two adjacent samples is greater than 1.2:

![](../img/monitor35.png)

The event details page shows that the host datakit-internal memory outlier exceeds the configured distance parameter, resulting in an emergency alert event:

![](../img/monitor36.png)

Notification object details display:

![](../img/monitor37.png)