# Process
---

After successfully collecting process data, it will be reported to the Guance console. In **Infrastructure** > **Process**, you can view all process data information within the current workspace for the **last 10 minutes**.

## Query and Analysis

Enter the **Process** Explorer, where Guance supports querying process data through keyword search, adding label filters, sorting, and other methods.

- **Time Control**: The process list supports viewing process data collected within the last ten minutes. By clicking the play button, you can refresh to the current time range and retrieve a new data list. Clicking the time range allows you to view process playback:

    - After dragging, the refresh is paused, and the time displayed is [start time - end time], with a query time range of 5 minutes;

    - After dragging, it queries historical process data;

    - After dragging, click the play button or refresh the page to return to viewing the most recent 10 minutes of processes.

![](img/8.process.png)

- [Search and Filter](../getting-started/function-details/explorer-search.md): In the Explorer search bar, support for keyword search, wildcard search, and various search methods; support filtering values via `labels/attributes`, including positive and negative filtering, among other filtering methods.

- [Quick Filters](../getting-started/function-details/explorer-search.md#quick-filter): Edit quick filters by adding new filter fields. After completion, you can select field values for quick filtering.

- [Custom Display Columns](../getting-started/function-details/explorer-search.md#columns): Customize the addition, editing, deletion, and dragging of display columns via **Display Columns**.

- Sorting: Hover over the list menu and click “:fontawesome-solid-sort: Sort” to sort in ascending or descending order based on selected labels.

- [Analysis Mode](../getting-started/function-details/explorer-search.md#analysis): Supports multi-dimensional analysis statistics based on <u>1-3 labels</u>, reflecting the distribution characteristics of data across different dimensions. It supports multiple data chart analysis methods, including top lists, pie charts, and treemaps.

![](img/4.jichusheshi_3.png)

- Data Export: The :material-cog: settings icon in the upper right corner of the Explorer supports exporting the current object list data to CSV files or dashboard and notes.

    - Export to CSV file: Save the current list as a CSV file locally;

    - Export to Dashboard: Save the current list as a **visual chart** to a specified **dashboard**;

    - Export to Note: Save the current list as a **visual chart** to a specified **note**.

If you need to export a specific data entry, open that data's detail page and click the :material-tray-arrow-up: icon in the upper right corner.

![](img/process-0809.png)

## Process Detail Page

Clicking on the process name in the process list will slide out the detail page to view detailed information about the process object, including the associated objects, Label attributes, other extended attributes, and related metrics, logs, hosts, networks, etc.

![](img/8.process_3.png)


### Associated Analysis

Guance supports associated analysis for each process. On the process detail page, in addition to basic process information, you can comprehensively monitor the process's performance by understanding its associated metrics, logs, hosts, networks, etc., more quickly and comprehensively.

#### Host Query

Clicking the host tag on the process detail page allows you to query relevant data associated with the host connected to the process.

![](img/9.process_6.png)

| Action | Description |
| --- | --- |
| Filter Field Value | Adds this field to the Explorer to view all data related to this field. |
| Reverse Filter Field Value | Adds this field to the Explorer to view all data except for this field. |
| Add to Display Columns | Adds this field to the Explorer list for viewing. |
| Copy | Copies this field to the clipboard. |
| View Related Logs | Views all logs related to this host. |
| View Related Containers | Views all containers related to this host. |
| View Related Processes | Views all processes related to this host. |
| View Related Traces | Views all traces related to this host. |
| View Related Security Checks | Views all security check data related to this host. |

#### Associated Metrics/Logs/Hosts

At the bottom of the detail page, switching content tabs allows you to:

<div class="grid" markdown>

=== "Metrics"

    You can monitor the performance status of the process in real-time for the <u>last 24 hours</u>, including CPU usage, memory usage, number of open files, etc.

    **Note**: Process metric data collection is not automatically enabled by default and needs to be manually configured to start metric collection for processes. Once the collection is enabled, the metrics shown in the figure below will display data.

    > For enabling instructions, refer to [Processes](../integrations/host_processes.md).

=== "Logs"

    You can view logs and log counts related to this process from the <u>last hour</u> and perform keyword searches, multi-label filtering, and time sorting on these logs.

    - To view more detailed log information: Click the log content to jump to the corresponding log detail page or click to navigate to the **Logs** section to view all logs related to this host.
 
    - To view more log fields or complete log content: Use the **Display Columns** of the associated log Explorer to customize and adjust "Maximum Display Lines" and "Display Columns".
    
    **Note**: To enhance user query experience, Guance saves user browsing settings in **Logs** (including "Maximum Display Lines" and "Display Columns") by default, ensuring consistency between **Associated Logs** and **Logs**. However, custom adjustments made in **Associated Logs** are not saved after exiting the page.


=== "Host"

    You can view basic information about the related host (associated field: `host`) and the performance metrics status within the selected time component range.

    ???+ warning "Field `host`"
    
        To view related hosts in process details, the `host` field must match; otherwise, no related host page will be visible in the process details.

        - Attribute View: Includes basic information about the host, integration operation status, and cloud provider information if cloud host collection is enabled;
  
        - Metric View: Displays default 24-hour performance metrics views for related hosts such as CPU, memory, etc. Click **Open this View** to [Built-in Views](../scene/built-in-view/bind-view.md), clone the host view for customization, save it as a user view, and bind it to the process detail page for viewing.

=== "Network"

    Network traffic between hosts, Pods, Deployments, and Services can be viewed. After successful collection of process network data, it is reported to the Guance console. In **Infrastructure > Process** detail page under **Network**, you can view network data based on hosts or process services.

</div>

![](img/8.process_1.png)

#### Binding Built-in Views

Guance supports custom binding of built-in views to Explorers. Clicking Bind Built-in View adds a new view to the current host detail page. You can customize the relevant content of the process object and create binding relationships.

![](img/view-1.png)

**Note**: Before [Binding Built-in Views](../scene/built-in-view/bind-view.md), ensure that the bound built-in view contains fields related to the process, such as `process_id`.

<!--
### Process Network

Network traffic between hosts, Pods, Deployments, and Services can be viewed. After successful collection of process network data, it is reported to the Guance console. In **Infrastructure > Process** detail page under **Network**, you can view network data based on hosts or process services.

???+ warning

    - Currently only supports Linux systems, and apart from CentOS 7.6+ and Ubuntu 16.04, other distributions require a Linux kernel version higher than 4.0.0;
  
    - Host/process service network traffic data is saved for the past 48 hours by default, while the Free Plan saves data for the past 24 hours;
  
    - In the process detail page, clicking into **Network** defaults to fetching data from the last 15 minutes and does not support automatic refresh; manual refresh is required to get new data;
   
    - Currently supports network performance monitoring based on TCP and UDP protocols. Combining incoming and outgoing, there are six selection options:
       
        - incoming + protocol agnostic     
        - incoming + TCP protocol   
        - incoming + UDP protocol 
        - outgoing + protocol agnostic     
        - outgoing + TCP protocol     
        - outgoing + UDP protocol     

#### Parameter Explanation

| Parameter | Description | Statistical Method |
| --- | --- | --- |
| IP/Port | Aggregation based on IP+port, up to 100 entries returned | Grouped by IP/port |
| Sent Bytes | Number of bytes sent from source host/process service to target | Sum of all sent bytes |
| Received Bytes | Number of bytes received by source host/process service from target | Sum of all received bytes |
| TCP Delay | TCP delay from source host/process service to target | Average value |
| TCP Jitter | TCP delay fluctuation from source host/process service to target | Average value |
| TCP Connections | Number of TCP connections from source host/process service to target | Total sum |
| TCP Retransmissions | Number of TCP retransmissions from source host/process service to target | Total sum |
| TCP Closures | Number of TCP closures from source host/process service to target | Total sum |


#### Network Connection Analysis

Guance supports viewing network connection data on the process detail page, including source IP/port, destination IP/port, sent bytes, received bytes, TCP delay, TCP retransmissions, etc.

You can also customize display fields via the **Settings** button or add filtering conditions for connection data, filtering all string-type `keyword` fields. If you need to view more detailed network connection data, click the data to view the corresponding network flow data.

**Process Network Connection Analysis**:

In the network section of the process detail page, selecting the view as "Pid" allows you to see network connections between process services.

![](img/7.host_network_3.png)

**Host Network Connection Analysis**:

In the network section of the process detail page, selecting the view as "Host" allows you to see network connections between hosts.

![](img/7.host_network_4.png)

#### 48-Hour Network Data Playback

In process network, you can click the time control to view 48-hour network data playback.

- Time Range: Defaults to viewing data 30 minutes before and after the log, or the last hour for current logs;

- Supports arbitrary dragging of the time range to view corresponding network traffic;
 
- After dragging, it queries historical network data;

- After dragging, clicking the play button or refreshing the page returns to viewing the last hour of network data.

![](img/4.process_1.png)

#### Network Flow Data

Guance supports viewing network flow data on the process detail page, which automatically refreshes every 30 seconds, displaying data from the last two days, including time, source IP/port, destination IP/port, source host, transmission direction, protocol, etc.

You can also customize display fields via the **Settings** button or add filtering conditions for network flow data, filtering all string-type `keyword` fields. If you need to view related network flow data, click the data to view the corresponding host, transmission direction, protocol, etc.

![](img/9.network_2.png)

-->