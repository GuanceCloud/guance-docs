# Dashboard
---

Clearly displays the range in which metric data values fall, making it suitable for organizing chaotic data and highlighting key points.

<img src="../../img/dashboard-pic.png" width="70%" >

## Chart Query

Supports **simple query**, **expression query**, and **PromQL query**.

**Note**:

1. Single chart queries only support one query statement, defaulting to a simple query. You can switch between simple and expression queries. DQL queries also support switching between these modes;
2. If a transformation function used in a simple query is not supported by an expression query, the function will not be carried over when switching to expression query.

> For more detailed explanations of chart query conditions, refer to [Chart Query](chart-query.md).

<!--
## Chart Links

Links help you navigate from the current chart to a target page; you can add internal and external links. Additionally, template variables can modify corresponding variable values in the link to pass data information, achieving data linkage.

> For more related settings, refer to [Chart Links](chart-link.md).
-->

## Chart Configuration

> For more details, refer to [Chart Configuration](./chart-config.md).

### Segment Thresholds

Set segment threshold values and gauge colors for numerical values. Corresponding thresholds should also have their colors configured.

<img src="../../img/dashboard-pic-1.png" width="70%" >

<!--
| Unit | **:material-numeric-1-box: Default Unit Display**:<br /><li>If the queried data is metric data and you have set units for metrics in [Metric Management](../../metrics/dictionary.md), the data will be displayed according to the unit of the metric;<br /><li>If no unit is configured in **Metric Management**, it will display with [thousand separator](chart-query.md#thousand) as the numeric increment format.<br />**:material-numeric-2-box: After Configuring Units**:<br />Priority is given to using the custom-configured units you set. Metric data supports two options for displaying numbers:<br /><br />**Scientific Notation Explanation**<br /><u>Default Increment</u>: Units are ten thousand, million, e.g., 10000 is displayed as 1 ten thousand, 1000000 as 1 million. Two decimal places are retained;<br /><u>Short Scale</u>: Units are K, M, B. That is, thousand, million, billion, trillion, etc., in Chinese context. For example, 1000 is 1K, 10000 is 10K, 1000000 is 1M; two decimal places are retained.|

## Advanced Configuration

| Option | Description |
| --- | --- |
| Time Slicing | When time slicing is enabled, the original data is first segmented and aggregated based on a certain time interval, then the aggregated dataset is secondarily aggregated to get the final result value. It is disabled by default.<br /><br />If time slicing is disabled, there is no time interval option; if enabled, the time interval options are as follows:<br /><li>Auto Align: When enabled, it dynamically adjusts the query based on the selected time range and aggregation time interval, rounding up to the nearest time interval.<br /> &nbsp; &nbsp; &nbsp;The system presets multiple time intervals: 1 millisecond, 10 milliseconds, 50 milliseconds, 100 milliseconds, 500 milliseconds, 1 second, 5 seconds, 15 seconds, 30 seconds, 1 minute, 5 minutes, 10 minutes, 30 minutes, 1 hour, 6 hours, 12 hours, 1 day, 1 week, 1 month;<br /><li>Custom Time Interval: When "Lock Time" is selected, different selectable time intervals are automatically matched based on the length of the locked time. (*For example, if the time interval is set to 1 minute, queries will be issued at 1-minute intervals*).<br /><br /><br />For more details, refer to [Time Slicing Explanation](chart-query.md#time-slicing). |
| Workspace Authorization | The list of authorized workspaces. Selecting a workspace allows querying and displaying data from that workspace. |
| Data Sampling | Only for workspaces using the Doris log data engine; when enabled, it samples data other than "Metrics," with a dynamic sampling rate based on data volume. |
| Time Offset | Non-time series data has at least a 1-minute delay after being stored. When querying relative time, this may lead to missing recent data.<br />Enabling time offset shifts the actual query time range forward by 1 minute to prevent data loss due to storage delays. For example, if the current time is 12:30 and you query the last 15 minutes of data, with time offset enabled, the actual query time is 12:14-12:29.<br />:warning: <br /><li>This setting only applies to relative time queries. If the query time range is an absolute time range, time offset does not apply.<br /><li>For charts with time intervals, such as time series charts, if the set time interval exceeds 1 minute, the time offset does not apply. For charts without time intervals, such as overview charts and bar charts, the time offset remains effective.
-->