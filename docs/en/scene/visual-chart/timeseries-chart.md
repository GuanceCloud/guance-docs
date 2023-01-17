# Timeseries Chart

---

## Introduction

Time-series diagrams are generally used to show the trend changes of data at equal time intervals, and can be used to analyze the effect and impact of multiple sets of indicator data.

## Application Scenarios

- View trends in application performance metrics data over time, such as the number of application "requests" over the last 15 minutes.
- View trends in user access metrics data over time, such as the occurrence of user access "errors" over different time frames.

- View similar trending metrics over a fixed time frame
- View events triggered by abnormal data fluctuations

## Chart Query

Chart query supports 「simple query」, 「expression query」 and 「DQL query」, please click [chart-query](chart-query.md) for detailed explanation of chart query conditions, simple query is added by default.

## Chart Linking

Links can help users jump from the current chart to the target page, support adding internal links and external links to the platform, and support modifying the corresponding variable values in the links through template variables to transfer data information and complete data linkage. Please click [chart-link](chart-link.md) to view the related settings.

## Event association

By "adding filter fields" to match the abnormal events associated with the selected fields, the time series data can be displayed in association with the events. This feature helps users to see if there are related events during the data fluctuation while viewing the trend to help them locate the problem from another perspective. Please click [events-relative](events-relative.md) for setting instructions.

## Chart Style
| Options | Description |
| --- | --- |
| Chart Title | Set the title for the chart, after setting, it will be displayed on the top left of the chart, and it supports hiding |
| Chart Types | Include line, bar and area charts (line chart is selected by default) |
| Stacked Display | Only supports bar chart, off by default, when on, "Mode" option appears on the right, including time series, percentage.<br /><li>Time sequence: each column is divided to show the percentage of subcategories under large categories, and statistics on the size of different indicators under each grouping<br /><li>Percentage: each layer of the column represents the percentage of the data of that category to the overall data of that grouping, and each series is stacked according to the percentage it represents |
| Color | Set the chart data display color, support custom manual input preset color, input format: aggregation function (indicator) {"label": "label value"}, such as `last(usage_idle){"host": "guance_01"}` |
| Alias | <li>Supports adding aliases to grouped queries. After adding aliases, the name of the legend changes, making it easier to distinguish related indicators more intuitively.<br><li>Support custom manual input of preset aliases, input format: aggregation function(indicator){"tag": "tag value"}, such as `last(usage_idle){"host": "guance_01"}` |
| Legend | Used to visually display the name, quantity and percentage of each indicator data. Currently supports selecting the bottom, right, and hidden legends (click on the indicator row in the legend to hide/show the corresponding indicator) |
| Show only grouping | Disable by default, when enabled, only "tag values" will be displayed in the legend, no more aggregate functions and indicator names, etc. |



## Chart Settings

