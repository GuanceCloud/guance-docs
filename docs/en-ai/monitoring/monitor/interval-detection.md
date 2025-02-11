# Interval Detection
---

Within the selected time range, Guance will perform anomaly detection on metrics data. If the proportion of mutation anomalies in the detected data points exceeds the preset threshold percentage, an interval anomaly event will be triggered.


## Application Scenarios

This is used for monitoring trend-stable data/metrics. For example, if the proportion of abnormal data points due to sudden changes in host CPU usage over the past day exceeds 10%, an anomaly event is generated.

## Detection Configuration

![](../img/example03.png)

### Detection Frequency

This refers to the execution frequency of the detection rule, which automatically matches the selected detection interval.

### Detection Interval

This refers to the time range of metric queries executed each time the task runs.

| Detection Interval (Dropdown Options) | Detection Frequency |
| --- | --- |
| 15m | 5m |
| 30m | 5m |
| 1h | 15m |
| 4h | 30m |
| 12h | 1h |
| 1d | 1h |

### Detection Metrics

Monitored metrics data.

| Field | Description |
| --- | --- |
| Data Type | The current data type being detected, including metrics, logs, infrastructure, resource catalog, events, APM, RUM, security check, network, and Profile. |
| Mearsurement | The measurement set where the current detection metric resides. |
| Metric | The specific metric being detected. |
| Aggregation Algorithm | Includes Avg by (average), Min by (minimum), Max by (maximum), Sum by (sum), Last (last value), First by (first value), Count by (number of data points), Count_distinct by (number of distinct data points), p50 (median), p75 (75th percentile), p90 (90th percentile), p99 (99th percentile). |
| Detection Dimensions | Any string-type (`keyword`) fields in the configuration can be selected as detection dimensions; currently, up to three fields can be chosen. By combining multiple detection dimension fields, a specific detection object can be determined. Guance will determine whether the statistical metrics for a particular detection object meet the threshold conditions for triggering an event.<br />* (For example, selecting detection dimensions `host` and `host_ip` results in a detection object like `{host: host1, host_ip: 127.0.0.1}`).* |
| Filter Conditions | Filters the metric data based on labels, limiting the scope of detection data; supports adding one or more label filters; supports fuzzy matching and non-matching filter conditions. |
| Alias | Custom name for the detection metric. |
| [Query](../../scene/visual-chart/chart-query.md) Method | Supports simple queries and expression queries. |

### Trigger Conditions

Set the trigger conditions for alert levels: You can configure any one of critical, major, minor, and normal severity levels. Supports upward (data increase), downward (data decrease), or both types of data comparisons.

Configure trigger conditions and severity levels; when query results contain multiple values, any value meeting the trigger condition will generate an event.

> For more details, refer to [Event Level Description](event-level-description.md).

???+ abstract "Alert Levels"

    1. **Alert Levels Critical (Red), Major (Orange), Minor (Yellow)**: Based on configured condition operators.
  

    2. **Alert Level Normal (Green)**: Based on configured detection times, as follows:

	- Each execution of a detection task counts as one detection, e.g., if the detection frequency is 5 minutes, one detection = 5 minutes.
	- You can customize the number of detections, e.g., if the detection frequency is 5 minutes, then 3 detections = 15 minutes.

	| Level | Description |
	| --- | --- |
	| Normal | After the detection rule takes effect, if critical, major, or minor anomaly events occur and the data returns to normal within the configured custom detection times, a recovery alert event is generated.<br/> :warning: Recovery alerts are not subject to [alert mute](../alert-setting.md) restrictions. If recovery alert detection times are not set, the alert event will not recover and will remain in the [**Events > Unrecovered Events List**](../../events/event-explorer/unrecovered-events.md).|


### Data Gaps

You can configure seven strategies for handling data gaps.

1. In conjunction with the detection interval time range, judge the query results of the most recent minutes for the detection metric, **do not trigger an event**;

2. In conjunction with the detection interval time range, judge the query results of the most recent minutes for the detection metric, **consider the query result as 0**; at this point, the query result will be compared against the thresholds configured in the **trigger conditions** to determine if an anomaly event should be triggered.

3. Customize filling of the detection interval value, **trigger data gap events, critical events, major events, minor events, and recovery events**; it is recommended that the custom data gap time configuration be **>= detection interval time**, if the configured time <= detection interval time, there may be simultaneous satisfaction of data gaps and anomalies, in which case only the data gap handling result will apply.


### Information Generation

Enabling this option will generate "information" events for detection results that do not match the above trigger conditions.

**Note**: When configuring trigger conditions, data gaps, and information generation simultaneously, the following priority applies: data gaps > trigger conditions > information event generation.