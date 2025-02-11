# Log Stream Chart
---

Displays log data in the form of a time series table. You can customize the displayed log range and columns. Additionally, you can search for and filter logs recorded in the system, such as hardware, software, system information, and events, and display them.

![](../img/log.png)

## Chart Query

1. Query: Supports queries with a fixed data source of **Logs**, and supports keyword searches;
2. Filter: Filters queried log data by entering filter conditions;
3. Display Columns: Choose the columns to display. The `message` content is included by default and can be renamed.


## Chart Configuration

> For more details, refer to [Chart Configuration](./chart-config.md).

<!--
## Common Configuration

| Option | Description |
| --- | --- |
| Title | Set a title for the chart, which will be displayed in the top-left corner of the chart. It supports hiding the title. |
| Description | Add a description to the chart. After setting it, an [i] icon will appear after the chart title, displaying the description when hovered over. If not set, it does not display. |
| Unit | Select the unit for the display column. Supports custom units. When the content is numeric, users can choose a data unit; for non-numeric content, users can input a data unit. |

## Advanced Configuration

| Option | Description |
| --- | --- |
| Lock Time Range | Fixes the time range for querying data in the current chart, unaffected by the global time component. After successful setup, the user-defined time (e.g., [xx minutes], [xx hours], [xx days]) will appear in the top-right corner of the chart. |
| Formatting Configuration | Allows hiding sensitive log data or highlighting important log data:<br /><li>Field: Added display columns;<br /><li>Matching Method: Supports `=`, `!=`, `match`, `not match`;<br /><li>Matched Content: Data content from query results;<br /><li>Display As: Replace with desired content.<br /> |
-->