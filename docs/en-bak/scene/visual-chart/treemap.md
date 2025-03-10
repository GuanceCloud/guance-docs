# Rectangular Tree Diagram
---

## Introduction

It is used to visualize the percentage distribution of metric data under different groupings.

## Use Case

The rectangular tree diagram of the Guance is used to show the percentage distribution of metrics data under different groupings. For example, you can view the CPU usage of different hosts.

## Chart Search

Chart query supports 「simple query」, 「expression query」 and 「DQL query」, please click [chart-query](chart-query.md) for detailed explanation of chart query conditions, simple query is added by default. You can add multiple queries, but the Tag of by (grouping) must be the same, modify one, and the other will be modified automatically.

The chart query selects the color by the value of the selected query metric, as described below.

| Options | Description |
| --- | --- |
| Metrics | Color indicates grouped tags (Tags), and area indicates metric data. When multiple metric queries are added, you can select the main metric to display, and the area size is displayed according to the selected metric data results, Top/Bottom and quantity. |

## Chart Linking

Links can help you jump from the current chart to the target page, support adding internal links and external links to the platform, and support modifying the corresponding variable values in the links through template variables to transfer the data information to complete the data linkage. Please click [chart-link](chart-link.md) to view the related settings.
## Chart Style
| Options | Description |
| --- | --- |
| Title | Set the title for the chart, after setting, it will be displayed on the top left of the chart, support hiding
| color | set the display color of the chart data, support custom manual input preset color, input format is: aggregation function(metric){"label": "label value"}, such as `last(usage_idle){"host": "guance_01"}` |


## Chart Settings

### Basic Settings
| Options | Description |
| --- | --- |
| Units | 1. Support setting units for query results.<br />1）If the queried data has no unit, after setting the unit in the chart, it will be displayed on the chart according to the set unit<br />2）If the query data comes with its own units, or if you are in [Metric Management] (../../metrics/dictionary.md), and you set the units for the metrics in the chart, the units set in the chart will be displayed on the chart.<br />3）If the query data has no units and no units are set in the chart, the chart Y-axis values are automatically calculated according to scientific notation; the original values are displayed on the chart in the format [thousandths] (chart-query.md#thousand).<br /> **Scientific counting instructions**<br />Default query result value is automatically converted to units, display follows 「scientific notation K, M, B」 (1 thousand = 1K, 1 million = 1M, 1 billion = 1B), retaining two decimal points; RMB is automatically converted to units 「yuan, million, billion」, retaining two decimal points<br />*For example, if the unit of time interval is selected as ns, then according to the size of the data, the query result will only automatically convert the unit effect as follows, and so on：*<br /><li>1000000ns：Chart query data results in 1ms<br /><li>1000000000ns：The chart query data result shows 1s<br /><li>10000000000ns：The chart query data result shows 1m<br /><br/>2. support for the query results preset units, manual input format: aggregation function (metric), such as `last(age_idle)` |

### Advanced Settings
| Options | Description |
| --- | --- |
| Time Slicing | When time slicing is enabled, the original data will be aggregated in segments at certain time intervals, and then the aggregated data set will be aggregated for the second time to get the result value, which is disabled by default. For details, please refer to [time slicing description](chart-query.md#time-slicing) |
| Lock Time | Support to lock the time range of chart query data, not limited by the global time component. The time set by the user will appear in the upper right corner of the chart after successful setup, such as 【xx minutes】, 【xx hours】, 【xx days】. If you lock the time interval of 30 minutes, then when you adjust the time component, no matter what time range view is queried, only the last 30 minutes data will be displayed. |
| Time interval | If time slice is off, there is no time interval option, if time slice is on, the time interval option is as follows：<br /><li>Original interval: default query to display data according to the time range of the time component<br /><li>Auto-alignment: When turned on, the query will be dynamically adjusted according to the selected time range and aggregation interval, rounded up according to the calculated time interval. (For example, if the automatic aggregation algorithm calculates the time interval to be 50 seconds, then the actual query will be launched according to the time interval of 1 minute) The system presets 1 ms, 10 ms, 50 ms, 100 ms, 500 ms, 1 second, 5 seconds, 15 seconds, 30 seconds, 1 minute, 5 minutes, 10 minutes, 30 minutes, 1 hour, 6 hours, 12 hours, 1 day, 1 week, 1 month, and many time interval.<br /><li>Custom time interval: When 【Lock time】 is selected, according to the length of the lock time, different optional time intervals will be automatically matched to query the displayed data. (For example, if you select 1 minute as the time interval, the query will actually be launched at the interval of 1 minute)<br /> |
| Field Mapping | Object mapping with view variables, default is off, if object mapping is configured in view variables：<br /><li>When field mapping is enabled, the chart displays the 「grouped fields」 of the query and the corresponding 「mapped fields」, and the unmapped grouped fields are not displayed.<br /><li>When field mapping is turned off, the chart is displayed normally, without the mapped fields<br /> |
| Chart Description | Add description information to the chart, after setting the chart title will appear behind the 【i】 prompt, no setting will not be displayed |
| Workspaces | The list of authorized workspaces, you can query and display the workspace data through the chart after you select it. |


## Example Chart

The following figure shows an example of how to view the top 10 CPU usage for different hosts.

![](../img/4.treemap.png)

