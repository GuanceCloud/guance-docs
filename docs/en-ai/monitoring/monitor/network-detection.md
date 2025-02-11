# Network Data Monitoring
---

A tool used to monitor network performance metrics within a workspace, allowing users to set threshold ranges and trigger alerts when metrics exceed these thresholds. Guance supports configuring alert rules for individual metrics and allows customization of alert severity levels.

## Use Cases

Supports monitoring metric data from data sources such as `netflow`/`httpflow`. For example, monitoring request counts, error counts, and error rates for host data sources with `httpflow`.

## Detection Configuration

![](../img/5.monitor_8.png)

### Detection Frequency

The execution frequency of detection rules; the default is 5 minutes.

### Detection Interval

The time range for querying metrics each time the task is executed. This is influenced by the detection frequency, resulting in different selectable intervals.

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

Set the metrics for detecting data. Supports setting metrics for all or specific services within a certain time range in the workspace.

| Field     | Description                                                         |
| -------- | ------------------------------------------------------------ |
| Data Source   | Supported: `netflow`, `httpflow`.                                 |
| Metrics     | <li>`netflow`: Sent bytes, received bytes, TCP delay, TCP fluctuation, TCP connection count, TCP retransmission count, TCP close count;<br><li>`httpflow`: Request count, error count, error rate, average response time, P99 response time, P95 response time, P75 response time, P50 response time. |
| Filter Conditions | Screen the data of detected metrics based on labels, limiting the scope of detected data. Supports adding one or more label filters, including fuzzy matching and non-matching conditions. |
| Detection Dimensions | Any string type (`keyword`) fields in the configuration can be selected as detection dimensions. Currently, up to three fields are supported. By combining multiple detection dimension fields, a specific detection object can be determined. Guance will evaluate whether the statistical metrics of a specific detection object meet the threshold conditions for triggering events.<br />* (For example, selecting detection dimensions `host` and `host_ip` would result in a detection object like `{host: host1, host_ip: 127.0.0.1}`).*

### Trigger Conditions

Set the trigger conditions for alert levels: you can configure any one of critical, major, minor, or normal.

Configure trigger conditions and severity levels. When query results contain multiple values, an event is generated if any value meets the trigger condition.

> For more details, refer to [Event Level Description](event-level-description.md).

If **Continuous Trigger Judgment** is enabled, you can configure it to generate events again after multiple consecutive judgments meet the trigger conditions, with a maximum limit of 10 times.

???+ abstract "Alert Levels"

	1. **Critical (Red), Major (Orange), Minor (Yellow)**: Based on configured conditional operators.
  

    2. **Normal (Green)**: Based on configured detection counts, as follows:

    - Each execution of a detection task counts as one detection, e.g., [Detection Frequency = 5 minutes], then 1 detection = 5 minutes;
    - You can customize the detection count, e.g., [Detection Frequency = 5 minutes], then 3 detections = 15 minutes.

    After the detection rule takes effect, if critical, major, or minor abnormal events occur, and the data returns to normal within the custom detection count, a recovery alert event is generated.

    **Note**: Recovery alert events are not subject to [Alert Muting](../alert-setting.md). If no recovery alert detection count is set, the alert event will not recover and will remain in the [**Events > Unrecovered Events List**](../../events/event-explorer/unrecovered-events.md).

### Data Gap Handling

You can configure seven strategies for handling data gaps.

1. Link the detection interval time range to judge the query results of the most recent minutes of the detected metrics, **do not trigger events**;

2. Link the detection interval time range to judge the query results of the most recent minutes of the detected metrics, **treat query results as 0**; at this point, the query results will be compared against the thresholds configured in the **Trigger Conditions** to determine if an anomaly event should be triggered.

3. Customize fill-in values for the detection interval, **trigger data gap events, critical events, major events, minor events, and recovery events**; when choosing this strategy, it is recommended that the custom data gap time be **>= detection interval time**. If the configured time <= detection interval time, there may be simultaneous satisfaction of data gap and anomaly conditions, in which case only the data gap processing result will apply.


### Information Generation

Enabling this option will generate "Information" events for detection results that do not match the above trigger conditions and write them into the system.

**Note**: If trigger conditions, data gap handling, and information generation are configured simultaneously, the priority order for triggering is: data gap handling > trigger conditions > information event generation.