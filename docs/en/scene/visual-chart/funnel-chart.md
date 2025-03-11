# Funnel Chart
---

A funnel chart is generally suitable for process analysis that has standardization, a long cycle, and multiple stages. By comparing data at each stage through the funnel chart, problems can be intuitively identified.

**Note**: The funnel chart query conditions are limited to a maximum of 4 selections.

![](../img/filter.png)

## Use Cases

It can be used to compare data at various stages of a process. For example, a funnel chart is applicable for website business process analysis, showing the final conversion rate from when users enter the site to making a purchase, as well as the conversion rate at each step.

## Chart Configuration

> For more details, refer to [Chart Configuration](./chart-config.md).


<!--
## Common Configuration

| Option | Description |
| --- | --- |
| Title | Set a title for the chart, which will be displayed in the top-left corner of the chart after setting. It supports being hidden. |
| Description | Add a description to the chart; after setting it, an [i] prompt will appear after the chart title. If not set, it will not be displayed. |
| Color | Set the display color of the chart data. |
| Alias | <li>Support adding aliases to grouped queries; after adding an alias, the legend name changes accordingly, making it easier to distinguish related metrics;<br/><li>Support custom manual input of preset aliases, with the format: aggregation function (metric){"label": "label value"}, such as `last(usage_idle){"host": "guance_01"}`. |
| Data Format | You can choose the number of decimal places and whether to use thousand separators.<br /><li>The thousand separator is enabled by default; if disabled, the original value without any separators will be shown. For more details, refer to [Data Thousand Separator Formatting](../visual-chart/chart-query.md#thousand). |

## Advanced Configuration

| Option | Description |
| --- | --- |
| Lock Time | This fixes the time range for querying current chart data, independent of the global time component. After successful setup, the user-defined time will appear in the top-right corner of the chart, e.g., [xx minutes], [xx hours], [xx days]. |
| Time Slicing | When time slicing is enabled, the original data is first segmented and aggregated based on a certain time interval, and then the resulting dataset is aggregated again to obtain the final result value. By default, this is turned off.<br /><br />If time slicing is disabled, there is no time interval option; if enabled, the time interval options are:<br /><li>Auto-align: After enabling, the query adjusts dynamically based on the selected time range and aggregation interval, rounding up to the nearest higher value.<br /> &nbsp; &nbsp; &nbsp;The system presets various time intervals: 1 millisecond, 10 milliseconds, 50 milliseconds, 100 milliseconds, 500 milliseconds, 1 second, 5 seconds, 15 seconds, 30 seconds, 1 minute, 5 minutes, 10 minutes, 30 minutes, 1 hour, 6 hours, 12 hours, 1 day, 1 week, 1 month;<br /><li>Custom Time Interval: When selecting [Lock Time], different selectable time intervals are automatically matched based on the locked time length for displaying data. (*For example, if the time interval is set to 1 minute, the actual query will be made every 1 minute*).<br /><br /><br />For more details, refer to [Time Slicing Explanation](chart-query.md#time-slicing). |
| Workspace Authorization | Lists authorized workspaces; after selection, the chart can query and display data from these workspaces. |
| Data Sampling | Only for Doris log data engine workspaces; when enabled, it samples all data except Metrics, with a non-fixed sampling rate that adjusts dynamically based on data volume. |
| Time Offset | Non-time series data have at least a 1-minute delay after being stored. When using relative time queries, this may cause recent data not to be collected, leading to missing data.<br />Enabling time offset shifts the actual query time range forward by 1 minute when querying relative time ranges, preventing data retrieval issues due to storage delays. For example, if it's currently 12:30 and you query the last 15 minutes of data, with time offset enabled, the actual queried time range is 12:14-12:29.<br />:warning: <br /><li>This setting only applies to relative time queries; if the time range is an absolute time range, time offset does not apply.<br /><li>For charts with time intervals, such as time series charts, if the set time interval exceeds 1 minute, time offset does not apply; it only applies if the interval is <= 1 minute. For charts without time intervals, such as overview charts or bar charts, time offset remains effective.|
-->