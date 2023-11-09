# Log Explorer
---


When the log data is collected into Guance, you can view all the log contents in the workspace through **Logs** in the Guance workspace.

## Explorer Modes

Log explorer supports three viewing modes, including all logs, pattern analysis, and chart analysis. 
 
=== "ALL Logs" 
 
    ALL logs: Viewing and analyzing based on the collected original log data. 
    
    ![](img/log-explorer-en-1.png)

=== "Pattern Analysis" 
 
    Pattern: Analyzing the similarity of raw log data. By default, pattern is performed based on the message field, but custom patterning fields can also be specified if needed.

    Log Scope: The current time range is determined based on the selected time range in the upper right corner. A total of 10,000 log data within this time range will be used for pattern analysis. Logs with high similarity will be patterned together, and common patterns will be extracted and counted.

    You can click the icon :octicons-triangle-up-16: & :octicons-triangle-down-16: icons to sort the document count, with the default sorting order being descending.

    Clicking on a pattern list will display all the current patterns. The data list will be sorted in reverse chronological order and can display the most recent 50 log data. You can choose to display 1 line, 3 lines, or 10 lines. Clicking on **Related logs** will allow you to view the corresponding log details.
    
    ![](img/log-explorer-en-2.png)

=== "Analysis" 
 
    In **Logs > Explorers**, select **Analysis** in the upper right corner to group statistics of the original log data based on **1-3 tags**, so as to reflect the distribution characteristics and trends of log data under different groups and at different times. 
    
    The guance supports a variety of browsing methods for grouped data: timeseries, top list, pie chart and treemap. 
    
    > For more details, see [Analysis Mode for Explorer](../getting-started/necessary-for-beginners/explorer-search.md#analysis). 
    
    ![](img/log-explorer-en-3.gif)

## Log Query and Analysis

Guance supports a variety of ways to query and analyze log data:

### Time Intervals & Export

Guance will automatically divide several time points according to the selected time range, and show the number of different log states through stacked histogram to help statistical analysis. If the log is filtered, the histogram shows the filtered results synchronously.

- Log statistical chart supports floating to the chart through the mouse, and click the **Export** button to export to the dashboard or notes;
- Log charts support custom selection of time intervals.

![](img/1-log-explorer-0320-en.png)

### Time Control

Guance explorer displays the log data of the last 15 minutes by default, and you can select the [time range](../getting-started/function-details/explorer-search.md#time) of log data display.

### Log Index

Guance supports setting log multiple indexes, filtering qualified logs and saving them in different log indexes, and helping users save log data storage costs by selecting different data storage strategies for log indexes.

After setting the index in **Logs > Index**, it is supported to select different indexes in the explorer to view the corresponding log contents. 

> See [Log Index](multi-index.md).

![](img/log-explorer-en-5.png)

### Search and Filter

In the search bar of log explorer, it supports many [search and filter methods](../getting-started/function-details/explorer-search.md).

### DQL Search {#dql}

**Notes**: The DQL search feature currently only supports log explorer use.

In the log explorer, you can switch to DQL manual query mode by clicking on :fontawesome-solid-code: in the search box. This allows you to customize input filter conditions and search criteria.

- Filter condition: Support any combination of `and / or` , the use of `()` parentheses to indicate the priority of performing searches, and `=`, `!=` and other operators;
- Search condition: Support string queries using the DQL function `query_string()` such as entering `message = query_string()` to search log contents.

> See [DQL Definition](../dql/define.md) for more DQL syntax.

### Quick Filter

In the log explorer, you can use quick filters to easily filter logs. You can edit the [quick filters](../getting-started/function-details/explorer-search.md#quick-filter) and add new filter fields.

### Column

The log explorer displays the `time` and `message` fields by default, where the `time` field is fixed and cannot be deleted. When hovering on the display column of the explorer, click the **Set** button to support ascending, descending, moving columns to the left, moving columns to the right, adding columns to the left, adding columns to the right, replacing columns, adding to shortcut filtering, adding to grouping, removing columns and other operations. 

> See [Display Column Description](../getting-started/function-details/explorer-search.md#columns).

### Creat Monitors {#new}

You can use this link in the log explorer to directly navigate to the monitor creation page and quickly set up anomaly detection rules for log data.

<img src="../img/explorer-monitor.png" width="70%" >

> See [How to create monitors](../monitoring/monitor/index.md#new) for more details.

### Copy as cURL

The log explorer supports retrieving log data through the command line. On the right side of the log data list, click on :fontawesome-solid-gear: and then click on **Copy as cURL** to copy the cURL command. Go to the terminal of the host and execute the command to retrieve log data based on the selected filtering and search criteria within the current time range.

<img src="../img/logexport-1.png" width="70%" >

<u>**Example**</u>

After copying the cURL command line, follow the steps shown in the image below: Replace `<Endpoint>` with the domain name and `<DF-API-KEY>` with the **Key ID** by going to [API Management](../management/api-key/index.md).

> For more information about related parameters, see [DQL Data Query](../open-api/query-data/query-data.md).
> 
> For more information about the API, see [Open API](../management/api-key/open-api.md).

```shell
curl '<Endpoint>/api/v1/df/query_data?search_after=\[1680226330509,8572,"L_1680226330509_cgj4hqbrhi85kl1m6os0"\]&queries_body=%7B%22queries%22:\[%7B%22uuid%22:%222eb41760-cf6e-11ed-a983-7d559044c3fc%22,%22qtype%22:%22dql%22,%22query%22:%7B%22q%22:%22L::re(%60.*%60):(%60*%60)%7B+%60index%60+IN+\[%27default%27\]+%7D%22,%22highlight%22:true,%22limit%22:50,%22orderby%22:\[%7B%22time%22:%22desc%22%7D\],%22_funcList%22:\[\],%22funcList%22:\[\],%22disableMultipleField%22:false,%22disable_slimit%22:false,%22is_optimized%22:true,%22offset%22:0,%22search_after%22:\[1680226330509,8572,%22L_1680226330509_cgj4hqbrhi85kl1m6os0%22\],%22timeRange%22:\[1680187562081,1680230762081\],%22tz%22:%22Asia%2FShanghai%22%7D%7D\]%7D' \
- H 'DF-API-KEY: <DF-API-KEY>' \
- -compressed \
- -insecure
```


**Note**: Only Standard members and roles above can perform the copy command line operation.

In addition to this export path, you can also use [other log data export](#logexport) methods.



### Format

Formatting configurations allow you to hide sensitive log data content or highlight log data content that needs to be viewed, and for quick filtering by replacing existing log content.

Click :fontawesome-solid-gear: in the upper right corner of the explorer list, click **Format** to add mapping, enter the following contents and click **Save** to replace the original log content with "DEGUB" in the format you want to display.

- Value: such as content
- Displayed as content: such as `******`
- Color: free to set colors of the value

**Note**: Only administrators and roles above can configure explorer formatting.

![](img/log-explorer-en-16.png)

### Log Highlight

In order to enable you to get the key data information of the log faster, Guance uses different colors to highlight different contents of the log, which are divided into two theme colors: light color and dark color.

**Note**: If you search the log in the search bar, only the matching keywords are highlighted in the returned list.

| Log Content | Light Color Theme | Dark Theme |
| --- | --- | --- |
| Date (when the log occurred) | Yellow | Light yellow |
| Keyword (HTTP protocol related, such as GET) | Green | Light green |
| Text (Quoted String) | Blue | Light blue |
| Default (unmarked text) | Black | Grey |
| Numbers (log status codes, etc., such as 404) | Purple | Light purple |

![](img/log-explorer-en-7.png)

### Single Line Expansion

Click :material-chevron-down: to expand and view the full content of a log;

Click :octicons-copy-16: to copy the entire log content. When the log is expanded, if JSON display is supported, the log will be shown in JSON format, otherwise, it will be displayed normally.

![](img/log-explorer-en-8.png)

### Multiline Browse

The log data list of Guance shows you the trigger "time" and the "content" of the log by default. You can select Log Display "1 Line", "3 Lines", or "10 Lines" in the **Column** of the explorer to view the complete log contents.

![](img/log-explorer-en-9.png)

<!--
### Log Data Export {#logexport}

In **Log**, you can filter out the desired log data first, and then export it through :fontawesome-solid-gear: for viewing and analysis. Export to CSV files or dashboards and notes is supported.

![](img/log-explorer-en-16.png)
-->

## Log Details

Click on the log list, you can draw out the details page of the current log to view the details of the log, including the time when the log was generated, host, source, service, content, extended fields, viewing context, etc.


### View Full Log

When the log is reported to Guance, if the data exceeds 1M size, it will be divided according to 1M standard(one log is 2.5 M, and it will be divided into three pieces (1M/1M/0.5M)). You can view the integrity of the cut log according to the following fields:

| Field               | Type   | Description                                                         |
| ------------------ | ------ | ------------------------------------------------------------ |
| __truncated_id     | string | Indicates the unique identity of the log, and splits multiple logs with the same __truncated_ID, and the ID prefix is LT_xxx |
| __truncated_count  | number | Indicates the total number of sliced logs                                       |
| __truncated_number | number | Indicates the splitting order of the log, starting from 0, and 0 indicates the one that starts the log        |

On the log details page, if the current log is cut into multiple posts, the "View full log" button will be displayed in the upper right corner. Clicking "View full log" will open a new page and list all relevant logs according to the log segmentation order. At the same time, the page will color the selected logs before jumping to help locate the upstream and downstream.

### Log Context {#up-down}

On the Log Details page, click **Log Context** in the upper right corner to open a new page and jump to the Log Explorer.

When you open a new log explorer in the view context of the log details page, you will view the data around the current log time with "host", "source", "service" and "filename" as filters.

![](img/log-explorer-en-27.png)


### Attributes

When hovering on attribute fields, you can view the fields including host, process, link and container data related to logs.

| Fields      | Description        |
| ----------- | ------------------- |
| Filter      | Add this field to the log explorer to view all log data related to this field and value.        |
| Reverse filter      | Add this field to the log explorer to view other log data besides this field value.        |
| Add to showcolumns      | Add the field to data list for viewing.        |
| Copy      | Copy the field to the clipboard.          |
| View Related Containers      | View all containers associated with this host.        |
| View Related Processes      | View all processes related to this host.        |
| View Related Links      | View all links related to this host.        |
| View Related Security Check     | View all security check data related to this host.        |


![](img/log-explorer-en-14.png)

### Content

Log content automatically displays JSON and text viewing modes according to `message` type. If there is no message field in the log, the content of the log will not be displayed. The content of the log supports expansion and folding, which is expanded by default. After folding, only the height of 1 line will be displayed.

### Extended Attributes

:material-numeric-1-circle-outline: In the search bar, you can enter the field name or value to quickly search and locate.

:material-numeric-2-circle-outline: After checking the field alias, you can view it after the field name. You can choose as needed.

:material-numeric-3-circle-outline: When the extended attribute is selected, click on the dropdown icon in front to quickly filter and view using the small icons for **Filter**, **Reverse Filter**, **Add to showcolumns** and **Copy**.

![](img/log-explorer-en-15.png)


### Correlation Analysis

=== "Host"

    Guance enables you to view the metrics view and property view of related hosts (associated field: host) through **Host** at the bottom of the details page. 
    
    - Metric view: You can view the performance of related hosts **from 30 minutes before the end of the log to 30 minutes after the end of the log**, including CPU, memory and other performance views of related hosts. 
    

    - Attribute view: It helps you trace back the real situation of host objects when the log is generated, and support viewing **the latest object data generated by relevant hosts in the corresponding time**, including the basic information of hosts and the operation of integration. If you start the collection of cloud hosts, you can also view the information of cloud providers. 
    
    **Note**: Guance holds the historical data of the last 48 hours of host objects by default. If the host history data corresponding to the current log time is not found, you will not be able to view the attribute view of the associated host.
    
    <img src="../img/log-explorer-en-18.png" width="70%" >

=== "Trace"

    Through **Trace** at the bottom of the details page, you can view the flame graph and Span list of trace related to the current log (associated field: `trace_id`), and click **Jump** button in the upper right corner to directly correspond to the link details. 
    
    > For more information on flame graph and Span lists, see [Trace Analysis](../application-performance-monitoring/explorer.md).
    
    - Flame graph 
    
    <img src="../img/log-explorer-en-28.png" width="70%" >
    
    - Span List
    
    <img src="../img/log-explorer-en-29.png" width="70%" >


=== "Container"

    Guance enables you to view the basic information of the relevant container (associated field: container_name) and the performance of in the selected time component range through the **container** at the bottom of the details page. 
 
    - Attribute view: It helps you trace back the real situation of container objects when log is generated, and supports viewing the latest object data generated by relevant containers in the corresponding time, including the basic information and attribute information of containers. 

    
    <img src="../img/log-explorer-en-20.png" width="70%" >
    
    - Metric view: It supports viewing the performance of related containers from 30 minutes before the end of the log to 30 minutes after the end of the log, including the performance views of containers such as CPU and memory.
    
    <img src="../img/log-explorer-en-21.png" width="70%" >

=== "Pod"

    Guance enables you to view the attribute view and metrics view of related Pod (related field: pod_name) through **Pod** at the bottom of the details page. 
 
    - Attribute view: Help you trace back the real situation of container pod object when log is generated, and support viewing **the latest object data of relevant container pod** in corresponding time, including basic information and attribute information of pod. 

    
    <img src="../img/log-explorer-en-22.png" width="70%" >
    
    - Metric view: support to view the performance of related container pod **from 30 minutes before the end of the log to 30 minutes after the end of the log**, including Pod CPU, memory and other performance views.
    
    <img src="../img/log-explorer-en-23.png" width="70%" >

=== "Metrics"

    The index associated with the log is divided into three views according to the associated fields, which are "service", "project" and "source".

=== "Network"

    Guance enables you to view network data connections within the last 48 hours through the Network section at the bottom of the details page. This includes Host, Pod, Deployment, and Service information.

    > See [Network](../infrastructure/network.md).
    
    <img src="../img/log-explorer-en-24.png" width="70%" >
    
    **Matching field:**

    To view the related network in the details page, you need to match the corresponding related fields (logs need to configure the corresponding field labels during data collection, otherwise it cannot view the related network pages in the details page). 
 
    - Host: Match the field `host`, and you can click **Copy** button to copy related fields and their values. 
    - Pod: The matching fields are listed below. Click the **Copy** button on the right to copy the associated field and its value.
 
    | **Matching Field Priority**  |
    | ------------------- |
    | `namespace`; `pod_name` |
    | `namespace`; `pod`      |
    | `pod_name`            |
    | `pod`                |

    - Deployment: The matching fields are as follows. Click the **Copy** button on the right to copy the associated field and its value.

    | **Matching Field Priority**  |
    | ------------------- |
    | `namespace`; `deployment_name` |
    | `namespace`; `deployment`      |
    | `deployment_name`           |
    | `deployment`                 |

    - Service: The matching fields are as follows. Click the **Copy** button on the right to copy the associated field and its value.

    | **Matching Field Priority**  |
    | ------------------- |
    | `namespace`; `service_name` |
    | `namespace`; `service`      |

    ???+ warning 

        - If the associated fields of Host, Pod and Deployment are configured at the same time, the data of Pod network will be displayed first when entering the details page, followed by the data of Deployment network; 

        - If the associated fields of Pod, Deployment are not configured, the network data is not displayed. 

### Bind View

Guance supports setting up binding or deleting inner views (user views) to the log detail page. Click on **Bind View** to add a new view to the current log detail page.

<img src="../img/log-view.png" width="70%" >

