# 组合检测

在观测云，除了基于不同的数据范围设置不同的检测规则，您还可以将多个监控器的结果通过表达式组合成一个监控器，最终基于组合后的结果进行告警。

## 检测频率

组合监控**没有固定的检测频率**，而是根据所选择监控器的事件状态来进行判断。由于各个监控器检测频率不一定相同，所以选取其中**最大的检测频率**同频作判断。

例如：监控器 A 检测频率（5 分钟），监控器 B 检测频率（1 小时），那么组合监控 A&&B，就跟随 B 一起做判断（1小时一次）。B 触发检测后，结合监控器 B 的检测结果，与监控器 A 最新一次检测结果，进行逻辑判断。

## 新建

点击**监控器 > 新建监控器 > 组合检测·**，进入区间检测规则配置页面。

### 步骤一：检测配置

![](../img/combine-1.png)

1）选择至少两个监控器，右侧会显示其 by 条件分组。

**注意**：最多添加 10 个监控器。

2）**组合方式**：遵循**与或非**的运算逻辑表达式来定义组合监控器是否触发事件。当所选监控器都触发异常状态时，解析为真，反之解析为假。

**逻辑运算**：当所选监控器处于异常状态时，解析为 `True`，具体如下：

| 事件状态 |  解析后	 | 严重等级 | 
| --- | --- |  --- | 
| `critical` | True |  4 | 
| `error` | True |  3 | 
| `warning` | True |  2 | 
| `nodata` | True |  1 | 
| `ok` | False |  0 | 
| `info` | False |  0 | 
| 不触发事件视为正常，同样解析为 False |  |   | 

**运算符详解**：

| 逻辑运算 |  说明	 |
| --- | --- |
| `&&` `与` | `A&&B`：若运算结果为 `true`，则返回 A、B 中**更不严重**的状态等级。例如：A=critical，B=warning，那么返回 `warning`。 |
| `｜｜` `或` | `A｜｜B`：若运算结果为 `true`，则返回 A、B 中**更严重**的状态等级。例如：A=critical，B=warning，那么返回 `critical`。 |
| `!` `非` | “异常状态” 对应的`非`都是 `ok`；“正常状态”对应的`非`都是 `critical`。例如：若 A=error，那么 `!A=ok`；若 A=ok，那么 `!A=critical`。 |


???+ warning "如何定义【真】？"

    基于所选的监控，若监控器中**存在分组**，那么当所有监控器共同的分组**都处于异常状态**时才会解析为“真”。
    例如：当选择了监控器 A（主机 1、2、3、4 产生告警）与监控器 B（主机 2、3、5、6 产生告警），那么组合监控器 (A&&B) 只有主机 2 和 3 会返回为“真”，产生告警。


**注意**：当组合方式中的监控器**分组不一致**，这种没有共同分组的情况将不会产生告警。

| 分组情况 |  是否一致 | 示例 | 
| --- | --- |  --- | 
| 监控器 A 无分组，监控器 B 有分组 | 否<font color=red size=2>（此时不会产生告警）</font> |  B: by host | 
| 监控器 A 和 B 分组部分一致 | 否<font color=red size=2>（此时不会产生告警）</font> |  A: by host, service, B: by host, device | 
| 监控器A 和 B 分组完全不一致 | 否<font color=red size=2>（此时不会产生告警）</font> |  A: by host, B: by service | 
| 监控器 A 和 B 分组为包含关系 | 是<font color=red size=2>（此时可以正常检测和告警）</font> |  A: by host, B: by host, device (`dimension_tags=host`)| 
| 监控器 A 包含于监控器 B 分组，监控器 B 包含于监控器 C 分组 | 是<font color=red size=2>（此时可以正常检测和告警）</font> |  A: by host，B: by host, device，C: by host, device, os (`dimension_tags=host`)| 

*示例：*

选择监控器 A：by host；监控器 B：by host, device，此时取交集 `host` 作为最终的 `dimension_tags`，监控器 A 正常判断即可，监控器 B 中取主机的所有 `device` 的最严重等级作为其状态，例如：

![](../img/no-alert.png)

### 步骤二：事件通知

![](../img/8.monitor_1.png)


1）**事件标题**：设置告警触发条件的事件名称，支持使用预置的[模板变量](../event-template.md)。

**注
意**：最新版本中监控器名称将由事件标题输入后同步生成。旧的监控器中可能存在监控器名称和事件标题不一致的情况，为了给您更好的使用体验，请尽快同步至最新。

2）**事件内容**：满足触发条件时发送的事件通知内容。支持输入 Markdown 格式文本信息并预览效果，支持使用预置的关联链接，支持使用预置的[模板变量](../event-template.md)。

**注意**：不同告警通知对象支持的 Markdown 语法不同，例如：企业微信不支持无序列表。

**无数据通知配置**：支持自定义无数据通知内容，若没有配置，则自动使用官方默认的通知模版。

![](../img/8.monitor_2.png)


3）**关联异常追踪**：开启关联后，若该监控器下产生了异常事件，将同步创建 Issue。选择 Issue 的等级以及需要投递的目标频道，产生的 Issue 可以前往[异常追踪](../../exception/index.md) > 您选定的[频道](../../exception/channel.md)进行查看。

在事件恢复后，可以同步关闭 Issue。

![](../img/issue-create.png)

#### 事件内容自定义高级配置 {#advanced-settings}

观测云支持在事件内容中通过高级配置添加关联日志或错误堆栈，以便查看异常情况发生时的上下文数据情况：

![](../img/advanced-settings.png)

- 添加关联日志：

查询：

如：获取一条索引为 `default` 的日志 `message`：

```
{% set dql_data = DQL("L::RE(`.*`):(`message`) { `index` = 'default' } LIMIT 1") %}
```

关联日志：



```
{{ dql_data.message | limit_lines(10) }}
```

- 添加关联错误堆栈
  
查询：

```
{% set dql_data = DQL("T::re(`.*`):(`error_message`,`error_stack`){ (`source` NOT IN ['service_map', 'tracing_stat', 'service_list_1m', 'service_list_1d', 'service_list_1h', 'profile']) AND (`error_stack` = exists()) } LIMIT 1") %}
```

关联错误堆栈：

```
{{ dql_data.error_message | limit_lines(10) }}

{{ dql_data.error_stack | limit_lines(10) }}
```




### 步骤三：告警配置

[**告警策略**](../alert-setting.md)：监控满足触发条件后，立即发送告警消息给指定的通知对象。告警策略中包含需要通知的事件等级、通知对象、以及告警沉默周期。

告警策略支持单选或多选，点击策略名可展开详情页。若需修改策略点击**编辑告警策略**即可。

![](../img/policy-create.png)


### 步骤四：关联

![](../img/5.monitor_4.png)

**关联仪表板**：每一个监控器都支持关联一个仪表板，可快速跳转查看。

## FAQ

:material-chat-question: 如果 BY 配置不符合规则，监控器是否能配置成功？

不符合规范也可以创建成功，只是不会产生告警。

:material-chat-question: 如果配置了组合监控器，原始监控器是否会正常监控？

会正常告警，被组合的监控器不会受任何影响。

:material-chat-question: 组合监控怎么计算任务调用？

同样也是检测一次计为 1 次任务调用，检测频率和被组合监控器中最大的检测频率一致。