# 计费产生逻辑
---

本文将展示在<<< custom_key.brand_name >>>产品的按量付费计费框架中，各计费项的计费产生和价格计算逻辑。


## 概念先解

| 名词   | 说明 |
| -------- | ---------- |
| 数据存储   | 即对不同的数据类型自定义设置数据保存时长。|
| 基础计费   | 某个计费项的单价为**固定值**。 |
| 梯度计费   | 某个计费项的单价为**动态值**，会根据当前数据类型选择的数据存储策略有**不同的单价值**。 |

## 计费周期 {#cycle}

<<< custom_key.brand_name >>>计费周期为**天**，即根据工作空间当天统计的使用量在次日零点结算，生成每日账单同步到<<< custom_key.brand_name >>>[费用中心](../billing-center/index.md)，最终根据实际绑定结算方式从对应账中扣除消费金额。

<!--

## 计费模型

| 全量统计   |     |     |     |     |     |     |     |     |
| -------- | ---------- | ---------- | ---------- | ---------- | ---------- | ---------- | ---------- | ---------- |
|    |  数据存储   |  3 天   |  7 天   |  14 天   |  30 天   |  180 天   |  360 天   |     |
|   时间线 |     |     |     |     |     |     |     |     |
|    |   中国区站点  |     |     |     |     |     |     |     |
|    |     |     |     |     |     |     |     |     |
|    | 中国香港及海外站点    |     |     |     |     |     |     |     |

<!--

## 结算方式 {#account}

<<< custom_key.brand_name >>>支持<<< custom_key.brand_name >>>费用中心账号、云账号等多种结算方式，云账号结算包括阿里云账号、AWS 账号结算和华为云账号结算，在云账号结算模式下支持多个站点的云账单合并到一个云账号下进行结算。

> 更多具体结算方式说明，可参考 [<<< custom_key.brand_name >>>结算方式](../../billing/billing-account/index.md)。

<!--
## 统计范围 {#count}

**全量统计**

![](../img/all.png)


**增量统计**

![](../img/add.png)

> <<< custom_key.brand_name >>>不同类型数据的数据保存策略支持自定义选择，详细信息请参考 [数据存储策略](../../billing-method/data-storage.md)。
-->

## 计费项 {#item}

### 时间线 {#timeline}

<<< custom_key.brand_name >>>的时序引擎存储数据主要涉及到以下几个基本概念：

| 名词   | 说明 |
| -------- | ---------- |
| 指标集   | 一般用于表示某种统计值对应的一个集合，从原理上类似关系型数据库中的 `table` 概念。 |
| 数据点   | 应用于指标数据上报场景则指代一条指标数据样本，具体可类比关系型数据库中的 `row` 数据。 |
| 时间   | 时间戳，代表数据点产生的时间，这里也可以理解为 DataKit 采集到某条指标数据产生行协议上报的时间。 |
| 指标   | Field，一般情况下存放的是会随着时间戳的变化而变化的数值类型的数据。例如我们在 CPU 指标集中常见的 `cpu_total`,`cpu_use`,`cpu_use_pencent` 等都是指标。 |
| 标签   | Tags，一般存放的是并不随着时间戳变化的属性信息。例如在 CPU 指标集中常见的 `host`、`project` 等字段都是标签属性，用来标识指标的实际对象属性。 |


#### 示例 {#exapmle}

![](../img/billing-2.png)

以上图为例，指标集 CPU 中基于单个指标存在共 6 个数据点，每个数据点都有一个时间字段：`time`，一个指标：`cpu_use_pencent`，两个标签：`host`、`project`。第一行和第四行数据都是 `host` 名称是 `Hangzhou_test1` 且 `project` 归属于 Guance 的 CPU 使用率（`cpu_use_pencent`）情况，依此类推第二行和第五行表示 `host` 名称是 `Ningxia_test1` 且 `project` 归属于 Guance 的 CPU 使用率，第三行和第六行 `host` 名称是 `Singapore_test1` 且 `project` 归属于 `Guance_oversea` 的 CPU 使用率。

根据上述时间线的统计数据，基于 `cpu_use_pencent` 这个指标的时间线组合一共有 3 种，分别是：

`"host":"Hangzhou_test1","project":"Guance"`      
`"host":"Ningxia_test1","project":"Guance"`       
`"host":"Singapore_test1","project":"Guance_oversea"`       

