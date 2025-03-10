# Scatter Plot
---

A scatter plot shows the general trend of how the dependent variable changes with the independent variable. Based on this trend, an appropriate function can be chosen to fit the empirical distribution, thereby finding the functional relationship between variables.

![](../img/scatter.png)

## Use Cases

Used to observe the distribution and aggregation of data. For example, you can view the distribution of CPU system usage and user usage rates across different hosts.


## Chart Query

Define filtering conditions for the X-axis and Y-axis separately. You can switch to expression queries, PromQL queries, or other data source queries.

The Measurement sets and Metrics can differ, but the by (grouping) Tags must be consistent. Modifying one query condition automatically updates the other.

> For more detailed information on chart query conditions, refer to [Chart Query](chart-query.md).

## Chart Configuration

> For more details, refer to [Chart Configuration](./chart-config.md).


<!--
## Chart Links

Links help you jump from the current chart to a target page; they can include internal platform links and external links. Template variables can modify corresponding variable values in the link to pass data information, achieving data synchronization.

> For more related settings, refer to [Chart Links](chart-link.md).

## Common Configurations

| Option | Description |
| --- | --- |
| Title | Set a title for the chart, which will appear in the top-left corner of the chart. Supports hiding.|
| Description | Add a description to the chart. After setting, an [i] icon appears after the chart title. If not set, it does not display. |
| Unit | **:material-numeric-1-box: Default unit display**:<br /><li>If the queried data is Metrics data and you have set units for the Metrics in [Metrics Management](../../metrics/dictionary.md), the default display follows the configured units.<br /><li>If no units are configured in **Metrics Management**, the data is displayed using thousand separators.<br />**:material-numeric-2-box: After configuring units**:<br />Custom-defined units take priority. For Metrics data, two options are provided for formatting numbers:<br /><br />**Scientific Notation Explanation**<br /><u>Default scaling</u>: Units are in ten thousand, million, etc., such as 10000 displayed as 1 ten thousand, 1000000 as 1 million. Two decimal places are retained.<br /><u>Short scale</u>: Units are K, M, B. That is, thousand, million, billion, trillion, etc., like 1000 as 1k, 10000 as 10k, 1000000 as 1M. Two decimal places are retained.|
| Color | Set the color for chart data, supporting custom preset colors. Input format: aggregate_function(Metric){"label": "label_value"}, e.g., `last(usage_idle){"host": "guance_01"}`. |
| Alias | <li>Supports adding aliases to grouped queries. After adding an alias, the legend name changes accordingly, making it easier to distinguish related Metrics.<br/><li>Supports custom preset aliases, input format: aggregate_function(Metric){"label": "label_value"}, e.g., `last(usage_idle){"host": "guance_01"}`. |
| Data Format | Choose the number of decimal places and whether to use thousand separators.<br /><li>Thousand separators are enabled by default. Disabling them displays the raw value without separators. More details can be found at [Data Thousand Separators](../visual-chart/chart-query.md#thousand). |

## Advanced Configuration

| Option | Description |
| --- | --- |
| Lock Time Range | Fix the time range for querying data in the current chart, independent of the global time widget. After setting, the user-defined time appears in the top-right corner of the chart, such as [xx minutes], [xx hours], [xx days]. For example, if the locked time interval is 30 minutes, the chart will always show data from the last 30 minutes regardless of the selected time range. |
| Field Mapping | This works with object mapping in view variables. By default, it is off. If object mapping is configured in view variables:<br /><li>Enabling field mapping shows the **grouped fields** and corresponding **mapped fields** in the chart; unmapped grouped fields are not shown.<br /><li>Disabling field mapping results in normal chart display without showing mapped fields. |
| Workspace Authorization | Authorized workspace list. Selecting workspaces allows querying and displaying data from those workspaces via the chart. |
| Data Sampling | Only applicable to Doris log data engine workspaces; when enabled, non-Metrics data is sampled, with a dynamic sampling rate based on data volume. |
| Time Offset | Non-time series data has at least a 1-minute delay after being stored. When selecting relative time ranges, recent data might not be collected, leading to missing data.<br />Enabling time offset shifts the actual query time range forward by 1 minute to prevent data loss due to storage delays. For example, at 12:30, querying the last 15 minutes of data would actually query from 12:14 to 12:29.<br />:warning: <br /><li>This setting only applies to relative time ranges. If the query is for an absolute time range, time offset does not apply.<br /><li>For charts with time intervals, such as time series charts, time offset only applies if the interval is <= 1 minute. For charts without time intervals, such as summary or bar charts, time offset remains effective.
-->