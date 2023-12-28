# 图表链接
---

## 简介

观测云支持图表内置关联链接和自定义关联链接，可以帮助您实现从当前图表跳转至目标页面，并通过模板变量中对应的变量值传送数据信息，实现数据联动。

## 变量说明

观测云支持 4 种模板变量，分别为<u>时间变量、标签变量、视图变量和值变量</u>。

### 时间变量

| 变量 | 说明 |
| --- | --- |
| #{TR} | 当前图表查询的时间范围。假设当前查询时间是 `最近1小时` ，则：<br />模板变量：`&time=#{TR}` 等同为 `&time=1h`  |
| #{timestamp.start} | 当前图表查询所选数据点的开始时间。  |
| #{timestamp.end} | 当前图表查询所选数据点的结束时间。  |

### 标签变量

| 变量 | 说明 |
| --- | --- |
| #{T} | 当前图表查询的所有分组标签集合。假设当前图表查询为：<br />`M::'datakit':(LAST('cpu_usage'))  BY 'host','os'`<br />查询结果为：host=abc、os=linux，则：<br />模板变量：`&query=#{T} `等同为 `&query=host:abc os:linux` |
| #{T.name} | 当前图表查询中某一个标签的值，name 可替换为查询中的任意tagKey。<br />假设当前图表查询为：<br />`M::'datakit':(LAST('cpu_usage')) BY 'host', 'os'`<br />查询结果为：host=abc、os=linux，则：<br /><li>模板变量 `#{T.host} = abc`<br /><li> `&query=hostname:#{T.host}` 等同为 `&query=hostname:abc` |

### 视图变量

| 变量 | 说明 |
| --- | --- |
| #{V} | 当前仪表板中所有视图变量的集合 <br />假设当前仪表板的视图变量为：<br />version=V1.7.0 和 region=cn-hangzhou<br />模板变量` &query=#{V}  `等同为 `&query=version:V1.7.0 region:cn-hangzhou` |
| #{V.name} | 当前仪表板中某一个视图变量的值，name 可替换为任意变量名。<br />假设当前仪表板的视图变量 version=V1.7.0，则：<br /><li> 模板变量  `#{V.version} = V1.7.0`<br /><li> `&query=version:#{V.version}` 等同为 `&query=version:V1.7.0`<br /> |

### 值变量 {#z-variate}

| 图表类型 | <div style="width: 130px">变量</div> | 说明 |
| --- | --- | --- |
| 时序图、概览图、饼图、柱状图、排行榜、仪表板、漏斗分析 | #{Value} | 当前图表查询返回的数据值变量。假设当前图表查询 `M::cpu:(AVG(load5s))` 查询结果为`a`，则：<br />值变量：`&query=#{Value}` 等同为 `&query=a` |
| 散点图 | #{Value.X} | 当前图表查询返回的 X 轴数据值变量。假设当前图表查询为：<br />`M::cpu:(AVG(load5s))`<br />查询结果为：X=abc，则：<br />值变量：`&query=#{Value.X} `等同为 `&query=X:abc` |
|  | #{Value.Y} | 当前图表查询返回的 Y 轴数据值变量。<br />假设当前图表查询为：<br />`M::backuplog:(AVG(lru_add_cache_success_count))`<br />查询结果为：Y=dca，则：<br />值变量 `&query=Y:#{Value.Y}` 等同为 `&query=Y:dca` |
| 气泡图 | #{Value.X} | 当前图表查询返回的 X 轴数据值变量。假设当前图表查询为：<br />`T::RE(.*):(FIRST(duration)) BY service`<br />查询结果为：X:first(duration)=98，则：<br />值变量：`&query=X:#{Value.X} `等同为 `&query=X:98` |
|  | #{Value.Y} | 当前图表查询返回的 Y 轴数据值变量。<br />假设当前图表查询为：<br />`T::RE(.*):(LAST(duration)) BY service`<br />查询结果为：Y:last(duration)=8500，则：<br />值变量 `&query=Y:#{Value.Y}` 等同为 `&query=Y:8500` |
|  | #{Value.Size} | 当前图表查询返回的 Size 数据值变量。<br />假设当前图表查询为：<br />`T::RE(.*):(MAX(duration)) BY service`<br />查询结果为：Size:Max(duration)=1773，则：<br />值变量 `&query=Size:#{Value.Size}` 等同为 `&query=Size:1773` |
| 表格图 | #{Value.column_name} | 当前图表选中的列值变量，name 可替换为任意列变量名。<br />假设当前图表查询为：<br />`M::cpu:(*)`<br />查询结果为：usage_user=6.47%，则：<br />值变量` &query=#{Value.usage_user}  `等同为 `&query=usage_user:6.47%` |
| 矩形树图、中国地图、世界地图、蜂窝图 | #{Value.metric_name} | 当前图表选中的查询数据值变量，name 可替换为任意列变量名。<br />假设当前图表查询为：<br />`L::RE(.*):(MAX(response_time)) { index = default } BY country`<br />查询结果为：max(response_time)=16692，则：<br />值变量` &query=#{Value.max(response_time)}  `等同为 `&query=max(response_time):16692` |


