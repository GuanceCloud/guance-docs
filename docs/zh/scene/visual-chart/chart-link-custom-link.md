# 自定义链接 
---

即为图表添加自定义链接。在文本框输入基础上，通过参数配置自由组合生成最终图表关联链接地址来查看相关的数据。自定义链接添加以后默认开启显示，可直接在图表预览中显示。

## 开始添加

1. 进入**仪表板 > 图表 > 链接**;
2. 定义链接**名称**；
3. 为图表添加自定义链接；
4. 确定。

<img src="../../img/custom_link.png" width="70%" >

## 链接地址

链接地址基于文本框输入和参数配置生成，用于关联图表与相关数据。

### 预设链接

系统提供预设链接，简化链接地址配置。预设链接可帮助快速关联到常用数据类型，无需手动输入完整路径。

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


### 预设参数 {#description}

根据选择的预设链接，系统提供相应参数，简化配置。这些参数允许您根据具体需求灵活配置链接地址，确保关联的准确性。


| <div style="width: 160px">参数<div style="width: 160px">         | 说明                                          |
| ------------ | -------------------------------------------- |
| `time`         | 时间筛选，可用于查看器、仪表板中。<br/>链接格式：<br><li>通过模板变量传递查询时间：`&time=#{TR}` <br><li>查询最近 15 分钟：`&time=15m`<br><li>设定具体的开始时间和结束时间：`&time=1675247688602,1676457288602` |
| `variable`     | 视图变量查询，一般用于仪表板视图中。<br/>链接格式：`&variable={"host":"guance","service":"kodo"}` |
| `dashboard_id` | 仪表板 ID，可用于指定仪表板/内置视图。<br/>链接格式：`&dashboard_id=dsbd_069b2b90f562123456789123456789` |
| `name`         | 名称，可用于指定仪表板名称/笔记名称/自定义查看器名称等。<br/>链接格式：`&name=Linux 主机监控视图` |
| `query`         | 标签筛选或文本搜索，一般用于查看器中数据过滤使用。支持通过 `空格`、`AND`、`OR` 组合拼接标签筛选和文本搜索。<br/>:warning: 空格等同于 AND。       |
| `cols`         | 查看器显示列，一般用于指定查看器的显示列。未指定时显示系统默认。<br/>链接格式：`&cols=time,host,service,message` |
| `w`            | 工作空间 ID，当跨工作空间跳转时需要指定。<br/>链接格式：`&w=wksp_40a73c6c2b024301a0b1d139e1234567` |

### 可用的模版变量

系统默认提供当前图表链接可用的模板变量，如 `#{TR}`、`#{T}`、`#{T.host}`、`#{V}`、`#{V.host}` 等，可直接用于链接配置。

### 示例说明

以关联查看当前工作空间 CPU 监控视图为例，配置示例如下：

`/scene/dashboard/dashboardDetail?dashboard_id=dsbd_e4313axxxxxxxxxxxxxc4198775e&name=CPU 监控视图&w=wksp_ed134a648xxxxxxxxxxxxx9a9c6115&time=#{TR}&variable=#{V.host}`

- 链接地址说明：

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
    - 多个参数用 `,` 隔开，多个变量间用 `&` 链接；
    - 链接地址支持使用相对路径的地址。

## 链接方式

支持三种链接打开方式：

- 新页面：在新页面打开链接；
- 当前页面：在当前页面打开链接；
- 划出详情页：在当前页面侧滑出窗口，打开该链接。

## 管理链接

支持对图表链接进行以下操作：

- 开启/关闭显示：控制图表上是否显示关联链接；  
- 编辑：修改已添加的链接；      
- 删除：删除当前自定义链接，删除后无法恢复，请谨慎操作；       
- 恢复为默认：将修改过的内置链接还原到初始状态。 


<img src="../../img/manag_link.png" width="70%" >