# HOST
---

After completing the HOST data collection, it will be automatically synchronized to <<< custom_key.brand_name >>> Management Console. In the HOST Explorer, you can view all collected HOST data.

The console provides two professional analysis views (selectable via the view tab in the top left corner):

- **HOST Object List**: Displays metrics data for all HOSTs within the current workspace over the past 2 days, including HOST name/tags, CPU usage, memory usage, and CPU load, helping users monitor HOST operating status.

- **HOST Topology Diagram**: Visualizes dynamic topology structures of HOST clusters, providing analysis dimensions such as operating system type, DataKit version, cloud provider, and deployment region. It supports cross-level topology drilling to facilitate HOST relationship analysis.

## Manage HOST

### Data Sorting

In the HOST object list, you can sort metric data in ascending or descending order:

<img src="../img/host-queue.png" width="60%" >

**Note**: Due to delays in data storage, these metrics are not updated in real-time. The system calculates the average value of the last 15 minutes every 5 minutes, so there may be some deviation in the final data.


### Display Online HOSTs Only {#online}

Clicking the "Display Online HOSTs Only" button quickly lists HOSTs that have reported data in the last 10 minutes.

???+ warning "Note"

    - If HOST data is interrupted for more than 10 minutes, CPU usage, MEM usage, and CPU load will be displayed as `-`;
    - If a HOST has no data reporting for more than 24 hours, it will be removed from the list.

<img src="../img/host-status.png" width="60%" >

### Time Widget {#time}

In the upper right corner of the Explorer, you can select HOST data for different time ranges, including:

- Last 2 hours
- Last 6 hours
- Last 1 day
- Last 2 days

## HOST Details {#details}

By clicking on the HOST name in the HOST object list, the side-sliding HOST details page allows you to view basic information, extended attributes, associated information, and bound views for that HOST.

### Mute HOST {#mute}

This feature can temporarily ignore alert notifications for specific HOSTs, reducing interference and focusing on important tasks, such as known temporary issues or maintenance periods.

1. On the HOST detail page, click **Mute HOST**;
2. Select mute time type;
3. Click confirm.

<img src="../img/3.host_15.png" width="70%" >

After configuration, return to the HOST list where muted HOSTs will display a mute mark. During the mute period, you will not receive alarm notifications for this HOST, and related alarm events will be automatically stored in event management. You can view all muted HOSTs under **Monitoring > [Mute Management](../monitoring/silent-management.md)**.

> For more details, refer to [Alert Settings](../monitoring/alert-setting.md).

![](img/mute.png)

To cancel muting, you can directly click "Cancel Mute" in the HOST detail or operate in "Monitoring > Mute Management".

<img src="../img/mute_1.png" width="70%" >

<img src="../img/mute_2.png" width="70%" >

### Export Data

If you need to export a specific HOST's data, simply click the :material-tray-arrow-up: icon in the top right corner.

![](img/host_data_export.png)


### HOST Labels {#label}

In multi-HOST management environments, you can customize labels for each HOST. Based on property labels, the final data classification and query filtering can be achieved.

1. Click the edit button to the right of **Labels**;

2. Select labels from the drop-down list, or press Enter to add new labels;

3. After adding, save.

**Note**: After configuring labels, they will take effect after waiting for 1-5 minutes.


![](img/7.host_label_1.png)

![](img/7.host_label_3.png)

### Basic Information

