# Application Performance Metrics Monitoring
---

Used to monitor key metrics data of Application Performance Monitoring (APM) within the workspace. By setting specific threshold ranges, <<< custom_key.brand_name >>> will automatically trigger a warning mechanism once the monitored metrics exceed these preset thresholds. This threshold-based alert setting helps users promptly identify and respond to potential performance issues, ensuring stable application operation.

## Use Cases

- Monitor metrics data for all or individual services under **Application Performance Monitoring**;
- Count the number of qualified traces within a specified time period, triggering an incident when it exceeds the custom threshold.

## Detection Configuration

![](../img/5.monitor_7.1.png)

### Detection Frequency

The execution frequency of the detection rule; default is set to 5 minutes.

### Detection Interval

The time range for querying metrics each time the task is executed. Depending on the detection frequency, different detection intervals are available.

| Detection Frequency | Detection Interval (Dropdown Options) |
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

Set the metrics for detecting data. You can configure the metrics data for all or individual services in the workspace over a certain time range.

<div class="grid" markdown>

=== "Service Metrics"

    | Field | Description |
    | --- | --- |
    | Service | Monitor metrics data for all or individual services under Application Performance Monitoring within the current workspace, supporting full selection or single selection. |
    | Metrics | Specific detection metrics, supporting configuration of single metrics, including request count, error request count, request error rate, average requests per second, average response time, P50 response time, P75 response time, P90 response time, P99 response time, etc. |
    | Filtering Conditions | Filter the detection metric data based on tags associated with the metrics, limiting the scope of detected data. Supports adding one or multiple tag filters, allowing fuzzy matching and non-matching conditions. |
    | Detection Dimensions | Any string type (`keyword`) fields in the configured data can be selected as detection dimensions. Currently, up to three fields can be chosen as detection dimensions. By combining multiple detection dimension fields, a specific detection object can be determined. <<< custom_key.brand_name >>> will evaluate whether the statistical metrics of a certain detection object meet the threshold conditions for triggering events.<br/>*For example, selecting detection dimensions `host` and `host_ip` would result in a detection object {host: host1, host_ip: 127.0.0.1}.* |

=== "Trace Statistics"

    Count the number of qualified traces within a specified time period, triggering an incident when it exceeds the custom threshold. Useful for notifying about service trace anomalies.

    | Field | Description |
    | --- | --- |
    | Source | The source of the current detection metric data, supporting selection of all (`*`) or a specified single source. |
    | Filtering Conditions | Filter the trace `span` using tags, limiting the scope of detected data. Supports adding one or multiple tag filters. |
    | Aggregation Algorithm | Default is “*”, corresponding function is `count`. If other fields are selected, the function automatically changes to `count distinct` (counts unique occurrences). |
    | Detection Dimensions | Any string type (`keyword`) fields in the configured data can be selected as detection dimensions. Currently, up to three fields can be chosen as detection dimensions. By combining multiple detection dimension fields, a specific detection object can be determined. <<< custom_key.brand_name >>> will evaluate whether the statistical metrics of a certain detection object meet the threshold conditions for triggering events.<br/>*For example, selecting detection dimensions `host` and `host_ip` would result in a detection object {host: host1, host_ip: 127.0.0.1}.* |

</div>

### Trigger Conditions

Configure the trigger conditions for alert levels: you can set any one of critical, major, minor, or normal conditions.

Configure trigger conditions and severity levels. When multiple values are returned by the query, an event is generated if any value meets the trigger condition.

> For more details, refer to [Event Level Description](event-level-description.md).

If **Continuous Trigger Evaluation** is enabled, it means that after multiple consecutive evaluations meet the trigger conditions, an event will be triggered again. The maximum limit is 10 times.

???+ abstract "Alert Levels"

	1. **Critical (Red), Major (Orange), Minor (Yellow)**: Based on configured condition operators.
  

	2. **Normal (Green)**: Based on configured detection counts, as follows:

	- Each execution of a detection task counts as one detection, e.g., if **Detection Frequency = 5 minutes**, then 1 detection = 5 minutes;
	- Custom detection counts can be defined, e.g., if **Detection Frequency = 5 minutes**, then 3 detections = 15 minutes.

	| Level | Description |
	| --- | --- |
	| Normal | After the detection rule takes effect, if critical, major, or minor incidents occur and data returns to normal within the custom detection count, a recovery alert event is generated.<br/> :warning: Recovery alerts are not subject to [alert muting](../alert-setting.md). If no recovery alert detection count is set, the alert will not recover and will remain in the [**Events > Unrecovered Events List**](../../events/event-explorer/unrecovered-events.md).|

### Data Gap Handling

Seven strategies can be configured for handling data gaps.

1. In conjunction with the detection interval, judge the query results of the most recent minutes for the detection metrics, **do not trigger events**;

2. In conjunction with the detection interval, judge the query results of the most recent minutes for the detection metrics, **treat query results as 0**; at this point, the query results will be compared with the thresholds configured in the **Trigger Conditions** to determine whether to trigger an incident.

3. Customize filling in the detection interval value, **trigger data gap events, critical events, major events, minor events, and recovery events**; it is recommended that the custom data gap time configuration be **>= detection interval time**. If the configured time <= detection interval time, both data gap and anomaly conditions may be met simultaneously, in which case only the data gap processing result will be applied.


### Information Event Generation

Enabling this option writes unmatched detection results as "Information" events.

**Note**: When configuring trigger conditions, data gap handling, and information event generation simultaneously, the following priority applies: data gap handling > trigger conditions > information event generation.