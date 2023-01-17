# Scheck
---

## Overview

Security check is used to monitor vulnerabilities, anomalies and risks in systems, containers and networks in the workspace. You can trigger alarms by setting the number of times detection metrics appear, and discover and manage security threats in time.

## Application Scene

Support monitoring network, storage, database, system, webserver, container for vulnerabilities, exceptions, and risks.

## Rule Description

In "Monitor", click "+ New Monitor", select "Safety Inspection", and enter the safety inspection rule configuration page.

### Step 1. Detect the Configuration

![](../img/monitor27.png)

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

3）**Detection metrics:** Monitor the number of check events containing the set fields in the "Security Check" within a certain time range, and support adding label filtering pairs for screening.

| Field | Description |
| --- | --- |
| Type | Event classification, support: `network`，`storage`，`database`，`system`，`webserver`，`container` |
| Host | Hostname |
| Level | Check event level, support: `info`，`warn`，`critical` |
| Tag | Based on the metric label, the data of detection metric is screened and the detection data range is limited. Support to add one or more label filters, and support fuzzy matching and fuzzy mismatching filters. |
| Detection dimensiom | The corresponding string type (keyword) fields in the configuration data can be selected as detection dimensions. At present, the detection dimensions support selecting up to three fields. Through the combination of fields of multiple detection dimensions, a certain detection object can be determined, and the observation cloud will judge whether the statistical index corresponding to a detection object meets the threshold of trigger conditions, and if it meets the conditions, an event will be generated. (For example, if the instrumentation dimensions "host" and "host_ip" are selected, the instrumentation object can be {host: host1, host_ip: 127.0.0.1}） |


4）**Trigger condition:** Set the trigger condition of alarm level.

![](../img/monitor58.png)

Configure the trigger condition and severity. When the query result is multiple values, an event will be generated if any value meets the trigger condition.

- Event Level Details refer to [event level description](event-level-description.md) 

**01、Alarm Levels Emergency (Red), Important (Orange), Warning (Yellow) Based on Configuration Condition Judgment Operator.**

- Operator details refer to [operator description](operator-description.md) 

**02、Alarm level is normal (green). Information (blue) is based on the number of detections configured. Description is as follows:**

- One test is performed for each test task, if "test frequency = 5 minutes", then one test = 5 minutes
- You can customize the number of tests, such as "Test frequency = 5 minutes", then 3 tests = 15 minutes

**a-Normal (green):** After the detection rules take effect, emergency, important and warning abnormal events are generated, and after the data detection results return to normal within the configured custom detection period, a recovery alarm event will be generated.

???+ attention
    
    Recovery alarm events are not restricted by [alarm silence](../alert-setting.md). If the recovery alarm event detection number is not set, the alarm event will not recover and will always appear in Events-Unrecovered Event List.

**b-Message (blue):** Normal test results also generate events.


**03、alarm level without data (gray):** Data status supports three configurations: "Trigger without data event", "Trigger recovery event" and "Do not trigger event". The log data selects the strategy of "Trigger recovery event" by default, so there is no need to configure without data, and twice the monitoring frequency is obtained as the detection task of no data recovery event.

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

Detect whether there are abnormal problems in the system.

![](../img/example09.png)
