# Overview Chart
---

The overview chart clearly displays a critical numerical value or metric result and supports displaying mixed line charts to help understand the trend of the metrics.

![](../img/overview.png)

## Use Cases

1. Intuitively display data result values;  
2. View a key data point, such as: RUM PV / UV.

## Chart Configuration

> For more details, refer to [Chart Configuration](./chart-config.md).

### Year-over-Year and Month-over-Month Comparison

This involves comparing with data from the same period in the previous time frame; it is turned off by default. If there is a data gap within the comparison time range, it will directly show as N/A, for example: week-over-week N/A.


#### Comparison Dimensions

When enabled, the comparison dimensions support the following options:

- Hour (compared to one hour ago)
- Day (compared to one day ago)
- Week (compared to one week ago)
- Month (compared to one month ago)
- Month-over-Month

#### Comparison Logic

Below the value in the overview chart, the **increase/decrease percentage** will be displayed.

The percentage calculation is: (current query result - comparison query result) / comparison query result * 100%.

#### Example

| Dimension | Comparison Query Logic | Current Query Time Range | Comparison Query Time Range | Percentage Display |
| --- | --- | --- | --- | --- |
| Hour | Shift back **1h** | 【1h】3/2 10:00-3/2 11:00 | 3/2 09:00 - 3/2 10:00 | Compared to one hour ago xx% ⬆ |
| | | **Today/Yesterday/Last Week/This Week/This Month/Last Month** | **No Comparison** | **None** |
| Day | Shift back **24h** | 【1h】3/2 10:00-3/2 11:00 | 3/1 10:00 - 3/1 11:00 | Day-over-day xx% ⬆ |
| | | 【Today】3/2 00:00:00 - current time | 3/1 00:00:00 - 23:59:59 | Day-over-day xx% ⬆ |
| | | **Last Week/This Week/This Month/Last Month** | **No Comparison** | **None** |
| Week | Shift back **7d** | 【1h】3/2 10:00 - 3/2 11:00 (Wednesday) | 2/23 10:00 - 2/23 11:00 (last Wednesday) | Week-over-week xx% ⬆ |
| | | 【Today】3/2 00:00 - 3/2 11:00 (Wednesday) | 2/23 00:00:00-23:59:59 (all day last Wednesday) | Week-over-week xx% ⬆ |
| | | 【This Week】2/28 00:00 - current time (Monday to Wednesday) | 2/21 00:00:00 - 2/27 23:59:59 (entire last week) | Week-over-week xx% ⬆ |
| | | **This Month/Last Month** | **No Comparison** | **None** |
| Month | Shift back **1mo** | 【3d】3/2 10:00 - 3/5 10:00 | 2/2 10:00 - 2/5 10:00 | Month-over-month xx% ⬆ |
| | | 【Today】3/2 00:00:00 - current time | 2/2 00:00:00 - 23:59:59 (all day 2nd of last month) | Month-over-month xx% ⬆ |
| | | 【This Month】3/1 00:00:00-current time | 2/1 00:00:00 - 2/28 23:59:59 (entire last month) | Month-over-month xx% ⬆ |
| | | 【3d】3/26 10:00 - 3/29 10:00 | 2/26 10:00 - 2/28 23:59:59 (since February has no 29th) | Month-over-month xx% ⬆ |
| | | **Last Week/This Week** | **No Comparison** | **None** |
| | | **【1d】3/29 10:00 - 3/30 10:00**| **No Comparison (February has no 29th or 30th)** | **None** |

### Mixed Chart

When enabled, you can choose to display an area chart or bar chart simultaneously in the current chart to help query both the current metric value and its trend.

You can also optionally select the display of the chart axes.

![](../img/overview-1.png)

<!--
## Chart Query

Chart queries support **simple queries**, **expression queries**, **DQL queries**, and **PromQL queries**; the default is simple query.

> For more detailed explanations of chart query conditions, refer to [Chart Query](chart-query.md).

**Note**:

- A single chart query only supports one query statement, defaulting to **simple query**. Clicking **Convert to Expression Query** switches to expression query, converting the simple query into "Query A", supporting mutual switching. **DQL query** applies similarly.
- If conversion functions not supported by expression queries are used in simple queries, they will not be carried over when switching to expression queries.

## Chart Links

Links can help you jump from the current chart to a target page. You can add internal platform links or external links, and modify the corresponding variable values in the link using template variables to pass data information, achieving data linkage.

> For more related settings, refer to [Chart Links](chart-link.md).

## Common Configurations

