# Bar Chart

---

Bar charts are generally suitable for demonstrating data changes over a period of time and comparisons among variables.

![](../img/bar.png)

## Chart Query

Chart queries support **simple query**, **expression**, **PromQL** and **Datasource**; Simple query is added by default; You can add multiple queries, but the Tag of by (grouping) must be consistent. If one is modified, the others will be automatically synchronized.

> For more details, see [Chart Query](chart-query.md).

## Chart Link

Links can help you jump from the current chart to the target page; You can add internal and external links; You can also modify the corresponding variable values in the link through template variables to transfer data information and complete data linkage.

> For more details, see [Chart Link](chart-link.md).

## Basic Settings

The chart types include bar charts and bar graphs.

| Option | Description |
| --- | --- |
| Title | Set a title for the chart. After setting, it will be displayed in the upper left corner of the chart, and can be hidden. |
| Description | Add a description to the chart. After setting, an [i] tip will appear behind the chart title. If not set, it will not be displayed. |
| Stack | Type: Includes general stack and percentage stack.<br /><br />X-axis: Includes group and query.<br />&nbsp; &nbsp; &nbsp;Group: Each group is a bar, and data sets of the same group are stacked;<br />&nbsp; &nbsp; &nbsp;Query: Each query is a bar, and the groups in the query are stacked. |
| Unit | :material-numeric-1-box: Default unit display:<br /><li>If the data queried is metric data, and you have set a unit for the metric in https://www.notion.so/metrics/dictionary.md, then it will be displayed by default according to the unit of the metric;<br /><li>If you have no relevant unit configuration in Metric Management, it will be displayed in https://www.notion.so/chart-query.md#thousand comma separated format.<br />:material-numeric-2-box: After configuring the unit:<br />The unit you custom configured will be used to display, and metric data supports two options for values:<br /><br />Scientific Notation Description<br /><u>Default Rounding</u>: Units are ten thousand, million, such as 10000 is displayed as 1 ten thousand, 1000000 is displayed as 1 million. Retain two decimal places;<br /><u>Short System</u>: Units are K, M, B. That is, thousand, million, billion, trillion, etc. represent thousand, million, billion, trillion in Chinese context. Such as 1000 is 1k, 10000 is 10k, 1000000 is 1 million; retain two decimal places. |
| Color | Set the display color of the chart data, support custom manual input preset color, input format is: Aggregation function (metric) {"Tag": "Tag value"}, such as last(usage_idle){"host": "guance_01"}. |
| Legend | For more details, see https://www.notion.so/timeseries-chart.md#legend. |
| Data Format | You can choose the number of decimal places and the thousand separator.<br /><li>The thousand separator is turned on by default, and after turning off, the original value will be displayed without the separator. For more details, see https://www.notion.so/visual-chart/chart-query.md#thousand. |

## Advanced Settings

| Option | Description |
| --- | --- |
| Lock Time | That is, fix the time range of the current chart query data, not subject to the restriction of the global time component. After setting successfully, the upper right corner of the chart will display the time set by the user, such as 【xx minutes】, 【xx hours】, 【xx days】. If the lock time interval is 30 minutes, then no matter what time range view is queried when adjusting the time component, only the data of the last 30 minutes will be displayed. |
| Time Slicing | After turning on time slicing, the original data will be aggregated in segments according to a certain time interval, and then the aggregated data set will be aggregated a second time to get the result value, turned off by default.<br /><br />If time slicing is turned off, there is no time interval option; if time slicing is turned on, the time interval options are as follows:<br /><li>Automatic alignment: After turning on, it will dynamically adjust the query according to the selected time range and aggregation time interval, and round up the calculated time interval.<br />      The system has preset a variety of time intervals: 1 millisecond, 10 milliseconds, 50 milliseconds, 100 milliseconds, 500 milliseconds, 1 second, 5 seconds, 15 seconds, 30 seconds, 1 minute, 5 minutes, 10 minutes, 30 minutes, 1 hour, 6 hours, 12 hours, 1 day, 1 week, 1 month;<br /><li>Custom time interval: When selecting 【Lock Time】, according to the length of the lock time, automatically match different optional time interval queries to display data. (For example: if the time interval is selected as 1 minute, then the query will actually be initiated at intervals of 1 minute)<br /><br />For more details, see https://www.notion.so/chart-query.md#time-slicing. |
| Baseline | Support adding baseline value, baseline title and baseline color. |
| Field Mapping | Cooperate with the object mapping function of the view variable, default is off, if object mapping is configured in view variable:<br /><li>When field mapping is turned on, the chart displays the grouping field and corresponding mapping field of the query, and the grouping field that is not specified for mapping is not displayed;<br /><li>When field mapping is turned off, the chart is displayed normally, and the mapped field is not displayed.<br /> |
| Space Authorization | The list of authorized workspaces, after selection, you can query and display the data of this workspace through the chart. |

## Example Chart

The chart below shows the remaining disk space of different devices in the last 15 minutes: