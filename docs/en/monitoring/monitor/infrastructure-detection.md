# Infrastructure Survival Detection
---

## Overview

"Infrastructure Survival Detection" is used to monitor the running status of infrastructure, and infrastructure objects support selection: host, container, Pod, Deployment and Node.

## Application Scene

Monitor whether there is abnormal interruption in long-term survival infrastructure, and support monitoring the running status of host, container, Pod, Deployment and Node.

## Rule Description

In "Monitor", click "+ New Monitor", select "Infrastructure Survival Monitoring", and enter the configuration page of detection rules.

### Step 1. Detect the Configuration

![](../img/monitor18.png)

1）**Detection frequency:** The execution frequency of detection rules, including "5 minutes/10 minutes/15 minutes/30 minutes/1 hour", and 5 minutes is selected by default.

2）**Detection index:** Monitoring metric data.

| Field | Description |
| --- | --- |
| Object types | Contain "Host", "Container", "Pod", "Deployment" and "Node" |
| Filter | Drop-down is only for filtering without search function.<br>The name tag of the default detection object is put in the first place. |
| Switch | It only exists when the type is host. After opening, the filter box is grayed out and invalid. |

3）**Trigger condition:** Set the trigger condition of alarm level.

![](../img/monitor56.png)

- Message (blue): Normal test results also generate events.
- meet the condition trigger event no data event
- If there is no abnormal event within the detection times, a normal event will be generated

???+ attention

    The monitor can't query any data of the detected object, and there may be anomalies in data reporting.

### Step 2. Event Notification

![](../img/monitor15.png)

4）**Event title:** Set the event name of the alarm trigger condition, and support the use of preset template variables. For details, refer to [template variables](../event-template.md).

???+ attention
    
    In the latest version, "Monitor Name" will be generated synchronously after entering "Event Title". There may be inconsistencies between "Monitor Name" and "Event Title" in the old monitor. In order to give you a better experience, please synchronize to the latest as soon as possible. Support one-click replacement for event headers.

5）**Event content:** Event notification content sent when triggering conditions are met, It supports input of markdown format text information and preview effect, support use of preset template variables, refer to [template variables](../event-template.md).

???+ attention
    
    Different alarm notification objects support different markdown syntax. For example, enterprise WeChat does not support unordered list.

6）**Alarm strategy:** Send an alarm message to the specified notification object immediately after the monitoring meets the trigger condition. The alarm policy includes the event level to be notified, the notification object, and the alarm silence period. For details, refer to [alarm strategy](../alert-setting.md).

### Step 3. Associate

![](../img/monitor13.png)

8）**Associated dashboards:** Each monitor supports associated dashboards, that is, dashboards that can customize quick jumps through the "Associated Dashboards" function (dashboards associated with monitors support quick jumps to view monitoring views).

## Example

Assuming that your host needs to run 24 hours and can't go down, you can configure the host survival alarm, and trigger the alarm if there is no data for 10 consecutive minutes.

![](../img/example02.png)


