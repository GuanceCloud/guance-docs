# Container

---

## Introduction

  Container data will report to the console after successfully collected. In the Container of the Infrastructure page, you can view the data information of various objects in the inner container of the workspace.

Container data can be viewed and analyzed in two modes. By switching the icon in the upper left corner of the page, you can view:

- **Container Object List**: you can view the Containers, Pods, Services, Deployments, Clusters, Nodes, Replica Sets, Jobs and Cron Jobs data collected in the current workspace **in the last ten minutes** in the form of a list, and retrieve, filter, group and aggregate the data in the list.
- **Container Profile**: you can view the Containers and Pods data of the workspace as a profile and quickly identify the performance status of the Container/pod based on the size of the population data.

## Container Object List

Through the Container object list, you can view the Containers, Pods, Services, Deployments, Clusters, Nodes, Replica Sets, Jobs and Cron Jobs data collected in the current workspace **in the last ten minutes** in the form of a list. It supports you to view Container data by searching keywords, filtering, sorting, etc. And it also supports setting labels for Containers and displaying Container lists with the same labels through label filtering.

### Data Query and Analysis

#### Time Control

The Container object list supports viewing Containers, Pods, Services, Deployments, Clusters, Nodes, Replica Sets, Jobs, Cron Jobs data collected **in the last ten minutes**. The「 :material-refresh: refresh 」button can refresh to the current time range and retrieve the data list again.

#### Search and Filter

In the observer search bar, it supports keyword search, wildcard search, association search, JSON search and other search methods, and it also supports value filtering through `tag/attribute`, including forward filtering, reverse filtering, fuzzy matching, reverse fuzzy matching, existence and nonexistence and other filtering methods. For more searches and filters, refer to the document [search and filter for the observer](../getting-started/necessary-for-beginners/explorer-search.md).

#### Quick Filter

