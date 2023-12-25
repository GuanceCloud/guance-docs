# APM Detection
---


APM Detection is based on intelligent detection algorithms that intelligently identify abnormal situations such as a sudden increase or decrease in the number of application requests, a sudden increase in the number of error requests, and a sudden increase, decrease or interval rise in request latency. It automatically performs anomaly analysis based on application service anomaly metrics.

## Use Cases

APM Detection is used to monitor whether application services experience anomalies or interruptions and ensure smooth operation of the services.

## Setup

Click on **Intelligent Monitoring > Create > APM Detection** to enter the rule configuration page.

### Step 1: Detection Configuration {#config}

![image](../img/intelligent-detection09.png)

:material-numeric-1-circle-outline: **Monitor Name**: Edit the name of the monitor.

:material-numeric-2-circle-outline: **Detection Frequency**: The execution frequency of the detection rule, fixed at 30 minutes.

:material-numeric-3-circle-outline: **Filter**: Filter the data of the detection metrics based on metric tags to limit the range of data to be detected. Adding one or more tag filters is supported.

### Step 2: Event Notification

![image](../img/intelligent-detection07.png)

:material-numeric-4-circle-outline: **Event Content**: The content of the event notification sent when the trigger condition is met. Support input in Markdown format, preview of the effect, use of preset [associated links](link-description.md) and use of preset [template variables](../event-template.md).

**Note**: Different notification objects support different Markdown syntax. For example, WeChat Work does not support unordered lists.

:material-numeric-5-circle-outline: **Synchronously create Issue**: If an abnormal event occurs under this monitor, an issue for anomaly tracking will be created synchronously and delivered to the channel for anomaly tracking. You can go to [Incident](../../exception/index.md) >  Your selected [Channel](../../exception/channel.md) to view it.

### Step 3: Alert Configuration

:material-numeric-6-circle-outline: **Alert Strategy**: After the monitoring meets the trigger conditions, immediately send an alert message to the specified notification object.

**Note**: The event level triggered by intelligent monitoring is "error".

## Monitor List

After creating a detection rule, you can view and manage the it in the Intelligent Monitoring list.

![image](../img/intelligent-detection01.png)

### Operations

<div class="grid cards" markdown>

- [<font color="coral"> :fontawesome-solid-arrow-up-right-from-square: &nbsp; Monitor List Operations</font>](../monitor/index.md#list)

</div>

### View Events

The monitor will obtain the metric information of the detected application service objects in the last 30 minutes. When an abnormal situation is identified, the corresponding event will be generated, and you can view the corresponding abnormal events in the **[Events > Intelligent Monitoring](../../events/inte-monitoring-event.md)** list.

![image](../img/intelligent-detection04.png)

#### Event Details Page

Click on Event to view the details page of the intelligent monitoring event, including event status, abnormal occurrence time, abnormal name, analysis report, alert notification, history records and associated events.

* Click on the upper right corner Jump to Monitor to view and adjust the [configuration](index.md);

* Click on the upper right corner **Export** button to select **Export JSON** or **Export PDF** to obtain all key data corresponding to the current event.

:material-numeric-1-circle-outline: Analysis Report

![](../img/intelligent-detection11.png)

![](../img/intelligent-detection12.png)

* Abnormal Analysis: Display the current abnormal application service tags, details of the abnormal analysis report, and statistics on the distribution of abnormal values.

* Resource Analysis: For request monitoring, you can view the rankings of resource request counts (TOP 10), resource error request counts (TOP 10), resource requests per second (TOP 10), and other information.

**Note**: When there are multiple interval anomalies, the dashboard displays the analysis of the first segment by default. You can click on the **Abnormal Value Distribution Chart** to switch, and the abnormal analysis dashboard will be synchronized accordingly.

:material-numeric-2-circle-outline: [Extended Fields](../../events/event-explorer/event-details.md#extension)

:material-numeric-3-circle-outline: [Alert Notification](../../events/event-explorer/event-details.md#alarm)

:material-numeric-4-circle-outline: [Related Events](../../events/event-explorer/event-details.md#relevance)




