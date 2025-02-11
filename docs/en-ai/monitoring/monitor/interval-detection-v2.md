# Interval Detection V2
---

The V2 version of interval detection establishes a confidence interval based on the historical data of the current monitoring metrics to predict the normal fluctuation range. The Guance system compares the data characteristics of the current time period with historical data to detect whether the data exceeds the predefined confidence interval. If the data point exceeds this range, the system will classify it as an anomaly and may trigger an alert; if the data point is within the normal range, the system will continue to monitor to ensure the stability and security of real-time data.

Key Features:

- In-depth Analysis: Establishes a confidence interval based on the historical data of the monitoring metrics to predict the normal fluctuation range.
- Continuous Updates: Continuously updated by the Guance algorithm team to provide more data processing capabilities.

## Concept Explanation

Confidence Interval Range (`confidence_interval`): A metric that defines the tolerance for the upper and lower bounds of the confidence interval for time series data within a specific detection range. The value range for this parameter is 1% to 100%. For data with high volatility and randomness, a larger tolerance can be chosen; conversely, for data with more regular fluctuations, the tolerance can be reduced accordingly.

Setting a larger confidence interval results in wider upper and lower bounds, thereby reducing the number of detected anomalies. If the confidence interval is set too small, it may detect a large number of anomalies. Conversely, if the confidence interval is set too large, it may fail to detect any anomalies. Therefore, it is crucial to reasonably set the `confidence_interval` parameter based on the characteristics of the data. Proper parameter settings ensure that important anomaly signals are not missed while avoiding over-sensitivity to normal data fluctuations.

Example:

![](../img/interval-v2-example.png)

## Detection Configuration

![](../img/interval-v2.png)

### Detection Frequency

This refers to the execution frequency of the detection rule, defaulting to every 10 minutes, which cannot be changed.

### Monitoring Metrics

This refers to the monitored metric data.

| Field | Description |
| --- | --- |
| Data Type | The type of data currently being detected, supports only Metrics data. |
| Mearsurement | The Metrics set where the current detection metric resides. |
| Metric | The specific metric targeted by the current detection. |
| Aggregation Algorithm | Includes Avg by (average), Min by (minimum), Max by (maximum), Sum by (sum), Last (last value), First by (first value), Count by (number of data points), Count_distinct by (number of distinct data points), p50 (median), p75 (75th percentile), p90 (90th percentile), p99 (99th percentile). |
| Detection Dimensions | Any string type (`keyword`) fields in the configuration can be selected as detection dimensions, with up to three fields supported. By combining multiple detection dimension fields, a specific detection object can be determined. Guance will evaluate whether the statistical metrics corresponding to a detection object meet the threshold conditions for triggering events.<br/>*For example, selecting detection dimensions `host` and `host_ip` would result in a detection object like `{host: host1, host_ip: 127.0.0.1}`.* |
| Filtering Conditions | Filters the data of the detection metrics based on labels to limit the scope of detection; one or more label filters can be added; supports fuzzy matching and non-matching filter conditions. |
| Alias | Custom name for the detection metric. |
| [Query](../../scene/visual-chart/chart-query.md) Method | Supports simple queries and expression queries. |

### Trigger Conditions

Set the trigger conditions for alert levels: You can configure any one of the critical, major, minor, or normal trigger conditions. It supports upward (data increase), downward (data decrease), or both upward and downward data comparisons.

Configure trigger conditions and severity levels; when the query results contain multiple values, an event is generated if any value meets the trigger condition.

> For more details, refer to [Event Level Description](event-level-description.md).

???+ abstract "Alert Levels"

    1. **Alert Levels Critical (Red), Major (Orange), Minor (Yellow)**: Based on configured condition operators.
  

    2. **Alert Level Normal (Green)**: Based on configured detection count, as follows:

	- Each execution of a detection task counts as one detection, e.g., [Detection Frequency = 5 minutes], then 1 detection = 5 minutes.    
	- You can customize the detection count, e.g., [Detection Frequency = 5 minutes], then 3 detections = 15 minutes.   

	| Level | Description |
	| --- | --- |
	| Normal | After the detection rule takes effect, if critical, major, or minor anomaly events occur, and the data detection results return to normal within the configured custom detection count, a recovery alert event is generated.<br/> :warning: Recovery alert events are not subject to [alert muting](../alert-setting.md) restrictions. If no recovery alert event detection count is set, the alert event will not recover and will remain in the [**Events > Unrecovered Events List**](../../events/event-explorer/unrecovered-events.md).|
	

### Data Gaps

You can configure seven strategies for handling data gaps.

1. Linked to the detection interval time range, judge the query results of the most recent minutes of the detection metric, **do not trigger events**;

2. Linked to the detection interval time range, judge the query results of the most recent minutes of the detection metric, **consider the query result as 0**; at this point, the query result will be compared with the thresholds configured in the **trigger conditions** to determine whether an anomaly event should be triggered.

3. Customize the fill-in value for the detection interval, **trigger data gap events, critical events, major events, minor events, and recovery events**; choose this configuration strategy, it is recommended that the custom data gap time >= detection interval time. If the configured time <= detection interval time, there may be simultaneous satisfaction of data gaps and anomalies, in which case only the data gap handling result will be applied.


### Information Generation

Enabling this option will generate "Information" events for detection results that do not match the above trigger conditions and write them into the system.

**Note**: When configuring trigger conditions, data gaps, and information generation simultaneously, the following priority applies: data gaps > trigger conditions > information event generation.