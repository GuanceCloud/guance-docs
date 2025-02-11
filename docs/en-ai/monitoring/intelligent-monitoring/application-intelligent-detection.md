# Application Intelligent Detection
---

Using intelligent detection algorithms, it can automatically identify sudden increases or decreases in the number of application requests, surges in the number of error requests, and sharp rises or falls in request latency. These anomaly patterns are captured through anomaly metrics of application services and automatically trigger the anomaly analysis process.

## Use Cases

This is used to monitor whether application services experience anomalies or interruptions, ensuring that services operate smoothly.

## Detection Configuration {#config}

![](../img/intelligent-detection09.png)

1. Define the monitor name.

2. Select the detection scope: Filter the data for detection metrics based on metric labels, limiting the scope of detected data. You can add one or more label filters. If no filters are added, all metric data will be detected.

## View Events

The monitor retrieves the metric information of the monitored application service objects from the past 10 minutes. When an anomaly is identified, corresponding events are generated and can be viewed in the [**Events > Intelligent Monitoring**](../../events/inte-monitoring-event.md) list.

### Event Details Page

In the event viewer, you can view the details page of intelligent monitoring events, including event status, anomaly occurrence time, anomaly name, analysis report, alert notifications, history, and related events.

* Click the **Go to Monitor** button in the top-right corner to view and adjust the [intelligent monitor configuration](index.md);

* Click the **Export** button in the top-right corner to export the current event's key data as a **JSON file** or **PDF file**.

:material-numeric-1-circle-outline: Analysis Report

![](../img/intelligent-detection11.png)

* Anomaly Summary: Displays the tags of the currently abnormal application services, detailed anomaly analysis reports, and statistics on the distribution of anomaly values.

* Resource Analysis: Monitors request volumes, allowing you to view resource request rankings (Top 10), resource error request rankings (Top 10), and resource requests per second rankings (Top 10).

**Note**: When multiple intervals exhibit anomalies, the **Anomaly Analysis** dashboard defaults to displaying the first interval's anomalies. You can switch by clicking on the **Anomaly Value Distribution Chart**, which synchronizes with the dashboard.

:material-numeric-2-circle-outline: [Extended Fields](../../events/event-explorer/event-details.md#extension)

:material-numeric-3-circle-outline: [Alert Notifications](../../events/event-explorer/event-details.md#alarm)

:material-numeric-4-circle-outline: [Related Events](../../events/event-explorer/event-details.md#relevance)