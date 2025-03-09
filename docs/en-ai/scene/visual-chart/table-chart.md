# Table Chart
---

The table chart is characterized by its ability to intuitively display statistical information and reflect relationships between data.

It includes two types of charts:

- Grouped Table Chart (default selection)
- Time Series Table Chart

![](../img/table.png)

## Chart Query

1. Supports adding multiple queries, but the grouping labels must be consistent; modifying one automatically synchronizes changes to others.
2. Supports metric sorting, defaulting to sorting by the first query's metric. Clicking on the column header toggles ascending/descending order, and the Top/Bottom settings in the corresponding query are synchronized. Clicking on metrics from other queries for sorting also synchronizes the Top/Bottom settings in the corresponding query.

> For more details, refer to [Chart Query](./chart-query.md).

## Chart Configuration

> For more details, refer to [Chart Configuration](./chart-config.md).

### Table Configuration

#### Enable Pagination

Enabling pagination allows you to choose the number of items displayed per page, including 10, 20, 50, and 100 items.

#### Display Columns

You can select which columns of queried data to display. If there are many columns, you can customize and manually input column names. The final query result values can be used as [value variables](chart-link.md#z-variate) for link navigation;

In edit mode, you can manually adjust column widths, and after saving the current chart, the list information will be displayed according to the column width. You can also **drag and drop** to adjust the order of displayed columns, and the list will be shown according to the configured sequence.

<img src="../../img/table-1.png" width="70%" >

<!--
## Common Configurations {#set}

The table chart includes two types: grouped table chart and time series table chart (the former is selected by default).

### Title

1. Title: Set a title for the chart, which appears in the top-left corner of the chart after setting. It supports hiding.
2. Description: Add a description to the chart. After setting, an [i] hint appears after the chart title. If not set, it does not display.

### Units

???+ abstract "About unit display for metric data"

    :material-numeric-1-circle: Default unit display:

    - If the queried data is metric data and you have set units for the metric in [Metric Management](../../metrics/dictionary.md), it will be displayed using the metric's unit.
    - If no related unit is configured in **Metric Management**, it will be displayed with thousand separators as specified in [thousand separator](chart-query.md#thousand).

    :material-numeric-2-circle: After configuring units: it prioritizes displaying with your custom-configured units. Metric data supports two options for numerical formatting:

    - Default scaling: units of ten thousand, million, etc., such as 10000 displayed as 10K, 1000000 as 1M. Two decimal places are retained.
    - Short scale: units of K, M, B. That is, thousand, million, billion, trillion, etc., like 1000 as 1K, 10000 as 10K, 1000000 as 1M; two decimal places are retained.


- Global:

Includes common unit formats across different dimensions, such as data size, time intervals, timestamps, etc.

In this mode, you can also enter custom units in the dropdown box and apply them to the current chart by pressing Enter.


- Custom: Select the metrics included under the current query conditions and input custom units.

### Alias

This adds aliases to grouped queries. After adding an alias, the legend name changes accordingly, making it easier to distinguish related metrics.

You can manually input preset aliases, formatted as: aggregation function(metric){"label": "label value"}, such as `last(usage_idle){"host": "guance_01"`.


### Data Format

1. Decimal Places: Choose 0, 1, 2, 3 decimal places or full precision.

2. [Thousand Separator](../visual-chart/chart-query.md#thousand): Thousand separators are enabled by default. Disabling them displays the original value without separators.


## Advanced Configuration

### Time

Lock Time: This fixes the time range for querying data in the current chart, independent of the global time component. After successful setup, the user-defined time appears in the top-right corner of the chart, such as 【xx minutes】, 【xx hours】, 【xx days】. If the locked time interval is 30 minutes, regardless of the time range viewed, only the most recent 30 minutes of data will be displayed.

### Rule Mapping

Set metric ranges and corresponding background and font colors for different columns. Metrics within the set ranges will be displayed in the configured styles.

When a metric value meets multiple settings, it will display the style of the last condition met.

For value mapping settings, neither the ["Display As"] nor ["Color"] fields are mandatory:

- ["Display As"] defaults to empty, meaning no mapping value is displayed.
- ["Color"] defaults to empty, meaning the original color is displayed.

### Workspace Authorization

When enabled, you can query data from external workspaces within the current chart of the current workspace.

Below the chart, you can select the target workspace from the authorized workspace dropdown list for querying.

### Data Sampling

Applicable only to workspaces using the Doris log data engine.

When enabled, it samples all non-metric data, with a dynamic sampling rate based on data volume.

### Time Offset

Non-time series data has at least a 1-minute delay after being stored, leading to potential data loss when querying recent minutes.

Enabling time offset shifts the actual query time range forward by 1 minute when querying relative time intervals, preventing data gaps due to storage delays. For example, if the current time is 12:30 and you query the last 15 minutes of data, enabling time offset means the actual query time is 12:14-12:29.

???+ warning "Notes"

    1. This setting applies only to relative time queries. If the query time range is an "absolute time range," time offset does not apply.
    2. For charts with time intervals, such as time series charts, if the set time interval exceeds 1 minute, time offset does not apply. For charts without time intervals, such as summary charts or bar charts, time offset remains effective.
-->