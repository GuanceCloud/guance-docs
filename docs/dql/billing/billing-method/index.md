# 计费方式
---


## 概览

观测云支持按需购买，按量付费的计费方式。按照 DataKit 数量、时间线数量、日志类数据数量、备份日志数据数量、任务调度次数、用户访问 PV 数量、应用性能 Trace 数量、API 拨测次数、短信发送次数等多个维度进行价格统计。


## 计费价格

观测云计费项分成全量统计和增量统计，详情说明可参考[名词解释](#21f2fa80)。

观测云计费价格分成两种计算方式：一种是基于数据统计的基础计费模式，另外一种是基于数据统计及[数据存储策略](https://www.yuque.com/dataflux/doc/evmgge)的梯度计费模式。日志类数据、应用性能 Trace、用户访问 PV 这三个计费项采用梯度计费模式，其他计费项采用基础计费模式。

### 基础计费模式

观测云提供两种计费模式，可在费用中心切换选择。一种是统计“DataKit+时间线”数量的计费模式，另外一种是仅统计“时间线”数量的计费模式。其他计费项备份日志数据数量、API拨测次数、任务调度次数、短信发送次数为通用计费项。


#### 调整计费模式
观测云默认为“DataKit+时间线”的计费模式，若需要修改为“时间线”的计费模式需要联系观测云客户经理在观测云计费平台进行更改。


#### 统计“DataKit+时间线”数量
| **计费项** | **计费单元** | **商业版单价** |
| --- | --- | --- |
| Datakit 数量 | 每 1 台 | 3 元 |
| 时间线数量 | 每 300 条 | 3 元 |
| 备份日志数据数量 | 每千万条 | 2 元 |
| API 拨测次数 | 每 1 万次 | 1 元<br />注意：统计不包含自建节点产生的API拨测的数据 |
| 任务调度次数 | 每 1 万次 | 1 元 |
| 短信发送次数 | 每 10 次 | 1 元 |

时间线计算公式：

- 计费时间线数量 = 时间线数量 - DataKit数量 * 300
- 计费时间线数量账单 = （时间线数量 - DataKit数量 * 300）/ 300 * 3
- 若计算得出的计费时间线数量 <= 0，则按照 0 条计算。


#### 统计“时间线”数量
| **计费项** | **计费单元** | **商业版单价** |
| --- | --- | --- |
| 时间线数量 | 每 300 条 | 3 元 |
| 备份日志数据数量 | 每千万条 | 2 元 |
| API 拨测次数 | 每 1 万次 | 1 元<br />注意：统计不包含自建节点产生的API拨测的数据 |
| 任务调度次数 | 每 1 万次 | 1 元 |
| 短信发送次数 | 每 10 次 | 1 元 |

时间线计算公式：

- 计费时间线数量 = 时间线数量
- 计费时间线数量账单 = 时间线数量  / 300 * 3


### 梯度计费模式


#### 日志类数据

| **计费项** | **计费单元** | **商业版梯度价格** |  |  |
| --- | --- | --- | --- | --- |
| 数据存储策略 |  | 14 天 | 30 天 | 60 天 |
| 日志类数据数量 | 每百万条 | 1.5 元 | 2 元 | 2.5 元 |


#### 应用性能 Trace
| **计费项** | **计费单元** | **商业版梯度价格** |  |
| --- | --- | --- | --- |
| 数据存储策略 |  | 7 天 | 14 天 |
| 应用性能 Trace 数量 | 每百万个 | 3 元 | 6 元 |


#### 用户访问 PV
| **计费项** | **计费单元** | **商业版梯度价格** |  |
| --- | --- | --- | --- |
| 数据存储策略 |  | 7 天 | 14 天 |
| 用户访问 PV 数量 | 每万个 | 1 元 | 2 元 |


### 计费公式

- 按天出账
- 计费项账单 = 计费单元数量 * 单价
- 计费项单元数量 = 实际统计数量 / 计费单元（注意：此处结果值不做进位处理，保留数值小数点后两位）


### 计费示例

假设A公司使用观测云对公司的 IT 基础设施、应用系统等进行整体观测，统计7天的费用示例。


#### 1.基础计费

基础计费项包括全量计费项和增量计费项，时间线和备份日志数据数量为全量计费项，DataKit数量、API拨测次数、任务调度次数、短信发送次数为增量计费项。下面将以两种不同基础计费模式进行示例，包括DataKit、时间线和任务调度计费项的费用统计。

**1）按照“DataKit+时间线”的计费模式，7天的总费用：DataKit+时间线+任务调度的费用总计=420+146+9=575元**

- 每 1 台 DataKit 单价3元
| DataKit | Day1 | Day2 | Day3 | Day4 | Day5 | Day6 | Day7 |
| --- | --- | --- | --- | --- | --- | --- | --- |
| 单日用量 | 10 | 10 | 15 | 15 | 30 | 30 | 30 |
| 增量计费 | 10 | 10 | 15 | 15 | 30 | 30 | 30 |
| 总计(元) | 30 | 30 | 45 | 45 | 90 | 90 | 90 |

DataKit 7天的总费用=30+30+45+45+90+90+90=420元

- 每300条时间线单价3元，计费时间线数量账单 = （时间线数量 - DataKit数量 * 300）/ 300 * 3，若计算得出的计费时间线数量 <= 0，则按照 0 条计算。
| 时间线 | Day1 | Day2 | Day3 | Day4 | Day5 | Day6 | Day7 |
| --- | --- | --- | --- | --- | --- | --- | --- |
| 单日用量 | 500 | 500 | 500 | 500 | 800 | 800 | 20000 |
| 全量计费 | 500 | 1000 | 1500 | 2000 | 2800 | 3600 | 23600 |
| 总计(元) | 0 | 0 | 0 | 0 | 0 | 0 | (23600-30*300)/300*3=146 |

时间线 7天的总费用=51.6元

- 每1万次任务调度单价1元
| 任务调度 | Day1 | Day2 | Day3 | Day4 | Day5 | Day6 | Day7 |
| --- | --- | --- | --- | --- | --- | --- | --- |
| 单日用量 | 1万 | 1万 | 1万 | 1万 | 1.5万 | 1.5万 | 2万 |
| 增量计费 | 1万 | 1万 | 1万 | 1万 | 1.5万 | 1.5万 | 2万 |
| 总计(元) | 1 | 1 | 1 | 1 | 1.5/1*1=1.5 | 1.5/1*1=1.5 | 2/1*1=2 |

任务调度 7天的总费用=1+1+1+1+1.5+1.5+2=9元

**2）按照“时间线”的计费模式，DataKit数量不收费，7天的总费用：时间线+任务调度的费用总计=350+9=359元**

- 每300条时间线单价3元，计费时间线数量账单 = 时间线数量 / 300 * 3
| 时间线 | Day1 | Day2 | Day3 | Day4 | Day5 | Day6 | Day7 |
| --- | --- | --- | --- | --- | --- | --- | --- |
| 单日用量 | 500 | 500 | 500 | 500 | 800 | 800 | 20000 |
| 全量计费 | 500 | 1000 | 1500 | 2000 | 2800 | 3600 | 23600 |
| 总计(元) | 500/300*3=5 | 1000/300*3=10 | 15 | 20 | 28 | 36 | 236 |

时间线 7天的总费用=5+10+15+20+28+36+236=350元

2）增量计费项统计以任务调度举例，每1万次单价1元

| 任务调度 | Day1 | Day2 | Day3 | Day4 | Day5 | Day6 | Day7 |
| --- | --- | --- | --- | --- | --- | --- | --- |
| 单日用量 | 1万 | 1万 | 1万 | 1万 | 1.5万 | 1.5万 | 2万 |
| 增量计费 | 1万 | 1万 | 1万 | 1万 | 1.5万 | 1.5万 | 2万 |
| 总计(元) | 1 | 1 | 1 | 1 | 1.5/1*1=1.5 | 1.5/1*1=1.5 | 2/1*1=2 |

任务调度 7天的总费用=1+1+1+1+1.5+1.5+2=9元


#### 2.梯度计费

梯度计费项都是增量计费，下面以日志类数据为例：<br />1）数据存储策略为14天，每百万条梯度价格1.5元

| 任务调度 | Day1 | Day2 | Day3 | Day4 | Day5 | Day6 | Day7 |
| --- | --- | --- | --- | --- | --- | --- | --- |
| 单日用量 | 1百万 | 1百万 | 1百万 | 1百万 | 1.5百万 | 1.5百万 | 2百万 |
| 增量计费 | 1百万 | 1百万 | 1百万 | 1百万 | 1.5百万 | 1.5百万 | 2百万 |
| 总计(元) | 1.5 | 1.5 | 1.5 | 1.5 | 1.5/1*1.5=2.25 | 1.5/1*1.5=2.25 | 2/1*1.5=3 |

7天的总费用=1.5+1.5+1.5+1.5+2.25+2.25+3=13.5元

2）数据存储策略为30天，每百万条梯度价格2元

| 任务调度 | Day1 | Day2 | Day3 | Day4 | Day5 | Day6 | Day7 |
| --- | --- | --- | --- | --- | --- | --- | --- |
| 单日用量 | 1百万 | 1百万 | 1百万 | 1百万 | 1.5百万 | 1.5百万 | 2百万 |
| 增量计费 | 1百万 | 1百万 | 1百万 | 1百万 | 1.5百万 | 1.5百万 | 2百万 |
| 总计(元) | 2 | 2 | 2 | 2 | 1.5/1*2=3 | 1.5/1*2=3 | 2/1*2=4 |

7天的总费用=2+2+2+2+3+3+4=18元

3）数据存储策略为60天，每百万条梯度价格2.5元

| 任务调度 | Day1 | Day2 | Day3 | Day4 | Day5 | Day6 | Day7 |
| --- | --- | --- | --- | --- | --- | --- | --- |
| 单日用量 | 1百万 | 1百万 | 1百万 | 1百万 | 1.5百万 | 1.5百万 | 2百万 |
| 增量计费 | 1百万 | 1百万 | 1百万 | 1百万 | 1.5百万 | 1.5百万 | 2百万 |
| 总计(元) | 2.5 | 2.5 | 2.5 | 2.5 | 1.5/1*2.5=3.75 | 1.5/1*2.5=3.75 | 2/1*2.5=5 |

7天的总费用=2.5+2.5+2.5+2.5+3.75+3.75+5=22.5元


## 名词解释	


### 全量统计

当前工作空间下，统计数据保存策略范围内所有的数据 / 数量。时间线、备份日志数据这两个计费项按照全量计费。


### 增量统计

当前工作空间下，统计一天内产生的数据 / 数量。DataKit 、日志类数据、应用性能 Trace、用户访问 PV 、API 拨测、任务调度、短信按照增量计费。


### DataKit 数量

当前工作空间下，一天内有数据上报的datakit的数量。由于目前datakit数量是按小时做数量统计，所以当天datakit的实际数量取24个点里面的最大值。

注意：主机安装 DataKit 开启采集数据后，变更主机名`host_name`会默认新增加一台主机，原主机名会继续在「基础设施」-「主机」列表中显示，一个小时后不会继续上报数据，直到24小时未上报数据后从列表中移除。由于 DataKit 数量是在24小时内取最大值，故在这个计费周期内会被统计为2台主机进行收费。


### 时间线数量

当前工作空间，上报的指标数据中基于标签可以组合而成的所有组合数量。

在 “观测云”中时间线是由指标、标签（字段）、数据存储时长组合而成的，“指标”和“标签（字段）的组合”是数据存储的主键。例如：如果有 `天气` 这个指标，数据存储时长一样。

```
2021-04-15T00:00:00Z 天气,国家=中国,地区=上海 温度=23.1
2021-04-15T00:00:00Z 天气,国家=中国,地区=杭州 温度=22.2
2021-04-15T00:00:00Z 天气,国家=美国,地区=纽约 温度=23.3
2021-04-15T00:00:00Z 天气,国家=美国,地区=洛杉矶 温度=21.2
2021-04-15T00:00:10Z 天气,国家=中国,地区=上海 温度=23.3
2021-04-15T00:00:10Z 天气,国家=中国,地区=杭州 温度=20.2
2021-04-15T00:00:10Z 天气,国家=美国,地区=纽约 温度=24.3
2021-04-15T00:00:10Z 天气,国家=美国,地区=洛杉矶 温度=25.2
```

如上所述，包含 1 个指标：【天气】；4 个标签组合：【中国 上海】【中国 杭州】【美国 纽约】【美国 洛杉矶】；则当前指标 `天气` 的时间线数量为： `1(指标个数) x 4(标签的组合个数) = 4 个时间线`

**注意：数据存储时长是采集上来的数据在平台中保存的时间，超过存储时长的数据将会自动删除。**


### 日志类数据数量

当前空间下，日志类数据的统计数量，日志类数据数量包括日志、云拨测（用户自建节点产生的云拨测数据）、安全巡检和事件的数据数量总和，默认计费单位为“百万条”。


### 备份日志数据数量

当前空间下，备份日志数据的统计数量，默认计费单位为“百万条”。


### 应用性能 Trace 数量

当前空间下，统计应用性能监测 trace_id 的数量，默认计费单位为“百万个”。


### 用户访问 PV 数量

当前空间下，统计一天内所有页面浏览产生的 PV 数量，默认计费单位为“千个”。


### API 拨测次数

当前空间下，统计一天内所有的 API 拨测产生的任务调用次数，默认计费单位为“万次”。


### 任务调度次数

当前空间下，统计一天内所有的 Func 平台调用的次数，涉及到任务的调用即会进行次数统计，如异常检测的规则数量、生成指标的规则数量等，默认计费单位为“万次”。


### 短信发送次数

当前空间下，统计一天内所有发送出去的短信的次数，默认计费单位为“次”。

## 价格计算

用于计算当前工作空间各个项目的使用情况。用户可计算一天、一个月和一年的使用情况。点击 [价格计算器 ](https://www.dataflux.cn/billing)可自动计算价格。


## 数据存储策略

数据存储时长会影响价格统计，你可以调整当前工作空间指标数据、日志数据、事件数据、安全巡检数据、应用性能数据、用户访问数据的数据存储策略，仅支持工作空间拥有者进入「管理」-「基本设置」，变更数据存储策略。更多说明可参考文档 [数据存储策略](https://www.yuque.com/dataflux/doc/evmgge) 。


---

观测云是一款面向开发、运维、测试及业务团队的实时数据监测平台，能够统一满足云、云原生、应用及业务上的监测需求，快速实现系统可观测。**立即前往观测云，开启一站式可观测之旅：**[www.guance.com](https://www.guance.com)<br />![](../img/logo_2.png)