依此类似如需统计当前工作空间内所有的指标的时间线，只需将实际统计到指标的时间线数量求和即可得到。



通过 DataKit 采集指标数据上报到某个工作空间。特指 DQL 中 NameSpace 为 **M** 查询得到的数据。



<div class="grid cards" markdown>

- [<font color="coral"> :fontawesome-solid-arrow-up-right-from-square: &nbsp; 时间线计费明细</font>](../billing-method/index.md#timeline)


</div>

???+ abstract "计费项统计"

    每小时的时间间隔统计**当天内**新增的时间线数量。

    费用计算公式：天费用 = 实际计费数量/1000 * 单价（根据上面数据存储策略应用对应单价）

### 日志 {#logs}



以下任意一种情况发生都会产生对应的日志类数据：

- 开启日志数据采集并上报；

- 开启监控器、智能巡检、SLO 等异常检测任务配置或通过 OpenAPI 上报自定义事件；

- 开启可用性拨测任务，并通过自建拨测节点触发上报的拨测数据。



<div class="grid cards" markdown>

- [<font color="coral"> :fontawesome-solid-arrow-up-right-from-square: &nbsp; 日志计费明细</font>](../billing-method/index.md#logs)


</div>

???+ abstract "计费项统计"

    每小时的时间间隔统计 **1 小时内**新增的日志类数据数量。

    费用计算公式：天费用 = 实际计费数量/1000000 * 单价（根据上面数据存储策略应用对应单价）

???+ warning

    **根据选择不同的存储类型，超大的日志数据会拆分成多条进行计费**：

    **ES 存储**：日志大小超过 10 KB，该条日志计费的条数 = 取整数（日志大小/10 KB）

    **SLS 存储**：日志大小超过 2 KB，该条日志计费的条数 = 取整数（日志大小/2 KB）

    若单条数据小于上述限制，则还是按照 1 条计算。



### 数据转发 {#backup}


支持日志数据转发到<<< custom_key.brand_name >>>或其他四种外部存储的方式。基于数据转发规则，统计汇总转发的流量大小对应计费。

**注意**：保存到<<< custom_key.brand_name >>>提供的数据转发数据仍保留记录。
<!--
控制台可以配置备份规则将上报的日志数据同步做备份操作，匹配到备份规则的数据将会存储到数据转发的索引，<<< custom_key.brand_name >>>基于该索引下数据统计数据转发的容量大小。
-->



<div class="grid cards" markdown>

- [<font color="coral"> :fontawesome-solid-arrow-up-right-from-square: &nbsp; 数据转发计费明细</font>](../billing-method/index.md#backup)


</div>

???+ abstract "计费项统计"

    每小时的时间间隔统计**数据存储策略内**数据转发的容量大小。默认容量单位：Bytes。

    费用计算公式：天费用 = 实际计费容量/1000000000 * 对应单价

<!--
### 备份日志 {#backuplog}



统计每天出账时工作空间内保存到<<< custom_key.brand_name >>>存储对象的数据容量大小，即压缩后的数据容量大小。



<div class="grid cards" markdown>

- [<font color="coral"> :fontawesome-solid-arrow-up-right-from-square: &nbsp; 备份日志计费明细</font>](../billing-method/index.md#backuplog)


</div>

#### 计费项统计

以每小时的时间间隔统计**数据存储策略内**数据转发的容量大小，最终得到 24 个数据点之后，取最大值作为实际计费数量。默认容量单位：Bytes。

费用计算公式：天费用 = 实际计费容量/1000000000 * 对应单价

-->

### 网络 {#network}



- 开启 eBPF 网络数据采集



<div class="grid cards" markdown>

- [<font color="coral"> :fontawesome-solid-arrow-up-right-from-square: &nbsp; 上报网络数据主机计费明细</font>](../billing-method/index.md#network)


</div>

???+ abstract "计费项统计"

    每小时的时间间隔统计**当天内**新增的 host 数量。

    费用计算公式：天费用 = 实际计费数量 * 对应单价

### 应用性能 Trace {#trace}




- 工作空间内每日产生的 Span 数据数量统计。

**注意**：<<< custom_key.brand_name >>>新的计费调整中会取”数量/10“与 `trace_id` 数量中较大的作为当天计费数据出账。



<div class="grid cards" markdown>

- [<font color="coral"> :fontawesome-solid-arrow-up-right-from-square: &nbsp; 应用性能 Trace 数量计费明细</font>](../billing-method/index.md#trace)


</div>

???+ abstract "计费项统计"

    每小时的时间间隔统计 1 小时内新增的 `trace_id` 数量。

    费用计算公式：天费用 = 实际计费数量/1000000 * 对应单价

### 应用性能 Profile {#profile}



- 开启应用性能监测 Profile 数据采集



<div class="grid cards" markdown>

- [<font color="coral"> :fontawesome-solid-arrow-up-right-from-square: &nbsp; 应用性能 Profile 数量计费明细</font>](../billing-method/index.md#profile)


</div>

???+ abstract "计费项统计"

    每小时的时间间隔统计 1 小时内新增的 Profile 数据数量。

    费用计算公式：天费用 = 实际计费数量/10000 * 对应单价

???+ warning

    Profile 数据主要有两部分组成：**基础属性数据** + **Profile 分析文件**：

    若存在超大的 Profile 分析文件，那么 Profile 数据会被拆分成多条进行计费。

    Profile 分析文件数据大于 300 KB，计费条数 = 取整数（Profile 分析文件大小/300 KB）

    若分析文件小于上述限制，则还是按照 1 条计算。



### 用户访问 PV {#pv}




- 工作空间内每日产生的 Resource、Long Task、Error、Action 数据数量统计。

**注意**：<<< custom_key.brand_name >>>新的计费调整中会取”数量/100“ 与 PV 中较大的做为当天计费数据出账。



<div class="grid cards" markdown>

- [<font color="coral"> :fontawesome-solid-arrow-up-right-from-square: &nbsp; 用户访问 PV 数量计费明细</font>](../billing-method/index.md#pv)


</div>

???+ abstract "计费项统计"

    每小时的时间间隔统计 1 小时内新增的 PV 数据数量。

    费用计算公式：天费用 = 实际计费数量/10000 * 单价（*根据上面数据存储策略应用对应单价*）

### 会话重放 {#session}



- 开启会话回放采集



<div class="grid cards" markdown>

- [<font color="coral"> :fontawesome-solid-arrow-up-right-from-square: &nbsp; 会话重放计费明细</font>](../billing-method/index.md#session)


</div>

???+ abstract "计费项统计"

    每小时的时间间隔统计当天内新增的 Session 数量。

    费用计算公式：天费用 = 实际计费数量/1000 * 对应单价

???+ warning

    若存在超长活跃的 Session，那么 Session 会根据 `time_spent` 拆分成多条进行计费。

    Session `time_spent` > 4 小时，计费数量 = 取整数（`time_spent`/4 小时）；

    若 Session `time_spent` 小于上述 4 小时，则还是按照 1 个 Session 计算。


### 可用性监测 {#st}



- 开启可用性拨测任务并通过<<< custom_key.brand_name >>>提供的拨测节点返回拨测结果
  


<div class="grid cards" markdown>

- [<font color="coral"> :fontawesome-solid-arrow-up-right-from-square: &nbsp; 可用性监测数据计费明细</font>](../billing-method/index.md#st)


</div>

???+ abstract "计费项统计"

    每小时的时间间隔统计 1 小时内新增的拨测数据数量。

    费用计算公式：天费用 = 实际计费数量/10000 * 对应单价

???+ warning

    由于目前拨测数据存储在日志的 **默认** 索引，所以 DQL 查询或统计需要增加以下筛选条件查询拨测数据。
    
    `index = ['default'], source = [‘http_dial_testing',‘tcp_dial_testing’,'icmp_dial_testing','websocket_dial_testing']`。


### 任务调用 {#trigger}



- 开启监控器、SLO 等定时检测任务，其中监控器突变检测、区间检测、离群检测、日志检测每次检测一次计为 5 次任务调用，其余检测类型计为 1 次任务调用。同时，若**检测区间**超出 15 分钟，超出的部分按照每 15 分钟叠加 1 次任务调用；

- 智能监控：主机、日志、应用智能检测每执行一次检测计为 10 次任务调用；用户访问智能检测每执行一次检测计为 100 次任务调用。

???+ abstract "计算示例"
     
    :material-numeric-1-circle-outline: 监控器调用次数：

    1. 正常情况下计算示例：假设执行一次【突变检测】，则计算为 5 次任务调用。
    2. 超检测区间情况下的计算示例：若检测区间为 30 分钟，则超出的部分按照每 15 分钟向上加 1。例如，执行一次【离群检测】，计算为 6 次任务调用。
    3. 检测类型算多次且超检测区间情况下的计算示例：执行两次【区间检测】，叠加检测区间为 60 分钟，则计算为 13 次任务调用（2 次检测 * 5 + 3 次超出检测区间）。

    :material-numeric-2-circle-outline: 智能监控调用次数计算示例：假设执行一次【主机智能监控】，则计算为 10 次任务调用。


- DataKit/OpenAPI 每次查询计为 1 次任务调用；
- 开启生成指标每次查询计为 1 次任务调用；                  
- 选择中心 Func 提供的高级函数每次查询计为 1 次任务调用。       



<div class="grid cards" markdown>

- [<font color="coral"> :fontawesome-solid-arrow-up-right-from-square: &nbsp; 任务调用次数计费明细</font>](../billing-method/index.md#trigger)


</div>

???+ abstract "计费项统计"

    每小时的时间间隔统计 1 小时内新增的任务调用次数。

    费用计算公式：天费用 = 实际计费数量/10000 * 对应单价


### 短信 {#sms}




- 告警策略配置短信通知发送



<div class="grid cards" markdown>

- [<font color="coral"> :fontawesome-solid-arrow-up-right-from-square: &nbsp; 短信发送次数计费明细</font>](../billing-method/index.md#sms)


</div>

???+ abstract "计费项统计"

    每小时的时间间隔统计 1 小时内新增的短信发送次数。

    费用计算公式：天费用 = 实际计费数量/10 * 单价


## 计费示例 {#example}

假设 A 公司使用<<< custom_key.brand_name >>>对公司的 IT 基础设施、应用系统等进行整体观测。

假设 A 公司总共有 10 台主机（每台主机默认日活跃时间线为 600），每天产生 6000 条时间线，200 万条日志数据，200 万个 Trace 数据，2 万个 PV 数据，以及 2 万次任务调度，使用的数据存储策略如下：

| 计费项       | 指标（时间线） | 日志 | 应用性能 Trace | 用户访问 PV |
| ------------ | -------------- | ---- | -------------- | ----------- |
| 数据存储策略 | 3 天           | 7 天 | 3 天           | 3 天        |

具体明细如下：

| 计费项   | 日计费数量 | 计费单价        | 计费逻辑                                                     | 日计费费用 |
| -------- | ---------- | --------------- | ------------------------------------------------------------ | ---------- |
| 时间线   | 6000 条     | 0.6 元/千条     | （实际计费数量/1000）* 单价<br>即 （6000 条/1000 条） * 0.6 元 | 3.6 元       |
| 日志     | 200 万条   | 1.2 元/百万条 | (实际统计数量/计费单元) * 单价<br>即 （2 百万/1 百万） * 1.2 元 | 2.4 元     |
| Trace    | 200 万个   | 2 元/百万个   | (实际统计数量/计费单元) * 单价<br/>即 （2 百万/1 百万） * 2 元 | 4 元       |
| PV       | 2 万个     | 0.7 元/万个   | (实际统计数量/计费单元) * 单价<br/>即 （2 万/1 万） * 0.7 元 | 1.4 元     |
| 任务调度 | 2 万次     | 1 元/万次     | (实际统计数量/计费单元) * 单价<br/>即 （2 万/1 万） * 1 元 | 2 元       |

**注意**：由于时间线为增量计费项，所以该公司产生时间线的数量变化会导致费用变化。

> 更多时间线数量测算，可参考 [时间线示例](#timeline)。


## 更多阅读

<font size=2>


<div class="grid cards" markdown>

- [<font color="coral"> :fontawesome-solid-arrow-right-long: &nbsp; <<< custom_key.brand_name >>>自研时序数据库</font>](./gauncedb.md)


</div>


<div class="grid cards" markdown>

- [<font color="coral"> :fontawesome-solid-arrow-right-long: &nbsp; 时间线计费项说明</font>](./timeline.md)


</div>

<div class="grid cards" markdown>

- [<font color="coral"> :fontawesome-solid-arrow-right-long: &nbsp; 时序数据库深入浅出之存储篇</font>](https://www.infoq.cn/article/storage-in-sequential-databases)


</div>


</font>


