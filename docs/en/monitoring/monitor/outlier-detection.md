# Outlier Detection
---

## Overview

The algorithm detects whether there is outlier deviation in the index/statistical data of the detected object under a specific grouping. If there is more than a certain degree of inconsistency, abnormal events of outlier detection will be generated for subsequent alarm tracking.

## Application Scene

Users can configure appropriate distance parameters according to the characteristics of index data to trigger emergency events. For example, you can monitor the memory usage of individual hosts far from that of other hosts.

## Rule Description

In "Monitor", click "+ New Monitor", select "Outlier Detection", and enter the outlier detection rule configuration page.

### Step 1. Detect the Configuration

![](../img/monitor34.png)

1）**Detection frequency:** The execution frequency of detection rules automatically matches the detection interval selected by users.

2）**Detection interval:** The time range of detection index query when each task is executed. You can choose 15m, 30m, 1h, 4h, 12h and 1d

| Detection Interval (Drop-down Option) | Default Detection Frequency | 
| --- | --- | 
| 15m | 5m |
| 30m | 5m |
| 1h | 15m |
| 4h | 30m |
| 12h | 1h |
| 1d | 1h |

3）**Detection Indicators:** Monitoring metric Data.

| Field | Description |
| --- | --- |
| Data Type | At present, only "metric" data is supported |
| Measurement | Measurement where the current detection metric is located |
| Metric | The metric where the current detection metric is located |
| Aggregation algorithm | Contain Avg by (average), Min by (minimum), Max by (maximum), Sum by (sum), Last (Last), First by (first), Count by (data points), Count_distinct by (non-duplicate data points), p50 (median), p75 (75%), p90 (90%), p99 (99%)|
| Filter condition | The corresponding string type (keyword) fields in the check configuration data can be selected as the check dimension. At present, the check dimension supports selecting up to three fields. Through the combination of fields of multiple detection dimensions, a certain detection object can be determined, and the observation cloud will judge whether the statistical index corresponding to a detection object meets the threshold of trigger conditions, and if it meets the conditions, an event will be generated. (For example, if the instrumentation dimensions "host" and "host_ip" are selected, the instrumentation object can be {host: host1, host_ip: 127.0.0.1}） |
| Detection dimension | Metric-based labels filter the data of detecting metrics, limit the range of detected data, support adding one or more labels to filter, and support fuzzy matching and fuzzy mismatching screening conditions. |
| Alias | Custom metrics name |
| Query mode | Support simple query and expression query, refer to [query](../../scene/visual-chart/chart-query.md) |

4）**Trigger condition:** Set the trigger condition of alarm level.

![](../img/monitor53.png)

Configure the trigger condition and severity. When the query result is multiple values, an event will be generated if any value meets the trigger condition.

- **紧急（红色）：** Using DBSCAN algorithm, users can configure appropriate distance parameters according to the characteristics of metric data to trigger emergency events. Distance parameter, which indicates the maximum distance between one sample and the other, and is not the maximum limit of the distance between points in the cluster. (float, default=0. 5)

???+ attention

    You can optionally configure any floating-point value between range (0-3.0), If it is not configured, the default distance parameter is 0.5. The larger the distance setting, the less outliers will be obtained. If the distance value is too small, many outliers may be detected. If the distance value is too large, no outliers may be detected. Therefore, it is necessary to set appropriate distance parameters according to different data characteristics.

- **Normal (green):** The user can configure the number of times. If the detection index triggers an "emergency" abnormal event, and then N consecutive tests are normal, the "normal" event will be generated. Used to determine whether abnormal events return to normal, it is recommended to configure.

- **Information (blue):** Normal detection results also generate events. If the detection metrics do not meet any trigger conditions of "emergency", "error", "warning", "normal" and "no data", it means that there is no abnormality in the detection results, and the "information" event is triggered at this time.

- **No data (gray):** When the detection metric has no data, the user can configure: no event, no data event, recovery event, and corresponding event under configuration conditions.

### Step 2. Event Notification

![](../img/monitor15.png)

5）**Event title:** Set the event name of the alarm trigger condition, and support the use of preset template variables. For details, refer to [template variables](../event-template.md).

???+ attention

    In the latest version, "Monitor Name" will be generated synchronously after entering "Event Title". There may be inconsistencies between "Monitor Name" and "Event Title" in the old monitor. In order to give you a better experience, please synchronize to the latest as soon as possible. Support one-click replacement for event headers.

6）**Event content:** Event notification content sent when triggering conditions are met, support input of markdown format text information, support preview effect, support use of preset template variables, refer to [template variables](../event-template.md).

???+ attention

    Different alarm notification objects support different markdown syntax. For example, enterprise WeChat does not support unordered list.

7）**Alarm policy:** Send an alarm message to the specified notification object immediately after the monitoring meets the trigger condition. The alarm policy includes the event level to be notified, the notification object, and the alarm silence period. For details, refer to [alarm strategy](../alert-setting.md).

### Step 3. Association

![](../img/monitor13.png)

8）**Associated dashboards:** Each monitor supports associated dashboards, that is, dashboards that can customize quick jumps through the "Associated Dashboards" function (dashboards associated with monitors support quick jumps to view monitoring views).

## Example
Take host memory metric outlier detection as an example.

Configure the monitor to generate an alarm when the maximum distance parameter between two adjacent samples is greater than 1.2:

![](../img/monitor35.png)

The event details page shows that the host datakit-internal memory outlier exceeds the configured distance parameter, resulting in an emergency alarm event:

![](../img/monitor36.png)

Notification object details display:

![](../img/monitor37.png)