# Kubernetes Intelligent Monitoring
---

Based on intelligent monitoring algorithms, by regularly monitoring key metrics such as the total number of Pods, Pod restart counts, and API Server QPS, Kubernetes intelligent monitoring can promptly detect and predict potential issues in the cluster. This method not only identifies abnormal fluctuations in resource usage but also precisely pinpoints the source of problems through root cause analysis, whether they are configuration errors, resource mismatches, or excessive requests. This makes the operation and maintenance work of Kubernetes clusters more intelligent and automated.

## Use Cases

Gain deep insights into various performance metrics of the cluster, providing comprehensive monitoring capabilities from cluster resources, service resources to the API server level.

## Monitoring Configuration {#config}

![](../img/k8s.png)

1. Define the monitor name;

2. Select the monitoring scope: filter based on clusters, namespaces, and hosts to limit the data range for monitoring. Support adding one or multiple label filters. If no filters are added, all metric data will be monitored.


## View Events

The monitor retrieves the metric information of application service objects from the last 10 minutes. When anomalies are detected, corresponding events are generated and can be viewed in the [**Events > Intelligent Monitoring**](../../events/inte-monitoring-event.md) list.


### Event Details Page

Click **Events** to view the details page of intelligent monitoring events, including event status, time of anomaly occurrence, anomaly name, analysis report, alert notifications, historical records, and related events.

* Click the **Jump to Monitor** button at the top right to adjust the [intelligent monitor configuration](index.md);

* Click the **Export** button at the top right to choose between exporting a **JSON file** and exporting a **PDF file**, thereby obtaining all critical data associated with the current event.

:material-numeric-1-circle-outline: Analysis Report

![](../img/k8s-1.png)

* Anomaly Summary: Displays statistics on the distribution of anomalous API Server nodes in the current cluster.

* Anomaly Analysis: View information such as the number of API Server nodes, API QPS, read request processing count, write request success rate, and write request processing count.

<!--
**Note**: When there are multiple intervals of anomalies, the **Anomaly Analysis** dashboard defaults to displaying the anomaly situation of the first interval. You can switch by clicking on the [Anomaly Value Distribution Chart], and after switching, the anomaly analysis dashboard synchronizes accordingly.
-->

:material-numeric-2-circle-outline: [Extension Fields](../../events/event-explorer/event-details.md#extension)

:material-numeric-3-circle-outline: [Alert Notifications](../../events/event-explorer/event-details.md#alarm)

:material-numeric-4-circle-outline: [Related Events](../../events/event-explorer/event-details.md#relevance)