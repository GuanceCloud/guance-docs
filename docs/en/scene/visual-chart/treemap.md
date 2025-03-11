# Treemap
---

Used to display the proportion distribution of metrics data under different groups. It can show the proportion of different categories and effectively utilize space, displaying more data compared to pie charts.

![](../img/treemap.png)

## Chart Query

Supports **simple queries**, **expression queries**, **DQL queries**, **PromQL queries**, and **data source queries**.

You can add multiple queries, but the Tag for by (grouping) must be consistent. Modifying one query will automatically synchronize changes to others. Query results preset five return quantities: 5, 10, 20, 50, and 100, with a default return of 20 data points. Manual input is supported, up to a maximum of 100 data points.

> For more detailed explanations of chart query conditions, refer to [Chart Query](chart-query.md).

Chart queries select colors based on the selected metrics values:

- Metrics: Colors represent grouping tags (Tags), and areas represent metrics data. When multiple metrics queries are added, you can choose the primary displayed metric, and the area size is determined by the selected metrics data results, Top/Bottom, and quantity.

## Chart Configuration

> For more details, refer to [Chart Configuration](./chart-config.md).


<!--
## Chart Links

Links can help navigate from the current chart to a target page. You can add internal or external links, and modify link variables using template variables to pass data information, enabling data interactivity.

> For more related settings, refer to [Chart Links](chart-link.md).



## Common Configurations {#ui}

| Option | Description |
| --- | --- |
| Title | Set a title for the chart. After setting, it will be displayed in the top-left corner of the chart, with an option to hide it. |
| Description | Add a description to the chart. After setting, an [i] prompt will appear after the chart title; otherwise, it will not be displayed. |
| Unit | **:material-numeric-1-box: Default unit display**: <br /><li>If the queried data is metrics data and you have set units for the metrics in [Metrics Management](../../metrics/dictionary.md), the default display will follow the metrics' units.<br /><li>If no unit configuration exists in **Metrics Management**, the data will be displayed with thousand separators.<br />**:material-numeric-2-box: After configuring units**: <br />Priority is given to your custom-defined units. For metrics data, two options are provided:<br /><br />**Scientific notation explanation**<br /><u>Default rounding</u>: Units are in ten thousand and million, e.g., 10000 is shown as 10K, 1000000 as 1M. Two decimal places are retained;<br /><u>Short scale</u>: Units are K, M, B. i.e., thousand, million, billion, trillion, etc. For example, 1000 is 1K, 10000 is 10K, 1000000 is 1M; two decimal places are retained.|
| Color | Set the display color for chart data, supporting custom manual input of preset colors. The format is: aggregation function(metrics){"tag": "tag value"}, such as `last(usage_idle){"host": "guance_01"}`. |
| Alias | Refer to [Alias](./timeseries-chart.md#legend). |
| Legend | Includes tags, percentages, and values; multiple selections can be checked. |
| Data Format | Choose the number of decimal places and the thousands separator.<br /><li>The thousands separator is enabled by default. Disabling it will display raw values without separators. More details can be found at [Data Thousand Separator Formatting](../visual-chart/chart-query.md#thousand). |


## Advanced Configuration

| Option | Description |
| --- | --- |
| Lock Time | Fix the time range for the current chart query data, independent of the global time component. After successful setup, the user-defined time will appear in the top-right corner of the chart, such as 【xx minutes】, 【xx hours】, 【xx days】. |
| Time Slicing | When enabled, the original data is segmented and aggregated based on a certain time interval before performing a second aggregation on the aggregated dataset to obtain the result value. By default, this feature is disabled.<br /><br />If time slicing is off, there is no time interval option; if it is on, the time interval options are:<br /><li>Auto-align: When enabled, it dynamically adjusts queries based on the selected time range and aggregation interval, rounding up to the nearest interval.<br /> &nbsp; &nbsp; &nbsp;The system presets various time intervals: 1 millisecond, 10 milliseconds, 50 milliseconds, 100 milliseconds, 500 milliseconds, 1 second, 5 seconds, 15 seconds, 30 seconds, 1 minute, 5 minutes, 10 minutes, 30 minutes, 1 hour, 6 hours, 12 hours, 1 day, 1 week, 1 month;<br /><li>Custom time interval: When selecting 【Lock Time】, the system automatically matches different available time intervals based on the locked time length to query and display data. (*For example, if the time interval is 1 minute, queries will be made at 1-minute intervals*)<br /><br /><br />More details can be found at [Time Slicing Explanation](chart-query.md#time-slicing). |
| Field Mapping | This works with view variable object mapping functions. By default, it is disabled. If object mapping has been configured in view variables:<br /><li>When field mapping is enabled, the chart displays the **grouping fields** and corresponding **mapped fields**, while unmapped grouping fields are not shown;<br /><li>When field mapping is disabled, the chart displays normally without showing mapped fields.<br /> |
| Workspace Authorization | Lists authorized workspaces. After selection, the chart can query and display data from the selected workspace. |
| Data Sampling | Only applicable to Doris log data engine workspaces; when enabled, it samples non-metrics data, with a dynamic sampling rate based on data volume. |
| Time Offset | Non-time series data may have at least a 1-minute delay after being stored. When querying relative time, recent data might not be collected, leading to data loss.<br />Enabling time offset shifts the actual query time range forward by 1 minute when querying relative time intervals, preventing empty data retrieval due to storage delays. For example, if the current time is 12:30 and you query the last 15 minutes of data, enabling time offset will actually query from 12:14 to 12:29.<br />:warning: <br /><li>This setting only applies to relative time queries. If the query time range is an "absolute time range," time offset does not apply.<br /><li>For charts with time intervals, like time series charts, if the set time interval exceeds 1 minute, time offset does not apply; it only applies when <= 1 minute. For charts without time intervals, like summary charts and bar charts, time offset remains effective.|
-->