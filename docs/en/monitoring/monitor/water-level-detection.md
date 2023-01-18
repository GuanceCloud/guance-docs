# Water Level Detection
---

## Overview

Water level detection is based on historical data to detect the persistent abnormal performance of metrics, which can avoid burr alarm of sudden detection.

## Application Scene


## Rule Description

In "Monitor", click "+ New Monitor", select "Water Level Detection", and enter the water level detection rule configuration page.

### Step 1. Detect the Configuration

![](../img/6.monitor06.png)

1）**Detection frequency:** The execution frequency of detection rules, including 1m/5m/15/30m/1h/6h (5m is selected by default).

2）**Detection interval:** The time range of detection metric query when each task is executed. The optional detection interval will be different due to the influence of detection frequency. (Support user-defined).

| Detection Frequency | Detection Interval (Drop-down Option) | Custom Interval Limit |
| --- | --- | --- |
| 1m | 1m/5m/15m/30m/1h/3h | <=3h |
| 5m | 5m/15m/30m/1h/3h | <=3h |
| 15m | 15m/30m/1h/3h/6h | <=6h |
| 30m | 30m/1h/3h/6h | <=6h |
| 1h | 1h/3h/6h/12h/24h | <=24h |
| 6h | 6h/12h/24h | <=24h |

3）**Detection metric:** Monitoring metric data, only one metric is allowed to be detected at a time.

| Field | Description |
| --- | --- |
| Detection metric | The currently detected metric, namely "Result", supports the detection of metric data |
| Measurement | Measurement where the current detection metric is located |
| Metric | Metrics for current detection |
| Aggregation period | The data aggregation period of the current detection metric is 1 minute by default |
| Aggregation algorithm | Contains Avg by (average), Min by (minimum), Max by (maximum), Sum by (sum), Last (Last), First by (first), Count by (data points), Count_distinct by (non-duplicate data points), p50 (median), p75 (75%), p90 (90%), p99 (99%) |
| Detection dimension | The detection dimension determines which dimension the detection rule is triggered based on, that is, the trigger object. Guance Cloud supports adding multiple detection dimensions. If the metric of any detection dimension meets the alarm condition, an alarm will be triggered. The int field is not supported as a detection dimension, and at most three fields can be selected. |
| Filter condition | Metric-based labels filter the data of detecting metrics, limit the range of detected data, support adding one or more labels to filter, and support fuzzy matching and fuzzy mismatching screening conditions. |
| Query way | Support simple query and expression query, refer to [query](../../scene/visual-chart/chart-query.md) |


4）**Trigger condition:** Set the trigger condition of alarm level.

Configure the trigger condition and severity. When the query result is multiple values, an event will be generated if any value meets the trigger condition.

- Event level details refer to [event level description](event-level-description.md) 

**01、Alarm Levels Urgent (Red), Important (Orange), Warning (Yellow) Based on cycle range, number of mutations, direction of mutations, and intensity of mutations, as follows:**

- Cycle range: set statistics of data in several aggregation cycles, and one aggregation cycle is equivalent to one data point in the line chart.
- Mutation direction: including three detection criteria: upward (data rise), downward (data fall), upward or downward.
- Mutation intensity: according to the upward or downward data breakthrough degree, it is divided into three grades: strong, medium and weak (as shown in the figure)

![](../img/image_11.png)

**02、Alarm level no data (gray), normal (green), information (blue) based on configuration detection times, as follows:**

- One test is performed for each test task, if "test frequency = 5 minutes", then one test = 5 minutes
- You can customize the number of tests, such as "test frequency = 5 minutes", then 3 tests = 15 minutes

**a-No data (gray):** No data status supports three configurations: "Trigger No Data Event", "Trigger Recovery Event" and "Don't Trigger Event", and needs to manually configure no data processing strategy.

After the detection rule comes into effect, there is no data detected for the first time and there is no data continuously, and no data alarm event is generated; If there is data detected and the data report is broken within the configured self-defined detection period, an alarm event without data will be generated.

**b-Normal (green):** After the detection rules take effect, emergency, important and warning abnormal events are generated, and after the data detection results return to normal within the configured custom detection period, a recovery alarm event will be generated.

Note: Recovery alarm events are not restricted by [alarm silence](../alert-setting.md). If the recovery alarm event detection period is not set, the alarm event will not recover and will always appear in Events-Unrecovered Event List.

**c-Message (blue):** Normal test results also generate events.

### Step 2. Event Notification

![](../img/monitor15.png)

5）**Event title:** Set the event name of the alarm trigger condition, and support the use of preset template variables. For details, refer to [template variables](../event-template.md).

**Note:** In the latest version, "Monitor Name" will be generated synchronously after "Event Title" is entered. There may be inconsistencies between "Monitor Name" and "Event Title" in the old monitor. In order to give you a better experience, please synchronize to the latest as soon as possible. Support one-click replacement for event headers.

6）**Event content:** Event notification content sent when triggering conditions are met, support input of markdown format text information, support preview effect, support use of preset template variables, refer to [template variables](../event-template.md).

**Note:** Different alarm notification objects support different markdown syntax, for example, enterprise WeChat does not support unordered list.

7）**Alarm policy:** Send an alarm message to the specified notification object immediately after the monitoring meets the trigger condition. The alarm policy includes the event level to be notified, the notification object, and the alarm silence period. For details, refer to [alarm strategy](../alert-setting.md).

### Step 3. Association

![](../img/monitor13.png)

8）**Associated dashboards:** Each monitor supports associated dashboards, that is, dashboards that can customize quick jumps through the "Associated Dashboards" function (dashboards associated with monitors support quick jumps to view monitoring views).

## Example
