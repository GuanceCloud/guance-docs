# Infrastructure Active Detection
---

Based on infrastructure data, you can set up survival conditions in infrastructure survival detection settings to monitor the operational status and stability of the infrastructure.

## Use Cases

Monitor whether there is abnormal interruption in long-term survival infrastructure, and support monitoring the running status of host, container, Pod, Deployment and Node.

## Setup

Click on **Monitor > Create > Infrastructure Active Detection** to enter the configuration page for the rule.

### Step 1: Detection Configuration

![](../img/monitor18.png)

:material-numeric-1-circle-outline: **Detection Frequency:** The execution frequency of detection rules, including "5 minutes/10 minutes/15 minutes/30 minutes/1 hour", and 5 minutes is selected by default.

:material-numeric-2-circle-outline: **Detection Metrics:** Monitoring metric data.

<div class="grid" markdown>

=== "Objects"

    <img src="../../img/insfra-2.png" width="60%" >

    - Types: include host, container, Pod, Deployment, Node;
    - Filter: drop-down to view related fields; by default, the object's name Tag is in the first position;
    - Detect all hosts: only available when the type is host, when enabled, the filtering box is greyed out.

=== "Metrics"

    <img src="../../img/insfra-2.png" width="60%" >

    - Types: include host, container, Pod, Deployment, Node;
    - Metrics: list all measurements in the current workspace and their corresponding metric fields; you can also choose to manually input custom measurements and metrics;
    - Filter: drop-down to view related fields; by default, the object's name Tag is in the first position;
    - Detect all hosts: only available when the type is host, when enabled, the filtering box is greyed out.

</div>

:material-numeric-3-circle-outline: **Trigger Condition:** Set the trigger condition of alert level.

![](../img/monitor56.png)

- Information (Blue): Normal detection results also generate events;
- Events triggered by meeting conditions without data events;
- If no abnormal events are generated within the detection times, normal events are generated.

**Note**: The monitor can't query any data of the detected infrastucture tyep, and there may be anomalies in data reporting.

### Step 2: Event Notification

![](../img/monitor15.png)

:material-numeric-4-circle-outline: **Event Title:** Set the event name of the alert trigger condition, and support the use of preset [template variables](../event-template.md).

**Note**: In the latest version, the Monitor Name will be automatically generated based on the Event Title input. In older monitors, there may be inconsistencies between the Monitor Name and the Event Title. To enjoy a better user experience, please synchronize to the latest version as soon as possible. One-click replacement with event title is supported.

:material-numeric-5-circle-outline: **Event Content:** Event notification content sent when triggering conditions are met, It supports input of markdown format text information and preview effect, support use of preset template variables, refer to [template variables](../event-template.md).

**Note**: Different alert notification objects support different Markdown syntax. For example, WeCom does not support unordered lists.

:material-numeric-6-circle-outline: **Alert Strategy:** Send an alert message to the specified notification targets immediately after the monitoring meets the trigger condition. The [Alert Strategy](../alert-setting.md) includes the event level to be notified, the notification targets and the mute alerting period.

:material-numeric-7-circle-outline: **Synchronously create Issue**: If abnormal events occur under this monitor, an issue for anomaly tracking will be created synchronously and delivered to the channel for anomaly tracking. You can go to [Incident](../../exception/index.md) > Your selected [Channel](../../exception/channel.md) to view it.

### Step 3: Association

![](../img/monitor13.png)

:material-numeric-8-circle-outline: **Associate Dashboard**: Every monitor supports associating with a dashboard for quick navigation and viewing.

### Example

Assuming that your host needs to run 24 hours and can't go down, you can configure the host survival alert, and trigger the alert if there is no data for 10 consecutive minutes.

![](../img/example02.png)


