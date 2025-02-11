# Summary View
---

The Summary View clearly displays a critical value or Metrics result and supports displaying mixed line charts to help understand the trend of Metrics.

![](../img/overview.png)

## Application Scenarios

1. Intuitively display data result values;
2. View a key data point, such as PV/UV.

## Chart Configuration

> For more details, refer to [Chart Configuration](./chart-config.md).

### Year-over-Year and Month-over-Month Comparison

This refers to comparing with the same period in the previous time frame; it is turned off by default. If there is a data gap within the comparison period, it will directly show as N/A, for example: Week-over-Week N/A.

#### Comparison Dimensions

When enabled, the comparison dimensions support the following options:

- Hour (compared with one hour ago)
- Day (compared with one day ago)
- Week (compared with one week ago)
- Month (compared with one month ago)
- Sequential Comparison

#### Comparison Logic

Below the value in the Summary View, the **Increase/Decrease Percentage** is displayed.

The percentage calculation is: (Current Query Result - Comparison Query Result) / Comparison Query Result * 100%.

#### Examples

| Dimension | Comparison Query Logic | Current Query Time Range | Comparison Query Time Range | Percentage Display |
| --- | --- | --- | --- | --- |
| Hour | Shifted back **1h** | 【1h】3/2 10:00-3/2 11:00 | 3/2 09:00 - 3/2 10:00 | Compared with one hour ago xx% ⬆ |
| | | **Today/Yesterday/Last Week/This Week/This Month/Last Month** | **No Comparison** | **None** |
| Day | Shifted back **24h** | 【1h】3/2 10:00-3/2 11:00 | 3/1 10:00 - 3/1 11:00 | Day-over-Day xx% ⬆ |
| | | 【Today】3/2 00:00:00 - Current Time | 3/1 00:00:00 - 23:59:59 | Day-over-Day xx% ⬆ |
| | | **Last Week/This Week/This Month/Last Month** | **No Comparison** | **None** |
| Week | Shifted back **7d** | 【1h】3/2 10:00 - 3/2 11:00 (Wednesday) | 2/23 10:00 - 2/23 11:00 (Last Wednesday)| Week-over-Week xx% ⬆ |
| | | 【Today】3/2 00:00 - 3/2 11:00 (Wednesday) | 2/23 00:00:00-23:59:59 (All Day Last Wednesday) | Week-over-Week xx% ⬆ |
| | | 【This Week】2/28 00:00 - Current Time (Monday to Wednesday) | 2/21 00:00:00 - 2/27 23:59:59 (Entire Last Week) | Week-over-Week xx% ⬆ |
| | | **This Month/Last Month** | **No Comparison** | **None** |
| Month | Shifted back **1mo** | 【3d】3/2 10:00 - 3/5 10:00 | 2/2 10:00 - 2/5 10:00 | Month-over-Month xx% ⬆ |
| | | 【Today】3/2 00:00:00 - Current Time | 2/2 00:00:00 - 23:59:59 (All Day February 2nd) | Month-over-Month xx% ⬆ |
| | | 【This Month】3/1 00:00:00-Current Time | 2/1 00:00:00 - 2/28 23:59:59 (Entire Last Month) | Month-over-Month xx% ⬆ |
| | | 【3d】3/26 10:00 - 3/29 10:00 | 2/26 10:00 - 2/28 23:59:59 (Since February does not have 29th or 30th) | Month-over-Month xx% ⬆ |
| | | **Last Week/This Week** | **No Comparison** | **None** |
| | | **【1d】3/29 10:00 - 3/30 10:00**| **No Comparison (February does not have 29th or 30th)** | **None** |

### Mixed Chart

When enabled, you can choose to display an area chart or bar chart simultaneously in the current chart to help query both the current Metrics value and the trend of Metrics.

You can also select whether to show the chart axes as needed.

![](../img/overview-1.png)

<!--
## Chart Query

Chart queries support **Simple Query**, **Expression Query**, **DQL Query**, and **PromQL Query**; by default, a simple query is added.

> For more detailed explanations of chart query conditions, refer to [Chart Query](chart-query.md).

**Note**:

- A single chart query only supports one query statement, which defaults to **Simple Query**. Clicking **Convert to Expression Query** switches to expression query mode, treating the simple query as "Query A," supporting mutual switching. The same applies to **DQL Query**.
- If conversion functions used in the simple query are not supported in expression queries, they will not be carried over after switching.

## Chart Link

