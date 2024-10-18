# 应用智能检测
---


利用智能检测算法，能够自动识别应用请求数量的急剧增加或减少、错误请求数量的激增、以及请求延迟的急剧上升或下降等情况。这些异常模式将通过应用程序服务的异常指标进行捕捉，并自动触发异常分析流程。



## 应用场景

用于监控应用程序服务是否出现异常或中断，确保服务平稳运行状态。

## 检测配置 {#config}

![](../img/intelligent-detection09.png)

1. 定义监控器名称。

2. 选择检测范围：基于指标的标签对检测指标的数据进行筛选，限定检测的数据范围，支持添加一个或多个标签筛选。若不添加筛选，检测所有指标数据。



## 查看事件

监控器会获取最近 10 分钟的检测应用程序服务对象指标信息，识别出现异常情况时，会生成相应的事件，在[**事件 > 智能监控**](../../events/inte-monitoring-event.md)列表可查看对应异常事件。


### 事件详情页

在事件查看器可查看智能监控事件的详情页，包括事件状态、异常发生时间、异常名称、分析报告、告警通知、历史记录和关联事件。

* 点击右上角的**跳转到监控器**，可查看调整[智能监控器配置](index.md)；

* 点击右上角的**导出**按钮，支持选择**导出 JSON 文件**与**导出 PDF 文件**，从而获取当前事件所对应的所有关键数据。

:material-numeric-1-circle-outline: 分析报告

![](../img/intelligent-detection11.png)


* 异常总结：显示查看当前异常应用程序服务标签、异常分析报告详情、异常值分布情况统计

* 资源分析：对请求数的监控，可查看资源请求数排行（TOP 10）、资源错误请求数排行（TOP 10）、资源每秒请求数排行（TOP 10）等信息

**注意**：存在多个区间异常时，**异常分析**仪表板默认展示第一段异常区间的异常情况，可以点击【异常值分布图】进行切换，切换后异常分析仪表板同步联动。

:material-numeric-2-circle-outline: [扩展字段](../../events/event-explorer/event-details.md#extension)

:material-numeric-3-circle-outline: [告警通知](../../events/event-explorer/event-details.md#alarm)

:material-numeric-4-circle-outline: [关联事件](../../events/event-explorer/event-details.md#relevance)




