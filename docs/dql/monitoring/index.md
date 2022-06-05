# 监控
---

“观测云” 拥有强大的异常监测能力，不仅提供了包括Docker、Elasticsearch、Host等一系列监控模版，还支持自定义监控器，配合告警通知功能，可及时发现帮助您快速发现问题、定位问题、解决问题。同时，“观测云”支持SLO（Service Level Objective）监控，精准把控服务水准和目标。

## 监控器
（原指“异常检测规则”）“观测云” 提供「阈值检测」、「日志检测」等多种监测方式，允许用户自定义配置检测规则和触发条件，并通过告警第一时间接收告警通知。

- [阈值检测](https://www.yuque.com/dataflux/doc/zdeogm)：基于设置的阈值对指标数据进行异常检测，当数据达到阈值时，触发告警并通知用户。
- [日志检测](https://www.yuque.com/dataflux/doc/usqo8y)：基于工作空间内的日志数据进行异常检测，多适用于 IT 监控场景下的代码异常或任务调度检测等。
- [突变检测](https://www.yuque.com/dataflux/doc/dgk8e5)：基于历史数据对指标的突发反常表现进行异常检测，多适用于业务数据、时间窗短的场景。
- [区间检测](https://www.yuque.com/dataflux/doc/kcngg6)：基于动态阈值范围对指标的异常数据点进行检测，当数据超出设定的区间范围后，产生告警并通知用户，多适用于趋势稳定时间线的场景。
- [水位检测](https://www.yuque.com/dataflux/doc/wbi2y4)：基于历史数据对指标的持续反常表现进行异常检测，可避免突发检测的毛刺告警。
- [安全巡检](https://www.yuque.com/dataflux/doc/bbp4o4)：基于工作空间内安全巡检数据进行异常检测，用于监控工作空间内系统、容器、网络等存在的漏洞、异常和风险。
- [应用性能指标检测](https://www.yuque.com/dataflux/doc/tag1nx)：基于工作空间内「应用性能监测」的指标数据，当指标到达设置的阈值范围后触发告警。
- [用户访问指标检测](https://www.yuque.com/dataflux/doc/qnpqmm)：基于工作空间内「用户访问监测」的指标数据，当指标到达设置的阈值范围后触发告警。
- [进程异常检测](https://www.yuque.com/dataflux/doc/uskqmx)：基于工作空间内的进程数据，支持对进程数据的一个或多个字段类型设置触发告警。
- [可用性监测数据检测](https://www.yuque.com/dataflux/doc/he412g)：基于工作空间内的云拨测数据，通过对一定时间段内拨测任务产生的指定数据量设置阈值范围后触发告警。

## 模版
（原指“内置检测库”），“观测云”内置多种开箱即用的监控模版，支持一键创建Docker、Elasticsearch、Host、Redis监控。成功新建模版后，即自动添加对应的官方监控器至当前工作空间。详情可参考文档 [模版](https://www.yuque.com/dataflux/doc/br0rm2) 。

## 分组
（原指“自定义监测库”），分组功能支持您自定义创建有意义的监测器组合，方便分组管理各项监控器。

## SLO
（Service Level Objective），是服务等级目标的简称，即预先设定的系统稳定性目标。“观测云”支持测试当前系统服务状态等级，对比检测对应的SLI（Service Level Indicator是测量指标，对应监控器所测量的指标）是否满足目标需要。

## 告警设置

“观测云” 支持为检测库设置触发条件告警、无数据告警、告警恢复等，通过告警沉默控制重复告警通知。详情可参考 [告警设置](https://www.yuque.com/dataflux/doc/qxz5xz) 。


---

观测云是一款面向开发、运维、测试及业务团队的实时数据监测平台，能够统一满足云、云原生、应用及业务上的监测需求，快速实现系统可观测。**立即前往观测云，开启一站式可观测之旅：**[www.guance.com](https://www.guance.com)
![](img/logo_2.png)
