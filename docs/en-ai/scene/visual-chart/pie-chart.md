# Pie Chart
---

Generally used to represent the comparison of data groups.

Chart types include:

- Pie Chart: Displays the comparison of data groups, more suitable for scenarios with fewer sample metrics;   
- Doughnut Chart: More suitable for reflecting the proportions of various parts in multiple sample metrics;    
- Rose Chart: The size of the arc radius indicates the magnitude of the data, suitable for scenarios with too many categories and similar value proportions.

![](../img/pie.png)


## Chart Configuration

> For more details, refer to [Chart Configuration](./chart-config.md).

### Merge Data Items

If there are too many slices in the pie chart with a very small proportion of data, you can merge the data into an "Other" slice to prioritize viewing higher priority slices, improving the readability of the pie chart.

After configuring the merge, a new "Other" slice is added to the pie chart, representing the aggregated display of merged data. 

- Before Merging:

<img src="../../img/pie-1.png" width="70%" >

- After Merging:

<img src="../../img/pie-2.png" width="70%" >


<!--
## Chart Query

Chart queries support **Simple Query**, **Expression Query**, **DQL Query**, and **PromQL Query**; by default, a simple query is added. Each query preset returns 5 result counts, including 5, 10, 20, 50, 100, with a default return of 20 data points, supporting manual input up to 100 data points.

> For more detailed conditions of chart queries, refer to [Chart Query](chart-query.md).

## Chart Link

Links help you navigate from the current chart to the target page; internal and external links can be added. You can also modify variables in the link using template variables to pass data information, achieving data联动 (data linkage).

> For more related settings, refer to [Chart Link](chart-link.md).

## Common Configuration

| Option | Description |
| --- | --- |
| Title | Set a title for the chart, which will appear in the top-left corner of the chart after setting, and supports hiding.|
| Description | Add a description to the chart, which will show an [i] prompt after the chart title if set; otherwise, it does not appear. |
| Unit | **:material-numeric-1-box: Default unit display**: <br /><li>If the queried data is metric data and you have set units for metrics in [Metric Management](../../metrics/dictionary.md), it will default to displaying according to the metric's unit.<br /><li>If no relevant unit configuration exists in **Metric Management**, it will display as [thousand separator](chart-query.md#thousand) comma-separated values.<br />**:material-numeric-2-box: After configuring the unit**: <br />It prioritizes displaying with your custom configured unit. Metric data supports two options for numerical values:<br /><br />**Scientific Notation Explanation**<br /><u>Default progression</u>: Units are ten thousand, million, etc., like 10000 displayed as 1 ten thousand, 1000000 displayed as 1 million. Two decimal places retained;<br /><u>Short scale</u>: Units are K, M, B. That is, thousand, million, billion, trillion, etc., in Chinese context. For example, 1000 is 1 k, 10000 is 10 k, 1000000 is 1 million; two decimal places retained.|
| Color | You can set font color and background color for the chart. |
| Legend | For more details, refer to [Legend Description](./timeseries-chart.md#legend). |
| Data Format | You can choose the number of decimal places and the thousand separator.<br /><li>The thousand separator is enabled by default. If disabled, the original value without separators will be displayed. For more details, refer to [Thousand Separator Format](../visual-chart/chart-query.md#thousand). |


## Advanced Configuration

| Option | Description |
| --- | --- |

| Lock Time | This fixes the time range for querying data in the current chart, independent of the global time component. After successful setup, the user-defined time appears in the top-right corner of the chart, such as 【xx minutes】, 【xx hours】, 【xx days】. |
| Time Slice | When enabled, it first segments and aggregates the original data at certain time intervals, then performs a second aggregation on the aggregated dataset to get the final result. By default, this is turned off.<br /><br />If time slicing is disabled, there are no time interval options; if enabled, the time interval options are as follows:<br /><li>Auto-align: When enabled, it dynamically adjusts the query based on the selected time range and aggregation time interval, rounding up to the nearest computed interval.<br /> &nbsp; &nbsp; &nbsp;The system presets multiple time intervals: 1 millisecond, 10 milliseconds, 50 milliseconds, 100 milliseconds, 500 milliseconds, 1 second, 5 seconds, 15 seconds, 30 seconds, 1 minute, 5 minutes, 10 minutes, 30 minutes, 1 hour, 6 hours, 12 hours, 1 day, 1 week, 1 month;<br /><li>Custom time interval: When selecting 【Lock Time】, different selectable time intervals are automatically matched based on the locked time length, displaying data accordingly. (*For example, if the time interval is set to 1 minute, queries will be initiated at 1-minute intervals*).<br /><br /><br />For more details, refer to [Time Slicing Description](chart-query.md#time-slicing). |
| Year-over-Year Comparison | Compares data with the same period in the previous time frame. It defaults to being turned off. After enabling year-over-year comparison, four options are supported: hour (compared to one hour ago), day (compared to one day ago), week (compared to one week ago), month (compared to one month ago).<br />After enabling year-over-year comparison, if there is a data gap within the comparison time range, it directly displays N/A, e.g., week-over-week N/A.<br /><br />Multiple comparison dimensions can be selected. For more details, refer to [Year-over-Year Comparison](time-comparison.md).   |
| Mixed Chart | <li>When enabled, area charts or bar charts can be displayed simultaneously in the chart, helping you understand the trend of metrics while querying current metric values;<br /><li>After enabling, a new line color setting item will be added in the value mapping, and after setting the line color in the value mapping, results that meet the conditions will be displayed in the chart.<br /><br />You can also choose to display axes. |
| Workspace Authorization | Lists authorized workspaces. After selection, data from these workspaces can be queried and displayed via the chart. |
| Data Sampling | Only applies to workspaces using the Doris log data engine; when enabled, sampling queries are performed on all data except "metrics," with a non-fixed sampling rate that dynamically adjusts based on data volume. |
| Time Offset | Non-time series data has at least a 1-minute query delay after being stored. When choosing relative time queries, it may lead to recent minutes' data not being collected, resulting in data loss.<br />Enabling time offset shifts the actual query time range forward by 1 minute when querying relative time ranges, preventing data retrieval from being empty due to storage delays. For example, if it's currently 12:30 and you're querying the last 15 minutes of data, with time offset enabled, the actual query time would be 12:14-12:29.<br />:warning: <br /><li>This setting only applies to relative time ranges. If the query time range is "absolute time range," time offset does not apply.<br /><li>For charts with time intervals, such as time series charts, if the set time interval exceeds 1 minute, time offset does not apply. For charts without time intervals, such as overview charts and bar charts, time offset remains effective.

## Example Chart

The following chart shows the comparison between used disk space and remaining disk space:

![](../img/8.scene_pie_1.gif)

-->