## 内置链接

内置链接是观测云默认为图表提供的关联链接，主要基于当前查询的时间范围和分组标签，帮助您查看对应的日志、进程、容器、链路。内置链接默认关闭。

![](../img/6.link_1.png)

开启显示内置链接后，点击图表即可查看关联的数据。

- 查看相关日志：基于当前查询的分组标签关联查询相关日志，即添加当前分组标签为筛选条件，支持跳转至日志查看器查看详情；容器、进程、链路同理。

![](../img/6.link_3.png)


## 自定义链接 {#custom-link}

观测云支持为图表添加自定义链接，在文本框输入基础上，通过参数配置自由组合生成最终图表关联链接地址来查看相关的数据。自定义链接添加以后默认开启显示，可直接在图表预览中显示相关链接。

在**仪表板**，选择**图表 > 链接**，输入**名称**，即可开始为图表添加自定义链接。

<img src="../../img/6.link_5.1.png" width="70%" >

### 链接地址

链接地址是在文本框输入基础上，通过参数配置自由组合生成最终图表关联链接地址来查看相关的数据。

#### 预设链接说明

在添加图表链接时，观测云提供预设链接，帮助您简单快速配置链接地址。

| 关联数据类型 | 预设链接                                  |
| ------------ | -------------------------------------- |
| 日志         | `/logIndi/log/all`                                           |
| 链路         | `/tracing/link/all`                                          |
| 错误追踪     | `/tracing/errorTrack`                                        |
| Profile      | `/tracing/profile`                                           |
| 容器         | `/objectadmin/docker_containers?routerTabActive=ObjectadminDocker` |
| Pod          | `/objectadmin/kubelet_pod?routerTabActive=ObjectadminDocker` |
| 进程         | `/objectadmin/host_processes?routerTabActive=ObjectadminProcesses` |
| 仪表板       | `/scene/dashboard/dashboardDetail`                           |


#### 预设参数说明 {#description}

在添加图表链接时，基于您选择的预设链接，会提供相应的可用参数，帮助您简单快速配置链接地址。

| 参数         | 说明                                          |
| ------------ | -------------------------------------------- |
| time         | 时间筛选，可用于查看器、仪表板中，链接格式如下：<br><li>通过模板变量传递查询时间：`&time=#{TR}` <br><li>查询最近15分钟：`&time=15m`<br><li>设定具体的开始时间和结束时间：`&time=1675247688602,1676457288602` |
| variable     | 视图变量查询，一般用于仪表板视图中。<br/>链接格式：`&variable={"host":"guance","service":"kodo"}` |
| dashboard_id | 仪表板 ID，可用于指定仪表板/内置视图。<br/>链接格式：`&dashboard_id=dsbd_069b2b90f562123456789123456789` |
| name         | 名称，可用于指定仪表板名称/笔记名称/自定义查看器名称等。<br/>链接格式：`&name=Linux 主机监控视图` |
| query         | 标签筛选或文本搜索，一般用于查看器中数据过滤使用。支持通过 `空格`、`AND`、`OR` 组合拼接标签筛选和文本搜索。（空格等同于 AND）                                          |
| cols         | 查看器的显示列，一般用于指定查看器的显示列。若没有指定，则显示为系统默认。<br/>链接格式：`&cols=time,host,service,message` |
| w            | 工作空间 ID，当跨工作空间跳转时需要指定。<br/>链接格式：`&w=wksp_40a73c6c2b024301a0b1d139e1234567` |

#### 可用的模版变量

