# Logs List

---

The log explorer is one of your core tools for log analysis and troubleshooting. Facing the massive amount of log data collected and reported by <<< custom_key.brand_name >>>, you can achieve efficient management of log information through multiple operations such as searching, filtering, and exporting.


## View Mode {#mode}

- Standard mode: Fields are displayed in columns:

<img src="../img/log_view_model.png" width="70%" >

- Stacked mode: All fields except the time field (`time`) will be merged into a single column and displayed in multi-line format within cells:

<img src="../img/log_view_model_1.png" width="70%" >

In stacked mode, graphical operations can be performed on specific fields:

<img src="../img/log_view_model_2.png" width="70%" >

## Status Distribution Chart

Based on the selected time range, the system will automatically divide into multiple time points and display the number of different log statuses in the form of a stacked bar chart, helping to efficiently perform statistical analysis. When filtering logs, the bar chart will synchronously display the filtered results in real-time.

- You can hover over the chart to export it, eventually exporting to dashboards, notes, or copying it to the clipboard;
- You can customize the selection of time intervals.

![](../img/export_chart.png)


## Log Index

By setting up [Multiple Log Indices](./multi-index/index.md), logs that meet certain conditions can be stored in different indices, and an appropriate data storage strategy can be chosen for each index, effectively saving log data storage costs.

After setup, you can easily switch between different indices in the explorer to view corresponding log content.

<img src="../img/log_explorer_index.png" width="80%" >

## Search and Filtering

In the search bar of the log explorer, various [search and filter methods](../getting-started/function-details/explorer-search.md) are supported.

After entering search or filter conditions, you can preview the query effects. You can also copy these conditions for direct use in charts or query tools.

<img src="../img/bar-preview.png" width="70%" >


### DQL Search {#dql}

**Prerequisite**: The DQL search function is currently only supported for use in the log explorer.

By clicking the toggle button :fontawesome-solid-code: on the right side of the search box, enter the manual input query mode for DQL.

- Filter conditions: Supports any combination of `and / or`, supports specifying priority using `()` parentheses, and supports operators such as `=` and `!=`;
- Search conditions: Supports using the DQL function `query_string()` for string queries. For example, entering `message = query_string()` allows full-text search of log content.

> For more DQL syntax, refer to [DQL Definition](../dql/define.md).


### JSON Field Return {#json-content}

???+ warning "Note"

    This feature is only applicable to user roles with DQL query permissions.

DQL queries support extracting nested values from JSON fields in log data. You just need to add fields with the `@` symbol in the DQL query statement, and the system will automatically recognize this configuration, displaying the extracted values as independent fields in the query results. For example:

- Normal query:

<img src="../img/json.png" width="70%" >

- Expected query after extracting embedded fields:

<img src="../img/json-1.png" width="70%" >

In the log explorer, if you want to specify viewing extracted values from the JSON text of each log's `message` directly in the data list, add fields in the display column in the format `@targer_fieldname`. As shown below, we add `@fail_reason` configured in the DQL query statement in the display column:

![](../img/json-3.gif)

## Create Monitor {#new}

When filtering log data, if you need to further alert monitor the filtered results, you can achieve this by setting up a monitor with one click. The system will automatically apply the selected index, data source, and search conditions, thus simplifying the configuration process.


???+ warning "Note"

    - If another workspace is selected in the top-left corner of the log explorer, the search conditions will not be synchronized to the monitor configuration page, which will default to being empty.
    - In the standard Commercial Plan, the site-level `left*` query function is enabled by default. You just need to enable the workspace-level `left*` query to support the monitor's `left*` query. For Deployment Plans, you can independently enable or disable the site-level `left*` query, and only when both site and workspace-level `left*` queries are enabled can the monitor perform `left*` queries. Otherwise, if the log explorer configures a `left*` query, an error may occur when jumping to the monitor.

![](../img/explorer-monitor.png)

![](../img/explorer-monitor-1.png)


## Copy as cURL

