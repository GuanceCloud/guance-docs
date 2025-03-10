# Log List

---

The log viewer is one of the core tools for you to perform log analysis and troubleshoot issues. Facing the massive amount of log data collected and reported by <<< custom_key.brand_name >>>, you can achieve efficient log management through various operations such as searching, filtering, and exporting.

## View Mode {#mode}

- Standard Mode: Fields are displayed in columns;

<img src="../img/log_view_model.png" width="70%" >

- Stacked Mode: Except for the time field (`time`), all other fields will be merged into a single column and displayed in multiple lines within the cell.

<img src="../img/log_view_model_1.png" width="70%" >

In stacked mode, you can perform graphical operations on specific fields:

<img src="../img/log_view_model_2.png" width="70%" >

## Status Distribution Chart

<<< custom_key.brand_name >>> automatically divides several time points based on the selected time range, displaying the number of different log statuses via a stacked bar chart to assist with statistical analysis. If logs have been filtered, the bar chart will display the results after filtering.

- You can export the chart by hovering over it, ultimately exporting it to dashboards, notes, or clipboard;
- You can customize the time interval selection.

![](../img/10.export_pic.png)

## Time Widget

The <<< custom_key.brand_name >>> viewer defaults to displaying log data from the past 15 minutes. You can customize the [time range](../getting-started/function-details/explorer-search.md#time) for data display.

## Log Index

You can set up [multi-log indices](./multi-index/index.md) to filter and save logs that meet certain criteria in different log indices. By selecting different data storage policies for log indices, you can save on log data storage costs.

After setting up indices, you can switch between different indices in the viewer to view corresponding log content.

<img src="../img/5.log_3.1.png" width="70%" >

## Search and Filtering

In the search bar of the log viewer, you can use [various search and filtering methods](../getting-started/function-details/explorer-search.md).

After entering search or filter conditions, you can preview the query results. You can copy these conditions for direct use in charts or query tools.

<img src="../img/bar-preview.png" width="70%" >

## DQL Search {#dql}

**Prerequisite**: The DQL search function is currently only supported in the log viewer.

In the log viewer, you can switch to DQL manual input query mode by clicking the toggle button :fontawesome-solid-code: inside the search box, allowing you to customize and input filtering and search conditions.

- Filter Conditions: Supports `and / or` combinations, supports using `()` parentheses to indicate search priority, supports `=` and `!=` operators;
- Search Conditions: Supports using the DQL function `query_string()` for string queries, such as entering `message = query_string()` to search log content.

> For more DQL syntax, refer to [DQL Definition](../dql/define.md).

## Quick Filters {#filter}

On the left side of the log viewer, you can edit [quick filters](../getting-started/function-details/explorer-search.md#quick-filter).

**Note**: If the values listed in quick filters are affected by sampling, the sampling rate will be displayed, and users can temporarily disable sampling.

## Custom Display Columns

The log viewer defaults to displaying the `time` and `message` fields. You can perform operations like sorting ascending/descending, moving columns left/right, adding/removing columns, adding to quick filters, grouping, etc.

> For more details, refer to [Display Column Explanation](../getting-started/function-details/explorer-search.md#columns).

### JSON Field Return {#json-content}

**Note**: This feature is only available to user roles with DQL query permissions.

<<< custom_key.brand_name >>> DQL queries support extracting embedded values from JSON fields in log data by adding fields with the `@` symbol in the DQL query statement. The system will recognize this configuration and display it as an independent field in the query results. For example:

- Normal Query:

<img src="../img/json.png" width="70%" >

- Expected Query After Extracting Embedded Fields:

<img src="../img/json-1.png" width="70%" >

In the log viewer, if you want to specify viewing extracted values from each log's `message` JSON text directly in the data list, add a field in the display columns with the format `@target_fieldname`. As shown below, we added `@fail_reason` configured in the DQL query statement to the display columns:

![](../img/json-3.gif)

## Create Monitor {#new}

While filtering log data, if you wish to implement further alert monitoring on the filtered data, you can set up monitors with one click. <<< custom_key.brand_name >>> will automatically apply your selected index, data source, and search conditions, simplifying the configuration process.

**Note**:

1. If another workspace is selected in the top-left corner of the viewer, the search conditions will not be synchronized, and the monitor configuration page will be empty by default.
2. In the standard Commercial Plan, site-level `left*` queries are enabled by default. You only need to enable workspace-level `left*` queries to support monitor `left*` queries. For the Deployment Plan, you can independently enable or disable site-level `left*` queries. Only when both site and workspace-level `left*` queries are enabled can the monitor perform `left*` queries. Otherwise, if the log viewer configures a `left*` query, switching to the monitor will result in an error.

![](../img/explorer-monitor.png)

![](../img/explorer-monitor-1.png)

## Copy as cURL

The log viewer supports obtaining log data via command line. On the right side of the log data list under **Settings**, click **Copy as cURL** to copy the cURL command line. Execute this command on your host terminal to retrieve log data for the current time period based on the selected filters and search conditions.

![](../img/logexport-1.png)

<u>**Example**</u>

After copying the cURL command line, it looks like the following: Replace `<Endpoint>` with the domain name, and `<DF-API-KEY>` should be replaced with the **Key ID** from [API Management](../management/api-key/index.md).

> For more parameter explanations, refer to [DQL Data Query](../open-api/query-data/query-data.md).
> 
> For more API information, refer to [Open API](../management/api-key/open-api.md).

```shell
curl '<Endpoint>/api/v1/df/query_data?search_after=\[1680226330509,8572,"L_1680226330509_cgj4hqbrhi85kl1m6os0"\]&queries_body=%7B%22queries%22:\[%7B%22uuid%22:%222eb41760-cf6e-11ed-a983-7d559044c3fc%22,%22qtype%22:%22dql%22,%22query%22:%7B%22q%22:%22L::re(%60.*%60):(%60*%60)%7B+%60index%60+IN+\[%27default%27\]+%7D%22,%22highlight%22:true,%22limit%22:50,%22orderby%22:\[%7B%22time%22:%22desc%22%7D\],%22_funcList%22:\[\],%22funcList%22:\[\],%22disableMultipleField%22:false,%22disable_slimit%22:false,%22is_optimized%22:true,%22offset%22:0,%22search_after%22:\[1680226330509,8572,%22L_1680226330509_cgj4hqbrhi85kl1m6os0%22\],%22timeRange%22:\[1680187562081,1680230762081\],%22tz%22:%22Asia%2FShanghai%22%7D%7D\]%7D' \
- H 'DF-API-KEY: <DF-API-KEY>' \
- -compressed \
- -insecure
```

**Note**: Only **Standard Member and above** can perform the copy command line operation.

Apart from this export path, you can also use [other log data export](#logexport) methods.

## Set Status Colors {#status-color}

<<< custom_key.brand_name >>> has predefined system default colors for status values. If you need to modify the color displayed for data in different states in the viewer, you can do so by clicking **Set Status Colors**.

<img src="../img/status-color.png" width="70%" >

## Formatting Configuration

<font size=2>**Note**: Only administrators and above can configure formatting settings for the viewer.</font>

Formatting configuration allows you to hide sensitive log data or highlight important log data, and you can quickly filter by replacing original log content.

Click the **Settings** in the top-right corner of the viewer list, then click **Formatting Configuration** to add mappings, enter the following content, and click Save to replace the original log content containing "DEBUG" with the format you want to display.

- Field: e.g., Content
- Matching Method: e.g., match (currently supports `=`, `!=`, `match`, `not match`)
- Matching Content: e.g., DEBUG
- Display as Content: e.g., `******`

![](../img/11.log_format_2.gif)

## Log Data Export {#logexport}

In **Logs**, you can first filter out the desired log data and then export it for viewing and analysis via :octicons-gear-24:, supporting export to CSV files or dashboards and notes.

![](../img/5.log_explorer_3.png)

If you need to export a specific log entry, open the log detail page and click the :material-tray-arrow-up: icon in the top-right corner.

![](../img/export-log-0808.png)

## Log Color Highlighting

To help you quickly obtain key log information, <<< custom_key.brand_name >>> uses different colors to highlight different parts of the log content, divided into light and dark themes.

**Note**: When searching logs in the search bar, only the matched keywords remain highlighted in the returned list.

| Log Content | Light Theme | Dark Theme |
| --- | --- | --- |
| Date (log occurrence time) | Yellow | Light Yellow |
| Keywords (HTTP protocol related, such as GET) | Green | Light Green |
| Text (quoted strings) | Blue | Light Blue |
| Default (unmarked text) | Black | Gray |
| Numbers (log status codes, such as 404) | Purple | Light Purple |

![](../img/2.log_1.png)

## Single-line Log Expansion and Copy

Click :material-chevron-down: on a log entry to expand and view its full content;

Click the :octicons-copy-16: button to copy the entire log entry. When expanded, if JSON display is supported, the log will be shown in JSON format; otherwise, it will display normally.

![](../img/5.log_explorer_1.png)

## Multi-line Log Browsing

<<< custom_key.brand_name >>>'s log data list defaults to showing the trigger time and content of logs. You can choose to display logs in "1 Line", "3 Lines", "10 Lines", or "All" in the **Display Columns** to view complete log content.

![](../img/5.log_explorer_2.gif)