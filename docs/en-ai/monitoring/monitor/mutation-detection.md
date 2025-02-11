# Mutation Detection
---

By comparing the absolute change or relative percentage change of the same metric across two different time periods, this method determines whether an anomaly has occurred. This approach is often used to track peaks or fluctuations in metrics. When anomalies are detected, it can more accurately generate event records for subsequent analysis and handling.

## Application Scenarios

Mutation detection is suitable for monitoring short-term changes relative to long-term data or change rates. For example, setting the percentage difference between the average MySQL connection count over the past 15 minutes and the average value over the past day to be greater than 500% means that if the average connection count over the last 15 minutes exceeds five times the average connection count over the past day, the system will trigger a warning.

It is recommended to use statistical functions such as Average (AVG), Maximum (MAX), Minimum (MIN) to calculate these metrics rather than using the Last Value (LAST) function to reduce the impact of abnormal data and improve monitoring accuracy.

## Detection Configuration {#configuration-file}

![](../img/monitor22.png)

### Detection Metrics

This refers to the monitored metric data. It can compare the difference or percentage difference of the metric between two time periods.

| Field | Description |
| --- | --- |
| Data Type | The current data type being detected, including metrics, logs, infrastructure, resource catalog, events, APM, RUM, security check, network, and Profile. |
| Mearsurement | The measurement set where the current detected metric resides. |
| Metric | The specific metric currently being detected. |
| Aggregation Algorithm | Includes Avg by (average), Min by (minimum), Max by (maximum), Sum by (sum), Last (last value), First by (first value), Count by (data point count), Count_distinct by (distinct data point count), p50 (median), p75 (75th percentile), p90 (90th percentile), p99 (99th percentile). |
| Detection Dimension | String type (`keyword`) fields in the configuration data can be selected as detection dimensions. Currently, up to three fields can be chosen. By combining multiple detection dimension fields, a specific detection object can be determined. Guance will judge whether the statistical metric of a certain detection object meets the threshold condition; if so, an event will be generated.<br />* (For example, selecting detection dimensions `host` and `host_ip` would result in a detection object like `{host: host1, host_ip: 127.0.0.1}`). |
| Filtering Conditions | Filter the data of the detected metric based on metric tags to limit the scope of detection data; supports adding one or more tag filters; supports fuzzy matching and fuzzy non-matching filter conditions. |
| Alias | Customize the name of the detected metric. |
| [Query](../../scene/visual-chart/chart-query.md) Method | Supports simple query and expression query. |

The selectable detection intervals include last month, last week, yesterday, 1 hour ago, compared with the previous period, last 15 minutes, last 30 minutes, last 1 hour, last 4 hours, last 12 hours, and last 1 day.

**Note**: For detection intervals "yesterday" and "1 hour ago," the difference or percentage difference within the same time range is compared. For other detection intervals, the difference or percentage difference between two time periods is compared.

![](../img/1.monitor_1.png)

### Detection Frequency

The execution frequency of the detection rule, automatically matched to the larger time range of the two selected detection intervals. It includes 1 minute, 5 minutes, 15 minutes, 30 minutes, and 1 hour.

### Trigger Conditions

Set the trigger conditions for alert levels: You can configure any one of the following trigger conditions—critical, major, minor, data gap, informational:

1. Pre-trigger Condition Configuration: Enabled by default; when the detection value meets the threshold set in the pre-trigger condition (operators supported: >, >=, <, <=, default selected >), then continue to evaluate the mutation detection rule; disabling this configuration only evaluates the mutation detection rule.

2. Mutation Rule Configuration: Compare data in three forms—upward (data increase), downward (data decrease), or both upward and downward—to evaluate the mutation detection rule.

![](../img/muta_01.png)

Configure trigger conditions and severity levels. If the query results contain multiple values, an event is generated if any value meets the trigger condition.

> For more details, refer to [Event Level Description](event-level-description.md).

???+ abstract "Alert Levels"

	1. **Critical (Red), Major (Orange), Minor (Yellow)**: Based on configured condition operators.
  

	2. **Normal (Green)**: Based on configured detection counts, as follows:

	- Each execution of a detection task counts as 1 detection, e.g., [Detection Frequency = 5 minutes] means 1 detection = 5 minutes.
	- Customizable detection counts, e.g., [Detection Frequency = 5 minutes], then 3 detections = 15 minutes.

	| Level | Description |
	| --- | --- |
	| Normal | After the detection rule takes effect, if critical, major, or minor abnormal events occur, and the data detection results return to normal within the custom-configured detection count, a recovery alert event is generated.<br/> :warning: Recovery alert events are not subject to [alert muting](../alert-setting.md). If no recovery alert event detection count is set, the alert event will not recover and will remain in the [**Events > Unrecovered Events List**](../../events/event-explorer/unrecovered-events.md). |

### Data Gap

For data gaps, seven strategies can be configured.

1. Link to the detection interval time range, determine the query results of the most recent minutes of the detected metric, **do not trigger events**;

2. Link to the detection interval time range, determine the query results of the most recent minutes of the detected metric, **consider the query result as 0**; at this point, the query result will be re-evaluated against the threshold configured in the **trigger conditions** to determine if an anomaly event should be triggered.

3. Customize the fill-in value for the detection interval, **trigger data gap events, critical events, major events, minor events, and recovery events**; choose this configuration strategy, it is recommended that the custom data gap time be **>= detection interval time**, if the configured time <= detection interval time, there may be simultaneous satisfaction of data gap and anomaly conditions, in which case only the data gap processing result will apply.


### Information Generation

Enabling this option generates "informational" events for detection results that do not match the above trigger conditions.

**Note**: If trigger conditions, data gaps, and information generation are configured simultaneously, the following priority order applies: data gap > trigger conditions > information event generation.