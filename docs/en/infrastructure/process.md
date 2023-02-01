# Process
---

## Introduction

Process data collection will be reported to the Guance console after being successfully reported. In the "Process" of "Infrastructure", you can view all process data information in the current workspace **for the last 10 minutes**.

## Query and Analysis

Enter the "Process" observer, and Guance supports you to query process data by searching keywords, adding label filters and sorting.

#### Time control

The process list supports viewing the process data collected **in the last ten minutes**, and it can be refreshed to the current time range by the "Play" button to retrieve the data list again. Click the time range to view the process playback:

- After dragging, the refresh is paused and the time is displayed as "start time-end time"; The query time range is 5 minutes;
- After dragging, the query is historical process data;
- After dragging, click the "Play" button or refresh the page to return to viewing the progress "in the last 10 minutes".

![](img/8.process.png)

#### Search and Filter

In the ovserver search bar, it supports keyword search, wildcard search, association search, JSON search and other search methods, and it also supports value filtering through `tag/attribute`, including forward filtering, reverse filtering, fuzzy matching, reverse fuzzy matching, existence and nonexistence and other filtering methods. For more searches and filters, refer to the document [search and filter for the observer](../getting-started/necessary-for-beginners/explorer-search.md).

#### Quick Filter

The observer shortcut filter supports editing "shortcut filter" and adding new filter fields. After adding, you can select their field values for quick filtering. For more shortcut filters, please refer to the document [shortcut filters](../getting-started/necessary-for-beginners/explorer-search.md#quick-filter).

#### Custom Display Columns

On the process list page, Guance displays PID, user, host and other information for you by default. You can customize to add, edit, delete and drag display columns through Display Columns. When the mouse hovers over the observer display column, click the「 :material-cog: settings」button, which supports ascending, descending, moving columns to the left, moving columns to the right, adding columns to the left, adding columns to the right, replacing columns, adding to shortcut filtering, adding to analysis (grouping aggregation analysis), removing columns and other operations. See the documentation [display column description](../getting-started/necessary-for-beginners/explorer-search.md#columns) for more custom display columns.

#### Sorting

Hover the mouse to the list menu and click “ :fontawesome-solid-sort: sort” to sort based on the selected label.

#### Analysis Mode

In the analysis bar of infrastructure process observer, multi-dimensional analysis and statistics based on **1-3 tags** are supported to reflect the distribution characteristics of data in different dimensions, and various data chart analysis methods are supported, including ranking list, pie chart and rectangular tree chart. For more details, please refer to the document [analysis Mode for the observer](../getting-started/necessary-for-beginners/explorer-search.md#analysis).

![](img/4.jichusheshi_3.png)

#### Data Export

The " :material-cog: settings" icon in the upper right corner of the observer (next to "display column") supports exporting the current object list data to CSV files or scene dashboards and notes.

- Export to CSV File: Save current list as CSV file locally.

- Export to Dashboard: Save the current list as "Visual Chart" to the specified "Dashboard".
- Export to Notes: Save the current list as "Visual Chart" to specify "Notes".

## Process Details page

Click on the process name in the process list, and you can draw out the details page to view the detailed information of the process object, including the object to which the process belongs, Label attribute, other extended attributes, and associated indicators, logs, hosts and networks.

![](img/8.process_3.png)



### Association Analysis

Guance supports correlation analysis of each process. In the process details page, you can not only understand the basic information of the process, but also associate the **metrics, logs, hosts and networks of the corresponding process in one stop, so as to monitor the running of the process faster and more comprehensively**.

#### Association Host Query

By clicking the Host tab on the Process Details page, you can also query data about the hosts associated with the process.

![](img/9.process_6.png)

- "Filter field value", that is, add the field to the observer to view all the data related to the field.
- "Reverse filter field value", that is, add this field to the observer to view other data besides this field.
- "Add to display column", that is, add the field to the observer list for viewing.
- "Copy", that is, copy the field to the clipboard. 
- "View related logs", that is, view all logs related to this host.
- "View dependent containers", that is, view all containers associated with this host.
- "View related processes", that is, view all processes related to this host.
- "View related links", that is, view all links related to this host.
- "View related inspection", that is, view all inspection data related to this host.

#### Association Metrics / Logs / Hosts

At the bottom of the Details page, switch the Content tab to allow you to:

![](img/9.process_5.png)

- View CPU utilization, memory utilization, number of open files of the process through "metrics".
- View all logs related to this process **in the last 1 hour** through log.
- View the basic information of relevant hosts and the metric data of the host **in the last 24 hours** through "Host".



=== "Metrics"

    On the Process Details page, Guance enables you to monitor the performance status of the process **in the last 24 hours** in real time through the "Process" of the Details page, including CPU utilization, memory utilization and number of open files.
    Note: The collection of process metric data does not automatically start by default. It is necessary to manually configure the process collector to start the collection of process metrics. Please refer to the document [process](../datakit/host_processes.md). After the process metric data is collected, the metrics in the following figure will display the data.

=== "Log"

    Through "Log" at the bottom of the details page, you can view the logs and the number of logs related to the process **in the last 1 hour** , and perform keyword search, multi-label filtering and time sorting on these related logs.
    - If you need to view more detailed log information, you can click the log content to jump to the corresponding log details page, or click "Jump" to "Log" to view all logs related to the host.
    - If you need to view more log fields or more complete log contents, you can customize and adjust "Maximum Display Rows" and "Display Columns" through "Display Columns" in the associated log observer.
    **Note: For a smoother user query experience, Guance immediately saves the user's browsing settings in the "Log" by default (including "Maximum Display Rows" and "Display Columns"), so that the "Association Log" is consistent with the "Log". However, the custom adjustments made in the Association Log are not saved after exiting the page.**


=== "Host"

    Guance enables you to view the basic information of related hosts (related field: host) and the status of performance indicators **within the selected time component** through the "host" at the bottom of the details page.
    Note: To view related hosts in process details, you need to match the field "host", otherwise you cannot view the page of related hosts in process details.
    - Attribute view: It includes the basic information of the host and the integrated operation. If the collection of cloud hosts is started, the information of cloud suppliers can also be viewed.
    - Metric view: You can view the CPU, memory and other performance metric views of related hosts within the default 24 hours. Click "Open this view" to the inner dashbpoard, and the host view can be customized by cloning and saved as a user view. The user view can be viewed on the process details page through binding. For more configuration details, please refer to [binding inner dashboard](../scene/built-in-view/bind-view.md).

![](img/8.process_1.png)

#### Custom Inner Dashboards

Guance supports custom binding of inner dashboards to observers. With the binding function of inner dashboards, you can customize the related contents of process objects and create binding relationships. For more configuration details, see[binding inner dashboards](https://preprod-docs.cloudcare.cn/management/built-in-view/bind-view/).

**Note:** Before binding a built-in view, you need to confirm that the view variable in the bound built-in view has fields related to the process, such as `process_id`.



### Process Network

Process network supports viewing network traffic in two different dimensions: host and process service. It also supports viewing network traffic and data connections between source host/source process services and destinations based on IP/port, Through visual real-time display, it helps enterprises to know the network running status of business systems in real time, quickly analyze, track and locate problems and faults, and prevent or avoid business problems caused by network performance degradation or interruption.

After successful process network data collection, you will report to the Guance console. In "Network" on the "Infrastructure"-"Process" details page, you can view network data based on host or process services.

Note:

- Currently only Linux systems are supported, and other distributions except CentOS 7.6 + and Ubuntu 16.04 require a Linux kernel version higher than 4.0. 0.
- Host/process service network traffic data is saved for the last 48 hours by default, and the free version is saved for the last 24 hours by default;
- Click to enter "Network" on the Process Details page. The time control obtains the data of the last 15 minutes by default and does not support automatic refresh. You need to manually click Refresh to obtain new data;
- At present, it supports network performance monitoring based on TCP and UDP protocols. With incoming and outgoing, it is divided into 6 combination choices:
   - incoming + 不区分协议
   - incoming + tcp protocol
   - incoming + udp protocol
   - outgoing + 不区分协议
   - outgoing + tcp protocol
   - outgoing + udp protocol

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

