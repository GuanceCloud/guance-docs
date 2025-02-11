# Process Anomaly Detection
---

Used for monitoring process data within the workspace, supporting the configuration of alert trigger conditions for one or more field types in the process data.

## Application Scenarios

For example, you can set an alert condition for events where the `host` field value is `izaqbin` and the `state` field value is `sleep`.

## Detection Configuration

![](../img/monitor24.png)

### Detection Frequency

This is the execution frequency of the detection rule; the default is 5 minutes.

### Detection Interval

This is the time range for querying the detection metrics. The available detection intervals vary depending on the detection frequency.

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

Set the metrics for detection. Supports setting the occurrence count of one or more keyword fields in the process data within a specified time range in the current workspace.

| Field | Description |
| --- | --- |
| Process | Manually enter the process name, supporting wildcard matching for fuzzy search. Multiple values should be separated by commas. |
| Filter Conditions | Supports filtering fields in process data to limit the scope of detected data. You can add one or more label filters. |
| Detection Dimensions | Any string type (`keyword`) fields in the data can be selected as detection dimensions. Currently, up to three fields are supported. By combining multiple detection dimension fields, you can define a specific detection object. Guance will determine if the statistical metrics for this object meet the threshold conditions, triggering an event if they do.<br />* (For example, selecting detection dimensions `host` and `host_ip` results in a detection object like `{host: host1, host_ip: 127.0.0.1}`).*

### Trigger Conditions

Set the trigger conditions for different alert levels: you can configure any one of the critical, major, minor, or normal trigger conditions.

Configure trigger conditions and severity levels. When the query results contain multiple values, an event is generated if any value meets the trigger condition.

> For more details, refer to [Event Level Description](event-level-description.md).

If **Continuous Trigger Judgment** is enabled, you can configure how many consecutive times the trigger condition must be met before generating another event. The maximum limit is 10 times.

???+ abstract "Alert Levels"

	1. **Critical (Red), Major (Orange), Minor (Yellow)**: Based on configured condition operators.
  

    2. **Normal (Green)**: Based on configured detection counts, as follows:

    - Each execution of a detection task counts as 1 detection, e.g., if the detection frequency is 5 minutes, then 1 detection = 5 minutes;
    - You can customize the detection count, e.g., if the detection frequency is 5 minutes, then 3 detections = 15 minutes.

    After the detection rule takes effect, if critical, major, or minor anomaly events occur, and the data returns to normal within the configured custom detection count, a recovery alert event is generated.

### Data Discontinuity

You can configure seven strategies for handling data discontinuity.

1. Linked to the detection interval time range, judge the query result of the most recent minutes for the detection metrics, **do not trigger an event**;

2. Linked to the detection interval time range, judge the query result of the most recent minutes for the detection metrics, **consider the query result as 0**; the query result will be compared with the threshold configured in the **trigger conditions** to determine if an anomaly event should be triggered.

3. Customize the fill-in value for the detection interval, **trigger data discontinuity events, critical events, major events, minor events, and recovery events**; it is recommended that the custom data discontinuity time configuration be **>= detection interval time span**. If the configured time <= the detection interval time span, both data discontinuity and anomalies may occur simultaneously, in which case only the data discontinuity processing result will apply.


### Information Generation

Enabling this option will generate "Information" events for detection results that do not match any of the above trigger conditions.

**Note**: When configuring trigger conditions, data discontinuity, and information generation simultaneously, the following priority applies: data discontinuity > trigger conditions > information event generation.