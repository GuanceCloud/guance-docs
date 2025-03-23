# Logs List

---

The log explorer is one of your core tools for log analysis and troubleshooting. Facing the massive amount of log data collected and reported by <<< custom_key.brand_name >>>, you can perform various operations such as searching, filtering, and exporting to efficiently manage log information.


## View Mode {#mode}

- Standard mode: Fields are displayed in columns;

<img src="../img/log_view_model.png" width="70%" >

- Stacked mode: Except for the time field (`time`), all other fields will be merged into a single column and displayed in multiple lines within the cell.

<img src="../img/log_view_model_1.png" width="70%" >

In stacked mode, you can perform graphical operations on specific fields:

<img src="../img/log_view_model_2.png" width="70%" >

## Status Distribution Chart

Based on the selected time range, the system will automatically divide into multiple time points and display the quantity of different log statuses in the form of a stacked bar chart, assisting in efficient statistical analysis. When logs are filtered, the bar chart will synchronize in real-time to display the filtered results.

- You can hover over the chart to export it, eventually exporting it to a dashboard, note, or copying it to the clipboard;
- You can customize the time interval selection.

![](../img/export_chart.png)


## Log Index

By setting up [Log Multi-Indexes](./multi-index/index.md), logs that meet certain conditions can be stored in different indexes, and an appropriate data storage strategy can be selected for each index, effectively saving log data storage costs.

After setting up, you can easily switch between different indexes in the explorer to view corresponding log content.

<img src="../img/log_explorer_index.png" width="80%" >

## Search and Filtering

In the search bar of the log explorer, multiple [search and filter methods](../getting-started/function-details/explorer-search.md) are supported.

After entering search or filter conditions, you can preview the query effects. You can also copy these conditions for direct use in charts or query tools.

<img src="../img/bar-preview.png" width="70%" >


### DQL Search {#dql}

**Prerequisite**: The DQL search function is currently only supported for use with the log explorer.

By clicking the toggle button :fontawesome-solid-code: on the right side of the search box, you can enter the manual input query mode for DQL.

- Filter conditions: Supports arbitrary combinations of `and / or`, supports specifying priority through `()` parentheses, and supports operators such as `=` and `!=`;
- Search conditions: Supports using the DQL function `query_string()` for string queries. For example, entering `message = query_string()` allows for full-text searches of log content.

> For more DQL syntax, refer to [DQL Definition](../dql/define.md).



### JSON Field Return {#json-content}

**Note**: This feature is only applicable to user roles with DQL query permissions.

DQL queries support extracting nested values from JSON fields in log data. You just need to add fields with the `@` symbol in the DQL query statement, and the system will automatically recognize this configuration and display the extracted values as independent fields in the query results. For example:

- Normal query:

<img src="../img/json.png" width="70%" >

- Query after extracting embedded fields:

<img src="../img/json-1.png" width="70%" >

In the log explorer, if you want to directly specify in the data list the values extracted from the JSON text of each log's `message`, add fields in the format `@targer_fieldname` in the display columns. As shown below, we added `@fail_reason` configured in the DQL query statement to the display columns:

![](../img/json-3.gif)

## Create Monitor {#new}

While filtering log data, if you need to further alert monitor the filtered results, you can achieve this by setting up a monitor with one click. The system will automatically apply the selected index, data source, and search conditions, simplifying the configuration process.


???+ warning "Note"

    - If another workspace is selected in the upper left corner of the log explorer, the search conditions will not be synchronized to the monitor configuration page, and the monitor configuration page will default to being empty.
    - In the standard commercial edition, the site-level `left*` query function is enabled by default. You only need to enable the workspace-level `left*` query to support the monitor's `left*` query. For the deployment edition, you can independently enable or disable the site-level `left*` query. Only when both the site and workspace-level `left*` queries are enabled can the monitor perform `left*` queries. Otherwise, if the log explorer is configured with a `left*` query, an error may occur when switching to the monitor.

![](../img/explorer-monitor.png)

![](../img/explorer-monitor-1.png)


## Copy as cURL

