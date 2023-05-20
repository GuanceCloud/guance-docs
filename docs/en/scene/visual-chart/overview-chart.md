# Overview Chart
---

## Introduction

The overview chart clearly displays the result values of an metric and supports the display of line blends to help users understand the trend of the metric.

## Use Case

The overview graph of the Guance is used to display the resultant values of a metric. For example, you can view the CPU usage for the last 15 minutes.

## Chart Search

Chart query supports 「simple query」, 「expression query」 and 「DQL query」. Please click [chart-query](chart-query.md) for detailed explanation of chart query conditions.

**Note：**

- Single chart query only supports one query statement, the default is 「simple query」, click 「convert to expression query」 to switch to expression query, and use simple query as "query A", and support switching each other.The 「DQL query」 also applies to switching between each other.
- If a conversion function that is not supported by 「expression query」 is used in 「simple query」, the function will not be brought to the expression query after switching.

## Chart Links

Links can help you realize jumping from the current chart to the target page, support adding platform internal links and external links, support modifying the corresponding variable values in the links through template variables to transfer data information over and complete data linkage.Please click [chart-link](chart-link) for setting instructions.

## Chart Style
| Options | Description |
| --- | --- |
| Chart Title | Set the title name for the chart, after setting, it will be displayed on the top left of the chart, and it supports hiding |
| Color | Set the font color and background color of the chart |


## Chart Setup

### Basic Settings
| Options | Description |
| --- | --- |
| Data Accuracy | Select the number of decimal places to keep |
| Unit | 1.Support setting units for query results.<br />1）If the queried data has no unit, after setting the unit in the chart, it will be displayed on the chart according to the set unit<br />2）If the query data comes with its own units, or if you are in [Metric Management] (../../metrics/dictionary.md), and you set the units for the metrics in the chart, the units set in the chart will be displayed on the chart.<br />3）If the queried data has no units and no units are set in the chart, the chart Y-axis values are automatically calculated according to scientific notation.Show raw values on the chart in [thousandths](chart-query.md#thousand) format。<br /> **Scientific counting instructions**<br />Default query result value is automatically converted to units, display follows 「scientific notation K, M, B」 (1 thousand = 1K, 1 million = 1M, 1 billion = 1B), retaining two decimal points; RMB is automatically converted to units 「yuan, million, billion」, retaining two decimal points<br />*For example, if the unit of time interval is selected as ns, then according to the size of the data, the query result will only automatically convert the unit effect as follows, and so on：*<br /><li>1000000ns：Chart query data results in 1ms<br /><li>1000000000ns：The chart query data result shows 1s<br /><li>10000000000ns：The chart query data result shows 1m<br /><br/>2.Support for query results preset units, manual input format: aggregation function (metric), such as `last(age_idle)` |
| Value Mapping | <li> 设Set the range of metrics and the corresponding background color and font color. Metrics within the range will be displayed in the set style<br /><li> Set the metric range and mapping value, when the metric value is within the set data range, it will be displayed as the corresponding mapping value<br /><li> When the metric value meets more than one setting at the same time, it is displayed as the last setting that meets the condition.<br />When setting value mapping, neither 【Show as】 nor 【Color】 is mandatory/required：<br />   - 【Show as】 is empty by default, which means no mapping value is displayed<br />   - 【Color] 】s empty by default, that is, no color mapping to show its original color<br /> |

### Advanced Settings
| Options | Description |
| --- | --- |
| Time slice | When time slicing is turned on, the original data will be aggregated in segments at certain time intervals, and then the aggregated data set will be aggregated a second time to get the result value, which is turned off by default. For details, please refer to [time slicing description](chart-query.md#time-slicing) |
| Lock time | Supports locking the time range of the chart query data, not limited by the global time component.After successful setup, the time set by the user will appear in the upper right corner of the chart, such as 【xx minutes】, 【xx hours】, 【xx days】. If the time interval of 30 minutes is locked, then when adjusting the time component, no matter what time range view is queried, only the last 30 minutes of data will be displayed. |
| Time interval | 若Time slice off, no time interval option, if time slice on, time interval option as follows：<br /><li>Original interval: default query to display data according to the time range of the time component<br /><li>Auto-alignment: When turned on, the query will be dynamically adjusted according to the selected time range and aggregation interval, rounded upward according to the calculated time interval in close proximity.（ For example, if the automatic aggregation algorithm calculates the time interval to be 50 seconds, then the actual query will be launched at an interval of 1 minute ）The system is preset with 1 ms, 10 ms, 50 ms, 100 ms, 500 ms, 1 sec, 5 sec, 15 sec, 30 sec, 1 min, 5 min, 10 min, 30 min, 1 hr, 6 hr, 12 hr, 1 day, 1 week, 1 month, and many other time intervals.<br /><li>Custom time interval: When 【Lock time】 is selected, different optional time intervals will be automatically matched to query the displayed data according to the length of lock time.（ For example, if you select 1 minute for the time interval, then the query will actually be launched at 1 minute intervals ）<br /> |
| Comparison of the same period | Compare with data from the previous same time. The default display is off. When the contemporaneous comparison is turned on, the comparison dimension supports 4 options: hourly (compare with one hour ago), daily (compare with one day ago), weekly (compare with one week ago), and monthly (compare with one month ago).Only single support, refer to [time comparison](time-comparison.md) for details   |
| Collapsed Hybrid Chart | <li>When enabled, the overview chart and the line chart will be displayed in the chart at the same time, helping users to understand the trend of the metric while checking the current value of the metric<br /><li>After the value mapping is turned on, a new line color setting item is added to the value mapping. After the line color is set in the value mapping, the data query results will be displayed in the chart when the conditions are met.<br /> |
| Chart Description | Add description information for the chart, after setting the chart title will appear behind the 【i】 prompt, not set, it will not be displayed |
| Workspace | A list of authorized workspaces, which can be queried and displayed via charts after selection |


## Example diagram

The graph below shows the last 15 minutes of memory usage.

![](../img/4.gailantu.png)

