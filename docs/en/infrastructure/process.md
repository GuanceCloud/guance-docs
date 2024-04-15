# Process
---

Process data collection will be reported to the Guance console after being successfully reported. In the **Infrastructure > Process**, you can view all process data information in the current workspace **for the last 10 minutes**.

## Query and Analysis

Enter the Process explorer, and Guance supports you to query process data by searching keywords, adding label filters and sorting.

- Time Widget: The process list supports viewing the process data collected **in the last ten minutes**, and it can be refreshed to the current time range by the "Play" button to retrieve the data list again. Click the time range to view the process playback:

    - After dragging, the refresh is paused and the time is displayed as "start time-end time"; The query time range is 5 minutes;
    
    - After dragging, the query is historical process data;
    
    - After dragging, click the "Play" button or refresh the page to return to viewing the progress "in the last 10 minutes".

![](img/8.process.png)

- [Search and Filter](../getting-started/function-details/explorer-search.md): You can use various search methods such as keyword search and wildcard search. You can also filter values by `tags/attributes`, including forward and reverse filtering, fuzzy and reverse fuzzy matching, existence and non-existence.

- [Quick Filter](../getting-started/function-details/explorer-search.md#quick-filter): Edit in the quick filter to add new filtering fields and then you can select them for quick filtering.

- [Columns](../getting-started/function-details/explorer-search.md#columns): On the host object list page, you can customize the display columns by adding, editing, deleting and dragging the display columns.

- Sorting: Hover to the list menu and click :fontawesome-solid-sort: sort to sort based on the selected label.

- [Analysis Mode](../getting-started/function-details/explorer-search.md#analysis): You can perform multidimensional analysis and statistics based on <u>1-3 tags</u> to reflect the distribution characteristics of data in different dimensions. It supports various data chart analysis methods, including toplist, pie charts and treemaps.

![](img/4.jichusheshi_3.png)

- Data Export: The :material-cog: icon in the upper right corner of the explorer supports exporting the current object list data to CSV files or dashboards and notes.

    - Export to CSV File: Save current list as CSV file locally.

    - Export to Dashboard: Save the current list as Visual Chart to the specified Dashboard.
    
    - Export to Notes: Save the current list as Visual Chart to specify Notes.


If you need to export a certain data, open the details page of that data, and click on the :material-tray-arrow-up: icon in the top right corner.

![](img/process-0809.png)

## Process Details page

Click on the process name in the process list, and you can draw out the details page to view the detailed information of the process object, including the object to which the process belongs, labels, attributes and associated metrics, logs, hosts and networks.

![](img/8.process_3.png)



### Association Analysis

Guance supports correlation analysis for each process. On the process details page, in addition to the basic information of the process, you can also have a one-stop understanding of <u>the corresponding process metrics, logs, hosts, networks, etc., to monitor the process operation more quickly and comprehensively</u>.

#### Host Query

By clicking the Host tab on the Process Details page, you can query data about the hosts associated with the process.

![](img/9.process_6.png)


| Operate | Description |
| --- | --- |
| Filter field value | Add the field to the explorer to view all the data related to the field. |
| Reverse filter field value | Add this field to the explorer to view other data besides this field. |
| Add to display column | Add the field to the explorer list for viewing. |
| Copy | Copy the field to the clipboard.  |
| View related logs/containers/processes/links/inspection | view all logs/containers/processes/links/inspection related to this host. |


#### Association Metrics/Logs/Hosts

At the bottom of the details page, you can switch content tabs:

![](img/9.process_5.png)

<div class="grid" markdown>

=== "Metrics"

    You can monitor the performance status of processes in the last 24 hours, including CPU usage, memory usage, and number of open files.

    **Note**: Process metric data is not collected automatically by default. You need to manually configure the process collector to enable the collection of process metrics. Once process metric collection is enabled, the metrics shown in the following figure will display data.

    > See [Process](../datakit/host_processes.md) for instructions on how to enable process metric collection. 

=== "Logs"

    You can view the logs and log count related to the process in the last 1 hour, and perform keyword searches, multi-tag filtering and time sorting on these logs.

    - To view more detailed log information: You can click on the log content to jump to the corresponding log details page, or click on **Logs** to view all logs related to the host;

    - To view more log fields or complete log content: You can customize the "Maximum Displayed Rows" and "Displayed Columns" through the associated log explorer **Columns**.

    **Note**: For a smoother user query experience, Guance automatically saves the user's browsing settings in **Logs** (including "Maximum Displayed Rows" and "Displayed Columns"), to keep the **Associated Logs** consistent with **Logs**. However, any custom adjustments made in **Associated Logs** are not saved after exiting the page.

=== "Host"

    You can view the basic information of the associated hosts (with the `host` field) and the performance metric status within the selected time range in the time component.

    ???+ warning "`host`"

        To view the associated hosts in the process details, the `host` field must be matched. Otherwise, the pages of the associated hosts cannot be viewed in the process details.

        - Attribute view: Includes basic information and integration status of the host. If the collection of cloud hosts is enabled, you can also view information from the cloud provider;

        - Metric view: You can view the performance metric view of the associated hosts, such as CPU and memory, in the default 24-hour period. Click **Open this view** to go to the [Built-in Views](../scene/built-in-view/bind-view.md), where you can customize and save the host view as a user view, which can be viewed by binding it in the process details page.

</div>

![](img/8.process_1.png)

#### Bind Inner Views

Guance supports custom binding of inner dashboards to explorers. With the binding function of inner views, you can customize the related contents of process objects and create binding relationships. 

**Note:** Before [binding a inner view](../scene/built-in-view/bind-view.md), you need to confirm that the view variable in the bound inner view has fields related to the process, such as `process_id`.

<!--

### Process Network

Network support is available for viewing network traffic between hosts, Pods, Deployments, and Services. After successful collection of network data, the process network data will be reported to the Guance console. In the **Infrastructure > Processes > Network**, you can view network data based on host or process services.
 

#### Parameter Description

| Parameter | Description | Statistical Method |
| --- | --- | --- |
| IP/Port | The target is aggregated based on IP+ port and returns up to 100 pieces of data. | Collected by IP/Port Packet |
| Number of bytes sent | Number of bytes sent to destination by source host/process service | Sum the number of bytes sent by all records |
| Number of bytes accepted | Number of bytes of destination received by source host/process service | Sum of bytes received by all records |
| TCP Delay | TCP latency of source host/process service to destination | Average value |
| TCP Fluctuation | TCP latency fluctuation of source host/process service to target | Average value |
| TCP Number of connections | Number of TCP connections from source host/process service to destination | Average value |
| TCP Number of retransmissions | Number of TCP retransmissions from source host/process service to destination | Average value |
| TCP Number of closures | Number of TCP shutdowns from source host/process service to destination | Average value |


#### Network Connection Analysis

Guance supports viewing network connection data on the process details page, including source IP/port, target IP/port, number of bytes sent, number of bytes received, TCP delay and TCP retransmission times. At the same time, you can customize the display fields through the Settings button, or add filters for connection data to filter keyword fields of all string types. If you need to view more detailed network connection data, click on the data to view its corresponding network flow data.

**Process Network Connection Analysis**
On the Network of the Process Details page, select the view as "Pid" to see the network connectivity between the process services.

![](img/9.network_5.png)

**Host Network Connection Analysis**
On the Process Details page, select "Host" as the view to see the network connectivity between hosts.

![](img/9.network_1.png)

#### 48-hour Network Data Playback

In the process network, it supports clicking the time control to select and view the 48-hour network data playback.

- Time range: view the data of 30 minutes before and after the log by default, and view the data of the latest hour by default if the current log occurs;
- Support any drag time range to view the corresponding network traffic;
- After dragging, the query is historical network data;
- After dragging, click the "Play" button or refresh the page to return to view the network data of "Recent 1 Hour".

![](img/4.process_1.png)

#### Network Flow Data

Guance supports viewing network flow data on the process details page, which is automatically refreshed every 30s. The data of the last 2 days is displayed by default, including time, source IP/port, target IP/port, source host, transmission direction and protocol. At the same time, you can customize the display fields through the Settings button, or add filters for network stream data to filter keyword fields of all string types. If you need to view the associated network flow data, click the data to view other network flow data corresponding to relevant fields such as host, transmission direction and protocol.

![](img/9.network_2.png)

-->