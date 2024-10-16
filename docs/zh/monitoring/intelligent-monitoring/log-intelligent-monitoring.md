# 日志智能检测
---


基于智能检测算法，监控工作空间内采集器产生的日志数据。智能识别日志数量的突增 / 突降、错误日志的突增的异常数据，及时发现不符合预期的异常状态。

## 应用场景

多适用于 IT 监控场景下的代码异常或任务调度检测等。例如监控日志的错误数突增。

## 检测配置

![](../img/intelligent-detection06.png)

1. 定义监控器名称。

2. 选择检测维度：支持**基于 Source（By Source）**或**基于 Service (By Service)**检测，自动匹配用户选择的检测维度；

3. 选择检测范围：基于指标的标签对检测指标的数据进行筛选，限定检测的数据范围，支持添加一个或多个标签筛选。若不添加筛选，检测所有日志的数据。


## 查看事件

监控器会获取最近 10 分钟的检测日志指标，识别出现日志数量的突增 / 突降、错误日志的突增情况时，会生成对应的事件，在**事件 > 智能监控**列表可查看异常事件。


### 事件详情页

点击**事件**，可查看智能监控事件的详情页，包括事件状态、异常发生时间、异常名称、分析报告、告警通知、历史记录和关联事件。

* 点击右上角的**跳转到监控器**，可查看调整[智能监控器配置](index.md)；

* 点击右上角的**导出**按钮，支持选择**导出 JSON 文件**与**导出 PDF 文件**，从而获取当前事件所对应的所有关键数据。

:material-numeric-1-circle-outline: 分析报告

![](../img/intelligent-detection08.png)

* 异常总结：可查看当前异常日志标签、异常分析报告详情、及错误请求数分布情况

* 错误分析：可查看错误日志的聚类信息

**注意**：存在多个区间异常时，**异常总结 > 异常值分布图**及**异常分析**仪表板默认展示第一段异常区间的异常情况分析，可以点击【异常值分布图】进行切换，切换后异常分析仪表板同步联动。

:material-numeric-2-circle-outline: [扩展字段](../../events/event-explorer/event-details.md#extension)

:material-numeric-3-circle-outline: [告警通知](../../events/event-explorer/event-details.md#alarm)

:material-numeric-4-circle-outline: [历史记录](../../events/event-explorer/event-details.md#history)

:material-numeric-5-circle-outline: [关联事件](../../events/event-explorer/event-details.md#relevance)
