# Pie Chart
---

Generally used to represent the comparison of data groups.

Chart types include:

- Pie Chart: Displays the comparison of data groups, more suitable for scenarios with fewer sample metrics;   
- Donut Chart: More suitable for reflecting the proportion of each part in multiple sample metrics;    
- Rose Chart: The size of the arc radius represents the magnitude of the data, suitable for scenarios with too many categories and similar value proportions.

![](../img/pie.png)


## Chart Configuration

> For more details, refer to [Chart Configuration](./chart-config.md).

### Merge Data Items

If there are too many slices in the pie chart with a very small percentage, you can merge them into an "Other" slice to prioritize viewing higher priority slices, improving the readability of the pie chart.

After configuring the merge, a new "Other" slice is added to the pie chart, representing the aggregated merged data. 

- Before Merging:

<img src="../../img/pie-1.png" width="70%" >

- After Merging:

<img src="../../img/pie-2.png" width="70%" >


<!--
## Chart Query

Chart queries support **Simple Query**, **Expression Query**, **DQL Query**, and **PromQL Query**; by default, a simple query is added. Each query preset returns 5 result counts, including 5, 10, 20, 50, and 100, with a default return of 20 records, supporting manual input up to 100 records.

> For more detailed explanations of chart query conditions, refer to [Chart Query](chart-query.md).

## Chart Links

Links help you navigate from the current chart to a target page; internal and external links can be added; template variables can modify corresponding variable values in the link to pass data information, achieving data linkage.

> For more related settings, refer to [Chart Links](chart-link.md).

## Common Configurations

| Option | Description |
| --- | --- |
| Title | Set a title name for the chart. Once set, it will display in the top-left corner of the chart and supports hiding.|
| Description | Add a description to the chart. If set, an [i] icon will appear after the chart title; if not set, it will not display. |
| Unit | **:material-numeric-1-box: Default unit display**: <br /><li>If the queried data is metric data and you have configured units for metrics in [Metric Management](../../metrics/dictionary.md), the default display will follow the metric's unit configuration;<br /><li>If no unit is configured in **Metric Management**, it will display using the [thousand separator](chart-query.md#thousand) format.<br />**:material-numeric-2-box: After configuring units**: <br />Priority is given to your custom-defined units for scaling. Metric data supports two options for numerical representation:<br /><br />**Scientific Notation Explanation**<br /><u>Default Scaling</u>: Units are in ten thousand, million, e.g., 10000 displays as 10k, 1000000 displays as 1M. Retains two decimal places;<br /><u>Short Scale</u>: Units are K, M, B. They represent thousand, million, billion, trillion, etc., respectively. For example, 1000 is 1K, 10000 is 10K, 1000000 is 1M; retains two decimal places.|
| Color | You can set font color and background color for the chart. |
| Legend | For more details, refer to [Legend Explanation](./timeseries-chart.md#legend). |
| Data Format | You can choose the number of decimal places and the thousands separator.<br /><li>The thousands separator is enabled by default. When disabled, it shows the original value without separators. For more details, refer to [Data Thousand Separator Formatting](../visual-chart/chart-query.md#thousand). |

## Advanced Configuration

| Option | Description |
| --- | --- |

| Lock Time Range | This locks the time range for querying data in the current chart, unaffected by the global time component. After successful setup, the user-defined time appears in the top-right corner of the chart, such as ["xx minutes"], ["xx hours"], ["xx days"]. |
| Time Slicing | Enabling time slicing segments the original data according to a certain time interval before aggregating the segmented data a second time to obtain the result value. It is disabled by default.<br /><br />If time slicing is disabled, there is no time interval option; if enabled, the time interval options are:<br /><li>Auto Align: When enabled, the query dynamically adjusts based on the selected time range and aggregation interval, rounding up to the nearest appropriate interval.<br /> &nbsp; &nbsp; &nbsp;The system presets multiple time intervals: 1 millisecond, 10 milliseconds, 50 milliseconds, 100 milliseconds, 500 milliseconds, 1 second, 5 seconds, 15 seconds, 30 seconds, 1 minute, 5 minutes, 10 minutes, 30 minutes, 1 hour, 6 hours, 12 hours, 1 day, 1 week, 1 month;<br /><li>Custom Time Interval: When selecting ["Lock Time"], different selectable time intervals are automatically matched based on the locked time duration. (*For example, if the time interval is chosen as 1 minute, the actual query will be made at 1-minute intervals*).<br /><br /><br />For more details, refer to [Time Slicing Explanation](chart-query.md#time-slicing). |
| Year-over-Year Comparison | Compares data with the same period in the previous cycle. By default, it is displayed as off. After enabling year-over-year comparison, four options are supported for comparison dimensions: Hour (compared with one hour ago), Day (compared with one day ago), Week (compared with one week ago), Month (compared with one month ago).<br />After enabling year-over-year comparison, if data is missing within the comparison time range, it directly displays as N/A, e.g., week-over-week N/A.<br /><br />Multiple comparison dimensions can be selected. For more details, refer to [Year-over-Year Comparison](time-comparison.md).   |
| Mixed Chart | <li>Enabling this allows you to choose between displaying an area chart or a bar chart simultaneously in the chart, helping you understand the trend of metrics while querying current metric values;<br /><li>When enabled, a new line color setting item is added to the value mapping. After setting the line color in the value mapping, the data query results that meet the conditions will be displayed in the chart.<br /><br />You can also choose to enable axis display. |
| Workspace Authorization | Authorized workspace list. After selection, the chart can query and display data from the authorized workspace. |
| Data Sampling | Only applicable to workspaces using the Doris log data engine; when enabled, it samples data other than metrics, with a dynamic sampling rate based on data volume. |
| Time Offset | Non-time series data has at least a 1-minute delay after being stored. When choosing relative time queries, this may cause recent minutes of data to not be collected, leading to data loss.<br />Enabling time offset shifts the actual query time range forward by 1 minute when querying relative time ranges to prevent data retrieval from being empty due to storage delays. For example, if the current time is 12:30 and you query the last 15 minutes of data, with time offset enabled, the actual query time would be: 12:14-12:29.<br />:warning: <br /><li>This setting only applies to relative time ranges. If the query time range is an "absolute time range," time offset does not apply.<br /><li>For charts with time intervals, like time series charts, time offset does not apply if the set time interval exceeds 1 minute. For charts without time intervals, like overview charts and bar charts, time offset remains effective.|

## Example Chart

The following chart compares used and remaining disk space:

![](../img/8.scene_pie_1.gif)


-->