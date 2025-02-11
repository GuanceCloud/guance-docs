# China Map
---

Used to display the distribution of data for a specific metric across different provinces.

## Application Scenarios

1. View data that includes geographical location information;
2. View dispersed data, such as population density;
3. Compare data sizes using color intensity.

## Chart Query

**Prerequisites**: The data set queried for metrics must include a label representing `province`, and the query conditions must include grouping by `province`; otherwise, the chart cannot be added successfully.

Chart queries support **simple queries**, **expression queries**, **PromQL queries**, and **data source queries**; you can add multiple queries, but the tags used for grouping (by) must be consistent.

> For more detailed instructions, refer to [Chart Query](chart-query.md).

Chart queries match regions through province labels and colors through metric values:

| Option | Description |
| --- | --- |
| Province Label | Select the label representing the province. This label must be a grouped tag in the query.<br />:warning: The label name for the province does not have to be `province` as long as its values represent provincial administrative regions. |
| Metric | When multiple metric queries are added, you can set the primary metric to display. The "primary display metric" determines the gradient color for the blocks. |

<!--
## Common Configuration

| Option | Description |
| --- | --- |
| Title | Set a title for the chart. Once set, it will appear in the top-left corner of the chart and supports hiding. |
| Description | Add a description to the chart. If set, an [i] icon will appear after the chart title; if not set, it will not be displayed. |
| Color | Gradient intervals:<br/><li>Automatic: By default, the system divides the current data's maximum and minimum values into 5 intervals, with options to customize the maximum and minimum values;<br/><li>Custom: Supports custom gradient color levels, i.e., region range levels on the map. The system defaults to dividing the selected metric's max and min values into 5 gradient levels, with customizable level count (up to 10), range, and display colors.<br /><br/>Gradient color scheme: The gradient color of the blocks. After selecting a color, the system generates color blocks based on the selected color and the number of levels specified; default is 5 levels. |
| Legend | For more details, refer to [Legend Explanation](./timeseries-chart.md#legend). |
| Unit | **:material-numeric-1-box: Default unit display**:<br /><li>If the queried data is metric data and units are configured for the metric in [Metric Management](../../metrics/dictionary.md), the default display follows the metric's unit settings;<br /><li>If no units are configured in **Metric Management**, it displays numbers with thousand separators.<br />**:material-numeric-2-box: After configuring units**:<br />Prioritizes the custom-configured units for display. Metric data supports two options for numerical representation:<br /><br />**Scientific Notation Explanation**<br /><u>Default rounding</u>: Units are ten thousand (万), one hundred thousand (百万), etc., e.g., 10000 is shown as 1 万, 1000000 as 1 百万. Two decimal places are retained;<br /><u>Short scale</u>: Units are K, M, B. Representing thousand, million, billion, trillion, etc., in Chinese context. E.g., 1000 is 1 k, 10000 is 10 k, 1000000 is 1 million; two decimal places are retained.|
| Data Format | You can choose the number of decimal places and whether to use thousand separators.<br /><li>Thousand separators are enabled by default. If disabled, original values without separators are displayed. For more details, refer to [Data Thousand Separator Format](../visual-chart/chart-query.md#thousand). |

## Advanced Configuration

| Option | Description |
| --- | --- |
| Lock Time | Fix the time range for the current chart query data, unaffected by the global time component. After setting, the user-defined time appears in the top-right corner of the chart, such as [xx minutes], [xx hours], [xx days]. If the locked time interval is 30 minutes, regardless of the time range viewed via the time component, only the last 30 minutes of data will be displayed. |
| Field Mapping | Works with view variable object mapping, default is off. If object mapping is configured in view variables:<br /><li>When field mapping is enabled, the chart displays the **grouped fields** and corresponding **mapped fields**; unmapped grouped fields are not displayed;<br /><li>When field mapping is disabled, the chart displays normally without showing mapped fields. |
| Workspace Authorization | Authorized workspace list. After selection, the chart can query and display data from this workspace. |
| Data Sampling | Only applicable to Doris log data engine workspaces; when enabled, non-metric data undergoes sampling queries with a dynamic sampling rate based on data volume. |
| Time Offset | Non-time series data has at least a 1-minute delay after being stored. When querying relative time ranges, recent minutes' data might not be collected, leading to data loss.<br />Enabling time offset shifts the actual query time range forward by 1 minute to prevent data gaps due to storage delays. For example, at 12:30 PM, querying the last 15 minutes of data would actually query from 12:14 PM to 12:29 PM.<br />:warning: <br /><li>This setting only applies to relative time ranges; for absolute time ranges, time offset is ineffective.<br /><li>For charts with time intervals, such as time series charts, if the time interval exceeds 1 minute, the time offset is ineffective; for charts without time intervals, like summary or bar charts, the time offset remains effective.
-->