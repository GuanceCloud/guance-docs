# Threshold Detection
---

Used for monitoring anomalies in data such as metrics, logs, traces, etc. You can set threshold ranges, and when the data exceeds these thresholds, the system will trigger alerts and notify externally. Additionally, it supports detecting multiple metrics simultaneously and configuring different alert levels for each detection.

## Application Scenarios

Supports monitoring anomalies in data related to metrics, logs, infrastructure, resource catalogs, events, APM, RUM, security checks, and network aspects. For example, you can monitor whether the host memory usage rate is abnormally high.

## Detection Configuration {#steps}

![](../img/monitor14.png)

### Detection Frequency

The execution frequency of the detection rules; the default is 5 minutes.

In addition to the specific options provided by Guance, you can also enter a [**custom crontab task**](./detection-frequency.md), configuring scheduled tasks based on minutes, hours, days, months, weeks, etc.

When using custom Crontab detection frequencies, the detection intervals include the last 1 minute, last 5 minutes, last 15 minutes, last 30 minutes, last 1 hour, and last 3 hours.

<img src="../../img/crontab.png" width="60%" >

### Detection Interval

The time range for querying detection metrics. Depending on the detection frequency, selectable detection intervals may vary.

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

3) **Detection Metrics**: Setting the data to be detected.

| Field | Description |
| --- | --- |
| Data Type | The type of data currently being detected, supporting metrics, logs, infrastructure, resource catalogs, events, APM, RUM, security checks, and network data types. |
| Mearsurement | The measurement set where the current detection metric resides (for "metrics" data type). |
| Metric | The specific metric being detected (for "metrics" data type). |
| Aggregation Algorithm | Includes Avg by (average), Min by (minimum), Max by (maximum), Sum by (sum), Last (last value), First by (first value), Count by (count of data points), Count_distinct by (count of distinct data points), p50 (median), p75 (75th percentile), p90 (90th percentile), p99 (99th percentile). |
| Detection Dimensions | String type (`keyword`) fields in the configured data can be selected as detection dimensions. Currently, up to three fields can be chosen. By combining multiple detection dimension fields, a specific detection object can be determined. Guance will judge whether the statistical metrics of a specific detection object meet the threshold conditions, and if so, an event is generated.<br />* (For example, selecting detection dimensions `host` and `host_ip` results in a detection object like {host: host1, host_ip: 127.0.0.1}. For log detection objects, the default dimensions are `status`, `host`, `service`, `source`, `filename`). * |
| Filter Conditions | Filters the data of the detection metric based on metric labels, limiting the scope of detection data. Multiple label filters can be added, and non-metric data supports fuzzy matching and fuzzy mismatching filter conditions. |
| Alias | Custom name for the detection metric. |
| [Query Method](../../scene/visual-chart/chart-query.md) | Supports simple queries, expression queries, and PromQL queries. |

### Trigger Conditions

Set the trigger conditions for alert levels: you can configure any one of critical, major, minor, or normal trigger conditions.

Configure trigger conditions and severity levels. When query results contain multiple values, an event is generated if any value meets the trigger condition.

> For more details, refer to [Event Level Description](event-level-description.md).

If **Continuous Trigger Judgment** is enabled, you can configure the number of consecutive times the trigger conditions must be met before an event is triggered again. The maximum limit is 10 times.


???+ abstract "Alert Levels"

	1. **Alert Levels Critical (Red), Major (Orange), Minor (Yellow)**: Based on configured conditions and operators.

    > For more operator details, refer to [Operator Description](operator-description.md);   
    >     
    > For details on `likeTrue` and `likeFalse` truth tables, refer to [Truth Table Description](table-description.md).


    2. **Alert Level Normal (Green)**: Based on configured detection counts, as follows:

    - Each execution of a detection task counts as 1 detection, e.g., with a detection frequency of 5 minutes, 1 detection = 5 minutes.
    - You can customize the detection count, e.g., with a detection frequency of 5 minutes, 3 detections = 15 minutes.

    | Level | Description |
    | --- | --- |
    | Normal | After the detection rule takes effect, if critical, major, or minor anomaly events occur, and the data returns to normal within the configured custom detection count, a recovery alert event is generated.<br/> :warning: Recovery alert events are not subject to [alert muting](../alert-setting.md). If no recovery alert event detection count is set, the alert event will not recover and will remain in the [**Events > Unrecovered Events List**](../../events/event-explorer/unrecovered-events.md).|

### Data Gaps

Seven strategies can be configured for handling data gaps.

1. Linked to the detection interval time range, judging the query results of the most recent minutes of the detection metric, **no event is triggered**;

2. Linked to the detection interval time range, judging the query results of the most recent minutes of the detection metric, **query results are considered as 0**; at this point, the query results are compared with the thresholds configured in the **trigger conditions** to determine if an anomaly event should be triggered.

3. Custom fill-in for detection interval values, **trigger data gap events, critical events, major events, minor events, and recovery events**; when choosing this configuration strategy, it is recommended that the custom data gap time >= detection interval time. If the configured time <= detection interval time, both data gap and anomaly conditions may be met simultaneously, in which case only the data gap handling result will apply.


### Information Generation

Enabling this option generates "information" events for detection results that do not match any of the above trigger conditions and writes them into the system.

**Note**: When configuring trigger conditions, data gaps, and information generation simultaneously, the following priority order applies: data gaps > trigger conditions > information event generation.