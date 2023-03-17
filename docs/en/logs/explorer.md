# Log Explorer
---

## Overview

When the log data is collected into Guance, you can view all the log contents in the workspace through **Log** in the Guance workspace.

## Log Explorer Mode

Log explorer supports three viewing modes, including all logs, pattern analysis, and chart analysis. 
 
=== "ALL Logs" 
 
    In **Log > Explorer**, select **All Logs** to view and analyze based on the collected original log data. 
    
    ![](img/log-explorer-en-1.png)

=== "Cluster Analysis" 
 
    In **Log > Explorer**, click **Pattern Analysis** to calculate and analyze the similarity of the original log data. 

    Clustering field: Clustering is based on the 'message' field by default, and clustering fields can be customized according to needs. 

    Log range: Fix the current time period according to the time range selected at the top right, obtain 10,000 pieces of data in this time period for cluster analysis, aggregate the logs with high approximation, and extract and count the common Pattern clustering. 
 
    Click on the Pattern clustering list to draw out all the current Pattern clustering lists, and the returned data lists are arranged in reverse order according to time. It supports displaying the latest 50 log data, and can be displayed in 1 row, 3 rows and 10 rows. Click on the **Associated Logs** list to view the corresponding log details. 

    
    ![](img/log-explorer-en-2.png)

