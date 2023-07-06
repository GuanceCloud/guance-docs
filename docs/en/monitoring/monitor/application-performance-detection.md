# Application Performance Metrics Detection
---

## Overview

"Application Performance Metrics Detection" is used to monitor the metric data of "Application Performance Monitoring" in the workspace. By setting the threshold range, an alarm is triggered when the metric reaches the threshold. Guance supports setting alarms and customizing alarm levels for individual metrics.

## Application Scene

- Support to monitor the metric data of all/single services in "Application Performance Monitoring", and support all selection or single selection.
- Support statistics of the number of eligible links within the specified time, and trigger abnormal events when exceeding the custom threshold.

## Rule Description

### Step 1. Detect the configuration

![](../img/monitor17.png)

1）**Detection frequency:** The execution frequency of detection rules, including 1m/5m/15/30m/1h/6h (5m is selected by default).

2）**Detection interval:** The time range of detection metric query when each task is executed. The optional detection interval will be different due to the influence of detection frequency. (support user-defined)

| Detection Frequency | Detection Interval (Drop-down Option) | Custom Interval Limit |
| --- | --- | --- |
| 1m | 1m/5m/15m/30m/1h/3h | <=3h |
| 5m | 5m/15m/30m/1h/3h | <=3h |
| 15m | 15m/30m/1h/3h/6h | <=6h |
| 30m | 30m/1h/3h/6h | <=6h |
| 1h | 1h/3h/6h/12h/24h | <=24h |
| 6h | 6h/12h/24h | <=24h |

3）**Detection Metrics:** Set the metrics of detection data. Supports setting metric data within a certain time range in the list of all/single services in the workspace.

**Service Metrics**

| Field | Description |
| --- | --- |
| Service | It supports monitoring the metric data of all/single services in "Application Performance Monitoring" in the current workspace, and supports all selection or single selection. |
| Metrics | Specific detection metrics, support setting a single metric, including request number, error request number, request error rate, average request number per second, average response time, P50 response time, P75 response time, P90 response time, P99 response time, etc. |
| Filter Condition | Based on the metric label, the data of detection metric is screened and the detection data range is limited. Support to add one or more label filters, and support fuzzy matching and fuzzy mismatching filters.|
| Detection Dimension | The corresponding string type (keyword) fields in the configuration data can be selected as detection dimensions. At present, the detection dimensions support selecting up to three fields. Through the combination of fields of multiple detection dimensions, a certain detection object can be determined, and Guance will judge whether the statistical metric corresponding to a detection object meets the threshold of trigger conditions, and if it meets the conditions, an event will be generated. (For example, if the detect dimensions "host" and "host_ip" are selected, the detect object can be {host: host1, host_ip: 127.0.0.1}） |

**Link Statistics**

Count the number of links that meet the conditions within the specified time, and trigger abnormal events when exceeding the custom threshold. Can be used for service link exception error notification.

![](../img/6.monitor14.2.png)

| Field | Description |
| --- | --- |
| Source | The data source of the current detection metric is supported by selecting all (`*`) or specifying a single data source |
| Filter Condition | Through the label filter link span, the range of detected data is limited, and one or more label filters are supported. |
| Aggregation Algorithm | “*” is selected by default, and the corresponding function is count. If other fields are selected, the function automatically changes to Count distinct |
| Detection Dimension | The corresponding string type (keyword) fields in the configuration data can be selected as detection dimensions. At present, the detection dimensions support selecting up to three fields. Through the combination of fields of multiple detection dimensions, a certain detection object can be determined, and Guance will judge whether the statistical index corresponding to a detection object meets the threshold of trigger conditions, and if it meets the conditions, an event will be generated. (For example, if the detect dimensions "host" and "host_ip" are selected, the detect object can be {host: host1, host_ip: 127.0.0.1}） |

4）**Trigger condition:** Set the trigger condition of alarm level.

![](../img/monitor16.png)

Configure the trigger condition and severity. When the query result is multiple values, an event will be generated if any value meets the trigger condition.

- For more event level details, refer to [event level description](event-level-description.md) 

**01, Alarm levels Emergency (Red), Important (Orange), Warning (Yellow) based on configuration condition judgment operator.**

- Operator details refer to [operator description](operator-description.md) 

**02, Alarm level is Normal (green). Information (blue) is based on the number of detections configured. Description is as follows:**

- One test is performed for each test task, if "test frequency = 5 minutes", then one test = 5 minutes
- You can customize the number of tests, such as "Test frequency = 5 minutes", then 3 tests = 15 minutes

**a-Normal (green):** After the detection rules take effect, emergency, important and warning abnormal events are generated, and within the configured custom detection times, the data detection results return to normal, then a recovery alarm event is generated.

???+ attention

    Recovery alarm events are not restricted by [alarm silence](../alert-setting.md). If the recovery alarm event detection number is not set, the alarm event will not recover and will always appear in Events-Unrecovered Event List.

**b-Message (blue):** Normal test results also generate events.

**03, alarm level without data (gray):** No data status supports three configurations: "trigger no data event", "trigger recovery event" and "do not trigger event", and needs to manually configure no data processing strategy.

After the detection rule comes into effect, there is no data detected for the first time and there is no data continuously, and no data alarm event is generated; If there is data detected and the data report is broken within the configured self-defined detection time range, an alarm event without data will be generated.

### Step 2. Event Notification

![](../img/monitor15.png)

5）**Event title:** Set the event name of the alarm trigger condition, and support the use of preset template variables. For details, refer to [template variables](../event-template.md).

???+ attention

    In the latest version, "Monitor Name" will be generated synchronously after entering "Event Title". There may be inconsistencies between "Monitor Name" and "Event Title" in the old monitor. In order to give you a better experience, please synchronize to the latest as soon as possible. Support one-click replacement for event headers.

6）**Event content:** Event notification content sent when triggering conditions are met, support input of markdown format text information, support preview effect, support use of preset template variables, refer to [template variables](../event-template.md).

???+ attention

    Different alarm notification objects support different markdown syntax. For example, enterprise WeChat does not support unordered list.

7）**Alarm policy:** Send an alarm message to the specified notification object immediately after the monitoring meets the trigger condition. The alarm policy includes the event level to be notified, the notification object, and the alarm silence period. For details, refer to [alarm policy](../alert-setting.md).

### Step 3. Association

![](../img/monitor13.png)

8）**Associated dashboards:** Each monitor supports associated dashboards, that is, dashboards that can customize quick jumps through the "Associated Dashboards" function (dashboards associated with monitors support quick jumps to view monitoring views).

## Example

The following figure shows that the configuration detects that the response time of the link service P90 is too high.

![](../img/example01.png)