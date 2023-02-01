# Link Observer
---

## Introduction

In the Guance Console, you can view all link data in the "Link" of "Application Performance Monitoring". You can search, filter, export link data, view link details, and analyze link performance through flame diagram and span list, and you can clearly track the data details of each link performance, whether it is synchronous or asynchronous call.

## Link List


 Guance provides three link viewing lists, namely "All Span”, “All Top Spans” and “all Trace”. Spans represent logical units of work in a distributed system within a given time period, and multiple spans will form a link trace.

=== "All Span"

    It displays all Span data collected in the currently selected time range.
    
    ![](img/3.apm_3.png)

=== "All top-level Span"

    Filter displays all Span data entered for the first time in the currently selected time range.
    
    ![](img/3.apm_4.png)

=== "All Trace"

    It filters and displays all Trace data containing the initial top-level Span in the currently selected time range.
    
    ![](img/3.apm_5.png)

## Link Query and Analysis

### Time Control

The link observer displays the data for the last 15 minutes by default, and you can select the time range of data display through the Time Control in the upper right corner. See the documentation [time control description](../getting-started/necessary-for-beginners/explorer-search.md#time).

### Search and Filter

In the link observer search bar, it supports keyword search, wildcard search, association search and other search methods, and it also supports value screening through `tag/attribute`, including forward screening, reverse screening, fuzzy matching, reverse fuzzy matching, existence and nonexistence and other screening methods. For more searching and filtering, refer to the document [searching and filtering for the observer](../getting-started/necessary-for-beginners/explorer-search.md).

**Note: When you switch to view the Service or Link observer, Guance reserves the current filter criteria and time range for you by default.**

### Analysis Mode

In the analysis bar of link viewer, multi-dimensional analysis and statistics based on **1-3 tags** are supported to reflect the distribution characteristics and trends of data in different dimensions and at different times. Guance supports a variety of data chart analysis methods, including time sequence chart, ranking list, pie chart and rectangular tree chart. For more details, please refer to the document [analysis Mode for the observer](../getting-started/necessary-for-beginners/explorer-search.md#analysis).

### Quick Filter

Shortcut Filter in Link Observer, support editing "Shortcut Filter" and add new filter fields. After adding, you can select their field values for quick filtering. For more shortcut filters, please refer to the document [shortcut filters](../getting-started/necessary-for-beginners/explorer-search.md#quick-filter).

### Filter History

Guance supports saving the search condition history of viewer `key:value` in "filter history", which is applied to different viewers in the current workspace. See the documentation [filter history](../getting-started/necessary-for-beginners/explorer-search.md#filter-history).

### Chart Statistics

Chart statistics in the link observer supports viewing the "number of requests", "number of wrong requests" and "response time" of different states of the link within the selected time range, and it also supports synchronizing display of chart statistics through filtering.

- Number of requests/number of erroneous requests: According to the selected time range, it is divided into 60 time points, and the "number of requests" and "number of erroneous requests" of the link are statistically displayed by histogram.
- Response time: According to the selected time range, it is divided into 60 time points, and four response metrics are statistically displayed by line chart, which are "average response time per second", "P75 response time", "P90 response time" and "P99 response time".

### Custom Display Columns

In Link Observer, "Time", "Link ID", "Service", "Resource" and "Duration" are viewed by default, and display columns can be added, edited, deleted and dragged by custom through "Display Columns". When the mouse hovers over the observer display column, click the "Settings" button to support ascending, descending, moving columns to the left, moving columns to the right, adding columns to the left, adding columns to the right, replacing columns, adding to shortcut filtering, adding to grouping and removing columns and other operations. See the documentation [display column description](../getting-started/necessary-for-beginners/explorer-search.md#columns) for more custom display columns.

### Link Data Export

In Link Observer, you can filter out the desired link data for export and then view and analyze it, supporting export to CSV files or scene dashboards and notes.

### Save Snapshot

 Guance supports "viewing historical snapshots" to directly save the snapshot data of the current observer. Through the snapshot function, you can quickly reproduce the instantly copied data copy information and restore the data to a certain time point and a certain data display logic. See the documentation [snapshot](../management/snapshot.md).

![](img/3.apm_6.gif)

##  Link Details {#detail}

In the link observer, you can click on any link to view the corresponding link details, including the current link occurrence time, duration, http method, http url, http status code, TraceId, flame diagram, Span list, service invocation relationship and associated log, host, metric and network.

![](img/9.apm_explorer_6.1.png)

### Flame Graph

Flame graph can clearly show the flow and execution time of each span in the whole link. You can view the corresponding service list and response time on the right side of the flame graph. Click on the span of the flame graph, and view the corresponding Json content in "Link Details", which supports mouse scroll zooming to view specific span information. For more information on the application of flame graphs, please refer to the document [using flame graphs to analyze link performance](../getting-started/function-details/trace-glame-graph.md).

=== "Flame graph link description"

    ![](img/13.apm_flame.png)
    
    As can be seen from the flame graph above, this call link contains two services, namely cloudcare and mysql. The link starts with the POST request that initiates the cloudcare service, then executes the `ActionResource.executeAction`, and finally executes the mysql statement. During the whole process of executing `ActionResource.executeAction`, the mysql statement is executed several times. The execution time of cloudcare and mysql is calculated as follows:
    
    - cloudcare service execution time = D1+D2+D3+D4+D5+D6+D7+D8+D9+D10+D11
    - mysql service execution time = span2+span3+......+span11
    
    ![](img/span_2.png)
    
    Please refer to the span list for details of specific executed statements and execution time.

=== "Instructions for calculation of execution time proportion"

    The proportion of service execution time in the flame graph refers to the proportion of each service in the total time of calling the link this time. The following figure is an example. The calling link includes two services, namely cloudcare and mysql, and the execution time accounts for 42.37% and 57.63% respectively. The cloudcare service has 2 spans and the mysql service has 10 spans.
    
    - How to calculate the proportion of mysql service execution time: sum all span execution time/total length of current link call.
    
    Description of calculation method: There are 10 spans in mysql service in the following figure. You can click on each span to get the execution time of the current span. As can be seen from the figure, the execution time of the span is 5.08 ms, and then in the same way, get the execution time of the remaining 9 spans and add them up.
    
    ![](img/13.apm_flame_0.1.png)
    
    - How to calculate cloudcare service execution time ratio: (total current link calling time-mysql service execution time)/total current link calling time
    
    Description of calculation method: cloudcare service runs through the whole calling link in the following figure. Except for the execution time of mysql service, the remaining time is the execution time of cloudcare service (see the execution time in the red line). Percentage of execution time can also be directly through the span list to view the execution time and percentage of execution time of each span.
    
    ![](img/13.apm_flame.png)

=== "Asynchronous call"

    In the flame graph, whether the service is called synchronously or asynchronously, the data details of each link performance can be clearly tracked. For example, you can clearly see which requests are made asynchronously through the flame graph, when they started, when they ended, and how much time they took in total.
    
    ![](img/9.apm_explorer_19.2.png)

### Span List

The list shows all the spans in the link and their total number of spans, including "resource name", "number of spans", "duration", "execution time" and "percentage of execution time". It supports search span, click on any span, view the corresponding JSON content in "Link Details" and switch to the flame map to display span synchronously. If there is an error, display an error prompt before the span.

![](img/9.apm_explorer_18.png)

### Service Call Relationship

Service call relationship is used to view the call relationship between various services and supports viewing related service call relationship through search filtering.

![](img/9.apm_explorer_9.png)

### Shortcut Instructions {#icon}

- Full screen view/Restore default size: You can click the full screen view icon in the upper right corner of Link Details ![](img/9.apm_explorer_13.png), expand horizontally to view the link flame diagram; click the Restore Default Size icon ![](img/9.apm_explorer_13.1.png) to restore the details page;
- Expand/Retract mini-map: You can click the Expand/retract mini-map icon on the left side of link details ![](img/9.apm_explorer_14.png) to quickly view the flame map by selecting intervals, dragging and scrolling on the mini-map;
- View global Trace: You can click on the left side of Link Details to view the global Trace icon![](img/9.apm_explorer_15.png), view the global link in the flame graph;
- Double-click Span: Zoom in and display the Span in the middle of the flame graph, and you can quickly locate and view its context-related Span;
- Click on the service name: highlight the corresponding Span, click on the service name again, and restore the default all-selected Span. You can quickly filter and view the Span corresponding to the service by clicking on the service name.

![](img/10.changelog_apm.gif)

### Extended Attributes

On the link details page, you can view the related field properties of the current link in "Extended Properties". Click on the field to quickly filter through "Filter Field Value", "Reverse Filter Field Value", "Add to Display Column" and "Copy".

- "Filter field value", that is, add the field to the observer to view all the data related to the field
- "Reverse filter field value", that is, add this field to the observer to view other data besides this field
- "Add to display column", that is, add the field to the observer list for viewing
- "Copy", that is, copy the field to the clipboard 

![](img/9.apm_explorer_7.png)

Click "Filter Field Value" to filter and view the list of links related to this field in link observer.

![](img/9.apm_explorer_8.png)

### Error Details

On the Link Details page, if there is an error link, you can view the relevant error details. For more error link analysis, refer to the document [error tracing](../application-performance-monitoring/error.md).

![](img/6.apm_error.png)

### Association Analysis

=== "Associated User Access Experience"

    On the link details page, you can view the associated real user access experience data (associated field: trace_id) through the "related view" at the top of the page, which helps you to view the user access corresponding to application performance.
    
    ![](img/9.apm_explorer_19.1.png)

=== "Association Log"

    On the link details page, you can view the log based on the current link association (association field: trace_id) through log. Association log supports you to search for keywords and filter multiple tags on logs; log contents are displayed according to the configuration of "Maximum Display Rows" and "Display Columns" in log observer by default, and you can customize display columns. If you need to view more detailed log contents, you can click log contents to jump to log details page, or click jump button to log page to open.
    
    ![](img/3.apm_7.png)
    
    If you are an administrator or above, you can customize the associated fields. You can click the setting button on the right side of the associated field, select the field to be associated in the pop-up dialog box, support manual input, drag sequence and other operations and at last confirm to complete the configuration.
    
    Note: The association log custom field and the service list association analysis configuration custom field influence each other. If the custom field is configured in the service list, it will be displayed synchronously here. For more details, please refer to the document [service catalog association analysis](service-catalog.md#analysis).
    
    ![](img/3.apm_8.png)

=== "Code Hotspots"

    When the application uses the ddtrace collector to enable APM link tracing and Profile performance tracing data collection at the same time, Guance provides Span-level correlation view analysis. On the link details page, you can click "Code Hotspots" at the bottom of the flame diagram to view the code hotspots associated with the current link, including execution time, method and execution time ratio.
    
    ![](img/9.apm_explorer_11.png)
    
    Click "View Profile Details" to support jumping to the Profile Details page to view more associated codes, which helps you quickly find and locate problems.
    
    ![](img/9.apm_explorer_12.png)

=== "Associated Host"

    On the Link Details page, you can view the metrics view and the properties view of the associated host (associated field: host) through host.
    
    - Metric view: You can view the performance metric status of related hosts **from 30 minutes before the end of the link to 30 minutes** after the end of the link, including the CPU, memory and other performance metric views of related hosts.
    
    ![](img/3.apm_9.png)
    
    - Attribute view: it helps you to trace back the real situation of host objects when the link is generated, and supports viewing **the latest object data generated by relevant hosts in the corresponding time**, including the basic information of hosts and the operation of integration. If you start the collection of cloud hosts, you can also view the information of cloud suppliers.
    
    Note: Guance holds the historical data of the last 48 hours of host objects by default. If the host history data corresponding to the current link time is not found, you will not be able to view the attribute view of the associated host.
    
    ![](img/3.apm_10.png)

=== "Association Container"

    On the Link Details page, you can view the metrics view and property view of the relevant container (associated field: container_name) through the Container.
    
    - Metric view: It supports viewing the performance metric status of related containers**from 30 minutes before the end of the link to 30 minutes after the end of the link**, including the performance metric views of container CPU and memory.
    
    - Attribute view: It helps you trace back the real situation of container objects when links are generated, and supports **viewing the latest object data generated by relevant containers in the corresponding time**, including the basic information and attribute information of containers.

=== "Associated Pod"

    On the Link Details page, you can use "Pod" to view the properties view and metrics view of the related Pod (associated field: pod_name).
    
    - Metric view: It supports viewing the performance metric status of related container pod **from 30 minutes before the end of the link to 30 minutes after the end of the link**, including the performance metric views of container CPU and memory.
    
    - Attribute view: It helps you to trace back the real situation of container pod object when link is generated, and supports **viewing the latest object data generated by relevant container pod in corresponding time**, including basic information and attribute information of container.

=== "Associated Network"

    On the Link Details page, you can view the data connectivity of the associated host (associated field: host), Pod (associated field: pod_name), and Deployment (associated field: deployment_name) networks through Network. For more details, refer to the documentation [network](../infrastructure/network.md).
    
    Note:
    
    - If the associated fields of host, Pod and Deployment are configured at the same time, the data of Pod network will be displayed first when entering the details page, followed by the data of Deployment network;
    - If the associated fields of Pod and Deployment are not configured, the network data is not displayed.
    
    ![](img/12.network_detail_2.png)
