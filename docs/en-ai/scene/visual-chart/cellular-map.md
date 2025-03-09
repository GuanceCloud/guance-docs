# Honeycomb Chart
---

Displays the data situation under different groups, indicating the magnitude of the data through the depth of color blocks. It can be used for monitoring assets and infrastructure.

![](../img/bee.png)

## Chart Configuration

> For more details, refer to [Chart Configuration](./chart-config.md).


<!--

## Common Configuration

| Option | Description |
| --- | --- |
| Title | Set a title for the chart. Once set, it will display in the top-left corner of the chart, with an option to hide it. |
| Description | Add a description to the chart. After setting, an 【i】 icon will appear after the chart title, which does not show if not set. |
| Colors | Gradient intervals:<br><li>Auto: By default, the system divides the current data's maximum and minimum values into 5 intervals, supporting custom maximum and minimum values;<br><li>Custom: Supports custom gradient color levels, i.e., setting the level ranges for the honeycomb chart areas. The system defaults to dividing the selected metric's max and min values into 5 gradient levels, supporting custom number of levels (up to 10), level ranges, and display colors.<br/><br/>Gradient colors: The gradient colors of the blocks. After selecting a color, the system generates color blocks based on the selected color and the number of levels. |
| Legend | For more details, refer to [Legend Explanation](./timeseries-chart.md#legend). |
| Unit | **:material-numeric-1-box: Default unit display**:<br /><li>If the queried data is metric data and you have set units for the metrics in [Metric Management](../../metrics/dictionary.md), the units will be displayed according to the metric's unit settings;<br /><li>If no unit is configured in **Metric Management**, the data will be displayed using [thousands separator](chart-query.md#thousand) with comma-separated values.<br />**:material-numeric-2-box: After configuring units**:<br />The system will prioritize the custom unit configuration for displaying the data, supporting two options for metric data:<br /><br />**Scientific Notation Explanation**<br /><u>Default rounding</u>: Units are in ten thousand, million, e.g., 10000 displays as 1 ten thousand, 1000000 displays as 1 million. Two decimal places are retained;<br /><u>Short scale</u>: Units are K, M, B, representing thousand, million, billion, trillion respectively. For example, 1000 is 1 k, 10000 is 10 k, 1000000 is 1 million; two decimal places are retained.|
| Data Format | You can choose the number of decimal places and whether to use a thousands separator.<br /><li>The thousands separator is enabled by default. If disabled, the original value without separators will be displayed. For more details, refer to [Data Thousands Separator Format](../visual-chart/chart-query.md#thousand). |

## Advanced Configuration

| Option | Description |
| --- | --- |
| Lock Time Range | Fix the time range for querying data in this chart, independent of the global time component. After setting, the user-defined time will appear in the top-right corner of the chart, such as 【xx minutes】, 【xx hours】, 【xx days】. For example, if the lock time interval is 30 minutes, regardless of the time range selected in the time component, only the data from the last 30 minutes will be displayed. |
| Field Mapping | Works with view variable object mapping. By default, it is off. If object mapping is configured in view variables:<br /><li>When field mapping is enabled, the chart shows the **grouped fields** and corresponding **mapped fields**, and any grouped fields not specified in the mapping will not be displayed;<br /><li>When field mapping is disabled, the chart displays normally without showing the mapped fields. |
| Workspace Authorization | A list of authorized workspaces. After selection, the chart can query and display data from these workspaces. |
| Data Sampling | Only applicable to Doris log data engine workspaces; when enabled, it samples non-metric data, with a dynamic sampling rate based on data volume. |
| Time Offset | Non-time series data has at least a 1-minute delay after being stored. When using relative time queries, recent data may not be captured, leading to missing data.<br />Enabling time offset shifts the actual query time range forward by 1 minute to prevent data loss due to storage delays. For example, if the current time is 12:30 and you query the last 15 minutes of data, with time offset enabled, the actual query time would be 12:14-12:29.<br />:warning: <br /><li>This setting only applies to relative time queries. If the time range is an "absolute time range," the time offset does not apply.<br /><li>For charts with time intervals, such as time series charts, if the time interval exceeds 1 minute, the time offset does not apply. For charts without time intervals, like summary charts or bar charts, the time offset remains effective.|

-->