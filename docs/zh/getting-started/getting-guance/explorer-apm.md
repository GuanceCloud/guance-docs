# 标准应用性能监测（APM）查看器使用介绍

## 进入应用性能监测 > 服务

![](../img/apm-1.png)

![](../img/apm-2.png)

## 切换为服务拓扑视图

可以直观查看服务之间的关联拓扑。

![](../img/apm-3.png)

## 查看服务的关联信息

点击服务后，可以**查看上下游**、**查看服务概览**、**查看相关日志**、**查看相关链路**。

![](../img/apm-4.png)

## 查看服务的概览大盘

点击顶部的**概览**按钮，查看所有服务的整体概览。

![](../img/apm-5.png)

可通过下拉菜单选择一个或者多个服务、环境、版本，查看对应的数据。

![](../img/apm-6.png)

## 查看所有服务链路（Trace + Span）

点击顶部**链路**，进入所有服务链路的查看器。

界面上方展示了三个系统内置的快捷图表，可以查看 Span 总数量趋势、错误 Span 趋势、响应时间趋势。 

![](../img/apm-7.png)

界面下方展示了所有链路的列表，可以通过切换 Span、顶层 Span、Trace 查看不同数据。

![](../img/apm-8.png)

点击任意 Span，查看详情，页面上方默认会展示这条链路（Trace）的火焰图信息。

![](../img/apm-9.png)

> 火焰图的详细解释和使用，可参考文档 [火焰图](../../best-practices/monitoring/trace-glame-graph.md)。

点击火焰图的不同色块，可以切换到同一条链路下的不同 Span。

![](../img/apm-10.png)

也可以通过切换标签页，查看 Span 列表。

其中 Span 列表详情页有 **瀑布图** 和 **列表图** 两种展示模式。

![](../img/apm-11.png)

![](../img/apm-12.png)

也可以通过切换标签页，查看**服务调用关系**。

![](../img/apm-13.png)

## 查看关联仪表板

页面下方是关联视图，可以查看系统内置仪表板以及自定义关联仪表板。

![](../img/apm-14.png)

> 关于自定义关联仪表板，可参考文档[标准日志查看器使用介绍](./generate-explorer.md)。

## 快速查看错误链路

点击顶部**错误追踪**，可以快速查看所有错误汇总信息。

![](../img/apm-15.png)

使用**聚类分析**功能，可以查看同类错误信息的汇总和排序。

![](../img/apm-16.png)

使用右上角**分析**功能，可以快速对错误信息进行分组展示。

该示例中，以 `host` 为维度进行分组展示，可以快速发现，`pe-ruoyi` 这台主机上产生的错误数量最多。

![](../img/apm-17.png)

## 查看 Profile 数据

点击顶部的**Profile**，可以查看所有 Profile 代码剖析数据。

![](../img/apm-18.png)

点击任意一条 Profile 数据，可以查看耗时详情，可以通过点击类型筛选框，进行类型切换。

![](../img/apm-19.png)

可以通过切换不同类型的数据，快速定位到性能瓶颈或耗时最长的方法。

> 关于 Profile 详细使用介绍，可参考文档 [Profile](../../application-performance-monitoring/profile.md)。

## 更多阅读

<div class="grid cards" markdown>

- [<font color="coral"> :fontawesome-solid-arrow-right-long: &nbsp; 解锁应用性能监测（APM）查看器更多功能</font>](../../application-performance-monitoring/explorer.md)

</div>