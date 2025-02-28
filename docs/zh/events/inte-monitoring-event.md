# 智能监控
---


在**事件 > 智能监控**查看器，您可以查看当前工作空间内智能监控产生的全部事件列表。

在智能监控事件查看器，您可以：

- 通过柱状图堆叠的方式，统计当前事件查看器内，不同时间点发生的不同规则的事件数量；  
- 基于标签、字段、文本对事件进行关键词搜索、标签筛选、字段筛选、关联搜索等；  
- 基于选择字段分组进行聚合事件分析。

## 查询与分析

在智能监控事件查看器中，支持通过选择时间范围、搜索关键字，筛选等方式查询事件数据，帮助您快速在所有事件中定位到特定时间范围、功能模块、行为触发的事件。

![](img/inte-monitoring-event01.png)

- 时间控件：所有事件查看器默认展示最近 15 分钟的数据，您也可以自定义数据展示的[时间范围](../getting-started/function-details/explorer-search.md#time)。

- [搜索与筛选](../getting-started/function-details/explorer-search.md)

- 在智能监控事件查看器分析栏，支持基于标签字段进行多维度分析，以反映不同分析维度下的聚合事件统计，点击聚合事件可查看[聚合事件详情](./event-explorer/event-details.md)。

- 可编辑左侧的[快捷筛选](../getting-started/function-details/explorer-search.md#quick-filter)或添加新的筛选字段。

- 筛选历史：<<< custom_key.brand_name >>>支持在[筛选历史](../getting-started/function-details/explorer-search.md#filter-history)保存查看器 `key:value` 的搜索条件历史，应用于当前工作空间不同的查看器。

- 事件导出：在智能监控事件查看器中，点击**导出**可导出当前事件查看器的数据到 CSV、仪表板和笔记。

- 保存快照：在智能监控事件查看器左上角，点击**查看历史快照**，即可直接保存当前事件的快照数据，通过[快照](../getting-started/function-details/snapshot.md)功能，您可以快速复现即时拷贝的数据副本信息，将数据恢复到某一时间点和某一数据展示逻辑。

## 事件详情页

在智能监控事件查看器，点击任意事件，即可侧滑打开查看事件详情，包括分析报告、告警通知、历史记录、关联事件等信息。在事件详情页，支持跳转到当前事件关联的监控器和导出事件的关键信息到 PDF 或者 JSON 文件。

> 更多详情，可参考 [智能监控](../monitoring/intelligent-monitoring/index.md)。 

