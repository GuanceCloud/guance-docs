# MetricsQL 语法参考

当前在<<< custom_key.brand_name >>>的仪表盘中，你可以使用 MetricsQL 语言来查询 Pormetheus 指标。

MetricsQL 是由 VictoriaMetrics 开发的 PromQL 语法增强语言，在绝大部分的情况下 MetricsQL 都可以兼容 PormQL 的查询，但也对 PormQL 中一些不够直观和方便的地方做了增强和优化，[这篇文章](https://medium.com/@romanhavronenko/victoriametrics-promql-compliance-d4318203f51e)介绍了更多的兼容设计细节。

在绝大部分情况下，你都可以按照你理解的 PromQL 语法来进行查询，这通常不会出错。当你遇到一些比较棘手的问题时，比如希望对 gauge 数据计算 p95、希望 topk 能返回准确个数的序列等情况时，你就可以通过下面的语法参考寻找答案了。

对比 MetricsQL 与 PromQL 语法，它们有如下主要差异：

- MetricsQL 考虑了回溯窗口中的前一个点，适用于范围函数，例如 [rate](#rate) 和 [increase](#increase)。这允许返回用户对 `increase(metric[$__interval])` 查询的确切结果，而不是 Prometheus 针对此类查询返回的不完整结果。
- MetricsQL 不会推测范围函数的结果，这解决了 PromQL 中的[此问题](https://github.com/prometheus/prometheus/issues/3746)。有关 PromQL 和 MetricsQL 计算 [rate](#rate) 和 [increase](#increase) 的技术细节，请参见[此问题中的评论](https://github.com/VictoriaMetrics/VictoriaMetrics/issues/1215#issuecomment-850305711)。
- MetricsQL 针对 `step` 值小于采集间隔的 [rate](#rate)，返回预期的非空响应。这解决了 Grafana 展示的[问题](https://github.com/grafana/grafana/issues/11451)。另请参见[此博客文章](https://www.percona.com/blog/2020/02/28/better-prometheus-rate-function-with-victoriametrics/)。
- MetricsQL 将 `scalar` 类型与不带标签的 `instant vector` 视为相同，因为这两种类型之间的微妙差异通常会使用户感到困惑。有关详细信息，请参见[相应的 Prometheus 文档](https://prometheus.io/docs/prometheus/latest/querying/basics/#expression-language-data-types)。
- MetricsQL 从输出中删除所有 `NaN` 值，因此某些查询（例如 `(-1)^0.5）` 在 MetricsQL 中返回空结果，而在 PromQL 中返回一系列 `NaN` 值。请注意，前端不会为 `NaN` 值绘制任何线条或点，因此无论是 MetricsQL 还是 PromQL 的最终结果都是相同的。
- MetricsQL 在应用函数后保留指标名称，这些函数不会改变原始时间序列的含义。例如，[min_over_time(foo)](#min_over_time) 或 [round(foo)](#round) 在结果中保留了 `foo` 指标名称。有关详细信息，请参见[此问题](https://github.com/VictoriaMetrics/VictoriaMetrics/issues/674)。


同时你依旧要注意在<<< custom_key.brand_name >>>中使用，与原版 MetricsQL 仍有差异：

- 支持 measurement 选择，需要在指标名前面拼接 measurement，以冒号分隔 `increase(measurement:metric[1m])`，当不写 measurement 时查询性能会显著下降
- <<< custom_key.brand_name >>> UI 暂不支持手动配置 `step` ，目前的 `step` 根据时间范围和显示密度自动计算
- <<< custom_key.brand_name >>> UI 暂不支持热力图 (Heatmap) 类型的图形展示，可能影响 Historgram 的显示效果

<font color=coral>本篇文章内容主要来源于对 <u>https://docs.victoriametrics.com/MetricsQL.html</u> 的翻译，当中文翻译有歧义时，也可以对照原文阅读。</font>

## 功能列表

MetricsQL 包含如下功能：

- 可以忽略方括号中的回溯窗口。MetricsQL 根据用于构建图形的 `step` 自动选择向后查看的窗口。以下查询在 MetricsQL 中有效：`rate(node_network_receive_bytes_total)`。当在 Grafana 中使用时，它等效于 `rate(node_network_receive_bytes_total[$__interval])`。
- [聚合函数](#aggregate-functions)可以接受任意数量的参数。例如，`avg(q1, q2, q3)` 将为 `q1`、`q2` 和 `q3` 返回每个点的平均值。
- 可以将 [@修饰符](https://prometheus.io/docs/prometheus/latest/querying/basics/#modifier) 放置在查询中的任何位置。例如，`sum(foo) @ end()` 计算所选时间范围 `[start ... end]` 的 `sum(foo)` 在 `end` 时间戳处的值。
- 可以使用任意子表达式作为 [@修饰符](https://prometheus.io/docs/prometheus/latest/querying/basics/#modifier)。例如，`foo @ (end() - 1h)` 在所选时间范围 `[start ... end]` 的 `end - 1h` 时间戳上计算 `foo`。
- [offset](https://prometheus.io/docs/prometheus/latest/querying/basics/#offset-modifier)、方括号中的回溯窗口和 [subquery](#subqueries) 中的 `step` 值可以使用 `[Ni]` 语法引用当前步骤，在 Grafana 中也称为 `$__interval` 值。例如，`rate(metric[10i] offset 5i)` 将返回覆盖前 10 个 `step` 并具有 5 个 `step` 偏移量的每秒速率。
- [offset](https://prometheus.io/docs/prometheus/latest/querying/basics/#offset-modifier) 可以放置在查询中的任何位置。例如，`sum(foo) offset 24h`。
- 方括号中的回溯窗口和 [offset](https://prometheus.io/docs/prometheus/latest/querying/basics/#offset-modifier) 可以是分数。例如，`rate(node_network_receive_bytes_total[1.5m] offset 0.5d)`。
- 持续时间后缀是可选的。如果省略后缀，则持续时间为秒。例如，`rate(m[300] offset 1800)` 相当于 `rate(m[5m]) offset 30m`。
- 可以将持续时间放置在查询中的任何位置。例如，`sum_over_time(m[1h]) / 1h` 等效于 `sum_over_time(m[1h]) / 3600`。
- 数值可以带有 `K`、`Ki`、`M`、`Mi`、`G`、`Gi`、`T` 和 `Ti` 后缀。例如，`8K` 相当于 `8000`，而 `1.2Mi` 相当于 `1.2*1024*1024`。
- 所有列表上末尾随逗号都是允许的，比如标签过滤器、函数参数和表达式。例如，以下查询是有效的：`m{foo="bar",}`、`f(a, b,)`、`WITH (x=y,) x`，这简化了多行查询的维护。
- 指标名称和标签名称可以包含任何 Unicode 字母。例如，`температура{город="Киев"}` 是一个 MetricsQL 表达式。
- 指标名称和标签名称可以包含转义字符。例如，`foo\\\\-bar{baz\\\\=aa="b"}` 是有效的表达式。它返回名称为 `foo-bar` 的时间序列，其中包含带有值 `b` 的标签 `baz=aa`。此外，还支持以下转义序列： 
    - `\\\\xXX`，其中 `XX` 是转义 ASCII 字符的十六进制表示。 
    - `\\\\uXXXX`，其中 `XXXX` 是转义 Unicode 字符的十六进制表示。
- 聚合函数支持可选的 `limit N` 后缀，以限制输出系列的数量。例如，`sum(x) by (y) limit 3` 将聚合后的输出时间序列数限制为 3。所有其他时间序列都将被删除。
- [histogram_quantile](#histogram_quantile)接受可选的第三个参数 `boundsLabel`。在这种情况下，它返回估计的百分位数的 `lower` 和 `upper` 边界。有关详细信息，请参见[此问题](https://github.com/prometheus/prometheus/issues/5706)。
- `default` 二元运算符。`q1 default q2` 使用 `q2` 中的相应值填充 `q1` 中的空隙。
- `if`二元运算符。`q1 if q2` 删除 `q2` 中缺少的值的 `q1` 中的值。
- `ifnot` 二元运算符。`q1 ifnot q2` 删除 `q2` 中存在的 `q1` 中的值。
- `WITH` 模板。此功能简化了编写和管理复杂查询。你可以在 [WITH templates playground](https://play.victoriametrics.com/select/accounting/1/6a716b0f-38bc-4856-90ce-448fd713e3fe/expand-with-exprs) 尝试。
- 字符串文字可以连接。这在 `WITH` 模板中很有用：`WITH (commonPrefix="long_metric_prefix_") {__name__=commonPrefix+"suffix1"} / {__name__=commonPrefix+"suffix2"}`。
- 可以将 `keep_metric_names` 修改符应用于所有 [Rollup 函数](#rollup-functions)和 [转换函数](#transform-functions)。该修饰符会防止在函数结果中删除指标名称。请参见[这些文档](#keep_metric_names)。

## keep_metric_names

默认情况下，在应用更改原始时间序列含义的函数后，指标名称会被删除。当将函数应用于具有不同名称的多个时间序列时，这可能会导致“重复时间序列”错误。可以通过将 `keep_metric_names` 修饰符应用到函数中来解决此错误。

例如，`rate({__name__=~"foo|bar"}) keep_metric_names` 在返回的时间序列中保留了 `foo` 和 `bar` 的指标名称。

## MetricsQL 函数

MetricsQL 提供以下函数：

- [Rollup 函数](#rollup-functions)
- [转换函数](#transform-functions)
- [标签操作函数](#label-manipulation-functions)
- [聚合函数](#aggregate-functions)

### Rollup 函数

**Rollup 函数** (也称为范围函数或窗口函数) 在给定的回溯窗口上对 **原始样本** 进行滚动计算，适用于[序列选择器](https://docs.victoriametrics.com/keyConcepts.html#filtering)。例如，`avg_over_time(temperature[24h])` 计算最近 24 小时内原始样本的平均温度。

其他详细信息：

- 如果使用 Rollup 函数构建图形，则每个图形上的每个点都会独立计算 Rollup。例如，`avg_over_time(temperature[24h])` 图形的每个点显示最后 24 小时的平均温度。点之间的间隔由前端传递的 `step` 查询参数设置。
- 如果给定的 [序列选择器](https://docs.victoriametrics.com/keyConcepts.html#filtering) 返回多个时间序列，则分别计算每个返回的系列的滚动计算。
- 如果在方括号中缺少回溯窗口，则 MetricsQL 会自动将回溯窗口设置为图形上点之间的间隔（也称为 `step` 查询参数在 [/api/v1/query_range](https://docs.victoriametrics.com/keyConcepts.html#range-query)、Grafana 中的 `$__interval` 值或 MetricsQL 中的 `1i` 持续时间）。例如，`rate(http_requests_total)` 等同于 `rate(http_requests_total[$__interval])`；在 MetricsQL 中。它也等同于 `rate(http_requests_total[1i])`。
- MetricsQL 中的每个 [序列选择器](https://docs.victoriametrics.com/keyConcepts.html#filtering) 都必须包装到一个 Rollup 函数中。否则，它会在执行计算之前自动转换为 [default_rollup](#default_rollup)。例如，`foo{bar="baz"}` 在执行计算之前会自动转换为 `default_rollup(foo{bar="baz"}[1i])`。
- 如果将除 [序列选择器](https://docs.victoriametrics.com/keyConcepts.html#filtering) 之外的其他内容传递给 Rollup 函数，则内部参数会自动转换为 [subquery](#subqueries)。
- 所有 Rollup 函数都接受可选的 `keep_metric_names` 修饰符。如果设置了该修饰符，则函数会在结果中保留指标名称。请参阅[这些文档](#keep_metric_names)。

> 请参见[隐式查询转换](#implicit-query-conversions)。

### 支持的 Rollup 函数列表

#### absent_over_time

`absent_over_time(series_selector[d])` 是一个 [Rollup 函数](#rollup-functions)，如果给定的前置窗口 `d` 中不包含原始样本，则返回 1。否则，返回空结果。

> 此函数由 PromQL 支持。另请参见[present_over_time](#present_over_time)。

#### aggr_over_time

`aggr_over_time(("rollup_func1","rollup_func2",...), series_selector[d])` 是一个 [Rollup 函数](#rollup-functions)，它为给定的 [序列选择器](https://docs.victoriametrics.com/keyConcepts.html#filtering) 中的每个时间序列分别计算所有列出的 `rollup_func*`。`rollup_func*` 可以包含任何 Rollup 函数。例如，`aggr_over_time(("min_over_time","max_over_time","rate"), m[d])` 将计算 `m[d]` 的 [min_over_time](#min_over_time)、[max_over_time](#max_over_time) 和 [rate](#rate)。

#### ascent_over_time

`ascent_over_time(series_selector[d])` 是一个 [Rollup 函数](#rollup-functions)，它计算给定前置窗口 `d` 上原始样本值的上升。计算是针对返回的每个时间系列单独执行的。

此函数对于跟踪 GPS 中的高度增益很有用。度量名称从结果的累加值中剥离。添加 [keep_metric_names](#keep_metric_names) 修饰符以保留度量名称。

> 另请参见 [descent_over_time](#descent_over_time)。

#### avg_over_time

`avg_over_time(series_selector[d])` 是一个 [Rollup 函数](#rollup-functions)，它计算给定前置窗口 `d` 上原始样本值的平均值，每个时间系列返回的给定[序列选择器](https://docs.victoriametrics.com/keyConcepts.html#filtering)。

> 此函数由 PromQL 支持。另请参见[median_over_time](#median_over_time)。

#### changes

`changes(series_selector[d])` 是一个 [Rollup 函数](#rollup-functions)，它计算给定前置窗口 `d` 中原始样本更改的次数，每个时间序列返回的给定 [序列选择器](https://docs.victoriametrics.com/keyConcepts.html#filtering)。与 Prometheus 中的 `changes()` 不同，它考虑了给定前置窗口 `d` 之前的最后一个样本的更改。有关详细信息，请参见[此文章](https://medium.com/@romanhavronenko/victoriametrics-promql-compliance-d4318203f51e)。

度量名称从结果的累加值中剥离。添加 [keep_metric_names](#keep_metric_names) 修饰符以保留度量名称。

> 此函数由 PromQL 支持。另请参见 [changes_prometheus](#changes_prometheus)。

#### changes_prometheus

`changes_prometheus(series_selector[d])` 是一个 [Rollup 函数](#rollup-functions)，它计算给定前置窗口 `d` 中原始样本更改的次数，每个时间序列返回的给定 [序列选择器](https://docs.victoriametrics.com/keyConcepts.html#filtering)。它不像 Prometheus 一样考虑给定前置窗口 `d` 之前的最后一个样本的更改。有关详细信息，请参见[此文章](https://medium.com/@romanhavronenko/victoriametrics-promql-compliance-d4318203f51e)。

度量名称从结果的累加值中剥离。添加 [keep_metric_names](#keep_metric_names) 修饰符以保留度量名称。

> 此函数由 PromQL 支持。另请参见 [changes](#changes)。

#### count_eq_over_time

`count_eq_over_time(series_selector[d], eq)` 是一个 [Rollup 函数](#rollup-functions)，它计算给定前置窗口 `d` 上等于 `eq` 的原始样本数量，每个时间序列返回的给定 [序列选择器](https://docs.victoriametrics.com/keyConcepts.html#filtering)。度量名称从结果的累加值中剥离。添加 [keep_metric_names](#keep_metric_names) 修饰符以保留度量名称。

> 另请参见 [count_over_time](#count_over_time)。

#### count_gt_over_time

`count_gt_over_time(series_selector[d], gt)` 是一个 [Rollup 函数](#rollup-functions)，它计算给定前置窗口 `d` 上大于`gt`的原始样本数量，每个时间序列返回的给定 [序列选择器](https://docs.victoriametrics.com/keyConcepts.html#filtering)。度量名称从结果的累加值中剥离。添加 [keep_metric_names](#keep_metric_names) 修饰符以保留度量名称。

> 另请参见 [count_over_time](#count_over_time)。

#### count_le_over_time

`count_le_over_time(series_selector[d], le)` 是一个 [Rollup 函数](#rollup-functions)，它计算给定前置窗口 `d` 上不超过`le`的原始样本数量，每个时间序列返回的给定 [序列选择器](https://docs.victoriametrics.com/keyConcepts.html#filtering)。度量名称从结果的累加值中剥离。添加 [keep_metric_names](#keep_metric_names) 修饰符以保留度量名称。

> 另请参见 [count_over_time](#count_over_time)。

#### count_ne_over_time

`count_ne_over_time(series_selector[d], ne)` 是一个 [Rollup 函数](#rollup-functions)，它计算给定前置窗口 `d` 上不等于`ne`的原始样本数量，每个时间序列返回的给定 [序列选择器](https://docs.victoriametrics.com/keyConcepts.html#filtering)。度量名称从结果的累加值中剥离。添加 [keep_metric_names](#keep_metric_names) 修饰符以保留度量名称。

> 另请参见 [count_over_time](#count_over_time)。

#### count_over_time

`count_over_time(series_selector[d])` 是一个 [Rollup 函数](#rollup-functions)，它计算给定前置窗口 `d` 上原始样本数量，每个时间序列返回的给定 [序列选择器](https://docs.victoriametrics.com/keyConcepts.html#filtering)。度量名称从结果的累加值中剥离。添加 [keep_metric_names](#keep_metric_names) 修饰符以保留度量名称。

> 此函数由 PromQL 支持。另请参见 [count_le_over_time](#count_le_over_time)、[count_gt_over_time](#count_gt_over_time)、[count_eq_over_time](#count_eq_over_time) 和 [count_ne_over_time](#count_ne_over_time)。

#### decreases_over_time

`decreases_over_time(series_selector[d])` 是一个 [Rollup 函数](#rollup-functions)，它计算给定前置窗口 `d` 上原始样本值减少的数量，每个时间序列返回的给定 [序列选择器](https://docs.victoriametrics.com/keyConcepts.html#filtering)。度量名称从结果的累加值中剥离。添加 [keep_metric_names](#keep_metric_names) 修饰符以保留度量名称。

> 另请参见 [increases_over_time](#increases_over_time)。

#### default_rollup

`default_rollup(series_selector[d])` 是一个 [Rollup 函数](#rollup-functions)，它返回给定前置窗口 `d` 上的最后一个原始样本值，每个时间序列返回的给定 [序列选择器](https://docs.victoriametrics.com/keyConcepts.html#filtering)。

#### delta

`delta(series_selector[d])` 是一个 [Rollup 函数](#rollup-functions)，它计算给定前置窗口 `d` 中最后一个样本与给定前置窗口 `d` 中最后一个样本之间的差异，每个时间序列返回的给定 [序列选择器](https://docs.victoriametrics.com/keyConcepts.html#filtering)。MetricsQL 中 `delta()` 函数的行为与 Prometheus 中 `delta()` 函数的行为略有不同。有关详细信息，请参见[此文章](https://medium.com/@romanhavronenko/victoriametrics-promql-compliance-d4318203f51e)。

度量名称从结果的累加值中剥离。添加 [keep_metric_names](#keep_metric_names) 修饰符以保留度量名称。

> 此函数由 PromQL 支持。另请参见 [increase](#increase) 和 [delta_prometheus](#delta_prometheus)。

#### delta_prometheus

`delta_prometheus(series_selector[d])` 是一个 [Rollup 函数](#rollup-functions)，它计算给定前置窗口 `d` 中第一个和最后一个样本之间的差异，每个时间序列返回的给定 [序列选择器](https://docs.victoriametrics.com/keyConcepts.html#filtering)。

`delta_prometheus()` 的行为与 Prometheus 中 `delta()` 函数的行为接近。有关详细信息，请参见[此文章](https://medium.com/@romanhavronenko/victoriametrics-promql-compliance-d4318203f51e)。

度量名称从结果的累加值中剥离。添加 [keep_metric_names](#keep_metric_names) 修饰符以保留度量名称。

> 另请参见 [delta](#delta)。

#### deriv

`deriv(series_selector[d])` 是一个 [Rollup 函数](#rollup-functions)，它计算给定 [序列选择器](https://docs.victoriametrics.com/keyConcepts.html#filtering) 返回的每个时间序列上的每秒导数，使用线性回归计算。

结果中的指标名称将被删除。添加 [keep_metric_names](#keep_metric_names) 修饰符以保留指标名称。

> 此函数由 PromQL 支持。另请参见 [deriv_fast](#deriv_fast) 和 [ideriv](#ideriv)。

#### deriv_fast

`deriv_fast(series_selector[d])` 是一个 [Rollup 函数](#rollup-functions)，它使用给定的回溯窗口 `d` 中的第一个和最后一个原始样本计算每个时间序列的每秒导数。

结果中的指标名称将被删除。添加 [keep_metric_names](#keep_metric_names) 修饰符以保留指标名称。

> 另请参见 [deriv](#deriv) 和 [ideriv](#ideriv)。

#### descent_over_time

`descent_over_time(series_selector[d])` 是一个 [Rollup 函数](#rollup-functions)，它计算给定回溯窗口 `d` 中原始样本值的下降。对于返回的每个时间序列，计算是单独执行的。

此函数对于跟踪 GPS 跟踪中的高度损失非常有用。

结果中的指标名称将被删除。添加 [keep_metric_names](#keep_metric_names) 修饰符以保留指标名称。

> 另请参见 [ascent_over_time](#ascent_over_time)。

#### distinct_over_time

`distinct_over_time(series_selector[d])` 是一个 [Rollup 函数](#rollup-functions)，它返回给定回溯窗口 `d` 中每个时间序列上不同原始样本值的数量。

结果中的指标名称将被删除。添加 [keep_metric_names](#keep_metric_names) 修饰符以保留指标名称。

#### duration_over_time

`duration_over_time(series_selector[d], max_interval)` 是一个 [Rollup 函数](#rollup-functions)，它返回给定 [序列选择器](https://docs.victoriametrics.com/keyConcepts.html#filtering) 在回溯窗口 `d` 中存在的持续时间（以秒为单位）。预计每个系列中相邻样本之间的间隔不会超过 `max_interval`。否则，这样的间隔被视为间隙，不被计算。

结果中的指标名称将被删除。添加 [keep_metric_names](#keep_metric_names) 修饰符以保留指标名称。

> 另请参见 [lifetime](#lifetime) 和 [lag](#lag)。

#### first_over_time

`first_over_time(series_selector[d])` 是一个 [Rollup 函数](#rollup-functions)，它返回给定回溯窗口 `d` 中每个时间序列上的第一个原始样本值。

> 另请参见 [last_over_time](#last_over_time) 和 [tfirst_over_time](#tfirst_over_time)。

#### geomean_over_time

`geomean_over_time(series_selector[d])` 是一个 [Rollup 函数](#rollup-functions)，它计算给定回溯窗口 `d` 中原始样本的几何平均值。对于返回的每个时间序列，计算是单独执行的。

结果中的指标名称将被删除。添加 [keep_metric_names](#keep_metric_names) 修饰符以保留指标名称。

#### histogram_over_time

`histogram_over_time(series_selector[d])` 是一个 [Rollup 函数](#rollup-functions)，它在给定回溯窗口 `d` 中的原始样本上计算 [VictoriaMetrics 直方图](https://godoc.org/github.com/VictoriaMetrics/metrics#Histogram)。它针对返回的每个 [序列选择器](https://docs.victoriametrics.com/keyConcepts.html#filtering) 中的时间序列单独计算。生成的直方图对于传递给 [histogram_quantile](#histogram_quantile) 以计算多个 [gauges](https://docs.victoriametrics.com/keyConcepts.html#gauge) 的分位数非常有用。例如，以下查询计算过去 24 小时每个国家的中位数温度：

`histogram_quantile(0.5, sum(histogram_over_time(temperature[24h])) by (vmrange,country))`。

#### hoeffding_bound_lower

`hoeffding_bound_lower(phi, series_selector[d])` 是一个 [Rollup 函数](#rollup-functions)，它计算给定范围 `[0...1]` 中给定 `phi` 的下限 [Hoeffding 界](https://en.wikipedia.org/wiki/Hoeffding's_inequality)。

> 另请参见 [hoeffding_bound_upper](#hoeffding_bound_upper)。

#### hoeffding_bound_upper

`hoeffding_bound_upper(phi, series_selector[d])` 是一个 [Rollup 函数](#rollup-functions)，它计算给定范围 `[0...1]` 中给定 `phi` 的上限 [Hoeffding 界](https://en.wikipedia.org/wiki/Hoeffding's_inequality)。

> 另请参见 [hoeffding_bound_lower](#hoeffding_bound_lower)。

#### holt_winters

`holt_winters(series_selector[d], sf, tf)` 是一个 [Rollup 函数](#rollup-functions)，它使用给定的平滑因子 `sf` 和趋势因子 `tf`，计算原始样本在给定回溯窗口 `d` 上的 Holt-Winters 值（又称 [双重指数平滑](https://en.wikipedia.org/wiki/Exponential_smoothing#Double_exponential_smoothing)）。`sf` 和 `tf` 都必须在范围 `[0...1]` 中。预计 [序列选择器](https://docs.victoriametrics.com/keyConcepts.html#filtering) 返回 [gauge 类型](https://docs.victoriametrics.com/keyConcepts.html#gauge) 的时间序列。

> 此函数由 PromQL 支持。另请参见 [range_linear_regression](#range_linear_regression)。

#### idelta

`idelta(series_selector[d])` 是一个 [Rollup 函数](#rollup-functions)，它计算给定回溯窗口 `d` 中每个时间序列中最后两个原始样本之间的差异。

结果中的指标名称将被删除。添加 [keep_metric_names](#keep_metric_names) 修饰符以保留指标名称。

> 此函数由 PromQL 支持。另请参见 [delta](#delta)。

#### ideriv

`ideriv(series_selector[d])` 是一个 [Rollup 函数](#rollup-functions)，它基于给定回溯窗口 `d` 上的最后两个原始样本，计算每个时间序列的每秒导数。对于返回的每个 [序列选择器](https://docs.victoriametrics.com/keyConcepts.html#filtering) 中的时间序列，计算是单独执行的。

结果中的指标名称将被删除。添加 [keep_metric_names](#keep_metric_names) 修饰符以保留指标名称。

> 另请参见 [deriv](#deriv)。

#### increase

`increase(series_selector[d])` 是一个 [Rollup 函数](#rollup-functions)，它计算给定回溯窗口 `d` 中每个时间序列的增量。预计 [序列选择器](https://docs.victoriametrics.com/keyConcepts.html#filtering) 返回 [counter 类型](https://docs.victoriametrics.com/keyConcepts.html#counter) 的时间序列。

与 Prometheus 不同，它在计算结果时考虑了给定回溯窗口 `d` 之前的最后一个样本。详情请参见[此文章](https://medium.com/@romanhavronenko/victoriametrics-promql-compliance-d4318203f51e)。

结果中的指标名称将被删除。添加 [keep_metric_names](#keep_metric_names) 修饰符以保留指标名称。

> 此函数由 PromQL 支持。另请参见 [increase_pure](#increase_pure)、[increase_prometheus](#increase_prometheus) 和 [delta](#delta)。

#### increase_prometheus

`increase_prometheus(series_selector[d])` 是一个 [Rollup 函数](#rollup-functions)，它计算给定回溯窗口 `d` 中每个时间序列的增量。预计 [序列选择器](https://docs.victoriametrics.com/keyConcepts.html#filtering) 返回 [counter 类型](https://docs.victoriametrics.com/keyConcepts.html#counter) 的时间序列。在计算结果时，它不像 Prometheus 那样考虑给定回溯窗口 `d` 之前的最后一个样本。详情请参见[此文章](https://medium.com/@romanhavronenko/victoriametrics-promql-compliance-d4318203f51e)。

结果中的指标名称将被删除。添加 [keep_metric_names](#keep_metric_names) 修饰符以保留指标名称。

> 另请参见 [increase_pure](#increase_pure) 和 [increase](#increase)。

#### increase_pure

`increase_pure(series_selector[d])` 是一个 [Rollup 函数](#rollup-functions)，它与 [increase](#increase) 相同，但有以下情况：它假设 [counters](https://docs.victoriametrics.com/keyConcepts.html#counter) 总是从 0 开始，而 [increase](#increase) 如果第一个值太大，则忽略该值。

#### increases_over_time

`increases_over_time(series_selector[d])` 是一个 [Rollup 函数](#rollup-functions)，它计算给定回溯窗口 `d` 中每个时间序列中原始样本值的增加数量。

结果中的指标名称将被删除。添加 [keep_metric_names](#keep_metric_names) 修饰符以保留指标名称。

> 另请参见 [decreases_over_time](#decreases_over_time)。

#### integrate

`integrate(series_selector[d])` 是一个 [Rollup 函数](#rollup-functions)，它根据给定的 `d` 时间窗口，对给定的 [序列选择器](https://docs.victoriametrics.com/keyConcepts.html#filtering) 返回的每个时间序列上的原始样本进行积分计算。

指标名称从结果 rollups 中删除。添加 [keep_metric_names](#keep_metric_names) 修改器以保留指标名称。

#### irate

`irate(series_selector[d])` 是一个 [Rollup 函数](#rollup-functions)，它根据给定的 `d` 时间窗口，计算给定 [序列选择器](https://docs.victoriametrics.com/keyConcepts.html#filtering) 返回的每个时间序列上最后两个原始样本的瞬时每秒增长率。预期 `series_selector` 返回计数器类型的时间序列。

指标名称从结果 rollups 中删除。添加 [keep_metric_names](#keep_metric_names) 修改器以保留指标名称。

> 该函数由 PromQL 支持。另请参见 [rate](#rate) 和 [rollup_rate](#rollup_rate)。

#### lag

`lag(series_selector[d])` 是一个 [Rollup 函数](#rollup-functions)，它返回给定 `d` 时间窗口上最后一次样本和当前点的时间戳之间的持续时间（以秒为单位）。它按独立计算每个从给定的 [序列选择器](https://docs.victoriametrics.com/keyConcepts.html#filtering) 返回的时间序列。

指标名称从结果 rollups 中删除。添加 [keep_metric_names](#keep_metric_names) 修改器以保留指标名称。

> 另请参见 [lifetime](#lifetime) 和 [duration_over_time](#duration_over_time)。

#### last_over_time

`last_over_time(series_selector[d])` 是一个 [Rollup 函数](#rollup-functions)，它返回给定 `d` 时间窗口上给定 [序列选择器](https://docs.victoriametrics.com/keyConcepts.html#filtering) 返回的每个时间序列上最后一个原始样本值。

> 该函数由 PromQL 支持。另请参见 [first_over_time](#first_over_time) 和 [tlast_over_time](#tlast_over_time)。

#### lifetime

`lifetime(series_selector[d])` 是一个 [Rollup 函数](#rollup-functions)，它返回给定 `d` 时间窗口上最后一个和第一个样本之间的持续时间（以秒为单位），并按每个从给定的 [序列选择器](https://docs.victoriametrics.com/keyConcepts.html#filtering) 返回的时间序列独立计算。

指标名称从结果 rollups 中删除。添加 [keep_metric_names](#keep_metric_names) 修改器以保留指标名称。

> 另请参见 [duration_over_time](#duration_over_time) 和 [lag](#lag)。

#### mad_over_time

`mad_over_time(series_selector[d])` 是一个 [Rollup 函数](#rollup-functions)，它计算给定 `d` 时间窗口上给定 [序列选择器](https://docs.victoriametrics.com/keyConcepts.html#filtering) 返回的每个时间序列上原始样本的 [中位数绝对偏差](https://en.wikipedia.org/wiki/Median_absolute_deviation)。

> 另请参见 [mad](#mad) 和 [range_mad](#range_mad)。

#### max_over_time

`max_over_time(series_selector[d])` 是一个 [Rollup 函数](#rollup-functions)，它计算给定 `d` 时间窗口上给定 [序列选择器](https://docs.victoriametrics.com/keyConcepts.html#filtering) 返回的每个时间序列上原始样本的最大值。

> 该函数由 PromQL 支持。另请参见 [tmax_over_time](#tmax_over_time)。

#### median_over_time

`median_over_time(series_selector[d])` 是一个 [Rollup 函数](#rollup-functions)，它计算给定 `d` 时间窗口上给定 [序列选择器](https://docs.victoriametrics.com/keyConcepts.html#filtering) 返回的每个时间序列上原始样本的中位数。

> 另请参见 [avg_over_time](#avg_over_time)。

#### min_over_time

`min_over_time(series_selector[d])` 是一个 [Rollup 函数](#rollup-functions)，它计算给定 `d` 时间窗口上给定 [序列选择器](https://docs.victoriametrics.com/keyConcepts.html#filtering) 返回的每个时间序列上原始样本的最小值。

> 该函数由 PromQL 支持。另请参见 [tmin_over_time](#tmin_over_time)。

#### mode_over_time

`mode_over_time(series_selector[d])` 是一个 [Rollup 函数](#rollup-functions)，它为给定 `d` 时间窗口上的原始样本计算 [mode](https://en.wikipedia.org/wiki/Mode_(statistics))。它按每个从给定的 [序列选择器](https://docs.victoriametrics.com/keyConcepts.html#filtering) 返回的时间序列单独计算。预计原始样本值是离散的。

#### predict_linear

`predict_linear(series_selector[d], t)` 是一个 [Rollup 函数](#rollup-functions)，它使用线性插值计算给定 `d` 时间窗口上的原始样本值，预测 `t` 秒后的值。预测值是按每个从给定的 [序列选择器](https://docs.victoriametrics.com/keyConcepts.html#filtering) 返回的时间序列单独计算的。

> 该函数由 PromQL 支持。另请参见 [range_linear_regression](#range_linear_regression)。

#### present_over_time

`present_over_time(series_selector[d])` 是一个 [Rollup 函数](#rollup-functions)，如果给定 `d` 时间窗口上至少有一个原始样本，则返回 1。否则，返回一个空结果。

指标名称从结果 rollups 中删除。添加 [keep_metric_names](#keep_metric_names) 修改器以保留指标名称。

> 该函数由 PromQL 支持。

#### quantile_over_time

`quantile_over_time(phi, series_selector[d])` 是一个 [Rollup 函数](#rollup-functions)，它计算给定 `d` 时间窗口上给定 [序列选择器](https://docs.victoriametrics.com/keyConcepts.html#filtering) 返回的每个时间序列上的 `phi` 分位数。`phi` 值必须在范围 `[0...1]` 内。

> 该函数由 PromQL 支持。另请参见 [quantiles_over_time](#quantiles_over_time)。

#### quantiles_over_time

`quantiles_over_time("phiLabel", phi1, ..., phiN, series_selector[d])` 是一个 [Rollup 函数](#rollup-functions)，它计算给定 `d` 时间窗口上给定 [序列选择器](https://docs.victoriametrics.com/keyConcepts.html#filtering) 返回的每个时间序列上的 `phi*` 分位数。该函数返回每个 `phi*` 的单独时间序列，其中 `{phiLabel="phi*}` 标签。`phi*` 值必须在范围 `[0...1]` 内。

> 另请参见 [quantile_over_time](#quantile_over_time)。

#### range_over_time

`range_over_time(series_selector[d])` 是一个 [Rollup 函数](#rollup-functions)，它计算给定 `d` 时间窗口上给定 [序列选择器](https://docs.victoriametrics.com/keyConcepts.html#filtering) 返回的每个时间序列上的值范围。例如，它计算 `max_over_time(series_selector[d]) - min_over_time(series_selector[d])`。

指标名称从结果 rollups 中删除。添加 [keep_metric_names](#keep_metric_names) 修改器以保留指标名称。

#### rate

`rate(series_selector[d])` 是一个 [Rollup 函数](#rollup-functions)，它计算给定 `d` 时间窗口上给定 [序列选择器](https://docs.victoriametrics.com/keyConcepts.html#filtering) 返回的每个时间序列上的平均每秒增长率。预期 `series_selector` 返回计数器类型的时间序列。

指标名称从结果 rollups 中删除。添加 [keep_metric_names](#keep_metric_names) 修改器以保留指标名称。

> 该函数由 PromQL 支持。另请参见 [irate](#irate) 和 [rollup_rate](#rollup_rate)。

#### rate_over_sum

`rate_over_sum(series_selector[d])` 是一个 [Rollup 函数](#rollup-functions)，它计算给定 `d` 时间窗口上给定 [序列选择器](https://docs.victoriametrics.com/keyConcepts.html#filtering) 返回的每个时间序列上的原始样本之和的每秒速率。这些计算是按每个时间序列单独执行的。

指标名称从结果 Rollups 中删除。添加 [keep_metric_names](#keep_metric_names) 修改器以保留指标名称。

#### resets

`resets(series_selector[d])` 是一个 [Rollup 函数](#rollup-functions)，它返回给定 `d` 时间窗口上给定 [序列选择器](https://docs.victoriametrics.com/keyConcepts.html#filtering) 返回的每个时间序列上的计数器重置次数。预期 `series_selector` 返回计数器类型的时间序列。

指标名称从结果 rollups 中删除。添加 [keep_metric_names](#keep_metric_names) 修改器以保留指标名称。

> 该函数由 PromQL 支持。

#### rollup

`rollup(series_selector[d])` 是一个 [Rollup 函数](#rollup-functions)，它计算给定 `d` 时间窗口上的原始样本的 `min`、`max` 和 `avg` 值，并在时间序列中返回它们，具有 `rollup="min"`、`rollup="max"` 和 `rollup="avg"` 附加标签。这些值是按每个从给定的 [序列选择器](https://docs.victoriametrics.com/keyConcepts.html#filtering) 返回的时间序列单独计算的。

可选的第二个参数 `"min"`、`"max"` 或 `"avg"` 可以传递以仅保留一个计算结果并且不添加标签。

#### rollup_candlestick

`rollup_candlestick(series_selector[d])` 是一个 [Rollup 函数](#rollup-functions)，它在给定的回溯窗口 `d` 上计算 `open`、`high`、`low` 和 `close` 值（也称为 OHLC）并将它们作为附加标签 `rollup="open"`、`rollup="high"`、`rollup="low"` 和 `rollup="close"` 返回到时间序列中。这些计算是针对从给定的 [序列选择器](https://docs.victoriametrics.com/keyConcepts.html#filtering) 返回的每个时间序列单独执行的。此函数对金融应用程序非常有用。

可选的第二个参数 `"min"`、`"max"` 或 `"avg"` 可以传递以仅保留一个计算结果并且不添加标签。

#### rollup_delta

`rollup_delta(series_selector[d])` 是一个 [Rollup 函数](#rollup-functions)，它在给定的回溯窗口 `d` 上计算相邻原始样本之间的差异，并返回计算差异的 `min`、`max` 和 `avg` 值，并将它们作为附加标签 `rollup="min"`、`rollup="max"` 和 `rollup="avg"` 返回到时间序列中。这些计算是针对从给定的 [序列选择器](https://docs.victoriametrics.com/keyConcepts.html#filtering) 返回的每个时间序列单独执行的。

可选的第二个参数 `"min"`、`"max"` 或 `"avg"` 可以传递以仅保留一个计算结果并且不添加标签。

度量名称从生成的 rollup 中删除。添加 [keep_metric_names](#keep_metric_names) 修饰符以保留度量名称。

> 另请参见 [rollup_increase](#rollup_increase)。

#### rollup_deriv

`rollup_deriv(series_selector[d])` 是一个 [Rollup 函数](#rollup-functions)，它在给定的回溯窗口 `d` 上计算相邻原始样本的每秒导数，并返回计算每秒导数的 `min`、`max` 和 `avg` 值，并将它们作为附加标签 `rollup="min"`、`rollup="max"` 和 `rollup="avg"` 返回到时间序列中。这些计算是针对从给定的 [序列选择器](https://docs.victoriametrics.com/keyConcepts.html#filtering) 返回的每个时间序列单独执行的。

可选的第二个参数 `"min"`、`"max"` 或 `"avg"` 可以传递以仅保留一个计算结果并且不添加标签。

度量名称从生成的 rollup 中删除。添加 [keep_metric_names](#keep_metric_names) 修饰符以保留度量名称。

#### rollup_increase

`rollup_increase(series_selector[d])` 是一个 [Rollup 函数](#rollup-functions)，它在给定的回溯窗口 `d` 上计算相邻原始样本之间的增量，并返回计算增量的 `min`、`max` 和 `avg` 值，并将它们作为附加标签 `rollup="min"`、`rollup="max"` 和 `rollup="avg"` 返回到时间序列中。这些计算是针对从给定的 [序列选择器](https://docs.victoriametrics.com/keyConcepts.html#filtering) 返回的每个时间序列单独执行的。

可选的第二个参数 `"min"`、`"max"` 或 `"avg"` 可以传递以仅保留一个计算结果并且不添加标签。

度量名称从生成的 rollup 中删除。添加 [keep_metric_names](#keep_metric_names) 修饰符以保留度量名称。另请参见 [rollup_delta](#rollup_delta)。

#### rollup_rate

`rollup_rate(series_selector[d])` 是一个 [Rollup 函数](#rollup-functions)，它计算给定回溯窗口内相邻原始样本的每秒变化率，并返回计算出的每秒变化率的 `min`、`max` 和 `avg` 值，并在时间序列中返回它们作为附加标签 `rollup="min"`、`rollup="max"` 和 `rollup="avg"`。

> 查看[此文章](https://valyala.medium.com/why-irate-from-prometheus-doesnt-capture-spikes-45f9896d7832)以更好地理解何时使用 `rollup_rate()`。

可选的第二个参数 `"min"`、`"max"` 或 `"avg"` 可以传递以仅保留一个计算结果并且不添加标签。

这些计算是针对从给定的 [序列选择器](https://docs.victoriametrics.com/keyConcepts.html#filtering) 返回的每个时间序列进行的。

结果回滚的指标名称将被剥离。添加 [keep_metric_names](#keep_metric_names) 修饰符以保留指标名称。

#### rollup_scrape_interval

`rollup_scrape_interval(series_selector[d])` 是一个 [Rollup 函数](#rollup-functions)，它计算给定回溯窗口内相邻原始样本之间的间隔（以秒为单位），并返回计算的间隔的 `min`、`max` 和 `avg` 值，并在时间序列中返回它们作为附加标签 `rollup="min"`、`rollup="max"` 和 `rollup="avg"`。

这些计算是针对从给定的 [序列选择器](https://docs.victoriametrics.com/keyConcepts.html#filtering) 返回的每个时间序列进行的。

可选的第二个参数 `"min"`、`"max"` 或 `"avg"` 可以传递以仅保留一个计算结果并且不添加标签。

结果回滚的指标名称将被剥离。添加 [keep_metric_names](#keep_metric_names) 修饰符以保留指标名称。另请参见 [scrape_interval](#scrape_interval)。

#### scrape_interval

`scrape_interval(series_selector[d])` 是一个 [Rollup 函数](#rollup-functions)，它计算给定回溯窗口内原始样本之间的平均间隔（以秒为单位），每个从给定的 [序列选择器](https://docs.victoriametrics.com/keyConcepts.html#filtering) 返回的时间序列。

结果回滚的指标名称将被剥离。添加 [keep_metric_names](#keep_metric_names) 修饰符以保留指标名称。

> 另请参见 [rollup_scrape_interval](#rollup_scrape_interval)。

#### share_gt_over_time

`share_gt_over_time(series_selector[d], gt)` 是一个 [Rollup 函数](#rollup-functions)，它返回给定回溯窗口内大于 `gt` 的原始样本的份额（在区间`[0...1]` 内）。它是针对从给定的 [序列选择器](https://docs.victoriametrics.com/keyConcepts.html#filtering) 返回的每个时间序列独立计算出来的。

此功能用于计算 SLI 和 SLO。例如： `share_gt_over_time(up[24h], 0)` - 返回过去 24 小时的服务可用性。

结果回滚的指标名称将被剥离。添加 [keep_metric_names](#keep_metric_names) 修饰符以保留指标名称。

> 另请参见 [share_le_over_time](#share_le_over_time)。

#### share_le_over_time

`share_le_over_time(series_selector[d], le)` 是一个 [Rollup 函数](#rollup-functions)，它返回给定回溯窗口内小于等于 `le` 的原始样本的份额（在区间 `[0...1]` 内）。它是针对从给定的 [序列选择器](https://docs.victoriametrics.com/keyConcepts.html#filtering) 返回的每个时间序列独立计算出来的。

此功能用于计算 SLI 和 SLO。例如：`share_le_over_time(memory_usage_bytes[24h], 100*1024*1024)` 返回过去 24 小时内内存使用量低于或等于 100MB 的时间序列值的份额。

结果回滚的指标名称将被剥离。添加 [keep_metric_names](#keep_metric_names) 修饰符以保留指标名称。

> 另请参见 [share_gt_over_time](#share_gt_over_time)。

#### stale_samples_over_time

`stale_samples_over_time(series_selector[d])` 是一个 [Rollup 函数](#rollup-functions)，它计算给定回溯窗口 `d` 内匹配给定 [序列选择器](https://docs.victoriametrics.com/keyConcepts.html#filtering) 的每个时间序列的 [staleness markers](https://docs.victoriametrics.com/vmagent.html#prometheus-staleness-markers) 数量。

结果回滚的指标名称将被剥离。添加 [keep_metric_names](#keep_metric_names) 修饰符以保留指标名称。

#### stddev_over_time

`stddev_over_time(series_selector[d])` 是一个 [Rollup 函数](#rollup-functions)，它计算给定回溯窗口 `d` 内从给定 [序列选择器](https://docs.victoriametrics.com/keyConcepts.html#filtering) 返回的每个时间序列的原始样本的标准差。

结果回滚的指标名称将被剥离。添加 [keep_metric_names](#keep_metric_names) 修饰符以保留指标名称。

> 此函数由 PromQL 支持。另请参见 [stdvar_over_time](#stdvar_over_time)。

#### stdvar_over_time

`stdvar_over_time(series_selector[d])` 是一个 [Rollup 函数](#rollup-functions)，它计算给定回溯窗口 `d` 内从给定 [序列选择器](https://docs.victoriametrics.com/keyConcepts.html#filtering) 返回的每个时间序列的原始样本的标准方差。

结果回滚的指标名称将被剥离。添加 [keep_metric_names](#keep_metric_names) 修饰符以保留指标名称。

> 此函数由 PromQL 支持。另请参见 [stddev_over_time](#stddev_over_time)。

#### sum_over_time

`sum_over_time(series_selector[d])` 是一个 [Rollup 函数](#rollup-functions)，它计算给定回溯窗口 `d` 内从给定 [序列选择器](https://docs.victoriametrics.com/keyConcepts.html#filtering) 返回的每个时间序列的原始样本值的总和。

结果回滚的指标名称将被剥离。添加 [keep_metric_names](#keep_metric_names) 修饰符以保留指标名称。

> 此函数由 PromQL 支持。

#### sum2_over_time

`sum2_over_time(series_selector[d])` 是一个 [Rollup 函数](#rollup-functions)，它计算给定回溯窗口 `d` 内从给定 [序列选择器](https://docs.victoriametrics.com/keyConcepts.html#filtering) 返回的每个时间序列的原始样本值的平方和。

结果回滚的指标名称将被剥离。添加 [keep_metric_names](#keep_metric_names) 修饰符以保留指标名称。

#### timestamp

`timestamp(series_selector[d])` 是一个 [Rollup 函数](#rollup-functions)，它返回给定回溯窗口 `d` 内每个从给定的 [序列选择器](https://docs.victoriametrics.com/keyConcepts.html#filtering) 返回的时间序列的最后一个原始样本的时间戳（以秒为单位）。

结果回滚的指标名称将被剥离。添加 [keep_metric_names](#keep_metric_names) 修饰符以保留指标名称。

> 此函数由 PromQL 支持。另请参见 [timestamp_with_name](#timestamp_with_name)。

#### timestamp_with_name

`timestamp_with_name(series_selector[d])` 是一个 [Rollup 函数](#rollup-functions)，它返回给定回溯窗口 `d` 内每个从给定的 [序列选择器](https://docs.victoriametrics.com/keyConcepts.html#filtering) 返回的时间序列的最后一个原始样本的时间戳（以秒为单位）。

结果回滚的指标名称将被保留。

> 另请参见 [timestamp](#timestamp)。

#### tfirst_over_time

`tfirst_over_time(series_selector[d])` 是一个 [Rollup 函数](#rollup-functions)，它返回给定回溯窗口 `d` 内每个从给定的 [序列选择器](https://docs.victoriametrics.com/keyConcepts.html#filtering) 返回的时间序列的第一个原始样本的时间戳（以秒为单位）。

结果回滚的指标名称将被剥离。添加 [keep_metric_names](#keep_metric_names) 修饰符以保留指标名称。

> 另请参见 [first_over_time](#first_over_time)。

#### tlast_change_over_time

`tlast_change_over_time(series_selector[d])` 是一个 [Rollup 函数](#rollup-functions)，它返回给定回溯窗口 `d` 内每个从给定的 [序列选择器](https://docs.victoriametrics.com/keyConcepts.html#filtering) 返回的时间序列上的最后一次更改的时间戳。

结果回滚的指标名称将被剥离。添加 [keep_metric_names](#keep_metric_names) 修饰符以保留指标名称。

> 另请参见 [last_over_time](#last_over_time)。

#### tlast_over_time

`tlast_over_time(series_selector[d])` 是一个 [Rollup 函数](#rollup-functions)，它是`timestamp`的一个别名。

> 另请参见 [tlast_change_over_time](#tlast_change_over_time)。

#### tmax_over_time

`tmax_over_time(series_selector[d])` 是一个 [Rollup 函数](#rollup-functions)，它返回给定回溯窗口 `d` 上具有最大值的原始样本的时间戳（以秒为单位）。它针对从给定的 [序列选择器](https://docs.victoriametrics.com/keyConcepts.html#filtering) 返回的每个时间序列独立计算。

度量名称从结果卷起中剥离。添加 [keep_metric_names](#keep_metric_names) 修改器以保留度量名称。

> 另请参见 [max_over_time](#max_over_time)。

#### tmin_over_time

`tmin_over_time(series_selector[d])` 是一个 [Rollup 函数](#rollup-functions)，它返回给定回溯窗口 `d` 上具有最小值的原始样本的时间戳（以秒为单位）。它针对从给定的 [序列选择器](https://docs.victoriametrics.com/keyConcepts.html#filtering) 返回的每个时间序列独立计算。

度量名称从结果卷起中剥离。添加 [keep_metric_names](#keep_metric_names) 修改器以保留度量名称。

> 另请参见[min_over_time](#min_over_time)。

#### zscore_over_time

`zscore_over_time(series_selector[d])` 是一个 [Rollup 函数](#rollup-functions)，它返回给定回溯窗口 `d` 上原始样本的 [z-score](https://en.wikipedia.org/wiki/Standard_score)。它针对从给定的[序列选择器](https://docs.victoriametrics.com/keyConcepts.html#filtering) 返回的每个时间序列独立计算。

度量名称从结果卷起中剥离。添加 [keep_metric_names](#keep_metric_names) 修改器以保留度量名称。

> 另请参见 [zscore](#zscore)和 [range_trim_zscore](#range_trim_zscore)。

### 转换函数

**转换函数**计算 [Rollup 结果](#rollup-functions)的变换。例如，`abs(delta(temperature[24h]))` 计算每个从卷积中返回的时间序列的每个点的绝对值。

附加细节：

- 如果转换函数直接应用于[序列选择器](https://docs.victoriametrics.com/keyConcepts.html#filtering)，则会在计算变换之前自动应用[default_rollup()](#default_rollup)函数。例如，`abs(temperature)`会被隐式转换为 `abs(default_rollup(temperature[1i]))`。
- 所有转换函数都接受可选的 [keep_metric_names](#keep_metric_names) 修改器。如果设置了它，则函数不会从结果时间序列中删除度量名称。参见[这些文档](#keep_metric_names)。

> 另请参见[隐式查询转换](#implicit-query-conversions)。


### 支持的转换函数列表


#### abs

`abs(q)` 是一个[转换函数](#transform-functions)，它计算由 `q` 返回的每个时间序列的每个点的绝对值。

> 此功能由 PromQL 支持。

#### absent

`absent(q)` 是一个[转换函数](#transform-functions)，如果 `q` 没有点，则返回1。否则，返回空结果。

> 此功能由 PromQL 支持。另请参见 [absent_over_time](#absent_over_time)。

#### acos

`acos(q)` 是一个[转换函数](#transform-functions)，它返回由 `q` 返回的每个时间序列的每个点的[反余弦](https://en.wikipedia.org/wiki/Inverse_trigonometric_functions)。

度量名称从结果序列中剥离。添加 [keep_metric_names](#keep_metric_names) 修改器以保留度量名称。

> 此功能由 PromQL 支持。另请参见 [asin](#asin) 和 [cos](#cos)。

#### acosh

`acosh(q)` 是一个[转换函数](#transform-functions)，它返回由 `q` 返回的每个时间序列的每个点的[反双曲余弦](https://en.wikipedia.org/wiki/Inverse_hyperbolic_functions#Inverse_hyperbolic_cosine)。

度量名称从结果序列中剥离。添加 [keep_metric_names](#keep_metric_names) 修改器以保留度量名称。

> 此功能由 PromQL 支持。另请参见 [sinh](#cosh)。

#### asin

`asin(q)` 是一个[转换函数](#transform-functions)，它返回由 `q` 返回的每个时间序列的每个点的[反正弦](https://en.wikipedia.org/wiki/Inverse_trigonometric_functions)。

度量名称从结果序列中剥离。添加 [keep_metric_names](#keep_metric_names) 修改器以保留度量名称。

> 此功能由 PromQL 支持。另请参见 [acos](#acos) 和 [sin](#sin)。

#### asinh

`asinh(q)` 是一个[转换函数](#transform-functions)，它返回由 `q` 返回的每个时间序列的每个点的[反双曲正弦](https://en.wikipedia.org/wiki/Inverse_hyperbolic_functions#Inverse_hyperbolic_sine)。

度量名称从结果序列中剥离。添加 [keep_metric_names](#keep_metric_names) 修改器以保留度量名称。

> 此功能由 PromQL 支持。另请参见 [sinh](#sinh)。

#### atan

`atan(q)` 是一个[转换函数](#transform-functions)，它返回由 `q` 返回的每个时间序列的每个点的[反正切](https://en.wikipedia.org/wiki/Inverse_trigonometric_functions)。

度量名称从结果序列中剥离。添加 [keep_metric_names](#keep_metric_names) 修改器以保留度量名称。

> 此功能由 PromQL 支持。另请参见 [tan](#tan)。

#### atanh

`atanh(q)` 是一个[转换函数](#transform-functions)，它返回由 `q` 返回的每个时间序列的每个点的[反双曲正切](https://en.wikipedia.org/wiki/Inverse_hyperbolic_functions#Inverse_hyperbolic_tangent)。

度量名称从结果序列中剥离。添加 [keep_metric_names](#keep_metric_names) 修改器以保留度量名称。

> 此功能由 PromQL 支持。另请参见 [tanh](#tanh)。

#### bitmap_and

`bitmap_and(q, mask)` 是一个[转换函数](#transform-functions)，它计算从 `q` 返回的每个时间序列的每个 `v` 点的位运算 `v & mask`。

度量名称从结果序列中剥离。添加 [keep_metric_names](#keep_metric_names) 修改器以保留度量名称。

#### bitmap_or

`bitmap_or(q, mask)` 是一个[转换函数](#transform-functions)，它计算从 `q` 返回的每个时间序列的每个 `v` 点的位运算 `v | mask`。

度量名称从结果序列中剥离。添加 [keep_metric_names](#keep_metric_names) 修改器以保留度量名称。

#### bitmap_xor

`bitmap_xor(q, mask)` 是一个[转换函数](#transform-functions)，它计算从 `q` 返回的每个时间序列的每个 `v` 点的位运算 `v ^ mask`。

度量名称从结果序列中剥离。添加 [keep_metric_names](#keep_metric_names) 修改器以保留度量名称。

#### buckets_limit

`buckets_limit(limit, buckets)` 是一个[转换函数](#transform-functions)，它将[直方图桶](https://valyala.medium.com/improving-histogram-usability-for-prometheus-and-grafana-bc7e5df0e350)的数量限制为给定的 `limit`。

> 另请参见 [prometheus_buckets](#prometheus_buckets) 和 [histogram_quantile](#histogram_quantile)。

#### ceil

`ceil(q)` 是一个[转换函数](#transform-functions)，它将由 `q` 返回的每个时间序列的每个点四舍五入到最接近的整数。

> 此功能由 PromQL 支持。另请参见 [floor](#floor) 和 [round](#round)。

#### clamp

`clamp(q, min, max)` 是一个[转换函数](#transform-functions)，它使用给定的 `min` 和 `max` 值夹住由 `q` 返回的每个时间序列的每个点。

> 此功能由 PromQL 支持。另请参见 [clamp_min](#clamp_min) 和 [clamp_max](#clamp_max)。

#### clamp_max

`clamp_max(q, max)` 是一个[转换函数](#transform-functions)，它将由 `q` 返回的每个时间序列的每个点都钳制在给定的 `max` 值下。

> 此函数由 PromQL 支持。请参阅 [clamp](#clamp) 和 [clamp_min](#clamp_min)。

#### clamp_min

`clamp_min(q, min)` 是一个[转换函数](#transform-functions)，它将由 `q` 返回的每个时间序列的每个点都钳制在给定的 `min` 值上。

> 此函数由 PromQL 支持。请参阅 [clamp](#clamp) 和 [clamp_max](#clamp_max)。

#### cos

`cos(q)` 是一个[转换函数](#transform-functions)，它返回由 `q` 返回的每个时间序列的每个 `v` 点的 `cos(v)`。

度量名称从结果系列中删除。添加 [keep_metric_names](#keep_metric_names) 修饰符以保留度量名称。

> 此函数由 PromQL 支持。请参阅 [sin](#sin)。

#### cosh

`cosh(q)` 是一个[转换函数](#transform-functions)，它返回 `q` 返回的每个时间序列的每个点的[双曲余弦](https://en.wikipedia.org/wiki/Hyperbolic_functions)。

结果序列中的指标名称被剥离。添加 [keep_metric_names](#keep_metric_names) 修饰符以保留指标名称。

> 此函数由 PromQL 支持。此函数由 PromQL 支持。另请参见[acosh](#acosh)。

#### day_of_month

`day_of_month(q)` 是一个[转换函数](#transform-functions)，它返回 `q` 返回的每个时间序列的每个点的月份日期。预计 `q` 返回 Unix 时间戳。返回的值在范围`[1...31]` 内。

结果序列中的指标名称被剥离。添加 [keep_metric_names](#keep_metric_names) 修饰符以保留指标名称。

> 此函数由 PromQL 支持。

#### day_of_week

`day_of_week(q)` 是一个[转换函数](#transform-functions)，它返回 `q` 返回的每个时间序列的每个点的星期日期。预计 `q` 返回 Unix 时间戳。返回的值在范围 `[0...6]` 内，其中 `0` 表示星期日，`6` 表示星期六。

结果序列中的指标名称被剥离。添加 [keep_metric_names](#keep_metric_names) 修饰符以保留指标名称。

> 此函数由 PromQL 支持。

#### days_in_month

`days_in_month(q)` 是一个[转换函数](#transform-functions)，它返回由 `q` 返回的每个时间序列的每个点识别的月份中的天数。预计 `q` 返回 Unix 时间戳。返回的值在范围`[28...31]` 内。

结果序列中的指标名称被剥离。添加 [keep_metric_names](#keep_metric_names) 修饰符以保留指标名称。

> 此函数由 PromQL 支持。

#### deg

`deg(q)` 是一个[转换函数](#transform-functions)，它将 `q` 返回的每个时间序列的每个点从弧度转换为度。

结果序列中的指标名称被剥离。添加 [keep_metric_names](#keep_metric_names) 修饰符以保留指标名称。

> 此函数由 PromQL 支持。另请参见 [rad](#rad)。

#### end

`end()` 是一个[转换函数](#transform-functions)，它返回最后一个点的 Unix 时间戳（以秒为单位）。它被称为传递给 [/api/v1/query_range](https://docs.victoriametrics.com/keyConcepts.html#range-query) 的 `end` 查询参数。

> 另请参见[start](#start)、[time](#time)和 [now](#now)。

#### exp

`exp(q)` 是一个[转换函数](#transform-functions)，它为 `q` 返回的每个时间序列的每个点计算 `e^v`。

结果序列中的指标名称被剥离。添加 [keep_metric_names](#keep_metric_names) 修饰符以保留指标名称。

> 此函数由 PromQL 支持。另请参见 [ln](#ln)。

#### floor

`floor(q)` 是一个[转换函数](#transform-functions)，它将 `q` 返回的每个时间序列的每个点舍入到最接近的整数。

> 此函数由 PromQL 支持。另请参见 [ceil](#ceil) 和 [round](#round)。

#### histogram_avg

`histogram_avg(buckets)` 是一个[转换函数](#transform-functions)，它计算给定 `buckets` 的平均值。它可用于计算跨多个时间序列的给定时间范围的平均值。例如，`histogram_avg(sum(histogram_over_time(response_time_duration_seconds[5m])) by (vmrange,job))` 将返回最近5分钟内每个 `job` 的平均响应时间。

#### histogram_quantile

`histogram_quantile(phi, buckets)` 是一个[转换函数](#transform-functions)，它计算给定[直方图桶](https://valyala.medium.com/improving-histogram-usability-for-prometheus-and-grafana-bc7e5df0e350)上的 `phi` - [百分位数](https://en.wikipedia.org/wiki/Percentile)`。phi` 必须在范围 `[0...1]` 内。例如，`histogram_quantile(0.5, sum(rate(http_request_duration_seconds_bucket[5m]) by (le))`将返回在最近5分钟内所有请求的中位数请求持续时间。

该函数接受可选的第三个参数 - `boundsLabel`。在这种情况下，它返回具有给定 `boundsLabel` 标签的估计百分位数的 `lower`和`upper`边界。有关详细信息，请参见[此问题](https://github.com/prometheus/prometheus/issues/5706)。

当在多个直方图上计算[百分位数](https://en.wikipedia.org/wiki/Percentile)时，所有输入直方图**必须**具有相同边界的桶，例如它们必须具有相同的 `le` 或 `vmrange` 标签集。否则，返回的结果可能无效。有关详细信息，请参见[此问题](https://github.com/VictoriaMetrics/VictoriaMetrics/issues/3231)。

> 此函数由 PromQL 支持（除了 `boundLabel` 参数）。另请参见 [histogram_quantiles](#histogram_quantiles)、[histogram_share](#histogram_share) 和 [quantile](#quantile)。

#### histogram_quantiles

`histogram_quantiles("phiLabel", phi1, ..., phiN, buckets)` 是一个[转换函数](#transform-functions)，它计算给定的 `phi*` - 分位数在给定的[直方图桶](https://valyala.medium.com/improving-histogram-usability-for-prometheus-and-grafana-bc7e5df0e350)上。参数 `phi*` 必须在范围 `[0...1]` 内。例如，`histogram_quantiles('le', 0.3, 0.5, sum(rate(http_request_duration_seconds_bucket[5m]) by (le))`。每个计算的分位数都以相应的 `{phiLabel="phi*"}` 标签在单独的时间序列中返回。

> 另请参见 [histogram_quantile](#histogram_quantile)。

#### histogram_share

`histogram_share(le, buckets)` 是一个[转换函数](#transform-functions)，它计算处于 `buckets` 下面的 `le` 的份额（在范围 `[0...1]` 内）。这个函数对于计算 SLI 和 SLO 很有用。这与 [histogram_quantile](#histogram_quantile) 相反。

该函数接受可选的第三个参数 - `boundsLabel`。在这种情况下，它返回具有给定 `boundsLabel` 标签的估计份额的 `lower` 和 `upper` 边界。

#### histogram_stddev

`histogram_stddev(buckets)` 是一个[转换函数](#transform-functions)，它计算给定 `buckets` 的标准差。

#### histogram_stdvar

`histogram_stdvar(buckets)` 是一个[转换函数](#transform-functions)，它可以用于计算跨多个时间序列的给定时间范围的标准差，它计算给定 `buckets` 的标准方差。例如，`histogram_stdvar(sum(histogram_over_time(temperature[24])) by (vmrange,country))` 将返回最近24小时内每个国家的温度的标准差。

#### hour

`hour(q)` 是一个 [转换函数](#transform-functions)，返回 `q` 返回的每个时间序列中每个点的小时数。预期 `q` 返回 unix 时间戳。返回的值在范围 `[0...23]` 内。

度量名称从结果系列中剥离。添加 [keep_metric_names](#keep_metric_names) 修饰符以保留度量名称。

> PromQL 支持此功能。

#### interpolate

`interpolate(q)` 是一个 [转换函数](#transform-functions)，它使用从 `q` 返回的每个时间序列的上一个和下一个非空点计算的线性插值值填充间隙。

> 另请参见 [keep_last_value](#keep_last_value) 和 [keep_next_value](#keep_next_value)。

#### keep_last_value

`keep_last_value(q)` 是一个 [转换函数](#transform-functions)，它使用返回的每个时间序列中的最后一个非空点的值填充间隙。

> 另请参见 [keep_next_value](#keep_next_value) 和 [interpolate](#interpolate)。

#### keep_next_value

`keep_next_value(q)` 是一个 [转换函数](#transform-functions)，它使用返回的每个时间序列中的下一个非空点的值填充间隙。

> 另请参见 [keep_last_value](#keep_last_value)和 [interpolate](#interpolate)。

#### limit_offset

`limit_offset(limit, offset, q)` 是一个 [转换函数](#transform-functions)，它跳过来自 `q` 返回的 `offset` 时间序列，然后对每个组返回最多 `limit` 个剩余时间序列。

> 这允许为 `q` 时间序列实现简单的分页。另请参见 [limitk](#limitk)。

#### ln

`ln(q)` 是一个 [转换函数](#transform-functions)，它为 `q` 返回的每个时间序列的每个点计算 `ln(v)`。

度量名称从结果系列中剥离。添加 [keep_metric_names](#keep_metric_names) 修饰符以保留度量名称。

> PromQL 支持此功能。另请参见 [exp](#exp) 和 [log2](#log2)。

#### log2

`log2(q)` 是一个 [转换函数](#transform-functions)，它为 `q` 返回的每个时间序列的每个点计算 `log2(v)`。

度量名称从结果系列中剥离。添加 [keep_metric_names](#keep_metric_names) 修饰符以保留度量名称。

> PromQL 支持此功能。另请参见 [log10](#log10)和[ln](#ln)。

#### log10

`log10(q)` 是一个 [转换函数](#transform-functions)，它为 `q` 返回的每个时间序列的每个点计算`log10(v)`。

度量名称从结果系列中剥离。添加 [keep_metric_names](#keep_metric_names) 修饰符以保留度量名称。

> PromQL 支持此功能。另请参见 [log2](#log2)和[ln](#ln)。

#### minute

`minute(q)` 是一个 [转换函数](#transform-functions)，它返回 `q` 返回的每个时间序列中每个点的分钟数。预期 `q` 返回 unix 时间戳。返回的值在范围 `[0...59]` 内。

度量名称从结果系列中剥离。添加 [keep_metric_names](#keep_metric_names) 修饰符以保留度量名称。

> PromQL 支持此功能。

#### month

`month(q)` 是一个 [转换函数](#transform-functions)，它为 `q` 返回的每个时间序列的每个点返回月份。预期 `q` 返回 unix 时间戳。返回的值在范围 `[1...12]` 内，其中 `1` 表示一月，`12` 表示十二月。

度量名称从结果系列中剥离。添加 [keep_metric_names](#keep_metric_names) 修饰符以保留度量名称。

> PromQL 支持此功能。

#### now

`now()` 是一个 [转换函数](#transform-functions)，它以秒为单位返回当前时间戳的浮点值。

> 另请参见 [time](#time)。

#### pi

`pi()` 是一个 [转换函数](#transform-functions)，它返回 [Pi number](https://en.wikipedia.org/wiki/Pi)。

> PromQL 支持此功能。

#### rad

`rad(q)` 是一个 [转换函数](#transform-functions)，它将 `q` 返回的每个时间序列中每个点的度转换为弧度。

度量名称从结果系列中剥离。添加 [keep_metric_names](#keep_metric_names) 修饰符以保留度量名称。

> PromQL 支持此功能。另请参见 [deg](#deg)。

#### prometheus_buckets

`prometheus_buckets(buckets)` 是一个 [转换函数](#transform-functions)，它将带有 `vmrange` 标签的   [VictoriaMetrics 直方图桶](https://valyala.medium.com/improving-histogram-usability-for-prometheus-and-grafana-bc7e5df0e350)转换为具有 `le` 标签的 Prometheus 直方图桶。

> 另请参见 [histogram_quantile](#histogram_quantile) 和 [buckets_limit](#buckets_limit)。

#### rand

`rand(seed)` 是一个 [转换函数](#transform-functions)，它以均匀分布返回范围为 `[0...1]` 的伪随机数。可选的 `seed` 可用作伪随机数生成器的种子。

> 另请参见 [rand_normal](#rand_normal)和[rand_exponential](#rand_exponential)。

#### rand_exponential

`rand_exponential(seed)` 是一个 [转换函数](#transform-functions)，它返回具有[指数分布](https://en.wikipedia.org/wiki/Exponential_distribution)的伪随机数。可选的 `seed` 可用作伪随机数生成器的种子。

> 另请参见 [rand](#rand) 和 [rand_normal](#rand_normal)。

#### rand_normal

`rand_normal(seed)` 是一个 [转换函数](#transform-functions)，它返回具有[正态分布](https://en.wikipedia.org/wiki/Normal_distribution)的伪随机数。可选的 `seed` 可用作伪随机数生成器的种子。

> 另请参见 [rand](#rand) 和 [rand_exponential](#rand_exponential)。

#### range_avg

`range_avg(q)` 是一个 [转换函数](#transform-functions)，它计算每个由 `q` 返回的时间序列中点的平均值。

#### range_first

`range_first(q)` 是一个 [转换函数](#transform-functions)，它返回由 `q` 返回的每个时间序列的第一个点的值。

#### range_last

`range_last(q)` 是一个 [转换函数](#transform-functions)，它返回由 `q` 返回的每个时间序列的最后一个点的值。

#### range_linear_regression

`range_linear_regression(q)` 是一个[转换函数](#transform-functions)，它计算由 `q` 返回的每个时间序列在所选时间范围内的[简单线性回归](https://en.wikipedia.org/wiki/Simple_linear_regression)。此函数对容量规划和预测非常有用。

#### range_mad

`range_mad(q)` 是一个[转换函数](#transform-functions)，它计算由 `q` 返回的每个时间序列点之间的[中位数绝对偏差](https://en.wikipedia.org/wiki/Median_absolute_deviation)。

> 另请参见 [mad](#mad) 和 [mad_over_time](#mad_over_time)。

#### range_max

`range_max(q)` 是一个[转换函数](#transform-functions)，它计算由 `q` 返回的每个时间序列点之间的最大值。

#### range_median

`range_median(q)` 是一个[转换函数](#transform-functions)，它计算由 `q` 返回的每个时间序列点之间的中位数。

#### range_min

`range_min(q)` 是一个[转换函数](#transform-functions)，它计算由 `q` 返回的每个时间序列点之间的最小值。

#### range_normalize

`range_normalize(q1, ...)` 是一个[转换函数](#transform-functions)，它将由 `q1，…` 返回的时间序列的值归一化为 `[0 ... 1]` 范围。此函数对于将具有不同值范围的时间序列相关联非常有用。

> 另请参见 [share](#share)。

#### range_quantile

`range_quantile(phi, q)` 是一个[转换函数](#transform-functions)，它返回 `q` 返回的每个时间序列中的 `phi` 分位数。 `phi` 必须在范围 `[0 ... 1]` 内。

#### range_stddev

`range_stddev(q)` 是一个[转换函数](#transform-functions)，它计算由 `q` 返回的每个时间序列在所选时间范围内的[标准偏差](https://en.wikipedia.org/wiki/Standard_deviation)。

#### range_stdvar

`range_stdvar(q)` 是一个[转换函数](#transform-functions)，它计算由 `q` 返回的每个时间序列在所选时间范围内的[标准方差](https://en.wikipedia.org/wiki/Variance)。

#### range_sum

`range_sum(q)` 是一个[转换函数](#transform-functions)，它计算由 `q` 返回的每个时间序列的点之和。

#### range_trim_outliers

`range_trim_outliers(k, q)` 是一个[转换函数](#transform-functions)，它从 `range_median(q)` 的位置删除距离 `k*range_mad(q)` 更远的点。例如，它等效于以下查询：`q ifnot (abs(q - range_median(q)) > k*range_mad(q))`。

> 另请参见 [range_trim_spikes](#range_trim_spikes) 和 [range_trim_zscore](#range_trim_zscore)。

#### range_trim_spikes

`range_trim_spikes(phi, q)` 是一个[转换函数](#transform-functions)，它从由 `q` 返回的时间序列中删除最大的 `phi` 百分比的峰值。 `phi` 必须在范围 `[0..1]` 内，其中 `0` 表示 `0％`，`1` 表示 `100％`。

> 另请参见 [range_trim_outliers](#range_trim_outliers) 和 [range_trim_zscore](#range_trim_zscore)。

#### range_trim_zscore

`range_trim_zscore(z, q)` 是一个[转换函数](#transform-functions)，它从 `range_avg(q)` 的位置删除距离 `z*range_stddev(q)` 更远的点。例如，它等效于以下查询：`q ifnot (abs(q - range_avg(q)) > z*range_avg(q))`。

> 另请参见 [range_trim_outliers](#range_trim_outliers) 和 [range_trim_spikes](#range_trim_spikes)。

#### range_zscore

`range_zscore(q)` 是一个[转换函数](#transform-functions)，它为由 `q` 返回的点计算 [z分数](https://en.wikipedia.org/wiki/Standard_score)，例如，它等效于以下查询：`(q - range_avg(q)) / range_stddev(q)`。

#### remove_resets

`remove_resets(q)` 是一个[转换函数](#transform-functions)，它从由 `q` 返回的时间序列中删除计数器重置。

#### round

`round(q, nearest)` 是一个[转换函数](#transform-functions)，它将由 `q` 返回的每个时间序列的每个点舍入到 `nearest` 的倍数。如果缺少 `nearest`，则将四舍五入到最接近的整数。

> 此函数受 PromQL 支持。 另请参见 [floor](#floor) 和 [ceil](#ceil)。

#### ru

`ru(free, max)` 是一个[转换函数](#transform-functions)，它计算给定 `free` 和 `max` 资源的范围内的资源利用率，范围为 `[0％... 100％]`。例如，`ru(node_memory_MemFree_bytes, node_memory_MemTotal_bytes)` 返回 [node_exporter](https://github.com/prometheus/node_exporter) 指标的内存利用率。

#### running_avg

`running_avg(q)` 是一个[转换函数](#transform-functions)，它计算由 `q` 返回的每个时间序列的运行平均值。

#### running_max

`running_max(q)` 是一个[转换函数](#transform-functions)，它计算由 `q` 返回的每个时间序列的运行最大值。

#### running_min

`running_min(q)` 是一个[转换函数](#transform-functions)，它计算由 `q` 返回的每个时间序列的运行最小值。

#### running_sum

`running_sum(q)` 是一个[转换函数](#transform-functions)，它计算由 `q` 返回的每个时间序列的运行总和。

#### scalar

`scalar(q)` 是一个[转换函数](#transform-functions)，如果 `q` 仅包含单个时间序列，则返回 `q`。否则，它不返回任何内容。

> 此函数受 PromQL 支持。

#### sgn

`sgn(q)` 是一个[转换函数](#transform-functions)，它对于由 `q` 返回的每个时间序列的每个点，如果 `v> 0`，则返回 `1`，如果 `v <0`，则返回 `-1`，如果 `v== 0`，则返回 `0`。

度量名称从生成的系列中删除。添加 [keep_metric_names](#keep_metric_names) 修饰符以保留度量名称。

> 此函数受 PromQL 支持。

#### sin

`sin(q)` 是一个[转换函数](#transform-functions)，它对于由 `q` 返回的每个时间序列的每个 `v` 点，返回 `sin(v)`。

度量名称从生成的系列中删除。添加 [keep_metric_names](#keep_metric_names) 修饰符以保留度量名称。

> 此函数受 MetricsQL 支持。另请参见 [cos](#cos)。

#### sinh

`sinh(q)` 是一个[转换函数](#transform-functions)，它对于由 `q` 返回的每个时间序列的每个点返回[双曲正弦](https://en.wikipedia.org/wiki/Hyperbolic_functions)。

度量名称从生成的系列中删除。添加 [keep_metric_names](#keep_metric_names) 修饰符以保留度量名称。

> 此函数受 MetricsQL 支持。另请参见 [cosh](#cosh)。

#### tan

`tan(q)` 是一个[转换函数](#transform-functions)，它对于由 `q` 返回的每个时间序列的每个 `v` 点，返回 `tan(v)`。

度量名称从生成的系列中删除。添加 [keep_metric_names](#keep_metric_names) 修饰符以保留度量名称。

> 此函数受 MetricsQL 支持。另请参见 [atan](#atan)。

#### tanh

`tanh(q)` 是一个[转换函数](#transform-functions)，它对于由 `q` 返回的每个时间序列的每个点返回[双曲正切](https://en.wikipedia.org/wiki/Hyperbolic_functions)。

度量名称从生成的系列中删除。添加 [keep_metric_names](#keep_metric_names) 修饰符以保留度量名称。

> 此函数受 MetricsQL 支持。另请参见 [atanh](#atanh)。

#### smooth_exponential

`smooth_exponential(q, sf)` 是一个[转换函数](#transform-functions)，它使用给定的平滑因子 `sf` 平滑由 `q` 返回的每个时间序列的点。

#### sort

`sort(q)` 是一个[转换函数](#transform-functions)，它按每个由 `q` 返回的时间序列中的最后一个点的升序对系列进行排序。

> 此函数受 PromQL 支持。 另请参见 [sort_desc](#sort_desc) 和 [sort_by_label](#sort_by_label)。

#### sort_desc

`sort_desc(q)` 是一个[转换函数](#transform-functions)，按照由 `q` 返回的每个时间序列的最后一个点降序排序。

> PromQL 支持此功能。另请参见 [sort](#sort) 和 [sort_by_label](#sort_by_label_desc)。

#### sqrt

`sqrt(q)` 是一个[转换函数](#transform-functions)，计算由 `q` 返回的每个时间序列的每个点的平方根。

结果系列中剥离了指标名称。添加 [keep_metric_names](#keep_metric_names) 修改器以保留指标名称。

> PromQL 支持此功能。

#### start

`start()` 是一个[转换函数](#transform-functions)，返回第一个点的 unix 时间戳（以秒为单位）。

它被称为传递给 [/api/v1/query_range](https://docs.victoriametrics.com/keyConcepts.html#range-query)的 `start` 查询参数。

> 另请参见 [end](#end)、[time](#time) 和 [now](#now)。

#### step

`step()` 是一个[转换函数](#transform-functions)，返回点之间的步长（也称为间隔）（以秒为单位）。它被称为传递给 [/api/v1/query_range](https://docs.victoriametrics.com/keyConcepts.html#range-query) 的 `step` 查询参数。

> 另请参见 [start](#start)和[end](#end)。

#### time

`time()` 是一个[转换函数](#transform-functions)，返回每个返回点的unix时间戳。

> PromQL 支持此功能。另请参见 [now](#now)、[start](#start) 和 [end](#end)。

#### timezone_offset

`timezone_offset(tz)` 是一个[转换函数](#transform-functions)，它返回相对于UTC的给定时区 `tz` 的偏移量（以秒为单位）。这在与日期时间相关的函数结合使用时可能非常有用。例如，`day_of_week(time()+timezone_offset("America/Los_Angeles"))` 将返回 `America/Los_Angeles` 时区的工作日。

特殊的 `Local` 时区可用于返回在VictoriaMetrics运行的主机上设置的时区的偏移量。

> 请参见[受支持的时区列表](https://en.wikipedia.org/wiki/List_of_tz_database_time_zones)。

#### ttf

`ttf(free)` 是一个[转换函数](#transform-functions)，它估计耗尽 `free` 资源所需的时间（以秒为单位）。例如，`ttf(node_filesystem_avail_byte)` 返回耗尽存储空间的时间。此功能可能对容量规划有用。

#### union

`union(q1, ..., qN)` 是一个[转换函数](#transform-functions)，它返回从 `q1`，…，`qN` 返回的时间序列的联合。`union` 函数名称可以省略-以下查询等效: `union(q1, q2)` 和 `(q1, q2)`。

预期每个 `q*` 查询返回具有唯一标签集的时间序列。否则，只返回具有相同标签集的系列中的第一个时间序列。使用 [alias](#alias) 和 [label_set](#label_set)函数为每个 `q*` 查询提供唯一的标签集：

#### vector

`vector(q)` 是一个[转换函数](#transform-functions)，它返回 `q`，例如在 MetricsQL 中什么也不做。

> PromQL 支持此功能。

#### year

`year(q)` 是一个[转换函数](#transform-functions)，它返回由 `q` 返回的每个时间序列的每个点的年份。预期 `q` 返回 unix 时间戳。

结果系列中剥离了指标名称。添加 [keep_metric_names](#keep_metric_names) 修改器以保留指标名称。

> PromQL 支持此功能。

### 标签操作函数

**标签操作函数**用于对选定的 [Rollup 结果](#rollup-functions)执行标签操作。

更多细节：

- 如果标签操作函数被直接应用于 [序列选择器](https://docs.victoriametrics.com/keyConcepts.html#filtering)，则在执行标签转换之前会自动应用 [default_rollup()](#default_rollup) 函数。例如，`alias(temperature, "foo")` 会隐式转换为 `alias(default_rollup(temperature[1i]), "foo")`。

> 另请参见 [隐式查询转换](#implicit-query-conversions)。

### 支持的标签操作函数列表

#### alias

`alias(q, "name")` 是设置返回 `q` 的所有时间序列的给定 `name` 的[标签操作函数](#label-manipulation-functions)。例如，`alias(up, "foobar")` 将重命名 `up` 序列为 `foobar` 序列。

#### drop_common_labels

`drop_common_labels(q1, ...., qN)` 是删除从 `q1, ..., qN` 返回的时间序列中的共同`label="value"` 对的[标签操作函数](#label-manipulation-functions)。

#### label_copy

`label_copy(q, "src_label1", "dst_label1", ..., "src_labelN", "dst_labelN")` 是将 `src_label*` 的标签值复制到 `q` 返回的所有时间序列的 `dst_label*` 中的[标签操作函数](#label-manipulation-functions)。如果 `src_label` 为空，则相应的 `dst_label` 保持不变。

#### label_del

`label_del(q, "label1", ..., "labelN")` 是从 `q` 返回的所有时间序列中删除给定的 `label*` 的[标签操作函数](#label-manipulation-functions)。


#### label_join

`label_join(q, "dst_label", "separator", "src_label1", ..., "src_labelN")` 是将 `src_label*` 值与给定的 `separator` 连接并将结果存储在 `dst_label` 中的[标签操作函数](#label-manipulation-functions)。这是针对 `q` 返回的每个时间序列单独执行的。例如，`label_join(up{instance="xxx",job="yyy"}, "foo", "-", "instance", "job")` 将 `xxx-yyy` 标签值存储到 `foo` 标签中。

> 此功能受 PromQL 支持。

#### label_keep

`label_keep(q, "label1", ..., "labelN")` 是在 `q` 返回的所有时间序列中仅保留列出的 `label*` 标签以外的所有标签的[标签操作函数](#label-manipulation-functions)。

#### label_lowercase

`label_lowercase(q, "label1", ..., "labelN")` 是在 `q` 返回的所有时间序列中将给定的 `label*` 标签的值转换为小写的[标签操作函数](#label-manipulation-functions)。

#### label_map

`label_map(q, "label", "src_value1", "dst_value1", ..., "src_valueN", "dst_valueN")` 是将 `q` 返回的所有时间序列的 `label` 值从 `src_*` 映射到 `dst*` 的[标签操作函数](#label-manipulation-functions)。

#### label_match

`label_match(q, "label", "regexp")` 是从 `q` 中删除不匹配给定 `regexp` 的 `label` 的时间序列的[标签操作函数](#label-manipulation-functions)。这个函数在类似于 [Rollup](#rollup) 函数之后很有用，这些函数可能为每个输入序列返回多个时间序列。

> 另请参见 [label_mismatch](#label_mismatch)。

#### label_mismatch

`label_mismatch(q, "label", "regexp")` 是从 `q` 中删除匹配给定 `regexp` 的 `label` 的时间序列的[标签操作函数](#label-manipulation-functions)。这个函数在类似于 [Rollup](#rollup) 函数之后很有用，这些函数可能为每个输入序列返回多个时间序列。

> 另请参见 [label_match](#label_match)。

#### label_move

`label_move(q, "src_label1", "dst_label1", ..., "src_labelN", "dst_labelN")` 是将 `src_label*` 的标签值移动到 `q` 返回的所有时间序列的 `dst_label*` 中的[标签操作函数](#label-manipulation-functions)。如果 `src_label` 为空，则相应的 `dst_label` 保持不变。

#### label_replace

`label_replace(q, "dst_label", "replacement", "src_label", "regex")` 是将给定 `regex` 应用于 `src_label`，并在给定 `regex` 匹配 `src_label` 时将 `replacement` 存储在 `dst_label` 中的[标签操作函数](#label-manipulation-functions)。`replacement` 可以包含对正则表达式捕获组的引用，如 `$1`、`$2` 等。这些引用会被相应的正则表达式捕获替换。例如，`label_replace(up{job="node-exporter"}, "foo", "bar-$1", "job", "node-(.+)")` 将 `bar-exporter` 标签值存储到 `foo` 标签中。

> 此功能受 PromQL 支持。

#### label_set

`label_set(q, "label1", "value1", ..., "labelN", "valueN")` 是将 `{label1="value1", ..., labelN="valueN"}` 标签设置为 `q` 返回的所有时间序列的[标签操作函数](#label-manipulation-functions)。

#### label_transform

`label_transform(q, "label", "regexp", "replacement")` 是在给定的 `label` 中将所有 `regexp` 出现替换为给定的 `replacement` 的[标签操作函数](#label-manipulation-functions)。

#### label_uppercase

`label_uppercase(q, "label1", ..., "labelN")` 是在 `q` 返回的所有时间序列中将给定的 `label*` 标签的值转换为大写的[标签操作函数](#label-manipulation-functions)。

> 另请参见 [label_lowercase](#label_lowercase)。

#### label_value

`label_value(q, "label")` 是为 `q` 返回的每个时间序列获取给定 `label` 的数值的[标签操作函数](#label-manipulation-functions)。

例如，如果将 `label_value(foo, "bar")` 应用于 `foo{bar="1.234"}`，则它将返回一个时间序列 `foo{bar="1.234"}`，其值为 `1.234`。对于非数字标签值，函数不会返回任何数据。

#### sort_by_label

`sort_by_label(q, label1, ... labelN)` 是[标签操作函数](#label-manipulation-functions)，它按给定标签集以升序排列系列。例如，`sort_by_label(foo, "bar")` 会按这些系列中标签 `bar` 的值对 `foo` 系列进行排序。

> 另请参见 [sort_by_label_desc](#sort_by_label_desc) 和 [sort_by_label_numeric](#sort_by_label_numeric)。

#### sort_by_label_desc

`sort_by_label_desc(q, label1, ... labelN)` 是 [标签操作函数](#label-manipulation-functions)，它按给定标签集以降序排列系列。例如，`sort_by_label(foo, "bar")` 会按这些系列中标签 `bar` 的值对 `foo` 系列进行排序。

> 另请参见 [sort_by_label](#sort_by_label) 和 [sort_by_label_numeric_desc](#sort_by_label_numeric_desc)。

#### sort_by_label_numeric

`sort_by_label_numeric(q, label1, ... labelN)` 是 [标签操作函数](#label-manipulation-functions)，它使用 [numeric sort](https://www.gnu.org/software/coreutils/manual/html_node/Version-sort-is-not-the-same-as-numeric-sort.html) 按给定标签集以升序排列系列。例如，如果 `foo` 系列具有值 `1`、`101`、`15` 和 `2`的 `bar` 标签，则 `sort_by_label_numeric(foo, "bar")` 将按以下 `bar` 标签值的顺序返回系列：`1`、`2`、`15` 和 `101`。

> 另请参见 [sort_by_label_numeric_desc](#sort_by_label_numeric_desc) 和 [sort_by_label](#sort_by_label)。

#### sort_by_label_numeric_desc

`sort_by_label_numeric_desc(q, label1, ... labelN)` 是 [标签操作函数](#label-manipulation-functions)，它使用 [numeric sort](https://www.gnu.org/software/coreutils/manual/html_node/Version-sort-is-not-the-same-as-numeric-sort.html) 按给定标签集以降序排列系列。例如，如果 `foo` 系列具有值 `1`、`101`、`15` 和 `2` 的 `bar` 标签，则 `sort_by_label_numeric(foo, "bar")` 将按以下 `bar` 标签值的顺序返回系列：`101`、`15`、`2` 和 `1`。

> 另请参见[sort_by_label_numeric](#sort_by_label_numeric)和[sort_by_label_desc](#sort_by_label_desc)。

### 聚合函数

**聚合函数**计算 [Rollup 结果](#rollup-functions) 组的聚合。

附加详细信息：

- 默认情况下，使用单个组进行聚合。通过在 `by` 和 `without` 修改器中指定分组标签，可以设置多个独立组。例如，`count(up) by (job)` 将按 `job` 标签值对 [Rollup 结果](#rollup-functions) 进行分组，并在每个组中单独计算 [count](#count) 聚合函数，而 `count(up) without (instance)` 将在计算 [count](#count) 聚合函数之前将 [Rollup 结果](#rollup-functions) 按除 `instance` 之外的所有标签进行分组。多个标签可以放置在 `by` 和 `without` 修改器中。
- 如果直接将聚合函数应用于 [序列选择器](https://docs.victoriametrics.com/keyConcepts.html#filtering)，则在计算聚合之前会自动应用 [default_rollup()](#default_rollup) 函数。例如，`count(up)` 隐式转换为 `count(default_rollup(up[1i]))`。
- 聚合函数接受任意数量的参数。例如，`avg(q1, q2, q3)` 将为 `q1`、`q2` 和 `q3` 返回每个点的平均值。
- 聚合函数支持可选的 `limit N` 后缀，可用于限制输出组的数量。例如，`sum(x) by (y) limit 3` 将聚合的组数限制为3。所有其他组都会被忽略。

> 另请参见 [implicit query conversions](#implicit-query-conversions)。

### 支持的聚合函数列表

#### any

`any(q) by (group_labels)` 是 [聚合函数](#aggregate-functions)，它从 `q` 返回的时间序列中每个 `group_labels` 返回一个序列。

> 另请参见 [group](#group)。

#### avg

`avg(q) by (group_labels)` 是 [聚合函数](#aggregate-functions)，它返回 `q` 的时间序列每个 `group_labels` 的平均值。聚合将针对具有相同时间戳的点的每个组单独计算。

> 此函数由 PromQL 支持。

#### bottomk

`bottomk(k, q)` 是 [聚合函数](#aggregate-functions)，它返回 `q` 的所有时间序列中具有最小值的 `k` 个点。聚合将针对具有相同时间戳的点的每个组单独计算。

> 此函数由 PromQL 支持。另请参见 [topk](#topk)。

#### bottomk_avg

`bottomk_avg(k, q, "other_label=other_value")` 是 [聚合函数](#aggregate-functions)，它返回 `q` 中平均值最小的 `k` 个时间序列。如果设置了可选的 `other_label=other_value` 参数，则返回其余时间序列的总和和所给标签。例如，`bottomk_avg(3, sum(process_resident_memory_bytes) by (job), "job=other")` 将返回平均值最小的 3 个时间序列和具有任何余数的 `{job="other"}` 标签的时间序列。

> 另请参见 [topk_avg](#topk_avg)。

#### bottomk_last

`bottomk_last(k, q, "other_label=other_value")` 是 [聚合函数](#aggregate-functions)，它返回 `q` 中最后值最小的 `k` 个时间序列。如果设置了可选的 `other_label=other_value` 参数，则返回剩余时间序列的总和和所给标签。例如，`bottomk_max(3, sum(process_resident_memory_bytes) by (job), "job=other")` 将返回最大值最小的 3 个时间序列和具有任何余数的 `{job="other"}` 标签的时间序列。

> 另请参见 [topk_last](#topk_last)。

#### bottomk_max

`bottomk_max(k, q, "other_label=other_value")` 是 [聚合函数](#aggregate-functions)，它返回 `q` 中最大值最小的 `k` 个时间序列。如果设置了可选的 `other_label=other_value` 参数，则返回剩余时间序列的总和和所给标签。例如，`bottomk_max(3, sum(process_resident_memory_bytes) by (job), "job=other")` 将返回最大值最小的 3 个时间序列和具有任何余数的 `{job="other"}` 标签的时间序列。

> 另请参见 [topk_max](#topk_max)。

#### bottomk_median

`bottomk_median(k, q, "other_label=other_value")` 是 [聚合函数](#aggregate-functions)，它返回 `q` 中中位数最小的 `k` 个时间序列。如果设置了可选的 `other_label=other_value` 参数，则返回剩余时间序列的总和和所给标签。例如，`bottomk_median(3, sum(process_resident_memory_bytes) by (job), "job=other")` 将返回中位数最小的 3 个时间序列和具有任何余数的 `{job="other"}` 标签的时间序列。

> 另请参见 [topk_median](#topk_median)。

#### bottomk_min

`bottomk_min(k, q, "other_label=other_value")` 是 [聚合函数](#aggregate-functions)，它返回 `q` 中最小值最小的 `k` 个时间序列。如果设置了可选的 `other_label=other_value` 参数，则返回剩余时间序列的总和和所给标签。例如，`bottomk_min(3, sum(process_resident_memory_bytes) by (job), "job=other")` 将返回最小值最小的 3 个时间序列和具有任何余数的 `{job="other"}` 标签的时间序列。

> 另请参见 [topk_min](#topk_min)。

#### count

`count(q) by (group_labels)` 是 [聚合函数](#aggregate-functions)，它返回 `q` 的非空点每个 `group_labels` 的数量。聚合将针对具有相同时间戳的点的每个组单独计算。

> 此函数由 PromQL 支持。

#### count_values

`count_values("label", q)` 是 [聚合函数](#aggregate-functions)，它计算具有相同值的点的数量，并将计数存储在具有每个初始值的附加 `label` 的时间序列中。聚合将针对具有相同时间戳的点的每个组单独计算。

> 此函数由 PromQL 支持。

#### distinct

`distinct(q)` 是 [聚合函数](#aggregate-functions)，它计算具有相同时间戳的每个组的唯一值的数量。

#### geomean

`geomean(q)` 是 [聚合函数](#aggregate-functions)，它计算具有相同时间戳的每个组的几何平均值。

#### group

`group(q) by (group_labels)` 是 [聚合函数](#aggregate-functions)，它为 `q` 返回的时间序列中每个 `group_labels` 返回 `1`。

> 此函数由 PromQL 支持。另请参见 [any](#any)。

#### histogram

`histogram(q)` 是聚合函数，它为每个具有相同时间戳的点组计算 VictoriaMetrics 直方图。通过热力图可视化大量时间序列。更多详细信息请参见本文。

> 另请参见 `histogram_over_time` 和 `histogram_quantile`。

#### limitk

`limitk(k, q) by (group_labels)` 是聚合函数，它返回每个 `group_labels` 中由 `q` 返回的时间序列中最多的 `k` 个时间序列。返回的时间序列集在调用之间保持不变。

> 另请参见 `limit_offset`。

#### mad

`mad(q) by (group_labels)` 是聚合函数，它为每个 `group_labels` 中由 `q` 返回的所有时间序列计算中位数绝对偏差。每个具有相同时间戳的点组单独计算聚合。

> 另请参见 `range_mad`、`mad_over_time`、`outliers_mad` 和 `stddev`。

#### max

`max(q) by (group_labels)` 是聚合函数，它为所有由 `q` 返回的时间序列中的每个 `group_labels` 返回最大值。每个具有相同时间戳的点组单独计算聚合。

> PromQL 支持此功能。

#### median

`median(q) by (group_labels)` 是聚合函数，它为所有由 `q` 返回的时间序列中的每个 `group_labels` 返回中位数值。每个具有相同时间戳的点组单独计算聚合。

#### min

`min(q) by (group_labels)` 是聚合函数，它为所有由 `q` 返回的时间序列中的每个 `group_labels` 返回最小值。每个具有相同时间戳的点组单独计算聚合。

> PromQL 支持此功能。

#### mode

`mode(q) by (group_labels)` 是聚合函数，它为所有由 `q` 返回的时间序列中的每个 `group_labels` 返回模式。每个具有相同时间戳的点组单独计算聚合。

#### outliers_mad

`outliers_mad(tolerance, q)` 是聚合函数，它返回 `q` 中至少有一个点在中位数绝对偏差（MAD）乘以 `tolerance` 之外的时间序列。例如，它返回具有至少一个点低于 `median(q)-mad(q)` 或单个点高于 `median(q)+mad(q)` 的时间序列。

> 另请参见 `outliersk` 和 `mad`。

#### outliersk

`outliersk(k, q)` 是聚合函数，它从 `q` 返回的时间序列中返回最大标准偏差（即异常值）的最多 `k` 个时间序列。

> 另请参见 `outliers_mad`。

#### quantile

`quantile(phi, q) by (group_labels)` 是聚合函数，它计算所有由 `q` 返回的时间序列的每个 `group_labels` 的 `phi` 分位数。`phi` 必须在范围 `[0...1]` 内。每个具有相同时间戳的点组单独计算聚合。

> PromQL 支持此功能。另请参见 `quantiles` 和 `histogram_quantile`。

#### quantiles

`quantiles("phiLabel", phi1, ..., phiN, q)` 是聚合函数，它计算由 `q` 返回的所有时间序列的 `phi*` 分位数，并将它们返回到带有 `{phiLabel="phi*"}` 标签的时间序列中。`phi*` 必须在范围 `[0...1]` 内。每个具有相同时间戳的点组单独计算聚合。

> 另请参见`quantile`。

#### share

`share(q) by (group_labels)` 是聚合函数，它为每个时间戳的每个非负点返回范围 `[0..1]` 内的份额，因此每个 `group_labels` 的份额总和为1。

此函数用于将 [直方图桶](https://docs.victoriametrics.com/keyConcepts.html#histogram) 份额归一化为 `[0..1]` 范围：

```
share(
  sum(
    rate(http_request_duration_seconds_bucket[5m])
  ) by (le, vmrange)
)
```

> 另请参见 [range_normalize](#range_normalize)。

#### stddev

`stddev(q) by (group_labels)` 是[聚合函数](#aggregate-functions)，它计算出由 `q` 返回的所有时间序列在每个 `group_labels` 上的标准差。该聚合是根据时间戳相同的每个点的组别单独计算的。

> 此函数受 PromQL 支持。

#### stdvar

`stdvar(q) by (group_labels)` 是[聚合函数](#aggregate-functions)，它计算出由 `q` 返回的所有时间序列在每个 `group_labels` 上的标准方差。该聚合是根据时间戳相同的每个点的组别单独计算的。

> 此函数受 PromQL 支持。

#### sum

`sum(q) by (group_labels)` 是[聚合函数](#aggregate-functions)，它返回由 `q` 返回的所有时间序列在每个 `group_labels` 上的总和。该聚合是根据时间戳相同的每个点的组别单独计算的。

> 此函数受 PromQL 支持。

#### sum2

`sum2(q) by (group_labels)` 是[聚合函数](#aggregate-functions)，它计算出由 `q` 返回的所有时间序列在每个 `group_labels` 上的平方和。该聚合是根据时间戳相同的每个点的组别单独计算的。

#### topk

`topk(k, q)` 是[聚合函数](#aggregate-functions)，它返回由 `q` 返回的所有时间序列中最大值的前 `k` 个点。该聚合是根据时间戳相同的每个点的组别单独计算的。

> 此函数受 PromQL 支持。另请参见 [bottomk](#bottomk)。

#### topk_avg

`topk_avg(k, q, "other_label=other_value")` 是[聚合函数](#aggregate-functions)，它返回 `q` 中平均值最大的前 `k` 个时间序列。如果设置了一个可选的 `other_label=other_value` 参数，则返回其余时间序列的总和与给定标签。例如，`topk_avg(3, sum(process_resident_memory_bytes) by (job), "job=other")` 将返回最大的三个平均值时间序列以及一个带有标签 `{job="other"}` 的时间序列，其中包含其余系列的总和（如果有）。

> 另请参见 [bottomk_avg](#bottomk_avg)。

#### topk_last

`topk_last(k, q, "other_label=other_value")` 是[聚合函数](#aggregate-functions)，它返回 `q` 中最后一个值最大的前 `k` 个时间序列。如果设置了一个可选的 `other_label=other_value` 参数，则返回其余时间序列的总和与给定标签。例如，`topk_max(3, sum(process_resident_memory_bytes) by (job), "job=other")` 将返回最大的三个最大值时间序列以及一个带有标签 `{job="other"}` 的时间序列，其中包含其余系列的总和（如果有）。

> 另请参见 [bottomk_last](#bottomk_last)。

#### topk_max

`topk_max(k, q, "other_label=other_value")` 是[聚合函数](#aggregate-functions)，它返回 `q` 中最大值最大的前 `k` 个时间序列。如果设置了一个可选的 `other_label=other_value` 参数，则返回其余时间序列的总和与给定标签。例如，`topk_max(3, sum(process_resident_memory_bytes) by (job), "job=other")` 将返回最大的三个最大值时间序列以及一个带有标签 `{job="other"}` 的时间序列，其中包含其余系列的总和（如果有）。

> 另请参见 [bottomk_max](#bottomk_max)。

#### topk_median

`topk_median(k, q, "other_label=other_value")` 是[聚合函数](#aggregate-functions)，它返回 `q` 中中位数最大的前 `k` 个时间序列。如果设置了一个可选的 `other_label=other_value` 参数，则返回其余时间序列的总和与给定标签。例如，`topk_median(3, sum(process_resident_memory_bytes) by (job), "job=other")` 将返回最大的三个中位数时间序列以及一个带有标签 `{job="other"}` 的时间序列，其中包含其余系列的总和（如果有）。

> 另请参见 [bottomk_median](#bottomk_median)。

#### topk_min

`topk_min(k, q, "other_label=other_value")` 是[聚合函数](#aggregate-functions)，它返回 `q` 中最小值最大的前 `k` 个时间序列。如果设置了一个可选的 `other_label=other_value` 参数，则返回其余时间序列的总和与给定标签。例如，`topk_min(3, sum(process_resident_memory_bytes) by (job), "job=other")` 将返回最大的三个最小值时间序列以及一个带有标签 `{job="other"}` 的时间序列，其中包含其余系列的总和（如果有）。

> 另请参见 [bottomk_min](#bottomk_min)。

#### zscore

`zscore(q) by (group_labels)` 是[聚合函数](#aggregate-functions)，它返回由 `q` 返回的所有时间序列在每个 `group_labels` 上的 [z-score](https://en.wikipedia.org/wiki/Standard_score) 值。该聚合是根据时间戳相同的每个点的组别单独计算的。此函数用于检测相关时间序列组中的异常值。

> 另请参见 [zscore_over_time](#zscore_over_time) 和 [range_trim_zscore](#range_trim_zscore)。

## 子查询

MetricsQL 支持并扩展了 PromQL 子查询。有关详情，请参见 [此文章](https://valyala.medium.com/prometheus-subqueries-in-victoriametrics-9b1492b720b3)。任何不是 [序列选择器](https://docs.victoriametrics.com/keyConcepts.html#filtering) 形式的 [Rollup 函数](#rollup-functions)都会形成一个子查询。多层 Rollup 函数可以隐式转换为 [隐式查询转换](#implicit-query-conversions)。例如，`delta(sum(m))` 被隐式转换为 `delta(sum(default_rollup(m[1i]))[1i:1i])`，因此它成为一个子查询，因为它包含嵌套的 [default_rollup](#default_rollup) 和 [delta](#delta)。

MetricsQL 执行子查询的方式如下：

- 使用外部 Rollup 函数的 `step` 值计算内部 Rollup 函数。例如，对于表达式 `max_over_time(rate(http_requests_total[5m])[1h:30s])`，将使用 `step=30s` 计算内部函数 `rate(http_requests_total[5m])`。计算结果的数据点按 `step` 对齐。
- 使用前端传递的 `step` 值，在内部 Rollup 函数的结果上计算外部 Rollup 函数。

## 隐式查询转换

在开始计算之前，MetricsQL 会对传入的查询执行以下隐式转换:

- 如果在 [Rollup 函数](#rollup-functions) 内部缺少方括号中的向前查看窗口，则会自动添加 `[1i]`。`[1i]` 表示一个 `step` 值，该值传递给 [/api/v1/query_range](https://docs.victoriametrics.com/keyConcepts.html#range-query)。在 Grafana 中，它也被称为 `$__interval`。例如，`rate(http_requests_count)` 会自动转换为 `rate(http_requests_count[1i])`。

- 所有未包装在 Rollup 函数内的序列选择器都会自动包装到 `default_rollup` 函数中。例如：

    - `foo` 会转换为 `default_rollup(foo[1i])`
    - `foo + bar` 会转换为 `default_rollup(foo[1i]) + default_rollup(bar[1i])`
    - `count(up)` 会转换为 `count(default_rollup(up[1i]))`，因为 [count](#count) 不是 [Rollup 函数](#rollup-functions) ，而是[聚合函数](#aggregate-functions)
    - `abs(temperature)` 会转换为 `abs(default_rollup(temperature[1i]))`，因为 [abs](#abs) 不是 [Rollup 函数](#rollup-functions)，而是[转换函数](#transform-functions)

- 如果 [subquery](#subqueries) 中缺少方括号中的 `step` ，则会自动添加 `1i` 步骤。例如，`avg_over_time(rate(http_requests_total[5m])[1h])` 会自动转换为 `avg_over_time(rate(http_requests_total[5m])[1h:1i])`。

- 如果传递给 [Rollup 函数](#rollup-functions) 的不是 [序列选择器](https://docs.victoriametrics.com/keyConcepts.html#filtering)，则会自动形成一个带有 `1i` 向前查看窗口和 `1i` 步骤的 [subquery](#subqueries)。例如，`rate(sum(up))` 会自动转换为 `rate((sum(default_rollup(up[1i])))[1i:1i])`。