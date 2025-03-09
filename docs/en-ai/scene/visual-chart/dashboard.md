# Dashboard
---

It clearly displays the range in which metric data values fall, making it suitable for segmenting chaotic data to highlight key points.

<img src="../../img/dashboard-pic.png" width="70%" >

## Chart Query

Supports **simple query**, **expression query**, and **PromQL query**.

**Note**:

1. Single chart queries only support one query statement, defaulting to a simple query. You can switch between simple and expression queries. DQL queries also support switching between these modes;
2. If conversion functions unsupported by expression queries are used in a simple query, they will not be carried over when switching to an expression query.

> For more detailed explanations of chart query conditions, refer to [Chart Query](chart-query.md).

<!--
## Chart Links

Links help you jump from the current chart to the target page; you can add internal and external links. Additionally, you can pass data information by modifying the corresponding variables in the link using template variables, achieving data interactivity.

> For more related settings, refer to [Chart Links](chart-link.md).
-->

## Chart Configuration

> For more details, refer to [Chart Configuration](./chart-config.md).



### Segment Thresholds

This involves setting segmented critical values and gauge colors for numerical values. Corresponding threshold colors are also set.

<img src="../../img/dashboard-pic-1.png" width="70%" >

<!--
| Unit | **:material-numeric-1-box: Default unit display**: <br /><li>If the queried data is metric data and you have set units for metrics in [Metric Management](../../metrics/dictionary.md), it will display according to the metric's unit;<br /><li>If no unit is configured in **Metric Management**, it will display with thousand separators as per [thousand separator](chart-query.md#thousand) rules.<br />**:material-numeric-2-box: After configuring units**: <br />Priority is given to your custom-defined units. Metric data supports two options for numerical values:<br /><br />**Scientific notation explanation**<br /><u>Default scaling</u>: Units are in ten thousand, million, etc., e.g., 10000 shows as 1 ten thousand, 1000000 shows as 1 million. Two decimal places are retained;<br /><u>Short scale</u>: Units are K, M, B. These represent thousand, million, billion, trillion, etc. For example, 1000 is 1k, 10000 is 10k, 1000000 is 1M; two decimal places are retained.|

## Advanced Configuration

| Option | Description |
| --- | --- |
| Time Slicing | When time slicing is enabled, the original data is first segmented and aggregated based on a certain time interval, then the aggregated dataset undergoes a second aggregation to get the final result value. It is disabled by default.<br /><br />If time slicing is off, there is no time interval option; if enabled, the time interval options are as follows:<br /><li>Auto-align: When enabled, it dynamically adjusts the query based on the selected time range and aggregation interval, rounding up to the nearest higher interval.<br /> &nbsp; &nbsp; &nbsp;The system presets multiple time intervals: 1ms, 10ms, 50ms, 100ms, 500ms, 1s, 5s, 15s, 30s, 1min, 5min, 10min, 30min, 1h, 6h, 12h, 1d, 1w, 1mo;<br /><li>Custom time interval: When selecting "Lock Time," different selectable time intervals are automatically matched based on the locked time duration. (e.g., if the time interval is set to 1 minute, the actual query will use 1-minute intervals.)<br /><br /><br />For more details, refer to [Time Slicing Explanation](chart-query.md#time-slicing). |
| Workspace Authorization | The list of authorized workspaces. Once selected, you can query and display data from that workspace through the chart. |
| Data Sampling | Applies only to workspaces using the Doris log data engine; when enabled, it samples non-metric data, with a dynamic sampling rate based on data volume. |
| Time Offset | Non-time series data may have at least a 1-minute delay after being stored. When querying relative time, this might lead to missing recent data.<br />Enabling time offset shifts the actual query time range forward by 1 minute when querying relative time ranges, preventing data loss due to storage delays. For example, if it is currently 12:30 and you query the last 15 minutes of data, with time offset enabled, the actual query time is 12:14-12:29.<br />:warning: <br /><li>This setting applies only to relative time ranges. If querying an absolute time range, time offset does not apply.<br /><li>For charts with time intervals, such as time series charts, time offset does not apply if the interval exceeds 1 minute. For charts without time intervals, like overview or bar charts, time offset remains effective.
--></example>
</example>