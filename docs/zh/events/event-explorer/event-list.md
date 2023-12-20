# 所有事件查看器
---


进入**事件**，通过切换左上角 :material-format-list-bulleted: 至**所有事件查看器**，您可以查看当前工作空间内全部事件列表。

在所有事件查看器，您可以：

- 通过柱状图堆叠的方式，统计当前事件查看器内，不同时间点发生的不同告警级别的事件数量；  
- 基于标签、字段、文本对事件进行关键词搜索、标签筛选、字段筛选、关联搜索等；  
- 基于选择字段分组进行聚合事件分析。

## 查询与分析

![](../img/5.event_7.gif)

- 时间控件：所有事件查看器默认展示最近 15 分钟的数据，您也可以自定义数据展示的[时间范围](../../getting-started/function-details/explorer-search.md#time)。

- 搜索与筛选：在所有事件查看器搜索栏，支持[多种搜索方式和筛选方式](../../getting-started/function-details/explorer-search.md)。

- 分析模式：可基于标签字段进行多维度分析，以反映不同分析维度下的聚合事件统计，点击聚合事件可查看[聚合事件详情](event-details.md)。

- 快捷筛选：通过列表左侧的快捷筛选，可编辑[快捷筛选](../../getting-started/function-details/explorer-search.md#quick-filter)，添加新的筛选字段。

- 筛选历史：观测云支持在[筛选历史](../../getting-started/function-details/explorer-search.md#filter-history)保存查看器 `key:value` 的搜索条件历史，应用于当前工作空间不同的查看器。

- 新建监控器：您可以在当前查看器通过该入口直接跳转至[监控器新建页面](../../monitoring/monitor/index.md#new)，为事件快速设置异常检测规则。

<img src="../../img/explorer-monitor.png" width="60%" >

- 事件导出：在所有事件查看器中，点击 :fontawesome-solid-gear: 可导出当前事件查看器的数据到 CSV、仪表板和笔记。

- 保存快照：在所有事件查看器左上角，点击**查看历史快照**，即可直接保存当前事件的快照数据，通过[快照](../../getting-started/function-details/snapshot.md)功能，您可以快速复现即时拷贝的数据副本信息，将数据恢复到某一时间点和某一数据展示逻辑。

## 更多阅读

<div class="grid cards" markdown>

- [<font color="coral"> :fontawesome-solid-arrow-right-long: &nbsp; 事件详情</font>](event-details.md)

</div>


<div class="grid cards" markdown>

- [<font color="coral"> :fontawesome-solid-arrow-right-long: &nbsp; 查看器的强大之处</font>](../../getting-started/function-details/explorer-search.md)

</div>