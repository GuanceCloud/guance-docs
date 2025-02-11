# Bubble Chart
---

The bubble chart can be used to display the relationship between three variables. Similar to a scatter plot, it has an X-axis and a Y-axis, with an additional variable representing size for comparison. It illustrates the general trend of how the dependent variable changes with the independent variable. This trend can help select an appropriate function for empirical distribution fitting, thereby finding the functional relationship between variables. It can be used to observe the distribution and aggregation of data.

![](../img/bubble.png)

## Chart Query

Define the filtering conditions for the X-axis and Y-axis separately. You can switch to expression queries, PromQL queries, or other data source queries.

> For more details, refer to [Chart Query](./chart-query.md).

## Chart Configuration

> For more details, refer to [Chart Configuration](./chart-config.md).

<!--
## Common Configuration

| Option | Description |
| --- | --- |
| Title | Set a title for the chart. Once set, it will appear in the top-left corner of the chart and supports hiding. |
| Description | Add a description to the chart. After setting, an [i] prompt will appear after the chart title; if not set, it will not be displayed. |
| Unit | **:material-numeric-1-box: Default unit display**:<br /><li>If the queried data is metrics data, and you have set units for the metrics in [Metrics Management](../../metrics/dictionary.md), the default display will follow the units set for the metrics;<br /><li>If no related unit configuration exists in **Metrics Management**, it will display using the [thousand separator](chart-query.md#thousand) format.<br />**:material-numeric-2-box: After configuring units**:<br />It prioritizes the custom configured units for scaling display. For metrics data, two options are available for numerical values:<br /><br />**Scientific Notation Explanation**<br /><u>Default Scaling</u>: Units are in ten thousand, million, etc., e.g., 10000 is displayed as 1 ten thousand, 1000000 as 1 million. Two decimal places are retained;<br /><u>Short Scale</u>: Units are K, M, B. That is, thousand, million, billion, trillion, etc., in Chinese context. E.g., 1000 is 1K, 10000 is 10K, 1000000 is 1M; two decimal places are retained. |
| Color | Set the display color for the chart data, supporting custom manual input of preset colors. Input format: aggregate_function(metrics){"label": "label_value"}, e.g., `last(usage_idle){"host": "guance_01"}`. |
| Alias | <li>Supports adding aliases to grouped queries. After adding an alias, the legend name changes accordingly, making it easier to distinguish related metrics.<br/><li>Supports custom manual input of preset aliases. Input format: aggregate_function(metrics){"label": "label_value"}, e.g., `last(usage_idle){"host": "guance_01"}`. |
| Data Format | Choose the number of decimal places and whether to use a thousand separator.<br /><li>The thousand separator is enabled by default. When disabled, the original value is displayed without separators. For more details, refer to [Data Thousand Separator Format](../visual-chart/chart-query.md#thousand). |

## Advanced Configuration

| Option | Description |
| --- | --- |
| Lock Time Range | Fix the time range for querying current chart data, unaffected by the global time component. After successful setup, the user-defined time (e.g., minutes, hours, days) will appear in the top-right corner of the chart. If the lock time interval is 30 minutes, regardless of the time range selected via the time component, only the data from the last 30 minutes will be displayed. |
| Field Mapping | Used with view variable object mapping functionality, which is off by default. If object mapping is configured in the view variable:<br /><li>When field mapping is enabled, the chart displays the **grouped fields** and corresponding **mapped fields**; unmapped grouped fields are not shown;<br /><li>When field mapping is disabled, the chart displays normally without showing mapped fields. |
| Workspace Authorization | List of authorized workspaces. After selection, the chart can query and display data from these workspaces. |
| Data Sampling | Only applicable to Doris log data engine workspaces; when enabled, it samples all data except "metrics." The sampling rate varies dynamically based on data volume. |
| Time Offset | Non-time series data may experience at least a 1-minute delay after being stored. Selecting relative time queries might result in missing recent data due to this delay.<br />Enabling time offset adjusts the actual query time range forward by 1 minute when querying relative time intervals to prevent empty data retrieval due to storage delays. For example, if it's 12:30 and you query the last 15 minutes of data, with time offset enabled, the actual query time is 12:14-12:29.<br />:warning: <br /><li>This setting only applies to relative time queries. If the query time range is an "absolute time range," time offset does not apply.<br /><li>For charts with time intervals, such as time series charts, time offset only applies when the set time interval is <= 1 minute. For charts without time intervals, like summary charts or bar charts, time offset remains effective.
-->