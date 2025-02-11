# Histogram
---

A histogram, also known as a quality distribution chart, is used to represent the distribution of data. It is a common statistical chart where the horizontal axis typically represents data intervals and the vertical axis represents frequency or distribution. The shape of the chart resembles a bar chart, with taller bars indicating a higher quantity of data points in that interval.

Histograms only support log-type data and can be used to represent the distribution of `number` type data stored in Elasticsearch, including data from "logs", "basic objects", "resource catalog", "events", "APM", "RUM", "security check", "network", and "Profile". If the workspace uses SLS storage, queries will result in an error.

![](../img/histogram.png)

## Chart Query

Supports **simple query**, **expression query**, **PromQL query**, and **data source query**.

> For more detailed information on chart query conditions, refer to [Chart Query](chart-query.md).

> For more details on storage, refer to [Data Storage Policy](../../billing-method/data-storage.md#options).

## Chart Configuration

> For more details, refer to [Chart Configuration](./chart-config.md).

## Advanced Configuration

| Option | Description |
| --- | --- |
| Lock Time Range | Fixes the time range for the current chart's data query, independent of the global time component. After setting this, the user-defined time (e.g., "xx minutes", "xx hours", "xx days") will appear in the top-right corner of the chart. For example, if you lock the time interval to 30 minutes, the chart will always show data for the last 30 minutes regardless of any changes to the time component. |
| Field Mapping | This feature works with view variable object mapping. By default, it is turned off. If view variables have configured object mappings:<br /><li>When field mapping is enabled, the chart displays the **grouped fields** and corresponding **mapped fields**; unmapped grouped fields are not shown.<br /><li>When field mapping is disabled, the chart displays normally without showing mapped fields. |
| Workspace Authorization | Lists authorized workspaces. After selection, the chart can query and display data from these workspaces. |
| Data Sampling | Only applicable to Doris log data engine workspaces. When enabled, it samples all data except metrics. The sampling rate adjusts dynamically based on data volume. |
| Time Offset | Non-time series data may experience at least a 1-minute delay after being indexed. When querying relative time ranges, this can lead to missing recent data.<br />Enabling time offset shifts the actual query time range back by 1 minute to prevent data loss due to indexing delays. For example, if the current time is 12:30 and you query the last 15 minutes of data, enabling time offset will adjust the query to cover 12:14-12:29.<br />:warning: <br /><li>This setting only applies to relative time queries. If the query specifies an absolute time range, time offset does not apply.<br /><li>For charts with time intervals (e.g., time series charts), time offset only applies if the interval is <= 1 minute. For charts without time intervals (e.g., summary charts, bar charts), time offset remains effective. |

## Common Configuration

| Option | Description |
| --- | --- |
| Title | Set a title for the chart, which appears in the top-left corner. You can choose to hide it. |
| Description | Add a description to the chart. Once set, an [i] icon will appear after the chart title. If not set, no icon will be displayed. |
| Unit | **Default unit display**:<br /><li>If the queried data is metric data and you have set units for the metric in [Metric Management](../../metrics/dictionary.md), the chart will use those units.<br /><li>If no units are configured in **Metric Management**, the chart will display values with thousand separators.<br />**After configuring units**: The chart prioritizes your custom unit settings. For metric data, you can choose between two options:<br /><br />**Scientific Notation Explanation**<br /><u>Default scaling</u>: Units are scaled in thousands, millions, etc., e.g., 10000 is displayed as 10K, 1000000 as 1 million. Two decimal places are retained.<br /><u>Short scale</u>: Units are K, M, B for thousand, million, billion, trillion, respectively. For instance, 1000 is 1k, 10000 is 10k, 1000000 is 1 million. Two decimal places are retained. |
| Color | Set the color for chart data. You can manually input predefined colors using the format: aggregation function(metric){"label": "label value"}, e.g., `last(usage_idle){"host": "guance_01"}`. |
| Legend | Choose legend placement (bottom, right, hidden). Clicking on a legend item hides/shows the corresponding metric. Legend values include min, max, p50, p75, p90, p99. |
| Data Format | Select decimal places and thousand separators.<br /><li>Thousand separators are enabled by default. Disabling them shows raw values without separators. More details can be found in [Data Thousand Separators](../visual-chart/chart-query.md#thousand). |
| Percentiles | By default, the chart displays p50, p75, p90, p99 percentiles as vertical lines to help visualize data distribution. |

## Event Correlation

By **adding filter fields**, match related incident events to the selected fields to achieve the purpose of correlating time series data with events. This feature helps users perceive whether relevant events occur during data fluctuations while viewing trends, aiding in problem localization from another perspective.

> For more details on related settings, refer to [Event Correlation](events-relative.md).

## Use Cases

Histograms in Guance are used to display the distribution trend of metric data over a period of time. They can be applied in the following scenarios:

- View the distribution of APM metric data within a specific time range, such as the distribution of "request counts" in the last 15 minutes.
- View the distribution of RUM metric data within a specific time range, such as the distribution of "error counts" in the last 15 minutes.
- Display the distribution of other log-type data containing `number` fields.