# Leaderboard
---

## Introduction

The ranking is an objective reflection of the strength of a relevant similar thing, showing succinctly the ascending and descending ranking of Top N or Bottom N.

## Use Case

The ranking of the Guance is used to display the ascending and descending ranking of data for a metric. For example, you can query the top 5 hosts for CPU usage statistics.

## Chart Search

Chart query supports 「simple query」, 「expression query」 and 「DQL query」. Please click [chart query] (chart-query.md) to view the detailed description of chart query conditions. By default, simple query is added. By default, 「Top」/「Bottom」 function is built in the query. By default, 5, 10, 20, 100 and 4 ranking numbers can be selected. Adding alias 「AS」 is not supported in the ranking list.

**Note：**

- Single chart query only supports one query statement, which defaults to 「Simple Query」. Click 「Convert to Expression Query」 to switch to Expression Query, and take Simple Query as "Query A", which supports mutual switching. 「DQL Query」 is also applicable to switching between each other.
- If a conversion function not supported by 「expression query」 is used in 「simple query」, the function will not be brought to the expression query after switching.

## Chart Links

Links can help you jump from the current chart to the target page, support adding internal links and external links to the platform, and support modifying the corresponding variable values in the links through template variables to transfer the data information to complete the data linkage. Please click [chart-link](chart-link.md) to view the related settings.
## Chart Style
| Options | Description |
| --- | --- |
| Chart Title | Set the title name for the chart, after setting, it will be shown on the top left of the chart, support hide |
| Chart Color | Set the color of the chart data |


## Chart Setup

### 基本设置
| Options | Description |
| --- | --- |
| Unit | 1.Support setting units for query results.<br />1）If there is no company in the query data, after setting the company in the chart, display it on the chart according to the set company<br />2）If the data queried comes with its own unit, or if you set the unit for the metric in [Metric Management] (../../metrics/dictionary.md), and after setting the unit on the chart, display it on the chart according to the unit set on the chart<br />3）If the query data has no units and no units are set in the chart, the chart Y-axis values are automatically calculated according to scientific notation; the original values are displayed on the chart in the format [thousandths] (chart-query.md#thousand).<br /> **Scientific counting instructions**<br />Default query result value is automatically converted to units, display follows 「scientific notation K, M, B」 (1 thousand = 1K, 1 million = 1M, 1 billion = 1B), retaining two decimal points; RMB is automatically converted to units 「yuan, million, billion」, retaining two decimal points<br />*For example, if the unit of time interval is selected as ns, then according to the size of the data, the query result will only automatically convert the unit effect as follows, and so on：*<br /><li>1000000ns：Chart query data results in 1ms<br /><li>1000000000ns：The chart query data result shows 1s<br /><li>10000000000ns：The chart query data result shows 1m<br /><br/>2.Support for query results preset units, manual input format: aggregation function (metric), such as `last(age_idle)` |
| Baseline | Support for adding baseline values, baseline titles, and baseline colors |

### Advanced Settings
| Options | Description |
| --- | --- |
| Time slice | When time slicing is turned on, the original data will be aggregated in segments at certain time intervals, and then the aggregated data set will be aggregated a second time to get the result value, which is turned off by default. For details, please refer to [time slicing description](chart-query.md#time-slicing) |
| Lock time | Support locking the time range of the chart query data, not limited by the global time component. The time set by the user will appear in the upper right corner of the chart after successful setup, e.g. 【xx minutes】, 【xx hours】, 【xx days】. If the time interval is locked at 30 minutes, then when adjusting the time component, no matter what time range view is queried, only the last 30 minutes of data will be displayed. |
| Time interval | If the time slice is off, there is no time interval option, if the time slice is on, the time interval option is as follows：<br /><li>Original interval: default query to display data according to the time range of the time component<br /><li>自Dynamic alignment: When turned on, the query will be dynamically aligned according to the selected time range and aggregation interval, rounded upwards according to the calculated time interval in close proximity.（ For example, if the automatic aggregation algorithm calculates the time interval to be 50 seconds, then the actual query will be launched at an interval of 1 minute ）The system is preset with 1 ms, 10 ms, 50 ms, 100 ms, 500 ms, 1 sec, 5 sec, 15 sec, 30 sec, 1 min, 5 min, 10 min, 30 min, 1 hr, 6 hr, 12 hr, 1 day, 1 week, 1 month, and many other time intervals.<br /><li>Custom time interval: When [Lock time] is selected, different optional time intervals will be automatically matched to query the displayed data according to the length of lock time.（ For example, if you select 1 minute for the time interval, then the query will actually be launched at 1 minute intervals ）<br /> |
| Field Mapping | The object mapping function with view variables is off by default, if object mapping is configured in the view variables：<br /><li>When field mapping is enabled, the chart displays the 「grouped fields」 of the query and the corresponding 「mapped fields」, and the grouped fields without specified mapping are not displayed.<br /><li>关When closing the field mapping, the chart is displayed normally without the mapped fields<br /> |
| Chart Description | Add description information for the chart, after setting the chart title will appear behind the 【i】 prompt, not set, it will not be displayed |
| Workspace | A list of authorized workspaces, which can be queried and displayed via charts after selection |


## Example diagram

The chart below shows the top 5 hosts in terms of CPU usage in the last 15 minutes.

![](../img/paihangbang.png)

