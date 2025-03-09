# Security Check Anomaly Detection
---

Used to monitor potential vulnerabilities, anomalies, and risks in systems, containers, networks, and other components within the workspace. You can configure alerts by setting the trigger frequency of detection metrics to promptly identify and manage security threats.


## Use Cases

Supports monitoring vulnerabilities, anomalies, and risks in Network, Storage, Database, System, Webserver, and Container.

## Detection Configuration

![](../img/monitor27.png)

### Detection Frequency

The execution frequency of the detection rules; the default is 5 minutes.

### Detection Interval

The time range for querying detection metrics. Depending on the detection frequency, different intervals are available.

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

Monitors the number of inspection events within a specified time range that include the configured fields in the **Security Check**. Supports adding label filters for screening.

| Field | Description |
| --- | --- |
| Category | Event classification, supports: `network`, `storage`, `database`, `system`, `webserver`, `container` |
| Host | Hostname |
| Level | Inspection event level, supports: `info`, `warn`, `critical` |
| Tags | Filters detection metric data using tags based on metrics, limiting the scope of detected data. Supports adding one or more tag filters with fuzzy match and fuzzy mismatch conditions. |
| Detection Dimensions | Any string type (`keyword`) field in the configuration can be selected as a detection dimension. Currently, up to three fields can be chosen. By combining multiple detection dimensions, a specific detection object can be determined. <<< custom_key.brand_name >>> will evaluate whether the statistical metrics of a detection object meet the threshold conditions. If met, an event is generated.<br />* (For example, selecting detection dimensions `host` and `host_ip` results in a detection object like `{host: host1, host_ip: 127.0.0.1}`).*

### Trigger Conditions

Set trigger conditions for alert levels: you can configure any one of critical, major, minor, or normal trigger conditions.

Configure trigger conditions and severity levels. When query results contain multiple values, an event is generated if any value meets the trigger condition.

> For more details, refer to [Event Level Description](event-level-description.md).

If **Continuous Trigger Judgment** is enabled, you can configure the conditions to trigger events after multiple consecutive judgments. The maximum limit is 10 times.


???+ abstract "Alert Levels"

	1. **Critical (Red), Major (Orange), Minor (Yellow) Alert Levels**: Based on configured condition operators.
  

    2. **Normal (Green) Alert Level**: Based on configured detection frequency, as follows:

    - Each execution of a detection task counts as 1 detection. For example, if the detection frequency is set to 5 minutes, then 1 detection = 5 minutes.  
    - You can customize the number of detections. For example, if the detection frequency is 5 minutes, then 3 detections = 15 minutes.  

    After the detection rule takes effect, if abnormal events such as critical, major, or minor occur, and the data returns to normal within the configured custom detection period, a recovery alert event is generated.

### Data Gaps

You can configure seven strategies for handling data gaps.

1. Link to the detection interval time range and determine the query result for the most recent minutes of the detection metric, **no event triggered**;

2. Link to the detection interval time range and determine the query result for the most recent minutes of the detection metric, **query result treated as 0**; this result will be compared against the threshold configured in the **Trigger Conditions** to determine if an anomaly event should be triggered.

3. Customize the fill-in value for the detection interval, **trigger data gap events, critical events, major events, minor events, and recovery events**; when choosing this configuration strategy, it is recommended that the custom data gap time >= detection interval time. If the configured time <= detection interval time, there may be simultaneous satisfaction of data gap and anomaly conditions, in which case only the data gap processing result will be applied.


### Information Generation

Enabling this option generates "information" events for detection results that do not match the above trigger conditions and writes them into the system.


**Note**: If trigger conditions, data gaps, and information generation are all configured, the following priority order applies: data gaps > trigger conditions > information event generation.