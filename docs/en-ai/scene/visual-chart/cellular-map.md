# Honeycomb Chart
---

Displays the data situation under different groups, using color block intensity to represent data magnitude. It can be used for monitoring assets and infrastructure.

![](../img/bee.png)

## Chart Configuration

> For more details, refer to [Chart Configuration](./chart-config.md).


<!--

## Common Configuration

| Option | Description |
| --- | --- |
| Title | Set a title for the chart, which will be displayed in the top-left corner of the chart after configuration. Supports hiding. |
| Description | Add a description to the chart. After setting, an [i] prompt will appear after the chart title; it does not display if not set. |
| Color | Gradient range:<br><li>Automatic: By default, the current data's maximum and minimum values are divided into 5 intervals, with support for customizing the maximum and minimum values;<br><li>Custom: Customize gradient color levels, i.e., set the level of the honeycomb chart area. The system defaults to dividing the selected Metrics' maximum and minimum values into 5 gradient levels, supporting customization of the number of levels (up to 10), level ranges, and display colors.<br/><br/>Gradient colors: The gradient color of the color blocks. After selecting a color, the system generates color blocks based on the selected color according to the specified number of levels. |
| Legend | For more details, refer to [Legend Explanation](./timeseries-chart.md#legend). |
| Unit | **:material-numeric-1-box: Default unit display**:<br /><li>If the queried data is Metrics data and you have set units for the Metrics in [Metrics Management](../../metrics/dictionary.md), the default display will follow the configured units;<br /><li>If no related unit configuration exists in **Metrics Management**, it will display using thousand separators.<br />**:material-numeric-2-box: After configuring units**:<br />It prioritizes displaying with your custom-configured units. For Metrics data, two options are available for numerical representation:<br /><br />**Scientific Notation Explanation**<br /><u>Default rounding</u>: Units are ten thousand, one hundred thousand, etc. For example, 10000 displays as 10K, 1000000 displays as 1M. Retains two decimal places;<br /><u>Short scale</u>: Units are K, M, B, representing thousand, million, billion, trillion, etc. For example, 1000 is 1k, 10000 is 10k, 1000000 is 1M; retains two decimal places.|
| Data Format | You can choose the number of decimal places and whether to use thousand separators.<br /><li>Thousand separators are enabled by default. When disabled, raw values without separators are displayed. For more details, refer to [Data Thousand Separator Format](../visual-chart/chart-query.md#thousand). |

## Advanced Configuration

| Option | Description |
| --- | --- |
| Lock Time Range | Fix the time range for querying data in this chart, independent of the global time component. After successful configuration, the user-defined time will appear in the top-right corner of the chart, such as 【xx minutes】, 【xx hours】, 【xx days】. If the locked time interval is 30 minutes, regardless of the time range selected in the time component, only the data from the last 30 minutes will be displayed. |
| Field Mapping | Works with view variable object mapping, defaulting to off. If object mapping is configured in view variables:<br /><li>When field mapping is enabled, the chart displays the **grouped fields** and corresponding **mapped fields**; unmapped grouped fields do not display;<br /><li>When field mapping is disabled, the chart displays normally without showing mapped fields. |
| Workspace Authorization | Authorized workspace list. After selection, the chart queries and displays data from the selected workspaces. |
| Data Sampling | Applies only to Doris log data engine workspaces. When enabled, it samples all non-Metrics data, with a dynamic sampling rate based on data volume. |
| Time Offset | Non-time series data has at least a 1-minute query delay after being stored. Selecting relative time queries may result in recent data not being collected, leading to data loss.<br />Enabling time offset shifts the actual query time range forward by 1 minute when querying relative time ranges, preventing empty data due to storage delays. For example, if the current time is 12:30 and you query the last 15 minutes of data, enabling time offset changes the actual query time to 12:14-12:29.<br />:warning: <br /><li>This setting applies only to relative time ranges. If the query time range is "absolute," time offset does not apply.<br /><li>For charts with time intervals, like time series charts, time offset applies only if the set time interval is <= 1 minute. For charts without time intervals, like summary or bar charts, time offset remains effective.|

-->