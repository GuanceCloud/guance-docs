# HOSTS
---

After the HOST data collection is completed, it is automatically synchronized to the <<< custom_key.brand_name >>> management console. In the HOST Explorer, you can view all collected HOST data.

The console provides two professional analysis views (select through the view tab in the top-left corner):

- **HOST Object List**: Displays HOST Metrics data from the last 2 days within the current workspace, including HOST name/tags, CPU usage, memory usage, and CPU load, helping users monitor HOST operational status.

- **HOST Topology Map**: Visually presents the dynamic topology structure of the HOST cluster, providing analysis dimensions such as operating system type, DataKit version, cloud vendor, and deployment region, with support for cross-level topology drilling, facilitating HOST relationship analysis.

## Manage HOSTS

### Data Sorting

In the HOST object list, you can sort Metric data in ascending or descending order:

<img src="../img/host-queue.png" width="60%" >

**Note**: Due to data warehousing delays, these Metrics are not updated in real-time. The system calculates the average value every 5 minutes for the last 15 minutes, so there may be some deviation in the final data.


### Display Online HOSTS Only {#online}

Clicking the "Display Online HOSTS Only" button quickly lists HOSTS that have reported data within the last 10 minutes.

???+ warning "Note"

    - If HOST data reporting breaks for more than 10 minutes, CPU usage, MEM usage, and CPU load will display as `-`;
    - If a HOST has not reported data for over 24 hours, it will be removed from the list.

<img src="../img/host-status.png" width="60%" >

### Time Widget {#time}

In the upper-right corner of the Explorer, you can select HOST data for different time ranges, including:

- Last 2 hours
- Last 6 hours
- Last 1 day
- Last 2 days

## HOST Details {#details}

By clicking on the HOST name in the HOST object list, a side-sliding HOST details page appears where you can view basic information, extended attributes, related information, and bound Views for that HOST.

### Mute HOST {#mute}

This feature allows you to temporarily ignore alert notifications for specific HOSTS, reducing distractions and focusing on important tasks, such as known temporary issues or maintenance periods.

1. On the HOST details page, click **Mute HOST**;
2. Select the mute duration;
3. Click confirm.

<img src="../img/3.host_15.png" width="70%" >

After configuration, return to the HOST list, and muted HOSTS will display a mute mark. During the mute period, you will not receive any alert notifications for that HOST, and related alert events will automatically be stored in event management. You can view all muted HOSTS under **Monitoring > [Mute Management](../monitoring/mute-management.md)**.

> For more details, refer to [Alert Settings](../monitoring/alert-setting.md).

![](img/mute.png)

To cancel muting, simply click "Cancel Mute" in the HOST details or operate under "Monitoring > Mute Management".

<img src="../img/mute_1.png" width="70%" >

<img src="../img/mute_2.png" width="70%" >

### Export Data

If you need to export a HOST data record, click the :material-tray-arrow-up: icon in the upper-right corner.

![](img/host_data_export.png)


### HOST Labels {#label}

In multi-HOST management environments, you can customize labels for each HOST. Based on property labels, final data classification and filtering queries can be performed.

1. Click the edit button next to **Labels**;

2. Select labels from the dropdown list or directly add by pressing Enter;

3. After adding, save.

**Note**: After label configuration, it takes 1-5 minutes to take effect.


![](img/7.host_label_1.png)

![](img/7.host_label_3.png)

### Basic Information

