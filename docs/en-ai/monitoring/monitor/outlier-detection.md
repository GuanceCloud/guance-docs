# Outlier Detection
---

By analyzing the metrics or statistical data of specific groups, this method identifies significant outliers. If inconsistencies detected exceed preset thresholds, the system generates an outlier detection incident for subsequent alert tracking and analysis. This approach helps promptly identify and address potential anomalies, improving monitoring accuracy and response speed.

## Use Cases

You can configure appropriate distance parameters based on the characteristics of the metric data to trigger critical events when data significantly deviates from the normal range. For example, you can set up monitoring so that when a host's memory usage is significantly higher than others, the system promptly issues an alert. Such configurations help quickly identify and respond to potential performance issues or anomalies.

## Detection Configuration

![](../img/5.monitor_9.png)

### Detection Frequency

Automatically matches the selected detection interval.

### Detection Interval

The time range for querying detection metrics.

| Detection Interval (Dropdown Options) | Default Detection Frequency |
| --- | --- |
| 15m | 5m |
| 30m | 5m |
| 1h | 15m |
| 4h | 30m |
| 12h | 1h |
| 1d | 1h |

### Detection Metrics

The monitored metric data.

| Field | Description |
| --- | --- |
| Data Type | The current data type being detected, including Metrics, Logs, Infrastructure, Resource Catalog, Events, APM, RUM, Security Check, Network, and Profile. |
| Mearsurement | The measurement set where the current detection metrics reside. |
| Metric | The specific metric being detected. |
| Aggregation Algorithm | Includes Avg by (average), Min by (minimum), Max by (maximum), Sum by (sum), Last (last value), First by (first value), Count by (number of data points), Count_distinct by (number of distinct data points), p50 (median), p75 (75th percentile), p90 (90th percentile), p99 (99th percentile). |
| Detection Dimensions | Any string type (`keyword`) fields in the configured data can be selected as detection dimensions. Currently, up to three fields are supported. By combining multiple detection dimension fields, a specific detection object can be determined. <<< custom_key.brand_name >>> will determine if the statistical metric of a detection object meets the threshold conditions; if it does, an event is generated.<br />* (For example, selecting detection dimensions `host` and `host_ip` results in a detection object like `{host: host1, host_ip: 127.0.0.1}`.) * |
| Filter Conditions | Filters the detection metrics data based on metric labels to limit the scope of detection; supports adding one or more label filters; supports fuzzy matching and non-matching filter conditions. |
| Alias | Custom name for the detection metric. |
| [Query](../../scene/visual-chart/chart-query.md) Method | Supports simple queries and expression queries. |

### Trigger Conditions

Set the alert level trigger conditions: you can configure any one of the critical, normal, data gap, or informational triggers.

Configure trigger conditions and severity levels. When query results contain multiple values, any value meeting the trigger condition will generate an event.

| <div style="width: 100px">Severity</div> | Description |
| --- | --- |
| Critical (Red) | Uses the DBSCAN algorithm, allowing configuration of suitable distance parameters based on metric data characteristics to trigger critical events. Distance parameter indicates the maximum distance between two samples to be considered neighbors, not the maximum distance within a cluster (float, default=0.5).<br /><br />:warning: You can choose any floating-point value between 0 and 3.0. If not configured, the default distance parameter is 0.5. Larger distances result in fewer anomaly points, while smaller distances may detect many outliers. Very large distances may result in no outliers detected, so suitable distance parameters should be set according to different data characteristics. |
| Normal (Green) | Configurable number of times. If the detection metric triggers a "Critical" anomaly event, and then N consecutive detections are normal, a "Normal" event is generated. Used to determine if an anomaly has returned to normal, it is recommended to configure this. |

### Data Gap Handling

Seven strategies can be configured for handling data gaps.

1. Linked to the detection interval time range, evaluate the most recent minutes of the detection metric's query results, **do not trigger events**;

2. Linked to the detection interval time range, evaluate the most recent minutes of the detection metric's query results, **consider query results as 0**; at this point, the query results will be compared with the thresholds configured in the **trigger conditions** to determine if an anomaly event should be triggered.

3. Custom fill for detection interval values, **trigger data gap events, critical events, important events, warning events, and recovery events**; if this strategy is chosen, it is suggested that the custom data gap time configuration be **>= detection interval time**. If the configured time <= detection interval time, both data gap and anomaly conditions might be met simultaneously; in such cases, only the data gap handling result will be applied.


### Information Generation

Enabling this option writes unmatched detection results as "Informational" events.

**Note**: When configuring trigger conditions, data gap handling, and information generation simultaneously, the following priority applies: data gap > trigger conditions > information event generation.