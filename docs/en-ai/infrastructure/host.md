# Host

---

After successful host data collection, it will be reported to the Guance console. Enter **Infrastructure > Host**, and you can view all collected host data information.

Guance offers two viewing and analysis modes for host data. By switching the Explorer in the top-left corner of the page, you can view the following pages:

- **Host Object List**: You can view each host's data information within the last 24 hours in the current workspace, including host name and tags, CPU usage, MEM usage, and CPU load;

- **Host Topology Map**: You can quickly view the size of host metrics in a topology map format and analyze the operational status of hosts under different systems, statuses, versions, and regions.

## Host Object List

Through the host object list, you can view each host's data information within the last 24 hours in the current workspace, including host status, name, CPU usage, MEM usage, and CPU load. It supports setting labels for hosts and filtering hosts with the same label through added tags.

![](img/7.host_detail_1.png)

Host object metric data supports ascending and descending sorting:

<img src="../img/host-queue.png" width="60%" >

**Note**: Due to data entry delays, these metrics are not updated in real-time. Data is aggregated every 5 minutes for the average value over the past 15 minutes, so there might be discrepancies.

### Display Only Online Hosts {#online}

To help you quickly identify host status, Guance has added a "Display Only Online Hosts" filter switch. This allows you to choose between viewing all reported host objects or only online hosts.

- **Display Only Online Hosts** enabled: Only lists hosts that have reported data within the last 10 minutes.

**Note**:

- If a host does not report data for more than 10 minutes, CPU usage, MEM usage, and CPU load will not be displayed, and the values will be filled with “-”;

- If a host does not report data for more than 24 hours, the host record will be removed from the list.

<img src="../img/host-status.png" width="60%" >

### Host Labels {#label}

In a multi-host management environment, Guance supports custom labels for each host. Setting Label properties on hosts can be used for data classification and query filtering. By clicking on the host name in the host object list, you can add labels to the host in the [details page](#details).

Steps:

![](img/7.host_label_1.png)

1) Click **Edit Label**;

2) Input the Label tag, press Enter to confirm and continue adding;

3) After completion, click Save;

**Note**: Label configurations take effect after 1-5 minutes.

4) After adding host Label tags, you can choose between two display formats: "1 line" and "all". In the host list, click **Show Columns** to switch the number of lines for Label display.

![](img/7.host_label_3.png)

### Query and Analysis

