# Table Chart
---

The table chart has the characteristic of intuitively displaying statistical information and reflecting relationships between data.

It includes two types of charts:

- Grouped Table Chart (default selection)
- Time Series Table Chart

![](../img/table.png)

## Chart Query

1. Supports adding multiple queries, but the grouping labels must be consistent. Modifying one query will automatically synchronize changes to others.
2. Supports sorting by metrics. By default, it sorts by the first query's metric. Clicking on the column header toggles ascending/descending order, which synchronizes with the Top/Bottom settings in the corresponding query. Clicking on other queries' metrics for sorting also synchronizes the Top/Bottom settings in the corresponding query.

> For more details, refer to [Chart Query](./chart-query.md).

## Chart Configuration

> For more details, refer to [Chart Configuration](./chart-config.md).

### Table Configuration

#### Enable Pagination

Enabling pagination allows you to choose the number of items displayed per page, including 10, 20, 50, and 100 items.

#### Display Columns

You can select the columns to display from the queried data. If there are many columns, you can customize and manually input column names. The final query results can be used as [value variables](chart-link.md#z-variate) for link navigation.

In edit mode, you can manually adjust column widths, and after saving the chart, the list information will be displayed according to the column width. You can also **drag and drop** to adjust the order of displayed columns, which will be shown in the configured sequence.

<img src="../../img/table-1.png" width="70%" >

<!--

## Common Configuration {#set}

The table chart includes two types: Grouped Table Chart and Time Series Table Chart (the former is selected by default).

### Title

1. Title: Set a title for the chart. After setting, it appears in the top-left corner of the chart, and supports hiding.
2. Description: Add a description to the chart. After setting, an [i] icon appears after the chart title; if not set, it does not display.

### Units

???+ abstract "About units for metric data"

    :material-numeric-1-circle: Default unit display:

    - If the queried data is metric data and you have set units for metrics in [Metric Management](../../metrics/dictionary.md), it defaults to displaying the metric's unit.
    - If no unit is configured in **Metric Management**, it displays numbers with [thousand separators](chart-query.md#thousand).

    :material-numeric-2-circle: After configuring units: It prioritizes using your custom-defined units. Metric data supports two options:

    - Default scaling: Units are ten thousand, million, etc., like 10000 displayed as 1 ten thousand, 1000000 displayed as 1 million. Retains two decimal places.
    - Short scale: Units are K, M, B, representing thousand, million, billion, trillion, etc. For example, 1000 is 1K, 10000 is 10K, 1000000 is 1M; retains two decimal places.

- Global:

Includes common unit formats across different dimensions, such as data size, time intervals, timestamps, etc.

In this mode, you can also select and input custom units in the dropdown, which will apply to the current chart upon pressing Enter.

- Custom: Select metrics included under the current query condition and input custom units.

### Alias

Add aliases to grouped queries. Adding an alias changes the legend name, making it easier to distinguish related metrics.

You can manually input preset aliases. The format is: aggregation function(metric){"label": "label value"}, such as `last(usage_idle){"host": "guance_01"}`.

### Data Formatting

1. Decimal Places: Choose 0, 1, 2, 3 decimal places or full precision.
2. [Thousand Separator](../visual-chart/chart-query.md#thousand): Thousand separators are enabled by default. Disabling them shows the original values without separators.

## Advanced Configuration

### Time

Lock Time: Fix the time range for querying data in the current chart, unaffected by the global time component. After setting, the user-defined time appears in the top-right corner of the chart, such as [xx minutes], [xx hours], [xx days]. If the locked time interval is 30 minutes, regardless of the time range selected in the time component, only the most recent 30 minutes of data will be displayed.

### Rule Mapping

Set metric ranges and corresponding background and font colors for different columns. Metrics within the specified range will display according to the set styles.

When a metric value meets multiple conditions, it displays the style of the last matching condition.

When setting value mappings, both the "Display As" and "Color" fields are optional:

- "Display As" defaults to empty, meaning no mapping value is displayed.
- "Color" defaults to empty, meaning no color mapping is applied.

### Workspace Authorization

Enabling this allows querying data from external workspaces under the current workspace.

Below the chart, you can select the target workspace from the authorized workspaces dropdown for querying.

### Data Sampling

Only applies to Doris log data engine workspaces.

After enabling, it samples queries for data other than "Metrics," with a dynamic sampling rate based on data volume.

### Time Offset

Non-time series data may have at least a 1-minute delay after being stored. When selecting relative time queries, this can result in missing data for the most recent few minutes.

Enabling time offset shifts the actual query time range forward by 1 minute when querying relative time intervals, preventing data loss due to storage delays. For example, if it's currently 12:30 and you query the last 15 minutes of data, enabling time offset means the actual query time is 12:14-12:29.

???+ warning "Notes"

    1. This setting only applies to relative time queries. If the query time range is an "absolute time range," time offset does not take effect.
    2. For charts with time intervals, such as time series charts, if the set time interval exceeds 1 minute, time offset does not take effect. For charts without time intervals, such as summary charts or bar charts, time offset remains effective.
-->