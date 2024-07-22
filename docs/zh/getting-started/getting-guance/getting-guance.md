# 搭建个人观测平台
---

## 第一步：注册并登录帐号 {#step-1}

进入[观测云官网](https://www.guance.com/)，点击[注册](../../plans/commercial-register.md)，即可开通观测云用户。

## 第二步：安装 DataKit {#step-2}

[DataKit](../../datakit/datakit-arch.md) 是观测云官方发布的数据采集应用，支持上百种数据的采集，可实时采集如主机、进程、容器、日志、应用性能、用户访问等多种数据。

账号注册成功后，登录 **[观测云控制台](https://console.guance.com/)** 工作空间，即可开始安装。

<u>*此处以 Linux 主机安装 DataKit 为例。*</u>
    
> 更多详情可参考文档 [主机安装 DataKit](../../datakit/datakit-install.md)、[K8s 安装 DataKit](../../datakit/datakit-daemonset-deploy.md)。

### 1、获取安装命令

登录**工作空间**，点击左侧**集成**，选择顶部 **DataKit**，即可看到各种平台的安装命令。

![](../img/getting-guance-1.png)

### 2、执行安装命令

复制对应安装命令并执行，若成功安装，在终端会看到如下提示。

![](../img/getting-guance-2.png)

### 3、查看运行状态

<div class="grid" markdown>

=== ":material-numeric-1-circle-outline: 观测云查看"

    进入**工作空间**，点击左侧**基础设施**模块，可查看已安装 DataKit 的主机列表。

    ![](../img/getting-guance-3.png)

=== ":material-numeric-2-circle-outline: 终端查看"

    > 相关阅读：[DataKit 服务管理](../../datakit/datakit-service-how-to.md)、[DataKit 状态查询](../../datakit/datakit-monitor.md)、[DataKit 故障排查](../../datakit/why-no-data.md)

    执行如下命令即可获取本机 DataKit 的基本运行情况。

    ```
    datakit monitor
    ```

    ![基础Monitor信息展示](https://zhuyun-static-files-production.oss-cn-hangzhou.aliyuncs.com/images/datakit/monitor-basic-v1.gif) 

</div>

## 第三步：开始观测 {#step-3}

成功安装 DataKit 后，会[默认开启一批数据指标采集器](../../datakit/datakit-input-conf.md#default-enabled-inputs)，无需手动开启。根据采集到的数据指标，观测云具备丰富的功能助您观测。

### [基础设施](../../infrastructure/index.md)

观测云支持采集包括主机、云主机、容器、进程和其他云服务的对象数据，并主动上报到工作空间。

![](../img/getting-guance-6.png)

### [场景](../../scene/index.md)

在观测云中，您可以根据不同的视角构建满足不同业务的**场景**，包括仪表板、笔记和查看器。

<u>(此处以添加 Linux 仪表板为例)</u>

<div class="grid" markdown>

=== ":material-numeric-1-circle-outline: 添加仪表板"

    点击左侧**场景**模块，依次点击**仪表板 > 新建仪表板**，在**系统视图**中搜索 **Linux**，选择「主机概览_Linux 监控视图」并点击**确定**，即可成功添加。

    ![](../img/getting-guance-4.png)

=== ":material-numeric-2-circle-outline: 查看仪表板"

    系统视图是观测云提供的标准模板，帮助用户直观地跟踪、分析和显示关键性能指标，监控整体的运行状况。点击 **[添加图表](../../scene/visual-chart/index.md)** ，可以自定义添加多种可视化图表。

    ![](../img/getting-guance-5.png)

</div>


### [指标](../../metrics/index.md)

观测云具有全域数据采集能力，由采集器获取的指标数据会自动上报至工作台，您可以通过**指标**对空间内的指标数据进行统一的分析和管理。

<div class="grid" markdown>

=== ":material-numeric-1-circle-outline: 指标管理"
    **指标管理**模块，可以查看所有上报到该工作空间的指标集、时间线数量、数据存储策略信息。

    ![](../img/getting-guance-7.png)

=== ":material-numeric-2-circle-outline: 指标分析"
    **指标分析**模块，可以对指标和其他数据类型（日志、基础对象、自定义对象、事件、应用性能、用户访问、安全巡检、网络、Profile等）进行数据查询和分析。

    如下图示例展示的是：当前工作空间内，最近15分钟，不同主机 ip 的 CPU使用率 对比分析。

    ![](../img/getting-guance-8.png)

</div>

### [监控](../../monitoring/index.md)

观测云拥有强大的异常监测能力，不仅提供了包括 Docker、ElasticSearch、Host 等一系列监控模板，还支持自定义监控器，配合告警通知功能，可及时发现帮助您快速发现问题、定位问题、解决问题。

<div class="grid" markdown>

=== ":material-numeric-1-circle-outline: 新建监控器"

    **监控 > 监控器**，可以自由选择**创建新的监控器**或**从模版库新建**。

    ![](../img/getting-guance-9.png)

=== ":material-numeric-2-circle-outline: 配置监控器信息"

    如下图示例展示的是：当前工作空间内，每隔 5 分钟检测 1 次，是否有某台主机 ip 在过去5分钟内的内存使用率最大值，触发了不同级别的阈值检测条件。

    ![](../img/getting-guance-10.png)

=== ":material-numeric-3-circle-outline: 配置告警策略及通知对象"

    若需要在监控器触发条件时，发送告警信息到特定通知对象，可在对应模块进行相关配置。

    ![](../img/getting-guance-11.png)

</div>

### [付费计划与账单](../../billing/index.md)

在**付费计划与账单**模块，可以查看当前工作空间的版本信息、使用统计、账单列表等信息。<br/>
如下图展示的是**商业版工作空间的拥有者**视角：

![](../img/12.billing_1.png)


<div class="grid cards" markdown>

- [<font color="coral"> :fontawesome-solid-arrow-up-right-from-square: &nbsp; 功能指南：了解更多操作小技巧</font>](../function-details/explorer-search.md)

<br/>

</div>

## 进阶操作

<div class="grid cards" markdown>

- [<font color="coral"> :fontawesome-solid-arrow-up-right-from-square: &nbsp; DataKit 采集器：中间件、APM、LOG 等</font>](../../datakit/datakit-input-conf.md)

- [<font color="coral"> :fontawesome-solid-arrow-up-right-from-square: &nbsp; 集成文档：丰富的数据接入操作指引</font>](../../integrations/integration-index.md)

- [<font color="coral"> :fontawesome-solid-arrow-up-right-from-square: &nbsp; DQL：贯穿观测云的查询语言</font>](../../dql/query.md)

- [<font color="coral"> :fontawesome-solid-arrow-up-right-from-square: &nbsp; 最佳实践：提供更多玩法灵感</font>](../../best-practices/index.md)

</div>

