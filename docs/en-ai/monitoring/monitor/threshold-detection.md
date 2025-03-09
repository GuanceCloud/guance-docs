# Threshold Detection
---

Used to monitor anomalies in data such as metrics, logs, traces, etc. You can set threshold ranges, and when the data exceeds these thresholds, the system will trigger alerts and notify externally. Additionally, it supports simultaneous detection of multiple metrics with different alert levels configured for each detection.

## Use Cases

Supports monitoring anomalies in data related to metrics, logs, infrastructure, resource catalogs, events, APM, RUM, security checks, and network aspects. For example, you can monitor if the host memory usage rate is abnormally high.

## Detection Configuration {#steps}

![](../img/monitor14.png)

### Detection Frequency

This refers to the execution frequency of the detection rules; the default selection is 5 minutes.

In addition to the specific options provided by <<< custom_key.brand_name >>>, you can also input a [**custom crontab task**](./detection-frequency.md), configuring scheduled tasks based on minutes, hours, days, months, weeks, etc.

When using a custom Crontab detection frequency, the detection intervals include the last 1 minute, last 5 minutes, last 15 minutes, last 30 minutes, last 1 hour, and last 3 hours.

<img src="../../img/crontab.png" width="60%" >

### Detection Interval

This refers to the time range for querying detection metrics. Depending on the detection frequency, available detection intervals may vary.

| Detection Frequency | Detection Intervals (Dropdown Options) |
| --- | --- |
| 1m | 1m/5m/15m/30m/1h/3h |
| 5m | 5m/15m/30m/1h/3h |
| 15m | 15m/30m/1h/3h/6h |
| 30m | 30m/1h/3h/6h |
| 1h | 1h/3h/6h/12h/24h |
| 6h | 6h/12h/24h |
| 12h | 12h/24h |
| 24h | 24h |

3) **Detection Metrics**: Set the data to be detected.

| Field | Description |
| --- | --- |
| Data Type | The type of data currently being detected, supporting types such as metrics, logs, infrastructure, resource catalogs, events, APM, RUM, security checks, and network data. |
| Mearsurement | The measurement set where the current detection metric resides (for "metrics" data type). |
| Metric | The specific metric targeted for detection (for "metrics" data type). |
| Aggregation Algorithm | Includes Avg by (average value), Min by (minimum value), Max by (maximum value), Sum by (sum), Last (last value), First by (first value), Count by (number of data points), Count_distinct by (number of distinct data points), p50 (median value), p75 (value at 75% position), p90 (value at 90% position), p99 (value at 99% position). |
| Detection Dimensions | String type (`keyword`) fields in the configuration can be selected as detection dimensions. Currently, up to three fields are supported. By combining multiple detection dimension fields, a specific detection object can be determined. <<< custom_key.brand_name >>> will determine whether the statistical metric of a certain detection object meets the threshold conditions. If the conditions are met, an event is generated.<br />* (For example, selecting detection dimensions `host` and `host_ip`, the detection object could be {host: host1, host_ip: 127.0.0.1}. When the detection object is "logs," the default detection dimensions are `status`, `host`, `service`, `source`, `filename`.) |
| Filtering Conditions | Filter the data of the detection metrics based on the labels of the metrics, limiting the scope of the detected data. Multiple label filters can be added, and non-metric data types support fuzzy matching and fuzzy mismatching filtering conditions. |
| Alias | Customize the name of the detection metric. |
| [Query Method](../../scene/visual-chart/chart-query.md) | Supports simple queries, expression queries, and PromQL queries. |

### Trigger Conditions

Set the trigger conditions for alert levels: you can configure any one of critical, major, minor, or normal.

Configure trigger conditions and severity levels. When the query results contain multiple values, an event is generated if any value meets the trigger condition.

> For more details, refer to [Event Level Description](event-level-description.md).

If **Continuous Trigger Judgment** is enabled, you can configure the number of consecutive times the trigger condition must be met before triggering an event again. The maximum limit is 10 times.

???+ abstract "Alert Levels"

    1. **Critical (Red), Major (Orange), Minor (Yellow)**: Based on the configured operator conditions.

    > For more operator details, refer to [Operator Description](operator-description.md);
    > 
    > For details on `likeTrue` and `likeFalse` truth tables, refer to [Truth Table Description](table-description.md).


    2. **Normal (Green)**: Based on the configured detection count, as follows:

    - Each execution of a detection task counts as one detection, e.g., [Detection Frequency = 5 minutes] means 1 detection = 5 minutes.
    - You can customize the detection count, e.g., [Detection Frequency = 5 minutes], then 3 detections = 15 minutes.

    | Level | Description |
    | --- | --- |
    | Normal | After the detection rule takes effect, if critical, major, or minor anomaly events occur, and within the configured custom detection count, the data returns to normal, a recovery alert event is generated.<br/> :warning: Recovery alert events are not subject to [alert muting](../alert-setting.md). If no recovery alert event detection count is set, the alert event will not recover and will remain in the [**Events > Unrecovered Events List**](../../events/event-explorer/unrecovered-events.md). |

### Data Gaps

For data gaps, seven strategies can be configured.

1. Link the detection interval time range and evaluate the query results of the most recent minutes of the detection metric, **do not trigger an event**;

2. Link the detection interval time range and evaluate the query results of the most recent minutes of the detection metric, **treat the query result as 0**; the query result will be compared against the threshold configured in the **trigger condition**, determining whether to trigger an anomaly event.

3. Custom fill the detection interval value, **trigger data gap events, critical events, major events, minor events, and recovery events**; when choosing this configuration strategy, it is recommended that the custom data gap time >= detection interval time. If the configured time <= detection interval time, there might be simultaneous satisfaction of data gap and anomaly conditions, in which case only the data gap handling result will be applied.


### Information Generation

Enabling this option generates "information" events for detection results that do not match any of the above trigger conditions.

**Note**: If trigger conditions, data gaps, and information generation are configured simultaneously, the following priority order applies: data gaps > trigger conditions > information event generation.