# Process Anomaly Detection
---

Used to monitor process data within the workspace, supporting the configuration of alert trigger conditions for one or more field types in the process data.

## Use Cases

For example, you can set an alert condition for events where the value of the `host` field is `izaqbin` and the value of the `state` field is `sleep`.

## Detection Configuration

![](../img/monitor24.png)

### Detection Frequency

The execution frequency of the detection rule; default is 5 minutes.

### Detection Interval

The time range for querying the detection metrics. Depending on the detection frequency, different intervals will be available.

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

Set the metrics data for detection. Supports setting the occurrence count of one or more keyword fields in the process data within a certain time range.

| Field | Description |
| --- | --- |
| Process | Enter the process name manually. Wildcards are supported for fuzzy matching, and multiple values can be separated by commas. |
| Filter Conditions | Supports filtering fields in process data to limit the scope of detected data. Multiple label filters can be added. |
| Detection Dimensions | Any string type (`keyword`) fields in the configured data can be selected as detection dimensions. Currently, up to three fields can be chosen. By combining multiple detection dimension fields, a specific detection object can be determined. <<< custom_key.brand_name >>> will evaluate whether the statistical metric for a given detection object meets the threshold conditions, generating an event if it does.<br />* (For example, selecting detection dimensions `host` and `host_ip` results in a detection object like `{host: host1, host_ip: 127.0.0.1}`.)*

### Trigger Conditions

Set the trigger conditions for alert levels: You can configure any one of critical, major, minor, or normal.

Configure trigger conditions and severity levels. If any of the multiple values meet the trigger condition, an event is generated.

> For more details, refer to [Event Level Description](event-level-description.md).

???+ abstract "Alert Levels"

	1. **Alert Levels Critical (Red), Major (Orange), Minor (Yellow)**: Based on configured condition operators.
  

    2. **Alert Level Normal (Green)**: Based on configured detection counts, as follows:

    - Each execution of a detection task counts as one detection. For example, with a detection frequency of 5 minutes, one detection = 5 minutes.  
    - Custom detection counts can be defined. For example, with a detection frequency of 5 minutes, three detections = 15 minutes.  

    After the detection rule takes effect, if abnormal events such as critical, major, or minor occur, and the data returns to normal within the configured custom detection count, a recovery alert event is generated.

### Data Gap Handling

Seven strategies can be configured for handling data gaps.

1. In conjunction with the detection interval time range, determine the query result for the most recent minutes of the detection metric, **do not trigger an event**;

2. In conjunction with the detection interval time range, determine the query result for the most recent minutes of the detection metric, **consider the query result as 0**; at this point, the query result will be compared against the thresholds configured in the **trigger conditions** to determine whether an anomaly event should be triggered.

3. Customize the fill-in value for the detection interval, **trigger data gap events, critical events, major events, minor events, and recovery events**; when selecting this type of configuration strategy, it is recommended that the custom data gap time be **>= detection interval time span**. If the configured time <= detection interval time span, both data gap and anomaly conditions may be met simultaneously, in which case only the data gap handling result will be applied.


### Information Generation

Enabling this option will generate "information" events for detection results that do not match the above trigger conditions.

**Note**: When configuring trigger conditions, data gap handling, and information generation simultaneously, the following priority applies: data gap > trigger conditions > information event generation.