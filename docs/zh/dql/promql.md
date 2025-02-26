# PromQL 快速上手

## 概述

[PromQL](https://prometheus.io/docs/prometheus/latest/querying/basics/) 是 [Prometheus 监控系统](https://prometheus.io/) 的查询语言，语法简洁又功能强大。PromQL 的语法跟一般的 SQL 语言很不一样，初学者往往需要花费几个小时阅读 [官方 PromQL 文档](https://prometheus.io/docs/prometheus/latest/querying/basics/) 才能理解它的工作原理。

这里请跟随我们的思路，一起快速理解 PromQL 的设计精髓并掌握 PromQL 的用法。

## 用 PromQL 选择时间序列

使用 PromQL 中选择时间序列直接写序列名称就可以。例如，以下查询将返回所有名称 `node_network_receive_bytes_total` 的时间序列:

```
node_network_receive_bytes_total
```

这个名称对应于 [node_exporter metric](https://github.com/prometheus/node_exporter)，包含了各种网络接口接收的字节数。这样一个简单的查询可能会返回具有以下标签的时间序列，对于 `eth0`，`eth1` 和 `eth2` 网络接口：

```
node_network_receive_bytes_total{device="eth0"}
node_network_receive_bytes_total{device="eth1"}
node_network_receive_bytes_total{device="eth2"}
```

不同的标签用大括号括起来：`{device="eth0"}`，`{device="eth1"}`，`{device="eth2"}`。

## 指标集 Measurement

在{{{ custom_key.brand_name }}}中的所有指标都是归属于指标集的，我们以指标集为单位管理指标的生命周期。而指标集 Measurement 这个概念在 Prometheus 中是不存在的，需要通过 Datakit 上报的时候可以手动配置或者根据前缀来自动生成，详细内容可以查看 [Datakit 的文档](../integrations/prom.md)。

我们继续以上面的 `node_network_receive_bytes_total` 指标为例，假设我们通过 Datakit 自动规则来生成，那么这个指标将会拆分为 Measurement 和 Field 两个部分，分别是 `node` 和 `network_receive_bytes_total`。

对应到查询上也会有略微改变，我们继续以上面提到的不同网络接口为例：

```
node:network_receive_bytes_total{device="eth0"}
node:network_receive_bytes_total{device="eth1"}
node:network_receive_bytes_total{device="eth2"}
```

可以观察到现在的指标名筛选格式变成了 `measurement:field` ，中间以冒号连接。

## 按标签过滤

单个指标名称可能对应于具有不同标签集的多个时间序列，就像上面的示例一样。如何选择仅匹配 `{device="eth1"}` 的时间序列？只需在查询中提及所需的标签即可：

```
node:network_receive_bytes_total{device="eth1"}
```

如果要选择除 `eth1` 之外的设备的所有时间序列，则只需在查询中将 `=` 替换为 `!=`：

```
node:network_receive_bytes_total{device!="eth1"}
```

如何选择以 `eth` 开头的设备的时间序列？只需使用正则表达式即可：

```
node:network_receive_bytes_total{device=~"eth.+"}
```

过滤器可以包含与Go兼容的任意正则表达式（也称为RE2）。

要选择不以 `eth` 开头的设备的所有时间序列，必须将 `=~` 替换为 `!~`：

```
node:network_receive_bytes_total{device!~"eth.+"}
```

## 按多个标签过滤

可以组合标签过滤器。例如，以下查询将仅返回以 `eth` 开头的设备的 `node42:9100` 实例上的时间序列：

```
node:network_receive_bytes_total{instance="node42:9100", device=~"eth.+"}
```

标签过滤器与它们之间使用 `and` 运算符组合，即“返回与这个过滤器匹配 `and` 那个过滤器匹配的时间序列”。如何实现 `or` 运算符？目前，PromQL 缺乏用于组合标签过滤器的 `or` 运算符，但在大多数情况下，它可以用正则表达式来代替。例如，以下查询将返回 `eth1` 或 `lo` 设备的时间序列：

```
node:network_receive_bytes_total{device=~"eth1|lo"}
```

## 按正则表达式过滤指标或指标集名称

指标集和指标名其实是具有特殊名称的普通标签：`__measurement__` 和 `__field__`，因此可以在这些标签上应用正则表达式来过滤你想要的数据。

例如，查询 `node` 指标集中所有具有 `network_receive_bytes_total` 或 `network_transmit_bytes_total` 指标名称的时间序列：

```
{__measurement__="node", __field__=~"network_(receive|transmit)_bytes_total"}
```

或者查询分布在 `node1` 和 `node2` 两个指标集中的 `network_receive_bytes_total` 或 `network_transmit_bytes_total` 指标名称的时间序列：

```
{__measurement__=~"node1|node2", __field__=~"network_(receive|transmit)_bytes_total"}
```

## 比较当前数据与历史数据

PromQL 允许查询历史数据并将其与当前数据组合/比较。只需在查询中添加 `offset`。例如，以下查询将返回 `node:network_receive_bytes_total` 名称的所有时间序列的一周前的数据：

```
node:network_receive_bytes_total offset 7d
```

以下查询将返回当前 GC 开销超过一个小时前 GC 开销的 1.5 倍的点。

```
go:memstats_gc_cpu_fraction > 1.5 * (go:memstats_gc_cpu_fraction offset 1h)
```

下面会介绍 `>` 和 `*` 运算符。

## 计算速率

仔细阅读者可能会注意到，图表对上面的所有查询都绘制不断增长的线：

![](img/promql.png)

这样的图形的可用性接近于零，因为它们显示难以解释的不断增长的计数器值，而我们需要画出网络带宽的图形。PromQL 具有一个函数 [rate](https://prometheus.io/docs/prometheus/latest/querying/functions/#rate)，它可以为所有匹配时间序列计算每秒速率：

```
rate(node:network_receive_bytes_total[5m])
```

现在这样的图形就可以理解了：

![](img/promql-1.png)

查询中的 `[5m]` 是什么意思？这是时间持续时间（d）。

在我们的情况下为 5 分钟 - 在计算每个图形点的每秒速率时向后查看。每个点的简化速率计算如下：`(Vcurr-Vprev) /（Tcurr-Tprev）`，其中 `Vcurr` 是当前点的值 `-Tcurr`，`Vprev` 是点上的值 `Tprev = Tcurr-d`。

如果这看起来太复杂了，那么只需记住更高的 `d` 会平滑图形，而较低的 `d` 会给图形带来更多噪音。

{{{ custom_key.brand_name }}}使用了一种 [PromQL 扩展语法 MetricsQL](metricsql.md) (感谢 [VictoriaMetrics](https://docs.victoriametrics.com/) 开源！)，在此情况下，`[d]` 可以省略在这种情况下，它等于图形上两个连续点之间的持续时间（也称为“步长”）：

```
rate(node:network_receive_bytes_total)
```

所以当你不清楚 `rate` 后面的持续时间应该怎么填写的时候，请放心直接省略吧。

## `rate` 的注意事项

`rate` 会去掉指标名称，但会保留内部时间序列的所有标签。

请勿将 `rate` 应用于可能上下波动的时间序列。这种时间序列称为[测量值](https://prometheus.io/docs/concepts/metric_types/#gauge)。`rate` 必须仅应用于[计数器](https://prometheus.io/docs/concepts/metric_types/#counter)，它们总是上升，但有时可能会重置为零（例如，在服务重新启动时）。

请勿使用 `irate` 代替 `rate`，因为 它[不能捕获峰值](https://medium.com/@valyala/why-irate-from-prometheus-doesnt-capture-spikes-45f9896d7832)，而且它并不比 `rate` 快多少。

## 算术运算符

PromQL 支持所有基本的[算术运算](https://prometheus.io/docs/prometheus/latest/querying/operators/#arithmetic-binary-operators)：

- 加法（+）
- 减法（-）
- 乘法（*）
- 除法（/）
- 取模（%）
- 指数（^）

这使得可以执行各种转换。例如，将字节/秒转换为位/秒：

```
rate(node:network_receive_bytes_total[5m]) * 8
```

此外，这使得可以执行跨时间序列的计算。例如，[这篇文章中的 Flux 查询](https://www.influxdata.com/blog/practical-uses-of-cross-measurement-math-in-flux/) 可以简化为以下 PromQL 查询：

```
co2 * (((temp_c + 273.15) * 1013.25) / (pressure * 298.15))
```

使用算术运算符组合多个时间序列需要了解[匹配规则](https://prometheus.io/docs/prometheus/latest/querying/operators/#vector-matching)。否则，查询可能会出错或导致不正确的结果。匹配规则的基础很简单：

- PromQL 引擎从左右两侧的所有时间序列中剥离度量名称，而不触及标签。
- 对于左侧的每个时间序列，PromQL 引擎在右侧搜索具有相同标签集的相应时间序列，对每个数据点应用操作，并返回具有相同标签集的结果时间序列。如果没有匹配项，则从结果中删除时间序列。

匹配规则可以使用 `ignoring`、`on`、`group_left` 和 `group_right` 修饰符进行增强。这非常复杂，但在大多数情况下不需要使用这些修饰符。

## PromQL 比较运算符

PromQL 支持以下[比较运算符](https://prometheus.io/docs/prometheus/latest/querying/operators/#comparison-binary-operators)：

- 等于（==）
- 不等于（！=）
- 大于（>）
- 大于或等于（>=）
- 小于（<）
- 小于或等于（<=）

这些运算符可以应用于任意 PromQL 表达式，就像算术运算符一样。比较运算的结果是匹配数据点的时间序列。例如，以下查询将仅返回带宽小于 2300 字节/秒的时间序列：

```
rate(node:network_receive_bytes_total[5m]) < 2300
```

这将导致以下带有间隙的图形，其中带宽超过 2300 字节/秒：

```
rate(node:network_receive_bytes_total[5m]) < 2300
```

比较运算符的结果可以使用 `bool` 修饰符增强：

```
rate(node:network_receive_bytes_total[5m]) < bool 2300
```

在这种情况下，结果将包含 1 表示 true 的比较和 0 表示 false 的比较：

```
rate(node:network_receive_bytes_total[5m]) < bool 2300
```

## 聚合和分组函数

PromQL 允许[聚合和分组时间序列](https://prometheus.io/docs/prometheus/latest/querying/operators/#aggregation-operators)。时间序列按给定的标签集进行分组，然后为每个组应用给定的聚合函数。例如，以下查询将返回在所有安装了 `node_exporter` 的节点上按实例分组的摘要入口流量：

```
sum(rate(node:network_receive_bytes_total[5m])) by (instance)
```

## 使用 Gauges

Gauges 是可以随时上下浮动的时间序列。例如，内存使用、温度或压力。在为仪表盘绘制图形时，预期每个点上的最小值、最大值、平均值和/或分位数值。PromQL 允许使用[以下函数](https://prometheus.io/docs/prometheus/latest/querying/functions/#aggregation_over_time)来实现：

例如，以下查询将为图形上的每个点绘制空闲内存的最小值：

```
min_over_time(node:memory_MemFree_bytes[5m])
```

MetricsQL 将 [rollup_*](https://docs.victoriametrics.com/MetricsQL.html#rollup) 函数添加到 PromQL 中，当应用于 Gauges 时自动返回 `min`、`max` 和 `avg` 值。例如：

```
rollup(node:memory_MemFree_bytes)
```

## 标签的操作

PromQL 提供了两个函数，用于标签的修改、美化、删除或创建：

尽管这些函数使用起来很笨拙，但它们允许对所选时间序列的标签进行强大的动态操作。 label_ 函数的主要用途是将标签转换为所需的视图。

MetricsQL 通过[更方便的标签操作函数](https://docs.victoriametrics.com/MetricsQL.html#label-manipulation-functions)扩展了这些函数：

- label_set — 为时间序列设置额外标签
- label_del — 从时间序列中删除给定标签
- label_keep — 除给定标签外，从时间序列中删除所有标签
- label_copy — 将标签值复制到其他标签
- label_move — 重命名标签
- label_transform — 将所有与给定正则表达式匹配的子字符串替换为模板替换
- label_value — 从给定标签返回数值

## 从单个查询中返回多个结果

有时需要从单个 PromQL 查询返回多个结果。这可以通过 [or 运算符](https://prometheus.io/docs/prometheus/latest/querying/operators/#logical-set-binary-operators)来实现。例如，以下查询将返回所有名称为`metric1`、`metric2` 和 `metric3` 的时间序列：

```
metric1 or metric2 or metric3
```

MetricsQL [简化](https://docs.victoriametrics.com/MetricsQL.html#union)了返回多个结果的过程-只需在 `()` 中列举它们：

```
(metric1、metric2、metric3)
```

请注意：任意的 PromQL 表达式都可以放在那里而不是指标名称。

在组合表达式结果时，有一个常见的陷阱：具有重复标签集的结果将被跳过。例如，以下查询将跳过 `sum(b)`，因为 `sum(a)` 和 `sum(b)` 都具有相同的标签集——它们根本没有标签：

```
sum(a) or sum(b)
```

## 结论

PromQL 是一种易于使用但功能强大的时间序列数据库查询语言。与 SQL、InfluxQL 或 Flux 相比，它允许以简洁而清晰的方式编写典型的 TSDB 查询。

本教程未涵盖 PromQL 的所有功能，因为有些特性并不是很常用：

- 它没有提到许多[函数](https://prometheus.io/docs/prometheus/latest/querying/functions/)和[逻辑运算符](https://prometheus.io/docs/prometheus/latest/querying/operators/#logical-set-binary-operators)。 
- 它不涵盖常见的表达式(即CTE或 [WITH 模板](https://victoriametrics.com/promql/expand-with-exprs)) 
- 它没有涵盖 [MetricsQL](https://docs.victoriametrics.com/MetricsQL.html) 支持的许多有用功能。  
     
你可以使用这个 [PromQL 速查表](https://promlabs.com/promql-cheat-sheet/)继续学习 PromQL。   

*本文主体内容翻译自 [PromQL tutorial for beginners and humans](https://valyala.medium.com/promql-tutorial-for-beginners-9ab455142085) ，{{{ custom_key.brand_name }}}也正在使用 [VictoriaMetrics](https://github.com/VictoriaMetrics/VictoriaMetrics) 开源的 [MetricsQL](https://docs.victoriametrics.com/MetricsQL.html) 引擎的实现，再次感谢 VictoriaMetrics ！*

## 更多阅读

<div class="grid cards" markdown>

- [<font color="coral"> :fontawesome-solid-arrow-right-long: &nbsp; **MetricsQL 语法参考**</font>](./metricsql.md)

</div>