In the basic information section of the HOST details page, you can add [HOST Labels](#label), check integration running conditions, system information, and cloud vendor information.

#### Integration Running Conditions

**Integration Running Conditions** displays DataKit version information installed on this HOST and the running status of related collectors. There are two running statuses:

- Collectors in normal running state are displayed by default as "light blue";

- Collectors with errors are displayed by default as "red" and support viewing error information by clicking.

At the same time, collectors with View symbols :fontawesome-solid-chart-simple: support monitoring View inspection:

![](img/7.host_detail_2.png)

#### System Information

The HOST details page shows system information about the HOST, covering HOST name, operating system, processor, memory, network, disk, connection tracking, and files, among others.


#### Cloud Vendor Information

For cloud HOSTS configured with [cloud synchronization](../integrations/hostobject.md#cloudinfo), the HOST details page also provides the following information: cloud platform, instance name, instance ID, instance specification, region, availability zone, creation time, network type, payment type, and IP address, among others.


### Extended Attributes

You can view all attributes related to the HOST. Supports searching and filtering via field name or value to narrow down the scope.

Hover over the corresponding field's value to display its original format.

<img src="../img/value.png" width="60%" >

### Associated Analysis

<<< custom_key.brand_name >>> supports associated analysis for each infrastructure object. Besides basic HOST information, you can comprehensively understand the HOST’s related Metrics, LOGs, processes, events, CONTAINERS, NETWORKs, security checks, etc., for faster and more comprehensive monitoring of HOST operations.

<img src="../img/9.host_4.png" width="60%" >

#### Bind Built-in Views {#view}

Besides the system-default Views displayed here, you can also bind user Views.

1. Enter the built-in View binding page;
2. Check the default associated fields. You can choose to retain or delete fields, or add new `key:value` fields;
3. Select the View;
4. After binding, you can view the bound built-in Views in the HOST object details and jump to the corresponding built-in View page by clicking the jump button :material-arrow-right-top-bold:.

**Note**: If the current data does not contain the associated fields of the bound View, the View will not be displayed on the details page; otherwise, it will be displayed.

<img src="../img/view.png" width="70%" >

<img src="../img/view-2.png" width="70%" >

<img src="../img/view-3.png" width="70%" >

Click the jump button :material-arrow-right-top-bold:, and you can enter the corresponding built-in View page.

<img src="../img/view-4.png" width="70%" >

<!--

<div class="grid" markdown>

=== "Metrics"

    You can monitor in real-time the performance status of the HOST <u>within the last 24 hours</u>, including CPU load, memory usage, etc.

    <img src="../img/host-metric.png" width="60%" >

=== "LOGs"

    You can view <u>within the last hour</u> LOGs and LOG counts related to the HOST.
     
    **Note**: To provide a smoother user query experience, <<< custom_key.brand_name >>> defaults to saving the user's browsing settings for LOGs (including “maximum number of rows to display” and “columns to display”) so that **associated LOGs** match the LOGs. However, custom adjustments made in associated LOGs are not saved after exiting the page.

    <img src="../img/host-log.png" width="60%" >

    > For more page operations, refer to [LOG Explorer](../logs/explorer.md).

=== "Processes"

    You can view <u>within the last 10 minutes</u> processes and process counts related to the HOST.
    
    <img src="../img/host-process.png" width="60%" >

=== "Events"

    You can view <u>within the last hour</u> alert Events related to the HOST (associated field: `host`).
    
    <img src="../img/host-event.png" width="60%" >

=== "CONTAINERS"

    You can view all CONTAINER data related to the HOST <u>within the last 10 minutes</u>.
    
    <img src="../img/host-container.png" width="60%" >

=== "Security Checks"

    You can view Security Check data related to the HOST <u>within the last day</u>.

    <img src="../img/host-intecheck.png" width="60%" >

=== "NETWORK"

    HOST NETWORK supports viewing network traffic between HOSTs. It supports viewing source HOST to target network traffic and data connections based on server and client sides, displaying them in real-time through visualization methods, helping businesses understand their system's network operation status in real-time, quickly analyzing, tracking, and locating faults, preventing or avoiding business problems caused by decreased or interrupted network performance.
    
    After successful collection of HOST NETWORK data, it is reported to the <<< custom_key.brand_name >>> console, where you can view the HOST's NETWORK performance monitoring data information in either **Topology** or **Summary** form under the NETWORK section of the HOST details page in **Infrastructure > HOST**.
    
    > For more details, refer to [NETWORK](network.md).

    <img src="../img/host-net.png" width="60%" >

</div>
-->