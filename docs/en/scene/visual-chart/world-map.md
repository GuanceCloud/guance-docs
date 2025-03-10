# World Map
---

Used to display the distribution of data across different geographic locations, with colors representing the magnitude of the data.



## Use Cases

1. Displaying data distribution across different regions;
2. Showing rankings of data magnitude by region.

## Chart Query

**Prerequisites:** The Measurement query dataset must include a tag that represents "Country," and the query conditions must include grouping by "Country." Otherwise, the chart cannot be added successfully.

Default simple queries are added. Multiple queries can be added, but the Tag for by (grouping) must be consistent. Modifying one will automatically synchronize changes to others.

> For more detailed explanations of chart query conditions, refer to [Chart Query](chart-query.md).

Chart queries match regions via country and color via Metrics values:

| Option | Description |
| --- | --- |
| Country Tag | Select the tag that represents the country. This tag must be a grouped tag in the query. The tag name does not have to be "Country" as long as its values represent countries. |
| Metric | When multiple Metrics queries are added, you can set the primary displayed Metric. The "Primary Displayed Metric" determines the gradient color of the color blocks. |

<!--
## Chart Links

Links help you navigate from the current chart to target pages; internal and external links can be added; template variables can modify corresponding variable values in the link to pass data information, completing data linkage.

> For more related settings, refer to [Chart Links](chart-link.md).



## Common Configurations

| Option | Description |
| --- | --- |
| Title | Set a title for the chart. Once set, it will appear in the top-left corner of the chart and supports hiding. |
| Description | Add a description to the chart. After setting, an [i] prompt will appear after the chart title. If not set, it will not be displayed. |
| Color | Gradient intervals:<br/><li>Automatic: By default, the system divides the data into 5 intervals based on the maximum and minimum values, supporting custom maximum and minimum values;<br/><li>Custom: Supports customizing gradient color levels, i.e., setting the level of regional ranges on the map. The system defaults to dividing the selected Metric's max and min values into 5 gradient levels, supporting up to 10 levels, range customization, and display colors.<br/><br/>Gradient color scheme: The gradient color of the color blocks. After selecting a color, the system generates color blocks based on the selected color and the number of levels; includes 5 levels. |
| Legend | For more details, refer to [Legend Explanation](./timeseries-chart.md#legend). |
| Unit | **:material-numeric-1-box: Default unit display**:<br /><li>If the queried data is Metrics data and you have set units for Metrics in [Metric Management](../../metrics/dictionary.md), the system will display the data according to the set units;<br /><li>If no units are configured in **Metric Management**, it will display using thousand separators.<br />**:material-numeric-2-box: After configuring units**:<br />It prioritizes using your custom-configured units for display. For Metrics data, two options are supported:<br /><br />**Scientific Notation Explanation**<br /><u>Default rounding</u>: Units are ten thousand, million, etc., such as 10000 displayed as 1 ten thousand, 1000000 displayed as 1 million. Two decimal places are retained;<br /><u>Short scale</u>: Units are K, M, B. That is, thousand, million, billion, trillion, etc. For example, 1000 is 1 k, 10000 is 10 k, 1000000 is 1 million; two decimal places are retained.|
| Data Format | You can choose the number of decimal places and the thousand separator.<br /><li>The thousand separator is enabled by default. Disabling it will display the original value without any separators. For more details, refer to [Data Thousand Separator Format](../visual-chart/chart-query.md#thousand). |

## Advanced Configuration

| Option | Description |
| --- | --- |
| Lock Time | Fixes the time range for the current chart query data, unaffected by the global time component. After successful setup, the user-defined time appears in the top-right corner of the chart, such as [xx minutes], [xx hours], [xx days]. If the locked time interval is 30 minutes, then regardless of the time range view adjusted by the time component, only the most recent 30 minutes of data will be displayed. |
| Field Mapping | Works with object mapping features of view variables. By default, it is disabled. If object mapping is configured in view variables:<br /><li>Enabling field mapping displays the **grouped fields** and corresponding **mapped fields** in the chart, while unmapped grouped fields are not shown;<br /><li>Disabling field mapping shows the chart normally without displaying mapped fields.<br /> |
| Workspace Authorization | Authorized workspace list. After selection, the chart can query and display data from the authorized workspace. |
| Data Sampling | Applies only to workspaces using the Doris log data engine. When enabled, it samples data other than "Metrics," with a non-fixed sampling rate that dynamically adjusts based on data volume. |
| Time Offset | Non-time series data has at least a 1-minute delay after being stored. When selecting relative time queries, this may result in missing data from the last few minutes due to ingestion delays.<br />Enabling time offset shifts the actual query time range forward by 1 minute when querying relative time intervals to prevent empty data retrieval due to ingestion delays. For example, if it is currently 12:30 and you query the last 15 minutes of data, enabling time offset will actually query the time range from 12:14 to 12:29.<br />:warning: <br /><li>This setting applies only to relative time queries. If the query time range is an "absolute time range," time offset does not apply.<br /><li>For charts with time intervals, such as time series charts, time offset does not apply if the set time interval exceeds 1 minute. It only applies if the interval is <= 1 minute. For charts without time intervals, such as summary charts or bar charts, time offset remains effective. |
-->