# Table Chart
---

## Introduction

Tables feature a visual display of statistical information attributes, while reflecting the relationships between data. Default grouping display.

## Use Case

The tabular chart of the guance is used to visualize the properties of statistical information. For example, you can view information about the top 10 CPU usage rates of different hosts in your workspace.

## Graph query

The chart query supports 「simple query」 and can be switched to 「DQL query」. Please click [chart-query](chart-query.md) for detailed explanation of the chart query conditions.

Attention.

- Support adding multiple queries, but the grouped labels must be the same, modify one, the other is automatically modified synchronously.
- Support sorting by metrics, sort by metrics of the first query by default, click on the table header to switch the ascending and descending order, corresponding to the Top/Bottom of the query to adjust synchronously, click on the metrics of other queries to sort, corresponding to the Top/Bottom of the query to adjust synchronously.

## Chart Linking

Links can help you jump from the current chart to the target page, support adding internal links and external links to the platform, and support modifying the corresponding variable values in the links through template variables to transfer data information over and complete data linkage.Please click [chart-link](chart-link.md) to view the relevant settings.
## Chart Style
| Options | Description |
| --- | --- |
| Chart Title | Set the title name for the chart, after setting, it will be displayed on the top left of the chart, support hide |
| Alias | <li>Supports adding aliases to grouped queries, including metrics and groups. After adding an alias, the name of the legend changes, making it easier to distinguish related metrics more intuitively.<br><li>Support custom manual input of preset aliases：<br>Metric: input format is: aggregation function (metric/attribute), e.g. `last(usage_idle)`<br>Grouping: input format is: label, e.g. `host` |


## Chart Setup

### Basic Settings
| Options | Description |
| --- | --- |
| Units | 1. Support setting units for query results.<br />1）If the queried data has no unit, after setting the unit in the chart, it will be displayed on the chart according to the set unit<br />2）If the query data comes with its own units, or if you are in [Metric Management] (../../metrics/dictionary.md), and you set the units for the metrics in the chart, the units set in the chart will be displayed on the chart.<br />3）If the query data has no units and no units are set in the chart, the chart Y-axis values are automatically calculated according to scientific notation; the original values are displayed on the chart in the format [thousandths] (chart-query.md#thousand).<br /> **Scientific counting instructions**<br />Default query result value is automatically converted to units, display follows 「scientific notation K, M, B」 (1 thousand = 1K, 1 million = 1M, 1 billion = 1B), retaining two decimal points; RMB is automatically converted to units 「yuan, million, billion」, retaining two decimal points <br />*For example, if the time interval of the unit is selected in ns, then according to the size of the data, the query result will only automatically convert the unit effect as follows, and so on：*<br /><li>1000000ns：Chart query data results in 1ms<br /><li>1000000000ns：The chart query data result shows 1s<br /><li>10000000000ns：The chart query data result shows 1m<br /><br/>2.Support for query results preset units, manual input format: aggregation function (metric), such as `last(age_idle)` |

### Advanced Settings
| Options | Description |
| --- | --- |
| Time Slice | When time slice is enabled, the original data will be aggregated in segments at certain time intervals, and then the aggregated data set will be aggregated a second time to get the result value, which is disabled by default.For details, see [time slicing instructions](chart-query.md#time-slicing) |
| Lock Time | Support to lock the time range of chart query data, not limited by the global time component. The time set by the user will appear in the upper right corner of the chart after successful setup, such as 【xx minutes】, 【xx hours】, 【xx days】. If you lock the time interval of 30 minutes, then when you adjust the time component, no matter what time range view is queried, only the last 30 minutes data will be displayed. |
| Time interval | If time slice is off, there is no time interval option, if time slice is on, the time interval option is as follows：<br /><li>Original interval: default query to display data according to the time range of the time component<br /><li>自Dynamic Alignment: When turned on, the query will be dynamically adjusted according to the selected time range and aggregation interval, rounded up according to the calculated time interval. (For example, if the automatic aggregation algorithm calculates the time interval to be 50 seconds, then the actual query will be launched according to the time interval of 1 minute) The system presets 1 millisecond, 10 milliseconds, 50 milliseconds, 100 milliseconds, 500 milliseconds, 1 second, 5 seconds, 15 seconds, 30 seconds, 1 minute, 5 minutes, 10 minutes, 30 minutes, 1 hour, 6 hours, 12 hours, 1 day, 1 week, 1 month, and many time interval.<br /><li>Custom time interval: When 【Lock time】 is selected, according to the length of the lock time, different optional time intervals will be automatically matched to query the displayed data. (For example, if you select 1 minute as the time interval, the query will actually be launched at 1 minute interval)<br /> |
| Field Mapping | Object mapping with view variables, default is off, if object mapping is configured in view variables：<br /><li>When field mapping is enabled, the chart displays the 「grouped fields」 of the query and the corresponding 「mapped fields」, and the grouped fields without specified mapping are not displayed.<br /><li>When field mapping is turned off, the chart is displayed normally, without the mapped fields<br /> |
| Chart Description | Add description information to the chart, after setting, an 【i】 prompt will appear behind the chart title, if not set, it will not be displayed |
| Workspace | The list of authorized workspaces, you can query and display the workspace data through the chart after you select it.


### Formatting Configuration

| Options | Description |
| --- | --- |
| Formatting Configuration | Formatting configuration allows you to hide sensitive log data content or highlight log data content that needs to be viewed，<br />- Fields: Iconic query field metrics that have been added<br />- Matching mode: support `=`, `! =`, `match`, `not match`<br />- Matching content: the data content of the query result<br />- Show as content: Replace with the content you want to show<br /> |

## Example graph

The following graph shows the loading efficiency of different host systems at 1m/5m/15m.

![](../img/2.biaogetu_1.png)

