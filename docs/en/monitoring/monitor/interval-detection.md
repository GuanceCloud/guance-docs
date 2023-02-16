# Interval Detection
---

## Overview

Anomaly detection is done for the metric data within the selected detection interval time range. When the proportion of abrupt change abnormal data points exceeds the set percentage, abnormal events of interval detection are generated. Most of them are used to monitor data/metrics with stable trends.

##  Application Scene

Data/metrics applied to monitor trend stability. For example, when the data points with abnormal cpu utilization rate of the host exceed 10% in the last day, abnormal events will be generated.

## Rule Description

In "Monitor", click "+ New Monitor", select "Interval Detection", and enter the Interval Detection Rule Configuration page.

### Step 1. Detect the Configuration

![](../img/monitor19.png)

1）**Detection frequency:** The execution frequency of detection rules automatically matches the detection interval selected by users.

2）**Detection interval:** The time range of detection index query when each task is executed. You can choose 15m, 30m, 1h, 4h, 12h and 1d

| Detection Interval (Drop-down Option) | Detection Frequency | 
| --- | --- | 
| 15m | 5m |
| 30m | 5m |
| 1h | 15m |
| 4h | 30m |
| 12h | 1h |
| 1d | 1h |

3）**Detection metrics:** Monitoring metric Data.

| Field | Description |
| --- | --- |
| Data type | Only "metric" data is supported at present |
| Measurement | Measurement where the current detection metric is located |
| Metrics | Metrics for current detection |
| Aggregation Algorithm | Contains Avg by (average), Min by (minimum), Max by (maximum), Sum by (sum), Last (Last), First by (first), Count by (data points), Count_distinct by (non-duplicate data points), p50 (median), p75 (75%), p90 (90%), p99 (99%) |
| Detection dimension | The corresponding string type (keyword) fields in the configuration data can be selected as detection dimensions. At present, the detection dimensions support selecting up to three fields. Through the combination of fields of multiple detection dimensions, a certain detection object can be determined, and Guance will judge whether the statistical metric corresponding to a detection object meets the threshold of trigger conditions, and if it meets the conditions, an event will be generated. (For example, if the instrumentation dimensions "host" and "host_ip" are selected, the instrumentation object can be{host: host1, host_ip: 127.0.0.1}） |
| Filtering criteria | Metric-based labels filter the data of detecting metrics, limit the range of detected data, support adding one or more labels to filter, and support fuzzy matching and fuzzy mismatching screening conditions. |
| Alias | Custom metrics Name |
| Query mode | Support simple query and expression query, refer to [query](../../scene/visual-chart/chart-query.md) |


4）**Trigger condition:** Set the trigger condition of alarm level. Support three forms of data comparison: upward (data rise), downward (data fall), upward or downward.

![](../img/monitor52.png)

Configure the trigger condition and severity. When the query result is multiple values, an event will be generated if any value meets the trigger condition.

- Event level details refer to [event level description](event-level-description.md) 

**01、Alarm Levels Emergency (Red), Important (Orange), Warning (Yellow) Based on Configuration Condition Judgment Operator.**

- Operator details refer to [operator description](operator-description.md) 

**02、 Alarm level is normal (green). Information (blue) is based on the number of detections configured. Description is as follows:**

- One test is performed for each test task, if "test frequency = 5 minutes", then one test = 5 minutes
- You can customize the number of tests, such as "Test frequency = 5 minutes", then 3 tests = 15 minutes

**a-Normal (green):** After the detection rules take effect, emergency, important and warning abnormal events are generated, and within the configured custom detection times, the data detection results return to normal, then a recovery alarm event is generated.

???+ attention
   
    Recovery alarm events are not restricted by [alarm silence](../alert-setting.md). If the recovery alarm event detection number is not set, the alarm event will not recover and will always appear in Events-Unrecovered Event List.

**b-Message (blue):** Normal test results also generate events.

**03、No Data (Gray):** No Data status supports three configurations: "Trigger No Data Event", "Trigger Recovery Event" and "Don't Trigger Event", and requires manual configuration of no data processing strategy.

After the detection rule comes into effect, there is no data detected for the first time and there is no data continuously, and no data alarm event is generated; If there is data detected and the data report is broken within the configured self-defined detection time range, an alarm event without data will be generated.

### Step 2. Event notification

![](../img/monitor15.png)

5）**Event title:** Set the event name of the alarm trigger condition, and support the use of preset template variables. For details, refer to [template variables](../event-template.md).

???+ attention
    
    In the latest version, "Monitor Name" will be generated synchronously after entering "Event Title". There may be inconsistencies between "Monitor Name" and "Event Title" in the old monitor. In order to give you a better experience, please synchronize to the latest as soon as possible. Support one-click replacement for event headers.

6）**Event content:** Event notification content sent when triggering conditions are met, support input of markdown format text information, support preview effect, support use of preset template variables, refer to [template variables](../event-template.md)。

???+ attention
    
    Different alarm notification objects support different markdown syntax. For example, enterprise WeChat does not support unordered list.

7）**Alarm policy:** Send an alarm message to the specified notification object immediately after the monitoring meets the trigger condition. The alarm policy includes the event level to be notified, the notification object, and the alarm silence period. For details, refer to [alarm policy](../alert-setting.md).

### Step 3. Associate

![](../img/monitor13.png)

8）**Associated dashboards:** Each monitor supports associated dashboards, that is, dashboards that can customize quick jumps through the "Associated Dashboards" function (dashboards associated with monitors support quick jumps to view monitoring views).

## Example

When the data points with abnormal cpu utilization rate exceed 10% in the last hour, abnormal events will occur.

![](../img/example03.png)
