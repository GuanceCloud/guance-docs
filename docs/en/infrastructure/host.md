# Hosts
---

After host data collection is successful, it will be reported to the <<< custom_key.brand_name >>> console. Enter **Infrastructure > Hosts**, and you can view all collected host data information.

<<< custom_key.brand_name >>> provides two modes for viewing and analyzing host data. By switching the Explorer in the top-left corner of the page, you can view the following pages:

- **Host Object List**: You can view data information for each host within the last 24 hours in the current workspace, including host name and labels, CPU usage, memory usage, and CPU load;

- **Host Topology Map**: You can quickly view the size of host metrics in a topology map format and analyze the operational status of hosts under different systems, statuses, versions, and regions.

## Host Object List

Through the host object list, you can view data information for each host within the last 24 hours in the current workspace, including host status, host name, CPU usage, memory usage, and CPU load; supports setting tags for hosts and filtering hosts with the same tag through added tags.

![](img/7.host_detail_1.png)

Host object metric data supports ascending and descending sorting:

<img src="../img/host-queue.png" width="60%" >

**Note**: Due to data entry delays, these metrics are not updated in real-time. Data is aggregated every 5 minutes for the average value over the past 15 minutes, so there may be some discrepancies.

### Show Only Online Hosts {#online}

To help you quickly identify host status, <<< custom_key.brand_name >>> has added a "Show Only Online Hosts" switch filter. This allows you to choose between viewing all reported host objects or only online hosts.

- When **Show Only Online Hosts** is enabled, only hosts that have reported data within the last 10 minutes are listed.

**Note**:

- If a host does not report data for more than 10 minutes, its CPU usage, memory usage, and CPU load will not be displayed, and the values will be filled with “-”;

- If a host does not report data for more than 24 hours, its record will be removed from the list.

<img src="../img/host-status.png" width="60%" >

### Host Labels {#label}

In environments managing multiple hosts, <<< custom_key.brand_name >>> supports custom labels for each host. Setting Label attributes on hosts can be used for data classification and filtering queries. By clicking the host name in the host object list, you can add labels to the host in the [details page](#details).

Steps are as follows:

![](img/7.host_label_1.png)

1) Click **Edit Label**;

2) Input the Label tag and press Enter to confirm and continue adding;

3) After completion, click Save;

**Note**: Label configurations take effect after 1-5 minutes.

4) After adding host Label tags, two display modes are supported: "1 line" and "All". In the host list, click **Display Columns** to switch the number of lines displayed for Labels.

![](img/7.host_label_3.png)

### Query and Analysis

