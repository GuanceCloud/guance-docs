# Logs Detection
---


Logs Detection is based on intelligent detection algorithms to monitor the log data generated by collectors in the workspace. It is suitable for scenarios such as code exceptions or task scheduling detection in IT monitoring. For example, monitoring a sudden increase in log errors.

## Use Cases

This is particularly applicable to code anomalies or task scheduling detection in IT monitoring scenarios. For example, monitoring a sudden increase in error count in logs.

## Setup

Click on **Intelligent Monitoring > Create > Logs Detection** to enter the configuration page for intelligent log detection.

### Step 1: Detection Configuration

![image](../img/intelligent-detection06.png)

:material-numeric-1-circle-outline: **Monitor Name**: Edit the name of the monitor.

:material-numeric-2-circle-outline: **Detection Frequency**: The frequency at which the detection rule is executed is fixed at 1 hour.

:material-numeric-3-circle-outline: **Detection Dimension**: Based on Source (By Source) or Service (By Service), automatically matching the selected detection dimension.

:material-numeric-4-circle-outline: **Filter**: Filter the data of the detection metrics based on metric tags and limit the range of data to be detected. Adding one or more tag filters is supported.

### Step 2: Event Notification

![image](../img/intelligent-detection07.png)

:material-numeric-5-circle-outline: **Event Content**: The content of the event notification sent when the trigger condition is met. Support input in Markdown format, preview of the effect, use of preset [associated links](link-description.md) and use of preset [template variables](../event-template.md).

**Note**: Different notification objects support different Markdown syntax. For example, WeChat Work does not support unordered lists.

:material-numeric-6-circle-outline: **Synchronously create Issue**: If an abnormal event occurs under this monitor, an issue for anomaly tracking will be created synchronously and delivered to the channel for anomaly tracking. You can go to [Incident](../../exception/index.md) >  Your selected [Channel](../../exception/channel.md) to view it.

### Step 3: Alarm Configuration

:material-numeric-7-circle-outline: Alert Strategy: After the monitoring meets the triggering conditions, it immediately sends an alert message to the specified notification object.

**Note**: The event level triggered by intelligent monitoring is "error".

## Monitor List

After creating a detection rule, you can view and manage the it in the Intelligent Monitoring list.

![image](../img/intelligent-detection01.png)

### Operations

<div class="grid cards" markdown>

- [<font color="coral"> :fontawesome-solid-arrow-up-right-from-square: &nbsp; Monitor List</font>](../monitor/index.md#list)


</div>


### View Events

The monitor will obtain the latest 30 minutes of log detection metrics. When a sudden increase or decrease in log quantity or an increase in error logs is identified, the corresponding events will be generated. You can view abnormal events in the **Events > Intelligent Monitoring** list.

![image](../img/intelligent-detection04.png)

#### Event Details Page

Click on Event to view the details page of the intelligent monitoring event, including event status, abnormal occurrence time, abnormal name, analysis report, alert notification, history records and associated events.

* Click on the upper right corner Jump to Monitor to view and adjust the [configuration](index.md);

* Click on the upper right corner **Export** button to select **Export JSON** or **Export PDF** to obtain all key data corresponding to the current event.

:material-numeric-1-circle-outline: Analysis Report

![](../img/intelligent-detection08.png)

* Abnormal Summary: You can view the current abnormal log tags, details of the abnormal analysis report and the distribution of error requests.

* Error Analysis: You can view the clustering information of error logs.

**Note**: When there are multiple intervals of abnormalities, the Abnormal Summary > Abnormal Value Distribution Chart and Abnormal Analysis dashboard will display the analysis of the first abnormal interval by default. You can click on the Abnormal Value Distribution Chart to switch. After switching, the abnormal analysis dashboard will be synchronized.

:material-numeric-2-circle-outline: [Extended Fields](../../events/event-explorer/event-details.md#extension)

:material-numeric-3-circle-outline: [Alert Notification](../../events/event-explorer/event-details.md#alarm)

:material-numeric-4-circle-outline: [History Record](../../events/event-explorer/event-details.md#history)

:material-numeric-5-circle-outline: [Related Events](../../events/event-explorer/event-details.md#relevance)