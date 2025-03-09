# Sankey Diagram

A special type of flow diagram used to display the flow of data or energy. For example, it can show traffic from one page to another, or energy transfers between different parts of a system. Through a Sankey diagram, you can quickly understand the flow and distribution of data.

![](../img/sankey.png)

## Chart Query

- Size: Query data such as Metrics, logs, events, etc.

- Nodes: By default, two options are displayed; you can select from the dropdown or press Enter to create custom nodes. Up to 6 nodes can be added; you can drag to adjust the order of nodes.

## Chart Configuration

> For more details, refer to [Chart Configuration](./chart-config.md).


<!--
## Common Configuration

| Option | Description |
| --- | --- |
| Title | Set a title for the chart. Once set, it will appear in the top-left corner of the chart, with an option to hide it. |
| Description | Add a description to the chart. Once set, an [i] icon will appear after the chart title; if not set, it will not be displayed. |
| Unit | **:material-numeric-1-box: Default unit display**:<br /><li>If the queried data is Metrics data and you have configured units in [Metrics Management](../../metrics/dictionary.md), the units will be displayed according to the Metrics configuration;<br /><li>If no related unit is configured in **Metrics Management**, the value will be displayed using thousand separators.<br />**:material-numeric-2-box: After configuring units**:<br />The chart will prioritize displaying values using your custom units. For Metrics data, two options are available:<br /><br />**Scientific Notation Explanation**<br /><u>Default Scaling</u>: Units are in ten thousand, million, etc., e.g., 10000 is shown as 10K, 1000000 as 1M. Two decimal places are retained.<br /><u>Short Scale</u>: Units are K, M, B. They represent thousand, million, billion, trillion, etc. For example, 1000 is 1K, 10000 is 10K, 1000000 is 1M; two decimal places are retained.|
| Color | Set font color and background color for the chart. |
| Alias | Refer to [Alias](./timeseries-chart.md#legend). |
| Data Format | Choose the number of decimal places and whether to use thousand separators.<br /><li>Thousand separators are enabled by default. If disabled, the original value without separators will be displayed. For more details, refer to [Data Thousand Separator Format](../visual-chart/chart-query.md#thousand). |

## Advanced Configuration

| Option | Description |
| --- | --- |
| Lock Time | Fix the time range for the current chart query data, unaffected by the global time component. After setting successfully, the user-defined time (e.g., "xx minutes", "xx hours", "xx days") will appear in the top-right corner of the chart. |
| Time Slicing | When enabled, it segments the original data based on a certain time interval before aggregating the segmented data a second time to get the result value. It is disabled by default.<br /><br />If time slicing is off, there is no time interval option; if it is on, the time interval options are as follows:<br /><li>Automatic Alignment: When enabled, it dynamically adjusts queries based on the selected time range and aggregation interval, rounding up to the nearest interval.<br /> &nbsp; &nbsp; &nbsp;The system presets multiple time intervals: 1 millisecond, 10 milliseconds, 50 milliseconds, 100 milliseconds, 500 milliseconds, 1 second, 5 seconds, 15 seconds, 30 seconds, 1 minute, 5 minutes, 10 minutes, 30 minutes, 1 hour, 6 hours, 12 hours, 1 day, 1 week, 1 month;<br /><li>Custom Time Interval: When "Lock Time" is selected, different time intervals are automatically matched based on the locked time length for querying and displaying data. (*For example, if the time interval is set to 1 minute, the actual query will be made at 1-minute intervals*).<br /><br /><br />For more details, refer to [Time Slicing Explanation](chart-query.md#time-slicing). |
| Field Mapping | Used with the object mapping function of view variables. It is disabled by default. If object mapping is configured in view variables:<br /><li>When field mapping is enabled, the chart displays **grouped fields** and corresponding **mapped fields**; unmapped grouped fields are not displayed;<br /><li>When field mapping is disabled, the chart displays normally without showing mapped fields.<br /> |
| Workspace Authorization | Authorized workspace list. After selection, the chart can query and display data from the authorized workspace. |
| Data Sampling | Applies only to workspaces using the Doris log data engine; when enabled, it samples non-Metrics data, with a dynamic sampling rate based on data volume. |
| Time Offset | Non-time series data has at least a 1-minute query delay after being stored. When selecting relative time queries, this may cause recent data not to be collected, leading to data loss.<br />Enabling time offset shifts the actual query time range forward by 1 minute to prevent data retrieval issues due to storage delays. For example, if the current time is 12:30 and you query the last 15 minutes of data, enabling time offset will query the period from 12:14 to 12:29.<br />:warning: <br /><li>This setting applies only to relative time queries. If the query time range is an "absolute time range," time offset does not apply.<br /><li>For charts with time intervals, such as time series charts, time offset only applies if the time interval is <= 1 minute. For charts without time intervals, such as summary charts and bar charts, time offset remains effective.
-->