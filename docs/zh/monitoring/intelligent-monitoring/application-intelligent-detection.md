# 应用智能检测
---


**应用智能检测**基于智能检测算法，智能识别应用请求数量的突增 / 突降、错误请求数量的突增、请求延迟的突增 / 突降 / 区间上升等异常情况，通过应用程序服务异常指标来自动进行异常分析。


## 应用场景

**应用智能检测**用于监控应用程序服务是否出现异常或中断，确保服务平稳运行状态。

## 新建

点击**智能监控 > 新建智能监控 > 应用智能检测**，进入规则的配置页面。

### 步骤一：检测配置 {#config}

![image](../img/intelligent-detection09.png)

1）**监控器名称**：支持编辑监控器名称。

2）**检测频率**：检测规则的执行频率，固定30分钟。

3）**筛选**：基于指标的标签对检测指标的数据进行筛选，限定检测的数据范围，支持添加一个或多个标签筛选。

### 步骤二：事件通知

![image](../img/intelligent-detection07.png)

4）**事件内容**：满足触发条件时发送的事件通知内容，支持输入 Markdown 格式文本信息，支持预览效果，支持使用预置的[关联链接](link-description.md)和[模板变量](../event-template.md)。

**注意**：不同告警通知对象支持的 Markdown 语法不同，例如：企业微信不支持无序列表。

5）**同步创建 Issue**：若该监控器下产生了异常事件，将同步创建 Issue 异常追踪，投递到异常追踪的频道中。您可以前往[异常追踪](../../exception/index.md) > 您选定的[频道](../../exception/channel.md)进行查看。

### 步骤三：告警配置

6）**告警策略**：监控满足触发条件后，立即发送告警消息给指定的通知对象。

**注意**：智能监控触发的事件等级为【重要】。

## 监控器列表

创建智能监控检测后，可在**智能监控**列表查看及管理检测规则。

![image](../img/intelligent-detection01.png)

### 列表操作

<div class="grid cards" markdown>

- [<font color="coral"> :fontawesome-solid-arrow-up-right-from-square: &nbsp; 监控器列表操作</font>](../monitor/index.md#list)

</div>

### 查看事件

监控器会获取最近 30 分钟的检测应用程序服务对象指标信息，识别出现异常情况时，会生成相应的事件，在[**事件 > 智能监控**](../../events/inte-monitoring-event.md)列表可查看对应异常事件。

![image](../img/intelligent-detection04.png)

#### 事件详情页

点击**事件**，可查看智能监控事件的详情页，包括事件状态、异常发生时间、异常名称、分析报告、告警通知、历史记录和关联事件。

* 点击右上角的**跳转到监控器**，可查看调整[智能监控器配置](index.md)；

* 点击右上角的**导出**按钮，支持选择**导出 JSON 文件**与**导出 PDF 文件**，从而获取当前事件所对应的所有关键数据。

:material-numeric-1-circle-outline: 分析报告

![](../img/intelligent-detection11.png)

![](../img/intelligent-detection12.png)

* 异常总结：显示查看当前异常应用程序服务标签、异常分析报告详情、异常值分布情况统计

* 资源分析：对请求数的监控，可查看资源请求数排行（TOP 10）、资源错误请求数排行（TOP 10）、资源每秒请求数排行（TOP 10）等信息

**注意**：存在多个区间异常时，**异常分析**仪表板默认展示第一段异常区间的异常情况，可以点击【异常值分布图】进行切换，切换后异常分析仪表板同步联动。

:material-numeric-2-circle-outline: [扩展字段](../../events/event-explorer/event-details.md#extension)

:material-numeric-3-circle-outline: [告警通知](../../events/event-explorer/event-details.md#alarm)

:material-numeric-4-circle-outline: [关联事件](../../events/event-explorer/event-details.md#relevance)




