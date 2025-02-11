# Treemap
---

Used to display the proportion distribution of metrics data under different groups. It can show the proportion of different categories and effectively utilize space, displaying more data compared to pie charts.

![](../img/treemap.png)

## Chart Query

Supports **simple queries**, **expression queries**, **DQL queries**, **PromQL queries**, and **data source queries**.

You can add multiple queries, but the Tag for by (grouping) must be consistent. Modifying one query automatically synchronizes the others. The query results preset 5 return quantities: 5, 10, 20, 50, and 100, with a default return of 20 data points. Manual input is supported, up to a maximum of 100 data points.

> For more detailed explanations of chart query conditions, refer to [Chart Query](chart-query.md).

The chart query selects colors based on the selected metrics values:

- Metrics: Colors represent grouping labels (Tags), and the area represents the metrics data. When multiple metrics queries are added, you can choose the primary metric to display, and the area size will be shown based on the selected metrics data, Top/Bottom, and quantity.

## Chart Configuration

> For more details, refer to [Chart Configuration](./chart-config.md).


<!--
## Chart Link

Links help achieve navigation from the current chart to the target page. You can add internal or external links within the platform, and modify link variables using template variables to pass data information, enabling data linkage.

> For more related settings, refer to [Chart Link](chart-link.md).



## Common Configuration {#ui}

| Option | Description |
| --- | --- |
| Title | Set a title for the chart, which appears in the top-left corner after setting. Supports hiding. |
| Description | Add a description to the chart. After setting, an [i] hint appears after the chart title; if not set, it does not display. |
| Unit | **:material-numeric-1-box: Default unit display**:<br /><li>If the queried data is metrics data and you have set units for the metrics in [Metrics Management](../../metrics/dictionary.md), it will default to showing according to the metric's unit.<br /><li>If no related unit configuration exists in **Metrics Management**, it will display using the [thousand separator](chart-query.md#thousand) format.<br />**:material-numeric-2-box: After configuring units**:<br />It prioritizes using your custom configured units for display. Metric-type data supports two options for numerical representation:<br /><br />**Scientific Notation Explanation**<br /><u>Default Scaling</u>: Units are in ten thousand, million, etc., such as 10000 displayed as 10 thousand, 1000000 displayed as 1 million. Two decimal places are retained;<br /><u>Short Scale</u>: Units are K, M, B. Representing thousand, million, billion, trillion, etc. in Chinese context. For example, 1000 is 1k, 10000 is 10k, 1000000 is 1M; two decimal places are retained. |
| Color | Set the display color for chart data. Supports custom manual input of preset colors, with the format: aggregation function(metrics){"label": "label value"}, e.g., `last(usage_idle){"host": "guance_01"}`. |
| Alias | Refer to [Alias](./timeseries-chart.md#legend). |
| Legend | Includes labels, percentages, and values. Multiple options can be checked. |
| Data Format | Choose the number of decimal places and thousands separator.<br /><li>The thousands separator is enabled by default. Disabling it shows the raw value without separators. More details can be found at [Thousands Separator Format](../visual-chart/chart-query.md#thousand). |


## Advanced Configuration

| Option | Description |
| --- | --- |
| Lock Time | Fixes the time range for the current chart query data, unaffected by the global time component. After successful setup, the user-defined time will appear in the top-right corner of the chart, such as [xx minutes], [xx hours], [xx days]. |
| Time Slicing | When enabled, it first segments and aggregates the original data according to a certain time interval, then performs a second aggregation on the aggregated dataset to obtain the result value. Defaults to off.<br /><br />If time slicing is disabled, there is no time interval option; if enabled, the time interval options are as follows:<br /><li>Auto Alignment: When enabled, it dynamically adjusts queries based on the selected time range and aggregation time interval, rounding up the calculated time interval.<br /> &nbsp; &nbsp; &nbsp;The system presets various time intervals: 1 millisecond, 10 milliseconds, 50 milliseconds, 100 milliseconds, 500 milliseconds, 1 second, 5 seconds, 15 seconds, 30 seconds, 1 minute, 5 minutes, 10 minutes, 30 minutes, 1 hour, 6 hours, 12 hours, 1 day, 1 week, 1 month;<br /><li>Custom Time Interval: When selecting [Lock Time], it automatically matches different selectable time intervals based on the length of the locked time. (*For example, if the time interval is chosen as 1 minute, the actual query will use a 1-minute interval*)<br /><br /><br />More details can be found at [Time Slicing Explanation](chart-query.md#time-slicing). |
| Field Mapping | Works with view variable object mapping features, default is off. If object mapping is configured in view variables:<br /><li>When field mapping is enabled, the chart displays the **grouping fields** and corresponding **mapped fields**, and any non-mapped grouping fields are not shown;<br /><li>When field mapping is disabled, the chart displays normally without showing mapped fields.<br /> |
| Workspace Authorization | Authorized workspace lists. After selection, the chart can query and display data from the authorized workspaces. |
| Data Sampling | Only applicable to Doris log data engine workspaces; when enabled, it samples data other than "metrics," with a non-fixed sampling rate that dynamically adjusts based on data volume. |
| Time Offset | Non-time series data has at least a 1-minute query delay after being stored. Selecting relative time queries may lead to recent few minutes' data not being collected, resulting in data loss.<br />Enabling time offset shifts the actual query time range forward by 1 minute when querying relative time ranges, preventing data retrieval from being empty due to storage delays. For example, at 12:30, querying the last 15 minutes of data would actually query from 12:14 to 12:29.<br />:warning: <br /><li>This setting only applies to relative time queries. If the query time range is "absolute time range," the time offset does not take effect.<br /><li>For charts with time intervals, such as time series charts, time offset does not take effect if the set time interval exceeds 1 minute, and only takes effect if <= 1 minute. For charts without time intervals, such as summary charts and bar charts, the time offset remains effective.|
-->