In the log explorer, you can obtain log data via command-line form. In the **Settings** section on the right side of the log data list, click the **Copy as cURL** button to copy the corresponding cURL command. Pasting and executing this command in the host terminal will retrieve log data that meets the filtering and search criteria within the current time period.

![](../img/logexport-1.png)

*Example*

After copying the cURL command line, it looks like the following figure: where `<Endpoint>` needs to be replaced with the domain name, and `<DF-API-KEY>` needs to be replaced with the **Key ID** from [API Management](../management/api-key/index.md).

> For more related parameter explanations, refer to [DQL Data Query](../open-api/query-data/query-data.md).
> 
> For more API information, refer to [Open API](../management/api-key/open-api.md).

```shell
curl '<Endpoint>/api/v1/df/query_data?search_after=\[1680226330509,8572,"L_1680226330509_cgj4hqbrhi85kl1m6os0"\]&queries_body=%7B%22queries%22:\[%7B%22uuid%22:%222eb41760-cf6e-11ed-a983-7d559044c3fc%22,%22qtype%22:%22dql%22,%22query%22:%7B%22q%22:%22L::re(%60.*%60):(%60*%60)%7B+%60index%60+IN+\[%27default%27\]+%7D%22,%22highlight%22:true,%22limit%22:50,%22orderby%22:\[%7B%22time%22:%22desc%22%7D\],%22_funcList%22:\[\],%22funcList%22:\[\],%22disableMultipleField%22:false,%22disable_slimit%22:false,%22is_optimized%22:true,%22offset%22:0,%22search_after%22:\[1680226330509,8572,%22L_1680226330509_cgj4hqbrhi85kl1m6os0%22\],%22timeRange%22:\[1680187562081,1680230762081\],%22tz%22:%22Asia%2FShanghai%22%7D%7D\]%7D' \
- H 'DF-API-KEY: <DF-API-KEY>' \
- -compressed \
- -insecure
```


**Note**: Only **Standard Members and Above** can perform the copy command-line operation.

Besides this export path, you can also adopt [other log data export](#logexport) methods.


## Set Status Color {#status-color}

The system has pre-set default colors for status values. If you need to customize the colors displayed for different statuses in the explorer, you can modify them by clicking **Set Status Color**.

<img src="../img/status-color.png" width="70%" >

## Formatting Configuration

<font size=2>**Note**: Only administrators and above can configure the explorer formatting.</font>

Through formatting configuration, you can hide sensitive log content, highlight important log content, or quickly filter by replacing log content.

1. Click the **Settings** icon in the upper-right corner of the explorer list;
2. Click **Formatting Configuration**;
3. Add mapping rules, input the following contents, and save:

    - Field: Specify the log field (such as `content`).
    - Matching method: Choose the matching method (currently supports =, !=, match, not match).
    - Matching content: Input the content to match (such as DEBUG).
    - Display content: Input the replacement content to display (such as ******).


![](../img/11.log_format_2.gif)

## Log Data Export {#logexport}

In **Logs**, you can first filter out the required log data, then export it as a CSV file or save it to a dashboard and notes via :octicons-gear-24: > Export button for further viewing and analysis.

![](../img/5.log_explorer_3.png)

If you need to export a specific log data, open the detail page of the log and click the :material-tray-arrow-up: icon in the upper-right corner.

![](../img/export-log-0808.png)


## Log Color Highlighting

To help quickly locate key information in logs, the system uses color highlighting to display log content. When entering keywords in the search bar, only the matched keywords will be highlighted.


## Single Log Line Expansion and Copy

- Click the :material-chevron-down: button in the log entry to view the complete content of the log. If the log supports JSON format, it will be displayed in JSON format; otherwise, it will display normally.

- Click the :octicons-copy-16: button to copy the entire log content to the clipboard.

![](../img/log_explorer_expand_copy.png)

## Multi-line Log Browsing

In the log data list, the trigger time and content of each log are displayed by default. Through the Explorer > Display Columns, you can choose to display "1 Line", "3 Lines", "10 Lines" or all content to view complete log information.

![](../img/log_explorer_lines.png)