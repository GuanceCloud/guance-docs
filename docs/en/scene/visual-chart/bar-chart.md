# Bar Chart

---

## Overview

Bar charts are generally applied to achieve changes in data over time and comparisons between variables. Grouping is displayed by default. For example, you can query the CPU usage of different hosts for the last 15 minutes.

## Operations

### Chart Query

Chart query supports simple query, expression query and DQL query, please click [chart query](chart-query.md) for detailed explanation of chart query conditions. Measurements and metrics of the query can be different, but the by (grouping) Tag must be the same. If one is modified, other queries are automatically modified.

### Chart Link

Links can help you jump from the current chart to the target page, which support adding internal links and external links to the platform and modifying the corresponding variable values in the links through template variables to transfer the data information to complete the data linkage. Please click [chart link](chart-link.md) to view the related settings.

### Chart Style
| Options | Description |
| --- | --- |
| Chart title | It would be shown on the top left of the chart after setting the title name; it also supports hide. |
| Chart style | It contains two kinds of bar presentation, bar chart and bar graph.  |
| Stacked display | It supports **Metric Stacking** and **Group Stacking** and is off by default. when the function is turned on, **Metric Stacking** is selected by default. The **Mode** option appears on the right side, including default and percentage.<br />- Default: split each column to show the percentage of subcategories under the large categories and count the size of different metrics under each grouping.<br />- Percentage: each layer of the column represents the percentage of the data of that category to the overall data of that grouping and each series is stacked according to the percentage it represents.<br /> |
| Alias | <li>You can add aliases to grouped queries, making it easier to distinguish related metrics more intuitively.<br/><li>You can input preset aliases in the format of aggregation function (metric) {"label": "label value"}, such as `last(usage_idle){"host": "guance_01"}` |
| Color | It refers to the display color of the chart data, enabling you to manually input custom preset color. The format is aggregation function (metric) {"label": "label value"}, such as `last(usage_idle){"host": "guance_01"}` |


### Chart Setting

#### Basic Setting
| Options | Description |
| --- | --- |
| Unit | 1. You can set units for query results.<br /><br />1）If the queried data has no unit, it will be displayed on the chart according to the set unit after setting the unit in the chart.<br /><br />2）If the query data comes with its own units or if you are in [Metric Management](.../.../metrics/dictionary.md), and you set the units for the metrics in the chart, the units set in the chart will be displayed on the chart.<br /><br />3）If the query data has no units and no units are set in the chart, the chart Y-axis values are automatically calculated according to scientific notation; the original values are displayed on the chart in the format [thousandths](chart-query.md#thousand).<br /><br /> **Scientific counting instructions:**<br />Query result value is automatically converted to units by default, display follows scientific notation K, M and B (1 thousand = 1K, 1 million = 1M, 1 billion = 1B), retaining two decimal points; RMB is automatically converted to units yuan, million, billion, retaining two decimal points.<br /><br />*For example, if the time interval of the unit is selected in ns, then according to the size of the data, the query result will only automatically convert the unit effect as follows, and so on.*<br /><li>1000000ns: chart query data results are displayed as 1ms.<br /><li>1000000000ns: chart query data results are displayed as 1s.<br /><li>10000000000ns: chart query data results are displayed as 1m.<br /><br/>2. You can preset units for the query results and manually input format as aggregation function (metric), such as `last(age_idle)` |
| Baseline | You can add baseline values, baseline titles and baseline colors. |

#### Advanced Setting
| Options | Description |
| --- | --- |
| Time slice | When time slicing is turned on, the original data will be aggregated in segments at certain time intervals, and then the aggregated data set will be aggregated a second time to get the result value, which is turned off by default. For details, please refer to [time slicing description](chart-query.md#time-slicing) |
| Lock time | You can lock the time range of chart query data, not limited by the global time component. The time set by the user will appear in the upper right corner of the chart after successful setup, e.g.【xx minutes】,【xx hours】,【xx days】. If the time interval is locked at 30 minutes, then when adjusting the time component, only the last 30 minutes of data will be displayed no matter what time range view is queried. |
| Time interval | If time slice is off, there is no time interval option, if time slice is on, the time interval options are as follows.<br /><br /><li>Original interval: query and display data according to the time range of the time component by default.<br /><br /><li>Auto-alignment: When turned on, the query will be dynamically adjusted according to the selected time range and aggregation interval, rounded up according to the calculated time interval. <br />For example, if the automatic aggregation algorithm calculates the time interval to be 50 seconds, then the actual query will be launched according to the time interval of 1 minute. The system presets 1 ms, 10 ms, 50 ms, 100 ms, 500 ms, 1 second, 5 seconds, 15 seconds, 30 seconds, 1 minute, 5 minutes, 10 minutes, 30 minutes, 1 hour, 6 hours, 12 hours, 1 day, 1 week, 1 month and many other time interval.<br /><br /><li>Define time interval: When lock time is selected, the query will automatically match different optional time intervals to display data according to the length of lock time. <br />For example, if you select 1 minute as the time interval, then the query will actually be launched at 1 minute interval.<br /> |
| Field mapping | It is a object mapping function to comply with view variables, which is turned off by default. If object mapping has been configured in view variables:<br /><li>When field mapping is turned on, the chart displays the grouping fields and the corresponding mapping fields of the query, and the grouping fields without mapping are not displayed.<br /><li>When field mapping is turned off, the chart displays normally, and the mapped fields are not displayed.<br /> |
| Chart description | After adding description information to the chart, the chart title will appear behind the【i】prompt, and vice versa. |
| Workspace | A list of authorized workspaces, which can be queried and displayed via charts after selection. |

### Example

The following shows an example of CPU usage for different hosts in the last 15 minutes.

- Bar Chart

![](../img/zhuzhuangtu001.png)

- Bar Graph

![](../img/zhuzhuangtu002.png)

