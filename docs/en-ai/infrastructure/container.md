# Containers

---

After the container data is successfully collected, it will be reported to the console. Navigate to **Infrastructure > Containers**, where you can view various object data information of containers within the workspace.

## Explorer

Container data can be viewed and analyzed in two modes by switching the icons :octicons-list-unordered-24: and :material-hexagon-multiple-outline: in the top-left corner of the page. You can view:

- [Container Object List](#object);
- [Container Hex Map](#distribution).

### Container Object List {#object}

For container object data collected within the <u>last ten minutes</u> in the current workspace, you can view them as a collection and further query and analyze the container data. You can also set labels for containers and filter the container list using these labels.

- **[Containers](#containers)**: View all Containers information collected within the workspace;

- **Kubernetes Collection**: View Pods, Services, Deployments, Clusters, Nodes, Replica Sets, Jobs, Cron Jobs, Daemonsets information collected within the workspace.

![](img/contra_01.png)

#### Query and Analysis 

- Time Controls: The Container Object List supports viewing data collected within the <u>last ten minutes</u>. Click the :material-refresh: button to refresh the current time range and retrieve new data lists.

- [Search and Filter](../getting-started/function-details/explorer-search.md): In the Explorer search bar, support multiple search methods such as keyword search and wildcard search; support filtering values through `labels/attributes`, including forward and reverse filtering.

- [Quick Filters](../getting-started/function-details/explorer-search.md#quick-filter): Edit and add new filter fields in Quick Filters. After adding, you can choose field values for quick filtering.

- [Custom Display Columns](../getting-started/function-details/explorer-search.md#columns): Customize the addition, editing, deletion, and dragging of display columns via **Display Columns**.

- [Analysis Mode](../getting-started/function-details/explorer-search.md#analysis): Support multi-dimensional analysis statistics based on <u>1-3 labels</u>, reflecting the distribution characteristics of data under different dimensions. Supports multiple data chart analysis methods, including Top Lists, pie charts, and treemaps.

- Sorting: Click menu items like CPU Usage Rate, MEM Usage Rate, and sort the selected tags in ascending or descending order.

- Data Export: Click the :material-cog: icon at the top right corner of the Explorer:

    - Export to CSV File: Save the current list as a CSV file locally;
    - Export to Dashboard: Save the current list as **visual charts** to a specified **dashboard**;
    - Export to Note: Save the current list as **visual charts** to a specified **note**.

If you need to export a specific data entry, open the details page of that entry and click the :material-tray-arrow-up: icon at the top right corner.


#### Containers {#containers}

Supports viewing all container information collected within the workspace, including container name, related host, running status, CPU usage rate, MEM usage rate, etc.

##### Details Page

Clicking on an object in the list pulls out the details page to view detailed information about the container, including container status, container name, container ID, container image, associated host, Pod, logs, processes, and Label attributes.

![](img/6.container_3.png)

##### Label Attributes {#label}

Uploaded automatically with container information. After adding container labels, you can filter and display container lists with the same label in the container object list.

##### Associated Analysis {#association-analysis}

Guance supports associated analysis for each infrastructure object. On the details page of a container object, besides basic container information, you can comprehensively monitor the performance of associated metrics, hosts, Pods, logs, processes, etc., providing faster and more comprehensive monitoring of container operations.

<div class="grid" markdown>

=== "Metrics"

    You can monitor the performance status of containers <u>within the last 24 hours</u> in real-time and choose different time ranges for viewing. Click the icon at the top right corner to customize and save edits to the bound container views in built-in views.

    **Note**: If the container has associated fields `service`, `project`, `namespace`, then corresponding views for these fields can be viewed in the container details.

=== "Host"

    You can view the basic information and performance metric status of related hosts (associated field: `host`) <u>within the selected time component range</u>.

    **Note**: To view related hosts in container details, the field `host` must match; otherwise, the related host page cannot be viewed in container details.

    - Attribute View: Includes basic information about the host, integration operation status, and cloud vendor information if cloud host collection is enabled;
    
    - Metrics View: View default 24-hour performance metric views for related hosts such as CPU, memory. Click **Open this view** to [Built-in Views](../scene/built-in-view/bind-view.md), clone and customize modifications to host views, and save them as user views. User views can be viewed in container details pages after binding.
    
    Additionally, clicking the tag **Host** on the container details page allows you to perform the following operations:
    
    | Action | Description |
    | --- | --- |
    | Filter Field Value | Add this field to the Explorer to view all data related to this field. |
    | Reverse Filter Field Value | Add this field to the Explorer to view all data except for this field. |
    | Add to Display Columns | Add this field to the Explorer list for viewing. |
    | Copy | Copy this field to the clipboard. |
    | View Related Logs | View all logs related to this host. |
    | View Related Containers | View all containers related to this host. |
    | View Related Processes | View all processes related to this host. |
    | View Related Traces | View all traces related to this host. |
    | View Related Inspections | View all inspection data related to this host. |
    
    ![Image title](img/21.container_1.png)

=== "Logs"

    You can view logs and log counts related to the container <u>within the last hour</u>, and perform keyword searches, multi-label filtering, and time sorting on these related logs.

    - For more detailed log information: Click the log content to jump to the corresponding log details page or click to jump to **Logs** to view all logs related to this host;
  
    - For more log fields or complete log content: Adjust "Maximum Display Rows" and "Display Columns" via the associated log Explorer's **Display Columns**.
  
    **Note**: To provide a smoother user query experience, Guance saves user browsing settings in **Logs** (including "Maximum Display Rows", "Display Columns") by default to keep **Associated Logs** consistent with **Logs**. However, custom adjustments made in **Associated Logs** are not saved after exiting the page.

=== "Processes"

    You can view the basic information and performance metric status of related processes (associated field: `container_id`) <u>within the selected time component range</u>.

=== "Associated Pods"

    You can view the basic information and performance metric status of related Pods (associated field: `pod_name`) <u>within the selected time component range</u>.

    **Note**: To view related Pods in container details, the field `pod_name` must match; otherwise, the related Pods page cannot be viewed in container details.

</div>


#### Pods {#pods}

By selecting the object **Pods** in the top-left corner, you can view all Pods' information retained within the workspace, including Pod names, running status, restart count, start time, etc.

##### Pods Details Page

Clicking on an object in the list pulls out the details page to view detailed information about the Pod, including running status, Pod name, associated node Node, Label attributes, associated metrics, associated containers, associated logs, YAML files, network connection status, associated server operation status, and associated Kubernetes.

Clicking the tag **Host** allows you to query data related to logs, containers, processes, traces, inspections, etc., associated with this host.

| Action | Description |
| --- | --- |
| Filter Field Value | Add this field to the Explorer to view all data related to this field. |
| Reverse Filter Field Value | Add this field to the Explorer to view all data except for this field. |
| Add to Display Columns | Add this field to the Explorer list for viewing. |
| Copy | Copy this field to the clipboard. |
| View Related Logs | View all logs related to this host. |
| View Related Containers | View all containers related to this host. |
| View Related Processes | View all processes related to this host. |
| View Related Traces | View all traces related to this host. |
| View Related Inspections | View all inspection data related to this host. |

![](img/7.pod_2.png)

##### Label Attributes

**Label Attributes** are uploaded automatically with Pods information. Existing Pod labels can be filtered in the Pods object list to display Pods with the same label.

##### Associated Analysis

Guance supports associated analysis for each infrastructure object. On the details page of a Pod object, you can not only view the basic information of the Pod but also comprehensively associate the metrics, containers, logs, networks, hosts, etc., of the corresponding Pod, providing faster and more comprehensive monitoring of Pod operations.

Kubernetes Logs/Events: Click Kubernetes Logs/Events to view data associated with `namespace`, `source`, `kind`, `name`.

Click the time control at the top right corner to customize the time range for filtering data.

![](img/0810-pods.png)

#### Services

By selecting the object **Services** in the top-left corner, you can view all Services' information retained within the workspace, including Service names, service type, Cluster IP, External IP, runtime, etc.

##### Services Details Page

Clicking on an object in the list pulls out the details page to view detailed information about the Service, including name, basic information, Label attributes, YAML files, etc.

**Note**: If the Service has an associated field `namespace`, then corresponding metric views for this field can be viewed in the Service details page.

![](img/8.services_1.png)

##### Label Attributes

**Label Attributes** are uploaded automatically with Services information. Existing labels can be filtered in the Services object list to display Services with the same label.

##### Kubernetes Events

Click Kubernetes events to view data associated with `namespace`, `source`, `kind`, `name`.

Click the time control at the top right corner to customize the time range for filtering data.

![](img/0810-pods.png)

#### Deployments

By selecting the object **Deployments** in the top-left corner, you can view all Deployments' detailed information retained within the workspace, including Deployment names, available replicas, upgraded replicas, readiness, runtime, etc.

##### Deployments Details Page

Clicking on an object in the list pulls out the details page to view detailed information about the Deployment, including name, basic information, Label attributes, and other field attributes. Supports viewing associated logs, Replica Set, Pods, network data, and associated Kubernetes.

**Note**: If the Deployment has an associated field `namespace`, then corresponding metric views for this field can be viewed in the Service details page.

![](img/8.deployment_2.png)

##### Label Attributes

**Label Attributes** are uploaded automatically with Deployments information. Existing labels can be filtered in the Deployments object list to display Deployments with the same label.

##### Associated Analysis 

=== "YAML"

    Supports viewing the YAML file corresponding to Deployments. In the Infrastructure Deployments details page, click **YAML** to view the corresponding YAML file.

=== "Logs"

    Through the **Logs** section at the bottom of the details page, you can view logs and log counts related to the Deployment <u>within the last hour</u>, and perform keyword searches, multi-label filtering, and time sorting on these related logs.

    - For more detailed log information: Click the log content to jump to the corresponding log details page or click to jump to **Logs** to view all logs related to this host;
    
    - For more log fields or complete log content: Adjust "Maximum Display Rows" and "Display Columns" via the associated log Explorer's **Display Columns**.
    
    **Note**: To provide a smoother user query experience, Guance saves user browsing settings in **Logs** (including "Maximum Display Rows", "Display Columns") by default to keep **Associated Logs** consistent with **Logs**. However, custom adjustments made in **Associated Logs** are not saved after exiting the page.

=== "Pods"

    Supports viewing the readiness status, restart count, runtime, etc., of Pods associated with Deployments. Click Pods or the jump button to view all Pods related to this Deployment.

=== "Replica Set"

    Supports viewing the readiness status and runtime of Replica Sets associated with Deployments. Click Replica Sets or the jump button to view all Replica Sets related to this Deployment.

=== "Network"

    Network traffic between Deployments can be viewed. Supports viewing source IP to destination IP network traffic and data connections based on IP/port, visualized in real-time to help businesses understand the network operation status of their business systems, quickly analyze, track, and locate issues, and prevent or avoid business problems caused by network performance degradation or interruption.

    After successful collection of network data from Deployments, it will be reported to the Guance console. You can view the network performance monitoring data information of the current Deployment in the **[Network](network.md)** section of the **Infrastructure > Container > Pods** details page.

=== "Kubernetes Logs/Events"

    Click Kubernetes logs/events to view data associated with `namespace`, `source`, `kind`, `name`.

    Click the time control at the top right corner to customize the time range for filtering data.

    ![](img/0810-pods.png)

#### Clusters

By selecting the object **Clusters** in the top-left corner, you can view all Clusters' information retained within the workspace, including Cluster names, runtime, Kubernetes annotations, etc.

##### Clusters Details Page

Clicking on an object in the list pulls out the details page to view detailed information about the Cluster, including name, basic attribute information, Label attributes, and other field attributes.

![](img/10.clusters_2.png)

##### Label Attributes

**Label Attributes** are uploaded automatically with Clusters information. Existing labels can be filtered in the Clusters object list to display Clusters with the same label.

#### Nodes

By selecting the object **Nodes** in the top-left corner, you can view all Nodes' information retained within the workspace, including Node names, status, version, runtime.

##### Nodes Details Page

Clicking on an object in the list pulls out the details page to view detailed information about the Node, including name, basic attribute information, Label attributes, and other field attributes. Supports viewing associated Pods data.

![](img/11.nodes_2.png)

Among them, clicking Kubernetes events allows you to view data associated with `namespace`, `source`, `kind`, `name`. The time control at the top right corner supports customizing the time range for filtering data.

![](img/0810-pods.png)

##### Label Attributes

**Label Attributes** are uploaded automatically with Nodes information. Existing labels can be filtered in the Nodes object list to display Nodes with the same label.

#### Replica Sets

By selecting the object **Replica Sets** in the top-left corner, you can view all Replica Sets' detailed information retained within the workspace, including Replica Set names, runtime, cluster, etc.

##### Replica Sets Details Page

Clicking on an object in the list pulls out the Replica Sets details page to view Replica Sets information, including name, basic attribute information, Label attributes, and other field attributes. Supports viewing associated Pods data.

**Note**: If the Replica Set has an associated field `namespace`, then corresponding metric views for this field can be viewed in the Service details page.

![](img/12.sets_2.png)

Among them, clicking Kubernetes events allows you to view data associated with `namespace`, `source`, `kind`, `name`. The time control at the top right corner supports customizing the time range for filtering data.

![](img/0810-pods.png)

##### Label Attributes

**Label Attributes** are uploaded automatically with Replica Sets information. Existing labels can be filtered in the Replica Sets object list to display Replica Sets with the same label.

#### Jobs

By selecting the object **Jobs** in the top-left corner, you can view all Jobs' information retained within the workspace, including Job names, parallel count, active count, runtime, etc.

##### Jobs Details Page

Clicking on an object in the list pulls out the details page to view detailed information about the Job, including name, basic attribute information, Label attributes, and other field attributes.

![](img/13.jobs_2.png)

##### Label Attributes

**Label Attributes** are uploaded automatically with Jobs information. Existing labels can be filtered in the Jobs object list to display Jobs with the same label.

#### Cron Jobs

By selecting the object **Cron Jobs** in the top-left corner, you can view all Cron Jobs' information retained within the workspace, including Cron Job names, schedule, paused status, active job count, runtime, etc.

##### Cron Jobs Details Page

Clicking on an object in the list pulls out the details page to view detailed information about the Cron Job, including name, basic attribute information, Label attributes, and other field attributes.

![](img/14.cronjobs_2.png)

Among them, clicking Kubernetes events allows you to view data associated with `namespace`, `source`, `kind`, `name`. The time control at the top right corner supports customizing the time range for filtering data.

![](img/0810-pods.png)

##### Label Attributes

**Label Attributes** are uploaded automatically with Cron Jobs information. Existing labels can be filtered in the Cron Jobs object list to display Jobs with the same label.

#### Daemonsets

By selecting the object **Daemonsets** in the top-left corner, you can view all Daemonsets' information retained within the workspace, displaying Daemonset names, desired node count, updated node count, ready node count, runtime, etc.

##### Daemonsets Details Page {#daemonsets}

Clicking on an object in the list pulls out the details page to view Daemonsets' updated node count, ready node count, and other field attributes.

![](img/daemonsets.png)

Among them, clicking Kubernetes events allows you to view data associated with `namespace`, `source`, `kind`, `name`. The time control at the top right corner supports customizing the time range for filtering data.

![](img/0810-pods.png)

##### Label Attributes

**Label Attributes** are uploaded automatically with Daemonsets information. Existing labels can be filtered in the Daemonsets object list to display Daemonsets with the same label.

#### Statefulset {#statefulset}

By selecting the object **Statefulset** in the top-left corner, you can view all Statefulset information retained within the workspace, displaying Statefulset names, cluster, namespace, runtime, ready replica count, running replica count, and desired replica count.

##### Statefulset Details Page 

Clicking on an object in the list pulls out the details page to view Statefulset-related ready replica count, runtime, and other field attributes.

![](img/statefulset.png)

Among them, clicking Kubernetes events automatically views data associated with `source`, `involved_kind`, `involved_namespace`, `involved_name`. The time control at the top right corner supports customizing the time range for filtering data.

![](img/statefulset-1.png)

#### Persistent Volumes {#persistent-volumes}

By selecting the object **Persistent Volumes** in the top-left corner, you can view all Persistent Volumes' information retained within the workspace, displaying Persistent Volume names, cluster, namespace, available count, idle nodes, and capacity.

##### Persistent Volumes Details Page 

Clicking on an object in the list pulls out the details page to view Persistent Volumes-related Pod names and available space.

![](img/persistent-volumes.png)

<!-- 
Among them, clicking Kubernetes events automatically views data associated with `source`, `involved_kind`, `involved_namespace`, `involved_name`. The time control at the top right corner supports customizing the time range for filtering data.

![](img/persistent-volumes-1.png)
-->

### Hex Map {#distribution}

In **Infrastructure > Containers**, when switching the Explorer to the container hex map, you can view the **Containers** and **Kubernetes > Pods** data in a hex map format.

- **Containers** Hex Map: Quickly view the size of container metric values [CPU Usage Rate, MEM Usage Rate, Standardized CPU Usage Rate, Standardized MEM Usage Rate] and analyze the performance state of containers under different projects, services, hosts, images;

- **Pods** Hex Map: Quickly view the restart count of Pods and analyze the performance state of Pods under different projects, services, hosts, Node names, namespaces.

![](img/6.container_1.png)

| Action      | Description                 |
| ----------- | --------------------------- |
| [Search and Filter](../getting-started/function-details/explorer-search.md)      |                  |
| Analyze      | You can reorganize Containers/Pods objects by adding one or more grouping labels.                 |
| Fill      | Customize the selection of fill metrics. The size of the fill metric value will determine the legend color. Includes four fill metrics: CPU Usage Rate, MEM Usage Rate, Standardized CPU Usage Rate, and Standardized MEM Usage Rate.                 |
| Custom Range      | Enable custom legend ranges via **Legend Settings**. Legend colors will be divided into 5 intervals based on the maximum and minimum values, each corresponding to five different colors.                 |
| Hover      | Hover over a container object to view container name, CPU Usage Rate, MEM Usage Rate, Standardized CPU Usage Rate, and Standardized MEM Usage Rate.                 |

## Analysis Dashboard {#analyse}

In **Infrastructure > Containers**, you can switch the Explorer to the **Analysis Dashboard**.

The Analysis Dashboard displays overview charts related to the Kubernetes collection on the same interface, building data insight scenarios through multi-dimensional data analysis. Use view switching, time controls, cluster name/namespace filtering to comprehensively monitor data metrics of different container collections.

![](img/contra_02.png)

### Switch

Default view is the Kubernetes Overview View, supporting dropdown switching to view other object-related analysis dashboards:

- **Kubernetes Overview View**: View the overall system view of the Kubernetes cluster;

- **Kubernetes Services Monitoring View**: View system views related to Services in the Kubernetes cluster;

- **Kubernetes Nodes Monitoring View**: View system views related to Nodes in the Kubernetes cluster;

- **Kubernetes Pods Monitoring View**: View system views related to Pods in the Kubernetes cluster;

- **Kubernetes Event Monitoring View**: View events related to containers in the Kubernetes cluster, including Warning events, Top 10 events, etc. Supports viewing event details, including node unavailability, node restarts, node OOM, image pull failures, volume mount failures, scheduling failures, etc.

**Note**: Built-in views (user views) with the same name as system views take priority in display.


## Further Reading

<font size=3>

<div class="grid cards" markdown>

- [<font color="coral"> :fontawesome-solid-arrow-right-long: &nbsp; View</font>](../scene/built-in-view/index.md)

</div>

<div class="grid cards" markdown>

- [<font color="coral"> :fontawesome-solid-arrow-right-long: &nbsp; Dashboard</font>](../scene/dashboard/index.md)

</div>

</font>