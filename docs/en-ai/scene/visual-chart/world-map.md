# World Map
---

Used to display the distribution of data across different geographical locations, with colors representing the magnitude of the data.



## Application Scenarios

1. Displaying the distribution of data in different regions;
2. Showing the ranking of data sizes in different regions.

## Chart Query

**Prerequisites:** The dataset for metrics query must include a tag indicating "country," and the query conditions must include grouping by "country." Otherwise, the chart cannot be successfully added.

By default, a simple query is added. Multiple queries can be added, but the Tag used for grouping (by) must be consistent. Changes to one will automatically synchronize changes to others.

> For more detailed explanations of chart query conditions, refer to [Chart Query](chart-query.md).

The chart query matches regions via country and colors via metric values:

| Option | Description |
| --- | --- |
| Country Tag | Select the tag that represents the country. This tag must be a grouped tag in the query.<br />The tag name does not have to be "country" as long as its values are countries. |
| Metric | When multiple metric queries are added, you can set the primary metric to display. The "primary display metric" determines the gradient color of the blocks. |

<!--
## Chart Links

Links help you navigate from the current chart to a target page; they support internal and external links. You can also use template variables to modify the corresponding variable values in the link, enabling data linkage.

> For more related settings, refer to [Chart Links](chart-link.md).



## Common Configurations

| Option | Description |
| --- | --- |
| Title | Set a title for the chart, which will be displayed in the top-left corner of the chart. It supports hiding the title. |
| Description | Add a description to the chart. After setting it, an [i] icon will appear after the chart title. If not set, it will not be displayed. |
| Color | Gradient intervals:<br/><li>Automatic: By default, the system divides the data into 5 intervals based on the maximum and minimum values, supporting custom max and min values;<br/><li>Custom: Supports customizing the gradient color levels, i.e., setting the region levels in the map. The system defaults to dividing the selected metric's max and min values into 5 gradient levels, supporting up to 10 levels, range customization, and color selection.<br /><br/>Gradient colors: The gradient color of the blocks. After selecting a color, the system generates color blocks based on the selected levels; includes 5 levels. |
| Legend | For more details, refer to [Legend Explanation](./timeseries-chart.md#legend). |
| Unit | **:material-numeric-1-box: Default unit display**:<br /><li>If the queried data is metric data and you have set units for the metric in [Metric Management](../../metrics/dictionary.md), the system will display the data according to the set units;<br /><li>If no unit configuration exists in **Metric Management**, the data will be displayed using thousand separators.<br />**:material-numeric-2-box: After configuring units**:<br />It prioritizes your custom-configured units for display. For metric data, two options are supported:<br /><br />**Scientific Notation Explanation**<br /><u>Default Scaling</u>: Units are ten thousand, hundred thousand, etc., e.g., 10000 displays as 1 ten thousand, 1000000 displays as 1 million. Retains two decimal places;<br /><u>Short Scale</u>: Units are K, M, B. That is, thousand, million, billion, trillion, etc., sequentially represent thousand, million, billion, trillion, etc., in Chinese context. For example, 1000 is 1k, 10000 is 10k, 1000000 is 1M; retains two decimal places.|
| Data Format | You can choose the number of decimal places and the thousands separator.<br /><li>The thousands separator is enabled by default. Disabling it will show the original value without separators. For more details, refer to [Thousand Separator Formatting](../visual-chart/chart-query.md#thousand). |

## Advanced Configurations

| Option | Description |
| --- | --- |
| Lock Time | Fixes the time range for the current chart query data, unaffected by the global time component. After setting this, the upper-right corner of the chart will show the user-defined time, such as ["xx minutes"], ["xx hours"], ["xx days"]. If the lock time interval is 30 minutes, regardless of the time range selected in the time component, only the latest 30 minutes of data will be displayed. |
| Field Mapping | Works with view variable object mapping, default is off. If object mapping is configured in view variables:<br /><li>When field mapping is enabled, the chart displays the **grouped fields** and their corresponding **mapped fields**; unmapped grouped fields are not shown;<br /><li>When field mapping is disabled, the chart displays normally without showing mapped fields. |
| Workspace Authorization | Authorized workspace lists. After selection, the chart can query and display data from the selected workspaces. |
| Data Sampling | Only for Doris log data engine workspaces; when enabled, it samples data other than "metrics," with a dynamic sampling rate based on data volume. |
| Time Offset | Non-time series data may have at least a 1-minute query delay after being stored. When querying relative time ranges, recent minutes' data might not be collected, leading to data loss.<br />Enabling time offset shifts the actual query time range forward by 1 minute when querying relative time intervals, preventing data gaps due to storage delays. For example, if it's currently 12:30 and you query the last 15 minutes of data, with time offset enabled, the actual query time range is 12:14-12:29.<br />:warning: <br /><li>This setting only applies to relative time ranges. If querying absolute time ranges, time offset does not apply.<br /><li>For charts with time intervals, like time series charts, time offset does not apply if the interval exceeds 1 minute. For charts without time intervals, like summary or bar charts, time offset remains effective.|
-->