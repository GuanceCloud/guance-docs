# Network Data Detection
---

A tool used to monitor network performance metrics within a workspace, allowing users to set threshold ranges and trigger alerts when metrics exceed these thresholds. <<< custom_key.brand_name >>> supports configuring alert rules for individual metrics and allows customization of alert severity levels.


## Use Cases

Supports monitoring metric data from data sources such as `netflow`/`httpflow`. For example, monitoring request counts, error counts, and error rates for host data sources with `httpflow`.

## Detection Configuration

![](../img/5.monitor_8.png)

### Detection Frequency

The frequency at which detection rules are executed; the default is 5 minutes.

### Detection Interval

The time range over which metrics are queried each time the task is executed. This is influenced by the detection frequency, resulting in different available intervals.

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

Set the metrics for detecting data. Supports setting metrics for all or individual services within a specific time range in the workspace.

| Field     | Description                                                         |
| -------- | ------------------------------------------------------------ |
| Data Source   | Supported: `netflow`, `httpflow`.                                 |
| Metrics     | <li>`netflow`: Sent bytes, received bytes, TCP delay, TCP jitter, TCP connections, TCP retransmissions, TCP closes;<br><li>`httpflow`: Request count, error count, error rate, average response time, P99 response time, P95 response time, P75 response time, P50 response time. |
| Filter Conditions | Filter the detected metric data based on labels associated with the metrics, limiting the scope of the detected data. Supports adding one or multiple label filters, including fuzzy matching and non-matching conditions. |
| Detection Dimensions     | Any string type (`keyword`) fields in the data can be selected as detection dimensions. Currently, up to three fields can be chosen. By combining multiple detection dimension fields, a specific detection object can be determined. <<< custom_key.brand_name >>> will evaluate whether the statistical metrics of a detection object meet the configured threshold conditions and generate an event if they do.<br />* (For example, selecting detection dimensions `host` and `host_ip` would result in a detection object like `{host: host1, host_ip: 127.0.0.1}`.) * |

### Trigger Conditions

Set the trigger conditions for alert levels: you can configure any one of critical, major, minor, or normal.

Configure trigger conditions and severity levels; when query results contain multiple values, an event is generated if any value meets the trigger condition.

> For more details, refer to [Event Level Description](event-level-description.md).

If **Continuous Trigger Judgment** is enabled, you can configure the rule to trigger events again after multiple consecutive evaluations meet the trigger conditions, with a maximum limit of 10 times.

???+ abstract "Alert Levels"

	1. **Alert Levels Critical (Red), Major (Orange), Minor (Yellow)**: Based on the configured condition operators.
  

    2. **Alert Level Normal (Green)**: Based on the configured detection count, as follows:

    - Each execution of a detection task counts as 1 detection, e.g., if the **Detection Frequency = 5 minutes**, then 1 detection = 5 minutes;
    - You can customize the detection count, e.g., if **Detection Frequency = 5 minutes**, then 3 detections = 15 minutes.

    After the detection rule takes effect, if an abnormal event occurs (critical, major, or minor), and the data returns to normal within the configured detection count, a recovery alert event is generated.

    **Note**: Recovery alert events are not subject to [Alert Mute](../alert-setting.md) restrictions. If no recovery alert detection count is set, the alert event will not recover and will remain in the [**Events > Unrecovered Events List**](../../events/event-explorer/unrecovered-events.md).

### Data Discontinuity

You can configure seven strategies for handling data discontinuity.

1. In conjunction with the detection interval time range, determine the query results for the most recent minutes of the detection metrics, **do not trigger an event**;

2. In conjunction with the detection interval time range, determine the query results for the most recent minutes of the detection metrics, **treat query results as 0**; these results will then be compared against the configured thresholds in the **Trigger Conditions** to determine if an abnormal event should be triggered.

3. Customize the fill-in value for the detection interval, **trigger data discontinuity events, critical events, major events, minor events, and recovery events**; if this configuration strategy is chosen, it is recommended that the custom data discontinuity time >= detection interval time. If the configured time <= detection interval time, there may be simultaneous satisfaction of data discontinuity and abnormal conditions, in which case only the data discontinuity handling result will be applied.


### Information Generation

Enabling this option will generate "Information" events for detection results that do not match any of the above trigger conditions.

**Note**: If trigger conditions, data discontinuity, and information generation are configured simultaneously, the following priority applies: data discontinuity > trigger conditions > information event generation.