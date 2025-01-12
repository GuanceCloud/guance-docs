# 主机
---


主机数据采集成功后会主动上报到观测云控制台。进入**基础设施 > 主机**，您可以查看到所采集到的全部主机数据信息。

观测云的主机数据有两种查看和分析模式，通过切换页面左上角查看器，您可以查看以下页面：

- **主机对象列表**：您可以查看当前空间每个主机<u>最近 24 小时内</u>的数据信息，包括主机名称及标签、主机的 CPU 使用率、MEM 使用率，CPU 负载等；

- **主机拓扑图**：您可以以拓扑图的方式快速查看主机指标值的大小，并分析不同系统、不同状态、不同版本、不同地区等的主机的运行状态。

## 主机对象列表

通过主机对象列表，您可以查看当前空间每个主机<u>最近 24 小时内</u>的数据信息，包括主机状态、主机名称、主机的 CPU 使用率、MEM 使用率，CPU 负载等；支持为主机设置标签，并通过添加的标签筛选展示相同标签的主机列表。


![](img/7.host_detail_1.png)

主机对象指标数据支持升降排序：

<img src="../img/host-queue.png" width="60%" >

**注意**：因数据入库存在延迟，该指标非实时更新，每 5 分钟统计一次最近 15 分钟的平均值，因此数据可能会存在偏差。

### 仅显示在线主机 {#online}

观测云为方便您快速识别主机状态，新增【仅显示在线主机】开关过滤，支持选择查看现在所有上报的主机对象数据列表，也可查看在线的主机列表。

- **仅显示在线主机**开启后，仅列出最近 10 分钟有数据上报的主机列表。

**注意**：

- 若主机超过 10 分钟数据断档上报，此时 CPU 使用率、MEM 使用率、CPU 负载均不作显示，值填充为 “-”；

- 若主机超过 24 小时仍未有数据上报，该主机记录将会在列表中移除。

<img src="../img/host-status.png" width="60%" >

### 主机标签 {#label}

