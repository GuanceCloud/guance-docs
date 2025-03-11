# Host
---

After the successful collection of host data, it will be automatically reported to the Guance Console. To access the information of all collected host data, go to **Infrastructure > Hosts**.

Guance offers two modes for viewing and analyzing host data. By switching the explorer in the top-left corner of the page, you can access the following pages:

- **Host List**: you can view the data information of each host **in the last 24 hours** of the current space, including host name and label, CPU utilization rate of the host, MEM utilization rate and CPU load;
- **Host Map**: you can quickly view the size of host metric values in the way of map, and analyze the running status of hosts in different systems, different states, different versions and different regions.



## Host List

Through the host list, you can view the data information of each host **in the last 24 hours** in the current space, including host status, host name, CPU utilization rate of the host, MEM utilization rate and CPU load. The list supports setting labels for hosts and filters lists of hosts showing the same labels by adding labels.

![](img/image.png)

Host metric data supports ascending and descending sorting:

<img src="../img/host-queue.png" width="60%" >

**Note**: Due to data storage delay, this metric is not updated in real-time. It is calculated every 5 minutes based on the average value of the last 15 minutes. Therefore, there may be some deviation in the data.

### Host Status

To facilitate quick identification of host status, host data is divided into two categories: online and offline.

- Under the online status, the data state is displayed as "green", indicating that the host is in a running state.

- Under the offline status, the data state is displayed as "gray", indicating that the host is in an offline state.

**Note**:

- When the host is offline, CPU usage, mem usage and CPU load are not displayed, and the values are filled with "-".
- Host records will be removed from the list if no data has been reported for more than 24 hours.

<img src="../img/host-status.png" width="60%" >

### Host Labels {#label}

