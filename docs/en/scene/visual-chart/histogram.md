# Histogram
---

A histogram, also known as a quality distribution chart, is used to represent the distribution of data. It is a common statistical chart where the horizontal axis represents data intervals and the vertical axis represents the frequency of occurrence. The shape of the chart resembles a bar chart, with taller bars indicating a higher number of occurrences within that interval.

Histograms only support log-type data and can be used to represent the distribution of `number` type data stored in Elasticsearch, including data from "logs", "basic objects", "resource catalogs", "events", "APM", "RUM", "security checks", "network", and "Profile" queries. If the workspace uses SLS storage, data queries will result in an error.

![](../img/histogram.png)

## Chart Queries

Supports **simple queries**, **expression queries**, **PromQL queries**, and **data source queries**.

> For more detailed explanations of chart query conditions, refer to [Chart Queries](chart-query.md).

> For more details on storage, refer to [Data Storage Policy](../../billing-method/data-storage.md#options).

## Chart Configuration

> For more details, refer to [Chart Configuration](./chart-config.md).

## Advanced Configuration

| Option | Description |
| --- | --- |
| Lock Time Range | This fixes the time range for querying data in the current chart, independent of the global time component. After setting this, the chart's top-right corner will display the user-defined time, such as "xx minutes", "xx hours", or "xx days". For example, if the locked time interval is 30 minutes, adjusting the time component to any other time range will still show only the most recent 30 minutes of data. |
| Field Mapping | This works with the object mapping function of view variables. By default, it is turned off. If object mapping is configured in view variables:<br /><li>When field mapping is enabled, the chart displays the **grouping fields** and corresponding **mapped fields**, while unspecified grouping fields are not shown;<br /><li>When field mapping is disabled, the chart displays normally without showing mapped fields. |
| Workspace Authorization | Lists authorized workspaces. After selection, the chart can query and display data from the selected workspace. |
| Data Sampling | Applies only to Doris log data engine workspaces; when enabled, it samples non-metric data dynamically based on data volume. The sampling rate is not fixed. |
| Time Offset | Non-time series data may have at least a 1-minute delay after being indexed. When using relative time queries, this can cause recent data to be missing.<br />Enabling time offset shifts the actual query time range forward by 1 minute when querying relative time intervals, preventing data gaps due to indexing delays. For example, if the current time is 12:30 and you query the last 15 minutes of data, with time offset enabled, the actual queried time range would be 12:14-12:29.<br />:warning: <br /><li>This setting only applies to relative time queries. If the query time range is an absolute time range, time offset does not apply.<br /><li>For charts with time intervals, such as time series charts, time offset only applies if the time interval is <= 1 minute. For charts without time intervals, like overview charts and bar charts, time offset remains effective. |

## Common Configuration

| Option | Description |
| --- | --- |
| Title | Set a title for the chart, which appears in the top-left corner of the chart. You can choose to hide it. |
| Description | Add a description to the chart. If set, an [i] icon will appear after the chart title; otherwise, it will not be displayed. |
| Unit | **:material-numeric-1-box: Default unit display**: <br /><li>If the queried data is metric data and you have set units for the metrics in [Metric Management](../../metrics/dictionary.md), the default display will use the metric's unit;<br /><li>If no unit is configured in **Metric Management**, the data will be displayed with thousand separators.<br />**:material-numeric-2-box: After configuring a unit**: <br />Priority is given to the custom unit you configure. Metric data supports two options for numerical representation:<br /><br />**Scientific Notation Explanation**<br /><u>Default rounding</u>: Units are in ten thousand, million, etc., e.g., 10000 is displayed as 1 ten thousand, 1000000 as 1 million. Two decimal places are retained;<br /><u>Short scale</u>: Units are K, M, B, representing thousand, million, billion, trillion, etc. For example, 1000 is 1k, 10000 is 10k, 1000000 is 1 million; two decimal places are retained. |
| Color | Set the display color for chart data. You can manually input preset colors in the format: aggregation function(metric){"label": "label value"}, such as `last(usage_idle){"host": "guance_01"}`. |
| Legend | Choose legend placement (bottom, right side, hidden). Clicking on a metric in the legend hides/shows the corresponding metric. Legend values include min, max, p50, p75, p90, p99. |
| Data Format | Choose the number of decimal places and whether to use thousand separators.<br /><li>Thousand separators are enabled by default. Disabling them shows raw values without separators. More details can be found in [Data Thousand Separator Formatting](../visual-chart/chart-query.md#thousand). |
| Percentiles | By default, percentiles p50, p75, p90, p99 are displayed in the histogram's distribution area, marked by vertical lines to help visualize data distribution. |

## Use Cases

<<< custom_key.brand_name >>>'s histograms are used to display the distribution trend of a specific metric over a period of time. They can be used in the following scenarios:

- View the distribution of APM metric data over a certain time range, such as the distribution of "request counts" in the last 15 minutes;
- View the distribution of RUM metric data over a certain time range, such as the distribution of "error counts" in the last 15 minutes;
- Display the distribution of other log-type data containing `number` type data.