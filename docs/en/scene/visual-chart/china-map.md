# China Map
---

Used to display the distribution of a certain Metrics data across different provinces.

## Use Cases

1. View data containing geographical location information;
2. View dispersed data, such as population density;
3. Compare data sizes through color intensity.

## Chart Query

**Prerequisites**: The data set queried for Metrics must contain a tag representing `province`, and the query conditions must include grouping by `province`; otherwise, the chart cannot be successfully added.

Chart queries support **simple queries**, **expression queries**, **PromQL queries**, and **data source queries**; you can add multiple queries, but the by (grouping) Tag must be consistent.

> For more detailed instructions, refer to [Chart Query](chart-query.md).

Chart queries match regions via provinces and colors via Metrics values:

| Option | Description |
| --- | --- |
| Province Tag | Select the tag representing the province. This tag must be a grouped tag in the query.<br />:warning: The tag name for the province tag does not have to be `province` as long as its values represent provincial administrative regions. |
| Metrics | When multiple Metrics queries are added, you can set the primary displayed Metrics. The "main display Metrics" determines the gradient color of the color blocks. |

<!--
## Common Configuration

| Option | Description |
| --- | --- |
| Title | Set a title for the chart, which will be displayed in the top-left corner of the chart after setting. It supports hiding the title.|
| Description | Add a description to the chart. After setting, an [i] prompt will appear after the chart title; if not set, it will not be displayed. |
| Color | Gradient range:<br/><li>Automatic: By default, the current data's maximum and minimum values are divided into 5 intervals, supporting custom maximum and minimum values;<br/><li>Custom: Support custom gradient color levels, i.e., region grade settings on the map. The system defaults to dividing the selected Metrics' max and min values into 5 gradient levels, supporting up to 10 custom levels, ranges, and display colors.<br/><br/>Gradient color series: The gradient color of the color blocks. After selecting a color, the system generates color blocks based on the selected color and the number of levels; including 5 levels. |
| Legend | For more details, refer to [Legend Explanation](./timeseries-chart.md#legend). |
| Unit | **:material-numeric-1-box: Default unit display**:<br /><li>If the queried data is Metrics data and you have set units for the Metrics in [Metrics Management](../../metrics/dictionary.md), it will be displayed according to the unit set for the Metrics;<br /><li>If there is no related unit configuration in **Metrics Management**, it will be displayed using comma-separated thousandths notation.<br />**:material-numeric-2-box: After configuring units**:<br />It will prioritize using your custom-configured units for display. For Metrics data, two options are provided for numerical values:<br /><br />**Scientific Notation Explanation**<br /><u>Default progression</u>: Units are ten thousand, million, etc. For example, 10000 is displayed as 1 ten thousand, 1000000 as 1 million. Two decimal places are retained;<br /><u>Short scale</u>: Units are K, M, B. That is, thousand, million, billion, trillion, etc. For example, 1000 is 1 k, 10000 is 10 k, 1000000 is 1 million; two decimal places are retained.|
| Data Format | You can choose the number of decimal places and whether to use thousand separators.<br /><li>Thousand separators are enabled by default. If turned off, the original value without separators will be displayed. For more details, refer to [Data Thousand Separator Formatting](../visual-chart/chart-query.md#thousand). |

## Advanced Configuration

| Option | Description |
| --- | --- |
| Lock Time | Fix the time range of the current chart query data, unaffected by the global time component. After successful setup, the user-defined time will appear in the top-right corner of the chart, such as [xx minutes], [xx hours], [xx days]. For example, if the locked time interval is 30 minutes, regardless of what time range view is queried using the time component, only the last 30 minutes of data will be displayed. |
| Field Mapping | Object mapping function that works with view variables. By default, it is disabled. If object mapping has been configured in view variables:<br /><li>When field mapping is enabled, the chart displays the **grouped fields** and corresponding **mapped fields**; unassigned mapped fields do not display;<br /><li>When field mapping is disabled, the chart displays normally without showing the mapped fields.<br /> |
| Workspace Authorization | Authorized workspace lists. After selection, the chart can query and display data from these workspaces. |
| Data Sampling | Only for workspaces using the Doris log data engine; when enabled, it samples all data except Metrics, with a dynamic sampling rate based on data volume. |
| Time Offset | Non-time-series data may experience at least a 1-minute delay after being stored. When querying relative time, this might result in missing data from the most recent few minutes.<br />Enabling time offset shifts the actual query time range forward by 1 minute when querying relative time intervals to prevent data loss due to storage delays. For example, if it's currently 12:30 and you query the last 15 minutes of data, enabling time offset means the actual query time is 12:14-12:29.<br />:warning: <br /><li>This setting only applies to relative time queries. If the query time range is an absolute time range, time offset does not apply.<br /><li>For charts with time intervals, such as time series charts, time offset only applies if the set interval is <= 1 minute. For charts without time intervals, like overview charts or bar charts, time offset remains effective.|
-->