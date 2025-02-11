# Sankey Diagram

A special type of flow diagram used to display the flow of data or energy. For example, it can show the traffic of users from one page to another, or the energy transfer between different parts within a system. Through a Sankey diagram, you can quickly understand the flow and distribution of data.

![](../img/sankey.png)

## Chart Query

- Size: Queries for metrics, logs, events, and other data.

- Nodes: By default, two options are displayed; you can select from a dropdown or press Enter to create custom nodes. Up to 6 nodes can be added; you can drag to adjust the order of nodes.

## Chart Configuration

> For more details, refer to [Chart Configuration](./chart-config.md).


<!--
## Common Configuration

| Option | Description |
| --- | --- |
| Title | Set a title for the chart, which will be displayed in the top-left corner of the chart after setting. It supports hiding. |
| Description | Add a description to the chart. After setting, an [i] prompt will appear after the chart title. If not set, it will not be displayed. |
| Unit | **:material-numeric-1-box: Default unit display**: <br /><li>If the queried data is metric data and you have set units for the metric in [Metric Management](../../metrics/dictionary.md), it will default to displaying using the metric's unit.<br /><li>If no related unit configuration exists in **Metric Management**, it will display with thousand separators as the numerical increment format.<br />**:material-numeric-2-box: After configuring the unit**: <br />It prioritizes displaying using your custom-configured unit. For metric data, two options are provided for numerical increments:<br /><br />**Scientific Notation Explanation**<br /><u>Default Increment</u>: Units are ten thousand, million, e.g., 10000 displays as 1 ten thousand, 1000000 displays as 1 million. Two decimal places are retained;<br /><u>Short Scale</u>: Units are K, M, B. That is, thousand, million, billion, trillion, etc., sequentially representing thousand, million, billion, trillion, etc., in Chinese context. For example, 1000 is 1k, 10000 is 10k, 1000000 is 1 million; two decimal places are retained. |
| Color | You can set the font color and background color for the chart. |
| Alias | Refer to [Alias](./timeseries-chart.md#legend). |
| Data Format | You can choose the number of decimal places and whether to use thousand separators.<br /><li>Thousand separators are enabled by default. When disabled, the original value is displayed without separators. More details can be found in [Data Thousand Separator Formatting](../visual-chart/chart-query.md#thousand). |

## Advanced Configuration

| Option | Description |
| --- | --- |
| Lock Time | Fix the time range for querying data in the current chart, independent of the global time component. After setting, the user-defined time will appear in the top-right corner of the chart, such as 【xx minutes】、【xx hours】、【xx days】. |
| Time Slicing | When time slicing is enabled, it first segments and aggregates the original data at certain time intervals, then performs a second aggregation on the aggregated dataset to obtain the result value. It is off by default.<br /><br />If time slicing is off, there are no time interval options; if it is on, the time interval options are as follows:<br /><li>Auto Align: When enabled, it dynamically adjusts queries based on the selected time range and aggregation interval, rounding up to the nearest time interval.<br /> &nbsp; &nbsp; &nbsp;The system presets multiple time intervals: 1 millisecond, 10 milliseconds, 50 milliseconds, 100 milliseconds, 500 milliseconds, 1 second, 5 seconds, 15 seconds, 30 seconds, 1 minute, 5 minutes, 10 minutes, 30 minutes, 1 hour, 6 hours, 12 hours, 1 day, 1 week, 1 month;<br /><li>Custom Time Interval: When selecting 【Lock Time】, it automatically matches different available time intervals based on the length of the locked time for query display (*for example, if the time interval is chosen as 1 minute, the actual query will be conducted every 1 minute*).<br /><br /><br />For more details, refer to [Time Slicing Explanation](chart-query.md#time-slicing). |
| Field Mapping | Works with object mapping features of view variables. It is off by default. If object mapping has been configured in view variables:<br /><li>When field mapping is enabled, the chart displays the **grouping fields** and corresponding **mapped fields**; grouping fields without specified mappings are not displayed;<br /><li>When field mapping is disabled, the chart displays normally without showing mapped fields.<br /> |
| Workspace Authorization | Authorized workspace lists. After selection, it allows querying and displaying data from the authorized workspace through the chart. |
| Data Sampling | Only for workspaces using the Doris log data engine; when enabled, it samples all data except "metrics," with a non-fixed sampling rate that dynamically adjusts based on data volume. |
| Time Offset | Non-time series data may have at least a 1-minute delay after being stored in the database. When selecting relative time queries, this may cause recent data not to be collected, leading to data loss.<br />Enabling time offset ensures that when querying relative time ranges, the actual query time range shifts forward by 1 minute to prevent data retrieval from being empty due to storage delays. For example, if it is currently 12:30 and you query the last 15 minutes of data, enabling time offset means the actual query time is 12:14-12:29.<br />:warning: <br /><li>This setting only applies to relative time queries. If the query time range is an "absolute time range," the time offset does not apply.<br /><li>For charts with time intervals, like time series charts, time offset only applies if the set time interval is <= 1 minute. For charts without time intervals, such as summary charts and bar charts, the time offset remains effective.
-->