In the log explorer, you can obtain log data via command line. In the **Settings** on the right side of the log data list, click the **Copy as cURL** button to copy the corresponding cURL command. Paste and execute this command in the host terminal to retrieve log data that meets the filtering and search criteria for the current time period.

![](../img/logexport-1.png)

*Example*

After copying the cURL command, as shown in the figure below: where `<Endpoint>` needs to be replaced with the domain name, and `<DF-API-KEY>` should be replaced with the **Key ID** in [API Management](../management/api-key/index.md).

> For more related parameter descriptions, refer to [DQL Data Query](../open-api/query-data/query-data.md).
>
> For more API information, refer to [Open API](../management/api-key/open-api.md).

```shell
curl '<Endpoint>/api/v1/df/query_data?search_after=\[1680226330509,8572,"L_1680226330509_cgj4hqbrhi85kl1m6os0"\]&queries_body=%7B%22queries%22:\[%7B%22uuid%22:%222eb41760-cf6e-11ed-a983-7d559044c3fc%22,%22qtype%22:%22dql%22,%22query%22:%7B%22q%22:%22L::re(%60.*%60):(%60*%60)%7B+%60index%60+IN+\[%27default%27\]+%7D%22,%22highlight%22:true,%22limit%22:50,%22orderby%22:\[%7B%22time%22:%22desc%22%7D\],%22_funcList%22:\[\],%22funcList%22:\[\],%22disableMultipleField%22:false,%22disable_slimit%22:false,%22is_optimized%22:true,%22offset%22:0,%22search_after%22:\[1680226330509,8572,%22L_1680226330509_cgj4hqbrhi85kl1m6os0%22\],%22timeRange%22:\[1680187562081,1680230762081\],%22tz%22:%22Asia%2FShanghai%22%7D%7D\]%7D' \
- H 'DF-API-KEY: <DF-API-KEY>' \
- -compressed \
- -insecure
```


**Note**: Only **Standard Members and above** can perform the copy command-line operation.

Besides this export path, you can also adopt other [log data export](#logexport) methods.


## Set Status Colors {#status-color}

The system has preset default colors for status values. If you need to customize the colors displayed in the explorer for different statuses, you can click **Set Status Color** to modify them.

<img src="../img/status-color.png" width="70%" >

## Formatting Configuration

<font size=2>**Note**: Only administrators and above can configure formatter settings for the explorer.</font>

Through formatting configurations, you can hide sensitive log content, highlight important log content, or quickly filter by replacing log content.

1. Click the **Settings** in the top-right corner of the explorer list;
2. Click **Formatting Configuration**;
3. Add mapping rules, input the following content and save:

    - Field: Specify the log field (e.g., `content`).
    - Match Method: Choose the matching method (currently supports =, !=, match, not match).
    - Match Content: Input the content to match (e.g., DEBUG).
    - Display as Content: Input the replacement content to display (e.g., ******).


![](../img/11.log_format_2.gif)

## Export Log Data {#logexport}

In **Logs**, you can first filter out the required log data, then export it as a CSV file or save it to dashboards and notes via :octicons-gear-24: > Export button for further viewing and analysis.

![](../img/5.log_explorer_3.png)

If you need to export a specific log data, open the log's details page and click the :material-tray-arrow-up: icon in the top-right corner.


## Log Highlighting

To help quickly locate key information in logs, the system uses color highlighting to display log content. When entering keywords in the search bar, only the matched keywords will be highlighted.


## Single-Line Log Expansion and Copy

- Click the :material-chevron-down: button in the log entry to view the full content of the log. If the log supports JSON format, it will be displayed in JSON format; otherwise, it will show normally.

- Click the :octicons-copy-16: button to copy the entire log content to the clipboard.

![](../img/log_explorer_expand_copy.png)

## Multi-Line Log Browsing

In the log data list, the trigger time and content of each log are displayed by default. Through Explorer > Display Columns, you can choose to display "1 Line", "3 Lines", "10 Lines" or all content to view complete log information.

![](../img/log_explorer_lines.png)