# Log Explorer
---

After log data is collected into Guance, you can view all the log content in the workspace through the **Log Explorer** in the Guance console.

**Note**: If the current logged-in account role has set **[Only display rules related to me](logdata-access.md#list)** in **Logs > [Data Access](logdata-access.md#list)**, the queried log content will be affected accordingly.

## Log Explorer Modes

The Guance Log Explorer supports three viewing modes, including:

- [All Logs](#all);
- [Pattern](#cluster);
- [Chart Analysis](#charts).

### All Logs {#all}

**All Logs**: View and analyze based on the collected raw log data.

![](img/5.log_1.png)

### Pattern {#cluster}

The Log Explorer provides an efficient pattern feature, which performs similarity calculation and analysis on raw log data.

The system defaults to performing log clustering based on the `message` field, automatically displaying the latest 50 log entries. You can also customize the clustering fields according to your business needs. After selecting the time range in the top right [Time Widget](../getting-started/function-details/explorer-search.md#time), the system will filter and analyze 10,000 log entries from that period, automatically aggregate similar log entries, extract, count, and finally display common features.

![](img/4.log_2.png)

In the pattern list, you can manage the data through the following operations:

1. Click the icons :octicons-triangle-up-16: & :octicons-triangle-down-16: to sort the document quantity, with a default reverse order.

2. Click the :octicons-gear-24: button to choose the display of 1 line, 3 lines, 10 lines, and all.

3. Click the material-tray-arrow-up: button to export all clustered log data.


### Chart Analysis {#charts}

In the **Analysis** mode of the explorer, the system groups and statistically analyzes the original log data based on <u>1-3 tags</u>, reflecting the distribution characteristics and trends of log data under different groups and different times.

![](img/manage-charts.png)

After entering the analysis mode, four types of charts are available: time series charts, leaderboards, pie charts, and tree maps.

You can manage the chart analysis mode through the following operations:

1. Below the chart, support filtering queries based on various fields.

2. In the time series chart mode, support selecting area charts, line charts, and bar charts for display styles.

3. For the displayed clustered data, in the time series chart mode, you can choose `slimit` as 5/10/20/50/100; in the leaderboard/pie chart/tree map mode, you can choose `limit to` the maximum or minimum as 5/10/20/50/100.

4. Click the right :material-list-box: button to choose to hide, bottom, or right legend.

5. Click the :art: button to customize the color style of the legend display.

6. Click the :material-tray-arrow-up: button to choose to export the current chart as a CSV file, export to notes, dashboard, or directly copy the chart.


## Log Query and Analysis

Guance supports querying and analyzing log data through various operations.

### Log Statistics

Guance automatically divides several time points based on the selected time range and displays the number of different log statuses through a stacked bar chart, helping with statistical analysis. If logs have been filtered, the bar chart displays the results after filtering.

- The log statistics chart supports hovering the mouse over the chart and clicking the export button to export to a dashboard, notes, or clipboard.

- The log statistics chart supports custom selection of time intervals.

![](img/10.export_pic.png)

### Time Widget

The Guance explorer defaults to displaying log data from the last 15 minutes, and you can also customize the [time range](../getting-started/function-details/explorer-search.md#time) for data display.

### Log Indexes

Guance supports setting up multiple log indexes, filtering logs that meet the conditions and saving them in different log indexes, and helping users save on log data storage costs by choosing different data storage strategies for log indexes.

After setting the index in **Logs > Index**, you can select different indexes in the explorer to view the corresponding log content.

> For more details, see [Log Indexes](multi-index.md).


### Search and Filtering

In the log explorer search bar, support for [multiple search methods and filtering methods](../getting-started/function-details/explorer-search.md).

After entering the search or filter conditions, you can view the preview effect of the query. You can copy the condition and use it directly for charts or query tools.

<img src="../img/bar-preview.png" width="70%" >

### DQL Search {#dql}

**Prerequisite**: The DQL search feature is currently only available for use in the log explorer.

In the log explorer, you can switch to the DQL manual input query mode by clicking the switch button :fontawesome-solid-code: in the search box, and customize the input filter and search conditions.

- Filter conditions: Support any combination of `and / or`, support using `()` parentheses to indicate the priority of executing the search, support operators such as `=`, `!=`.

- Search conditions: Support using DQL functions `query_string()` for string queries, such as entering `message = query_string()` to search log content.

> For more DQL syntax, see [DQL Definition](../dql/define.md).

### Quick Filters {#filter}

In the log explorer quick filters, support editing [quick filters](../getting-started/function-details/explorer-search.md#quick-filter) and adding new filter fields.

**Note**: If the values displayed in the quick filters are affected by sampling, the sampling rate is displayed, and users can temporarily turn off sampling.

### Customize Display Columns

The log explorer defaults to displaying the `time` and `message` fields, among which the `time` field is a fixed field and cannot be deleted. Hovering over a display column reveals the Settings button, which allows you to perform various column operations including sorting, moving columns, adding or removing columns, and applying filters and groupings.

> For more customization of display columns, see [Display Column Description](../getting-started/function-details/explorer-search.md#columns).

#### JSON Field Return {#json-content}

<font size=3>**Note**: This feature is only available for user roles with DQL query permissions.</font>

Guance DQL query supports extracting embedded values from the JSON fields of log data. By adding a field with the `@` symbol in the DQL query statement, the system will recognize the configuration and display it as an independent field in the query results. For example:

- Normal query:

<img src="../img/json.png" width="70%" >

- Expected extraction of embedded fields after query:

<img src="../img/json-1.png" width="70%" >

In the log explorer, if you want to directly specify the value extracted from the `message` JSON text of each log in the data list, add a field in the display column in the format of `@target_fieldname`. In the figure below, we have added the `@fail_reason` that has been configured in the DQL query statement to the display column:

![](img/json-3.gif)

### Create a Monitor {#new}

You can directly jump to the monitor creation page from the log explorer entry to quickly set up exception detection rules for log data.

![](img/explorer-monitor.png)

> For specific operations, see [Create](../monitoring/monitor/index.md#new).

### Copy as cURL

The log explorer supports obtaining log data in the form of command lines. On the right side of the log data list **Settings**, click **Copy as cURL** to copy the cURL command line, go to the host terminal to execute the command, and obtain the log data related to the current time period under the current filter and search conditions.

![](img/logexport-1.png)

<u>**Example**</u>

After copying the cURL command line, as shown in the figure below: `<Endpoint>` needs to be replaced with the domain name, and `<DF-API-KEY>` needs to be replaced with **Key ID** at [API Management](../management/api-key/index.md).

> For more information on related parameters, see [DQL Data Query](../open-api/query-data/query-data.md).
> 
> For more information on the API, see [Open API](../management/api-key/open-api.md).


```shell
curl '<Endpoint>/api/v1/df/query_data?search_after=\[1680226330509,8572,"L_1680226330509_cgj4hqbrhi85kl1m6os0"\]&queries_body=%7B%22queries%22:\[%7B%22uuid%22:%222eb41760-cf6e-11ed-a983-7d559044c3fc%22,%22qtype%22:%22dql%22,%22query%22:%7B%22q%22:%22L::re(%60.*%60):(%60*%60)%7B+%60index%60+IN+\[%27default%27\]+%7D%22,%22highlight%22:true,%22limit%22:50,%22orderby%22:\[%7B%22time%22:%22desc%22%7D\],%22_funcList%22:\[\],%22funcList%22:\[\],%22disableMultipleField%22:false,%22disable_slimit%22:false,%22is_optimized%22:true,%22offset%22:0,%22search_after%22:\[1680226330509,8572,%22L_1680226330509_cgj4hqbrhi85kl1m6os0%22\],%22timeRange%22:\[1680187562081,1680230762081\],%22tz%22:%22Asia%2FShanghai%22%7D%7D\]%7D' \
- H 'DF-API-KEY: <DF-API-KEY>' \
- -compressed \
- -insecure
```


**Note**: Only **Standard Members and above** can perform copy command line operations.

In addition to this export path, you can also use [other log data export](#logexport) methods.

### Status Colors {#status-color}

Guance has set default system colors for status values. You can modify the colors displayed in the explorer for corresponding data under different status.

![](img/status-color.png)

### Format

Format allows you to hide sensitive log data content or highlight the log data content you need to view, and you can also quickly filter by replacing the original log content.

Click on **Settings** in the upper right corner of the explorer list, and then click on **Format** to add a mapping. Enter the following content and click save to replace the original log content containing "DEBUG" with the format you want to display.

- Field: such as content;
- Matching method: such as match (currently supports `=`, `!=`, `match`, `not match`);
- Matching content: such as DEBUG;
- Display as content: such as `******`.

**Note**: Only administrators and above can perform format for explorers.

![](img/11.log_format_2.gif)

### Export {#logexport}

In **Logs**, you can first filter the log data you want, and then export it for viewing and analysis through :octicons-gear-24:. It supports exporting to CSV files or dashboards and notes.

![](img/5.log_explorer_3.png)

If you need to export a specific log entry, open the log detail page and click the :material-tray-arrow-up: icon in the upper right corner.

<img src="../img/export-log-0808.png" width="70%" >

### Color Highlighting

To help you quickly obtain key log data information, Guance uses different colors to highlight different content in the logs, divided into light and dark theme colors.

**Note**: If you search for logs in the search bar, the returned list will only retain the highlighting display of the matched keywords.

| Log Content | Light Theme | Dark Theme |
| --- | --- | --- |
| Date (The time the log occurred) | Yellow | Light Yellow |
| Keyword (Related to HTTP protocol, such as GET) | Green | Light Green |
| Text (Quoted strings) | Blue | Light Blue |
| Default (Text without any indication) | Black | Gray |
| Numbers (Log status codes, such as 404) | Purple | Light Purple |


### Single Line Expansion Copy

Click :material-chevron-down: on a log entry to expand and view the entire content of the log;

Click the :octicons-copy-16: button to copy the entire log entry. When the log content is expanded, if JSON display is supported, the log will be displayed in JSON format; if not supported, the log content will be displayed normally.

![](img/5.log_explorer_1.png)

### Multi-line Browsing

The log data list in Guance defaults to showing you the trigger time and content of the log. You can choose to display the log in "1 line," "3 lines," "10 lines," and all in the explorer **Display Columns** to view the complete log content.

![](img/5.log_explorer_2.gif)

## Log Details

Click on the log list to pull out the current log's detail page to view detailed information of the log, including the time the log was generated, the host, source, service, content, extended fields, view context, etc.

### View Complete Logs

When logs are reported to Guance, if the data exceeds 1M in size, they will be split according to the 1M standard. For example, a 2.5M log will be divided into 3 pieces (1M/1M/0.5M). You can view the integrity of the split logs based on the following fields:

| <div style="width: 140px">Field</div> | Type | Description |
| ------------------ | ------ | ------------------------------------------------------------ |
| `__truncated_id`     | string | Represents the unique identifier of the log. Multiple split logs use the same `__truncated_id`, with the ID prefix being LT_xxx. |
| `__truncated_count`  | number | Indicates the total number of split logs. |
| `__truncated_number` | number | Indicates the split order of the log, starting from 0, with 0 indicating the first log entry. |

On the log detail page, if the current log is split into multiple pieces, the **View Complete Logs** button will be displayed in the upper right corner. Click it and open a new page and list all related logs according to the log split order. The page will also mark the previously selected log with color to help locate upstream and downstream.



### View Context Logs {#up-down}

The context query feature of the log service can help you use the timeline to trace the log records before and after a specific exception log. Through the visualization of log context information in Guance, it can effectively assist you in troubleshooting and problem localization, allowing for timely response.

On the log detail page, you can directly view the **context logs** of the data content; click :fontawesome-solid-arrow-up-right-from-square: to open a new page of context logs.

![](img/2.log_updown_1.png)

???- warning "Additional Understanding of Related Logic"

    According to the returned data, load 50 pieces of data each time by scrolling.

    How to query the returned data?

    **Prerequisite**: Does the log have a `log_read_lines` field? If it exists, follow logic a; if it does not exist, follow logic b.

    a. Obtain the `log_read_lines` value of the current log and bring it into the filter `log_read_lines >= {{log_read_lines.value-30}} and log_read_lines <= {{log_read_lines.value +30}}`

    DQL Example: Current log line number = 1354170

    Then:

    ```
    L::RE(`.*`):(`message`) { `index` = 'default' and `host` = "ip-172-31-204-89.cn-northwest-1" AND `source` = "kodo-log" AND `service` = "kodo-inner" AND `filename` = "0.log" and `log_read_lines` >= 1354140 and `log_read_lines` <= 1354200}  sorder by log_read_lines
    ```

    b. Obtain the current log time, and push forward/backward to determine the query's **start time** and **end time**
    - Start time: Push 5 minutes forward from the current log time;
    - End time: Take the time (time) of the 50th piece of data pushed backward from the current log, if time = current log time, then use `time+1 microsecond` as the end time, if time ≠ current log time, then use `time` as the end time.

#### Detail Page

After clicking :fontawesome-solid-arrow-up-right-from-square:, you will be redirected to the detail page:

![](img/context-1.png)

You can manage all current data with the following operations:

1. Enter text in the search box to search and locate data;
2. Click the side :octicons-gear-24: button to change the system's default selection of automatic line wrapping, and choose **Content Overflow** to display each log entry as one line, which can be viewed by sliding left and right as needed.

![](img/context-1.gif)

### Attribute Fields

When you click on the attribute fields for quick filtering and viewing, you can view the host, process, link, and container data related to the log.

| Field | Description |
| ----------- | ------------------- |
| Filter Field Value | That is, add the field to the log explorer to view all log data related to the field. |
| Inverse Filter Field Value | That is, add the field to the log explorer to view other related log data except for the field. |
| Add to Display Columns | Add the field to the explorer list for viewing. |
| Copy | That is, copy the field to the clipboard. |
| View Related Containers | That is, view all containers related to the host. |
| View Related Processes | That is, view all processes related to the host. |
| View Related Links | That is, view all links related to the host. |
| View Related Inspections | That is, view all inspection data related to the host. |

![](img/17.explorer_5.png)

### Log Content {#content}

- Log content automatically displays two viewing modes: JSON and text, based on the `message` type. If a log does not have a `message` field, the log content section will not be displayed. Log content can be expanded or collapsed, with the default being the expanded state. When collapsed, only one line of height is shown.

- For logs with `source = bpf_net_l4_log`, two viewing modes are automatically displayed: JSON and message. The message mode displays information such as the client, server, and time, and supports switching between absolute and relative time views. The default display is absolute time, and this setting will be saved to the local browser after switching.

![](img/explorer_001.png)

### Extended Fields

- In the search bar, you can quickly search and locate by entering the field name or value.

- After checking the field alias, you can view it after the field name.

![](img/extension.gif)

- Hover over an extended field and click the dropdown icon to choose to **filter field values**, **inverse filter field values**, **add to display columns**, and **copy** for that field.

<img src="../img/17.explorer_4.png" width="60%" >

### Associated Analysis

=== "Host"

    Guance supports you to view the metric view and attribute view of the related host (associated field: `host`) through the **Host** at the bottom of the detail page.
    
    - Metric View: You can view the performance metric status of the related host **within 30 minutes before the log ends to 30 minutes after the log ends**, including performance metric views such as CPU and memory of the related host.
    
    ![](img/1.log_4.png)
    
    - Attribute View: Helps you trace back the real situation of the host object when the log was generated, supporting viewing the **latest object data produced by the related host within the corresponding time**, including basic information and integration operation status of the host. If cloud host collection is enabled, you can also view information from cloud vendors.
    
    ![](img/1.log_4.1.png)

    **Note**: Guance defaults to saving the historical data of the host object for the last 48 hours. If you cannot find the historical data of the host corresponding to the current log time, you will not be able to view the attribute view of the associated host.

    

=== "Trace"

    Through the **Trace** at the bottom of the detail page, you can view the flame graph and Span list of the current log-related trace (associated field: `trace_id`). Click the transfer button in the upper right corner to directly view the corresponding trace details.

    > For more information on the flame graph and Span list of the trace, please see [Trace Analysis](../application-performance-monitoring/explorer/explorer-analysis.md).
    
    - Flame Graph:
    
    ![](img/6.log_10.png)
    
    - Span List:
    
    ![](img/6.log_11.png)

=== "Container"

    Guance supports you to view the basic information and performance metric status **within the selected time component range** of the related container (associated field: `container_name`) through the **Container** at the bottom of the detail page.
    
    - Attribute View: Help you trace back the real situation of the container object when the log was generated, supporting viewing the **latest object data produced by the related container within the corresponding time**, including basic and attribute information of the container.
    
    ![](img/6.log_5.png)
    
    - Metric View: Support viewing the performance metric status of the related container **within 30 minutes before the log ends to 30 minutes after the log ends**, including performance metric views such as container CPU and memory.
    
    ![](img/6.log_6.png)

=== "Pod"

    Guance supports you to view the attribute view and metric view of the related Pod (associated field: `pod_name`) through the **Pod** at the bottom of the detail page.
    
    - Attribute View: Help you trace back the real situation of the container Pod object when the log was generated, supporting viewing the **latest object data produced by the related container Pod within the corresponding time**, including basic and attribute information of the Pod.
    
    ![](img/6.log_pod_1.png)
    
    - Metric View: Support viewing the performance metric status of the related container Pod **within 30 minutes before the log ends to 30 minutes after the log ends**, including performance metric views such as Pod CPU and memory.
    
    ![](img/6.log_pod_2.png)

=== "Metric"

    The metrics associated with logs are divided into three views according to the associated fields: `service`, `project`, and `source`.
    
    - Service Metrics:
    
    ![](img/6.log_7.png)
    
    - Project Metrics:
    
    ![](img/6.log_9.png)
    
    - Source Metrics:
    
    ![](img/6.log_8.png)

=== "Network"

    Guance supports you to view the network data connection status within 48 hours through the **Network** at the bottom of the detail page. This includes Host, Pod, Deployment, and Service.

    > For more details, please see [Network](../infrastructure/network.md).
    
    ![](img/7.host_network_2.png)

    

    **Matching Fields**
    
    To view related networks on the detail page, you need to match the corresponding associated fields, which means configuring the corresponding field tags during data collection; otherwise, you will not be able to match and view the associated network views on the detail page.

    - Host: Match the field `host`, and support copying the associated field and its value by clicking the **Copy** button on the right.

    - Pod: Match the fields below, and support copying the associated field and its value by clicking the **Copy** button on the right.

    | **Matching Field Priority**  |
    | ------------------- |
    | namespace, pod_name |
    | namespace, pod      |
    | pod_name            |
    | pod                 |

    - Deployment: Match the fields below, and support copying the associated field and its value by clicking the **Copy** button on the right.

    | **Matching Field Priority**  |
    | ------------------- |
    | namespace, deployment_name |
    | namespace, deployment      |
    | deployment_name            |
    | deployment                 |

    ???+ abstract "BPF Logs"
     
        For logs with `source = bpf_net_l4_log` and `source: bpf_net_l7_log`, support for viewing **associated networks** (associated field: `host`) is available.
        
        Associate network logs through `inner_traceid` and `l7_trace_id`:

        - The `inner_traceid` field associates Layer 4 and Layer 7 networks on the same network card;

        - The `l7_trace_id` field associates Layer 4 and Layer 7 networks across network cards.
    
        Associated network views:

        :material-numeric-1-circle-outline: `pod` matches the `src_k8s_pod_name` field, displaying the pod inner view.

        :material-numeric-2-circle-outline: `deployment` matches the `src_k8s_deployment_name` field, displaying the deployment inner view.

    - Service: Match the fields below, and support copying the associated field and its value by clicking the **Copy** button on the right.

    | **Matching Field Priority**  |
    | ------------------- |
    | namespace, service_name |
    | namespace, service      |

    **Note**:    
    - If associated fields for Host, Pod, Deployment, and Services are queried at the same time, the detail page will display the network data in this order;  
    - If no associated fields are queried, they will be displayed at the end in gray, and clicking will prompt **No Network View Matched**.

### Bind Inner Views

Guance supports setting up the binding or removing of inner views (user views) to the log detail page. Click on Bind Inner View to add a new view to the current log detail page.

<img src="../img/log-view.png" width="70%" >
