# Host Detection 
---


Host detection is based on intelligent detection algorithms, which regularly perform intelligent detection on the CPU and memory of the host. By analyzing the root causes of CPU and memory abnormalities, it determines whether the host has abnormal situations such as sudden increase/decrease or interval rise, and monitors the running status and stability of the host.


## Use Cases

Host detection is suitable for monitoring business hosts with high stability and reliability requirements, and supports providing analysis reports for generated abnormal events.

## Setup

Click on **Intelligent Monitoring > Create > Host Detection** to enter the rule configuration page.

### Step 1: Detection Configuration {#config}

![](../img/intelligent-detection03.png)

:material-numeric-1-circle-outline: **Monitor Name**: Edit the name of the monitor.

:material-numeric-2-circle-outline: **Detection Frequency**: The execution frequency of the detection rule, fixed at 30 minutes.

:material-numeric-3-circle-outline: **Filter**: Limit the range of hosts to be monitored through filtering combinations.

### Step 2: Event Notification

![](../img/intelligent-detection07.png)

:material-numeric-4-circle-outline: **Event Content**: The content of the event notification sent when the trigger condition is met. Support input in Markdown format, preview of the effect, use of preset [associated links](link-description.md) and use of preset [template variables](../event-template.md).

**Note**: Different notification objects support different Markdown syntax. For example, WeChat Work does not support unordered lists.

:material-numeric-5-circle-outline: **Synchronously create Issue**: If an abnormal event occurs under this monitor, an issue for anomaly tracking will be created synchronously and delivered to the channel for anomaly tracking. You can go to [Incident](../../exception/index.md) >  Your selected [Channel](../../exception/channel.md) to view it.

### Step 3: Alert Configuration

:material-numeric-6-circle-outline: Alert Strategy: After the monitor meets the trigger conditions, an alert message is immediately sent to the specified notification objects. The alert strategy includes the event level to be notified, notification objects and alert aggregation.

**Note**: The event level triggered by intelligent monitoring is "error".


## Monitor List

After creating a detection rule, you can view and manage the it in the Intelligent Monitoring list.

![](../img/intelligent-detection01.png)

### Operations

<div class="grid cards" markdown>

- [<font color="coral"> :fontawesome-solid-arrow-up-right-from-square: &nbsp; Monitor List</font>](../monitor/index.md#list)

</div>

### View Events

The monitor obtains the CPU and memory usage of the detected host in the last 30 minutes. When abnormal situations are identified, corresponding events are generated and can be viewed in the **Events > Intelligent Monitoring** list.

![image](../img/intelligent-detection04.png)

#### Event Details Page

Click Event to view the details page of the intelligent monitoring event, including the event status, abnormal occurrence time, abnormal name, analysis report, extended fields, alert notification, history records, and related events.

* Click on the upper right corner Jump to Monitor to view and adjust the [configuration](index.md);

* Click on the upper right corner **Export** button to select **Export JSON** or **Export PDF** to obtain all key data corresponding to the current event.

:material-numeric-1-circle-outline: Analysis Report

![](../img/intelligent-detection10.png)

![](../img/intelligent-detection13.png)

- Event Content: Display the event content configured in the monitor
- Abnormal Summary: Displays the current abnormal host name label, details of the abnormal analysis report, and the abnormal value time series chart displaying the abnormal trend
- Abnormal Analysis: Abnormal analysis dashboard, which displays basic information such as abnormal processes and CPU usage of the host
- Host Details: Displays the integration running status, system information, and cloud vendor information of the host

**Note**: When there are multiple interval abnormalities, the Abnormal Summary > Abnormal Trend Chart and Abnormal Analysis dashboard display the analysis of the abnormalities in the first interval by default. You can click the [Abnormal Trend Chart] to switch. After switching, the abnormal analysis dashboard will be linked accordingly.

:material-numeric-2-circle-outline: [Extended Fields](../../events/event-explorer/event-details.md#extension)

:material-numeric-3-circle-outline: [Alert Notification](../../events/event-explorer/event-details.md#alarm)

:material-numeric-4-circle-outline: [History Record](../../events/event-explorer/event-details.md#history)

:material-numeric-5-circle-outline: [Related Events](../../events/event-explorer/event-details.md#relevance)
