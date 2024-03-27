# 用户访问智能检测
---


**用户访问智能检测**基于智能检测算法，智能检测用户访问网站/APP 的性能异常和错误突增情况。基于检测指标进行异常分析，并触发告警。

- 性能分析指标： LCP(>= 2.5 s)、INP (>= 200 ms)、FID (>= 100 ms)、CLS (> 0.01)；

基于性能分析指标，统计检测区间受影响用户占比，设置告警级别阈值：Critical > 76.2% 、 Warning > 47.4% 、 error > 59.8% .

- 错误检测指标：会话错误数、页面错误数、动作错误数。


## 应用场景

**用户访问智能检测**支持监控包括 Web、APP 应用类型的指标数据异常。

## 新建

点击**智能监控 > 新建智能监控 > 用户访问智能检测**，进入规则的配置页面。

### 步骤一：检测配置 {#config}

![](../img/intelligent-detection15.png) 

1）**监控器名称**：支持编辑监控器名称。

2）**检测频率**：检测规则的执行频率，固定 60 分钟。

3）**请选择检测范围**：通过字段过滤要检测的数据范围，若不添加筛选，检测所有应用的数据。

### 步骤二：事件通知

![](../img/intelligent-detection07.png)

1）**事件内容**：满足触发条件时发送的事件通知内容。支持输入 Markdown 格式文本信息并预览效果，支持使用预置的关联链接和[模板变量](../event-template.md)。

**注意**：不同告警通知对象支持的 Markdown 语法不同，例如：企业微信不支持无序列表。

2）**关联异常追踪**：开启关联后，若该监控器下产生了异常事件，将同步创建 Issue。选择 Issue 的等级以及需要投递的目标频道，产生的 Issue 可以前往[异常追踪](../../exception/index.md) > 您选定的[频道](../../exception/channel.md)进行查看。

在事件恢复后，可以同步关闭 Issue。

![](../img/issue-create.png)

#### 事件内容自定义高级配置 {#advanced-settings}

观测云支持在事件内容中通过高级配置添加关联日志或错误堆栈：

![](../img/advanced-settings.png)

- 添加关联日志：

查询：

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

![](../img/policy-create-1.png)

**[告警策略](../alert-setting.md)**：监控满足触发条件后，立即发送告警消息给指定的通知对象。告警策略中包含需要通知的事件等级、通知对象、及告警聚合。在选择某一个告警策略后，若需要修改，可点击**编辑告警策略**，即可进行相关操作。

**注意**：用户访问智能检测触发的事件等级为【紧急】【重要】【警告】。

<!--
## 监控器列表

创建智能监控检测后，可在**智能监控**列表查看及管理检测规则。

![image](../img/intelligent-detection01.png)

### 列表操作

<div class="grid cards" markdown>

- [<font color="coral"> :fontawesome-solid-arrow-up-right-from-square: &nbsp; 监控器列表操作</font>](../monitor/index.md#list)

</div>
-->

## 查看事件

监控器会获取最近 60 分钟的检测应用程序服务对象指标信息，识别出现异常情况时，会生成相应的事件，在[**事件 > 智能监控**](../../events/inte-monitoring-event.md)列表可查看对应异常事件。

![](../img/intelligent-detection04.png)

### 事件详情页

点击**事件**，可查看智能监控事件的详情页，包括事件状态、异常发生时间、异常名称、分析报告、告警通知、历史记录和关联事件。

* 点击右上角的**跳转到监控器**，可查看调整[智能监控器](index.md)；

* 点击右上角的**导出**按钮，支持选择**导出 JSON 文件**与**导出 PDF 文件**，从而获取当前事件所对应的所有关键数据。

:material-numeric-1-circle-outline: 分析报告

![](../img/intelligent-detection14.png)

![](../img/intelligent-detection16.png)

* 异常总结：显示查看用户访问服务标签、分析报告详情、异常分布情况统计；

* 页面性能/错误分析：关联用户访问页面仪表板，分析页面 LCP、FCP、页面错误率等指标趋势。

**注意**：存在多个区间异常时，**异常分析**仪表板默认展示第一段异常区间的异常情况，可以点击【异常值分布图】进行切换，切换后异常分析仪表板同步联动。

:material-numeric-2-circle-outline: [扩展字段](../../events/event-explorer/event-details.md#extension)

:material-numeric-3-circle-outline: [告警通知](../../events/event-explorer/event-details.md#alarm)

:material-numeric-4-circle-outline: [关联事件](../../events/event-explorer/event-details.md#relevance)




