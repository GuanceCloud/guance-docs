# Outlier Detection
---

Through algorithmic analysis of the metrics or statistical data within a specific group, this method identifies significant outliers. If the detected inconsistencies exceed preset thresholds, the system generates an outlier detection incident for subsequent alert tracking and analysis. This approach helps to promptly identify and address potential anomalies, improving the accuracy and response speed of monitoring.

## Application Scenarios

You can configure appropriate distance parameters based on the characteristics of the metric data to trigger emergency events when data significantly deviates from the normal range. For example, you can set up monitoring so that when a host's memory usage is significantly higher than others, the system can promptly issue an alert. Such configurations help quickly identify and respond to potential performance issues or anomalies.

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
| Data Type | The current data type being detected, including Metrics, logs, infrastructure, Resource Catalog, events, APM, RUM, Security Check, network, and Profile. |
| Mearsurement | The Metrics set where the current detection metric resides. |
| Metric | The specific metric being detected. |
| Aggregation Algorithm | Includes Avg by (average), Min by (minimum), Max by (maximum), Sum by (sum), Last (last value), First by (first value), Count by (count of data points), Count_distinct by (count of distinct data points), p50 (median), p75 (75th percentile), p90 (90th percentile), p99 (99th percentile). |
| Detection Dimensions | Any string type (`keyword`) fields in the configuration data can be selected as detection dimensions. Currently, up to three fields are supported. By combining multiple detection dimension fields, a specific detection object can be determined. Guance will evaluate whether the statistical metrics of a detection object meet the threshold conditions for triggering events.<br />* (For example, selecting detection dimensions `host` and `host_ip` would result in a detection object like `{host: host1, host_ip: 127.0.0.1}`). |
| Filtering Conditions | Filters detection metric data based on metric labels to limit the scope of detection; supports adding one or more label filters; supports fuzzy matching and non-matching filter conditions. |
| Alias | Custom name for the detection metric. |
| [Query](../../scene/visual-chart/chart-query.md) Method | Supports simple queries and expression queries. |

### Trigger Conditions

Configure trigger conditions for different alert levels: you can configure any one of critical, normal, data gap, or informational triggers.

Set trigger conditions and severity levels. When query results contain multiple values, an event is generated if any value meets the trigger condition.

| <div style="width: 100px">Severity</div> | Description |
| --- | --- |
| Critical (Red) | Uses the DBSCAN algorithm, which allows configuring suitable distance parameters based on the characteristics of the metric data to trigger critical events. Distance parameter indicates the maximum distance between two samples that are considered neighbors, not the maximum distance within a cluster (float, default=0.5).<br /><br />:warning: You can configure any floating-point value between 0-3.0. If not configured, the default distance parameter is 0.5. Larger distances yield fewer anomaly points, while smaller distances may detect too many outliers, and overly large distances might result in no outliers being detected. Therefore, appropriate distance parameters should be set based on different data characteristics. |
| Normal (Green) | Configurable number of times. If the detection metric triggers a "critical" anomaly event, and then N consecutive detections are normal, a "normal" event is generated. This helps determine if an anomaly has returned to normal, and it is recommended to configure this. |

### Data Gap Handling

Seven strategies can be configured for handling data gaps.

1. Link with the detection interval time range, judge the query results of the most recent minutes of the detection metric, **do not trigger events**;

2. Link with the detection interval time range, judge the query results of the most recent minutes of the detection metric, **treat the query result as 0**; at this point, the query result will be compared against the threshold configured in the **trigger conditions** above to determine if an anomaly event should be triggered.

3. Customize the fill value for the detection interval, **trigger data gap events, critical events, major events, warning events, and recovery events**; when choosing this strategy, it is recommended that the custom data gap time configuration be **>= detection interval time**. If the configured time <= detection interval time, both data gap and anomaly conditions may be met simultaneously, in which case only the data gap processing result will apply.


### Information Generation

Enabling this option writes unmatched detection results as "informational" events.

**Note**: When configuring trigger conditions, data gap handling, and information generation simultaneously, the following priority applies: data gap > trigger conditions > information event generation.