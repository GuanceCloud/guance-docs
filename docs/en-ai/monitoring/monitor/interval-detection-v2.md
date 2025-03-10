# Interval Detection V2
---

The V2 version of interval detection establishes a confidence interval based on the historical data of the current detection metric to predict the normal fluctuation range. The <<< custom_key.brand_name >>> system compares the data characteristics of the current time period with historical data to detect whether the data exceeds the preset confidence interval. If a data point exceeds this range, the system will determine it as an anomaly and may trigger an alert; if the data point is within the normal range, the system will continue monitoring to ensure the stability and security of real-time data.

Key features:

- In-depth analysis: Establishes a confidence interval based on the historical data of the detection metric to predict the normal fluctuation range.
- Continuous updates: Continuously updated by the <<< custom_key.brand_name >>> algorithm team to provide more data processing capabilities.

## Concepts

Confidence interval (`confidence_interval`): A metric used to define the tolerance for the upper and lower bounds of the confidence interval within a specific detection range for time series data. The parameter value ranges from 1% to 100%. For highly volatile and random data, a larger tolerance can be chosen; conversely, for more regular data, the tolerance range can be reduced accordingly.

Setting a larger confidence interval results in wider upper and lower boundaries, reducing the number of detected anomalies. If the confidence interval is set too small, it may detect many anomalies. If set too large, it might fail to detect any anomalies. Therefore, setting the `confidence_interval` parameter appropriately based on the characteristics of the data is crucial. Correct parameter settings ensure that important anomaly signals are not missed while avoiding excessive sensitivity to normal fluctuations in the data.

Example:

![](../img/interval-v2-example.png)

## Detection Configuration

![](../img/interval-v2.png)

### Detection Frequency

The execution frequency of the detection rule, defaulting to every 10 minutes, which cannot be changed.

### Detection Metrics

The metrics data being monitored.

| Field | Description |
| --- | --- |
| Data Type | The type of data currently being detected, supporting only Metrics data. |
| Measurement | The Measurement where the current detection metric resides. |
| Metric | The specific metric being detected. |
| Aggregation Algorithm | Includes Avg by (average), Min by (minimum), Max by (maximum), Sum by (sum), Last (last value), First by (first value), Count by (number of data points), Count_distinct by (number of unique data points), p50 (median), p75 (75th percentile), p90 (90th percentile), p99 (99th percentile). |
| Detection Dimensions | String type (`keyword`) fields in the configuration data can be selected as detection dimensions, with up to three fields supported. By combining multiple detection dimension fields, a specific detection object can be determined. <<< custom_key.brand_name >>> will determine whether the statistical metric of a certain detection object meets the threshold conditions, and if so, an event will be generated.<br/>*For example, selecting detection dimensions `host` and `host_ip` would result in a detection object like `{host: host1, host_ip: 127.0.0.1}`.* |
| Filter Conditions | Filters the data of the detection metric based on the labels of the metrics, limiting the scope of the detected data; one or more label filters can be added; supports fuzzy matching and non-matching filter conditions. |
| Alias | Custom name for the detection metric. |
| [Query](../../scene/visual-chart/chart-query.md) Method | Supports simple queries and expression queries. |

### Trigger Conditions

Set the trigger conditions for alert levels: You can configure any one of critical, major, minor, or normal trigger conditions. Supports upward (data increase), downward (data decrease), or both forms of data comparison.

Configure trigger conditions and severity levels. When the query results contain multiple values, any value meeting the trigger condition will generate an event.

> For more details, refer to [Event Level Description](event-level-description.md).

???+ abstract "Alert Levels"

    1. **Alert Levels Critical (red), Major (orange), Minor (yellow)**: Based on configured condition operators.

    2. **Alert Level Normal (green)**: Based on configured detection counts, as follows:

	- Each execution of a detection task counts as 1 detection, e.g., if [Detection Frequency = 5 minutes], then 1 detection = 5 minutes.
	- Custom detection counts can be defined, e.g., if [Detection Frequency = 5 minutes], then 3 detections = 15 minutes.

	| Level | Description |
	| --- | --- |
	| Normal | After the detection rule takes effect, if an emergency, major, or minor anomaly event occurs, and the data detection results return to normal within the configured custom detection count, a recovery alert event is generated.<br/> :warning: Recovery alert events are not subject to [alert muting](../alert-setting.md). If no recovery alert event detection count is set, the alert event will not recover and will remain in the [**Events > Unrecovered Events List**](../../events/event-explorer/unrecovered-events.md).|

### Data Gap Handling

Seven strategies can be configured for handling data gaps.

1. Linked to the detection interval time range, judge the query results of the most recent minutes of the detection metric, **no event triggered**;

2. Linked to the detection interval time range, judge the query results of the most recent minutes of the detection metric, **query results considered as 0**; at this point, the query results will be compared against the thresholds configured in the **trigger conditions** to determine whether an anomaly event should be triggered.

3. Custom fill for detection interval values, **trigger data gap events, trigger critical events, trigger major events, trigger minor events, and trigger recovery events**; when choosing this configuration strategy, it is recommended that the custom data gap time configuration be **>= detection interval time**. If the configured time <= detection interval time, there may be simultaneous satisfaction of data gap and anomaly conditions, in which case only the data gap handling result will be applied.


### Information Generation

Enabling this option generates "information" events for detection results that do not match the above trigger conditions and writes them into the system.

**Note**: When configuring trigger conditions, data gap handling, and information generation simultaneously, the following priority applies: data gap handling > trigger conditions > information event generation.