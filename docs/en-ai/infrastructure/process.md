# Process
---

After process data collection is successful, it will be reported to the <<< custom_key.brand_name >>> console. In **Infrastructure** under **Process**, you can view all process data information within the current workspace for the **last 10 minutes**.

## Query and Analysis

Enter the **Process** Explorer, <<< custom_key.brand_name >>> supports querying process data through keyword search, adding label filters, sorting, and other methods.

- Time Widget: The process list supports viewing processes collected within the <u>last ten minutes</u>. By clicking the play button, you can refresh to the current time range and retrieve a new data list. Clicking the time range allows you to view process playback:

    - After dragging, the refresh pauses, and the time displayed is [start time-end time], with a query time range of 5 minutes;

    - After dragging, historical process data is queried;

    - After dragging, click the play button or refresh the page to return to viewing the most recent 10 minutes of processes.

![](img/8.process.png)

- [Search and Filtering](../getting-started/function-details/explorer-search.md): In the Explorer search bar, various search methods are supported, including keyword search, wildcard search, etc.; filtering by `labels/attributes` values, including positive and negative filtering, among others.

- [Quick Filter](../getting-started/function-details/explorer-search.md#quick-filter): Edit quick filters to add new filter fields. After completion, you can select field values for quick filtering.

- [Custom Display Columns](../getting-started/function-details/explorer-search.md#columns): Customize the addition, editing, deletion, and dragging of display columns via **Display Columns**.

- Sorting: Hover over the list menu and click “ :fontawesome-solid-sort: Sort” to sort based on selected tags in ascending or descending order.

- [Analysis Mode](../getting-started/function-details/explorer-search.md#analysis): Supports multi-dimensional analysis and statistics using <u>1-3 labels</u>, reflecting data distribution characteristics across different dimensions. Multiple data chart analysis methods are supported, including Top Lists, pie charts, and treemaps.

![](img/4.jichusheshi_3.png)

- Data Export: The :material-cog: settings icon in the top-right corner of the Explorer supports exporting the current object list data to CSV files or scene dashboards and notes.

    - Export to CSV file: Save the current list as a CSV file locally;

    - Export to Dashboard: Save the current list as a **visual chart** to a specified **dashboard**;

    - Export to Note: Save the current list as a **visual chart** to a specified **note**.

If you need to export a specific data entry, open the details page of that entry and click the :material-tray-arrow-up: icon in the top-right corner.

![](img/process-0809.png)

## Process Details Page

Clicking on a process name in the process list will slide out a detail page showing detailed information about the process object, including associated objects, Label attributes, additional extended attributes, and related metrics, logs, hosts, networks, etc.

![](img/8.process_3.png)

### Associated Analysis

<<< custom_key.brand_name >>> supports associated analysis for each process. On the process detail page, besides basic process information, you can comprehensively monitor the <u>metrics, logs, host, network, etc., related to the process</u>.

#### Host Query

By clicking the host tag on the process detail page, you can query data related to the host associated with the process.

![](img/9.process_6.png)

| Action | Description |
| --- | --- |
| Filter Field Value | Add this field to the Explorer to view all data related to this field. |
| Reverse Filter Field Value | Add this field to the Explorer to view data excluding this field. |
| Add to Display Columns | Add this field to the Explorer list for viewing. |
| Copy | Copy this field to the clipboard. |
| View Related Logs | View all logs related to this host. |
| View Related Containers | View all containers related to this host. |
| View Related Processes | View all processes related to this host. |
| View Related Traces | View all traces related to this host. |
| View Related Inspections | View all inspection data related to this host. |

#### Associated Metrics/Logs/Host

In the detail page, switch content tabs to:

<div class="grid" markdown>

=== "Metrics"

    You can monitor the performance status of the process <u>within the last 24 hours</u>, including CPU usage, memory usage, number of open files, etc.

    **Note**: Process metric data collection is not automatically enabled by default and requires manual configuration of the process collector to enable metric collection. Once enabled, the metrics in the image will display data.

    > For enabling methods, refer to [Processes](../integrations/host_processes.md).

=== "Logs"

    You can view logs and log counts related to the process <u>within the last hour</u> and perform keyword searches, multi-label filtering, and time sorting on these logs.

    - To view more detailed log information: Click the log content to jump to the corresponding log detail page, or click to jump to the **Logs** to view all logs related to the host;
 
    - To view more log fields or complete log content: Adjust the "maximum number of rows displayed" and "display columns" via the associated log Explorer's **Display Columns**.
    
    **Note**: For a smoother user experience, <<< custom_key.brand_name >>> saves user browsing settings (including "maximum number of rows displayed" and "display columns") in **Logs** by default to ensure consistency between **Associated Logs** and **Logs**. However, custom adjustments made in **Associated Logs** are not saved after exiting the page.


=== "Host"

    You can view basic information about related hosts (associated field: `host`) and their performance metric status <u>within the selected time widget range</u>.

    ???+ warning "Field `host`"
    
        To view related hosts in process details, the `host` field must match; otherwise, the related host page will not be visible in process details.

        - Attribute View: Includes basic host information, integration runtime status, and cloud provider information if cloud host collection is enabled;
  
        - Metric View: Displays default 24-hour performance metrics for related hosts, such as CPU and memory. Click **Open This View** to [Built-in Views](../scene/built-in-view/bind-view.md), where you can clone and customize host views, saving them as user views accessible from the process detail page.

=== "Network"

    Network traffic between hosts, Pods, Deployments, and Services can be viewed. After successful network data collection for processes, it will be reported to the <<< custom_key.brand_name >>> console. In **Infrastructure > Process** detail page under **Network**, you can view network data based on hosts or process services.

</div>

![](img/8.process_1.png)

#### Bind Built-in Views

<<< custom_key.brand_name >>> supports binding built-in views to Explorers. Click to bind a built-in view to add a new view to the current host detail page. You can customize the relevant content of the process object and create a binding relationship.

![](img/view-1.png)

**Note**: Before [binding built-in views](../scene/built-in-view/bind-view.md), confirm that the bound built-in view contains fields related to the process, such as `process_id`.

<!--
### Process Network

Network traffic between hosts, Pods, Deployments, and Services can be viewed. After successful network data collection for processes, it will be reported to the <<< custom_key.brand_name >>> console. In **Infrastructure > Process** detail page under **Network**, you can view network data based on hosts or process services.

???+ warning

    - Currently only supports Linux systems, and except for CentOS 7.6+ and Ubuntu 16.04, other distributions require a Linux kernel version higher than 4.0.0;
  
    - Network traffic data for hosts/process services is saved for the last 48 hours by default, while the Free Plan saves data for the last 24 hours by default;
  
    - In the process detail page, clicking into **Network** defaults to retrieving the last 15 minutes of data and does not support automatic refresh, requiring manual refresh for new data;
   
    - Currently supports TCP and UDP protocol network performance monitoring. Combined with incoming and outgoing, there are six selection options:  
       
        - Incoming + no protocol distinction     
        - Incoming + TCP protocol   
        - Incoming + UDP protocol 
        - Outgoing + no protocol distinction     
        - Outgoing + TCP protocol     
        - Outgoing + UDP protocol     

#### Parameter Explanation

| Parameter | Description | Statistical Method |
| --- | --- | --- |
| IP/Port | Aggregation based on IP+port, returns up to 100 records | Grouped by IP/port |
| Sent Bytes | Number of bytes sent from source host/process service to target | Sum of all sent byte records |
| Received Bytes | Number of bytes received by source host/process service from target | Sum of all received byte records |
| TCP Delay | TCP delay from source host/process service to target | Average value |
| TCP Jitter | TCP delay fluctuation from source host/process service to target | Average value |
| TCP Connections | Number of TCP connections from source host/process service to target | Total sum |
| TCP Retransmissions | Number of TCP retransmissions from source host/process service to target | Total sum |
| TCP Closures | Number of TCP closures from source host/process service to target | Total sum |


#### Network Connection Analysis

<<< custom_key.brand_name >>> supports viewing network connection data in the process detail page, including source IP/port, destination IP/port, sent bytes, received bytes, TCP delay, TCP retransmissions, etc.

Additionally, you can customize display fields via the **Settings** button or add filter conditions to string-type `keyword` fields for connection data. If you need more detailed network connection data, click the data to view its corresponding network flow data.

**Process Network Connection Analysis**:

In the network section of the process detail page, selecting the view as "Pid" shows network connections between process services.

![](img/7.host_network_3.png)

**Host Network Connection Analysis**:

In the network section of the process detail page, selecting the view as "Host" shows network connections between hosts.

![](img/7.host_network_4.png)

#### 48-Hour Network Data Playback

In process network, you can choose to view 48-hour network data playback by clicking the time widget.

- Time Range: Default view of data 30 minutes before and after the log; for current logs, the default view is the last hour;

- Supports arbitrary drag-and-drop to view corresponding network traffic;
 
- After dragging, queries historical network data;

- After dragging, clicking the play button or refreshing the page returns to viewing the last hour of network data.

![](img/4.process_1.png)

#### Network Flow Data

<<< custom_key.brand_name >>> supports viewing network flow data in the process detail page, which auto-refreshes every 30 seconds and displays data from the last two days, including time, source IP/port, destination IP/port, source host, transmission direction, protocol, etc.

Additionally, you can customize display fields via the **Settings** button or add filter conditions to string-type `keyword` fields for network flow data. If you need to view related network flow data, click the data to view corresponding fields such as host, transmission direction, and protocol.

![](img/9.network_2.png)

-->