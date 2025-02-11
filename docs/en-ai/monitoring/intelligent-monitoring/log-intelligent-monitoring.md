# Intelligent Log Detection
---

Based on intelligent detection algorithms, this feature monitors log data collected by collectors within the workspace. It intelligently identifies anomalies such as sudden increases or decreases in log volume and sudden spikes in error logs, promptly detecting unexpected abnormal conditions.

## Application Scenarios

This is particularly suitable for IT monitoring scenarios, such as code exceptions or task scheduling detection. For example, monitoring a sudden increase in error logs.

## Detection Configuration

![](../img/intelligent-detection06.png)

1. Define the monitor name.

2. Select detection dimensions: Supports **By Source** or **By Service** detection, automatically matching the selected dimension.

3. Select detection scope: Filter detection metrics data based on metric labels to limit the scope of detected data. You can add one or more label filters. If no filters are added, all log data will be detected.


## View Events

The monitor retrieves the latest 10 minutes of log metrics. When it detects sudden increases or decreases in log volume or sudden spikes in error logs, corresponding events are generated. These events can be viewed under **Events > Intelligent Monitoring**.

### Event Details Page

Clicking **Event** allows you to view the details page of an intelligent monitoring event, including event status, anomaly occurrence time, anomaly name, analysis report, alert notifications, historical records, and related events.

* Click the **Go to Monitor** button in the top right corner to view and adjust [Intelligent Monitor Configuration](index.md);

* Click the **Export** button in the top right corner to choose between exporting a **JSON file** or a **PDF file**, thereby obtaining all key data related to the current event.

:material-numeric-1-circle-outline: Analysis Report

![](../img/intelligent-detection08.png)

* Anomaly Summary: View the current anomaly log tags, detailed anomaly analysis reports, and distribution of failed request counts.

* Error Analysis: View clustering information of error logs.

**Note**: When multiple intervals have anomalies, the **Anomaly Summary > Anomaly Value Distribution Chart** and **Anomaly Analysis** dashboard default to displaying the analysis of the first anomalous interval. You can switch by clicking on the **Anomaly Value Distribution Chart**, and the anomaly analysis dashboard will synchronize accordingly.

:material-numeric-2-circle-outline: [Extension Fields](../../events/event-explorer/event-details.md#extension)

:material-numeric-3-circle-outline: [Alert Notifications](../../events/event-explorer/event-details.md#alarm)

:material-numeric-4-circle-outline: [Historical Records](../../events/event-explorer/event-details.md#history)

:material-numeric-5-circle-outline: [Related Events](../../events/event-explorer/event-details.md#relevance)