=== "Chart Analysis" 
 
    In **Log > Explorer**, select **Group** in the upper right corner to group statistics of the original log data based on **1-3 tags**, so as to reflect the distribution characteristics and trends of log data under different groups and at different times. The guance supports a variety of browsing methods for grouped data: sequence diagram, ranking list, pie chart and rectangular tree diagram. For more details, please refer to the document [Analysis Mode for Explorer](../getting-started/necessary-for-beginners/explorer-search.md#analysis). 
    
    ![](img/log-explorer-en-3.gif)

## Log Query and Analysis

Guance supports a variety of ways to query and analyze log data, including search and filtering, quick filtering, log statistics, multi-line browsing, color highlighting, formatting configuration, log data export and so on.

### Log Statistics

Guance will automatically divide several time points according to the selected time range, and show the number of different log states through stacked histogram to help statistical analysis. If the log is filtered, the histogram shows the filtered results synchronously.

- Log statistical chart supports floating to the chart through the mouse, and click the **Export** button to export to the dashboard, notes or sticker board;
- Log charts support custom selection of time intervals.

![](img/10.export_pic.png)

### Time Control

Guance explorer displays the log data of the last 15 minutes by default, and you can select the time range of log data display through **Time Control** in the upper right corner. See the documentation [Time Control Description](../getting-started/function-details/explorer-search.md#time).

### Log Index

Guance supports setting log multiple indexes, filtering qualified logs and saving them in different log indexes, and helping users save log data storage costs by selecting different data storage strategies for log indexes.

After setting the index in** Log > Index**, it is supported to select different indexes in the explorer to view the corresponding log contents. Refer to the documentation [Log Index](multi-index.md).

![](img/5.log_3.1.png)

### Search and Filter

In the search bar of log explorer, it supports keyword search, wildcard search, association search, JSON search, DQL manual search and other search methods. It also supports value filtering through `tag/attribute`, including forward filtering, reverse filtering, fuzzy matching, reverse fuzzy matching, existence and nonexistence and other filtering methods. Refer to the documentation [Search Instructions for the Explorer](../getting-started/function-details/explorer-search.md).

### DQL Search {#dql}

> Prcondition: The DQL search feature currently only supports log explorer use.

In the log explorer, you can switch the small icon ![](img/8.explorer_2.1.png) by clicking on the search bar and then switch to DQL manual input query mode, in which custom input filters and search criteria are supported.

- Filter condition: Support any combination of `and / or` , the use of `()` parentheses to indicate the priority of performing searches, and `=`, `!=` and other operators;
- Search condition: Support string queries using the DQL function `query_string()` such as entering `message = query_string()` to search log contents.

See the document [DQL Definition](../dql/define.md) for more DQL syntax.

### Quick Filter

**Shortcut Filter** in **Log Explorer** supports editing **Shortcut Filter** and add new filter fields. After adding, you can select their field values for quick filtering. For more shortcut filters, refer to the documentation [Quick Filter](../getting-started/function-details/explorer-search.md#quick-filter).

### Custom Display Columns

The log explorer displays the "time" and "message" fields by default, where the "time" field is fixed and cannot be deleted. When the mouse is placed on the display column of the explorer, click the **Set** button to support ascending, descending, moving columns to the left, moving columns to the right, adding columns to the left, adding columns to the right, replacing columns, adding to shortcut filtering, adding to grouping, removing columns and other operations. See the documentation [Display Column Description](../getting-started/function-details/explorer-search.md#columns).

### Formatting

Formatting configurations allow you to hide sensitive log data content or highlight log data content that needs to be viewed, and for quick filtering by replacing existing log content.

Click **Set** in the upper right corner of the viewer list, click **Formatting** to add mapping, enter the following contents, and click **Save** to replace the original log content with "DEGUB" in the format you want to display.

- Fields: such as content
- match: such as match (currently supports `=`, `!=`, `match`, `not match`)
- Matching content: such as DEBUG
- Display as content: such as `******`

Note: Only administrators and above can configure explorer formatting.

![](img/11.log_format_2.png)

### Log Highlight

In order to enable you to get the key data information of the log faster, Guance uses different colors to highlight different contents of the log, which are divided into two theme colors: light color and dark color.

Note: If you search the log in the search bar, only the matching keywords are highlighted in the returned list.

| Log Content | Light Color Theme | Dark Theme |
| --- | --- | --- |
| Date (when the log occurred) | Yellow | Light yellow |
| Keyword (HTTP protocol related, such as GET) | Green | Light green |
| Text (Quoted String) | Blue | Light blue |
| Default (unmarked text) | Black | Grey |
| Numbers (log status codes, etc., such as 404) | Purple | Light purple |

![](img/2.log_1.png)

### Log Single Line Expansion Copy

In the Guance log data list, you can hover to log contents, expand and view all log contents, and click **Copy** button to copy the whole log contents to the pad. When the log content is expanded, if JSON display is supported, the log will be displayed in JSON format, and if it is not supported, the log content will be displayed normally.

![](img/5.log_explorer_1.png)

### Log Multiline Browse

The log data list of Guance shows you the trigger "time" and the "content" of the log by default. You can select Log Display "1 Line", "3 Lines", or "10 Lines" in the **Display Column** of the explorer to view the complete log contents.

![](img/5.log_explorer_2.png)

### Log Data Export

- In **Log**, you can filter out the desired log data first, and then export it through **Set** for viewing and analysis. Export to CSV files or dashboards and notes is supported.

![](img/5.log_explorer_3.png)

## Log Details

Click on the **Log List**, you can draw out the details page of the current log to view the details of the log, including the time when the log was generated, host, source, service, content, extended fields, viewing context, etc. It supports to close the details page pop-up window directly through the esc button of the keyboard; And it also supports to switch up and down keys (↑ ↓) on the keyboard to switch and view the details of up and down logs. 


### View Full Log

When the log is reported to Guance, if the data exceeds 1M size, it will be divided according to 1M standard(one log is 2.5 M, and it will be divided into three pieces (1M/1M/0.5M)). You can view the integrity of the cut log according to the following fields:

| Field               | Type   | Description                                                         |
| ------------------ | ------ | ------------------------------------------------------------ |
| __truncated_id     | string | Indicates the unique identity of the log, and splits multiple logs with the same __truncated_ID, and the ID prefix is LT_xxx |
| __truncated_count  | number | Indicates the total number of sliced logs                                       |
| __truncated_number | number | Indicates the splitting order of the log, starting from 0, and 0 indicates the one that starts the log        |

On the log details page, if the current log is cut into multiple posts, the "View full log" button will be displayed in the upper right corner. Clicking "View full log" will open a new page and list all relevant logs according to the log segmentation order. At the same time, the page will color the selected logs before jumping to help locate the upstream and downstream.

### View Context {#up-down}

On the Log Details page, click **View in Context** in the upper right corner to open a new page and jump to the Log Explorer.

![](img/log-explorer-en-26.png)

When you open a new log explorer in the view context of the log details page, you will view the data around the current log time with "host", "source", "service" and "filename" as filters.

![](img/log-explorer-en-27.png)


### Attributes

When the mouse clicks on attribute fields such as **Host** and **Source**, it supports **Filter Field Value**, **Reverse Filter Field Value**, **Add to Display Column** and **Copy** for quick filtering viewing, and supports viewing host, process, link and container data related to logs. 
 
- "Filter field value": add this field to the log explorer to view all log data related to this field and value
- "Reverse filter field value": add this field to the log explorer to view other log data besides this field value
- "Add to display column": add the field to data list for viewing 
- "Copy": copy the field to the clipboard 
- "View Dependent Containers": view all containers associated with this host 
- "View Related Processes": view all processes related to this host 
- "View Related Links": view all links related to this host 
- "View related inspection": view all inspection data related to this host 


![](img/log-explorer-en-14.png)

### Content

Log content automatically displays Json and text viewing modes according to message type. If there is no message field in the log, the content of the log will not be displayed. The content of the log supports expansion and folding, which is expanded by default. After folding, only the height of 1 line will be displayed.

### Extended Field

When the mouse selects the extended field, click the drop-down icon in front, and display the small icons of **Filter Field Value**, **Reverse Filter Field Value**, **Add to Display Column** and **Copy** for quick filtering view.

![](img/log-explorer-en-15.png)


### Correlation Analysis

=== "Host"

    Guance enables you to view the metrics view and property view of related hosts (associated field: host) through **Host** at the bottom of the details page. 
    
    - Metric view: You can view the performance of related hosts ** from 30 minutes before the end of the log to 30 minutes after the end of the log, including CPU, memory and other performance  views of related hosts. 
    
    ![](img/log-explorer-en-18.png)

    - Attribute view: It helps you trace back the real situation of host objects when the log is generated, and support viewing **the latest object data generated by relevant hosts in the corresponding time**, including the basic information of hosts and the operation of integration. If you start the collection of cloud hosts, you can also view the information of cloud providers. 
    
    Note: Guance holds the historical data of the last 48 hours of host objects by default. If the host history data corresponding to the current log time is not found, you will not be able to view the attribute view of the associated host.
    
    ![](img/log-explorer-en-19.png)

=== "Trace"

    Through **Trace** at the bottom of the details page, you can view the flame graph and Span list of trace related to the current log (associated field: trace_id), and click **Jump** button in the upper right corner to directly correspond to the link details. For more information on flame graph and Span lists, see the documentation [Trace Analysis](../application-performance-monitoring/explorer.md).
    
    - Flame graph 
    
    ![](img/log-explorer-en-28.png)
    
    - Span List
    
    ![](img/log-explorer-en-29.png)


=== "Container"

    Guance enables you to view the basic information of the relevant container (associated field: container_name) and the performance of in the selected time component range through the **container** at the bottom of the details page. 
 
    - Attribute view: It helps you trace back the real situation of container objects when log is generated, and supports viewing the latest object data generated by relevant containers in the corresponding time, including the basic information and attribute information of containers. 

    
    ![](img/log-explorer-en-20.png)
    
    - Metric view: It supports viewing the performance of related containers from 30 minutes before the end of the log to 30 minutes after the end of the log, including the performance views of containers such as CPU and memory.
    
    ![](img/log-explorer-en-21.png)

=== "Pod"

    Guance enables you to view the attribute view and metrics view of related Pod (related field: pod_name) through **Pod** at the bottom of the details page. 
 
    - Attribute view: Help you trace back the real situation of container pod object when log is generated, and support viewing **the latest object data of relevant container pod** in corresponding time, including basic information and attribute information of pod. 

    
    ![](img/log-explorer-en-22.png)
    
    - Metric view: support to view the performance of related container pod **from 30 minutes before the end of the log to 30 minutes after the end of the log**, including Pod CPU, memory and other performance views.
    
    ![](img/log-explorer-en-23.png)

=== "Metrics"

    The index associated with the log is divided into three views according to the associated fields, which are "service", "project" and "source".

=== "Network"

    Guance enables you to view the data connectivity of related views (including Host, Pod, and Deployment) through **Network** at the bottom of the Details page.
    
    ![](img/log-explorer-en-24.png)
    
    **Matching field**
    To view the related network in the details page, you need to match the corresponding related fields(logs need to configure the corresponding field labels during data collection, otherwise it cannot view the related network pages in the details page). 
 
    - host: Match the field "host", select "host" with the mouse, and support clicking "copy" button to copy related fields and their values 
    - Pod: Match the field "Pod_name", select "Pod" with the mouse, and support clicking "Copy" button to copy the associated field and its value 
    - Deployment: Match the field "Deployment_name", select "Deployment" with the mouse, and support clicking the **Copy** button to copy the associated field and its value 
 
    Note: 
    - If the associated fields of host, Pod and Deployment are configured at the same time, the data of Pod network will be displayed first when entering the details page, followed by the data of Deployment network; 

    - If the associated fields of Pod, Deployment are not configured, the network data is not displayed. 
 
    **Network 48-hour replay** 
 
    In network page, it supports clicking on the time control to select and view the 48-hour network data playback. 
 
    - Time range: view the data of 30 minutes before and after the log by default, and view the data of the latest hour by default if the current log occurs; 
    - Support any drag time range to view the corresponding network traffic; 
    - After dragging, the query is historical network data; 
    - After dragging, click the "Play" button or refresh the page to return to view the network data of "Recent 1 Hour". 

    ![](img/log-explorer-en-25.png)


