# Log List

---

The Log Explorer is one of the core tools for log analysis and troubleshooting. Facing the massive amount of log data collected and reported by Guance, you can efficiently manage log information through various operations such as searching, filtering, and exporting.

## View Mode {#mode}

- **Standard Mode**: Fields are displayed in columns;

![Log View Model](../img/log_view_model.png)

- **Stacked Mode**: Except for the time field (`time`), all other fields will be merged into a single column and displayed in multiple lines within cells.

![Log View Model 1](../img/log_view_model_1.png)

In Stacked Mode, you can perform graphical operations on specific fields:

![Log View Model 2](../img/log_view_model_2.png)

## Status Distribution Chart

Guance automatically divides several time points based on the selected time range and displays the number of different log statuses using stacked bar charts to assist with statistical analysis. If logs have been filtered, the bar chart will also display the filtered results.

- You can export the chart after hovering over it, ultimately exporting it to dashboards, notes, or the clipboard.
- You can customize the time interval.

![](../img/10.export_pic.png)

## Time Controls

The Guance Log Explorer defaults to displaying logs from the last 15 minutes. You can customize the [time range](../getting-started/function-details/explorer-search.md#time).

## Log Indexing

You can set up [multi-log indexes](./multi-index/index.md) to filter and save logs that meet certain criteria in different log indexes. By selecting different data storage policies for log indexes, you can reduce log data storage costs.

After setting up indexes, you can switch between different indexes in the Explorer to view corresponding log content.

![Log 3.1](../img/5.log_3.1.png)

## Search and Filtering

In the Log Explorer search bar, [multiple search and filtering methods](../getting-started/function-details/explorer-search.md) are supported.

After entering search or filter conditions, you can preview the query results. You can copy these conditions for use in charts or query tools.

![Bar Preview](../img/bar-preview.png)

## DQL Search {#dql}

**Prerequisite**: The DQL search feature is currently only supported in the Log Explorer.

In the Log Explorer, you can switch to DQL manual input mode by clicking the toggle button :fontawesome-solid-code: in the search box, allowing you to customize your search and filter conditions.

- **Filter Conditions**: Supports `and / or` combinations, supports using `()` parentheses to indicate priority, and supports operators like `=` and `!=`.
- **Search Conditions**: Supports using the DQL function `query_string()` for string queries, e.g., `message = query_string()` to search log content.

> For more DQL syntax, refer to [DQL Definition](../dql/define.md).

## Quick Filters {#filter}

On the left side of the Log Explorer, you can edit [quick filters](../getting-started/function-details/explorer-search.md#quick-filter).

**Note**: If quick filter values are affected by sampling, the sample rate is displayed, and users can temporarily disable sampling.

## Custom Display Columns

The Log Explorer defaults to displaying the `time` and `message` fields, where the `time` field is fixed and cannot be deleted. When hovering over the displayed columns in the Explorer, click the **Settings** button to perform operations such as sorting columns, moving columns, adding columns, adding to quick filters, adding to groups, and removing columns.

> For more details, refer to [Display Column Explanation](../getting-started/function-details/explorer-search.md#columns).

### JSON Field Extraction {#json-content}

**Note**: This feature is only available to user roles with DQL query permissions.

Guance DQL queries support extracting nested values from JSON fields in log data. By adding fields with the `@` symbol in the DQL query statement, the system will recognize this configuration and display it as an independent field in the query results. For example:

- Normal Query:

![JSON](../img/json.png)

- Expected query result after extracting nested fields:

![JSON-1](../img/json-1.png)

In the Log Explorer, if you want to specify viewing extracted values from each log's `message` JSON text directly in the data list, add fields in the format `@target_fieldname` to the display columns. For instance, we add `@fail_reason` configured in the DQL query statement to the display columns:

![](../img/json-3.gif)

## Create a Monitor {#new}

While filtering log data, if you wish to implement further alert monitoring on the filtered data, you can achieve this by setting up a monitor with one click. Guance will automatically apply the selected index, data source, and search conditions, simplifying the configuration process.

**Note**:

1. If another workspace is selected in the top-left corner of the Explorer, the search conditions will not be synchronized, and the monitor configuration page will be empty by default.
2. The default Commercial Plan enables site-level `left*` queries. You only need to enable workspace-level `left*` queries to support monitor `left*` queries. For Deployment Plans, you can independently enable or disable site-level `left*` queries. Only when both site and workspace-level `left*` queries are enabled can monitors perform `left*` queries. Otherwise, if the Log Explorer configures `left*` queries, switching to the monitor will result in query errors.

![](../img/explorer-monitor.png)

![](../img/explorer-monitor-1.png)

## Copy as cURL

The Log Explorer supports retrieving log data via command line. In the settings on the right side of the log data list, click **Copy as cURL** to copy the cURL command line. Execute this command on your host terminal to retrieve log data for the current time period under the relevant filter and search conditions.

![](../img/logexport-1.png)

<u>**Example**</u>

After copying the cURL command line, replace `<Endpoint>` with the domain name and `<DF-API-KEY>` with the **Key ID** from [API Management](../management/api-key/index.md).

> For more parameter explanations, refer to [DQL Data Query](../open-api/query-data/query-data.md).
>
> For more API information, refer to [Open API](../management/api-key/open-api.md).

```shell
curl '<Endpoint>/api/v1/df/query_data?search_after=\[1680226330509,8572,"L_1680226330509_cgj4hqbrhi85kl1m6os0"\]&queries_body=%7B%22queries%22:\[%7B%22uuid%22:%222eb41760-cf6e-11ed-a983-7d559044c3fc%22,%22qtype%22:%22dql%22,%22query%22:%7B%22q%22:%22L::re(%60.*%60):(%60*%60)%7B+%60index%60+IN+\[%27default%27\]+%7D%22,%22highlight%22:true,%22limit%22:50,%22orderby%22:\[%7B%22time%22:%22desc%22%7D\],%22_funcList%22:\[\],%22funcList%22:\[\],%22disableMultipleField%22:false,%22disable_slimit%22:false,%22is_optimized%22:true,%22offset%22:0,%22search_after%22:\[1680226330509,8572,%22L_1680226330509_cgj4hqbrhi85kl1m6os0%22\],%22timeRange%22:\[1680187562081,1680230762081\],%22tz%22:%22Asia%2FShanghai%22%7D%7D\]%7D' \
- H 'DF-API-KEY: <DF-API-KEY>' \
- -compressed \
- -insecure
```

**Note**: Only **Standard Members and above** can perform the copy command line operation.

Besides this export path, you can also use [other log data export methods](#logexport).

## Set Status Colors {#status-color}

Guance has predefined system colors for status values. If you need to modify the colors displayed for different statuses in the Explorer, you can do so by clicking **Set Status Colors**.

![Status Color](../img/status-color.png)

## Formatting Configuration

<font size=2>**Note**: Only administrators and above can configure formatting settings for the Explorer.</font>

Formatting configurations allow you to hide sensitive log data or highlight important log data. You can also quickly filter by replacing original log content.

Click the **Settings** icon in the top-right corner of the Explorer list, then click **Formatting Configuration** to add mappings. Enter the following content and click Save to replace original log content containing "DEBUG" with your desired format.

- Field: e.g., Content
- Matching Method: e.g., match (currently supports `=`, `!=`, `match`, `not match`)
- Matching Content: e.g., DEBUG
- Display As: e.g., `******`

![](../img/11.log_format_2.gif)

## Export Log Data {#logexport}

In **Logs**, you can first filter out the desired log data and then export it for viewing and analysis, supporting exports to CSV files or dashboards and notes.

![](../img/5.log_explorer_3.png)

If you need to export a specific log entry, open the log detail page and click the :material-tray-arrow-up: icon in the top-right corner.

![](../img/export-log-0808.png)

## Log Highlighting

To help you quickly identify key information in logs, Guance uses different colors to highlight different parts of the logs, divided into light and dark themes.

**Note**: If you search for logs in the search bar, only the matching keywords will be highlighted in the returned list.

| Log Content | Light Theme | Dark Theme |
| --- | --- | --- |
| Date (log timestamp) | Yellow | Pale Yellow |
| Keywords (HTTP protocol related, e.g., GET) | Green | Pale Green |
| Text (quoted strings) | Blue | Pale Blue |
| Default (plain text) | Black | Gray |
| Numbers (log status codes, e.g., 404) | Purple | Pale Purple |

![](../img/2.log_1.png)

## Single-Line Log Expansion and Copy

Click :material-chevron-down: to expand a log entry and view its full content;

Click the :octicons-copy-16: button to copy the entire log entry. When expanded, if JSON display is supported, the log will be shown in JSON format; otherwise, it will be displayed normally.

![](../img/5.log_explorer_1.png)

## Multi-line Log Browsing

The log data list in Guance defaults to displaying the trigger time and content of logs. You can choose to display logs in "1 Line", "3 Lines", "10 Lines", or "All" in the **Display Columns** section to view complete log content.

![](../img/5.log_explorer_2.gif)