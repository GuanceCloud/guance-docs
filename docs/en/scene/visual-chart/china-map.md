# China Map
---

## Introduction

"Guance" supports adding a map of China to the view.

## Use Case

The world map of the Guance is used to display the data distribution of a certain metric data in different provinces. It can be used in the following scenarios.

- Showing the data distribution in different regions
- Showing the data size ranking of different regions

## Chart Search

**Prerequisites:** The data set of the metric query must contain the label "Province" and the query criteria must contain the grouping of "Province", otherwise the chart cannot be added successfully.

Please click [chart-query](chart-query.md) for detailed description of the chart query conditions, and add a simple query by default. You can add multiple queries, but the Tag of by (grouping) must be the same, modify one, and the other will be modified automatically.

Chart query matches regions by province and colors by metric values, as described below.

| Options | Description |
| --- | --- |
| Province tag | Select the tag that represents the province, the tag must be the tag tag that has been grouped in the query (**Note: the tag name of the province tag does not have to be "province", as long as the value is the provincial administrative region can be **) |
| Metrics | When adding multiple metric queries, you can set the main metric to be displayed. The "Main Display Metric" determines the metric of the color gradient color.

## Chart Linking

Links can help you jump from the current chart to the target page, support adding internal links and external links to the platform, and support modifying the corresponding variable values in the links through template variables to transfer the data information to complete the data linkage. Please click [chart-link](chart-link.md) to view the related settings.
## Chart Style
| Options | Description |
| --- | --- |
| Chart Title | Set the title for the chart, after setting, it will be shown on the top left of the chart, support hide |
| Region Ranking | Support ranking by region data size, from largest to smallest. Disable by default |
| Color | 1. Gradient color system: Gradient color of the color block. After selecting the color, the system will use the selected color as the base to generate the number of color blocks of the selected grade<br/>2. Gradient interval：<br/><li>Automatic: default divided into 5 intervals according to the maximum and minimum values of the current data, supports customizing the maximum and minimum values；<br/><li>自Definition: Supports custom gradient color levels, i.e., the level setting of the area range in the map. By default, the system divides the maximum and minimum values of the selected metric into 5 gradient levels, and supports customizing the number of levels (up to 10), the range of levels, and the display color |


## Chart Settings

### Basic Settings
| Options | Description |
| --- | --- |
| Units | 1. Support setting units for query results.<br />1）If the queried data has no unit, after setting the unit in the chart, it will be displayed on the chart according to the set unit<br />2）If the query data comes with its own units, or if you are in [Metric Management] (../../metrics/dictionary.md), and you set the units for the metrics in the chart, the units set in the chart will be displayed on the chart.<br />3）If the query data has no units and no units are set in the chart, the chart Y-axis values are automatically calculated according to scientific notation; the original values are displayed on the chart in the format [thousandths] (chart-query.md#thousand).<br /> **Scientific counting instructions**<br />Default query result value is automatically converted to units, display follows 「scientific notation K, M, B」 (1 thousand = 1K, 1 million = 1M, 1 billion = 1B), retaining two decimal points; RMB is automatically converted to units 「yuan, million, billion」, retaining two decimal points<br />*For example, if the unit of time interval is selected as ns, then according to the size of the data, the query result will only automatically convert the unit effect as follows, and so on：*<br /><li>1000000ns: chart query data results are displayed as 1ms<br /><li>1000000000ns: chart query data results are displayed as 1s<br /><li>10000000000ns: chart query data results are displayed as 1m<br /><br/>2. support for the query results preset units, manual input format: aggregation function (metric), such as `last(age_idle)` |

### Advanced Settings
| Options | Description |
| --- | --- |
| Time Slicing | When time slicing is enabled, the original data will be aggregated in segments at certain time intervals, and then the aggregated data set will be aggregated a second time to get the result value, which is disabled by default. For details, please refer to [time slicing description](chart-query.md#time-slicing) |
| Lock Time | Support to lock the time range of the chart query data, not limited by the global time component. The time set by the user will appear in the upper right corner of the chart after successful setup, such as 【xx minutes】, 【xx hours】, 【xx days】. If you lock the time interval of 30 minutes, then when you adjust the time component, no matter what time range view is queried, only the last 30 minutes of data will be displayed.|
| Time interval | If the time slice is off, there is no time interval option, if the time slice is on, the time interval option is as follows：<br /><li>Original interval: default query to display data according to the time range of the time component<br /><li>Auto-alignment: When turned on, the query will be dynamically adjusted according to the selected time range and aggregation interval, rounded up according to the calculated time interval. (For example, if the automatic aggregation algorithm calculates the time interval to be 50 seconds, then the actual query will be launched according to the time interval of 1 minute) The system presets 1 ms, 10 ms, 50 ms, 100 ms, 500 ms, 1 second, 5 seconds, 15 seconds, 30 seconds, 1 minute, 5 minutes, 10 minutes, 30 minutes, 1 hour, 6 hours, 12 hours, 1 day, 1 week, 1 month, and many time interval.<br /><li>Custom time interval: When 【Lock time】 is selected, according to the length of lock time, different optional time intervals will be automatically matched to query the displayed data. (For example, if you select 1 minute as the time interval, the query will actually be launched at 1 minute interval)<br /> |
| Field Mapping | The object mapping function with view variables is off by default, if object mapping is configured in the view variables：<br /><li>When field mapping is enabled, the chart displays the 「grouped fields」 of the query and the corresponding 「mapped fields」, and the grouped fields without specified mapping are not displayed.<br /><li>When field mapping is turned off, the chart is displayed normally, without the mapped fields<br /> |
| Chart Linkage | Map linkage with view variables. When enabled, select the view variable to be linked, then when clicking on the map color block area, the view variable value will automatically change to the selected area value |
| Chart Description | Add description information to the chart, after setting the chart title will appear behind the 【i】 prompt, do not set it will not be displayed |
| Workspace | A list of authorized workspaces, which can be queried and displayed via charts after selection |

## Example Chart

The chart below shows an example of the number of people recovered and discharged from hospitals in each province of the New Crown outbreak.

![](../img/zhongguo.png)

Note: The data in this chart is for testing purposes only.

