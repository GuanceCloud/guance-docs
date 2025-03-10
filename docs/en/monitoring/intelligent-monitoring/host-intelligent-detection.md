# Intelligent Host Detection
---

Relying on intelligent detection algorithms, the system will periodically monitor the CPU and memory usage of hosts. When anomalies in CPU or memory are detected, an in-depth root cause analysis is conducted to determine if there are any sudden increases, decreases, or sustained rises in abnormal patterns. This effectively monitors the operational status and stability of the host.

## Use Cases

Suitable for monitoring business hosts that require high stability and reliability, providing analysis reports for generated anomaly events.

## Detection Configuration {#config}

![](../img/intelligent-detection03.png)

1. Define the monitor name;

2. Select detection scope: Limit the range of hosts to be detected through filtering combinations. If no filters are added, <<< custom_key.brand_name >>> detects data from all hosts.


## View Events

The monitor retrieves the CPU, memory, network, and disk usage of the target host over the past 10 minutes. When anomalies are identified, corresponding events are generated and can be viewed in the **Events > Intelligent Monitoring** list.

### Event Details Page

Click **Events** to view the details page of intelligent monitoring events, including event status, time of anomaly occurrence, anomaly name, analysis report, extended fields, alert notifications, historical records, and related events.

* Click the **Jump to Monitor** button in the top-right corner to view and adjust [Intelligent Monitoring Configuration](index.md);

* Click the **Export** button in the top-right corner to export as a **JSON file** or **PDF file**, thus obtaining all key data associated with the current event.

:material-numeric-1-circle-outline: Analysis Report

![](../img/intelligent-detection10.png)

* Event content: Displays the event content configured by the monitor;
* Anomaly summary: Shows the hostname label of the current anomalous host, detailed anomaly analysis report, and anomaly trend chart;
* Anomaly analysis: Anomaly analysis dashboard displaying basic information such as abnormal processes and CPU usage;
* Host details: Displays the integrated operational status, system information, and cloud provider information.

**Note**: When multiple intervals have anomalies, the **Anomaly Summary > Anomaly Trend Chart** and **Anomaly Analysis** dashboard default to showing the analysis of the first anomaly interval. You can click on the **Anomaly Trend Chart** to switch intervals, and the anomaly analysis dashboard will synchronize accordingly.

:material-numeric-2-circle-outline: [Extended Fields](../../events/event-explorer/event-details.md#extension)

:material-numeric-3-circle-outline: [Alert Notifications](../../events/event-explorer/event-details.md#alarm)

:material-numeric-4-circle-outline: [Historical Records](../../events/event-explorer/event-details.md#history)

:material-numeric-5-circle-outline: [Related Events](../../events/event-explorer/event-details.md#relevance)