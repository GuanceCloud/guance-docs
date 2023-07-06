# Threshold Detection
---

## Overview

Threshold detection is used to monitor data anomalies such as metrics, logs, links. Users can set the threshold range, and when metrics reach the threshold, trigger an alarm and inform users. Supports simultaneous detection of multiple metric data and setting alarm levels.

## Application Scene

Support the detection of data anomalies such as "metrics", "logs", "infrastructure", "custom objects", "events", "application performance monitoring", "user access monitoring", "security check" and "network". For example, you can monitor problems such as excessive host memory utilization.

## Rule Description

In "Monitor", click "+ New Monitor", select "Threshold Detection", and enter the Threshold Detection Rule Configuration page.

### Step 1. Detect the Configuration

![](../img/monitor14.png)

1）**Detection frequency:** The execution frequency of detection rules, including 1m/5m/15/30m/1h/6h (5m is selected by default).

2）**Detection interval:** The time range of detection index query when each task is executed. The optional detection interval will be different due to the influence of detection frequency. (Support user-defined)

| Detection Frequency | Detection Interval (Drop-down Option) | Custom Interval Limit |
| --- | --- | --- |
| 1m | 1m/5m/15m/30m/1h/3h | <=3h |
| 5m | 5m/15m/30m/1h/3h | <=3h |
| 15m | 15m/30m/1h/3h/6h | <=6h |
| 30m | 30m/1h/3h/6h | <=6h |
| 1h | 1h/3h/6h/12h/24h | <=24h |
| 6h | 6h/12h/24h | <=24h |

3）**Detection Metric:** Set the detection data.

| Field | Description |
| --- | --- |
| Data type | The current detected data type supports detecting data types such as "Metric", "Log", "Infrastructure", "Custom Object", "Event", "Application Performance Monitoring", "User Access Monitoring", "Security Check" and "Network" |
| Measurement | The measurement where the current detection metric is located (take the "metric" data type as an example) |
| Metrics | The metric for which the current test is aimed (take the "metric" data type as an example) |
| Aggregation Algorithm | Contains Avg by (average), Min by (minimum), Max by (maximum), Sum by (sum), Last (Last), First by (first), Count by (data points), Count_distinct by (non-duplicate data points), p50 (median), p75 (75%), p90 (90%), p99 (99%) |
| Detection dimension | The corresponding string type (keyword) fields in the configuration data can be selected as detection dimensions. At present, the detection dimensions support selecting up to three fields. Through the combination of fields of multiple detection dimensions, a certain detection object can be determined, and the guance will judge whether the statistical index corresponding to a detection object meets the threshold of trigger conditions, and if it meets the conditions, an event will be generated. (For example, if the detection dimensions "host" and "host_ip" are selected, the detection object can be {host: host1, host_ip: 127.0.0.1}). When the detection object is "log", the default detection dimensions are "status", "host", "service", "source" and "filename"  |
| Filter condition | Metirc-based labels filter the data of detection metrics, limit the scope of detection data, and support adding one or more labels for screening. Non-metric data support fuzzy matching and fuzzy mismatching screening conditions. |
| Alias | Custom metrics name |
| Query mode | Support simple query and expression query, refer to [query](../../scene/visual-chart/chart-query.md) |

4）**Trigger condition:** Set the trigger condition of alarm level.

![](../img/monitor50.png)

Configure the trigger condition and severity. When the query result is multiple values, an event will be generated if any value meets the trigger condition.

- Event level details refer to [event level description](event-level-description.md) 

**01、Alarm Levels Emergency (Red), Important (Orange), Warning (Yellow) Based on Configuration Condition Judgment Operator.**

- Operator details refer to [operator description](operator-description.md) 
- `likeTrue` and `likeFalse` truth table details refer to [真值表truth table description说明](table-description.md) 


**02、Alarm level is normal (green). Information (blue) is based on the number of detections configured. Description is as follows:**

- One test is performed for each test task, if "test frequency = 5 minutes", then one test = 5 minutes
- You can customize the number of tests, such as "Test frequency = 5 minutes", then 3 tests = 15 minutes

**a-Normal (green):** After the detection rules take effect, emergency, important and warning abnormal events are generated, and within the configured custom detection times, the data detection results return to normal, then a recovery alarm event is generated.

???+ attention
    
    Recovery alarm events are not restricted by [alarm silence](../alert-setting.md). If the recovery alarm event detection number is not set, the alarm event will not recover and will always appear in Events-Unrecovered Event List.

**b-Message (blue):** Normal test results also generate events.

**03、Alarm Level No Data (Gray):** No Data Status supports three configurations: "Trigger No Data Event", "Trigger Recovery Event" and "Don't Trigger Event":

- When configuring the metric data monitor, it is necessary to manually configure the data-free processing strategy;
- When configuring the log data monitor, the strategy of "triggering recovery events" is selected by default, so there is no need to configure without data, and twice the monitoring frequency is obtained as the detection task of recovery events without data;
- Threshold (metric data only) supports manual configuration of non-data policy. If non-metric data is selected, the log data non-data policy will be automatically adapted without manual selection.

After the detection rule comes into effect, there is no data detected for the first time and there is no data continuously, and no data alarm event is generated; If there is data detected and the data report is broken within the configured self-defined detection time range, an alarm event without data will be generated.

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

Monitor host memory Swap usage is too high.

![](../img/example10.png)
