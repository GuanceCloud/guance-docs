# Containers

---

After the successful collection of container data, it will be reported to the console. Go to **Infrastructure > Containers** to view the data information of various containers.

## Explorer

There are two modes for viewing and analyzing container data. You can switch between them using the icons on the top left corner of the page: :octicons-list-unordered-24: and :material-hexagon-multiple-outline:. You can view:

- [View list](#object);
- [View map](#distribution).

### Container List {#object}

You can view the container data collected in the current workspace in a collection form and further query and analyze the container data. You can also set tags for containers to filter and display a list of containers with the same tag.

- **[Containers](#containers)**: You can view all the container information collected in the workspace.

- **Kubernetes Collection**: You can view information about Pods, Services, Deployments, Clusters, Nodes, Replica Sets, Jobs, Cron Jobs and Daemonsets collected in the workspace.

![](img/contra_01.png)

#### Query and Analysis 

- Time Widget: The container list supports viewing data collected in the last ten minutes. You can refresh the data list to the current time range by clicking the :material-refresh: button.

- [Search and Filter](../getting-started/function-details/explorer-search.md): You can use various search methods such as keyword search and wildcard search. You can also filter values by `tags/attributes`, including forward and reverse filtering, fuzzy and reverse fuzzy matching, existence and non-existence.

- [Quick Filter](../getting-started/function-details/explorer-search.md#quick-filter): Edit in the quick filter to add new filtering fields and then you can select them for quick filtering.

- [Columns](../getting-started/function-details/explorer-search.md#columns): On the host object list page, you can customize the display columns by adding, editing, deleting and dragging the display columns.

- [Analysis Mode](../getting-started/function-details/explorer-search.md#analysis): You can perform multidimensional analysis and statistics based on <u>1-3 tags</u> to reflect the distribution characteristics of data in different dimensions. It supports various data chart analysis methods, including toplist, pie charts and treemaps.

- Sorting: You can click on the list menu, such as CPU Usage, MEM Usage, to sort based on the selected tag.        

- Data Export: click :material-cog:, you can:
    
    - Export to CSV file: Save the current list as a CSV file locally.
    
    - Export to Dashboard/Note: Save the current list as visual charts to a specified dashboard/note.

To export a specific data entry, open the details page of that data and click the :material-tray-arrow-up: in the upper right corner.   


#### Containers List {#containers}

You can view all the container information collected in the workspace, including container name, related host, running status, CPU usage, MEM usage, etc.

##### Details Page

Clicking on the container name in the Containers list will slide out the details page to view detailed information about the container, including container status, container name, container ID, container image, associated host, Pod, logs, processes, and label attributes.

![](img/6.container_3.png)

##### Label

The container labels are automatically uploaded with the container information. After adding container labels, you can filter and display a list of containers with the added labels in the container list.


##### Association Analysis {#association-analysis}

Guance supports association analysis for each infrastructure type. In the details page of the container, in addition to the basic information of the container, you can also have a one-stop understanding of the associated metrics, hosts, Pods, logs, and processes related to the container, enabling you to monitor the container's running status faster and more comprehensively.

<div class="grid" markdown>

=== "Metrics"

    You can monitor the performance status of the container in real-time for the last 24 hours. You can select different time ranges for viewing. Click the icon in the upper right corner to customize and save the container view in the inner view.

    **Note**: If the container is associated with the fields `service`, `project`, `namespace`, you can view the views corresponding to these three fields in the container details.

=== "Host"

    You can view the basic information and performance metrics of the associated host (`host`) within the selected time range in the container details.

    **Note**: To view the associated host in the container details, the field `host` needs to be matched, otherwise, you will not be able to view the page of the associated host in the container details.

    - Attribute View: Includes basic host information, integration status, and cloud provider information if cloud host collection is enabled;

    - Metrics View: You can view the performance metrics of the associated host, such as CPU and memory, for the default last 24 hours. Click **Open this view** to go to the [inner view](../scene/built-in-view/bind-view.md) to customize and save the host view as a user view. The user view can be viewed by binding it in the container details.

    In addition, by clicking the **Host** label on the container details page, you can perform the following operations:

    | Operate | Description |
    | --- | --- |
    | Filter field value | Add the field to the explorer to view all the data related to the field. |
    | Reverse filter field value | Add this field to the explorer to view other data besides this field. |
    | Add to display column | Add the field to the explorer list for viewing. |
    | Copy | Copy the field to the clipboard.  |
    | View related logs/containers/processes/links/inspection | view all logs/containers/processes/links/inspection related to this host. |

    
    ![Image title](img/21.container_1.png)

=== "Logs"

    You can view the logs of the container for the last hour and the number of logs. You can perform keyword search, multi-tag filtering, and time sorting on these related logs.

    - To view more detailed log information: You can click on the log content to jump to the corresponding log details page or click to jump to **Logs** to view all logs related to the host;

    - To view more log fields or complete log content: You can customize the "Maximum Display Rows" and "Display Columns" through the associated log viewer **Display Columns**.

    **Note**: To provide a smoother user query experience, Guance saves the user's browsing settings in **Logs** in real-time (including "Maximum Display Rows" and "Display Columns") to keep the **Associated Logs** consistent with **Logs**. However, any customizations made in **Associated Logs** will not be saved after leaving the page.


=== "Processes"

    You can quickly view all the processes currently running in the container.

    To view more detailed process information, you can click on the process content to jump to the corresponding process details page or click to jump to the processes page to view all processes related to the container.


=== "Associated Pods"

    You can view the basic information and performance metrics of the associated Pods (`pod_name`) within the selected time range in the container details.

    **Note**: To view the associated Pods in the container details, the field `pod_name` needs to be matched, otherwise, you will not be able to view the page of the associated Pods in the container details.

</div>


#### Pods List {#pods}

By clicking on the Pods in the upper left corner, you can switch to Pods and view all the information about the Pods retained in the workspace, including the Pod name, running status, restart count and start time.

##### Details Page

Clicking on the Pods name in the Pods list will slide out the details page to view detailed information about the Pods, including running status, Pods name, associated node, attributes, associated metrics, associated containers, associated logs, YAML file, network connection status, associated server running status and associated kubernetes.

By clicking the **Host** label on the Pods details page, you can query the logs, containers, processes, links, and inspections related to that host.

| Operate | Description |
| --- | --- |
| Filter field value | Add the field to the explorer to view all the data related to the field. |
| Reverse filter field value | Add this field to the explorer to view other data besides this field. |
| Add to display column | Add the field to the explorer list for viewing. |
| Copy | Copy the field to the clipboard.  |
| View related logs/containers/processes/links/inspection | view all logs/containers/processes/links/inspection related to this host. |

![](img/7.pod_2.png)



##### Label

**Labels** are automatically uploaded with the Pods information. Existing Pods labels can be used to filter and display Pods data with the same tag in the Pods object list.


##### Association Analysis

In the Pods object details page, you can not only understand the basic information of the Pods but also have a one-stop association with the corresponding Pods. You can quickly and comprehensively monitor the Pods running status by viewing the associated metrics, containers, logs, network, and hosts related to the Pods.

Clicking on kubernetes logs/events allows you to view the corresponding data associated with `namespace`, `source`, `kind` and `name`.

Clicking on the time widget in the upper right corner allows you to customize the time range to filter the data.


![](img/0810-pods.png)

#### Services List

By clicking on Services in the upper left corner, you can view all the information about the Services retained in the workspace, including the Services name, service type, Cluster IP, External IP, running time, etc.

##### Details Page

Clicking on the Services name in the list will slide out the details page to view detailed information, including the name, basic information, label attributes, YAML file, etc.

**Note**: If Services are associated with the field `namespace`, you can view the corresponding metric view for this field in the Services details.

![](img/8.services_1.png)

##### Label

Labels are automatically uploaded with the Services information. Existing labels can be used to filter and display Services data with the same labels in the Services object list.

##### kubernetes Events

Clicking on the kubernetes events allows you to view the corresponding data associated with `namespace`, `source`, `kind` and `name`.

Clicking on the time widget in the upper right corner allows you to customize the time range to filter the data.

![](img/0810-pods.png)

#### Deployments List

By selecting Deployments in the upper left corner, you can view detailed information about all the Deployments in the workspace, including Deployment name, available replicas, upgraded replicas, runtime, etc.

##### Details Page

Clicking on the Deployment name in the list will bring up the details page where you can view detailed information about the Deployment, including name, basic information, label properties, and other field properties. You can view associated logs, Replica Sets, Pods, network data and related Kubernetes information.

**Note**: If the Deployment is associated with the field `namespace`, you can view the corresponding metric view of that field on the details page.

![](img/8.deploument_2.png)

##### Label

The Label is automatically uploaded with the Deployment information. Existing labels can be displayed in the Deployments list by using the quick filter to show Deployments with the same labels.


##### Associated Analysis 

<div class="grid" markdown>

=== "YAML"

    You can view the YAML file corresponding to the Deployment. On the details page, click YAML to view the corresponding YAML file.


=== "日志"

    通过详情页下方的**日志**，您可以查看与该 Deployments 相关的<u>最近 1 小时</u>的日志及日志数量，并对这些相关日志进行关键字搜索、多标签筛选和时间排序等。

    - 如您需查看更详细的日志信息：可点击日志内容跳转到对应日志详情页面，或点击跳转至**日志**查看与该主机相关的全部日志;
    
    - 如需查看更多的日志字段或更完整的日志内容：可通过关联日志查看器**显示列**自定义调整“最大显示行数”、“显示列”。
    
    **注意**：为了更流畅的用户查询体验，观测云默认即时保存用户在**日志**的浏览设置（包括“最大显示行数”、“显示列”），以使**关联日志**与**日志**保持一致。然而，在**关联日志**进行的自定义调整，在退出页面后不做保存。

=== "Pods"

    支持查看 Deployments 对应 Pods 的准备状态、重启次数、运行时长等，点击 Pods 或点击跳转按钮至 Pods 查看与本 Deployments 相关的全部 Pods。

=== "Replica Set"

    支持查看 Deployments 对应 Replica Sets 的准备状态、运行时长等，点击 Replica Sets 或点击跳转按钮至 Replica Sets 查看与本 Deployments 相关的全部 Replica Set。

=== "网络"

    Deployments 网络支持查看 Deployments 之间的网络流量。支持基于 IP/端口查看源 IP 到目标 IP 之间的网络流量和数据连接情况，通过可视化的方式进行实时展示，帮助企业实时了解业务系统的网络运行状态，快速分析、追踪和定位问题故障，预防或避免因网络性能下降或中断而导致的业务问题。
    
    Deployments 网络数据采集成功后会上报到观测云控制台，您可以在**基础设施 > 容器 > Pods**详情页中的**[网络](network.md)**，查看当前 Deployments 的网络性能监测数据信息。

=== "kubernetes 日志/事件"

    点击 kubernetes 日志/事件点击 kubernetes 事件可查看 `namespace`、`source`、`kind`、`name` 关联的对应数据。

    点击右上角时间控件，可自定义时间范围筛选数据。

    ![](img/0810-pods.png)

#### Clusters 列表

通过左上角的对象 **Clusters** ，您可以切换至 **Clusters** 查看空间内留存的全部 Clusters 的信息，包括 Clusters 名称、运行时间、kubernetes 注释等。

##### Clusters 详情页

点击 Clusters 列表中的 Clusters 名称即可划出详情页查看 Clusters 的详细信息，包括名称、基础属性信息、Label 属性和其他字段属性。

![](img/10.clusters_2.png)



##### Label

**Label 属性**随 Clusters 信息默认自动上传。已有的标签，可在 Clusters 对象列表通过快捷筛选展示相同标签的 Clusters 数据。


#### Nodes 列表

通过左上角的对象 **Nodes** ，您可以切换至 **Nodes** 查看空间内留存的全部 Nodes 的信息，包括 Nodes 名称、状态、版本、运行时间。

##### Nodes 详情页

点击 Nodes 列表中的 Nodes 名称即可划出详情页查看 Nodes 的详细信息，包括名称、基础属性信息、Label 属性和其他字段属性。支持查看关联的 Pods 数据。

![](img/11.nodes_2.png)

其中，点击 kubernetes 事件可查看 `namespace`、`source`、`kind`、`name` 关联的对应数据。右上角时间控件支持自定义时间范围筛选数据。

![](img/0810-pods.png)


##### Label

**Label 属性**随 Nodes 信息默认自动上传。已有的标签，可在 Nodes 对象列表通过快捷筛选展示相同标签的 Nodes 数据。


#### Replica Sets 列表

通过左上角的对象 **Replica Sets** ，您可以切换至 **Replica Sets** 查看空间内留存的全部 Replica Sets 的详尽信息，包括 Replica Sets 名称、运行时间长，集群等。

##### Replica Sets 详情页

点击 Replica Sets 列表中的 Replica Sets 名称即可划出 Replica Sets 详情页查看 Replica Sets 的信息，包括名称、基础属性信息、 Label 属性和其他字段属性。支持查看关联的 Pods 数据。

**注意**：若 Replica Sets 关联字段 `namespace`，则可以在 Services 详情页查看该字段对应的指标视图。


![](img/12.sets_2.png)

其中，点击 kubernetes 事件可查看 `namespace`、`source`、`kind`、`name` 关联的对应数据。右上角时间控件支持自定义时间范围筛选数据。

![](img/0810-pods.png)


##### Label

**Label 属性**随 Replica Sets 信息默认自动上传。已有的标签，可在 Replica Sets 对象列表通过快捷筛选展示相同标签的 Replica Sets 数据。


#### Jobs 列表

通过左上角的对象 **Jobs**，您可以切换至 **Jobs** 查看空间内留存的全部 Jobs 的信息，包括 Jobs 名称、并行数量、活跃数、运行时间等。

##### Jobs 详情页

点击 Jobs 列表中的 Jobs 名称即可划出详情页查看 Jobs 的详细信息，包括名称、基础属性信息、Label 属性和其他字段属性。

![](img/13.jobs_2.png)



##### Label

**Label 属性**随 Jobs 信息默认自动上传。已有的标签，可在 Jobs 对象列表通过快捷筛选展示相同标签的 Jobs 数据。


#### Cron Jobs 列表

通过左上角的对象 **Cron Jobs** ，您可以切换至 **Cron Jobs** 查看空间内留存的全部 Cron Jobs 的信息，包括 Cron Jobs 名称、运行日程、是否暂停、Jobs 活跃数量、运行时间等。

##### Cron Jobs 详情页

点击 Cron Jobs 列表中的 Cron Jobs 名称即可划出详情页查看 Cron Jobs 的详细信息，包括名称、基础属性信息、 Label 属性和其他字段属性。

![](img/14.cronjobs_2.png)

其中，点击 kubernetes 事件可查看 `namespace`、`source`、`kind`、`name` 关联的对应数据。右上角时间控件支持自定义时间范围筛选数据。

![](img/0810-pods.png)

##### Label

**Label 属性**随 Cron Jobs 信息默认自动上传。已有的标签，可在 Cron Jobs 对象列表通过快捷筛选展示相同标签的 Jobs 数据。


#### Daemonsets 列表

通过左上角的对象 **Daemonsets**，您可以切换至 **Daemonsets** 查看空间内留存的全部 Daemonsets 的信息，默认显示 Daemonsets 名称、期望节点数、更新节点数、准备就绪节点数、运行时长等。

##### Daemonsets 详情页 {#daemonsets}

点击 Daemonsets 列表中的 Daemonsets 名称即可划出详情页查看 Daemonsets 更新节点数、准备就绪节点数和其他字段属性。

![](img/daemonsets.png)

其中，点击 kubernetes 事件可查看 `namespace`、`source`、`kind`、`name` 关联的对应数据。右上角时间控件支持自定义时间范围筛选数据。

![](img/0810-pods.png)

##### Label

**Label 属性**随 Daemonsets 信息默认自动上传。已有的标签，可在 Daemonsets 对象列表通过快捷筛选展示相同标签的 Daemonsets 数据。



### 蜂窝图 {#distribution}

在**基础设施 > 容器**，切换查看器至容器蜂窝图时，您可以对工作空间的 **Containers** 和 **Kubernetes > Pods** 数据以蜂窝图形式进行查看。

- **Containers** 蜂窝图：可快速查看容器指标值（CPU 使用率、MEM 使用率）的大小，并分析不同项目、不同服务、不同主机、不同镜像下的容器性能状态；

- **Pods** 蜂窝图：可快速查看 Pods 的重启次数，并分析不同项目、不同服务、不同主机、不同 Nodes 名称、不同命名空间下的 Pods 性能状态。

![](img/6.container_1.png)

| 操作      | 说明                 |
| ----------- | ---------------- |
| [搜索和筛选](../getting-started/function-details/explorer-search.md)      |                  |
| 分析      | 您可以通过添加一个或多个分组标签重新组合 Containers/Pods 对象。                 |
| 填充      | 您可以自定义选择填充指标，填充指标值的大小将决定填充的图例颜色。您可以选择 CPU 使用率和 MEM 使用率两种指标填充方式。                 |
| 自定义区间      | 您可以通过 **图例设置** 开启自定义图例范围。图例的颜色将依据图例的最大和最小值等分为 5 个区间，每个区间将自动对应五个不同的颜色。                 |
| 鼠标悬停      | 悬停鼠标至容器对象，可查看容器名称、CPU 使用率和 MEM 使用率。                 |

## 分析看板 {#analyse}

在**基础设施 > 容器**，可切换查看器至**分析看板**。

分析看板将 Kubernetes 集合相关的概览图表同时展示在同一界面，通过多维度数据分析构建数据洞察场景。借助视图切换、时间控件、集群名称/命名空间过滤等方式全面监控不同容器集合的数据指标。

![](img/contra_02.png)

### 切换

默认查看工作空间 Kubernetes 总览视图，支持下拉切换查看其他对象相关分析看板：

- **Kubernetes 总览视图**：可查看 Kubernetes 集群下的总览系统视图；

- **Kubernetes Services 监控视图**：可查看 Kubernetes 集群下的 Services 相关的系统视图；

- **Kubernetes Nodes 监控视图**：可查看 Kubernetes 集群下的 Nodes 相关的系统视图；

- **Kubernetes Pods 监控视图**：可查看 Kubernetes 集群下的 Pods 相关的系统视图；

- **Kubernetes Event 监控视图**：可查看 Kubernetes 集群下的容器相关的事件，包括 Warnning 事件、事件 Top 10 等相关信息；支持查看事件详情信息，包括节点不可用、节点重启、节点 OOM、镜像拉取失败、卷挂载失败、调度失败等异常事件的统计视图。

**注意**：支持与系统视图同名的内置视图（用户视图）优先显示。


## 更多阅读

<div class="grid cards" markdown>

- [<font color="coral"> :fontawesome-solid-arrow-right-long: &nbsp; 视图</font>](../scene/built-in-view/index.md)

</div>


<div class="grid cards" markdown>

- [<font color="coral"> :fontawesome-solid-arrow-right-long: &nbsp; 仪表板</font>](../scene/dashboard.md)

