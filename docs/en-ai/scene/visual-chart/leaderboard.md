# Top List
---

A reflection of the objective strength of related similar things, succinctly displaying the top N or bottom N rankings in ascending or descending order.

![](../img/top.png)

## Use Cases

It can be used to display the ranking of a metric's data in ascending or descending order and view the ranking situation of grouped data.


## Chart Query

Supports **simple query**, **expression query**, **DQL query**, and **PromQL query**.

The query defaults to built-in 【Top】/【Bottom】 functions, with 4 preset ranking quantities: 5, 10, 20, 100. You can also manually enter the number of items, up to 100 items of data, which can be sorted in ascending or descending order based on the selected metric.

**Note**:

1. Single chart queries only support one query statement, defaulting to simple queries. Click **Convert to Expression Query** to switch to expression query mode, converting the simple query into "Query A". Simple queries and expression queries can be switched between. Click :fontawesome-solid-code: to switch to **DQL Query** & **PromQL Query**;
2. If conversion functions unsupported by expression queries are used in simple queries, they will not be carried over when switching to expression queries.

> For more detailed explanations of chart query conditions, refer to [Chart Query](chart-query.md).

## Chart Configuration

> For more details, refer to [Chart Configuration](./chart-config.md).


<!--
## Chart Links

Links help you jump from the current chart to the target page; internal and external links can be added; template variables can modify corresponding variable values in the link to pass data information, completing data linkage.

> For more related settings, refer to [Chart Links](chart-link.md).

## Common Configurations

| Option | Description |
| --- | --- |
| Title | Set a title for the chart, which will be displayed in the upper left corner of the chart after setting. Supports hiding.|
| Description | Add a description to the chart. After setting, an 【i】 prompt appears after the chart title. It does not display if not set. |
| Unit | **:material-numeric-1-box: Default unit display**:<br /><li>If the queried data is a metric and you have set units for the metric in [Metric Management](../../metrics/dictionary.md), it will display using the metric’s unit.<br /><li>If no unit is configured in **Metric Management**, it will display using [thousands separator](chart-query.md#thousand) notation.<br />**:material-numeric-2-box: After configuring units**:<br />Priority is given to your custom-configured units for display. Metric data supports two options for numerical representation:<br /><br />**Scientific Notation Explanation**<br /><u>Default scaling</u>: Units are ten thousand, million, etc., e.g., 10000 displays as 1 ten thousand, 1000000 displays as 1 million. Retains two decimal places;<br /><u>Short scale</u>: Units are K, M, B. Represent thousands, millions, billions, trillions, etc. For example, 1000 is 1 k, 10000 is 10 k, 1000000 is 1 M; retains two decimal places.|
| Color | Set the color of the chart. |
| Alias | Refer to [Alias](./timeseries-chart.md#legend). |
| Data Format | Choose the number of decimal places and thousands separator.<br /><li>The thousands separator is enabled by default. Disabling it shows the original value without separators. For more details, refer to [Data Thousands Separator Formatting](../visual-chart/chart-query.md#thousand). |


## Advanced Configuration

| Option | Description |
| --- | --- |
| Lock Time Range | Fix the time range for the current chart query data, unaffected by the global time component. After successful setup, the user-defined time will appear in the upper right corner of the chart, such as 【xx minutes】, 【xx hours】, 【xx days】. If the locked time interval is 30 minutes, then regardless of what time range the time component queries, it will only display data from the last 30 minutes. |
| Rule Mapping | <li>Set the range for metrics and corresponding background and font colors. Metrics within this range will display according to the set style;<br /><li>Set the range for metrics and mapping values. When the metric value falls within the set data range, it will display the corresponding mapped value;<br /><li>When a metric value satisfies multiple settings, it will display the style of the last condition met.<br /><br />When setting value mappings, neither 【Display As】 nor 【Color】 are required fields:<br />&nbsp; &nbsp; &nbsp;【Display As】defaults to empty, meaning no mapped value display;<br />&nbsp; &nbsp; &nbsp;【Color】defaults to empty, meaning no color mapping and displays its original color.<br /> |
| Baseline | Support adding baseline values, baseline titles, and baseline colors. |
| Field Mapping | Works with view variable object mapping functionality, disabled by default. If object mapping is configured in view variables:<br /><li>Enabling field mapping displays the **grouped fields** and corresponding **mapped fields** in the chart. Ungrouped fields not specified in the mapping are not displayed;<br /><li>Disabling field mapping displays the chart normally without showing the mapped fields.<br /> |
| Workspace Authorization | The list of authorized workspaces. After selection, it allows querying and displaying data from the authorized workspace. |
| Data Sampling | Applies only to Doris log data engine workspaces; when enabled, it samples all data except “metrics”. The sampling rate is dynamic and adjusts based on data volume. |
| Time Offset | Non-time series data has at least a 1-minute query delay after being stored. When selecting relative time queries, it may lead to missing recent data due to collection delays, resulting in data loss.<br />Enabling time offset shifts the actual query time range forward by 1 minute when querying relative time intervals to prevent data retrieval from being empty due to storage delays. For example, if the current time is 12:30 and you query the last 15 minutes of data, with time offset enabled, the actual query time would be 12:14-12:29.<br />:warning: <br /><li>This setting only applies to relative time ranges. If the query time range is an "absolute time range," time offset does not apply.<br /><li>For charts with time intervals, such as time series charts, if the set time interval exceeds 1 minute, time offset does not apply. For charts without time intervals, like overview charts and bar charts, time offset remains effective.
-->