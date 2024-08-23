# Histogram
---

## Introduction

The histogram, also known as the mass distribution chart, is used to represent the distribution of data and is a common statistical chart that generally uses the horizontal axis to represent the data interval and the vertical axis to represent the distribution. The shape of the chart is similar to a bar chart, and the higher the bar, the greater the number falling in the interval.

## Use Case

Histograms of guances are used to show the direction of the data distribution of a certain metric data over time. It can be used in the following scenarios.

- View the distribution of application performance metrics data over time, such as the distribution of "requests" over the last 15 minutes.
- View the distribution of user access metrics data over time, such as the distribution of "errors" over the last 15 minutes.
- The distribution of `number` type data in other log data.

## Chart Search

Chart query supports 「simple query」, 「expression query」 and 「DQL query」. Please click [chart-query.md](chart-query.md) for detailed explanation of chart query conditions.

???+ warning

    The histogram only supports log type data, which can be used to represent the distribution of ES storage `number` type data, including "log", "base object", "custom object", "event", "application performance", "user access", "security patrol", "network", "profile" data query; if the workspace is SLS storage, the data query will report an error. For more storage instructions, please refer to the document [Data Storage Policy](../../billing/billing-method/data-storage.md#options).

## Chart Links

Links can help you jump from the current chart to the target page, support adding internal links and external links to the platform, and support modifying the corresponding variable values in the links through template variables to transfer data information and complete data linkage. Please click [chart-link](chart-link.md) to view the related settings.

## Event association

By "adding filter fields" to match the abnormal events associated with the selected fields, the time series data can be displayed in relation to the events. This feature can help users to see if there are related events during the data fluctuation while viewing the trend to help them locate the problem from another perspective. Please click [events-relative.md] for setting instructions.

## Chart Style
| Options | Description |
| --- | --- |
| Chart Title | Set the title name for the chart, after setting, it will be shown on the top left of the chart, support hide |
| Color | Set the chart data display color, support custom manual input preset color, input format: aggregation function (metric) {"label": "label value"}, such as `last(usage_idle){"host": "guance_01"}` |
| Figure legend | <li>Used to visually display the name, quantity and percentage of each metric data. Currently supports selecting the bottom, right, and hidden legends (click on the metric row in the legend to hide/show the corresponding metric)<br><li>Legend values support min, max, p50, p75, p90, p99 |
| Percentile | Default display of p50, p75, p90, p99 in the distribution of the histogram when querying data, with vertical lines to help more intuitive view of the data distribution |


## Chart Setup

### Basic Settings
| Options | Description |
| --- | --- |
| Unit | 1. Support setting units for query results.<br />1）If the queried data has no unit, after setting the unit in the chart, it will be displayed on the chart according to the set unit<br />2）If the query data comes with its own units, or if you are in [Metric Management] (../../metrics/dictionary.md), and you set the units for the metrics in the chart, the units set in the chart will be displayed on the chart.<br />3）If the query data has no units and no units are set in the chart, the chart Y-axis values are automatically calculated according to scientific notation; the original values are displayed on the chart in the format [thousandths] (chart-query.md#thousand).<br /> **Scientific counting instructions**<br />Default query result value is automatically converted to units, display follows 「scientific notation K, M, B」 (1 thousand = 1K, 1 million = 1M, 1 billion = 1B), retaining two decimal points; RMB is automatically converted to units 「yuan, million, billion」, retaining two decimal points<br />*例For example, if the time interval of the unit is selected in ns, then according to the size of the data, the query result will only automatically convert the unit effect as follows, and so on：*<br /><li>1000000ns：Chart query data results in 1ms<br /><li>1000000000ns：The chart query data result shows 1s<br /><li>10000000000ns：The chart query data result shows 1m<br /><br/>2.Support for query results preset units, manual input format: aggregation function (metric), such as `last(age_idle)` |

### Advanced Settings
| Options | Description |
| --- | --- |
| Lock time | Support locking the time range of chart query data, not limited by the global time component. The time set by the user will appear in the upper right corner of the chart after successful setup, e.g. 【xx minutes】, 【xx hours】, 【xx days】. If the time interval is locked at 30 minutes, then when adjusting the time component, no matter what time range view is queried, only the last 30 minutes of data will be displayed. |
| Chart Description | Add description information to the chart, after setting the chart title will appear behind the 【i】 prompt, do not set it will not be displayed |
| Field Mapping | The object mapping function with view variables is off by default, if object mapping is configured in the view variables：<br /><li>When field mapping is enabled, the chart displays the 「grouped fields」 of the query and the corresponding 「mapped fields」, and the grouped fields without specified mapping are not displayed.<br /><li>When field mapping is turned off, the chart is displayed normally, without the mapped fields<br /> |
| Workspace | A list of authorized workspaces, which can be queried and displayed via charts after selection |


## Example diagram

In the following figure, `duration` denotes the duration of `span` and represents the distribution of `span` data over different durations.

![](../img/8.chart_11.png)