### Basic Settings
| Options | Description |
| --- | --- |
| Unit | 1.Support setting units for query results.<br />1）If the queried data has no unit, after setting the unit in the chart, it will be displayed on the chart according to the set unit<br />2）If the query data comes with its own units, or if you are in [Indicator Management] (../../metrics/dictionary.md), and you set the units for the metrics in the chart, the units set in the chart will be displayed on the chart.<br />3）If the query data has no units and no units are set in the chart, the chart Y-axis values are automatically calculated according to scientific notation; the original values are displayed on the chart in the format [thousandths] (chart-query.md#thousand).<br /> **Scientific counting instructions**<br />Default query result value is automatically converted to units, display follows 「scientific notation K, M, B」 (1 thousand = 1K, 1 million = 1M, 1 billion = 1B), retaining two decimal points; RMB is automatically converted to units 「yuan, million, billion」, retaining two decimal points<br />*For example, if the unit of time interval is selected as ns, then according to the size of the data, the query result will only automatically convert the unit effect as follows, and so on：*<br /><li>1000000ns：图Table query data results are shown as 1ms<br /><li>1000000000ns：The chart query data result shows 1s<br /><li>10000000000ns：The chart query data result shows 1m<br /><br>2.Support for query results preset units, manual input format: aggregation function (indicator), such as `last(age_idle)` |
| Y-axis | Support for customizing the maximum and minimum values of the Y-axis |
| Baseline settings | Support adding baseline values, baseline titles, and baseline colors |

### Advanced Settings {#advanced-setting}
| Options | Description |
| --- | --- |
| Lock Time | Support to lock the time range of chart query data, not limited by the global time component. The time set by the user will appear in the upper right corner of the chart after successful setup, such as 【xx minutes】, 【xx hours】, 【xx days】. If you lock the time interval of 30 minutes, then when you adjust the time component, no matter what time range view is queried, only the last 30 minutes data will be displayed. |
| Time interval | If time slice is off, there is no time interval option, if time slice is on, the time interval option is as follows：<br /><li>Original interval: default query to display data according to the time range of the time component<br /><li>Auto-alignment: When turned on, the query will be dynamically adjusted according to the selected time range and aggregation interval, rounded up according to the calculated time interval. (For example, if the automatic aggregation algorithm calculates the time interval to be 50 seconds, then the actual query will be launched according to the time interval of 1 minute) The system presets 1 ms, 10 ms, 50 ms, 100 ms, 500 ms, 1 second, 5 seconds, 15 seconds, 30 seconds, 1 minute, 5 minutes, 10 minutes, 30 minutes, 1 hour, 6 hours, 12 hours, 1 day, 1 week, 1 month, and many time interval.<br /><li>Custom time interval: When 【Lock time】 is selected, according to the length of the lock time, different optional time intervals will be automatically matched to query the displayed data. (For example, if you select 1 minute as the time interval, the query will actually be launched at 1 minute interval)<br /> |
| Display Density | Includes 「Lower: 60 dots」, 「Low: 180 dots」, 「Medium: 360 dots」, 「High: 720 dots」 (default is "Medium").<br />The logic rules are as follows: (e.g. query out 100 points)<br /><li>When the number of query points is lower than the "density points", directly return; (selected 【low】 density, 100 < 180, directly return the query out of 100 points)<br /><li>When the query points exceed the "density points", return the density points; (example selected 【Lower】 density, 100>60, after processing to return 60 points)<br />*Note: If you select "Lock Time" and choose "Time Interval", the display density will be grayed out and you cannot select*<br /> |
| Compare with the previous data at the same time. The default display is off. When you turn on time-comparison, it supports 4 options: hourly (compare with one hour ago), daily (compare with one day ago), weekly (compare with one week ago), and monthly (compare with one month ago). Multiple options are supported, refer to [time-comparison](time-comparison.md) for details. |
| Line blending | Only support bar chart |
| Field mapping | Object mapping with view variables, default is off, if object mapping is configured in view variables：<br /><li>When field mapping is enabled, the chart displays the 「grouped fields」 of the query and the corresponding 「mapped fields」, and the unmapped grouped fields are not displayed.<br /><li>关When closing the field mapping, the chart is displayed normally without the mapped fields<br /> |
| Chart Description | Add description information to the chart, after setting, an 【i】 prompt will appear behind the chart title, if not set, it will not be displayed |
| Workspace | The list of authorized workspaces, you can query and display the workspace data through the chart after you select it.

## Chart Analysis

A chronological chart is a two-dimensional chart indexed by time order, with the horizontal axis being the time scale and the vertical axis being the data scale. Based on the selected time range, the time series chart will plot the trend changes of the object data over that time period.

**Note**: A query statement in the time series chart returns a maximum of 10 timelines, i.e., according to the results of the group by condition, data with more than 10 timelines are displayed in order with only 10 timelines.

![](../img/f4.png)

### 时Inter-axis function

Also, in analysis mode, Observation Cloud provides a timeline function, which means you can not only preview the interactive changes of object data and time through the timeline below the chart, but also drag and drop to select the time range for display. The timeline range is a query period for the selected time range, fixed three query periods forward and up to one query period backward (up to the current point in time). Example.

- The current time point is 11:00, and the time range is selected as "Last 1 hour", then the timeline range is 「8:00 - 11: 00」.
- The current time point is 11:00, and the time range is selected as 「10:00-10: 40」 (the query period is 40 minutes), then the timeline range is 「8:40 - 11:00」.

![](../img/f3.png)

#### Similar Trend Indicators

In the analysis mode of the time series chart, check the trend line/bar of the time series chart to "View Similar Trend Indicators".

"View Similar Trend Indicators" is a search for similar indicator trends in the space, using the time frame you selected as absolute time. You can

- On the time series chart, click on the chart and drag the mouse to select the time range to search for
- Click on the "button" to search for similar trend results
- Click on the search result to go to the "Similar Trend Indicators" detail page

![](../img/18.shixutu_1.png)

#### Similar Trend Results

Based on the selected absolute time horizon, the list of query results includes

- Source: the set of indicators with similar trends
- Number of similarities: the number of charts with similar trends under the corresponding "Indicator Set"
- Preview: preview of similar trend charts

![](../img/18.shixutu_2.png)

**Note**.

- The currently selected time range is "absolute time" by default when querying the 「similar interval」, and will not be changed by any external action or observer. If you need to change the time range, you need to readjust the time range

- Once you enter the Similar Intervals page, click and drag the rectangle to adjust the time range of your search, and if you have already selected an area, you can still move or adjust the selected time range

- After dragging to the new time range, you need to confirm/cancel the time range change

  

### Legend Function

The legend function is used to visually display the name, quantity and percentage of each indicator data, and currently supports three ways to select the hidden, bottom and right side.

The time series chart legend values are re-aggregated and calculated based on the chart query results.`Last（Last value）`  、`First（First value）`、 `Avg（Average value）`、 `Min（Minimum value）`、 `Max（Maximum value）`、 `Sum（Summation）`、 `Count（Return Points）`   。

As shown in the figure below: `First` means return the first value of the query result of the current timing diagram, `Last` is the last value of the query result of the current timing diagram, click the legend value to support ascending and descending sorting.

Note: `Avg`, `Sum`, `Count` show different results depending on the selected interval (original interval and auto-alignment).

![](../img/chart030.png)

## Example Graph

The following graph shows the trend of the host CPU usage over the last 15 minutes.

- Line Chart

![](../img/chart031.png)

- Histogram

![](../img/chart032.png)

- Area Map

![](../img/chart033.png)

