# 告警统计图
---

以列表的形式展示未恢复的告警事件，快速识别和响应系统中的紧急问题.

<img src="../../img/warning.png" width="70%" >

基于异常检测的告警事件，告警统计图分为两个部分：

- 统计图：将事件按等级分组，统计每个等级的事件数量；
- 告警列表：在选定的时间范围内，产生的所有未恢复的告警事件。



您可以在查询中通过输入关键词进行查询定位，或进一步添加 `by` 条件进行数据聚合显示。

在告警列表中，hover 在某条事件数据上，即可选择直接[新建与该条事件相关的 Issue](../../events/event-explorer/unrecovered-events.md#issue) 或直接[恢复该条事件](../../events/event-explorer/unrecovered-events.md#recover)。


## 图表配置

> 更多详情，可参考 [图表配置](./chart-config.md)。

### 显示设置

1. 显示项：即选择当前图表需要展示的部分，包括：

    - 全部
    - 仅统计图
    - 仅告警列表

2. 分页数量：即左侧图告警列表中显示的未恢复事件数量，可选范围包含 10 条、20 条、50 条、100 条；系统默认 50 条分页。



## 更多阅读

<font size=2>

<div class="grid cards" markdown>

- [<font color="coral"> :fontawesome-solid-arrow-right-long: &nbsp; 图表配置</font>](./chart-config.md)

</div>




<div class="grid cards" markdown>

- [<font color="coral"> :fontawesome-solid-arrow-right-long: &nbsp; 未恢复事件查看器</font>](../../events/event-explorer/unrecovered-events.md)

</div>



</font>