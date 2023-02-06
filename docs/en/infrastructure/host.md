# Host
---

## Introduction

The host will actively report to the Guance console after collecting data successfully. In the "Host" of the "Infrastructure", you can view all the collected host data information.

The host data of Guance has two viewing and analysis modes. By switching the explorer in the upper left corner of the page, you can view the following pages:

- **Host Object List**, you can view the data information of each host **in the last 24 hours** of the current space, including host name and label, CPU utilization rate of the host, MEM utilization rate and single core load of CPU;
- **Host Topological Graph**, you can quickly view the size of host index values in the way of topology diagram, and analyze the running status of hosts in different systems, different states, different versions and different regions.



## Host Object List

Through the host object list, you can view the data information of each host **in the last 24 hours** in the current space, including host status, host name, CPU utilization rate of the host, MEM utilization rate and single core load of CPU. The list supports setting labels for hosts and filters lists of hosts showing the same labels by adding labels.

![](img/image.png)

### Host Status

In order to facilitate you to quickly identify the host status, the host data is divided into: online and offline.

- In the online state, the data status is displayed as "green" and the host is running.
- In the offline state, the data status is displayed as "gray" and the host is offline.

Note:

- When the host is offline, cpu usage, mem usage and load are not displayed, and the values are filled with " - ".
- Host records will be removed from the list if no data has been reported for more than 24 hours.
### Host Tag

Facing the management environment of multiple hosts, Guance supports customizing labels for each host to facilitate users to group management. By clicking on the host name in the host object list, you can add the Label "Label Attribute" to the host in the underlined details page.

The operation steps are as follows:

1）Click "Edit Label"

2）Enter the Label, press return key and confirm to continue adding.

3）After adding, click Save.

Note: The label configuration will not take effect immediately after it is completed, please wait 1-5 minutes before it takes effect.



![](img/7.host_label_1.png)



### Host Details

In the Host Object list, click the Host Name to slip out of the Host Details page. You can view the corresponding host by adding a host label (Labe attribute) to the host on the Host Details page.

#### Integration Performance

"Integrated Performance" shows the DataKit version information installed on the host and the related collector performance. The performance has two states:

- The collector in normal operation state is displayed as 'light blue' by default.
- The collector with error is displayed as 'Red' by default and supports clicking to view error information.

At the same time, the collector with "View Symbol" (as shown below) supports "Check Monitoring View", and you can view related inner dashboards through clicking the key.

![](img/2.host_6.png)

#### System Information

On the Host details page, you can view the system information of the host, including host name, operating system, processor, memory, network, disk, connection tracking and files.
![](img/2.host_7.png)

#### Cloud Supplier Information

If the host is a cloud host and configured with [「cloud synchronization」](../datakit/hostobject.md), click the host name in the list to underline the "cloud supplier information" of the cloud host, including cloud platform, instance name, instance ID, instance specification, region, available area, creation time, network type, payment type and IP address.

![](img/2.host_8.png)



#### Association Analysis

Guance supports association analysis of each infrastructure object. On the details page of the host object, you can not only understand the basic information of the host, but also associate the metrics, logs, processes, events, containers, networks and sheck of the corresponding host in one stop, so as to monitor the operation of the host faster and more comprehensively.

=== "Metrics"

    On the Host Details page, Guance enables you to monitor the performance status of the host **in the last 24 hours** in real time through the "Metrics" at the bottom of the details page, including CPU load and memory usage.

=== "Log"

    Through "Log" at the bottom of the details page, you can view the logs and the number of logs related to this host **in the last 1 hour**, and perform keyword search, multi-label filtering and time sorting on these related logs.
    - If you need to view more detailed log information, you can click the log content to jump to the corresponding log details page, or click "Jump" to "Log" to view all logs related to the host.
    - If you need to view more log fields or more complete log contents, you can customize and adjust "Maximum Display Rows" and "Display Columns" through "Display Columns" in the associated log onserver.
    **Note: For a smoother user query experience, Guance immediately saves the user's browsing settings in the "Log" by default (including "Maximum Display Rows" and "Display Columns"), so that the "Association Log" is consistent with the "Log". However, the custom adjustments made in the Association Log are not saved after exiting the page.**


=== "Process"

    Through "Processes" at the bottom of the details page, you can view the processes and the number of processes associated with this host **in the last ten minutes**, and perform keyword search, multi-label filtering and data sorting on these related processes. To view more detailed process information, you can click the process content to jump to the corresponding process details page, or click "Jump" to "Process" to view all processes related to the host.

=== "Event"

    Through "Processes" at the bottom of the details page, you can view the processes and the number of processes associated with this host **in the last ten minutes**, and perform keyword search, multi-label filtering and data sorting on these related processes. To view more detailed process information, you can click the process content to jump to the corresponding process details page, or click "Jump" to "Process" to view all processes related to the host.

=== "Container"

    Through "Container" at the bottom of the details page, you can view all Container data related to this host **in the last ten minutes**, and perform keyword search, multi-label filtering and data sorting on these related containers. To view more detailed container information, you can click the container to jump to the corresponding container details page, or click "Jump" to "Container" to view all containers related to this host.

=== "Sheck"

    Through "Sheck" at the bottom of the details page, you can view the Sheck data related to this host **in the last day**, and perform keyword search, multi-label filtering and data sorting on this security inspection data. To view more detailed security inspection information, you can click Sheck Data to jump to the corresponding Sheck details page, or click "Jump" to "Sheck" to view all Sheck data related to the host.

