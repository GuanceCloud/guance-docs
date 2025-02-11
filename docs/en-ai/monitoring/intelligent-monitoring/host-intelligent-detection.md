# Intelligent Host Monitoring
---

Relying on intelligent detection algorithms, the system will periodically monitor the CPU and memory usage of hosts. When anomalies in CPU or memory are detected, an in-depth root cause analysis is performed to determine if there are sudden increases, decreases, or sustained rises in abnormal patterns, thereby effectively monitoring the operational status and stability of the host.

## Application Scenarios

Suitable for monitoring business hosts with high requirements for stability and reliability, providing analysis reports for generated anomaly events.

## Detection Configuration {#config}

![](../img/intelligent-detection03.png)

1. Define the monitor name;

2. Select detection scope: By filtering and combining criteria, limit the range of hosts to be monitored. If no filters are added, Guance monitors all hosts' data.


## View Events

The monitor retrieves the CPU, memory, network, and disk usage of the monitored hosts over the past 10 minutes. When anomalies are identified, corresponding events are generated and can be viewed in the **Events > Intelligent Monitoring** list.

### Event Details Page

Click **Events** to view the details page of intelligent monitoring events, including event status, time of anomaly occurrence, anomaly name, analysis report, extended fields, alert notifications, historical records, and related events.

* Click the **Jump to Monitor** button in the top-right corner to adjust [Intelligent Monitoring Configuration](index.md);

* Click the **Export** button in the top-right corner to export as a **JSON file** or **PDF file**, obtaining all key data for the current event.

:material-numeric-1-circle-outline: Analysis Report

![](../img/intelligent-detection10.png)

* Event content: Displays the event content based on the monitor configuration;
* Anomaly Summary: Displays the hostname label of the current anomalous host, detailed anomaly analysis report, and time series chart showing anomaly trends;
* Anomaly Analysis: Anomaly analysis dashboard, displaying basic information such as abnormal processes and CPU usage on the host;
* Host Details: Displays the integrated operation status, system information, and cloud provider information of the host.

**Note**: When multiple intervals have anomalies, the **Anomaly Summary > Anomaly Trend Chart** and the **Anomaly Analysis** dashboard default to displaying the analysis of the first anomalous interval. You can switch by clicking the **Anomaly Trend Chart**, and the anomaly analysis dashboard will synchronize accordingly.

:material-numeric-2-circle-outline: [Extended Fields](../../events/event-explorer/event-details.md#extension)

:material-numeric-3-circle-outline: [Alert Notifications](../../events/event-explorer/event-details.md#alarm)

:material-numeric-4-circle-outline: [Historical Records](../../events/event-explorer/event-details.md#history)

:material-numeric-5-circle-outline: [Related Events](../../events/event-explorer/event-details.md#relevance)