Links can help you navigate from the current chart to a target page. You can add internal platform links or external links, modifying the corresponding variable values in the link using template variables to pass data information, achieving data linkage.

> For more related settings, refer to [Chart Link](chart-link.md).

## Common Configurations

| Option | Description |
| --- | --- |
| Title | Set a title for the chart, which appears in the top-left corner of the chart. It supports hiding the title. |
| Description | Add a description to the chart. After setting, an [i] icon will appear after the chart title, showing the description when hovered over. If not set, no icon is displayed. |
| Unit | **:material-numeric-1-box: Default Unit Display**: <br /><li>If the queried data is Metrics data and units are configured in [Metrics Management](../../metrics/dictionary.md), it will use the configured units for display;<br /><li>If no unit is configured in **Metrics Management**, it will display with thousand separators.<br />**:material-numeric-2-box: After configuring units**: <br />It prioritizes using your custom-defined units for display. Metric data supports two options:<br /><br />**Scientific Notation Explanation**<br /><u>Default Scaling</u>: Units are ten thousand, million, etc., e.g., 10000 is shown as 1 ten thousand, 1000000 as 1 million. Two decimal places retained;<br /><u>Short Scale</u>: Units are K, M, B. That is, thousand, million, billion, trillion, etc. E.g., 1000 is 1K, 10000 is 10K, 1000000 is 1M; two decimal places retained.|
| Color | Customize font color and background color for the chart. |
| Data Format | Choose the number of decimal places and thousands separator.<br /><li>The thousands separator is enabled by default. Disabling it shows the original value without separators. More details at [Data Thousand Separator Format](../visual-chart/chart-query.md#thousand). |

## Advanced Configurations

| Option | Description |
| --- | --- |
| Rule Mapping | <li>Set the range for Metrics and corresponding background and font colors. Metrics within the range will be displayed according to the set style;<br /><li>Set the range for Metrics and mapping values. When the metric value falls within the set range, it will display the mapped value;<br /><li>When multiple settings are met, the last matching condition's style will be applied.<br /><br />When setting value mappings, neither **Display As** nor **Color** are required fields:<br />&nbsp; &nbsp; &nbsp;**Display As** defaults to empty, meaning no mapping display;<br />&nbsp; &nbsp; &nbsp;**Color** defaults to empty, meaning no color change.<br /> |
| Lock Time | Fix the time range for querying data in the current chart, independent of global time components. After setting, the chart's top-right corner will display the user-set time, like 【xx minutes】, 【xx hours】, 【xx days】. |
| Time Slicing | When enabled, the original data is first segmented and aggregated based on a certain time interval, then the aggregated dataset undergoes secondary aggregation to obtain the result value. By default, this is disabled.<br /><br />If time slicing is disabled, there are no time interval options; if enabled, the time interval options are:<br /><li>Automatic Alignment: When enabled, the query dynamically adjusts based on the selected time range and aggregation interval, rounding up to the nearest higher interval.<br /> &nbsp; &nbsp; &nbsp;The system presets various intervals: 1 millisecond, 10 milliseconds, 50 milliseconds, 100 milliseconds, 500 milliseconds, 1 second, 5 seconds, 15 seconds, 30 seconds, 1 minute, 5 minutes, 10 minutes, 30 minutes, 1 hour, 6 hours, 12 hours, 1 day, 1 week, 1 month;<br /><li>Custom Time Interval: When selecting **Lock Time**, different optional time intervals are automatically matched based on the locked time length. (*For example, choosing a 1-minute interval means queries will be made every 1 minute*)<br /><br /><br />More details at [Time Slicing Explanation](chart-query.md#time-slicing). |

| Workspace Authorization | Lists authorized workspaces. After selection, you can query and display data from these workspaces. |
| Data Sampling | Only applicable to Doris log data engine workspaces; when enabled, it samples data other than "Metrics," with dynamic sampling rates based on data volume. |
| Time Offset | Non-time-series data has at least a 1-minute delay after being stored. Selecting relative time queries may cause recent data to be missed, leading to data loss.<br />Enabling time offset shifts the actual query time forward by 1 minute when querying relative time ranges, preventing data gaps due to storage delays. For example, at 12:30, querying the last 15 minutes of data would actually query from 12:14 to 12:29.<br />:warning: <br /><li>This setting only affects relative time queries. For absolute time ranges, time offset does not apply.<br /><li>For charts with time intervals, such as time series charts, time offset does not apply if the interval exceeds 1 minute. For charts without intervals, like Summary Views and bar charts, time offset remains effective.|

-->