Facing the management environment of multiple hosts, Guance supports customizing labels for each host. By setting the labels on the host, it can be used for data classification, filtering and querying. By clicking on the host name in the host list, you can add labels to the host in the [details page](#details). 

Setup:

![](img/7.host_label_1.png)

1. Click Edit;

2. Enter the Label, press Enter/Return key to confirm and continue adding;

3. After adding, click Save.

**Note**: The label configuration will not take effect immediately after it is completed, please wait 1-5 minutes before it takes effect.

4. After adding the label to the host, there are two display options: "1 line" and "all". In the host list, click on Columns to switch the number of lines for label display.

![](img/7.host_label_3.png)

### Query and Analysis


- Time Widget: The host list defaults to displaying the host data for the last 24 hours. You can refresh the data list to the current time range.

- [Search and Filter](../getting-started/function-details/explorer-search.md): You can use various search methods such as keyword search and wildcard search. You can also filter values by `tags/attributes`, including forward and reverse filtering, fuzzy and reverse fuzzy matching, existence and non-existence.

- [Quick Filter](../getting-started/function-details/explorer-search.md#quick-filter): Edit in the quick filter to add new filtering fields and then you can select them for quick filtering.

<img src="../img/quickfilter.png" width="60%" >

- [Columns](../getting-started/function-details/explorer-search.md#columns): On the host object list page, you can customize the display columns by adding, editing, deleting and dragging the display columns.

- [Analysis Mode](../getting-started/function-details/explorer-search.md#analysis): You can perform multidimensional analysis and statistics based on <u>1-3 tags</u> to reflect the distribution characteristics of data in different dimensions. It supports various data chart analysis methods, including toplist, pie charts and treemaps.


<img src="../img/4.jichusheshi_1.png" width="60%" >

- Settings: Click on the :material-cog: settings icon in the explorer's upper right corner to perform the following operations:

    - Create Monitor: If you find abnormal data for the current host, you can create a monitor with one click.
    
    - Export to CSV file: Save the current list as a CSV file locally.
    
    - Export to Dashboard/Note: Save the current list as visual charts to a specified dashboard/note.

<img src="../img/21.host_1.png" width="70%" >

### Host Details

In the host list, click on the hostname to slide out the host details page. You can view the corresponding host's basic information, attributes, associated information and bound views.

![](img/7.host_detail_6.png)

If you need to export a specific host's data, click on the icon in the top right corner :material-tray-arrow-up:.

![](img/host-0809.png)

#### Information

Here you can add [host labels](#label), view integration status (including DataKit version), system information and cloud provider information.

#### Integrations

**Integrations** displays the version information of the installed DataKit and the status of the associated collectors. There are two states of the collectors' status:

- Collectors in normal running state are displayed in "light blue" by default.
- Collectors with errors are displayed in "red" and can be clicked to view the error message.

Collectors with the view symbol :fontawesome-solid-chart-simple: support viewing monitoring views:

![](img/7.host_detail_2.png)

#### System Information

You can view the system information of the host, including host name, operating system, processor, memory, network, disk, connection tracking and files.

![](img/7.host_detail_3.png)

#### Cloud Provider

If the host is a cloud host and has configured [cloud synchronization](../integrations/hostobject.md#cloudinfo), you can view information including cloud platform, instance name, instance ID, instance specification, region, availability zone, creation time, network type, payment type, IP address, etc.

![](img/7.host_detail_4.png)

### Attributes

You can view all the attributes of the host and filter the view by attribute key or value to narrow down the scope of the view.

![](img/7.host_detail_5.png)

Hover over the value of the corresponding field to display its original format.

<img src="../img/value.png" width="60%" >



#### Association Analysis

Guance supports association analysis of each infrastructure. On the details page of the host, you can not only understand the basic information of the host, but also associate the metrics, logs, processes, events, containers, networks and security check of the corresponding host in one stop, so as to monitor the operation of the host faster and more comprehensively.

<img src="../img/9.host_4.png" width="60%" >

<div class="grid" markdown>

=== "Metrics"

    You can monitor the performance status of the host in real-time within the last 24 hours through the metrics, including CPU load, memory usage, etc.

    <img src="../img/host-metric.png" width="60%" >

=== "Logs"

    You can view the logs related to the host within the last 1 hour and the number of logs.
     
    **Note**: For a smoother user query experience, Guance automatically saves the user's browsing settings in the logs (including "maximum display lines" and "display columns") to keep the logs here consistent with [Logs](../logs/explorer.md). However, custom adjustments made in the associated logs are not saved after exiting the page.

    <img src="../img/host-log.png" width="60%" >

    > See [Log Explorer](../logs/explorer.md).


=== "Processes"

    You can view the processes related to the host within the last 10 minutes and the number of processes.
    
    <img src="../img/host-process.png" width="60%" >

=== "Events"

    You can view the alert events (with the associated field: `host`) related to the host within the last 1 hour.
    
    <img src="../img/host-event.png" width="60%" >

=== "Containers"

    You can view all container data related to the host within the last 10 minutes.
    
    <img src="../img/host-container.png" width="60%" >

=== "Security Check"

    You can view the security check data related to the host within the last 1 day.

    <img src="../img/host-intecheck.png" width="60%" >

=== "Network"

    Network supports viewing the network traffic between hosts. It supports viewing the network traffic and data connection status between source and target hosts based on the server and client, and provides real-time visualization to help enterprises understand the network operation status of their business systems, analyze, track, and locate problems and faults, and prevent or avoid business issues caused by network performance degradation or interruption.
    
    After the successful collection of host network data, it will be reported to the Observation Cloud console. You can view the network performance monitoring data of the host in two forms, **Topology Map** and **Overview**, through **Infrastructure > Host** in the details page.
    
    > See [Network](network.md).

    <img src="../img/host-net.png" width="60%" >

</div>




#### Mute Host {#mute}

On the host details page, click on Mute Host to set the host to MUTE mode. Mute mode can be set to "Only Once" or "Repeat", depending on your preference.

<img src="../img/3.host_15.png" width="70%" >

After configuring the settings, go back to the host list. During the mute period you have set, you will not receive any alert notifications related to that host. The generated alert events will be stored in the **Events**. The list of all mute hosts can be viewed in **Monitoring > Alearting Strategy**.

> See [Alearting Strategy](../monitoring/alert-setting.md).

**Note**: If you set a host to mute mode on the details page of a specific host, and also set the same mute rule for that host in **Monitoring > [Mute Management](../monitoring/silent-management.md)**, the mute icon will appear in the **Infrastructure > Hosts** list.

![](img/mute.png)


#### Bind Inner View {#view}

Guance supports binding inner views (user views) to the host details page. Click on Bind View to view the associated fields that are included by default. You can choose whether to keep these fields or add new `key:value` fields.

![](img/view.png)

On the **Bind View > Views** window, you can add multiple views:

<img src="../img/view-2.png" width="60%" >

After binding inner views, you can view the bound views in the host details page. By clicking on the button :material-arrow-right-top-bold:, you can navigate to the corresponding page to edit, copy, and export the view.

![](img/view-3.png)

**Note**: When [binding an inner view](../scene/built-in-view/bind-view.md), if the current data being opened does not include the fields associated with the view, the view will not be displayed on the details page of that data, and vice versa.


## Host Map 

Through Host Map, you can visually query the metric data size of the host, and then quickly analyze the running status of the host under custom labels such as different systems, states, versions and regions.

- [Search and Filter](../getting-started/necessary-for-beginners/explorer-search.md);

- Analysis: You can re-aggregate hosts by adding one or more grouping tags.

- Fill: The size of the filled metric values will determine the color of the fill in the legend. You can choose to fill using CPU usage, MEM usage or CPU load metrics;

- Custom Interval: You can customize the legend color range for the selected fill metrics. Legend colors will be divided into five intervals according to the maximum and minimum values of the legend, and each interval will automatically correspond to five different colors.

- Hover: Hover to see the name of the host, CPU usage and MEM usage.

![](img/3.host_2.2.png)