面对多个主机的管理环境，观测云支持为每一台主机自定义标签，基于主机设置 Label 属性标签，可以用于数据归类筛选查询。通过点击主机对象列表中的主机名称，您可以在划出[详情页](#details)中为主机添加标签。

操作步骤如下：

![](img/7.host_label_1.png)

1）点击**编辑 Label**；

2）输入 Label 标签，回车确认后可继续添加；

3）添加完成后，点击保存即可；

**注意**：标签配置完成后需要等待 1-5 分钟后生效。

4）主机 Label 标签添加完成后，支持两种显示方式：“1 行”和“全部”。在主机列表，点击**显示列**，即可切换 Label 的显示行数。

![](img/7.host_label_3.png)

### 查询与分析


- [时间控件](../getting-started/function-details/explorer-search.md#time)：主机对象列表默认为您展示最近 24 小时的主机数据；可刷新至当前时间范围，重新获取数据列表。

- [搜索与筛选](../getting-started/function-details/explorer-search.md)：在查看器搜索栏，支持关键字搜索、通配符搜索等多种搜索方式；支持通过 `标签/属性` 进行值的筛选，包括正向筛选、反向筛选等多种筛选方式。

- DQL 支持 **now() 函数**查询过滤：可获取当前查询时间，还支持通过 `+` ` -` 方式计算最新的时间与当前时间做比较。

- [快捷筛选](../getting-started/function-details/explorer-search.md#quick-filter)：在快捷筛选进行编辑，添加新的筛选字段。添加完成后，可以选择其字段值进行快捷筛选。

<img src="../img/quickfilter.png" width="60%" >

- [自定义显示列](../getting-started/function-details/explorer-search.md#columns)：可通过**显示列**自定义添加、编辑、删除、拖动显示列。

- [分析模式](../getting-started/function-details/explorer-search.md#analysis)：支持基于 <u>1-3 个标签</u>进行多维度分析统计，以反映出数据在不同维度下的分布特征，支持多种数据图表分析方式，包括排行榜、饼图和矩形树图。


<img src="../img/4.jichusheshi_1.png" width="60%" >

- 设置：点击查看器右上角的 :material-cog: 设置图标，您可进行以下操作：

    - 新建监控器：若发现当前主机数据存在异常情况，可一键创建监控器；

    - 导出到 CSV 文件：保存当前列表为 CSV 文件到本地；

    - 导出到仪表板/笔记：保存当前列表为可视化图表到指定仪表板/笔记。

<img src="../img/21.host_1.png" width="70%" >


## 主机详情 {#details}

在主机对象列表中，点击主机名即可侧滑出主机详情页。您可以在主机详情页中查看对应主机基本信息、扩展属性、关联信息以及绑定的视图。

![](img/7.host_detail_6.png)

如果需要导出某条主机数据，点击右上角 :material-tray-arrow-up: 图标即可。

![](img/host-0809.png)

### 基本信息

在主机详情页的基本信息，您可以为该主机添加[主机标签](#label)、查看集成运行情况（包括 DataKit 版本）、系统信息以及云厂商信息。

#### 集成运行情况

**集成运行情况**展示了该主机安装的 DataKit 版本信息和相关的采集器运行情况，运行情况共有两种状态：

- 正常运行状态的采集器，默认展示为 ”浅蓝色“；

- 发生错误的采集器，默认展示为 “红色” 且支持点击查看错误信息。

同时，带视图符号 :fontawesome-solid-chart-simple: 的采集器支持查看监控视图：

![](img/7.host_detail_2.png)

#### 系统信息

在主机详情页可查看主机的系统信息，包括主机名称、操作系统、处理器、内存，网络，磁盘、连接跟踪、文件等。

![](img/7.host_detail_3.png)

#### 云厂商信息

若主机是云主机且配置了[云同步](../integrations/hostobject.md#cloudinfo)，您可查看包括云平台、实例名、实例 ID、实例规格、地域、可用区、创建时间、网络类型、付费类型、IP 地址等信息。

![](img/7.host_detail_4.png)

### 扩展属性

您可以查看相关主机的全部属性；支持通过字段名或值做搜索过滤，缩小查看范围。

![](img/7.host_detail_5.png)

Hover 至对应字段的值，可显示其原始格式。

<img src="../img/value.png" width="60%" >

### 关联分析

观测云支持对每一个基础设施对象进行关联分析，除了主机的基本信息，您还可以一站式地了解主机对应的指标、日志、进程、事件、容器、网络、安全巡检等，更快更全面地监测主机运行情况。

<img src="../img/9.host_4.png" width="60%" >

<div class="grid" markdown>

=== "指标"

    您可实时监控主机<u>最近 24 小时内</u>的性能状态，包括 CPU 负载、内存使用等。

    <img src="../img/host-metric.png" width="60%" >

=== "日志"

    您可以查看与该主机相关的<u>最近 1 小时</u>的日志及日志数量。
     
    **注意**：为了更流畅的用户查询体验，观测云默认即时保存用户在日志的浏览设置（包括“最大显示行数”、“显示列”），以使**关联日志**与日志保持一致。然而，在关联日志进行的自定义调整，在退出页面后不做保存。

    <img src="../img/host-log.png" width="60%" >

    > 更多页面操作，可参考 [日志查看器](../logs/explorer.md)。

=== "进程"

    您可以查看与该主机相关的<u>最近 10 分钟</u>的进程及进程数量。
    
    <img src="../img/host-process.png" width="60%" >

=== "事件"

    您可以查看与该主机相关的<u>最近 1 小时</u>的告警事件（关联字段：`host`）。
    
    <img src="../img/host-event.png" width="60%" >

=== "容器"

    您可以查看<u>最近 10 分钟内</u>与该主机相关的全部容器数据。
    
    <img src="../img/host-container.png" width="60%" >

=== "安全巡检"

    您可以查看<u>最近 1 天内</u>与该主机相关的安全巡检数据。

    <img src="../img/host-intecheck.png" width="60%" >

=== "网络"

    主机网络支持查看主机之间的网络流量。支持基于服务端、客户端查看源主机到目标之间的网络流量和数据连接情况，通过可视化的方式进行实时展示，帮助企业实时了解业务系统的网络运行状态，快速分析、追踪和定位问题故障，预防或避免因网络性能下降或中断而导致的业务问题。
    
    主机网络数据采集成功后会上报到观测云控制台，您可以通过**基础设施 > 主机**详情页中的网络，以**拓扑**、**总览**两种形式查看主机的网络性能监测数据信息。
    
    > 更多详情，可参考 [网络](network.md)。

    <img src="../img/host-net.png" width="60%" >

</div>


### 静默主机 {#mute}

在主机详情页，点击**静默主机**，即可对该主机设置静默，静默时间包含**仅一次**和**重复**，可按需选择。

![](img/3.host_15.png)

配置完成后，回到主机列表，在您设置的静默时间内，您在该时间里将不再收到与该主机相关的告警通知，产生的告警事件会存入事件管理。所有静默的主机列表可在**监控 > 静默管理**中查看。

> 更多详情，可参考[告警设置](../monitoring/alert-setting.md)。

**注意**：当您在某特定主机的详情页中设置了静默主机，且在**监控 > [静默管理](../monitoring/silent-management.md)** 中对该台主机设置了同样的静默规则，则该主机在**基础设施 > 主机**列表会出现静默图标。

![](img/mute.png)

### 绑定内置视图 {#view}

观测云支持设置绑定内置视图（用户视图）到主机详情页面。点击绑定内置视图，可查看默认携带的关联字段。您可以选择是否保留该字段，还可添加新的 `key:value` 字段。

![](img/view.png)

在绑定内置视图 > 视图，您可以选择添加多个视图：

<img src="../img/view-2.png" width="60%" >

完成内置视图的绑定后，在主机对象详情中可查看所绑定的内置视图，并通过点击跳转按钮 :material-arrow-right-top-bold: 至对应的内置视图页面，对该内置视图进行编辑、复制和导出。

![](img/view-3.png)

**注意**：当[绑定了内置视图](../scene/built-in-view/bind-view.md)，若打开的当前数据不包含视图内所关联的字段，则在该条数据的详情页不显示该视图。反之显示。

<!--
![](img/4.view_bang_4.png)
-->



## 主机拓扑图

通过**主机拓扑图**，您能够可视化查询主机的指标数据大小，进而快速分析不同系统、不同状态、不同版本、不同地区等自定义标签下的主机的运行状态。

- [搜索与筛选](../getting-started/function-details/explorer-search.md)；

- 分析：您可以通过添加一个或多个分组标签重新聚合主机对象；

- 填充：您可以通过**填充**自定义填充指标，填充指标值的大小将决定填充的图例颜色。支持选择 CPU 使用率、MEM 使用率、CPU 负载三种指标填充方式；

- 自定义区间：您可以开启**自定义区间**为选择的填充指标自定义图例颜色区间范围。图例的颜色将依据图例的最大和最小值等分为五个区间，每个区间将自动对应五个不同的颜色；

- 鼠标悬停：Hover 至主机对象，可查看主机的名称、CPU 使用率和 MEM 使用率。

![](img/3.host_2.2.png)
