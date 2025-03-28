# Trace Explorer

---

After successful data collection, you can view all related data on the trace feature page. Using [the powerful search function](../../getting-started/function-details/explorer-search.md#search), you can easily filter and view trace data for any time period, quickly identifying and locating abnormal traces.

[Flame Graphs](#flame) provide you with an intuitive view to observe the flow and performance of each Span in a trace. Additionally, <<< custom_key.brand_name >>>'s tagging feature allows you to automatically associate infrastructure, logs, user access monitoring, and other data with trace analysis, supporting code-level data association views that help you quickly locate and resolve abnormal issues. Tools like [Span Lists](./explorer-analysis.md#span) and [Waterfall Charts](./explorer-analysis.md#waterfall) further display relevant Span information under a specific trace.

## Trace List

<<< custom_key.brand_name >>> provides three types of trace viewing lists: **All Spans**, **Service Entry Spans**, and **All Traces**.

A Span represents a logical unit of work within a given time period in a distributed system, and multiple Spans form a trace trajectory (`trace`).

<div class="grid" markdown>

=== "All Spans"

    Displays all Span data collected within the currently selected time range.

    ![](../img/4.apm_1.png)

=== "Service Entry Spans"

    Filters and displays all Spans generated by service entry calls within the currently selected time range.

    ![](../img/4.apm_2.png)

=== "All Traces"

    Filters and displays all top-level entry Spans of trace calls within the currently selected time range.

    ![](../img/4.apm_3.png)

</div>

## Manage Lists

### Chart Statistics

In the chart statistics section of the trace explorer, you can view key Metrics for different states of traces within the selected time range:

- Number of requests
- Error request count  
- Response time  

These Metrics can be displayed synchronously on the chart through filtering functions. Specific statistical methods are as follows:

- Request Count/Error Request Count: Based on the selected time range, the system divides it into 60 time points and displays the number of trace requests and error requests via bar charts.
- Response Time: Similarly divided into 60 time points based on the selected time range, four response time Metrics are displayed via line charts, including average response time per second, P75 response time, P90 response time, and P99 response time.

### Export {#export}

After filtering out the required trace data, you can export the data in the following formats for viewing and analysis:

- CSV files        
- JSONL files        
- Export to Use Cases > Dashboard/Notebook   

If you need to export a specific piece of data, open the detailed page of that data and click the :material-tray-arrow-up: icon in the upper right corner.

<img src="../../img/3.apm_6.png" width="70%" >

## Trace Details {#detail}

In the trace explorer, you can click on any trace to view the corresponding trace details, including relative time of occurrence, duration, HTTP method, HTTP URL, HTTP status code, TraceId, flame graph, Span list, service call relationships, and associated logs, hosts, metrics, networks, etc.

![](../img/9.apm_explorer_6.1.png)

If the current trace belongs to a frontend application (e.g., browser), you can view the distribution of request durations in the trace details, including Queueing (queue), First Byte (first packet), Download (download) request durations.

**Note**: The User Analysis SDK must be version 2.2.10 or higher to see this data display, and if there is a cross-origin situation, the header configuration needs adjustment.

> For more details, refer to [Web Application Integration](../../real-user-monitoring/web/faq.md#header).

<img src="../../img/11.apm_browse_1.png" width="70%" >

### Flame Graph {#flame}

The Flame Graph clearly displays the flow and execution time of each Span in the entire trace. You can view the corresponding service list and response times on the right side of the Flame Graph. By clicking a Span on the Flame Graph, you can view the corresponding Json content in the **Trace Details**, and zoom in using the mouse scroll wheel to view specific Span information.

> For more application details of the Flame Graph, refer to [Effective Use of Flame Graphs for Trace Performance Analysis](../../best-practices/monitoring/trace-glame-graph.md).

<div class="grid" markdown>

=== "Flame Graph Trace Explanation"

    ![](../img/13.apm_flame.png)

    From the Flame Graph above, you can see that this invocation trace includes two services: <u>CloudCare and Mysql</u>. The trace starts with a POST request initiated by the CloudCare service, then executes `ActionResource.executeAction`, and finally executes the Mysql statement. Throughout the execution of `ActionResource.executeAction`, the Mysql statement is executed multiple times. The execution time calculation methods for CloudCare and Mysql are as follows:

    - Execution time of CloudCare service = D1+D2+D3+D4+D5+D6+D7+D8+D9+D10+D11
    - Execution time of Mysql service = span2+span3+......+span11

    ![](../img/span_2.png)

    Specific statements and execution time details can be referenced from the Span list.

=== "Execution Time Percentage Calculation Explanation"

    The percentage of service execution time in the Flame Graph refers to the ratio of each service's execution time to the total time for this invocation trace. In the example below, this invocation trace includes two services: CloudCare and Mysql, with execution time percentages of 42.37% and 57.63%, respectively. CloudCare service has 2 Spans, and Mysql service has 10 Spans.

    - Mysql service execution time percentage calculation method: Sum of all Span execution times / Total duration of the current invocation trace.

    Calculation Method Explanation: There are 10 Spans in the Mysql service in the figure below, and you can click each Span to obtain the execution time of the current Span. As shown in the figure, the execution time of this Span is 5.08ms. Then use the same method to obtain the execution times of the remaining 9 Spans and sum them up.

    ![](../img/13.apm_flame_0.1.png)

    - CloudCare service execution time percentage calculation method: (Total duration of the current invocation trace - Mysql service execution time) / Total duration of the current invocation trace.

    Calculation Method Explanation: The CloudCare service runs throughout the current invocation trace in the figure below. Except for the Mysql service execution time, the remaining time is the CloudCare service execution time (see the red-marked part of the execution time). The execution time percentage can also be directly viewed from the Span list for the execution time and execution time percentage of each Span.

    ![](../img/13.apm_flame.png)

=== "Asynchronous Calls"

    In the Flame Graph, whether the service is synchronous or asynchronous, every detail of the trace performance data can be clearly tracked. For example, through the Flame Graph, you can clearly see which requests are asynchronous, start time, end time, and total time spent.

    ![](../img/9.apm_explorer_19.2.png)

</div>

### Span List {#span}

Displays all Span lists and their total Span count in this trace, including **resource name**, **Span count**, **duration**, **execution time**, and **execution time percentage**.

You can input the resource name or Span ID corresponding to the Span for search matching. Clicking any Span allows you to view the corresponding JSON content in the **Trace Details** and switch to the Flame Graph to display the Span simultaneously. If there is an error, an error message will be displayed.

Clicking **Error Spans** directly shows the filtered results.

![](../img/9.apm_explorer_18.png)

### Waterfall Chart {#waterfall}

View parent-child relationships between various resources.

The Waterfall Chart displays Span data according to the start time sequence. The left list shows Span data and displays the execution time percentage for each resource. On the right, it displays the Waterfall Chart according to the time sequence.

- You can input the resource name or Span ID corresponding to the Span for search matching;

- Click :octicons-arrow-switch-24: to toggle the format of execution time;

- Click **Error Spans** to directly show the filtered results.

![](../img/0710-span.gif)

### Service Call Relationships {#call}

Used to view call relationships between services and display the number of calls directly. You can search and filter to view related service call relationships through services, resources, and Span IDs.

<<< custom_key.brand_name >>> displays the color of the services here based on the `error` result statistics in the [Flame Graph](#flame) of the Trace Details. If it appears red, it indicates that the service has an error.

![](../img/9.apm_explorer_9.gif)

If you have configured the `service` [binding](../../scene/built-in-view/bind-view.md#bind) relationship in the user view, such as `service:mysql`. Clicking on the service card here will allow you to quickly view the related user views associated with that service.

Clicking a view will redirect you to its detailed page.

![](../img/apm_explorer_view.png)

### Quick Actions {#icon}

| <div style="width: 160px">Action</div> | Description                                                                                                                                                           |
| ------------------------------------ | -------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| Full-screen View/Restore Default Size | You can click the full-screen view icon :material-arrow-expand-all: in the upper-right corner of the trace details to expand horizontally and view the trace Flame Graph; clicking the restore default size icon :material-arrow-collapse-all: restores the details page. |
| Expand/Collapse Minimap               | You can click the expand/collapse minimap icon :material-format-indent-increase: on the left side of the trace details, allowing you to quickly view the Flame Graph by selecting intervals, dragging, and scrolling on the minimap.                              |
| View Global Trace                    | You can click the view global Trace icon :material-arrow-expand: on the left side of the trace details to view the global trace in the Flame Graph.                                                                      |
| Double-click Span                    | Amplify the display of the Span in the middle of the Flame Graph, allowing you to quickly locate and view context-related Spans.                                                                                             |
| Click Service Name                   | Highlight the corresponding Span, and clicking the service name again selects all Spans by default. You can quickly filter and view Spans corresponding to the service by clicking the service name.                                                  |

![](../img/10.changelog_apm.gif)

### Extended Attributes

:material-numeric-1-circle-outline: In the search bar, you can input field names or values for quick search and positioning;

:material-numeric-2-circle-outline: After checking field aliases, they appear after field names, and you can choose as needed.

:material-numeric-3-circle-outline: In the trace details page, you can view relevant field attributes of the current trace in **Extended Attributes**:

| <div style="width: 120px">Field</div> | Attribute                                                                                                           |
| ------------------------------------ | -------------------------------------------------------------------------------------------------------------- |
| Filter Field Value                   | Adds the field to the Explorer to view all data related to this field, and filters to view related trace lists in the Trace Explorer.<br />_See Figure One._ |
| Reverse Filter Field Value           | Adds the field to the Explorer to view all data except for this field.                                                           |
| Add to Display Column               | Adds the field to the Explorer list for viewing.                                                                             |
| Copy                                 | Copies the field to the clipboard.                                                                                         |

![](../img/extension.png)

???- abstract "Some Fields Do Not Support Filtering and Aggregation Logic"

    <<< custom_key.brand_name >>> has some fields indexed using full-text indexing, and these fields do not support filtering and aggregation logic. The scope of full-text indexed fields is as follows:

    | Category      | Field                  |
    | ----------- | ------------------ |
    | Objects, Resource Catalog      | `message `                 |
    | Logs, Backup Logs      | `message`                  |
    | Security      | `message` / `title`                  |
    | Networks      | `message`                  |
    | Traces      | `error_message` / `error_stack`                  |
    | Events      | `message` / `title` / `df_message` / `df_title`                  |
    | RUM Errors      | `error_message` / `error_stack`                  |
    | RUM Long Tasks      | `long_task_message` / `long_task_stack`                  |

<font size=2>_Figure One_</font>

![](../img/9.apm_explorer_8.png)

### Error Details

On the trace details page, if there are erroneous traces, you can view the related error details.

> For more analysis on erroneous traces, refer to [Error Tracking](../error.md).

![](../img/6.apm_error.png)

### Service Context {#context}

By obtaining object classifications from the infrastructure resource catalog and selecting the latest objects based on `create_time`, you can quickly view the current service’s runtime information, service dependencies, and integration information.

![](../img/trace_context.png)

### Correlation Analysis

<div class="grid" markdown>

=== "Correlated Logs"

    You can view logs associated with the current trace (correlation field: `trace_id`) through **Logs**. You can customize the display columns, and if you need to view more detailed log content, you can click the log content to navigate to the log details page, or click the jump button to open it on the log page.

    ![](../img/3.apm_7.png)

    If you have administrator-level permissions or above, you can customize correlation fields. Click the settings button next to the correlation field, and in the pop-up dialog box, select the fields you want to correlate, supporting manual input, drag-and-drop order operations, etc., confirming completes the configuration.

    ![](../img/3.apm_8.png)

    **Note**: Customizing correlation fields for logs and customizing correlation fields for service list analysis influence each other. If custom fields are configured in the service list, they will be displayed here synchronously.

=== "Code Hotspots"

    When the application uses ddtrace collectors and both APM trace tracking and Profile performance tracking data collection are enabled, <<< custom_key.brand_name >>> provides Span-level correlation viewing analysis. In the trace details page, you can click **Code Hotspots** below the Flame Graph to view code hotspots related to the current trace, including execution duration, methods, and execution time percentage.

    ![](../img/9.apm_explorer_11.png)

    Clicking **View Profile Details** allows you to navigate to the Profile details page to view more associated code.

    ![](../img/9.apm_explorer_12.png)

=== "Correlated Hosts"

    In the trace details page, you can view metric and attribute views of related hosts through **Hosts** (correlation field: `host`).

    - Metric View: Displays the performance metric status of related hosts **from 30 minutes before the end of the trace to 30 minutes after the end of the trace**, including CPU, memory, and other performance metric views of the related hosts.

    ![](../img/3.apm_9.png)

    - Attribute View: Helps you trace back to the actual state of the host object when the trace was generated, allowing you to view the latest object data produced by the related host **within the corresponding time period**, including basic host information and integration operation conditions. If cloud host collection is enabled, you can also view cloud provider information.

    **Note:** <<< custom_key.brand_name >>> defaults to saving the historical data of host objects for the last 48 hours. If no host historical data corresponding to the current trace time is found, you will not be able to view the attribute view of the associated host.

    ![](../img/3.apm_10.png)

=== "Correlated Containers"

    In the trace details page, you can view metric and attribute views of related containers through **Containers** (correlation field: `container_name`).

    - Metric View: Supports viewing the performance metric status of related containers <u>from 30 minutes before the end of the trace to 30 minutes after the end of the trace</u>, including container CPU, memory, and other performance metric views.

    - Attribute View: Helps you trace back to the actual state of the container object when the trace was generated, allowing you to view the latest object data produced by the related container <u>within the corresponding time period</u>, including basic container information and property information.

=== "Correlated Pods"

    In the trace details page, you can view the attribute and metric views of related Pods through **Pods** (correlation field: `pod_name`).

    - Metric View: Supports viewing the performance metric status of related Pods <u>from 30 minutes before the end of the trace to 30 minutes after the end of the trace</u>, including container CPU, memory, and other performance metric views.

    - Attribute View: Helps you trace back to the actual state of the Pod object when the trace was generated, allowing you to view the latest object data produced by the related Pod <u>within the corresponding time period</u>, including basic container information and property information.

=== "Correlated Network"

    <<< custom_key.brand_name >>> supports you to view multi-dimensional [network topology maps and summary data](../../infrastructure/network.md) including Host, Pod, Deployment, and Service in **Network**.

    ![](../img/7.host_network_2.png)

    **Matching Fields:**

    To view related networks in the details page, you need to match the corresponding correlation fields, i.e., configure the corresponding field tags during data collection; otherwise, you cannot match and view the correlated network views in the details page.

    - Host: Match field `host`.

    - Pod:

    | **Match Field Priority**  |
    | ------------------- |
    | namespace、pod_name |
    | namespace、pod      |
    | pod_name            |
    | pod                 |

    - Deployment:

    | **Match Field Priority**  |
    | ------------------- |
    | namespace、deployment_name |
    | namespace、deployment      |
    | deployment_name            |
    | deployment                 |

    - Service:

    | **Match Field Priority**  |
    | ------------------- |
    | namespace、service_name |
    | namespace、service      |


    **Note:**

    - If correlation fields for Host, Pod, Deployment, and Service are found simultaneously, network data will be displayed in this order upon entering the details page;
    - If no correlation fields are found, it will be displayed at the bottom in gray, and clicking will prompt **No network view matched**.

</div>

## Further Reading

<font size=2>

<div class="grid cards" markdown>

- [<font color="coral"> :fontawesome-solid-arrow-right-long: &nbsp; **Start Collecting Trace Data**</font>](./index.md)

</div>

<div class="grid cards" markdown>

- [<font color="coral"> :fontawesome-solid-arrow-right-long: &nbsp; **Power of the Explorer**</font>](../../getting-started/function-details/explorer-search.md)

</div>

<div class="grid cards" markdown>

- [<font color="coral"> :fontawesome-solid-arrow-right-long: &nbsp; **Bind Built-in Views**</font>](../../scene/built-in-view/bind-view.md#bind)

</div>

</font>