| Option | Description |
| --- | --- |
| Title | Set a title for the chart. After setting, it will appear in the top-left corner of the chart, with the option to hide it. |
| Description | Add a description to the chart. After setting, an [i] hint will appear after the chart title if set; otherwise, it will not be displayed. |
| Unit | **:material-numeric-1-box: Default unit display**: <br /><li>If the queried data is a metric and you have set units for the metric in [Metric Management](../../metrics/dictionary.md), it will default to displaying according to the metric's unit.<br /><li>If no unit configuration exists in **Metric Management**, it will display using thousand separator notation.<br />**:material-numeric-2-box: After configuring units**: <br />Priority is given to your custom configured units for display. Metric data supports two options:<br /><br />**Scientific Notation Explanation**<br /><u>Default progression</u>: Units are ten thousand, million, e.g., 10000 is shown as 1 ten thousand, 1000000 as 1 million, retaining two decimal places;<br /><u>Short scale</u>: Units are K, M, B. That is, thousand, million, billion, trillion, etc., representing thousand, million, billion, trillion, etc. in Chinese context. For example, 1000 is 1k, 10000 is 10k, 1000000 is 1M; retaining two decimal places.|
| Color | Set font color and background color for the chart. |
| Data Format | Choose the number of decimal places and the thousand separator.<br /><li>The thousand separator is enabled by default. When disabled, the original value without separators will be displayed. More details can be found in [Data Thousand Separator Format](../visual-chart/chart-query.md#thousand). |

## Advanced Configuration

| Option | Description |
| --- | --- |
| Rule Mapping | <li>Set the metric range and corresponding background color, font color. Metrics within the range will display according to the set style.<br /><li>Set the metric range and mapping values. When the metric falls within the set range, it will display the corresponding mapped value.<br /><li>When multiple settings are met, the last matching setting will be displayed.<br /><br />When setting value mappings, neither the "Display As" nor the "Color" fields are mandatory:<br />&nbsp; &nbsp; &nbsp;"Display As" defaults to empty, meaning no mapping value display;<br />&nbsp; &nbsp; &nbsp;"Color" defaults to empty, meaning no color mapping, showing the original color.<br /> |
| Lock Time | Fix the time range for querying data in the current chart, unaffected by the global time component. After successful setup, the user-defined time will appear in the top-right corner of the chart, such as 【xx minutes】, 【xx hours】, 【xx days】. |
| Time Slicing | When enabled, the original data is first segmented and aggregated based on a certain time interval, then the second aggregation is performed on the aggregated dataset to get the final result, defaulting to off.<br /><br />If time slicing is off, there is no time interval option; if enabled, the time interval options are:<br /><li>Auto-align: When enabled, it dynamically adjusts the query based on the selected time range and aggregation interval, rounding up to the nearest higher interval.<br /> &nbsp; &nbsp; &nbsp;The system presets various time intervals: 1 millisecond, 10 milliseconds, 50 milliseconds, 100 milliseconds, 500 milliseconds, 1 second, 5 seconds, 15 seconds, 30 seconds, 1 minute, 5 minutes, 10 minutes, 30 minutes, 1 hour, 6 hours, 12 hours, 1 day, 1 week, 1 month;<br /><li>Custom time interval: When selecting 【Lock Time】, different selectable time intervals automatically match based on the length of the locked time. (*For example, if the time interval is chosen as 1 minute, the actual query will use a 1-minute interval*).<br /><br /><br />For more details, refer to [Time Slicing Explanation](chart-query.md#time-slicing). |

| Workspace Authorization | The list of authorized workspaces. After selection, you can query and display data from these workspaces through the chart. |
| Data Sampling | Only applicable to Doris log data engine workspaces; when enabled, it samples all data except "metrics". The sampling rate is dynamic based on data volume. |
| Time Offset | Non-time series data may have at least a 1-minute delay after being stored. When selecting relative time queries, this might cause recent data to be missed, leading to data loss.<br />Enabling time offset shifts the actual query time range forward by 1 minute to prevent data retrieval issues due to storage delays. For example, if the current time is 12:30 and you query the last 15 minutes of data, enabling time offset means the actual query time is 12:14-12:29.<br />:warning: <br /><li>This setting only applies to relative time ranges. If the query time range is an "absolute time range," time offset does not apply.<br /><li>For charts with time intervals, like time series charts, time offset does not apply if the interval exceeds 1 minute. It only applies if the interval is <= 1 minute. For charts without time intervals, like overview charts and bar charts, time offset remains effective.|

-->