In the basic information section of the HOST detail page, you can add [HOST Labels](#label), view integration running conditions, system information, and cloud provider information.

#### Integration Running Conditions

**Integration Running Conditions** displays the installed DataKit version information and related collector running conditions for this HOST. There are two states for running conditions:

- Collectors in normal running state are default displayed as "light blue";

- Faulty collectors are default displayed as "red" and support viewing error information by clicking.

At the same time, collectors with view symbols :fontawesome-solid-chart-simple: support monitoring view inspection:

![](img/7.host_detail_2.png)

#### System Information

The HOST detail page displays the system information of the HOST, covering HOST name, operating system, processor, memory, network, disk, connection tracking, and files, among others.


#### Cloud Provider Information

For cloud HOSTs configured with [Cloud Sync](../integrations/hostobject.md#cloudinfo), the HOST detail page also provides the following information: cloud platform, instance name, instance ID, instance specification, region, availability zone, creation time, network type, billing type, and IP address, etc.


### Extended Attributes

You can view all properties related to the HOST. Searching by field name or value is supported to narrow down the scope of inspection.

Hover over the corresponding field value to display its original format.

<img src="../img/value.png" width="60%" >

### Correlation Analysis

<<< custom_key.brand_name >>> supports correlation analysis for each infrastructure object. Besides the basic information of the HOST, you can comprehensively understand the HOST's associated Metrics, LOGs, processes, events, CONTAINERS, NETWORKs, Security Checks, etc., enabling faster and more comprehensive monitoring of HOST operation conditions.

<img src="../img/9.host_4.png" width="60%" >

#### Bind Built-in Views {#view}

Besides the system-default views displayed here, user-defined views can also be bound.

1. Enter the built-in view binding page;
2. View default associated fields. You can choose to retain or delete fields and add new `key:value` fields;
3. Select the view;
4. After binding, you can view the bound built-in views in the HOST object details. By clicking the jump button :material-arrow-right-top-bold:, you can navigate to the corresponding built-in view page.

**Note**: If the current data does not include the associated fields of the bound view, the view will not be displayed on the detail page; otherwise, it will be displayed.

<img src="../img/view.png" width="70%" >

<img src="../img/view-2.png" width="70%" >

<img src="../img/view-3.png" width="70%" >

Click the jump button :material-arrow-right-top-bold: to enter the corresponding built-in view page.

<img src="../img/view-4.png" width="70%" >

<!--

<div class="grid" markdown>

=== "Metrics"

    You can monitor the performance status of the HOST <u>within the last 24 hours</u> in real-time, including CPU load, memory usage, etc.

    <img src="../img/host-metric.png" width="60%" >

=== "LOGs"

    You can view the <u>last 1 hour</u> LOGs and LOG counts related to the HOST.
     
    **Note**: To provide a smoother user query experience, <<< custom_key.brand_name >>> defaults to saving user browsing settings for LOGs (including "maximum number of lines displayed", "columns displayed") so that **associated LOGs** remain consistent with LOGs. However, any custom adjustments made during the associated LOGs session are not saved after exiting the page.

    <img src="../img/host-log.png" width="60%" >

    > For more page operations, refer to [LOG Explorer](../logs/explorer.md).

=== "Processes"

    You can view the <u>last 10 minutes</u> processes and process counts related to the HOST.
    
    <img src="../img/host-process.png" width="60%" >

=== "Events"

    You can view the <u>last 1 hour</u> alert events (associated field: `host`) related to the HOST.
    
    <img src="../img/host-event.png" width="60%" >

=== "CONTAINERS"

    You can view all CONTAINER data related to the HOST <u>in the last 10 minutes</u>.
    
    <img src="../img/host-container.png" width="60%" >

=== "Security Check"

    You can view Security Check data related to the HOST <u>in the last 1 day</u>.

    <img src="../img/host-intecheck.png" width="60%" >

=== "NETWORK"

    Host networking supports viewing network traffic between hosts. It supports viewing source host to target network traffic and data connections based on server or client sides, visually displaying them in real-time. This helps businesses understand their business systems' network operational status in real-time, quickly analyze, track, and locate issues, preventing or avoiding business problems caused by declining or interrupted network performance.
    
    After successful collection of host network data, it is reported to the <<< custom_key.brand_name >>> console. You can view the host's network performance monitoring data information in two forms: **Topology** and **Summary**, in the NETWORK section of the **Infrastructure > Host** details page.
    
    > For more details, refer to [Network](network.md).

    <img src="../img/host-net.png" width="60%" >

</div>
-->