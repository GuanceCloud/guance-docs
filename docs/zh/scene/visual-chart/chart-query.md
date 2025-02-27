# 图表查询
---

选定图表后，您可采用多种查询手段对不同类别的数据进行深入查询和分析。这些查询方式可帮助在图表中直观展示数值信息，并揭示数据之间的重要关系。

## 查询方式 {#query}

单个图表同时支持以下查询方式：

- 简单查询
- 表达式查询
- DQL 查询
- PromQL 查询
- 数据源

???+ warning "切换查询方式"

    简单查询和 DQL 查询可通过 :fontawesome-solid-code: 按钮相互切换。切换后，若无法解析或者解析不完整：

    - 在简单查询下未操作，直接切换回 DQL 查询则显示之前的 DQL 查询语句；  
    - 在简单查询下调整了查询语句，再次切换回 DQL 查询将按照最新的简单查询进行解析。

<img src="../../img/query.png" width="70%" >


### 简单查询 {#simple}

对不同[数据来源](#source)的数据进行查询，并通过选择聚合函数、分组标签、Label、筛选条件等进行图表展示。


#### 数据来源 {#source}

包括来自指标、日志、基础对象、资源目录、事件、应用性能、用户访问、安全巡检、网络、Profile、云账单的一系列数据组合。

| 来源 | 说明 |
| --- | --- |
| 指标 | 需选择**指标集**和**指标**，一个指标集可包含多个指标。 |
| 其他类型 | 基础对象、资源目录、安全巡检：需选择**分类**和**属性/标签**；<br />日志、事件、应用性能、用户访问：需选择**来源**和**属性/标签**。 |

???- warning "当日志作为数据源"

    可选择不同的索引来对应的日志内容，默认为索引 `default`。
    
    > 更多详情，可参考文档 [日志索引](../../logs/multi-index/index.md)。

    <img src="../../img/chart-source-log.png" width="70%" >

#### 多个查询

即选择多个查询条件，数据按所选的筛选项进行分组展示。

为方便区分数据查询结果的展示，可点击 AS 按钮为每条查询条件添加别名。

<img src="../../img/chart-multi-query.png" width="70%" >

如您希望将添加的别名直接显示在图表上，点击右侧[图例](./chart-config.md#legend) > 位置，选择底部或右侧即可。

<img src="../../img/chart-multi-query-legend.png" width="70%" >

#### Label 筛选 {#label}

**前提**：已经在在**基础设施 > [主机](../../infrastructure/host.md#label)**中为主机设置过 Label 属性。

即在 **`fx` > Label 筛选**，正选或反选主机 Label 属性进行筛选显示。

<img src="../../img/chart_query_label.png" width="70%" >



#### 添加筛选

点击 :material-filter-outline: 图标，可为当前查询添加筛选条件。

单个查询下可添加多个筛选条件，每个筛选条件之间包括 `AND` 和 `OR` 两种取值方式。

| 筛选条件       | 说明                                     | 支持的筛选条件类型           |
| -------------- | ---------------------------------------- | ---------------------------- |
| `=`            | 等于                                     | `Integer`、`Float`、`String` |
| `!=`           | 不等于                                   | `Integer`、`Float`、`String` |
| `>=`           | 大于等于                                 | `Integer`、`Float`、`String` |
| `<=`           | 小于等于                                 | `Integer`、`Float`、`String` |
| `>`            | 大于                                     | `Integer`、`Float`、`String` |
| `<`            | 小于                                     | `Integer`、`Float`、`String` |
| `match`        | 包含                                     | `String`                     |
| `not match`    | 不包含                                   | `String`                     |
| `wildcard`     | 模糊匹配（支持除指标以外的日志类数据）   | `String`                     |
| `not wildcard` | 模糊不匹配（支持除指标以外的日志类数据） | `String`                     |


<img src="../../img/chart_query_add_label.png" width="70%" >

#### 函数

点击 **fx** 图标，可为该查询添加函数计算指标等数据源。

<img src="../../img/chart_query_add_fix.png" width="70%" >


##### Rollup 函数 {#rollup}

即将数据切片成指定时间间隔的数据，并计算返回每个时间间隔的数据。

**注意**：

1. 在时序图表中，选择该函数以及聚合方式后，可前往**高级配置**选择时间间隔；
2. 在非时序图中，选择该函数后，可选择包含 `avg`、`sum`、`min` 等在内的聚合方式和包含 auto、10s、20s、30s、1m、5m、10m、30m、1h、6h、12h、1d、7d、30d 在内的时间间隔（`interval`）；
3. 仅支持指标数据查询，图表简单模式下其他数据查询不支持选择 Rollup 函数；
4. Rollup 函数不支持添加多个。

> 更多详情，可参考 [Rollup 函数](../../dql/rollup-func.md)。

##### 转换函数

又称外层函数，UI 模式下支持选择的函数如下所示：

| <div style="width: 180px">转换函数（外层函数） </div> | 说明 |
| --- | --- |
| `cumsum` | 对处理集累计求和 |
| `abs` |  计算处理集每个元素的绝对值 |
| `log2` | 计算处理集每个元素以 2 为底数的对数，处理集至少大于一行，否则返回空值 |
| `log10` | 计算处理集每个元素以 10 为底数的对数，处理集至少大于一行，否则返回空值 |
| `moving_average`  | 计算处理集的移动平均值，窗口的大小需要不小于处理集的行数，否则返回空值 |
| `difference` | 计算处理集相邻元素的差值，处理集至少大于一行，否则返回空值 |
| `derivative` | 计算处理集相邻元素的导数，求导的时间单位为秒（s） |
| `non_negative_derivative` | 计算处理集相邻元素的非负导数，求导的时间单位为秒（s） |
| `non_negative_difference` | 计算处理集相邻元素的非负差值，处理集至少大于一行，否则返回空值 |
| `series_sum` | 当分组产生多个 series，根据时间点，合并为 1 个 series。其中，相同时间点的多个 series 求和，处理集至少大于一行，否则返回空值 |
| `rate` |  计算某个指标一定时间范围内的变化率，适合缓慢变化的计数器。时间单位为秒（s） |
| `irate` | 计算某个指标一定时间范围内的变化率，适合快速变化的计数器，时间单位为秒（s） |

> 在 DQL 模式下，支持更多的外部函数，可参考 [DQL 外层函数](../../dql/out-funcs.md)。

##### 聚合函数 {#aggregate-function}

UI 模式下支持选择聚合方式返回结果值。


| 聚合函数 | 说明 |
| --- | --- |
| `last` | 返回最新时间戳的值 |
| `first` | 返回最早时间戳的值 |
| `avg` | 返回字段的平均值。参数有且只有一个，参数类型是字段名 |
| `min` | 返回最小值 |
| `max` | 返回最大值 |
| `sum` | 返回字段值的和 |
| `P50` | 返回第百分之 50 的字段值 |
| `P75` | 返回第百分之 75 的字段值 |
| `P90` | 返回第百分之 90 的字段值 |
| `P99` | 返回第百分之 99 的字段值 |
| `count` | 返回非空字段值的汇总值 |
| `count_distinct` | 统计字段不同值的数量 |
| `difference` | 返回一个字段中连续的时间值之间的差异 |
| `derivative` | 返回一个字段在一个 series 中的变化率 |
| `non_negative_derivative` | 返回在一个 series 中的一个字段中值的变化的非负速率 |

> 在 DQL 模式下，支持更多的聚合函数，可参考 [DQL 聚合函数](../../dql/funcs.md)。



##### 窗口函数 {#window}

以选定的时间间隔为窗口（记录集合），结合聚合函数对每条记录都执行统计计算，支持选择 1 分钟、5 分钟、15 分钟、30 分钟、1 小时、3 小时、6 小时、12 小时、24 小时。

**注意**：窗口函数查询结果并不会改变记录条数，当前存在的记录数量在执行完函数结果后，仍保持之前的记录数量。

##### 无数据填充 {#fillin}

即设定空值数据的填充方式，设定后在查询中显示为 **fill**，包括三种类型：

| 函数 | 说明 |
| --- | --- |
| 前值填充（previous） | 将空值数据转为上一个数值。  |
| 线性填充（linear） | 将空值数据进行线性函数计算后填充。 |
| 数值填充 | 可自定义填充数值。 |

##### 高级函数

高级函数主要用于对 DQL 查出的数据进行进一步的函数计算，并进行直观的时序图展示。{{{ custom_key.brand_name }}}时序图表中支持选择自定义函数对数据进行二次处理并返回数据结果显示。


> 更多详情，可参考 [高级函数](../../dql/advanced-funcs/index.md)。


#### 隐藏查询

点击 :material-eye-outline: 图标，即可隐藏图表上的该条查询结果。

如下图，系统加载数据只显示 1m 和 15m 的查询结果，5m 的系统加载查询结果已被隐藏，无法在图表上查看。

<img src="../../img/enable_chart_query_result.png" width="70%" >

### 表达式查询

即通过添加表达式进行计算。若表达式查询中包含多个查询语句，分组标签需保持一致。在表达式计算中，若查询 A 带单位，查询 A 与数字的运算结果同样带单位。例如：A 的单位是 KB，那么 A+100 的单位也是 KB。

![](../img/chart022.png)

### DQL 查询

{{{ custom_key.brand_name }}}支持切换到 DQL 模式，手动输入 DQL 语句进行图表查询。

> 一个图表同时支持多条 DQL 查询。更多详情，可参考 [DQL 查询](../../dql/query.md)。

<img src="../../img/chart021.png" width="80%" >

### PromQL 查询 {#PromQL}

{{{ custom_key.brand_name }}}支持通过书写 PromQL 查询获取数据。

| 查询方式      | 说明        |
| ----------- | -------- |
| Range 查询      | 在一定时间范围内运行查询        |
| Instant 查询      | 针对单个时间点运行查询        |

PromQL 添加后默认形式为文本框输入。在此输入框，既可以输入 PromQL 简单查询也可以输入表达式查询。

> 点击了解 [DQL 与其它几种查询语言的对比](../../dql/dql-vs-others.md#promql)；或前往 [PromQL](https://prometheus.io/docs/prometheus/latest/querying/basics/)。


### 添加数据源 {#func}

即针对存储于数据库内的数据属性作筛选、搜索、聚合分析等操作。

<img src="../../img/func.png" width="80%" >

> 具体配置方法见 [Function 外部函数配置](../../dql/dql-out-func.md)。


<!-- 

#### 预设字段查询

若工作空间数据断档上报，在配置图表查询时无法选择数据，可在查询中预设字段值，默认为数值类型，按数值类型显示 [聚合函数](#aggregate-function)。
-->



<!--
若您已发布脚本并在 Function 平台内将脚本同步至对应工作空间，即可直接选择下表的 Func 数据源，{{{ custom_key.brand_name }}}会自动获取工作空间 Issue 信息，最终为您进行可视化的数据展示。目前{{{ custom_key.brand_name }}}支持针对[状态为 `resolved` 的 Issue](../../exception/issue.md#others) 列出处理时长统计指标类的脚本函数。

| 函数列表    | 说明 |
| --------- | ----------- |
| incidents-issue_total_count | 异常追踪-issue 总数 |
| incidents-open_issue_count | 异常追踪-open issue 数量 |
| incidents-pending_issue_count | 异常追踪-pending issue 数量 |
| incidents-resolved_issue_count | 异常追踪-resolved issue 数量 |
| incidents-average_issue_duration | 异常追踪-issue 平均处理时长 |
| incidents-max_issue_duration | 异常追踪-issue 最大处理时长 |
| incidents-issue_count_distribution_by_level | 异常追踪-issue 等级分布 |
| incidents-issue_count_distribution_by_reference | 异常追踪-issue 来源分布 |
| incidents-issue_count_by_assignee(top10) | 异常追踪-issue 处理数量 TOP 10 负责人 |
| incidents-issue_duration_by_assignee(top10) | 异常追踪-issue 处理时长 TOP 10 负责人 |
| incidents-unresolved_issue_assignee_distribution | 异常追踪-未解决 issue 负责人分布 |
| incidents-unresolved_issue_list | 异常追踪-未解决 issue 列表 |
-->



<!--
## 时间分片 {#time-slicing}

### 开启时间分片

时间分片一般和时间间隔配合使用，开启时间分片后，会先对原始数据按照一定的时间间隔进行分段聚合，再对聚合后数据集进行第二次聚合得到结果值。

![](../img/8.chart_7.png)

在下面的概览图示例中，首先是把最近一小时内活跃的内存按照 5 分钟为时间间隔聚合得到 12 个平均值，然后取其中最大值在图表上展示。

![](../img/8.chart_8.png)

### 关闭时间分片

若未开启时间分片，所有采集上来的原始数据根据选择的函数进行聚合得到结果值。

<img src="../../img/8.chart_6.png" width="70%" >

在下面的概览图示例中，把最近一小时内活跃的内存取其平均值在图表上展示。

![](../img/8.chart_9.png)

## 图表千分位 {#thousand}

{{{ custom_key.brand_name }}}仪表板图表查询结果支持自动加上数据千分位格式显示。

![](../img/13.table_1.png)

若设置了单位，则按照设置的单位显示数据格式。

![](../img/13.table_2.png)

设置完成后可以在预览的情况下按照千分位数据格式显示，若设置单位则按照单位设置格式显示。

- 千分位数据格式显示：

<img src="../../img/13.table_4.png" width="70%" >

- 设置的数据格式显示：

<img src="../../img/13.table_5.png" width="70%" >

-->