- [Time Widget](../getting-started/function-details/explorer-search.md#time): The host object list defaults to displaying host data from the last 24 hours; it can be refreshed to the current time range to re-fetch the data list.

- [Search and Filter](../getting-started/function-details/explorer-search.md): In the search bar of the Explorer, various search methods are supported, including keyword search and wildcard search; you can filter values by `tags/attributes`, including forward and reverse filtering.

- DQL supports the **now() function** for query filtering: It retrieves the current query time and supports comparing the latest time with the current time using `+` and `-`.

- [Quick Filter](../getting-started/function-details/explorer-search.md#quick-filter): Edit quick filters to add new filter fields. After adding, select field values for quick filtering.

<img src="../img/quickfilter.png" width="60%" >

- [Custom Display Columns](../getting-started/function-details/explorer-search.md#columns): Customize columns by adding, editing, deleting, and dragging display columns via **Display Columns**.

- [Analysis Mode](../getting-started/function-details/explorer-search.md#analysis): Supports multi-dimensional analysis based on <u>1-3 tags</u>, reflecting data distribution characteristics across different dimensions. Multiple chart types are supported, including Top Lists, pie charts, and treemaps.

<img src="../img/4.jichusheshi_1.png" width="60%" >

- Settings: Click the :material-cog: settings icon in the upper-right corner of the Explorer to perform the following operations:

    - Create Monitor: If abnormal conditions are detected in the current host data, you can create a monitor with one click;

    - Export to CSV File: Save the current list as a CSV file locally;

    - Export to Dashboard/Notes: Save the current list as a visual chart to a specified dashboard/notes.

<img src="../img/21.host_1.png" width="70%" >

## Host Details {#details}

In the host object list, clicking the hostname slides out the host details page. On this page, you can view basic information, extended attributes, related information, and bound views for the corresponding host.

![](img/7.host_detail_6.png)

If you need to export specific host data, click the :material-tray-arrow-up: icon in the upper-right corner.

![](img/host-0809.png)

### Basic Information

In the host details page's basic information section, you can add [host labels](#label), view integration operation status (including DataKit version), system information, and cloud vendor information.

#### Integration Operation Status

The **Integration Operation Status** displays the installed DataKit version and related collector operational status, which has two states:

- Collectors in normal operation are displayed in "light blue";

- Collectors with errors are displayed in "red" and support clicking to view error information.

Collectors with a :fontawesome-solid-chart-simple: symbol support viewing monitoring views:

![](img/7.host_detail_2.png)

#### System Information

On the host details page, you can view system information for the host, including hostname, operating system, processor, memory, network, disk, connection tracking, files, etc.

![](img/7.host_detail_3.png)

#### Cloud Vendor Information

If the host is a cloud host and configured with [cloud synchronization](../integrations/hostobject.md#cloudinfo), you can view information such as cloud platform, instance name, instance ID, instance specifications, region, availability zone, creation time, network type, billing type, IP address, etc.

![](img/7.host_detail_4.png)

### Extended Attributes

You can view all attributes of the associated host; supports searching and filtering by field name or value to narrow down the viewing scope.

![](img/7.host_detail_5.png)

Hovering over the value of a field shows its original format.

<img src="../img/value.png" width="60%" >

### Associated Analysis

<<< custom_key.brand_name >>> supports associated analysis for each infrastructure object. Besides the host's basic information, you can comprehensively understand related metrics, logs, processes, events, containers, networks, security checks, etc., to monitor the host's operational status faster and more comprehensively.

<img src="../img/9.host_4.png" width="60%" >

<div class="grid" markdown>

=== "Metrics"

    You can monitor the host's performance status within the last 24 hours in real-time, including CPU load, memory usage, etc.

    <img src="../img/host-metric.png" width="60%" >

=== "Logs"

    You can view logs and log counts related to the host within the last hour.
     
    **Note**: For a smoother user experience, <<< custom_key.brand_name >>> automatically saves your browsing settings (including "maximum displayed rows", "display columns") when viewing logs. Custom adjustments made in associated logs are not saved upon exiting the page.

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

=== "Security Checks"

    You can view security check data related to the host within the last day.

    <img src="../img/host-intecheck.png" width="60%" >

=== "Network"

    Host network supports viewing network traffic between hosts. It can visualize source-to-target network traffic and data connections based on server and client sides, helping businesses monitor network performance in real-time, quickly analyze, track, and locate issues, and prevent business problems due to network degradation or interruption.
    
    After host network data collection is successful, it will be reported to the <<< custom_key.brand_name >>> console. You can view network performance monitoring data in two formats: **Topology** and **Overview** in the network section of the host details page.
    
    > For more details, refer to [Network](network.md).

    <img src="../img/host-net.png" width="60%" >

</div>

### Mute Host {#mute}

In the host details page, click **Mute Host** to set the host to mute. Mute times include **Once** and **Repeat**, selectable as needed.

![](img/3.host_15.png)

After configuration, return to the host list. During the set mute period, you will not receive alerts related to this host, and generated alert events will be stored in event management. All muted hosts can be viewed in **Monitoring > Mute Management**.

> For more details, refer to [Alert Settings](../monitoring/alert-setting.md).

**Note**: If you set a host to mute in its details page and also set the same mute rule for this host in **Monitoring > [Mute Management](../monitoring/silent-management.md)**, the host will show a mute icon in the **Infrastructure > Hosts** list.

![](img/mute.png)

### Bind Built-in Views {#view}

<<< custom_key.brand_name >>> supports binding built-in views (user views) to the host details page. Click to bind built-in views to view default associated fields. You can choose whether to retain these fields and add new `key:value` fields.

![](img/view.png)

In Bind Built-in Views > Views, you can choose to add multiple views:

<img src="../img/view-2.png" width="60%" >

After completing the binding of built-in views, you can view the bound built-in views in the host object details and navigate to the corresponding built-in view page via the jump button :material-arrow-right-top-bold:, where you can edit, copy, and export the built-in view.

![](img/view-3.png)

**Note**: If [built-in views are bound](../scene/built-in-view/bind-view.md), if the currently opened data does not contain fields associated with the view, the view will not be displayed on the detail page of that data. Otherwise, it will be displayed.

<!--
![](img/4.view_bang_4.png)
-->



## Host Topology Map

Through the **Host Topology Map**, you can visually query the size of host metrics and quickly analyze the operational status of hosts under different systems, statuses, versions, and regions with custom tags.

- [Search and Filter](../getting-started/function-details/explorer-search.md);

- Analysis: You can regroup host objects by adding one or more grouping tags;

- Fill: You can customize fill metrics via **Fill**. The size of the fill metric values determines the legend color. Supports filling with CPU usage, memory usage, and CPU load;

- Custom Range: You can enable **Custom Range** to define the legend color intervals for the selected fill metric. The legend colors will be divided into five intervals based on the maximum and minimum values;

- Mouse Hover: Hover over a host object to view the host name, CPU usage, and memory usage.

![](img/3.host_2.2.png)