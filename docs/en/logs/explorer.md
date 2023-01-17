# Logs Explorer
---

## Overview

When the log data is collected into Guance Cloud, you can view all the log contents in the workspace through "log" in the Guance Cloud console.

## Explorer

Log explorer supports three viewing modes, including all logs, pattern analysis, and chart analysis. 

=== "ALL log" 

    Into "Log"-"Explorer", select "All Log" to view and analyze based on the collected original log data. 
    
    ![](img/5.log_1.png)

=== "Cluster analysis" 

    Into "Log"-"Explorer", click "Pattern analysis" to calculate and analyze the similarity of the original log data. 
    
    Clustering field: Clustering is based on the 'message' field by default, and clustering fields can be customized according to needs. 
    
    Log range: Fix the current time period according to the time range selected at the top right, obtain 10,000 pieces of data in this time period for cluster analysis, aggregate the logs with high approximation, and extract and count the common Pattern clustering. 
     
    Click on the Pattern clustering list to draw out all the current Pattern clustering lists, and the returned data lists are arranged in reverse order according to time. It supports displaying the latest 50 log data, and can be displayed in 1 row, 3 rows and 10 rows. Click on the "Associated Log" list to view the corresponding log details. 


​    
    ![](img/4.log_2.png)

=== "Chart Analysis" 

    Into "Log"-"Explorer", select "Group" in the upper right corner to group statistics of the original log data based on **1-3 tags**, so as to reflect the distribution characteristics and trends of log data under different groups and at different times. The observation cloud supports a variety of browsing methods for grouped data: sequence diagram, ranking list, pie chart and rectangular tree diagram. For more details, please refer to the document [analysis Mode for the Explorer](../getting-started/necessary-for-beginners/explorer-search.md#analysis). 
    
    ![](img/5.log_analysis.gif)


## Log Details

Click on the log list, you can draw out the details page of the current log to view the details of the log, including the time when the log was generated, host, source, service, content, extended fields, viewing context, etc. Support to close the details page pop-up window directly through the esc button of the keyboard; Support to switch up and down keys (↑ ↓) on the keyboard to switch and view the details of up and down logs. 


### View the full log(名词需要调整)

When the log is reported to Guance Cloud, if the data exceeds 1M size, it will be divided according to 1M standard(one log is 2.5 M, and it will be divided into three pieces (1M/1M/0.5 M)). You can view the integrity of the cut log according to the following fields:

| Field               | Type   | Description                                                         |
| ------------------ | ------ | ------------------------------------------------------------ |
| __truncated_id     | string | Indicates the unique identity of the log, and splits multiple logs with the same __truncated_ID, and the ID prefix is LT_xxx |
| __truncated_count  | number | Indicates the total number of sliced logs                                       |
| __truncated_number | number | Indicates the splitting order of the log, starting from 0, and 0 indicates the one that starts the log        |

On the log details page, if the current log is cut into multiple posts, the "View Complete Log" button will be displayed in the upper right corner. Clicking "View Complete Log" will open a new page and list all relevant logs according to the log segmentation order. At the same time, the page will color the selected logs before jumping to help locate the upstream and downstream.

![](img/3.log_1.gif)

### View context {#up-down}

On the Log Details page, click "View Context" in the upper right corner to open a new page and jump to the Log Explorer.

![](img/2.log_updown_1.png)

When you open a new log explorer in the view context of the log details page, you will view the data around the current log time with "host", "source", "service" and "filename" as filters.

![](img/2.log_updown_2.png)


### Property

When the mouse clicks on attribute fields such as "Host" and "Source", it supports "Filter Field Value", "Reverse Filter Field Value", "Add to Display Column" and "Copy" for quick filtering viewing, and supports viewing host, process, link and container data related to logs. 

-"Filter field value": add this field to the log explorer to view all log data related to this field and value
-"Reverse filter field value": add this field to the log explorer to view other log data besides this field value
-"Add to display column": add the field to data list for viewing 
-"Copy": copy the field to the clipboard 
-"View Dependent Containers": view all containers associated with this host 
-"View Related Processes": view all processes related to this host 
-"View Related Links": view all links related to this host 
-"View related inspection": view all inspection data related to this host 


![](img/17.explorer_5.png)

### Message

Log content automatically displays Json and text viewing modes according to message type. If there is no message field in the log, the content of the log will not be displayed. The content of the log supports expansion and folding, which is expanded by default. After folding, only the height of 1 line will be displayed.

### Extended field

When the mouse selects the extended field, click the drop-down icon in front, and display the small icons of "Filter Field Value", "Reverse Filter Field Value", "Add to Display Column" and "Copy" for quick filtering view.

![](img/17.explorer_4.png)


### Correlation analysis

=== "Host"

    Guance Cloud enables you to view the metrics view and property view of related hosts (associated field: host) through "host" at the bottom of the Details page. 
    
    - Metrics view: You can view the performance of related hosts ** from 30 minutes before the end of the log to 30 minutes after the end of the log, including CPU, memory and other performance  views of related hosts. 
    
    ![](img/1.log_4.png)
    
    - Attribute view: Help you trace back the real situation of host objects when the log is generated, and support viewing the latest object data generated by relevant hosts in the corresponding time, including the basic information of hosts and the operation of integration. If you start the collection of cloud hosts, you can also view the information of cloud vendors. 
    
    Note: Guance Cloud holds the historical data of the last 48 hours of host objects by default. If the host history data corresponding to the current log time is not found, you will not be able to view the attribute view of the associated host.
    
    ![](img/1.log_4.1.png)

=== "Trace"
    Through "Trace" at the bottom of the details page, you can view the flame graph and Span list of trace related to the current log (associated field: trace_id), and click "Jump Button" in the upper right corner to directly correspond to the link details. For more information on flame graph and Span lists, see the documentation [Trace Analysis](../application-performance-monitoring/explorer.md).
    
    - Flame graph 
    
    ![](img/6.log_10.png)
    
    - Span List
    
    ![](img/6.log_11.png)


=== "Container"

    Guance Cloud enables you to view the basic information of the relevant container (associated field: container_name) and the performance  of in the selected time component range through the "container" at the bottom of the details page. 
     
    -Attribute view: Help you trace back the real situation of container objects when log is generated, and support viewing the latest object data generated by relevant containers in the corresponding time, including the basic information and attribute information of containers. 


​    
    ![](img/6.log_5.png)
    
    - Metrics view: It supports viewing the performance of related containers from 30 minutes before the end of the log to 30 minutes after the end of the log, including the performance views of containers such as CPU and memory.
    
    ![](img/6.log_6.png)

=== "Pod"

    Guance Cloud enables you to view the attribute view and metrics view of related Pod (related field: pod_name) through "Pod" at the bottom of the details page. 
     
    - Attribute view: Help you trace back the real situation of container pod object when log is generated, and support viewing the latest object data ** of relevant container pod ** in corresponding time, including basic information and attribute information of pod. 


​    
    ![](img/6.log_pod_1.png)
    
    - Metrics view: support to view the performance of related container pod ** from 30 minutes before the end of the log to 30 minutes after the end of the log, including Pod CPU, memory and other performance views.
    
    ![](img/6.log_pod_2.png)

=== "Metrics"

    The index associated with the log is divided into three views according to the associated fields, which are "service", "project" and "source".
    
    - Service
    
    ![](img/6.log_7.png)
    
    - Project
    
    ![](img/6.log_9.png)
    
    - Source 
    
    ![](img/6.log_8.png)

=== "Network"

    Guance Cloud enables you to view the data connectivity of related views (including Host, Pod, and Deployment) through "Network" at the bottom of the Details page.
    
    ![](img/12.network_detail_1.png)
    
    **Matching field**
    To view the related network in the details page, you need to match the corresponding related fields(logs need to configure the corresponding field labels during data collection, otherwise it cannot view the related network pages in the details page). 
     
    - host: Match the field "host", select "host" with the mouse, and support clicking "copy" button to copy related fields and their values 
    - Pod: Match the field "Pod_name", select "Pod" with the mouse, and support clicking "Copy" button to copy the associated field and its value 
    - Deployment: Match the field "Deployment_name", select "Deployment" with the mouse, and support clicking the "Copy" button to copy the associated field and its value 
     
    Note: 
    - If the associated fields of host, Pod and Deployment are configured at the same time, the data of Pod network will be displayed first when entering the details page, followed by the data of Deployment network; 
    - If the associated fields of Pod, Deployment are not configured, the network data is not displayed. 
     
    ** Network 48-hour replay ** 
     
    In network page, it supports clicking on the time control to select and view the 48-hour network data playback. 
     
    - Time range: view the data of 30 minutes before and after the log by default, and view the data of the latest hour by default if the current log occurs; 
    - Support any drag time range to view the corresponding network traffic; 
    - After dragging, the query is historical network data; 
    - After dragging, click the "Play" button or refresh the page to return to view the network data of "Recent 1 Hour". 
    
    ![](img/2.log_detail_4.png)


## Log Analysis

Guance Cloud supports a variety of ways to query and analyze log data, including search and filtering, quick filtering, log statistics, multi-line browsing, color highlighting, formatting configuration, log data export and so on.

### Log statistical chart

Guance Cloud will automatically divide several time points according to the selected time range, and show the number of different log states through stacked histogram to help statistical analysis. If the log is filtered, the histogram shows the filtered results synchronously. 

- Log statistical chart supports floating to the chart through the mouse, and click the Export button to export to the dashboard, notes or sticker board; 
- Log charts support custom selection of time intervals. 


![](img/10.export_pic.png)

### Time Selector

Explorer displays the log data of the last 15 minutes by default, and you can select the time range of log data display through the "Time Selector" in the upper right corner. For more details, please refer to the documentation [Time Selector Description](../getting-started/necessary-for-beginners/explorer-search.md#time) 


### Log Index

Guance Cloud supports setting log multiple indexes, filtering qualified logs and saving them in different log indexes, and helping users save log data storage costs by selecting different data storage strategies for log indexes. 

After setting the index in "Log"-"Index", it is supported to select different indexes in the explorer to view the corresponding log contents. For more details, please refer to the document [Log Index](multi-index.md). 


![](img/5.log_3.1.png)

### Search and Filter

In the search bar of log explorer, you can use search and it supports keyword search, wildcard search, association search(use AND/OR/NOT etc.), JSON search, DQL manual search and other search methods, and supports value filtering through ` tag/attribute `, including forward filtering, reverse filtering, fuzzy matching, reverse fuzzy matching, existence and nonexistence and other filtering methods. For more searches and filters, please refer to the document [Search Instructions](../getting-started/necessary-for-beginners/explorer-search.md).



### Filter

In Log Explorer, support editing "Filter" and add new filter fields. After adding, you can select their field values for quick filtering. For more filters, please refer to the document [Filter](../getting-started/necessary-for-beginners/explorer-search.md#quick-filter).

### Custom display columns

The log explorer displays the "time" and "message" fields by default, where the "time" field is fixed and cannot be deleted. When the mouse is placed on the display column of the list, click the "Settings" button to support ascending, descending, moving columns to the left, moving columns to the right, adding columns to the left, adding columns to the right, replacing columns, adding to shortcut filtering, adding to grouping, removing columns and other operations. See the documentation [Display Column Description](../getting-started/necessary-for-beginners/explorer-search.md#columns) for more custom display columns.

### Formatting configuration

Formatting configurations allow you to hide sensitive log data content or highlight log data content that needs to be viewed, and for quick filtering by replacing existing log content. 

Click "Settings" in the upper right corner of the viewer list, click "Format Configuration" to add mapping, enter the following contents, and click Save to replace the original log content with "DEGUB" in the format you want to display. 

-Fields: such as content 
-match: such as match (currently supports ` = `, `!= `, ` match `, ` not match `) 
-Matching content: such as DEBUG 
-Display as content: such as ` ******* ` 

Note: Only administrators and above can configure log explorer formatting.

![](img/11.log_format_2.png)

### Highlight 

In order to enable you to get the key data information of the log faster, Guance Cloud uses different colors to highlight different contents of the log, which are divided into two theme colors: light and dark. 

Note: If you search the log in the search bar, only the matching keywords are highlighted in the returned list. 

| Log content | light theme | dark theme | 
| --- | --- | --- |
| Date (time of log occurrence) | yellow | light yellow |
| Keywords (HTTP protocol related, such as GET) | green | light green |
| Text (Quoted String) | blue | light blue | 
| Default (unmarked text) | black | gray |
| Numbers (log status codes, etc., such as 404) | purple  | light purple | 


![](img/2.log_1.png)

### Log single-line expansion replication 

In log data list, you can use "mouse hover" to log contents, expand and view all log contents, and click "Copy" button to copy the whole log contents to the pad. When the log content is expanded, if JSON display is supported, the log will be displayed in JSON format, and if it is not supported, the log content will be displayed normally. 

![](img/5.log_explorer_1.png)

### Log multi-line display

The log data list shows you "time" and "content" of the log by default. You can select Log Display "1 Line", "3 Lines", or "10 Lines" in the "Display Column" of the explorer to view the complete log contents. 


![](img/5.log_explorer_2.png)

### Export

- In "Log", you can filter out the desired log data first, and then export it through "Settings" for viewing and analysis. Export to CSV files or dashboards and notes is supported.

![](img/5.log_explorer_3.png)