=== "Host Network"

    Host network supports viewing network traffic between hosts. It supports to view the network traffic and data connection between the source host and the target based on IP/port, and display it in real time in a visual way, so as to help enterprises know the network running status of the business system in real time, quickly analyze, track and locate problems and faults, and prevent or avoid business problems caused by network performance degradation or interruption.
    
    The host will report to the Guance console after successfully collected data, and you can view the network performance monitoring data information of the host through "Network" in the "Infrastructure"-"Host" Details page. For more details, please refer to [network](network.md).

![](img/9.host_4.png)



#### Host Silence

On the Host details page, you can select the alarm silence time of the host through "Host Silence", that is, you will no longer receive alarm notifications related to the host during this time, and the generated alarm events will be stored in event management. A list of all silent hosts can be viewed in Anomaly Detection Library-Host Silence Management. Refer to the documentation [alarm settings](../monitoring/alert-setting.md).

![](img/3.host_15.png)

#### Bind Inner Dashboards

Guance supports "Management"-"Inner Dashboards" in the Guance workspace, setting bindings or deleting inner dashboards (system view and user view) to the host details page.

After binding the inner dashboards, you can view the bound inner dashboard in Host Object Details. For example, if "CPU Monitoring View" is bound as a inner dashboard, members can view the "CPU Monitoring View" of the current host as a view variable in the details page, and click Jump to the corresponding inner dashboard page through the "Jump" button to edit, copy and export the inner dashboard.

**Note:**Before binding a inner dashboards, it is necessary to confirm whether the view variables in the bound inner dashboards (system view, user view) have fields related to the object classification, such as `host`. For more configuration details, see [binding inner dashboards](../scene/built-in-view/bind-view.md).

![](img/4.view_bang_4.png)

### Data Query and Analysis

On the "Host Object List" page, Guance supports you to query and analyze host data by searching, filtering, sorting and grouping aggregation analysis.

#### Time Control

By default, the host object list displays the host data of the last 24 hours for you. You can refresh to the current time range and retrieve the data list again by using the "Refresh" button.

#### Searching and Filtering

In the explorer search bar, it supports keyword search, wildcard search, association search, JSON search and other search methods. It also supports value filtering through `tag/attribute`, including forward filtering, reverse filtering, fuzzy matching, reverse fuzzy matching, existence and nonexistence and other filtering methods. For more searching and filtering, refer to the doc [search and filter for the explorer](../getting-started/necessary-for-beginners/explorer-search.md).

#### Quick Filtering

In the explorer shortcut filter, support editing "shortcut filter" and adding new filter fields. After adding, you can select their field values for quick filtering. For more shortcut filters, please refer to the document [shortcut filters](../getting-started/necessary-for-beginners/explorer-search.md#quick-filter).

#### Custom Display Columns

On the Host Object List page, you can customize to add, edit, delete and drag display columns through Display Columns. When the mouse is placed on the display column of the explorer, click the "Settings" button to support ascending, descending, moving columns to the left, moving columns to the right, adding columns to the left, adding columns to the right, replacing columns, adding to shortcut filtering, adding to analysis (grouping aggregation analysis) and removing columns and other operations. See the doc [Display Column Description](../getting-started/necessary-for-beginners/explorer-search.md#columns) for more custom display columns.

#### Analysis Mode

In the analysis column of infrastructure host explorer, multi-dimensional analysis and statistics based on **1-3 tags** are supported to reflect the distribution characteristics of data in different dimensions, and various data chart analysis methods are supported, including ranking list, pie chart and rectangular tree chart. For more details, please refer to the doc [analysis mode for the explorer](../getting-started/necessary-for-beginners/explorer-search.md#analysis).

![](img/4.jichusheshi_1.png)

#### Data Export

The " :material-cog: settings" icon in the upper right corner of the explorer (next to "display column") supports exporting the current object list data to CSV files or scene dashboards and notes.

- Export to CSV File: Save current list as CSV file locally.

- Export to Dashboard: Save the current list as "Visual Chart" to the specified "Dashboard".
- Export to Notes: Save the current list as "Visual Chart" to specify "Notes".

![](img/21.host_1.png)



## Host Topology Graph

Through the "Host Topology Graph", you can visually query the metric data size of the host, and then quickly analyze the running status of the host under custom labels such as different systems, different states, different versions and different regions.

- Searching and filtering: In the explorer search bar, it supports keyword search, wildcard search, association search, JSON search and other search methods, and supports value filtering through `tags/attributes` , including forward filtering, reverse filtering, fuzzy matching, reverse fuzzy matching, existence and nonexistence and other filtering methods. For more searches and filters, refer to the doc [searching and filtering for the explorer](../getting-started/necessary-for-beginners/explorer-search.md).
- Analysis: You can re-aggregate host objects by adding one or more grouping tags.
- Fill: You can customize the fill metircs through "Fill", and the size of the fill metirc value will determine the legend color of the fill. Support the selection of CPU utilization rate, MEM utilization rate and CPU single core load.
- Custom Interval: You can open "Custom Interval" to customize the legend color range for the selected fill metrics. Legend colors will be divided into five intervals according to the maximum and minimum values of the legend, and each interval will automatically correspond to five different colors.
- Mouse Hover: Hover the mouse over the host object to see the name of the host, CPU usage and MEM usage.

![](img/3.host_2.2.png)
