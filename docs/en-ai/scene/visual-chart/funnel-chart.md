# Funnel Chart
---

A funnel chart is generally suitable for process analysis that has standardization, a long duration, and multiple stages. By comparing data at each stage through the funnel chart, issues can be intuitively identified.

**Note**: The funnel chart query conditions are limited to a maximum of 4 selections.

![](../img/filter.png)

## Application Scenarios

It can be used to compare data at different stages of a process. For example, a funnel chart is suitable for website business process analysis, showing the final conversion rate from user entry to purchase completion, as well as the conversion rate at each step.

## Chart Configuration

> For more details, refer to [Chart Configuration](./chart-config.md).


<!--
## Common Configuration

| Option | Description |
| --- | --- |
| Title | Set a title for the chart. After setting, it will appear in the top-left corner of the chart, with an option to hide it. |
| Description | Add a description to the chart. After setting, an [i] icon will appear after the chart title, which does not show if not set. |
| Color | Set the display color for chart data. |
| Alias | <li>Support adding aliases to grouped queries; after adding an alias, the legend names change accordingly, making it easier to distinguish related metrics;<br/><li>Support custom manual input of preset aliases, format: aggregation function(metric){"label": "label value"}, e.g., `last(usage_idle){"host": "guance_01"}`. |
| Data Format | You can choose the number of decimal places and whether to use a thousand separator.<br /><li>The thousand separator is enabled by default. When disabled, raw values without separators are shown. For more details, refer to [Thousand Separator Formatting](../visual-chart/chart-query.md#thousand). |

## Advanced Configuration

| Option | Description |
| --- | --- |
| Lock Time | Fix the time range for querying data in the current chart, independent of the global time component. After setting, the user-defined time (e.g., [xx minutes], [xx hours], [xx days]) appears in the top-right corner of the chart. |
| Time Slicing | When enabled, the original data is first segmented and aggregated based on a specified time interval, then the resulting dataset is aggregated again to obtain the final result, default is off.<br /><br />If time slicing is off, no time interval options are available; if on, the time interval options are:<br /><li>Auto Align: When enabled, queries dynamically adjust based on selected time ranges and aggregation intervals, rounding up to the nearest interval.<br /> &nbsp; &nbsp; &nbsp;The system presets various time intervals: 1 millisecond, 10 milliseconds, 50 milliseconds, 100 milliseconds, 500 milliseconds, 1 second, 5 seconds, 15 seconds, 30 seconds, 1 minute, 5 minutes, 10 minutes, 30 minutes, 1 hour, 6 hours, 12 hours, 1 day, 1 week, 1 month;<br /><li>Custom Time Interval: When selecting [Lock Time], different selectable time intervals are automatically matched based on the locked time length, displaying data (*for example, if the time interval is set to 1 minute, queries are made every 1 minute*).<br /><br /><br />For more details, refer to [Time Slicing Explanation](chart-query.md#time-slicing). |
| Workspace Authorization | List of authorized workspaces; after selection, the chart queries and displays data from these workspaces. |
| Data Sampling | Applies only to Doris log data engine workspaces; when enabled, non-metric data is sampled, with a dynamic sampling rate based on data volume. |
| Time Offset | Non-time series data may have at least a 1-minute delay after being stored. When selecting relative time queries, this might lead to missing recent data.<br />Enabling time offset shifts the actual query time range forward by 1 minute when querying relative time intervals, preventing data loss due to storage delays. For example, at 12:30, querying the last 15 minutes of data would actually query from 12:14-12:29.<br />:warning: <br /><li>This setting applies only to relative time queries. If the query time range is an absolute time range, time offset does not apply.<br /><li>For charts with time intervals, such as time series charts, time offset only applies if the set time interval is <= 1 minute. For charts without time intervals, like overview or bar charts, time offset remains effective.|
-->