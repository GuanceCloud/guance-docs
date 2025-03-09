# Mutation Detection
---

By comparing the absolute change or relative percentage change of the same metric in two different time periods, it determines whether an anomaly has occurred. This method is commonly used to track peaks or fluctuations in metrics. When an anomaly is detected, it can generate event records more accurately for subsequent analysis and processing.


## Use Cases

Mutation detection is suitable for monitoring short-term changes relative to long-term data or change rates. For example, setting the percentage difference between the average number of MySQL connections in the last 15 minutes and the average over the past day to be greater than 500% means that if the average number of connections in the last 15 minutes exceeds five times the daily average, the system will trigger a warning.

It is recommended to use statistical functions such as Average (AVG), Maximum (MAX), Minimum (MIN) to calculate these metrics rather than the Last (LAST) function to reduce the impact of anomalous data and improve monitoring accuracy.


## Detection Configuration {#configuration-file}

![](../img/monitor22.png)

### Detection Metrics

This refers to the metric data being monitored. It compares the difference or percentage difference of the metric between two time periods.

| Field | Description |
| --- | --- |
| Data Type | The current data type being detected, including Metrics, Logs, Infrastructure, Resource Catalog, Events, APM, RUM, Security Check, Network, and Profile. |
| Mearsurement | The measurement set where the current detection metric resides. |
| Metric | The specific metric currently being detected. |
| Aggregation Algorithm | Includes Avg by (average), Min by (minimum), Max by (maximum), Sum by (sum), Last (last value), First by (first value), Count by (data point count), Count_distinct by (unique data point count), p50 (median), p75 (75th percentile), p90 (90th percentile), p99 (99th percentile). |
| Detection Dimensions | String type (`keyword`) fields in the configuration data can be selected as detection dimensions, with up to three fields supported. By combining multiple detection dimension fields, a specific detection object can be determined. <<< custom_key.brand_name >>> will determine whether the statistical metric for a specific detection object meets the threshold condition; if it does, an event is generated.<br />* (For example, selecting detection dimensions `host` and `host_ip` results in a detection object like `{host: host1, host_ip: 127.0.0.1}`). |
| Filter Conditions | Filters the detection metric data based on metric labels to limit the scope of the detected data; supports adding one or more label filters; supports fuzzy matching and non-matching filter conditions. |
| Alias | Custom name for the detection metric. |
| [Query](../../scene/visual-chart/chart-query.md) Method | Supports simple queries and expression queries. |

Time intervals can include last month, last week, yesterday, one hour ago, compared to the previous period, last 15 minutes, last 30 minutes, last hour, last 4 hours, last 12 hours, and last day.

**Note**: For the detection intervals "yesterday" and "one hour ago," the comparison is made within the same time range for the difference or percentage difference of the detection metric. For other detection intervals, the comparison is made between two time periods for the difference or percentage difference of the detection metric.

![](../img/1.monitor_1.png)


### Detection Frequency

The execution frequency of the detection rule automatically matches the larger time range of the two selected detection intervals. It includes 1 minute, 5 minutes, 15 minutes, 30 minutes, and 1 hour.

### Trigger Conditions

Set the alert level trigger conditions: you can configure any one of the following trigger conditions—Critical, Major, Minor, Data Gap, Informational:

1. Pre-trigger Condition Configuration: Enabled by default; when the detected value meets the threshold set in the pre-trigger condition (supported operators are >, >=, <, <=, default is >), then proceed to evaluate the mutation detection rule; disabling this configuration skips the pre-trigger condition check and directly evaluates the mutation detection rule;

2. Mutation Rule Configuration: Compares data increases, decreases, or both for mutation detection rules.

![](../img/muta_01.png)

Configure trigger conditions and severity levels. If the query result contains multiple values, any value meeting the trigger condition will generate an event.

> For more details, refer to [Event Level Description](event-level-description.md).

???+ abstract "Alert Levels"

	1. **Alert Levels Critical (Red), Major (Orange), Minor (Yellow)**: Based on configured condition operators.
  

	2. **Alert Level Normal (Green)**: Based on configured detection counts, as follows:

	- Each execution of a detection task counts as 1 detection, e.g., if [Detection Frequency = 5 minutes], then 1 detection = 5 minutes;
	- You can customize the detection count, e.g., if [Detection Frequency = 5 minutes], then 3 detections = 15 minutes.

	| Level | Description |
	| --- | --- |
	| Normal | After the detection rule takes effect, if critical, major, or minor abnormal events occur, and the data returns to normal within the configured custom detection count, a recovery alert event is generated.<br/> :warning: Recovery alert events are not subject to [alert muting](../alert-setting.md). If no recovery alert event detection count is set, the alert event will not recover and will remain in the [**Events > Unrecovered Events List**](../../events/event-explorer/unrecovered-events.md).|

### Data Gap

For data gap states, seven strategies can be configured.

1. Link the detection interval time range to judge the query results of the most recent minutes of the detection metric, **no event is triggered**;

2. Link the detection interval time range to judge the query results of the most recent minutes of the detection metric, **query results are treated as 0**; at this point, the query results are re-evaluated against the thresholds configured in the **trigger conditions** to determine if an anomaly event should be triggered.

3. Customize the fill value for the detection interval, **trigger data gap event, critical event, major event, minor event, and recovery event**; when choosing this configuration strategy, it is recommended that the custom data gap time be **>= detection interval time**. If the configured time <= detection interval time, there might be simultaneous satisfaction of data gap and anomaly conditions, in which case only the data gap handling result will apply.


### Information Generation

Enabling this option generates "information" events for detection results that do not match the above trigger conditions.

**Note**: When configuring trigger conditions, data gaps, and information generation simultaneously, the priority order for triggering is: data gap > trigger conditions > information event generation.