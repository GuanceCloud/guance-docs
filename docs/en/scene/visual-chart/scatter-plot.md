# Scatter Chart
---

## Introduction

The scatter plot represents the general trend of the dependent variable with the independent variable, from which a suitable function can be selected to fit the empirical distribution and thus find the functional relationship between the variables. It can be used to observe the distribution and aggregation of data.

## Use Case

A scatter plot of the Guance is used to see the distribution and aggregation of data. For example, you can see the distribution of CPU system usage and user usage across hosts.

## Chart Search

Please click [chart-query.md](chart-query.md) for detailed explanation of the chart query conditions.Add 「x-axis」 and 「y-axis」 queries by default, without 「Copy」 and 「Delete」 buttons；There is no 「Add Query」 button. The set of metrics and metrics of the query can be different, but the by (grouping) Tag must be the same, and if one is modified, the other is automatically modified simultaneously.

## Chart Links

Links can help you realize jumping from the current chart to the target page, support adding platform internal links and external links, support modifying the corresponding variable values in the links through template variables to transfer data information over and complete data linkage.Please click [chart-link] to view the relevant settings.

## Chart Style
| Options | Description |
| --- | --- |
| Chart Title | 为Set the title name of the chart, after setting, it will be shown on the top left of the chart, support hide |
| Color | Set the chart data display color, support custom manual input preset color, input format: aggregation function (metric) {"label": "label value"}, such as `last(usage_idle){"host": "guance_01"}` |
| Alias | <li>支Add aliases to the grouped queries. After adding aliases, the names of the legends change, making it easier to distinguish related metrics more intuitively.<br/><li>Support custom manual input of preset aliases, input format: aggregation function(metric){"tag": "tag value"}, such as `last(usage_idle){"host": "guance_01"}` |


## Chart Setup

### Basic Settings
| Options | Description |
| --- | --- |
| Unit | 1. Support setting units for query results.<br />1）If the queried data has no unit, after setting the unit in the chart, it will be displayed on the chart according to the set unit<br />2）If the query data comes with its own units, or if you are in [Metric Management] (../../metrics/dictionary.md), and you set the units for the metrics in the chart, the units set in the chart will be displayed on the chart.<br />3）If the query data has no units and no units are set in the chart, the chart Y-axis values are automatically calculated according to scientific notation; the original values are displayed on the chart in the format [thousandths] (chart-query.md#thousand).<br /> **Scientific counting instructions**<br />Default query result value is automatically converted to units, display follows 「scientific notation K, M, B」 (1 thousand = 1K, 1 million = 1M, 1 billion = 1B), retaining two decimal points; RMB is automatically converted to units 「yuan, million, billion」, retaining two decimal points<br />*For example, if the unit of time interval is selected as ns, then according to the size of the data, the query result will only automatically convert the unit effect as follows, and so on：*<br /><li>1000000ns：Chart query data results in 1ms<br /><li>1000000000ns：The chart query data result shows 1s<br /><li>10000000000ns：The chart query data result shows 1m<br /><br/>2.Support for query results preset units, manual input format: aggregation function (metric), such as `last(age_idle)` |

### Advanced Settings
| Options | Description |
| --- | --- |
| Time slice | When time slicing is turned on, the original data will be first aggregated in segments at certain time intervals, and then the aggregated data set will be aggregated a second time to get the result value, which is turned off by default.For details, see [time slicing instructions](chart-query.md#time-slicing) |
| Lock time | Support locking the time range of the chart query data, not limited by the global time component. The time set by the user will appear in the upper right corner of the chart after successful setup, e.g. 【xx minutes】, 【xx hours】, 【xx days】. If the time interval is locked at 30 minutes, then when adjusting the time component, no matter what time range view is queried, only the last 30 minutes of data will be displayed. |
| Time interval | If the time slice is off, there is no time interval option, if the time slice is on, the time interval option is as follows：<br /><li>Original interval: default query to display data according to the time range of the time component<br /><li>Auto-alignment: When turned on, the query will be dynamically adjusted according to the selected time range and aggregation interval, rounded upward according to the calculated time interval in close proximity.（ For example, if the automatic aggregation algorithm calculates the time interval to be 50 seconds, then the actual query will be launched at an interval of 1 minute ）The system is preset with 1 ms, 10 ms, 50 ms, 100 ms, 500 ms, 1 sec, 5 sec, 15 sec, 30 sec, 1 min, 5 min, 10 min, 30 min, 1 hr, 6 hr, 12 hr, 1 day, 1 week, 1 month, and many other time intervals.<br /><li>Custom time interval: When 【Lock time】 is selected, according to the length of the lock time, different optional time intervals will be automatically matched to query the displayed data. (For example, if you select 1 minute as the time interval, the query will actually be launched at 1 minute interval)<br /> |
| Field Mapping | The object mapping function with view variables is off by default, if object mapping is configured in the view variables：<br /><li>When field mapping is enabled, the chart displays the 「grouped fields」 of the query and the corresponding 「mapped fields」, and the unmapped grouped fields are not displayed.<br /><li>关When closing the field mapping, the chart is displayed normally without the mapped fields<br /> |
| Chart Description | Add description information for the chart, after setting the chart title will appear behind the 【i】 prompt, do not set it will not be displayed |
| Workspace | A list of authorized workspaces, which can be queried and displayed via charts after selection |

## Example diagram

The following graph shows the distribution of CPU system usage and user usage by host for the last 15 minutes.

![](../img/sandian.png)

