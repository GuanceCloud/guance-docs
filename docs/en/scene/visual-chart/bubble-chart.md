# Bubble Chart
---

The bubble chart can be used to display the relationship between three variables, similar to a scatter plot with an x-axis and y-axis, and includes a variable representing size for comparison. It shows the general trend of the dependent variable changing with the independent variable, from which a suitable function can be chosen to fit the empirical distribution and find the functional relationship between variables. It can be used to observe the distribution and clustering of data.

![](../img/bubble.png)

## Chart Query

Define filtering conditions for the X-axis and Y-axis separately. You can switch to expression queries, PromQL queries, or other data source queries.

> For more details, refer to [Chart Query](./chart-query.md).

## Chart Configuration

> For more details, refer to [Chart Configuration](./chart-config.md).

<!--
## Common Configuration

| Option | Description |
| --- | --- |
| Title | Set a title for the chart, which will be displayed in the top-left corner of the chart after setting; supports hiding. |
| Description | Add a description to the chart, which will appear as an [i] prompt after the chart title if set; otherwise, it will not be displayed. |
| Unit | **:material-numeric-1-box: Default unit display**:<br /><li>If the queried data is metrics data and you have set units for the metrics in [Metrics Management](../../metrics/dictionary.md), the default display will follow the metric's unit;<br /><li>If no related unit configuration exists in **Metrics Management**, it will display with thousand separators.<br />**:material-numeric-2-box: After configuring units**:<br />It prioritizes using your custom-configured units for display. Metrics data supports two options for numerical representation:<br /><br />**Scientific notation explanation**<br /><u>Default progression</u>: Units are ten thousand, million, etc., e.g., 10000 is displayed as 1 ten thousand, 1000000 as 1 million. Retains two decimal places;<br /><u>Short scale</u>: Units are K, M, B. i.e., thousand, million, billion, trillion, etc., in English context. For example, 1000 is 1k, 10000 is 10k, 1000000 is 1M; retains two decimal places.|
| Color | Set the display color for chart data, supporting custom preset colors entered manually. The input format is: aggregation_function(metric){"label": "label_value"}, such as `last(usage_idle){"host": "guance_01"}`. |
| Alias | <li>Supports adding aliases to grouped queries, which changes the legend names accordingly, making it easier to distinguish related metrics.<br/><li>Supports custom manual entry of preset aliases, with the input format being: aggregation_function(metric){"label": "label_value"}, such as `last(usage_idle){"host": "guance_01"}`. |
| Data Format | Choose the number of decimal places and whether to use thousand separators.<br /><li>Thousand separators are enabled by default. Disabling them displays raw values without separators. For more details, refer to [Data Thousand Separator Formatting](../visual-chart/chart-query.md#thousand). |


## Advanced Configuration

| Option | Description |
| --- | --- |
| Lock Time | Fix the time range for the current chart query data, unaffected by the global time component. After successful setup, the user-defined time appears in the top-right corner of the chart, such as 【xx minutes】, 【xx hours】, 【xx days】. If the locked time interval is 30 minutes, regardless of the time range selected by the time component, only the last 30 minutes of data will be displayed. |
| Field Mapping | Works with view variable object mapping functionality, which is off by default. If object mapping is configured in view variables:<br /><li>Enabling field mapping displays the **grouping fields** and corresponding **mapped fields** in the chart, while unmapped grouping fields are not shown;<br /><li>Disabling field mapping shows the chart normally without displaying mapped fields.<br /> |
| Workspace Authorization | Lists authorized workspaces, allowing queries and displays of data from those workspaces after selection. |
| Data Sampling | Applies only to Doris log data engine workspaces; when enabled, it samples all data except metrics, with a dynamic sampling rate based on data volume. |
| Time Offset | Non-time series data has at least a 1-minute query delay after being stored. When selecting relative time queries, this may result in recent data not being collected, leading to data loss.<br />Enabling time offset shifts the actual query time range forward by 1 minute when querying relative time intervals, preventing data gaps due to storage delays. For example, at 12:30, querying the last 15 minutes of data would actually query from 12:14 to 12:29.<br />:warning: <br /><li>This setting only applies to relative time ranges; absolute time ranges do not apply.<br /><li>For charts with time intervals, such as time series charts, time offset does not apply if the time interval exceeds 1 minute. For charts without time intervals, like overview or bar charts, time offset remains effective.
-->