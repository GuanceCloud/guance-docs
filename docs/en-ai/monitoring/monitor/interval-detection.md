# Interval Detection
---

Within the selected time range, <<< custom_key.brand_name >>> will perform anomaly detection on metrics data. If the proportion of mutation anomalies in the detected data points exceeds the preset threshold percentage, an interval anomaly event will be triggered.


## Use Cases

This is used for monitoring trend-stable data/metrics. For example, if the percentage of abnormal data points due to sudden changes in host CPU usage over the past day exceeds 10%, an anomaly event will be generated.

## Detection Configuration

![](../img/example03.png)

### Detection Frequency

This refers to the execution frequency of the detection rule, automatically matching the selected detection interval.

### Detection Interval

This is the time range for querying metrics each time the task is executed.

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
| Data Type | The current data type being detected, including Metrics, Logs, Infrastructure, Resource Catalog, Events, APM, RUM, Security Check, Network, and Profile. |
| Measurement | The Measurement set where the current detected metric resides. |
| Metric | The specific metric being detected. |
| Aggregation Algorithm | Includes Avg by (average), Min by (minimum), Max by (maximum), Sum by (sum), Last (last value), First by (first value), Count by (number of data points), Count_distinct by (number of unique data points), p50 (median), p75 (75th percentile), p90 (90th percentile), p99 (99th percentile). |
| Detection Dimensions | Any string type (`keyword`) fields in the configuration can be selected as detection dimensions. Currently, up to three fields can be chosen. By combining multiple detection dimension fields, a specific detection object can be determined. <<< custom_key.brand_name >>> will evaluate whether the statistical metrics of a specific detection object meet the threshold conditions for triggering events.<br />* (For example, selecting detection dimensions `host` and `host_ip` would result in a detection object like `{host: host1, host_ip: 127.0.0.1}`). * |
| Filtering Conditions | Filter the data of the detected metrics based on metric labels to limit the scope of detection; supports adding one or more label filters; supports fuzzy matching and non-matching filtering conditions. |
| Alias | Custom name for the detected metric. |
| [Query](../../scene/visual-chart/chart-query.md) Method | Supports simple queries and expression queries. |

### Trigger Conditions

Set the trigger conditions for alert levels: you can configure any one of critical, major, minor, or normal trigger conditions. It supports three forms of data comparison: upward (data increase), downward (data decrease), or both upward and downward.

Configure trigger conditions and severity levels. When the query results contain multiple values, an event will be generated if any value meets the trigger condition.

> For more details, refer to [Event Level Description](event-level-description.md).

???+ abstract "Alert Levels"

    1. **Critical (Red), Major (Orange), Minor (Yellow)**: Based on configured conditions and operators.
  

    2. **Normal (Green)**: Based on the number of detections configured, as follows:

	- Each execution of a detection task counts as one detection. For example, if the detection frequency is 5 minutes, then one detection = 5 minutes.    
	- You can customize the number of detections. For example, if the detection frequency is 5 minutes, then 3 detections = 15 minutes.   

	| Level | Description |
	| --- | --- |
	| Normal | After the detection rule takes effect, if critical, major, or minor anomaly events occur, and the data returns to normal within the configured number of detections, a recovery alert event will be generated.<br/> :warning: Recovery alert events are not subject to [alert muting](../alert-setting.md). If no recovery alert detection count is set, the alert event will not recover and will remain in the [**Events > Unrecovered Events List**](../../events/event-explorer/unrecovered-events.md).|


### Data Gap Handling

You can configure seven strategies for handling data gaps.

1. Link with the detection interval time range to judge the query results of the most recent minutes of the detected metrics, **do not trigger events**;

2. Link with the detection interval time range to judge the query results of the most recent minutes of the detected metrics, **consider the query results as 0**; at this point, the query results will be compared with the thresholds configured in the **trigger conditions** to determine whether an anomaly event should be triggered.

3. Customize the fill-in value for the detection interval, **trigger data gap events, critical events, major events, minor events, and recovery events**; when choosing this configuration strategy, it is recommended that the custom data gap time be **>= detection interval time**. If the configured time <= detection interval time, there may be simultaneous satisfaction of data gap and anomaly conditions, in which case only the data gap handling result will be applied.


### Information Generation

Enabling this option will generate "information" events for detection results that do not match any of the above trigger conditions and write them into the system.


**Note**: If trigger conditions, data gap handling, and information generation are all configured, the following priority order will be followed: data gap handling > trigger conditions > information event generation.