在添加图表链接时，系统会默认提供当前配置图表链接可用的模板变量，您可以直接复制应用在链接中。如 #{TR}、#{T}、#{T.host}、#{V}、#{V.host} 等。

#### 示例说明

以关联查看当前工作空间 CPU 监控视图为例，配置示例如下：

`/scene/dashboard/dashboardDetail?dashboard_id=dsbd_e4313axxxxxxxxxxxxxc4198775e&name=CPU 监控视图&w=wksp_ed134a648xxxxxxxxxxxxx9a9c6115&time=#{TR}&variable=#{V.host}`

链接地址说明如下：

| 链接组成       | 参数配置                                         |
| ---------- | ------------------------------------------------ |
| 仪表板地址 | `/scene/dashboard/dashboardDetail`               |
| 仪表版 ID   | `dashboard_id=dsbd_e4313axxxxxxxxxxxxxc4198775e` |
| 仪表板名称 | `name=CPU 监控视图`                              |
| 工作空间 ID | `w=wksp_ed134a648xxxxxxxxxxxxx9a9c6115`          |
| 时间变量   | `time=#{TR}`                                     |
| 视图变量   | `variable=#{V.host}`                             |

???+ warning "注意"

    - 变量支持在网址链接后面输入，若网址链接本身已经带有时间变量、标签变量或者视图变量，需要在现有变量上进行修改，否则会导致冲突；
    - 若一个变量有多个参数用 `,` 隔开，多个变量之间用 `&` 链接；
    - 链接地址支持使用相对路径的地址。

### 链接方式

观测云支持三种链接打开方式，分别为**新页面**、**当前页面**和**划出详情页**。

- 新页面：在一个新的页面打开链接；
- 当前页面：在当前页面打开链接；
- 划出详情页：在当前页面侧滑出窗口，打开该链接。

## 操作说明

观测云支持对图表链接进行以下操作：

| 操作 | 说明 |
| --- | --- |
| 开启/关闭显示 | 用于控制是否在图表上显示关联链接。 |
| 编辑 | 支持对已添加的链接进行修改。 |
| 删除 | 用于删除当前自定义的链接，链接删除后将无法恢复，请谨慎操作。 |
| 恢复为默认 | 支持对修改过的内置链接还原到初始默认状态。 |


![](../img/6.link_8.png)


## 场景示例

**前提**：已经在观测云仪表板下完成图表创建，现在需要为图表添加链接。

### 链接到其他视图

<div class="grid" markdown>

=== "步骤一：添加图表链接"

    在图表链接中，输入名称 “cpu usage”，根据预设的链接和参数添加链接地址，选择打开方式为**侧滑页**。

    或者您也可以直接打开需要在图表中链接的视图，复制浏览器中的网址后粘贴链接地址，并根据需要展示的效果修改模版变量。

    <img src="../../img/6.link_5.1.png" width="60%" >

=== "步骤二：在图表中打开链接"

    链接添加完成后，点击图表，即可弹出自定义链接对话框。

    ![](../img/6.link_6.png)

    点击配置的 “cpu usage” 链接，即可侧滑打开链接的视图。

    ![](../img/6.link_7.png)

</div>


### 链接到基础设施

<div class="grid" markdown>

=== "步骤一：添加图表链接"

    在图表链接中，输入名称“基础设施主机查看器”，粘贴在观测云基础设施主机复制的链接地址，并根据需要展示的效果添加或修改模版变量参数。选择打开方式为**侧划页**。

    <img src="../../img/6.link_12.1.png" width="60%" >

=== "步骤二：在图表中打开链接"

    链接添加完成后，点击图表，即可弹出自定义链接对话框。点击配置的“基础设施主机查看器”链接，即可侧滑打开链接的内容。可以看到，变量值主机保持一致。

    ![](../img/2.link_11.png)

</div>

### 链接到外部帮助文档

<div class="grid" markdown>

=== "步骤一：添加图表链接"

    在图表链接中，名称输入“链接帮助文档”，在链接地址粘贴复制帮助手册的链接。打开方式选择**侧划页**。

    <img src="../../img/6.link_9.png" width="60%" >

=== "步骤二：在图表中打开链接"

    点击图表，即可弹出自定义链接对话框。点击配置的外部链接，即可侧滑打开链接内容。可以按照链接的帮助文档说明对图表进行设置。

    <img src="../../img/6.link_10.png" width="70%" >

</div>