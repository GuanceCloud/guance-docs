# Traces

---

In the Guance console, you can view all related data in **APM > Trace**. You can search, filter, export trace data, view trace details, and perform a comprehensive analysis of trace performance through flame graphs, Span lists, etc. Both synchronous and asynchronous calls can clearly track the data details of each trace.

## Trace List

Guance provides three types of trace viewing lists, which are **All Spans**, **Entry Spans**, and **All Traces**.

A Span represents a logical unit of work in a distributed system within a given time period, and multiple Spans constitute a trace trajectory (trace).

<div class="grid" markdown>

=== "All Spans"

    Display all collected Span data within the currently selected time range.
    
    ![](img/4.apm_1.png)

=== "Entry Spans"

    Filter and display all Span data that first entered within the currently selected time range.
    
    ![](img/4.apm_2.png)

=== "All Traces"

    Filter and display all Trace data containing the initial top-level Span within the currently selected time range.

    ![](img/4.apm_3.png)

</div>

## Query and Analysis

- Time widget: The Trace explorer defaults to showing data from the last 15 minutes. You can customize the [time range](../getting-started/function-details/explorer-search.md#time) for data display.

- In the Trace explorer search bar, it supports [various search and filtering methods](../getting-started/function-details/explorer-search.md).

    - **Note:** When you switch to view **service** or **trace** explorer, Guance defaults to retain your current filter conditions and time range.

- Analysis Mode: In the Trace explorer [analysis bar](../getting-started/function-details/explorer-search.md#analysis), you can perform multi-dimensional analysis statistics based on <u>1-3 tags</u> and support multiple data chart analysis methods.

- Quick Filter: Supports editing [quick filters](../getting-started/function-details/explorer-search.md#quick-filter), adding new filter fields.

- Filter History: Guance supports saving the explorer `key:value` search condition history in the [filter history](../getting-started/function-details/explorer-search.md#filter-history) and applying it to different explorers in the current workspace.

- Custom [display columns](../getting-started/function-details/explorer-search.md#columns): In the trace list, the default view is **time**, **trace ID**, **service**, **resource**, and **duration**, which can be customized to add, edit, delete, and drag display columns.

### Chart Statistics

In the trace explorer chart statistics, you can check the **Requests**, **Error Requests**, **Response Time** of different statuses of the trace within the selected time range, and you can filter the synchronous display chart statistics.

- Requests/Error Requests: Divide into 60 time points according to the selected time range, and use a histogram to statistically display requests and error requests for the trace.
- Response time: Divide into 60 time points according to the selected time range, and use a line graph to statistically display four response metrics, namely the average response time per second, P75 response time, P90 response time and P99 response time.

### Data Export

In the trace explorer, after filtering out the desired Trace data for viewing and analysis, you can export it to a CSV file or scenario dashboard and notes.

If you need to export a piece of data, open the details page of this piece of data, and click the :material-tray-arrow-up: icon in the upper right corner.

### Save as a Snapshot

Guance supports **viewing historical snapshots** to directly save the snapshot data of the current explorer. Through the [snapshot](../getting-started/function-details/snapshot.md) function, you can quickly reproduce instant copies of data and restore data to a certain point in time and a certain data display logic.

![](img/3.apm_6.gif)

## Trace Details {#detail}

In the trace explorer, you can view the corresponding trace details by clicking on any trace, including the time, duration, HTTP method, HTTP URL, HTTP status code, TraceId, Flame, Span list, service call relationship and associated logs, hosts, metrics, networks, etc.

![](img/9.apm_explorer_6.1.png)

If the current trace belongs to a front-end application (such as: browser), you can view the request time distribution in the trace details, including the request time proportions of Queueing (queue), First Byte (first packet), Download (download).

???+ warning

    The RUM SDK must be 2.2.10 and above to see this part of the data display. If there is a cross-domain situation, the header configuration needs to be adjusted.

    > For more details, see [Web Application Access](../real-user-monitoring/web/app-access.md#header).

<img src="../img/11.apm_browse_1.png" width="70%" >

### Flame {#flame}

The flame graph can clearly show the flow and execution time of each Span in the entire trace. You can view the corresponding service list and response time on the right side of the flame graph. Click on the Span in the flame graph, in the **Trace Details Page** you can view the corresponding Json content, you can view specific Span information by zooming in and out with the mouse wheel.

> For more details on the application of the flame graph, see [Skillfully Use Flame Graph to Analyze Trace Performance](../best-practices/monitoring/trace-glame-graph.md).

<div class="grid" markdown>

=== "Flame Graph Trace Explanation"

    ![](img/13.apm_flame.png)

    From the flame graph above, it can be seen that this call trace includes two services, namely <u>CloudCare and Mysql</u>. The trace starts with the POST request initiated by the CloudCare service, then executes `ActionResource.executeAction`, and finally executes the Mysql statement. During the entire process of executing `ActionResource.executeAction`, the Mysql statement is executed multiple times. The execution time of CloudCare and Mysql is calculated as follows:

    - Execution time of CloudCare service = D1+D2+D3+D4+D5+D6+D7+D8+D9+D10+D11
    - Execution time of Mysql service = span2+span3+......+span11

    ![](img/span_2.png)

    The details of the specific execution statement and execution time can be referred to the Span list.

=== "Calculation of Execution Time Proportion"

    The service execution time proportion in the flame graph refers to the ratio of each service to the total time in this call trace. Below is an example, this call trace contains two services, namely CloudCare and Mysql, the execution time proportions are 42.37% and 57.63% respectively. The CloudCare service has 2 Spans, and the Mysql service has 10 Spans.

    - Calculation method of Mysql service execution time proportion: the total execution time of all spans / the total duration of the current call trace.

    Calculation method explanation: The Mysql service in the figure below has a total of 10 Span quantities. You can click on each Span to get the execution time of the current Span. From the figure, you can see that the execution time of this Span is 5.08ms, and then in the same way, get the remaining 9 The execution time of a Span is added.

    ![](img/13.apm_flame_0.1.png)

    - Calculation method of CloudCare service execution time proportion: (current call trace total duration-mysql service execution time)/current call trace total duration

    Calculation method explanation: The CloudCare service in the figure below runs through the entire current call trace. Except for the execution time of the mysql service, the remaining time is the execution time of the CloudCare service (see the execution time of the marked red line part). The execution time proportion can also be directly viewed through the Span list to view the execution time and execution time proportion of each Span.

    ![](img/13.apm_flame.png)

=== "Asynchronous Call"

    In the flame graph, whether the service is a synchronous or asynchronous call, each trace performance data detail can be clearly tracked. For example, through the flame graph, you can clearly see which requests are performed asynchronously, the start time, end tim and total time spent.

    ![](img/9.apm_explorer_19.2.png)

</div>

### Span List

Display the total Span quantity and its list in this trace, including **Resource**, **Span Quantity**, **Duration**, **Execution Time** and **Proportion**.

You can search for Span. Click on any Span. In **Trace Details**, you can view the corresponding JSON content. Switch to the flame graph to synchronously display Span. If there are errors, error prompts will be displayed before Span.

![](img/9.apm_explorer_18.png)

#### Waterfall Chart {#waterfall}

In the Span list, click :material-chart-waterfall: to view the parent-child relationship between resources.

The waterfall chart displays Span data in order of start time. The left side list displays Span data and shows the execution time proportion of each resource. The right side displays the waterfall chart in order of time.

You can also search for Span in the 🔍 bar. The fuzzy search results of the resource (`resource`) field will be highlighted.

![](img/0710-span.gif)

### Service Map {#call}

The service map is used to view the relationship between various "services-resources", and supports viewing related service map through the `service`, `resource` field search and filter.

![](img/9.apm_explorer_9.gif)

### Options {#icon}

| Options      | Description                          |
| ----------- | ------------------------------------ |
| Full screen view/Restore default size      | You can click the full-screen view icon in the upper right corner of the trace detail :material-arrow-expand-all: to expand and view the trace flame graph horizontally; click the restore default size icon :material-arrow-collapse-all: to restore the detail page.                          |
| Expand/Collapse Minimap      | You can click the expand/collapse minimap icon on the left side of the trace detail :material-format-indent-increase: to quickly view the flame graph by selecting the interval, dragging, and scrolling on the minimap.                          |
| View Global Trace      | You can click the view global Trace icon on the left side of the trace detail :material-arrow-expand: to view the global trace in the flame graph.                          |
| Double-click Span      | In the flame graph, enlarge the Span in the middle to quickly locate and view its associated Span in the context.                          |
| Click on the service name      | Highlight the corresponding Span, click the service name again, and restore the default full selection Span. You can filter and view the Span corresponding to the service by clicking the service name.                          |

![](img/10.changelog_apm.gif)

### Attributes

:material-numeric-1-circle-outline: In the search bar, you can quickly search and locate by entering the field name or value;

:material-numeric-2-circle-outline: After checking the field alias, you can view it after the field name; you can choose as needed.

:material-numeric-3-circle-outline: In the trace detail page, you can view the related field properties of the current trace in **Extended Attributes**:

| Field      | Attribute                          |
| ----------- | ------------------------------------ |
| Filter       | That is, add this field to the explorer to view all data related to this field. You can filter and view the trace list related to this field in the trace explorer. See Figure 1.                          |
| Reverse filter     | That is, add this field to the explorer to view other data except this field.                          |
| Add to display column      | That is, add this field to the explorer list for viewing.                          |
| Copy      | That is, copy this field to the clipboard.                          |

![](img/extension.png)

???- abstract "Some fields do not support filter aggregation and related logic"

    Guance has some fields that use full-text indexing. These fields do not support you to do filter aggregation and related logic. The range of full-text index fields is as follows:

    | Category      | Field                  |
    | ----------- | ------------------ |
    | Infrastructure, Custom Infrastructure Type      | `message `                 |
    | Logs, Backup Logs      | `message`                  |
    | Security Check     | `message` / `title`                  |
    | Network      | `message`                  |
    | Traces      | `error_message` / `error_stack`                  |
    | Events      | `message` / `title` / `df_message` / `df_title`                  |
    | RUM Error      | `error_message` / `error_stack`                  |
    | RUM Long Task      | `long_task_message` / `long_task_stack`                  |

<font size=2>*Figure one*</font>

![](img/9.apm_explorer_8.png)

### Error Details

On the trace detail page, if there is an error trace, you can view the related error details.

> For more error trace analysis, see [Error Tracking](../application-performance-monitoring/error.md).

![](img/6.apm_error.png)

### Associated Analysis

<div class="grid" markdown>

=== "Associated Logs"

    In the trace details page, you can view the logs associated with the current trace (associated field: `trace_id`) through **Logs**. You can perform keyword search and multi-label filtering on the logs. The log content is displayed by default according to the **maximum display rows** and **display columns** settings of the log explorer. You can customize the display columns. If you need to view more detailed log content, you can click on the log content to jump to the log details page, or click the jump button to open on the log page.

    ![](img/3.apm_7.png)

    If you are an administrator or above, you can customize the associated fields. Click the settings button on the right side of the associated field, select the fields you need to associate in the pop-up dialog box, support manual input, drag and drop order and other operations, confirm to complete the configuration.

    ???+ warning

        The associated log custom field and service list association analysis configuration custom field affect each other. If a custom field is configured in the service list, it will be synchronized here.

        > For more details, please refer to [Service List Association Analysis](service-catalog.md#analysis).

    ![](img/3.apm_8.png)


=== "Code Hotspots"

    After the application is using the ddtrace collector to turn on APM traces and Profile performance tracking data collection at the same time, Guance provides Span level associated viewing analysis. On the trace details page, you can click on **Code Hotspots** under the flame graph to view the code hotspots associated with the current trace, including execution time consumption, methods, and execution time proportion.

    ![](img/9.apm_explorer_11.png)

    Clicking **View Profile Details** can jump to the Profile details page to view more associated code.

    ![](img/9.apm_explorer_12.png)


=== "Associated Host"

    In the trace details page, you can view the metric view and attribute view of the related host (associated field: `host`) through **Host**.

    - Metric View: You can view the performance metric status of the related host **within 30 minutes before the end of the trace to 30 minutes after the end of the trace**, including the performance metric view of the related host's CPU, memory, etc.

    ![](img/3.apm_9.png)

    - Attribute View: Helps you to trace back the real situation of the host when the trace is generated, support to view **the latest data generated within the corresponding time** of the related host, including the basic information of the host, integrated operating situation. If you turn on the collection of cloud hosts, you can also view the information of the cloud manufacturer.

    **Note:** Guance defaults to save the host's recent 48 hours of historical data. If the host's historical data corresponding to the current trace time is not found, you will not be able to view the attribute view of the associated host.

    ![](img/3.apm_10.png)


=== "Associated Container"

    In the trace details page, you can view the metric view and attribute view of the related container (associated field: `container_name`) through **Container**.

    - Metric View: Support viewing the performance metric status of the related container **within 30 minutes before the end of the trace to 30 minutes after the end of the trace**, including the performance metric view of the container CPU, memory, etc.

    - Attribute View: Help you to trace back the real situation of the container object when the trace is generated, supports viewing **the latest object data generated within the corresponding time** of the related container, including the basic information of the container, attribute information.


=== "Associated Pod"

    In the trace details page, you can view the attribute view and metric view of the related Pod (associated field: `pod_name`) through **Pod**.

    - Metric View: Support viewing the performance metric status of the related container Pod **within 30 minutes before the end of the trace to 30 minutes after the end of the trace**, including the performance metric view of the container CPU, memory, etc.

    - Attribute View: Help you trace back the real situation of the container Pod object when the trace is generated, supports viewing **the latest object data generated within the corresponding time** of the related container Pod, including the container's basic information, attribute information.


=== "Associated Network"

    Guance supports you to view [network](../infrastructure/network.md) data connection situation within 48 hours through the **Network** below the details page. Including Host, Pod, Deployment and Service.

    ![](img/7.host_network_2.png)

    <font color=coral>Matching Fields:</font>

    To view the related network in the details page, you need to match the corresponding associated fields, that is, you need to configure the corresponding field tags when collecting data, otherwise you can not match and view the associated network view in the details page.

    - Host: Match field `host`, support clicking the **Copy** button on the right to copy the associated field and its value.
    - Pod: Match fields as follows, support clicking the **Copy** button on the right to copy the associated field and its value.

    | **Matching Field Priority**  |
    | ------------------- |
    | namespace, pod_name |
    | namespace, pod      |
    | pod_name            |
    | pod                 |

    - Deployment: Match fields as follows, support clicking the **Copy** button on the right to copy the associated field and its value.

    | **Matching Field Priority**  |
    | ------------------- |
    | namespace, deployment_name |
    | namespace, deployment      |
    | deployment_name            |
    | deployment                 |

    - Service: Match fields as follows, support clicking the **Copy** button on the right to copy the associated field and its value.

    |   **Matching Field Priority**  |
    |   ------------------- |
    | namespace, service_name |
    | namespace, service      |

    ???+ warning

        - If the associated fields of Host, Pod, Deployment, Service are queried at the same time, the network data is displayed in this order when entering the details page;
        - If the associated field is not queried, it is displayed in gray at the end, clicking prompts **No matching network view**.

</div>