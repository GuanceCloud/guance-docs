# 未恢复事件
---

<<< custom_key.brand_name >>>通过查看器集中展示当前工作空间内所有处于告警级别的事件记录。这种方法不仅帮助关注者全面理解告警事件的上下文，加速对事件的了解和认知，而且通过关联监控器、告警策略等有效减轻了警报疲劳。

未恢复事件数据源通过查询事件数据，以 `df_fault_id` 作为唯一标识进行聚合，并展示最近的数据结果。您可借助查看器这一可视化工具直观了解从事件等级到触发阈值基线的一系列关键数据点，从事件等级、持续时长、告警通知、监控器到事件内容、历史触发趋势图，这些信息共同构成了一个全面的视图，帮助您能够从不同角度分析和理解事件，从而做出更加明智的响应决策。

![](../img/5.event_6.png)

## 事件卡片

![](../img/event-card.png)

### 事件等级

基于监控器的触发条件配置会产生**未恢复（df_status != ok）**、**紧急（critical）**、**重要（error）**、**警告（warning）**、**数据断档（nodata）**的状态统计。

在<<< custom_key.brand_name >>>的未恢复事件查看器中，每条事件的等级被定义为该检测对象最近一次触发事件时的等级。

> 更多详情，可参考 [事件等级说明](../../monitoring/monitor/event-level-description.md)。

### 事件标题

未恢复事件查看器所显示的事件标题，直接来源于监控器规则配置时[设定的标题](../../monitoring/monitor/mutation-detection.md#event-content)，它代表了该检测对象在最后一次触发事件时所用的标题。

### 持续时长

表示当前检测对象从第一次触发异常产生事件截止到当前时间控件的结束时间，如 `5 分钟 (08/20 17:53:00 ~ 17:57:38)`。

### 告警通知

当前检测对象最后一次触发事件的告警通知情况。主要包含以下三种状态：

- 静默：表示当前事件受静默规则影响，但未对外发送告警通知；
- 实际发送[通知对象](../../monitoring/notify-object.md)的标识：包含钉钉机器人、企业微信机器人、飞书机器人等；
- `-`：没有对外触发告警通知。

### 监控器检测类型

即监控器类型。

### 检测对象

在配置监控器规则时，若在检测指标处使用了 `by` 分组查询，则事件卡片会展示筛选条件，如 `source:kodo-servicemap`。

### 事件内容

当前检测对象最后一次触发事件的事件内容，来源于配置监控器规则时[预设的内容](../../monitoring/monitor/mutation-detection.md#event-content)，它代表了该检测对象在最后一次触发事件时的事件内容。

### 历史触发趋势图 {#exception}

该趋势通过 Window 函数进行展示，检测结果值历史趋势展示实际数据的 60 次检测。

基于当前未恢复事件的检测结果值展示历史事件异常趋势，配置的监控器检测规则内的触发阈值条件值被设定为一个清晰的参考线。系统会特别标记出当前检测对象最后一次触发事件的检测结果，并且通过趋势图中的**竖线**，您可以迅速定位到事件触发的具体时间点。同时，该检测结果的对应检测区间也被展示出来，为您提供了一个直观的分析工具，以便于评估事件的发展过程及其影响。


## 管理卡片

### 显示偏好 {#preference}

未恢复事件列表支持两种显示样式：标准和扩展。

- 标准：显示事件标题、检测维度和事件内容。

![](../img/event-1-1.png)

- 扩展：除标准信息外，还显示未恢复事件的检测结果值[历史趋势](#exception)。

![](../img/event.png)


### Issue & 新建 Issue {#issue}

可针对未恢复事件[创建 Issue](../../exception/issue.md#event)，通知相关成员及时处理。
 
![](../img/event-2.png)

<img src="../../img/event-3.png" width="60%" >

若当前事件与某个异常追踪产生关联，点击图标可直接跳转查看：

<img src="../../img/event_jump_to_issue.png" width="80%" >

### 恢复事件 {#recover}

事件状态为正常（`df_sub_status = ok`）时即为恢复事件。恢复规则可在[监控器](../../monitoring/monitor/index.md)中设置，或手动恢复。

恢复事件分为四种类型：

| <div style="width: 140px">名称</div>       | `df_status` | 说明                                                    |
| :------------- | :-------- | :----------------------------------------------------------- |
| 恢复           | ok        | 之前检测到“紧急”“重要”“警告”这 3 种异常事件，N 次检测内未再触发，则视为恢复。 |
| 数据断档恢复     | ok        | 数据停止上报后重新上报，判断为恢复。 |
| 数据断档视为恢复 | ok        | 检测数据出现断档，视为正常状态。 |
| 手动恢复       | ok        | 用户手动点击恢复，支持单条/批量恢复。         |



## 更多阅读

<font size=2>

<div class="grid cards" markdown>

- [<font color="coral"> :fontawesome-solid-arrow-right-long: &nbsp; 事件详情</font>](event-details.md)

</div>

<div class="grid cards" markdown>

- [<font color="coral"> :fontawesome-solid-arrow-right-long: &nbsp; 所有事件查看器</font>](./event-list.md)

</div>


<div class="grid cards" markdown>

- [<font color="coral"> :fontawesome-solid-arrow-right-long: &nbsp; 查看器的强大之处</font>](../../getting-started/function-details/explorer-search.md)

</div>

<div class="grid cards" markdown>

- [<font color="coral"> :fontawesome-solid-arrow-right-long: &nbsp; 通过告警统计图可视化分析事件数据</font>](../../scene/visual-chart/alert-statistics.md)

</div>



</font>