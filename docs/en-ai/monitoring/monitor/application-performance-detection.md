# Application Performance Metrics Monitoring
---

This section is used to monitor key metrics data for application performance monitoring (APM) within the workspace. By setting specific threshold ranges, once the monitored metrics exceed these preset thresholds, Guance will automatically trigger a warning mechanism. This threshold-based alert setting helps users promptly identify and respond to potential performance issues, ensuring the stable operation of applications.

## Use Cases

- Monitor the metrics data for all or individual services under **application performance monitoring**;   
- Count the number of traces that meet certain conditions within a specified time period, triggering an incident event when it exceeds the custom threshold.

## Detection Configuration

![](../img/5.monitor_7.1.png)

### Detection Frequency

The execution frequency of the detection rule; default is 5 minutes.

### Detection Interval

The time range for querying metrics each time the task is executed. Depending on the detection frequency, different intervals are available.

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

### Detection Metrics

Set the metrics for detecting data. You can configure metrics data for all or individual services within the workspace over a specific time range.

<div class="grid" markdown>

=== "Service Metrics"

    | Field | Description |
    | --- | --- |
    | Service | Monitor the metrics data for all or individual services under application performance monitoring in the current workspace, supporting full selection or single selection. |
    | Metrics | Specific detection metrics, supporting configuration of individual metrics including request count, error request count, request error rate, average requests per second, average response time, P50 response time, P75 response time, P90 response time, P99 response time, etc. |
    | Filter Conditions | Filter the metric data based on tags, limiting the scope of detected data. Supports adding one or more tag filters, including fuzzy matching and non-matching filter conditions. |
    | Detection Dimensions | Any string type (`keyword`) fields in the data configuration can be selected as detection dimensions. Currently, up to three fields can be chosen. Combining multiple detection dimension fields can determine a specific detection object. Guance will evaluate whether the statistical metrics of a particular detection object meet the threshold conditions set for triggering events.<br/>*For example, selecting `host` and `host_ip` would result in a detection object like {host: host1, host_ip: 127.0.0.1}.* |

=== "Trace Statistics"

    Count the number of traces that meet certain conditions within a specified time period, triggering an incident event when it exceeds the custom threshold. Useful for notifying about abnormal service trace errors.

    | Field | Description |
    | --- | --- |
    | Source | The source of the current detection metrics data, supporting selection of all (`*`) or a specific source. |
    | Filter Conditions | Filter trace `span` using tags, limiting the scope of detected data. Supports adding one or more tag filters. |
    | Aggregation Algorithm | Default is “*”, corresponding function is `count`. If other fields are selected, the function automatically changes to `count distinct` (counts unique occurrences of keyword). |
    | Detection Dimensions | Any string type (`keyword`) fields in the data configuration can be selected as detection dimensions. Currently, up to three fields can be chosen. Combining multiple detection dimension fields can determine a specific detection object. Guance will evaluate whether the statistical metrics of a particular detection object meet the threshold conditions set for triggering events.<br/>*For example, selecting `host` and `host_ip` would result in a detection object like {host: host1, host_ip: 127.0.0.1}.* |

</div>

### Trigger Conditions

Set the trigger conditions for different alert levels: you can configure any one of critical, major, minor, and normal conditions.

Configure the trigger conditions and severity levels; if any value meets the trigger condition, an event is generated.

> For more details, refer to [Event Level Explanation](event-level-description.md).

If **Continuous Trigger Judgment** is enabled, it indicates that after multiple consecutive evaluations meet the trigger conditions, another event will be triggered. The maximum limit is 10 times.

???+ abstract "Alert Levels"

	1. **Critical (Red), Major (Orange), Minor (Yellow)**: Based on configured conditions and operators.
  

	2. **Normal (Green)**: Based on the configured detection count, as follows:

	- Each execution of a detection task counts as one detection. For example, with a **detection frequency of 5 minutes**, one detection = 5 minutes;    
	- Custom detection counts can be defined. For example, with a **detection frequency of 5 minutes**, three detections = 15 minutes.   

	| Level | Description |
	| --- | --- |
	| Normal | After the detection rule takes effect, if an incident event such as critical, major, or minor occurs, and the data returns to normal within the custom detection count, a recovery alert event is generated.<br/> :warning: Recovery alerts are not subject to [alert muting](../alert-setting.md). If no recovery alert detection count is set, the alert event will not recover and will remain in the [**Events > Unrecovered Events List**](../../events/event-explorer/unrecovered-events.md).|

### Data Gaps

You can configure seven strategies for handling data gaps.

1. Linked to the detection interval time range, judge the query results of the most recent minutes for the detection metrics, **no event is triggered**;

2. Linked to the detection interval time range, judge the query results of the most recent minutes for the detection metrics, **the query result is treated as 0**; at this point, the query result is compared with the threshold set in the **trigger conditions** above to determine if an incident event should be triggered.

3. Custom fill the detection interval value, **trigger data gap events, critical events, major events, minor events, and recovery events**; if this configuration strategy is chosen, the custom data gap time should be **>= detection interval time**. If the configured time <= detection interval time, there might be simultaneous satisfaction of data gaps and anomalies, in which case only the data gap handling result will apply.


### Information Generation

Enabling this option generates an "information" event for detection results that do not match any of the above trigger conditions.

**Note**: When configuring trigger conditions, data gaps, and information generation simultaneously, the following priority order applies: data gaps > trigger conditions > information event generation.