- [Time Control](../getting-started/function-details/explorer-search.md#time): The host object list defaults to displaying host data from the last 24 hours; you can refresh to the current time range and re-fetch the data list.

- [Search and Filter](../getting-started/function-details/explorer-search.md): In the Explorer search bar, you can use keyword search, wildcard search, and other methods; you can also filter by `tags/attributes`, including positive and negative filtering.

- DQL supports **now() function** queries: You can get the current query time and compare the latest time with the current time using `+` and `-`.

- [Quick Filters](../getting-started/function-details/explorer-search.md#quick-filter): Edit quick filters and add new filter fields. After adding, you can select field values for quick filtering.

<img src="../img/quickfilter.png" width="60%" >

- [Customize Display Columns](../getting-started/function-details/explorer-search.md#columns): Customize adding, editing, deleting, and dragging display columns via **Show Columns**.

- [Analysis Mode](../getting-started/function-details/explorer-search.md#analysis): Supports multi-dimensional analysis statistics based on <u>1-3 tags</u>, reflecting data distribution characteristics across different dimensions. It supports various data chart analysis methods, including Top Lists, pie charts, and treemaps.

<img src="../img/4.jichusheshi_1.png" width="60%" >

- Settings: Click the :material-cog: settings icon in the upper-right corner of the Explorer. You can perform the following operations:

    - Create a new monitor: If you find any anomalies in the current host data, you can create a monitor with one click;

    - Export to CSV file: Save the current list as a CSV file locally;

    - Export to Dashboard/Notebook: Save the current list as a visual chart to a specified dashboard/notebook.

<img src="../img/21.host_1.png" width="70%" >

## Host Details {#details}

In the host object list, clicking on the host name slides out the host details page. On this page, you can view corresponding host basic information, extended attributes, associated information, and bound views.

![](img/7.host_detail_6.png)

If you need to export a specific host's data, click the :material-tray-arrow-up: icon in the upper-right corner.

![](img/host-0809.png)

### Basic Information

In the basic information section of the host details page, you can add [host labels](#label), view integration runtime conditions (including DataKit version), system information, and cloud vendor information.

#### Integration Runtime Conditions

**Integration Runtime Conditions** displays the installed DataKit version information and related collector runtime conditions. There are two states:

- Collectors in normal running state are displayed in "light blue";

- Collectors with errors are displayed in "red" and support viewing error information.

Collectors with a view symbol :fontawesome-solid-chart-simple: support viewing monitoring views:

![](img/7.host_detail_2.png)

#### System Information

On the host details page, you can view the host's system information, including host name, operating system, processor, memory, network, disk, connection tracking, files, etc.

![](img/7.host_detail_3.png)

#### Cloud Vendor Information

If the host is a cloud host and [cloud synchronization](../integrations/hostobject.md#cloudinfo) is configured, you can view information such as cloud platform, instance name, instance ID, instance specifications, region, availability zone, creation time, network type, billing type, IP address, etc.

![](img/7.host_detail_4.png)

### Extended Attributes

You can view all attributes of the relevant host; support searching and filtering by field name or value to narrow down the viewing scope.

![](img/7.host_detail_5.png)

Hover over the value of the corresponding field to display its original format.

<img src="../img/value.png" width="60%" >

### Associated Analysis

Guance supports associated analysis for each infrastructure object. Besides the host's basic information, you can comprehensively understand the host's metrics, logs, processes, events, containers, network, Security Checks, etc., to monitor the host's operational status faster and more comprehensively.

<img src="../img/9.host_4.png" width="60%" >

<div class="grid" markdown>

=== "Metrics"

    You can monitor the host's performance status within the last 24 hours in real-time, including CPU load, memory usage, etc.

    <img src="../img/host-metric.png" width="60%" >

=== "Logs"

    You can view logs and log counts related to the host within the last hour.
     
    **Note**: For a smoother user experience, Guance saves your browsing settings (including "maximum display rows," "display columns") by default, ensuring consistency between **associated logs** and logs. However, custom adjustments made in associated logs are not saved when you exit the page.

    <img src="../img/host-log.png" width="60%" >

    > For more page operations, refer to [Log Explorer](../logs/explorer.md).

=== "Processes"

    You can view processes and process counts related to the host within the last 10 minutes.
    
    <img src="../img/host-process.png" width="60%" >

=== "Events"

    You can view alert events related to the host within the last hour (associated field: `host`).
    
    <img src="../img/host-event.png" width="60%" >

=== "Containers"

    You can view all container data related to the host within the last 10 minutes.
    
    <img src="../img/host-container.png" width="60%" >

=== "Security Check"

    You can view Security Check data related to the host within the last day.

    <img src="../img/host-intecheck.png" width="60%" >

=== "Network"

    Host network supports viewing network traffic between hosts. It supports viewing source-to-target network traffic and data connections based on server and client endpoints, providing real-time visualization to help businesses understand their business system's network operation status, quickly analyze, track, and locate issues, and prevent or avoid business problems caused by network performance degradation or interruptions.
    
    After successful collection of host network data, it will be reported to the Guance console. You can view host network performance monitoring data information in the network section of the **Infrastructure > Host** details page in **Topology** and **Summary** formats.
    
    > For more details, refer to [Network](network.md).

    <img src="../img/host-net.png" width="60%" >

</div>

### Mute Host {#mute}

On the host details page, clicking **Mute Host** sets the host to mute mode. Mute times include **Once** and **Repeat**, which can be selected as needed.

![](img/3.host_15.png)

After configuration, return to the host list. During the set mute period, you will not receive alerts related to the host, but generated alert events will be stored in event management. All muted hosts can be viewed in **Monitoring > Mute Management**.

> For more details, refer to [Alert Settings](../monitoring/alert-setting.md).

**Note**: If you set a host to mute in a specific host's details page and set the same mute rule in **Monitoring > [Mute Management](../monitoring/silent-management.md)**, the host will show a mute icon in the **Infrastructure > Host** list.

![](img/mute.png)

### Bind Built-in Views {#view}

Guance supports binding built-in views (user views) to the host details page. Click to bind built-in views and view the default associated fields. You can choose whether to retain these fields and add new `key:value` fields.

![](img/view.png)

In the bind built-in views > views section, you can add multiple views:

<img src="../img/view-2.png" width="60%" >

After completing the binding of built-in views, you can view the bound built-in views in the host object details and jump to the corresponding built-in view page via the jump button :material-arrow-right-top-bold: to edit, copy, and export the built-in view.

![](img/view-3.png)

**Note**: When [binding built-in views](../scene/built-in-view/bind-view.md), if the current data does not contain fields associated with the view, it will not be displayed on the details page of that data. Otherwise, it will be displayed.

<!-- 
![](img/4.view_bang_4.png)
 -->


## Host Topology Map

Using the **Host Topology Map**, you can visually query the size of host metric data, quickly analyzing the operational status of hosts under different systems, statuses, versions, and regions with custom tags.

- [Search and Filter](../getting-started/function-details/explorer-search.md);

- Analysis: You can re-aggregate host objects by adding one or more grouping tags;

- Fill: You can customize filling metrics via **Fill**. The fill metric value will determine the color of the legend. You can choose CPU usage, MEM usage, and CPU load as fill metrics;

- Custom Range: You can enable **Custom Range** to define custom color ranges for the selected fill metric. Legend colors will be divided into five intervals based on the maximum and minimum values, each automatically corresponding to a different color;

- Mouse Hover: Hover over the host object to view the host name, CPU usage, and MEM usage.

![](img/3.host_2.2.png)