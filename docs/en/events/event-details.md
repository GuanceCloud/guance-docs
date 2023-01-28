# Event Detail
---

## Overview

In the unrecovered event explorer or event explorer, click any event to view the event details, including basic properties, alarm notification, status & trends, Historical Record, associated event and associated SLO, etc. Click to jump to the monitor associated with the current event, and select "Export JSON file" or "Export PDF file" to get all the key data corresponding to the current event. If a dashboard is associated with the monitor, you can click to view the associated dashboard.

## Event Detail Page

### Basic Properties

Supports viewing the event detection dimension, event content, and extended properties. Click "Jump to Monitor" in the upper right corner to view and adjust the [Monitor Configuration](..monitoring/monitor/index.md). Click the "Export" button in the upper right corner to select "Export JSON file" or "Export PDF file" to get all the key data corresponding to the current event.

![](img/5.event_8.png)

### Alarm Notification
Displays the notification object type, notification object name, whether the notification was sent successfully, etc. Click to expand to show the details of the alert notification object, and support hover copy. (Note: During the silent period, the alert notification will not be sent to the relevant object repeatedly.)

![](img/5.event_10.png)

### Status & Trends
Supports viewing state distribution trends of events, DQL functions and window function line graphs.

![](img/5.event_9.png)

- Status distribution: show the status (urgent, important, warning, no data) of events within the selected time range (default shows the last 6 hours)
- DQL query statement: Real-time indicator data returned by a custom query statement based on anomaly detection rules, showing the real-time indicator data of the last 6 hours by default
- Window function: Based on anomaly detection rules, taking the selected time range as the window (record set) and the detection frequency as the offset, the statistical calculation is carried out again for each record, and the real-time anomaly detection index data used to trigger the alarm is returned. showing the real-time anomaly detection indicator data of the last 6 hours by default

![](img/image.png)

**Note:** In the event details, Guance supports selecting the time range to view the event data

   - When the time range you select is less than ( < = ) 6 hours, "state distribution", "DQL function" and "window function" will show the data and indicator trends of the current time range.
   - When the time range you select is greater than ( > ) 6 hours, "Status Distribution" and "DQL Functions" will display the data of the current time range and an adjustable interval slider will appear (the display range supports a minimum of 15 minutes and a maximum of 6 hours). By moving the interval slider, you can view the "window function" corresponding to its time range

### Historical Record

支持查看检测对象主机、异常/恢复时间和持续时长。

Supports viewing the detection object host, exception/recovery time and duration.

![](img/5.event_11.png)

### Associated Information
Supports viewing information related to the event that triggered the current event, such as viewing the logs related to the triggered event. This Associated Information only supports 4 types of monitor generated events: log detection, security check exception detection, process exception detection, and availability data detection.

> Note: If the log detection contains multiple expression queries, the associated information supports tab switching of multiple expression queries, if there are two expression queries A and B, then it contains two tabs for A and B to be switched.

![](img/3.event_13.png)

**Example of log detection configuration:**

![](img/3.event_13.1.png)

### Associated Event
Supports viewing associated events by filtering the fields and information of the selected time component.

![](img/5.event_12.png)

### Associated Dashboard

If you have configured associated dashboards in the monitor, you can view the associated dashboards.

![](img/5.event_13.png)



### Associated SLO
If an SLO is configured in Monitoring, you can view the associated SLO, including the SLO name, attainment rate, remaining amount, target, and other information.

![](img/5.event_14.png)

## Aggregate Event Detail Page

In the event explorer, after selecting the analysis dimension (e.g. Monitor ID), you can view the aggregated events based on that dimension. Click on an aggregated event to view the details of the corresponding aggregated event, including basic properties, status & trends, alarm notifications, associated events and associated dashboards, etc. For details, please refer to the event details above.

![](img/5.event_15.png)

## Auto Detection Event Detail Page

If the event is from the Auto Detection event, you can view the event details of Auto Detection in the event details page, such as the following diagram is the Auto Detection of Pod, you can view the event overview, exception Pod, container status, error log and other information in the event details, more details can refer to the document [Auto Detection](../monitoring/bot-obs/index.md).

![](img/5.event_16.png)

You can also see the Kubernets metrics view (associated field: df_dimension_tags) added for this Auto Detection, for more details see the documentation [Bind Built-in-view](. /scene/built-in-view/bind-view.md).

![](img/5.event_17.png)