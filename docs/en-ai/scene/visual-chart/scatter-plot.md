# Scatter Plot
---

A scatter plot shows the general trend of how a dependent variable changes with an independent variable. Based on this trend, you can choose an appropriate function for empirical distribution fitting to find the functional relationship between variables.

![](../img/scatter.png)

## Application Scenarios

It is used to observe the distribution and aggregation of data. For example, you can view the distribution of CPU system usage and user usage across different hosts.


## Chart Query

Define the filtering conditions for the X-axis and Y-axis separately. You can switch to expression queries, PromQL queries, and other data source queries.

The queried Mearsurements and Metrics can differ, but the by (grouping) Tag must be consistent. Modifying one query condition will automatically synchronize changes to the other.

> For more detailed explanations of chart query conditions, refer to [Chart Query](chart-query.md).

## Chart Configuration

> For more details, refer to [Chart Configuration](./chart-config.md).


<!--
## Chart Links

Links help you navigate from the current chart to the target page; they support adding internal platform links and external links. You can also use template variables to modify corresponding variable values in the link, enabling data联动.

> For more related settings, refer to [Chart Links](chart-link.md).

## Common Configurations

| Option | Description |
| --- | --- |
| Title | Set a title name for the chart, which appears in the top-left corner of the chart after setting. Supports hiding. |
| Description | Add a description to the chart. After setting, an 【i】 hint appears after the chart title. If not set, it does not display. |
| Unit | **:material-numeric-1-box: Default Unit Display**:<br /><li>If the queried data is Metrics data and you have set units for the Metrics in [Metrics Management](../../metrics/dictionary.md), the default display follows the unit configured for the Metrics.<br /><li>If no related unit configuration exists in **Metrics Management**, it displays using thousand separator notation.<br />**:material-numeric-2-box: After configuring a unit**:<br />It prioritizes the custom unit you configured for scaling display. Metric data supports two options for numerical scaling:<br /><br />**Scientific Notation Explanation**<br /><u>Default Scaling</u>: Units are 万 (ten thousand), 百万 (hundred thousand), etc., e.g., 10000 is displayed as 1 万, 1000000 as 1 百万. Retains two decimal places;<br /><u>Short Scale</u>: Units are K, M, B. i.e., thousand, million, billion, trillion, etc., representing thousand, million, billion, trillion, etc., in Chinese context. E.g., 1000 is 1 k, 10000 is 10 k, 1000000 is 1 million; retains two decimal places.|
| Color | Set the display color for chart data, supporting custom preset colors. Input format: aggregation function(Metric){"label": "label value"}, such as `last(usage_idle){"host": "guance_01"}`. |
| Alias | <li>Supports adding aliases to grouped queries. After adding an alias, the legend name changes accordingly, making it easier to distinguish related Metrics.<br/><li>Supports custom preset aliases, input format: aggregation function(Metric){"label": "label value"}, such as `last(usage_idle){"host": "guance_01"}`. |
| Data Format | Choose the number of decimal places and whether to use thousand separators.<br /><li>Thousand separators are enabled by default. When disabled, raw values are displayed without separators. More details can be found at [Data Thousand Separator Formatting](../visual-chart/chart-query.md#thousand). |

## Advanced Configuration

| Option | Description |
| --- | --- |
| Lock Time | Fix the time range for querying data in the current chart, unaffected by the global time component. After successful configuration, the user-defined time appears in the top-right corner of the chart, such as 【xx minutes】, 【xx hours】, 【xx days】. For instance, if the locked time interval is 30 minutes, regardless of what time range is selected via the time component, only the most recent 30 minutes of data will be displayed. |
| Field Mapping | Works with object mapping features of view variables. By default, it is off. If object mapping has been configured in view variables:<br /><li>When field mapping is enabled, the chart displays the **grouped fields** and corresponding **mapped fields**. Unmapped grouped fields are not shown.<br /><li>When field mapping is disabled, the chart displays normally without showing mapped fields. |
| Workspace Authorization | Authorized workspace lists. After selection, the chart can query and display data from the chosen workspaces. |
| Data Sampling | Applies only to workspaces using the Doris log data engine. When enabled, it samples non-Metrics data dynamically based on data volume. |
| Time Offset | Non-time series data may have at least a 1-minute delay after being stored. Selecting relative time queries might result in missing recent data due to delays, leading to empty results.<br />Enabling time offset adjusts the actual query time range forward by 1 minute when querying relative time intervals to prevent data loss caused by storage delays. For example, at 12:30, querying the last 15 minutes of data would actually query from 12:14 to 12:29.<br />:warning: <br /><li>This setting applies only to relative time queries. If the query time range is an absolute time range, time offset does not apply.<br /><li>For charts with time intervals, like time series charts, if the set time interval exceeds 1 minute, time offset does not apply. For charts without time intervals, such as summary or bar charts, time offset remains effective.
-->