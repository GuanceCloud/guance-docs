# Intelligent Monitoring for Kubernetes
---

Based on intelligent monitoring algorithms, by regularly monitoring key metrics such as the total number of Pods, Pod restarts, and API Server QPS, etc., intelligent monitoring for Kubernetes can promptly detect and predict potential issues within the cluster. This method not only identifies abnormal fluctuations in resource usage but also precisely pinpoints the root cause of problems, whether they are configuration errors, resource mismatches, or excessive requests. This makes the operation and maintenance of Kubernetes clusters more intelligent and automated.

## Application Scenarios

Deep insights into various performance metrics of the cluster, providing comprehensive monitoring capabilities from cluster resources, service resources to the API server level.

## Monitoring Configuration {#config}

![](../img/k8s.png)

1. Define the monitor name;

2. Select the monitoring scope: filter based on the cluster, namespace, and host to limit the data range for monitoring. Supports adding one or multiple label filters. If no filters are added, all metric data will be monitored.


## View Events

The monitor retrieves the metrics information of application service objects from the last 10 minutes. When anomalies are detected, corresponding events are generated, which can be viewed in the [**Events > Intelligent Monitoring**](../../events/inte-monitoring-event.md) list.

### Event Details Page

Click **Event** to view the details page of intelligent monitoring events, including event status, time of anomaly occurrence, anomaly name, analysis report, alert notifications, history, and related events.

* Click the **Go to Monitor** button in the top-right corner to adjust the [intelligent monitor configuration](index.md);

* Click the **Export** button in the top-right corner to choose between exporting a **JSON file** or a **PDF file**, thereby obtaining all critical data associated with the current event.

:material-numeric-1-circle-outline: Analysis Report

![](../img/k8s-1.png)


* Summary of Anomalies: Displays statistics on the distribution of anomalous API server nodes in the current cluster.

* Anomaly Analysis: You can view information such as the number of API server nodes, API QPS, the number of read requests being processed, write request success rate, and the number of write requests being processed.

<!--
**Note**: When there are multiple intervals of anomalies, the **Anomaly Analysis** dashboard defaults to displaying the first interval's anomaly situation. You can switch by clicking the [Anomaly Value Distribution Chart], and after switching, the anomaly analysis dashboard synchronizes accordingly.
-->

:material-numeric-2-circle-outline: [Extension Fields](../../events/event-explorer/event-details.md#extension)

:material-numeric-3-circle-outline: [Alert Notifications](../../events/event-explorer/event-details.md#alarm)

:material-numeric-4-circle-outline: [Related Events](../../events/event-explorer/event-details.md#relevance)