Observer shortcut filter supports editing "shortcut filter" and adding new filter fields. After adding, you can select their field values for quick filtering. For more shortcut filters, please refer to the document [shortcut filters](../getting-started/necessary-for-beginners/explorer-search.md#quick-filter).

#### Custom Display Columns

In the container observer list, you can customize to add, edit, delete and drag display columns through Display Columns. When the mouse is placed on the display column of the observer, click the「 :material-cog: Settings」button, which supports ascending, descending, moving columns to the left, moving columns to the right, adding columns to the left, adding columns to the right, replacing columns, adding to shortcut filtering, adding to analysis (grouping aggregation analysis), removing columns and other operations. See the documentation [display column description](../getting-started/necessary-for-beginners/explorer-search.md#columns) for more custom display columns.

#### Sorting

Click on the list menu, such as: CPU Usage and MEM Usage, you can ascend and descend sort based on the selected label;

#### Analysis Mode

In the analysis bar of infrastructure container observer, multi-dimensional analysis and statistics based on **1-3 tags** are supported to reflect the distribution characteristics of data in different dimensions, and various data chart analysis methods are supported, including ranking list, pie chart and rectangular tree chart. For more details, please refer to the document [analysis Mode for the observer](../getting-started/necessary-for-beginners/explorer-search.md#analysis).

![](img/4.jichusheshi_2.png)

#### Data Export

The" :material-cog: settings" icon in the upper right corner of the observer (next to "display column") supports exporting the current object list data to CSV files or scene dashboards and notes.

- Export to CSV File: Save current list as CSV file locally.

- Export to Dashboard: Save the current list as "Visual Chart" to the specified "Dashboard".
- Export to Notes: Save the current list as "Visual Chart" to specify "Notes".

![](img/container_export1.png)

### Containers List

The "Containers List" supports viewing all container information collected in the workspace, including container name, related host, running status, CPU utilization and MEM utilization.

#### Contrainer Details Page

Click the container name in the Contrainer list to draw the details page to view the details of the container, including container status, container name, container ID, container image and host associated with the container, Pod, log, process and Label tag attributes.

![](img/6.container_3.png)

#### Tag Attribute

The Label property is automatically uploaded with the container information by default. Click on the name in the container object list to underline the details page to view its corresponding Label property. After a container label is added, the list of containers showing the same label can be filtered through the added label in the list of container objects.

![](img/1.container_1.png)

#### Association Analysis
Guance Cloud supports association analysis of each infrastructure object. On the details page of container objects, you can not only understand the basic information of containers, but also associate the metrics, hosts, pods, logs and processes of corresponding containers in one stop, so as to monitor the operation of containers faster and more comprehensively.

=== "Metrics"

    On the Container Details page, you can monitor the performance status of containers **in the last 24 hours** in real time through the "Metrics" in the Details page, and you can select different time ranges for viewing. Click the icon in the upper right corner to edit and save the bound container view in the inner dashboard.
    **Note: If the container is associated with the fields "service", "project" and "namespace", the views corresponding to these three fields can be viewed in container details.**

=== "Host"

    On the Container details page, you are enabled to view the basic information of the relevant host (associated field: host) and the status of the performance metrics **within the selected time component** through the Details page.
    **Note: To view related hosts in Container details, you need to match the field "host", otherwise you cannot view the page of related hosts**.
    - Attribute view: It includes the basic information of the host and the integrated operation. If the collection of cloud hosts is started, the information of cloud vendors can also be viewed.
    - Metric view: You can view the CPU, memory and other performance metric views of related hosts within the default 24 hours. Click "Open This View" to the inner dashboard, and the host view can be customized by cloning and saved as a user view. The user view can be viewed on the container details page through binding. For more configuration details, please refer to [bind inner dashboards](../scene/built-in-view/bind-view.md).
    
    In addition, by clicking the tab "Host" on the container details page, you can do the following:
    
    - "Filter field value", that is, add the field to the observer to view all the data related to the field.
    - "Reverse filter field value", that is, add this field to the observer to view other data besides this field.
    - "Add to display column", that is, add the field to the observer list for viewing.
    - "Copy", that is, copy the field to the clipboard.
    - "View related logs", that is, view all logs related to this host.
    - "View Related Containers", that is, view all containers associated with this host.
    - "View Related Processes", that is, view all processes related to this host.
    - "View Related Links", that is, view all links related to this host.
    - "View Related Inspection", that is, view all inspection data related to this host.
    
    ![Image title](img/21.container_1.png)

=== "Log"

    Through "Log" at the bottom of the details page, you can view the logs and the number of logs related to the container **in the last 1 hour**, and perform keyword search, multi-label filtering and time sorting on these related logs.
    - If you need to view more detailed log information, you can click the log content to jump to the corresponding log details page, or click "Jump" to "Log" to view all logs related to the host.
    - If you need to view more log fields or more complete log contents, you can customize and adjust "Maximum Display Rows" and "Display Columns" through "Display Columns" in the associated log observer.
    **Note: For a smoother user query experience, Guance Cloud saves the user's browsing settings in the "Log" by default (including "Maximum Display Rows" and "Display Columns") in real time, so that the "Association Log" is consistent with the "Log". However, the custom adjustments made in the Association Log are not saved after exiting the page.**

=== "Process"

    On the Container details page, you can quickly view all the processes running in the current container through "Processes" at the bottom of the Details page. To see more detailed process information, you can click the process content to jump to the details page of the corresponding process, or click "Jump" to Process to see all the processes related to the container.

=== "Associated Pod"

    On the Container details page, you are enabled to view the basic information of the relevant Pod (associated field: pod_name) and the status of performance metrics **within the selected time component range** through the details page.
    **Note: To view the relevant Pod in container details, you need to match the field "Pod_name", otherwise you cannot view the page of the relevant Pod in container details.**



### Pods List

Through the object "Pods" in the upper left corner, you can switch to "Pods" to view the information of all Pods left in the space, including Pod name, running status, restart times, startup time and so on.

#### Pod Details Page

Click the Pod name in the Pod list to draw a detailed page to view the detailed information of Pod, including running status, Pod name and Node to which it belongs, Label tag attribute, associated index, associated container, associated log, YAML file, network connection status and associated server running status.

By clicking the tab "Host" on the pod details page, you can query the log, container, process, link, patrol and other data related to the host.

- "Filter Field Value", that is, add the field to the observer to view all the data related to the field.
- "Reverse Filter Field Value", that is, add this field to the observer to view other data besides this field.
- "Add to display column", that is, add the field to the observer list for viewing.
- "Copy", that is, copy the field to the clipboard.
- "View Related Logs", that is, view all logs related to this host
- "View Related Containers", that is, view all containers associated with this host.
- "View Related Processes", that is, view all processes related to this host.
- "View Related Links", that is, view all links related to this host.
- "View Related Inspection", that is, view all inspection data related to this host.

![](img/7.pod_2.png)



#### Tag Attributes

"Label Attribute" is automatically uploaded with Pod information by default. Existing Pod tags can display Pod data of the same tag through quick filtering in the Pod Object List.

![](img/1.container_1.png)



#### Correlation Analysis

 Guance Cloud supports association analysis of each infrastructure object. On the details page of Pod objects, you can not only understand the basic information of Pod, but also associate the metrics, containers, logs, networks and hosts corresponding to Pod in one stop, so as to monitor the operation of Pod faster and more comprehensively.

=== "YAML"

    Support to view yaml files corresponding to Pod. On the details page of infrastructure Pod, click "yaml" to view the corresponding yaml file.
    
    ![Image title](img/1.yaml_1.png)

=== "Metrics"

    Support to view the current pod container performance status, including CPU Cores, CPU utilization and memory.
    **Note: If the Pod is associated with the fields "service", "project" and "namespace", the views corresponding to these three fields can be viewed on the Pod details page.**

=== "Container"

    Support to view the container corresponding to Pod, click the container or click the "Jump" button to the container to view all containers related to the Pod.

=== "Log"

    Through "Log" at the bottom of the details page, you can view the logs and the number of logs related to this Pod **in the last hour**, and perform keyword search, multi-label filtering and time sorting on these related logs.
    - If you need to view more detailed log information, you can click the log content to jump to the corresponding log details page, or click "Jump" to "Log" to view all logs related to the host.
    - If you need to view more log fields or more complete log contents, you can customize and adjust "Maximum Display Rows" and "Display Columns" through "Display Columns" in the associated log observer.
    **Note: For a smoother user query experience, Guance Cloud saves the user's browsing settings in the "Log" by default (including "Maximum Display Rows" and "Display Columns") in real time, so that the "Association Log" is consistent with the "Log". However, the custom adjustments made in the Association Log are not saved after exiting the page.**

=== "Host"

    On the Pod Details page, you can view the basic information of the relevant host (associated field: host) and the status of performance metrics **within the selected time component** through the details page.
    **Note: To view the relevant host in the process details, you need to match the field "host", otherwise you cannot view the page of the relevant host in the process details.**
    - Attribute view: It includes the basic information of the host and the integrated operation. If the collection of cloud hosts is started, the information of cloud vendors can also be viewed.
    - Metric view: You can view the CPU, memory and other performance metric views of related hosts within the default 24 hours. Click "Open This View" to the inner dashboard, and the host view can be customized by cloning and saved as a user view. The user view can be viewed on the Pod Details page through binding. For more configuration details, please refer to [bind inner dashboard](../scene/built-in-view/bind-view.md).

=== "Network"

    Pod Network supports viewing network traffic between Pods. It supports to view the network traffic and data connection between source IP and target IP based on IP/port and display it in real time in a visual way. This helps enterprises know the network running status of business systems immediately, quickly analyze, track and locate problems and faults, and prevent or avoid business problems caused by network performance degradation or interruption.
    
    Pod network data will be reported to the Guance Cloud console after successfully collected. In "Network"-"Infrastructure"-"Container"-"Pod" Details page, you can view all Pod network performance monitoring data information in the workspace. For more details, please refer to [network](network.md).

### Services List

Through the object "Services" in the upper left corner, you can switch to "Services" to view the information of all Services retained in the space, including Service name, Service type, Cluster IP, External IP and runtime.

#### Service Details Page

Click the Service name in the Service list to draw out the details page to view the detailed information of the Service, including name, basic information, Label tag attributes and YAML files.

**Note: If the Service associated field is "namespace", you can view the metric view corresponding to this field on the Service Details page.**

![](img/8.services_1.png)

#### Tag Attributes

The Label property is automatically uploaded with the Service information by default. Existing tags can be displayed in the list of Service objects through quick filtering of the same label Service data.

![](img/1.container_1.png)



### Deployments list

From the object "Deployments" in the upper left corner, you can switch to "Deployments" to see the details of all Deployments left in the space, including Deployment names, available copies, upgraded copies, readiness and run time.

#### Deployment Details Page

Click on the Deployment name in the Deployments list to draw the Details page to view the details of the Deployment, including the name, underlying information, Label tag properties and other field properties. Support for viewing associated logs, Replica Set, Pod and network data.
**Note: If Deployment is associated with the field "namespace", the metric view corresponding to that field can be viewed on the Service Details page.**

![](img/8.deploument_2.png)

#### Tag Attributes

The Label property is automatically uploaded with the Deployment information by default. Existing tags that show Deployment data for the same tags in the list of Deployment objects through quick filtering.

![](img/1.container_1.png)

#### Association Analysis 

=== "YAML"

    Support viewing yaml files corresponding to Deployment. On the details page of Infrastructure Deployment, click "yaml" to view the corresponding yaml file.


=== "Log"

    Through "Log" at the bottom of the details page, you can view the logs and the number of logs related to this Deployment **in the last 1 hour** and perform keyword search, multi-label filtering and time sorting.
    - If you need to view more detailed log information, you can click the log content to jump to the corresponding log details page, or click "Jump" to "Log" to view all logs related to the host.
    - If you need to view more log fields or more complete log contents, you can customize and adjust "Maximum Display Rows" and "Display Columns" through "Display Columns" in the associated log viewer.
    **Note: For a smoother user query experience, Guance Cloud saves the user's browsing settings in the "Log" by default (including "Maximum Display Rows" and "Display Columns") in real time, so that the "Association Log" is consistent with the "Log". However, the custom adjustments made in the Association Log are not saved after exiting the page.**

=== "Pod"

    Support to view the preparation status, restart times and running time of the Pod corresponding to the Deployment. Click the Pod or click the "Jump" button to the Pod to view all Pods related to this Deployment.

=== "Replica Set"

    Support to view the preparation status and running time of Replica Set corresponding to Deployment. Click Replica Set or click "Jump" button to Replica Set to view all Replica Set related to this Deployment.

=== "Network"

    Deployment Network supports viewing network traffic between Deployments. It supports to view the network traffic and data connection between source IP and target IP based on IP/port and display it in real time in a visual way, so as to help enterprises know the network running status of business systems in real time, quickly analyze, track and locate problems and faults, and prevent or avoid business problems caused by network performance degradation or interruption.
    
    Deployment network data will be reported to the Guance Cloud console after successfully collected. You can view the network performance monitoring data information of the current Deployment in "Network"-"Infrastructure"-"Container"-"Pod" Details page. For more details, please refer to [network](network.md).

### Clusters List

With the object "Clusters" in the upper left corner, you can switch to "Clusters" to view all the Clusters information left in the space, including Clusters names, runtime, kubernetes and comments.

#### Clusters Details Page

Click the Clusters name in the Clusters list to draw the details page to view the details of Clusters, including name, basic attribute information, Label tag attribute and other field attributes.

![](img/10.clusters_2.png)



#### Tag Attributes

The Label property is automatically uploaded with Clusters information by default. Clusters data for the same label can be displayed in the Clusters object list by quickly filtering existing labels.

![](img/1.container_1.png)



### Nodes List

Through the object "Nodes" in the upper left corner, you can switch to "Nodes" to view the information of all Nodes left in the space, including Nodes name, status, version and running time.

#### Node Details Page

Click the Node name in the Nodes list to draw the details page to view the details of the Node, including the name, basic attribute information, Label tag attribute and other field attributes. It supports viewing associated Pod data.

![](img/11.nodes_2.png)



#### Tag Attributes

The Label property is automatically uploaded with the Node information by default. Existing tags can display Node data of the same tag through quick filtering in the Node object list.

![](img/1.container_1.png)

### Replica Sets List

From the object "Replica Sets" in the upper left corner, you can switch to "Replica Sets" to view the detailed information of all Replica Sets left in the space, including Replica Set name, long running time and cluster.

#### Replica Set Details Page

Click on the Replica Set name in the Replica Sets list to underline the Replica Set Details page to view the Replica Set information, including the name, underlying attribute information, Label tag attribute and other field attributes. It supports viewing associated Pod data.
**Note: If the Replica Set is associated with the field "namespace", the metric view corresponding to that field can be viewed on the Service Details page.**

![](img/12.sets_2.png)



#### Tag Attributes

The Label property is automatically uploaded with the Replica Set information by default. Replica Set data for the same tag can be displayed in the list of Replica Set objects by quickly filtering existing tags.

![](img/1.container_1.png)



### Jobs List

Through the object "Jobs" in the upper left corner, you can switch to "Jobss" to view the information of all Jobs left in the space, including Job name, parallel number, active number and running time.

#### Job Details Page

Click on the Job name in the Jobs list to draw the details page to view the details of the Job, including the name, basic attribute information, Label tag attribute and other field attributes.

![](img/13.jobs_2.png)



#### Tag Attributes

The Label property is automatically uploaded with Job information by default. Existing tags that show Job data for the same tags in the list of Job objects through quick filtering.

![](img/1.container_1.png)



### Cron Jobs List

Through the object "Cron Jobs" in the upper left corner, you can switch to "Cron Jobs" to view the information of all Cron Jobs left in the space, including Cron Job name, running schedule, whether to pause, number of active jobs and running time.

#### Cron Job Details Page

Click the Cron Job name in the Cron Jobs list to draw the details page to view the details of the Cron Job, including the name, underlying attribute information, Label tag attribute, and other field attributes.

![](img/14.cronjobs_2.png)



#### Tag Attributes

The Label property is automatically uploaded with the Cron Job information by default. Job data for the same label can be displayed in the list of Cron Job objects by quickly filtering existing labels.

![](img/1.container_1.png)



## Container Distribution Map

In "Infrastructure"-"Container", click the small icon of the Container distribution map in the upper left corner to switch the viewer to the Container distribution map, and you can view the "Container" and "Pod" data of the workspace in the form of distribution map.

In the "Container" profile, you can quickly view the size of Container metrics (CPU utilization, MEM utilization) and analyze the Container performance status under different projects, services, hosts and images.

In the "pod" profile, you can quickly view the restart times of pod, and analyze the performance status of pod under different projects, different services, different hosts, different Node names and different namespaces.

![](img/6.container_1.png)

- Search and filtering: In the viewer search bar, it supports keyword search, wildcard search, association search, JSON search and other search methods, and supports value filtering through `tags/attributes`, including forward filtering, reverse filtering, fuzzy matching, reverse fuzzy matching, existence and nonexistence and other filtering methods. For more searches and filters, refer to the document [search and filter for observer](../getting-started/necessary-for-beginners/explorer-search.md).
- Analysis: You can recombine the Container/pod object by adding one or more grouping tags.
- Fill: You can customize the selection of fill metrics, and the size of the fill metric value will determine the legend color of the fill. Support the selection of CPU utilization rate and MEM utilization rate.
- Custom range: You can open custom legend range through Legend Settings. Legend colors will be divided into five intervals according to the maximum and minimum values of the legend, and each interval will automatically correspond to five different colors.
- Mouse Hover: Hover the mouse over the container object to see the container name, CPU usage and MEM usage.
