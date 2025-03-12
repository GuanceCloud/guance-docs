# Log Stream Chart
---

When displaying log data in the form of a time series table, you can customize the display range and column configuration of the logs. Additionally, the system supports searching and filtering log data related to hardware, software, system information, and events, presenting the results in a clear tabular format.

![](../img/log.png)

## Chart Query

1. Query: Supports queries with the data source fixed as **Logs**, and supports keyword search;
2. Filter: Apply filter conditions to refine the queried log data;
3. Display Columns: Choose which columns to display. The `message` content is present by default and can be renamed.


## Chart Configuration

> For more details, refer to [Chart Configuration](./chart-config.md).

<!--
## Common Configuration

| Option | Description |
| --- | --- |
| Title | Set a title for the chart, which will be displayed in the top-left corner of the chart. You can choose to hide it. |
| Description | Add a description to the chart. After setting, an 【i】 icon appears after the chart title; if not set, it does not display. |
| Unit | Select the unit for the display columns. Custom units are supported. When the content is numeric, users select the data unit; when non-numeric, users input the data unit. |

## Advanced Configuration

| Option | Description |
| --- | --- |
| Lock Time | Fix the time range for querying data in this chart, independent of the global time component. After successful setup, the user-defined time (e.g., 【xx minutes】, 【xx hours】, 【xx days】) appears in the top-right corner of the chart. |
| Formatting Configuration | Formatting configuration allows you to hide sensitive log data or highlight specific log data:<br /><li>Field: Added display columns;<br /><li>Match Type: Supports `=`, `!=`, `match`, `not match`;<br /><li>Match Content: Data content from query results;<br /><li>Display As: Replace with desired display content.<br /> |
-->