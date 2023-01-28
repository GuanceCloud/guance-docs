# Histogram

---

## Introduction

Bar charts are generally suitable for achieving changes in data over time and comparisons between variables. Default grouping is displayed.

## Application Scenarios

The Histogram of the Guance is used to show data changes over time and comparisons between variables. For example, you can query the CPU usage of different hosts for the last 15 minutes.

## Chart Query

Chart query supports 「simple query」, 「expression query」 and 「DQL query」, please click [chart-query](chart-query.md) for detailed explanation of chart query conditions. The set of indicators and indicators of the query can be different, but the by (grouping) Tag must be the same, modify one, the other queries are automatically modified synchronously.

## Chart Linking

Links can help you jump from the current chart to the target page, support adding internal links and external links to the platform, and support modifying the corresponding variable values in the links through template variables to transfer the data information to complete the data linkage. Please click [chart-link](chart-link.md) to view the related settings.

## Chart Style
| Options | Description |
| --- | --- |
| Chart Title | Set the title name for the chart, after setting, it will be shown on the top left of the chart, support hide |
| Chart Style | Support 【bar chart】 and 【bar graph】 two kinds of bar presentation |
| Stacked display | Support 【Indicator Stacking】 and 【Group Stacking】, off by default, when on, 【Indicator Stacking】 is selected by default. The "Mode" option appears on the right side, including default and percentage.<br />- Default: split each column to show the percentage of subcategories under the large categories, and count the size of different indicators under each grouping<br />- Percentage: each layer of the column represents the percentage of the data of that category to the overall data of that grouping, and each series is stacked according to the percentage it represents<br /> |
| Alias | <li>Supports adding aliases to grouped queries. After adding aliases, the name of the legend changes, making it easier to distinguish related indicators more intuitively.<br/><li>Supports custom manual input of preset aliases in the format of: aggregation function (indicator) {"label": "label value"}, such as `last(usage_idle){"host": "guance_01"}` |
| Color | Set the display color of the chart data, support custom manual input preset color, input format: aggregation function (indicator) {"label": "label value"}, such as `last(usage_idle){"host": "guance_01"}` |


## Chart Setup

### Basic Settings
| Options | Description |
| --- | --- |
| Unit | 1. Support setting units for query results.<br />1）If the queried data has no unit, after setting the unit in the chart, it will be displayed on the chart according to the set unit<br />2）If the query data comes with its own units, or if you are in [Indicator Management] (.../.../metrics/dictionary.md), and you set the units for the metrics in the chart, the units set in the chart will be displayed on the chart.<br />3）If the query data has no units and no units are set in the chart, the chart Y-axis values are automatically calculated according to scientific notation; the original values are displayed on the chart in the format [thousandths] (chart-query.md#thousand).<br /> **Scientific counting instructions**<br />Default query result value is automatically converted to units, display follows 「scientific notation K, M, B」 (1 thousand = 1K, 1 million = 1M, 1 billion = 1B), retaining two decimal points; RMB is automatically converted to units 「yuan, million, billion」, retaining two decimal points<br />*For example, if the time interval of the unit is selected in ns, then according to the size of the data, the query result will only automatically convert the unit effect as follows, and so on.*<br /><li>1000000ns: chart query data results are displayed as 1ms<br /><li>1000000000ns: chart query data results are displayed as 1s<br /><li>10000000000ns: chart query data results are displayed as 1m<br /><br/>2. support for the query results preset units, manual input format: aggregation function (indicator), such as `last(age_idle)` |
| Baseline | Support for adding baseline values, baseline titles, and baseline colors |

### Advanced Settings
| Options | Description |
| --- | --- |
| Time slice | When time slicing is turned on, the original data will be aggregated in segments at certain time intervals, and then the aggregated data set will be aggregated a second time to get the result value, which is turned off by default. For details, please refer to [time slicing description](chart-query.md#time-slicing) |
| Lock time | Support locking the time range of chart query data, not limited by the global time component. The time set by the user will appear in the upper right corner of the chart after successful setup, e.g. 【xx minutes】, 【xx hours】, 【xx days】. If the time interval is locked at 30 minutes, then when adjusting the time component, no matter what time range view is queried, only the last 30 minutes of data will be displayed. |
| Time interval | If time slice is off, there is no time interval option, if time slice is on, the time interval options are as follows.<br /><li>Original interval: default query to display data according to the time range of the time component<br /><li>Auto-alignment: When turned on, the query will be dynamically adjusted according to the selected time range and aggregation interval, rounded up according to the calculated time interval. (For example, if the automatic aggregation algorithm calculates the time interval to be 50 seconds, then the actual query will be launched according to the time interval of 1 minute) The system presets 1 ms, 10 ms, 50 ms, 100 ms, 500 ms, 1 second, 5 seconds, 15 seconds, 30 seconds, 1 minute, 5 minutes, 10 minutes, 30 minutes, 1 hour, 6 hours, 12 hours, 1 day, 1 week, 1 month, and many time interval.<br /><li>自Define time interval: When 【Lock time】 is selected, the query will automatically match different optional time intervals to display data according to the length of lock time. (For example, if you select 1 minute as the time interval, then the query will actually be launched at 1 minute interval)<br /> |
| Field Mapping | The object mapping function in conjunction with view variables is off by default, if object mapping has been configured in the view variable：<br /><li>When field mapping is enabled, the chart displays the 「grouped fields」 of the query and the corresponding 「mapped fields」, and the grouped fields without specified mapping are not displayed.<br /><li>When field mapping is turned off, the chart is displayed normally, without the mapped fields<br /> |
| Chart Description | Add description information to the chart, after setting the chart title will appear behind the 【i】 prompt, do not set it will not be displayed |
| Workspace | A list of authorized workspaces, which can be queried and displayed via charts after selection |

## Example diagram

The following graph shows an example of CPU usage for different hosts in the last 15 minutes.

- Histogram

![](../img/zhuzhuangtu001.png)

- Bar Chart

![](../img/zhuzhuangtu002.png)

