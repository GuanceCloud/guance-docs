# Kubernetes 智能检测
---

**Kubernetes 智能检测**基于智能检测算法，通过定期监控关键指标，如 Pod 总数、Pod 重启次数以及 API Server QPS 等，Kubernetes 智能检测能够及时发现并预测集群中可能出现的问题。这种方法不仅能识别出资源使用的异常波动，还能通过根因分析精确指出问题源头，无论是配置失误、资源不匹配还是请求过多。使 Kubernetes 集群的运维工作更加智能化和自动化。


## 应用场景

对集群的各项性能指标深入洞察，从集群资源、服务资源到 API server 层面提供全方位的监控能力。

## 新建

点击**智能监控 > 新建智能监控 > Kubernetes 智能检测**，进入规则的配置页面。

### 步骤一：检测配置 {#config}

![](../img/k8s.png)

1）**监控器名称**：支持编辑监控器名称。


2）**检测范围**：基于集群、命名空间和主机进行筛选，限定检测的数据范围。支持添加一个或多个标签筛选。若不添加筛选，检测所有指标数据。

### 步骤二：事件通知

![](../img/k8s-2.png)

1）**事件内容**：满足触发条件时发送的事件通知内容。支持输入 Markdown 格式文本信息并预览效果，支持使用预置的关联链接和[模板变量](../event-template.md)。

**注意**：不同告警通知对象支持的 Markdown 语法不同，例如：企业微信不支持无序列表。

2）**关联异常追踪**：开启关联后，若该监控器下产生了异常事件，将同步创建 Issue。选择 Issue 的等级以及需要投递的目标频道，产生的 Issue 可以前往[异常追踪](../../exception/index.md) > 您选定的[频道](../../exception/channel.md)进行查看。

在事件恢复后，可以同步关闭 Issue。

![](../img/issue-create.png)




### 步骤三：告警配置

![](../img/policy-create-1.png)

[**告警策略**](../alert-setting.md)：监控满足触发条件后，立即发送告警消息给指定的通知对象。告警策略中包含需要通知的事件等级、通知对象、以及告警沉默周期。

告警策略支持单选或多选，点击策略名可展开详情页。若需修改策略点击**编辑告警策略**即可。



## 查看事件

监控器会获取最近 10 分钟的检测应用程序服务对象指标信息，识别出现异常情况时，会生成相应的事件，在[**事件 > 智能监控**](../../events/inte-monitoring-event.md)列表可查看对应异常事件。

![](../img/intelligent-detection04.png)

### 事件详情页

点击**事件**，可查看智能监控事件的详情页，包括事件状态、异常发生时间、异常名称、分析报告、告警通知、历史记录和关联事件。

* 点击右上角的**跳转到监控器**，可查看调整[智能监控器配置](index.md)；

* 点击右上角的**导出**按钮，支持选择**导出 JSON 文件**与**导出 PDF 文件**，从而获取当前事件所对应的所有关键数据。

:material-numeric-1-circle-outline: 分析报告

![](../img/k8s-1.png)

<!--

![](../img/intelligent-detection12.png)
-->

* 异常总结：显示查看当前集群异常 APIServer 节点数分布情况统计。

* 异常分析：可查看 APIServer 节点数、API QPS、在处理读请求数量、写请求成功率、在处理写请求数量等信息。

<!--
**注意**：存在多个区间异常时，**异常分析**仪表板默认展示第一段异常区间的异常情况，可以点击【异常值分布图】进行切换，切换后异常分析仪表板同步联动。
-->

:material-numeric-2-circle-outline: [扩展字段](../../events/event-explorer/event-details.md#extension)

:material-numeric-3-circle-outline: [告警通知](../../events/event-explorer/event-details.md#alarm)

:material-numeric-4-circle-outline: [关联事件](../../events/event-explorer/event-details.md#relevance)



