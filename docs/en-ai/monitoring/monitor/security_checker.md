# Security Check Anomaly Detection
---

This feature monitors potential vulnerabilities, anomalies, and risks in systems, containers, networks, and other components within the workspace. You can configure alerts by setting the trigger count for detection metrics to promptly identify and manage security threats.


## Application Scenarios

Supports monitoring vulnerabilities, anomalies, and risks in Network, Storage, Database, System, Webserver, and Container.

## Detection Configuration

![](../img/monitor27.png)

### Detection Frequency

This refers to the execution frequency of detection rules; the default is 5 minutes.

### Detection Interval

This refers to the time range for querying detection metrics. The available detection intervals vary based on the detection frequency.

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

Monitors the number of inspection events within a specified time frame that contain predefined fields in the **Security Check**. Supports adding label filters for screening.

| Field | Description |
| --- | --- |
| Category | Event classification, supports: `network`, `storage`, `database`, `system`, `webserver`, `container` |
| Host | Host name |
| Level | Inspection event level, supports: `info`, `warn`, `critical` |
| Tags | Filters detection metric data using tags based on metrics. Allows adding one or more tag filters with options for fuzzy matching and non-matching conditions. |
| Detection Dimensions | Any string type (`keyword`) fields in the configuration can be selected as detection dimensions. Up to three fields are supported. Combining multiple detection dimension fields can specify a unique detection object. Guance will determine if the statistical metrics for a detection object meet the threshold conditions set for triggering events.<br />* (For example, selecting detection dimensions `host` and `host_ip` results in a detection object `{host: host1, host_ip: 127.0.0.1}`.)*

### Trigger Conditions

Set trigger conditions for alert levels: you can configure any one of critical, major, minor, or normal trigger conditions.

Configure trigger conditions and severity levels. When query results return multiple values, an event is generated if any value meets the trigger condition.

> For more details, refer to [Event Level Description](event-level-description.md).

If **Continuous Trigger Judgment** is enabled, you can configure how many consecutive times the trigger conditions must be met before generating an event. The maximum limit is 10 times.

???+ abstract "Alert Levels"

	1. **Critical (Red), Major (Orange), Minor (Yellow)**: Based on configured condition operators.
  

    2. **Normal (Green)**: Based on configured detection counts, as follows:

    - Each execution of a detection task counts as 1 detection. For example, if the **Detection Frequency = 5 minutes**, then 1 detection = 5 minutes;
    - Custom detection counts can be defined. For example, if the **Detection Frequency = 5 minutes**, then 3 detections = 15 minutes.

    After the detection rule takes effect, if urgent, major, or minor anomaly events occur, and the data returns to normal within the custom detection period, a recovery alert event is generated.

### Data Discontinuity

You can configure seven strategies for handling data discontinuities.

1. Linked to the detection interval time range, judge the query results of the most recent minutes of the detection metrics, **do not trigger events**;

2. Linked to the detection interval time range, judge the query results of the most recent minutes of the detection metrics, **consider the query result as 0**; this result will then be compared against the thresholds configured in the **Trigger Conditions** to determine whether to trigger an anomaly event.

3. Customize the fill-in value for the detection interval, **trigger data discontinuity events, critical events, major events, minor events, and recovery events**; when choosing this configuration strategy, it is recommended that the custom data discontinuity time be **>= detection interval time**. If the configured time <= detection interval time, there may be simultaneous satisfaction of data discontinuity and anomaly conditions, in which case only the data discontinuity processing result will apply.


### Information Generation

Enabling this option generates "Information" events for detection results that do not match any of the above trigger conditions.

**Note**: When configuring trigger conditions, data discontinuity, and information generation simultaneously, the following priority applies: data discontinuity > trigger conditions > information event generation.