# Application Intelligent Detection
---

Using intelligent detection algorithms, it can automatically identify sudden increases or decreases in the number of application requests, surges in the number of error requests, and sharp rises or falls in request delays. These anomaly patterns are captured through anomaly metrics of application services and automatically trigger the anomaly analysis process.

## Use Cases

Used to monitor whether application services experience anomalies or interruptions, ensuring smooth service operation.

## Detection Configuration {#config}

![](../img/intelligent-detection09.png)

1. Define the monitor name.

2. Select the detection scope: filter detection metric data based on metric labels to limit the range of detected data. Supports adding one or multiple label filters. If no filters are added, all metric data will be detected.


## View Events

The monitor retrieves the metric information of the monitored application service objects for the past 10 minutes. When an anomaly is detected, corresponding events are generated and can be viewed in the [**Events > Intelligent Monitoring**](../../events/inte-monitoring-event.md) list.

### Event Details Page

In the event viewer, you can view the details page of intelligent monitoring events, including event status, anomaly occurrence time, anomaly name, analysis report, alert notifications, history, and related events.

* Click the **Go to Monitor** button in the top-right corner to adjust the [intelligent monitor configuration](index.md);

* Click the **Export** button in the top-right corner to choose between **Export JSON File** and **Export PDF File**, thereby obtaining all key data corresponding to the current event.

:material-numeric-1-circle-outline: Analysis Report

![](../img/intelligent-detection11.png)

* Anomaly Summary: Displays the current anomalous application service tags, detailed anomaly analysis reports, and statistics on the distribution of anomaly values.

* Resource Analysis: For request volume monitoring, you can view resource request rankings (Top 10), resource error request rankings (Top 10), and resource requests per second rankings (Top 10).

**Note**: When there are multiple anomaly intervals, the **Anomaly Analysis** dashboard defaults to displaying the first interval's anomaly situation. You can click on the [Anomaly Value Distribution Chart] to switch intervals, after which the anomaly analysis dashboard will synchronize accordingly.

:material-numeric-2-circle-outline: [Extension Fields](../../events/event-explorer/event-details.md#extension)

:material-numeric-3-circle-outline: [Alert Notifications](../../events/event-explorer/event-details.md#alarm)

:material-numeric-4-circle-outline: [Related Events](../../events/event-explorer/event-details.md#relevance)