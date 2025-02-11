# Top List
---

An objective reflection of the strength of related similar things, succinctly displaying the Top N or Bottom N ranking in ascending or descending order.

![](../img/top.png)

## Application Scenarios

It can be used to display the ranking of a metric's data in ascending or descending order, viewing the ranking situation of grouped data.


## Chart Queries

Supports **simple queries**, **expression queries**, **DQL queries**, and **PromQL queries**.

The query defaults to built-in 【Top】/【Bottom】 functions with preset rankings of 5, 10, 20, and 100. You can also manually input the number of items, up to a maximum of 100 data entries, which can be sorted in ascending or descending order based on the selected metric.

**Note**:

1. Single chart queries only support one query statement, defaulting to simple queries. Click **Convert to Expression Query** to switch to an expression query, using the simple query as "Query A," supporting mutual switching. Click :fontawesome-solid-code: to switch to **DQL Query** & **PromQL Query**;
2. If conversion functions unsupported by expression queries are used in simple queries, they will not be carried over when switching to expression queries.

> For more detailed explanations of chart query conditions, refer to [Chart Queries](chart-query.md).

## Chart Configuration

> For more details, refer to [Chart Configuration](./chart-config.md).


<!--
## Chart Links

Links can help you jump from the current chart to the target page; internal and external links can be added; template variables can modify the corresponding variable values in the link to pass data information, completing data linkage.

> For more related settings, refer to [Chart Links](chart-link.md).

## Common Configurations

| Option | Description |
| --- | --- |
| Title | Set a title for the chart, displayed in the top-left corner after setting, with an option to hide it.|
| Description | Add a description to the chart, which appears as an 【i】 prompt after the title if set; otherwise, it does not appear. |
| Unit | **:material-numeric-1-box: Default Unit Display**: <br /><li>If the queried data is metric data and you have set units for metrics in [Metric Management](../../metrics/dictionary.md), the units will be displayed accordingly;<br /><li>If no units are configured in **Metric Management**, the data will be displayed using thousand separators.<br />**:material-numeric-2-box: After configuring units**: <br />Your custom unit configuration takes precedence, supporting two options for metric data:<br /><br />**Scientific Notation Explanation**<br /><u>Default Scaling</u>: Units are in ten thousand, million, etc., e.g., 10000 is shown as 1 ten thousand, 1000000 as 1 million. Two decimal places are retained;<br /><u>Short Scale</u>: Units are K, M, B, representing thousand, million, billion, trillion, etc. E.g., 1000 is 1k, 10000 is 10k, 1000000 is 1 million; two decimal places are retained.|
| Color | Set the chart color. |
| Alias | Refer to [Alias](./timeseries-chart.md#legend). |
| Data Format | Choose the number of decimal places and thousand separators.<br /><li>The thousand separator is enabled by default. Disabling it shows the raw value without separators. For more details, refer to [Data Thousand Separator Format](../visual-chart/chart-query.md#thousand). |


## Advanced Configurations

| Option | Description |
| --- | --- |
| Lock Time | Fix the time range for the current chart query data, unaffected by the global time component. After successful setup, the user-defined time will appear in the top-right corner of the chart, such as 【xx minutes】, 【xx hours】, 【xx days】. If the locked time interval is 30 minutes, regardless of the time range viewed via the time component, only the most recent 30 minutes of data will be displayed. |
| Rule Mapping | <li>Set the metric range and corresponding background and font colors. Metrics within the range will display according to the set style;<br /><li>Set the metric range and mapping values, displaying the corresponding mapping values when the metric falls within the set range;<br /><li>When multiple settings are met simultaneously, the last condition satisfied will be displayed.<br /><br />When setting value mappings, neither 【Display As】 nor 【Color】 are mandatory:<br />&nbsp; &nbsp; &nbsp;【Display As】defaults to empty, meaning no mapping value is displayed;<br />&nbsp; &nbsp; &nbsp;【Color】defaults to empty, meaning the original color is displayed.<br /> |
| Baseline | Supports adding baseline values, titles, and colors. |
| Field Mapping | Works with view variable object mapping, defaulting to off. If object mapping is configured in view variables:<br /><li>Enabling field mapping displays the **grouped fields** and corresponding **mapped fields** in the chart; unmapped grouped fields are not displayed;<br /><li>Disabling field mapping shows the chart normally without displaying mapped fields.<br /> |
| Workspace Authorization | Authorized workspace list, allowing chart queries and display of data from that workspace after selection. |
| Data Sampling | Only for workspaces using the Doris log data engine; when enabled, it samples non-metric data dynamically based on data volume. |
| Time Offset | Non-time series data has at least a 1-minute query delay after being stored. When selecting relative time queries, this may result in missing data from the last few minutes.<br />Enabling time offset shifts the actual query time range forward by 1 minute when querying relative time intervals to prevent data loss due to storage delays. For example, if it is currently 12:30 and you query the last 15 minutes of data, enabling time offset means the actual query time is 12:14-12:29.<br />:warning: <br /><li>This setting only applies to relative time queries; for absolute time ranges, time offset does not apply.<br /><li>For charts with time intervals, such as time series charts, time offset only applies if the interval is <= 1 minute. For charts without time intervals, like summary or bar charts, time offset remains effective.
--></translated_content>