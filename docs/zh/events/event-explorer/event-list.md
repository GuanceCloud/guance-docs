# 事件列表
---


进入**事件**，通过切换左上角 :material-format-list-bulleted: 至**事件列表**，您可以查看当前工作空间下产生的全部事件。


![](../img/all-events.png)

在事件列表，您可以：

1. 通过柱状图堆叠的方式，查看分布图内当前事件查看器内，不同时间点下不同告警级别的事件统计数量；  
2. 基于标签、字段、文本对事件进行关键词搜索、标签筛选、字段筛选、关联搜索等；  
3. 基于不同的分析字段进行聚合事件分析，包含监控器 ID、监控类型、检测规则类型、主机、服务、容器名、Pod 名；
4. 查看某条事件的通知状态，包含以下三种情况：

| 通知状态      | 说明           |
| ------- | ----------- |
| 静默      | 即该告警事件处于静默状态。           |
| 沉默      | 即该告警事件处于沉默周期内。           |
| 通知对象标识      | 如钉钉机器人、企业微信机器人等标识；即该告警事件正常向[通知对象](../../monitoring/notify-object.md)发送。           |

## 查询与分析

您可通过以下操作来管理事件列表下的所有数据。


1. 时间控件：事件列默认展示最近 15 分钟的数据，您也可以自定义数据展示的[时间范围](../../getting-started/function-details/explorer-search.md#time)。

2. 搜索与筛选：在事件列搜索栏，支持[多种搜索方式和筛选方式](../../getting-started/function-details/explorer-search.md)。

3. 分析模式：可基于标签字段进行多维度分析，以反映不同分析维度下的聚合事件统计，点击聚合事件可查看[聚合事件详情](event-details.md)。

4. 快捷筛选：通过列表左侧的快捷筛选，可编辑[快捷筛选](../../getting-started/function-details/explorer-search.md#quick-filter)，添加新的筛选字段。

5. 筛选历史：<<< custom_key.brand_name >>>支持在[筛选历史](../../getting-started/function-details/explorer-search.md#filter-history)保存查看器 `key:value` 的搜索条件历史，应用于当前工作空间不同的查看器。

6. 事件导出：在事件列中，点击 :octicons-gear-24: 可导出当前事件查看器的数据为 CSV 文件或直接导出到仪表板和笔记。

7. 保存快照：在事件列左上角，点击**查看历史快照**，即可直接保存当前事件的快照数据，通过[快照](../../getting-started/function-details/snapshot.md)功能，您可以快速复现即时拷贝的数据副本信息，将数据恢复到某一时间点和某一数据展示逻辑。

8. 点击当前页面右下角的异常追踪图标，即可快速[新建 Issue](../../exception/issue.md#manual)。

9. 新建监控器：您可以在当前查看器通过该入口直接跳转至[监控器新建页面](../../monitoring/monitor/index.md#new)，为事件快速设置异常检测规则。

<img src="../../img/explorer-monitor.png" width="60%" >

## 更多阅读

<font size=2>

<div class="grid cards" markdown>

- [<font color="coral"> :fontawesome-solid-arrow-right-long: &nbsp; 事件详情</font>](event-details.md)

</div>


<div class="grid cards" markdown>

- [<font color="coral"> :fontawesome-solid-arrow-right-long: &nbsp; 查看器的强大之处</font>](../../getting-started/function-details/explorer-search.md)

</div>

</font>