# Containers

---

After container data collection succeeds, it will be reported to the console. Enter **Infrastructure > Containers**, and you can view various object data information of containers within the workspace.

## Explorer

Container data has two viewing and analysis modes. By switching at the top-left corner of the page :octicons-list-unordered-24: and :material-hexagon-multiple-outline:, you can view:

- [Container Object List](#object);
- [Container Honeycomb Chart](#distribution).

### Container Object List {#object}

For container object data collected within the <u>last ten minutes</u> in the current workspace, you can view them in a set form and further query and analyze container data; you can also set labels for containers and filter and display container lists with the same label through labels.

- **[Containers](#containers)**: You can view all Containers information collected within the workspace;

- **Kubernetes Collection**: You can view Pods, Services, Deployments, Clusters, Nodes, Replica Sets, Jobs, Cron Jobs, Daemonsets information collected within the workspace.

![](img/contra_01.png)

#### Query and Analysis 

- Time Widget: The container object list supports viewing data collected within the <u>last ten minutes</u>. Through the :material-refresh: button, you can refresh to the current time range and re-fetch the data list.

- [Search and Filter](../getting-started/function-details/explorer-search.md): In the Explorer search bar, it supports keyword search, wildcard search, and multiple search methods; it supports filtering values through `labels/attributes`, including positive and negative filtering methods.

- [Quick Filter](../getting-started/function-details/explorer-search.md#quick-filter): Edit quick filters and add new filter fields. After adding, you can choose field values for quick filtering.

- [Custom Display Columns](../getting-started/function-details/explorer-search.md#columns): Customize adding, editing, deleting, and dragging display columns through **Display Columns**.

- [Analysis Mode](../getting-started/function-details/explorer-search.md#analysis): Supports multi-dimensional statistical analysis based on <u>1-3 labels</u>, reflecting data distribution characteristics under different dimensions. It supports multiple data chart analysis methods, including Top Lists, pie charts, and treemaps.

- Sorting: Click on menu items in the list, such as CPU usage rate, MEM usage rate, you can sort the selected tags in ascending or descending order.

- Data Export: At the top-right corner of the Explorer :material-cog: icon, you can:

    - Export to CSV File: Save the current list as a CSV file locally;
    - Export to Dashboard: Save the current list as a **visualization chart** to a specified **dashboard**;
    - Export to Notebook: Save the current list as a **visualization chart** to a specified **notebook**.

If you need to export a specific piece of data, open the details page of that data and click the :material-tray-arrow-up: icon at the top-right corner.

#### Containers {#containers}

Supports viewing all container information collected within the workspace, including container name, related host, running status, CPU usage rate, MEM usage rate, etc.

##### Details Page

Clicking on an object in the list pulls out a details page to view detailed container information, including container status, container name, container ID, container image, associated host, Pod, logs, processes, and Label attributes.

![](img/6.container_3.png)

##### Label Attributes {#label}

Uploaded automatically by default with container information. After adding container labels, you can filter and display container lists with added labels through the container object list.

##### Associated Analysis {#association-analysis}

<<< custom_key.brand_name >>> supports associated analysis for each infrastructure object. On the details page of the container object, besides basic container information, you can comprehensively understand associated metrics, hosts, Pods, logs, processes, etc., to monitor container operations faster and more comprehensively.

<div class="grid" markdown>

=== "Metrics"

    You can monitor the performance status of containers within the last 24 hours in real-time, and you can choose different time ranges for viewing. Click the icon at the top-right corner to customize edit and save the bound container view in the built-in view.

    **Note**: If the container is associated with fields `service`, `project`, `namespace`, then you can view the views corresponding to these three fields in the container details.

=== "Host"

    You can view the basic information and performance metric status of related hosts (associated field: `host`) within the selected time component range.

    **Note**: To view related hosts in container details, the `host` field must match; otherwise, you cannot see the related host page in container details.

    - Attribute View: Includes basic host information, integrated runtime conditions. If cloud host collection is enabled, you can also view cloud provider information.
    
    - Metrics View: You can view the CPU, memory, and other performance metric views of related hosts for the default 24 hours. Click **Open this view** to [Built-in View](../scene/built-in-view/bind-view.md), and you can customize modify the host view through cloning and save it as a user view, which can be viewed by binding it to the container details page.
    
    Additionally, by clicking the tag **Host** on the container details page, you can perform the following operations:
    
    | Action | Description |
    | --- | --- |
    | Filter Field Value | Add the field to the Explorer to view all data related to the field. |
    | Negative Filter Field Value | Add the field to the Explorer to view data other than the field. |
    | Add to Display Columns | Add the field to the Explorer list for viewing. |
    | Copy | Copy the field to the clipboard. |
    | View Related Logs | View all logs related to the host. |
    | View Related Containers | View all containers related to the host. |
    | View Related Processes | View all processes related to the host. |
    | View Related Traces | View all traces related to the host. |
    | View Related Inspections | View all inspection data related to the host. |
    
    ![Image title](img/21.container_1.png)

=== "Logs"

    You can view logs and log counts related to the container within the last hour and perform keyword searches, multi-label filtering, and time sorting on these related logs.

    - To view more detailed log information: Click on the log content to jump to the corresponding log details page, or click to jump to **Logs** to view all logs related to the host.
  
    - To view more log fields or complete log content: Customize adjust “Maximum Rows” and “Display Columns” through the associated log Explorer **Display Columns**.
  
    **Note**: For a smoother user query experience, <<< custom_key.brand_name >>> defaults to saving user browsing settings in **Logs** (including “Maximum Rows” and “Display Columns”) instantly, so that **Associated Logs** and **Logs** remain consistent. However, custom adjustments made in **Associated Logs** are not saved after exiting the page.

=== "Processes"

    You can view the basic information and performance metric status of related processes (associated field: `container_id`) within the selected time component range.

=== "Associated Pods"

    You can view the basic information and performance metric status of related Pods (associated field: `pod_name`) within the selected time component range.

    **Note**: To view related Pods in container details, the `pod_name` field must match; otherwise, you cannot see the related Pods page in container details.

</div>


#### Pods {#pods}

Through the **Pods** object in the top-left corner, you can view all Pods' information retained in the space, including Pod names, running status, restart count, start time, etc.

##### Pods Details Page

Clicking on an object in the list pulls out a details page to view detailed information about Pods, including running status, Pod name, associated node Node, Label attributes, associated metrics, associated containers, associated logs, YAML files, network connection status, associated server runtime status, and associated Kubernetes.

By clicking the tag **Host**, you can query related logs, containers, processes, traces, inspections, etc., for the host.

| Action | Description |
| --- | --- |
| Filter Field Value | Add the field to the Explorer to view all data related to the field. |
| Negative Filter Field Value | Add the field to the Explorer to view data other than the field. |
| Add to Display Columns | Add the field to the Explorer list for viewing. |
| Copy | Copy the field to the clipboard. |
| View Related Logs | View all logs related to the host. |
| View Related Containers | View all containers related to the host. |
| View Related Processes | View all processes related to the host. |
| View Related Traces | View all traces related to the host. |
| View Related Inspections | View all inspection data related to the host. |

![](img/7.pod_2.png)

##### Label Attributes

**Label Attributes** are uploaded automatically by default with Pods information. Existing Pod labels can be used to display Pods data with the same label via quick filtering in the Pods object list.

##### Associated Analysis

<<< custom_key.brand_name >>> supports associated analysis for each infrastructure object. On the details page of the Pods object, you can not only understand the basic information of Pods but also comprehensively associate corresponding Pods’ metrics, containers, logs, networks, hosts, etc., for faster and more comprehensive monitoring of Pods' operation.

Kubernetes Logs/Events: Click Kubernetes Logs/Events to view data associated with `namespace`, `source`, `kind`, `name`.

Click the time widget at the top-right corner to customize the time range for data filtering.

![](img/0810-pods.png)

#### Services

Through the **Services** object in the top-left corner, you can view all Services' information retained in the space, including Service names, service types, Cluster IP, External IP, uptime, etc.

##### Services Details Page

Clicking on an object in the list pulls out a details page to view detailed information about Services, including name, basic information, Label attributes, YAML files, etc.

**Note**: If Services are associated with the field `namespace`, then you can view the metric view corresponding to this field in the Services details page.

![](img/8.services_1.png)

##### Label Attributes

**Label Attributes** are uploaded automatically by default with Services information. Existing labels can be used to display Services data with the same label via quick filtering in the Services object list.

##### Kubernetes Events

Click Kubernetes events to view data associated with `namespace`, `source`, `kind`, `name`.

Click the time widget at the top-right corner to customize the time range for data filtering.

![](img/0810-pods.png)

#### Deployments

Through the **Deployments** object in the top-left corner, you can view all detailed information of Deployments retained in the space, including Deployment names, available replicas, upgraded replicas, readiness, uptime, etc.

##### Deployments Details Page

Clicking on an object in the list pulls out a details page to view detailed information about Deployments, including name, basic information, Label attributes, and other field attributes. Support viewing associated logs, Replica Set, Pods, network data, and associated Kubernetes.

**Note**: If Deployments are associated with the field `namespace`, then you can view the metric view corresponding to this field in the Services details page.

![](img/8.deployment_2.png)

##### Label Attributes

**Label Attributes** are uploaded automatically by default with Deployments information. Existing labels can be used to display Deployments data with the same label via quick filtering in the Deployments object list.


##### Associated Analysis 

=== "YAML"

    Supports viewing the YAML file corresponding to Deployments. In the Infrastructure Deployments details page, click **YAML** to view the corresponding YAML file.


=== "Logs"

    Through the **Logs** section below the details page, you can view logs and log counts related to Deployments within the last hour and perform keyword searches, multi-label filtering, and time sorting on these related logs.

    - To view more detailed log information: Click on the log content to jump to the corresponding log details page, or click to jump to **Logs** to view all logs related to the host;
    
    - To view more log fields or complete log content: Customize adjust “Maximum Rows” and “Display Columns” through the associated log Explorer **Display Columns**.
    
    **Note**: For a smoother user query experience, <<< custom_key.brand_name >>> defaults to saving user browsing settings in **Logs** (including “Maximum Rows” and “Display Columns”) instantly, so that **Associated Logs** and **Logs** remain consistent. However, custom adjustments made in **Associated Logs** are not saved after exiting the page.

=== "Pods"

    Supports viewing the readiness state, restart count, uptime, etc., of Pods associated with Deployments. Click Pods or the jump button to Pods to view all Pods related to this Deployment.

=== "Replica Set"

    Supports viewing the readiness state, uptime, etc., of Replica Sets associated with Deployments. Click Replica Sets or the jump button to Replica Sets to view all Replica Sets related to this Deployment.

=== "Network"

    Deployment network supports viewing network traffic between Deployments. It supports viewing source IP to target IP network traffic and data connections based on IP/port, visualizing the real-time display to help businesses understand the network operation status of their business systems, quickly analyze, track, and locate issues, and prevent or avoid business problems caused by network performance degradation or interruption.
    
    Network data collected from Deployments is reported to the <<< custom_key.brand_name >>> console. You can view the network performance monitoring data of the current Deployment in the **[Network](network.md)** section of the **Infrastructure > Containers > Pods** details page.

=== "Kubernetes Logs/Events"

    Click Kubernetes logs/events to view data associated with `namespace`, `source`, `kind`, `name`.

    Click the time widget at the top-right corner to customize the time range for data filtering.

    ![](img/0810-pods.png)

#### Clusters

Through the **Clusters** object in the top-left corner, you can view all Clusters' information retained in the space, including Cluster names, runtime, Kubernetes annotations, etc.

##### Clusters Details Page

Clicking on an object in the list pulls out a details page to view detailed information about Clusters, including name, basic attribute information, Label attributes, and other field attributes.

![](img/10.clusters_2.png)

##### Label Attributes

**Label Attributes** are uploaded automatically by default with Clusters information. Existing labels can be used to display Clusters data with the same label via quick filtering in the Clusters object list.

#### Nodes

Through the **Nodes** object in the top-left corner, you can view all Nodes' information retained in the space, including Node names, status, version, runtime.

##### Nodes Details Page

Clicking on an object in the list pulls out a details page to view detailed information about Nodes, including name, basic attribute information, Label attributes, and other field attributes. Supports viewing associated Pods data.

![](img/11.nodes_2.png)

Among them, clicking Kubernetes events can view data associated with `namespace`, `source`, `kind`, `name`. The time widget at the top-right corner supports customizing the time range for data filtering.

![](img/0810-pods.png)

##### Label Attributes

**Label Attributes** are uploaded automatically by default with Nodes information. Existing labels can be used to display Nodes data with the same label via quick filtering in the Nodes object list.

#### Replica Sets

Through the **Replica Sets** object in the top-left corner, you can view all detailed information of Replica Sets retained in the space, including Replica Set names, runtime, cluster, etc.

##### Replica Sets Details Page

Clicking on an object in the list pulls out a Replica Sets details page to view Replica Sets information, including name, basic attribute information, Label attributes, and other field attributes. Supports viewing associated Pods data.

**Note**: If Replica Sets are associated with the field `namespace`, then you can view the metric view corresponding to this field in the Services details page.

![](img/12.sets_2.png)

Among them, clicking Kubernetes events can view data associated with `namespace`, `source`, `kind`, `name`. The time widget at the top-right corner supports customizing the time range for data filtering.

![](img/0810-pods.png)

##### Label Attributes

**Label Attributes** are uploaded automatically by default with Replica Sets information. Existing labels can be used to display Replica Sets data with the same label via quick filtering in the Replica Sets object list.

#### Jobs

Through the **Jobs** object in the top-left corner, you can view all Jobs' information retained in the space, including Job names, parallel count, active number, runtime, etc.

##### Jobs Details Page

Clicking on an object in the list pulls out a details page to view detailed information about Jobs, including name, basic attribute information, Label attributes, and other field attributes.

![](img/13.jobs_2.png)

##### Label Attributes

**Label Attributes** are uploaded automatically by default with Jobs information. Existing labels can be used to display Jobs data with the same label via quick filtering in the Jobs object list.

#### Cron Jobs

Through the **Cron Jobs** object in the top-left corner, you can view all Cron Jobs' information retained in the space, including Cron Job names, schedule, pause status, active job count, runtime, etc.

##### Cron Jobs Details Page

Clicking on an object in the list pulls out a details page to view detailed information about Cron Jobs, including name, basic attribute information, Label attributes, and other field attributes.

![](img/14.cronjobs_2.png)

Among them, clicking Kubernetes events can view data associated with `namespace`, `source`, `kind`, `name`. The time widget at the top-right corner supports customizing the time range for data filtering.

![](img/0810-pods.png)

##### Label Attributes

**Label Attributes** are uploaded automatically by default with Cron Jobs information. Existing labels can be used to display Cron Jobs data with the same label via quick filtering in the Cron Jobs object list.

#### Daemonsets

Through the **Daemonsets** object in the top-left corner, you can view all Daemonsets information retained in the space, displaying Daemonset names, expected node count, updated node count, ready node count, runtime, etc. by default.

##### Daemonsets Details Page {#daemonsets}

Clicking on an object in the list pulls out a details page to view Daemonsets updated node count, ready node count, and other field attributes.

![](img/daemonsets.png)

Among them, clicking Kubernetes events can view data associated with `namespace`, `source`, `kind`, `name`. The time widget at the top-right corner supports customizing the time range for data filtering.

![](img/0810-pods.png)

##### Label Attributes

**Label Attributes** are uploaded automatically by default with Daemonsets information. Existing labels can be used to display Daemonsets data with the same label via quick filtering in the Daemonsets object list.

#### Statefulset {#statefulset}

Through the **Statefulset** object in the top-left corner, you can view all Statefulset information retained in the space, displaying Statefulset names, cluster, namespace, runtime, prepared replica count, running replica count, and desired replica count by default.

##### Statefulset Details Page 

Clicking on an object in the list pulls out a details page to view Statefulset associated prepared replica count, runtime, and other field attributes.

![](img/statefulset.png)

Among them, clicking Kubernetes events can automatically view data associated with `source`, `involved_kind`, `involved_namespace`, `involved_name`. The time widget at the top-right corner supports customizing the time range for data filtering.

![](img/statefulset-1.png)

#### Persistent Volumes {#persistent-volumes}

Through the **Persistent Volumes** object in the top-left corner, you can view all Persistent Volumes information retained in the space, displaying Persistent Volumes names, cluster, namespace, available count, idle nodes, and capacity by default.

##### Persistent Volumes Details Page 

Clicking on an object in the list pulls out a details page to view Persistent Volumes associated Pod names and available space.

![](img/persistent-volumes.png)

<!--
Among them, clicking Kubernetes events can automatically view data associated with `source`, `involved_kind`, `involved_namespace`, `involved_name`. The time widget at the top-right corner supports customizing the time range for data filtering.

![](img/persistent-volumes-1.png)
-->

### Honeycomb Chart {#distribution}

In **Infrastructure > Containers**, when switching the Explorer to the container honeycomb chart, you can view **Containers** and **Kubernetes > Pods** data in a honeycomb chart format.

- **Containers** Honeycomb Chart: Quickly view the size of container metric values [CPU usage rate, MEM usage rate, standardized CPU usage rate, and standardized MEM usage rate] and analyze the performance status of containers under different projects, services, hosts, images;

- **Pods** Honeycomb Chart: Quickly view the restart count of Pods and analyze the performance status of Pods under different projects, services, hosts, Nodes names, namespaces.

![](img/6.container_1.png)

| Action      | Description                 |
| ----------- | ------------------------- |
| [Search and Filter](../getting-started/function-details/explorer-search.md)      |                  |
| Analysis      | You can reorganize Containers/Pods objects by adding one or more grouping labels.                 |
| Fill      | You can customize the selection of fill metrics, where the size of the fill metric value will determine the color of the legend. Includes four types of fill metrics: CPU usage rate, MEM usage rate, standardized CPU usage rate, and standardized MEM usage rate.                 |
| Custom Range      | You can enable custom legend ranges through **Legend Settings**. The legend colors will be divided into five intervals based on the maximum and minimum values of the legend, with each interval automatically corresponding to five different colors.                 |
| Hover      | Hovering over a container object with the mouse allows you to view the container name, CPU usage rate, MEM usage rate, standardized CPU usage rate, and standardized MEM usage rate.                 |

## Analysis Dashboard {#analyse}

In **Infrastructure > Containers**, you can switch the Explorer to the **Analysis Dashboard**.

The Analysis Dashboard displays overview charts related to Kubernetes collections simultaneously on the same interface, building data insight scenarios through multidimensional data analysis. Comprehensive monitoring of different container collection data metrics is achieved using view switching, time widgets, cluster name/namespace filtering, etc.

![](img/contra_02.png)

### Switching

Default view is the Kubernetes Overview View, supporting dropdown switching to view other object-related analysis dashboards:

- **Kubernetes Overview View**: View the system overview view under the Kubernetes cluster;

- **Kubernetes Services Monitoring View**: View the system overview view related to Services under the Kubernetes cluster;

- **Kubernetes Nodes Monitoring View**: View the system overview view related to Nodes under the Kubernetes cluster;

- **Kubernetes Pods Monitoring View**: View the system overview view related to Pods under the Kubernetes cluster;

- **Kubernetes Event Monitoring View**: View container-related events under the Kubernetes cluster, including Warning events, Top 10 events, etc. Supports viewing event details, including node unavailability, node restarts, node OOM, image pull failures, volume mount failures, scheduling failures, etc., in statistical views.

**Note**: Built-in views (user views) with the same name as system views have priority display.

## Further Reading

<font size=3>

<div class="grid cards" markdown>

- [<font color="coral"> :fontawesome-solid-arrow-right-long: &nbsp; View</font>](../scene/built-in-view/index.md)

</div>


<div class="grid cards" markdown>

- [<font color="coral"> :fontawesome-solid-arrow-right-long: &nbsp; Dashboard</font>](../scene/dashboard/index.md)

</div>

</font>