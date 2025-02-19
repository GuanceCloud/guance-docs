---
icon: zy/application-performance-monitoring
---
# 应用性能监测
---

<video controls="controls" poster="https://{{{ custom_key.static_domain }}}/dataflux/help/video/apm.jpeg" >
      <source id="mp4" src="https://{{{ custom_key.static_domain }}}/dataflux/help/video/apm.mp4" type="video/mp4">
</video>

应用性能监测支持使用 Opentracing 协议的采集器，实现对分布式架构的应用进行端到端的链路分析，并与基础设施、日志、用户访问监测进行关联，快速定位并解决故障，提高用户体验。


![](img/1.apm-2.png)

最佳部署方案是将 DataKit 部署在每一台应用服务器中，通过服务所在主机的 DataKit 后将数据打到{{{ custom_key.brand_name }}}中心，能更好地对应用服务的服务器主机指标、应用日志、系统日志、应用服务链路数据等统一汇聚，进行各项数据的关联分析。


## 应用场景

![](img/apm-usecase.png)

<!--
- 大规模分布式应用的高效管理：通过服务清单，您可以实时查看不同服务的所有权、依赖关系、性能指标，快速发现和解决服务的性能问题；
- 端到端的分布式链路分析：通过火焰图，您可以轻松观测整条链路中每个 Span 的流转和执行效率；
- 数据关联分析：通过丰富的标签功能自动关联基础设施、日志、用户访问监测等数据进行分析；
- 方法级的代码性能追踪：通过采集 Profile 数据，获取链路相关 Span 的关联代码执行片段，直观展示性能瓶颈，帮助开发人员发现代码优化方向。
-->


## 功能介绍

<div class="grid cards" markdown>

- :material-format-list-text: __[服务相关](./service-manag/index.md)__：查看服务清单、性能指标及服务间的调用关系拓扑图
- :fontawesome-solid-globe: __[概览](overview.md)__：查看在线服务数量、P90 服务响应耗时、服务最大影响耗时等指标
- :material-vector-line: __[链路](./explorer/index.md)__：基于火焰图等工具对采集上报的所有链路数据进行查询和分析
- :material-weather-lightning-rainy: __[错误追踪](error.md)__：支持查看链路中类似错误的产生历史趋势及其分布情况，快速定位错误
- :fontawesome-solid-code-compare: __[Profiling](profile.md)__：查看应用运行指标，实时展示调用关系和效率，优化代码性能
- :material-cloud-search: __[应用性能指标检测](../monitoring/monitor/application-performance-detection.md)__：通过配置应用性能监控器，及时发现异常链路数据

</div>


## 数据存储与计费规则

{{{ custom_key.brand_name }}}为应用性能数据提供 3 天、7 天、14 天三种数据存储时长选择，您可以按照需求在**管理 > 设置 > 变更数据存储策略**中调整。

> 更多数据存储策略，可参考 [数据存储策略](../billing-method/data-storage.md)。


基于<u>按需购买，按量付费</u>的计费方式，应用性能监测计费统计当前空间下，`trace_id` 的数量，采用梯度计费模式。

> 更多计费规则，可参考 [计费方式](../billing-method/index.md)。
