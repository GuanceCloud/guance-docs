# 更新日志



---



## 2022 年 12 月 29 日

### 新增巡检

* **云账户实例维度账单巡检**：云账户实例维度账单巡检帮助用户管理云服务实例级别的异常费用预警、预测费用情况并为用户提供高增长、高消耗的实例提示及账单可视化能力，支持多维度可视化云服务资源的消费情况。
* **阿里云抢占式实例存活巡检**：由于抢占式实例的市场价格会随供需变化而浮动，需要在创建抢占式实例时指定出价模式，当指定实例规格的实时市场价格低于出价且库存充足时，才能成功创建抢占式实例。所以说对于云资产的抢占实例巡检就显得尤为重要，通过巡检当发现抢占式实例即将被释放时，会提示当前规格的抢占实例的所有可用区的最新价格以及改抢占式实例的历史价格并给出恰当的处理意见。



## 2022 年 12 月 1 日

### 新增巡检

* **Kubernetes Pod 异常重启巡检**：Kubernetes 帮助用户自动调度和扩展容器化应用程序，但现代 Kubernetes 环境正变得越来越复杂，当平台和应用工程师需要调查动态、容器化环境中的事件时，寻找最有意义的信号可能涉及许多试错步骤。通过智能巡检可以根据当前的搜索上下文过滤异常，从而加快事件调查、减轻工程师的压力、减少平均修复时间并改善最终用户体验。
* **MySQL 性能巡检**：对于日益复杂的应用架构，当前的趋势是越来越多的客户采用免运维的云数据库，所以巡检 MySQL的性能巡检是重中之重，定期会对 MySQL 进行智能巡检，通过发现 MySQL 的性能问题来进行异常告警。
* **服务端应用错误巡检**：当服务端出现运行错误时，我们需要提早发现及时预警来让开发运维进行排错，及时确认错误是否对应用有潜在影响。服务端应用错误巡检事件上报的内容是提醒开发运维在过去一小时里应用出现了新的错误并定位到具体的出错的地方将关联的诊断线索一起提供给用户。
* **内存泄漏巡检**：基于内存异常分析检测器，定期对主机进行智能巡检，通过出现内存异常的主机来进行根因分析，确定对应异常时间点的进程和 pod 信息，分析当前工作空间主机是否存在内存泄漏问题。
* **磁盘使用率巡检**：基于磁盘异常分析检测器，定期对主机磁盘进行智能巡检，通过出现磁盘异常的主机来进行根因分析，确定对应异常时间点的磁盘挂载点和磁盘信息，分析当前工作空间主机是否存在磁盘使用率问题。
* **应用性能巡检**：基于APM异常根因分析检测器，选择要检测的 `service` 、 `resource` 、 `project` 、 `env` 信息，定期对应用性能进行智能巡检，通过应用程序服务指标异常来自动分析该服务的上下游信息，为该应用程序确认根因异常问题。

### 功能优化

* **前端应用日志错误巡检**：前端错误日志巡检事件报告新增展示前端用户影响。



## 2022 年 11 月 3 日

### 新增巡检

* **云账户账单巡检**：云账户账单巡检帮助用户管理云服务的预算预警、异常费用预警、预测费用情况并为用户提供可视化能力，支持多维度可视化云服务资源的消费情况。
* **前端应用日志错误巡检**：前端错误日志巡检 会帮助发现前端应用过去一小时内新出现的错误消息（聚类之后的Error Message），帮助开发和运维及时修复代码，避免随着时间的积累对客户体验产生持续性伤害。
* **阿里云资产巡检**：为观测云提供额外的数据接入能力，方便用户对云厂商的产品性能状态有更多的了解。

### 问题修复

* **磁盘使用率巡检**：修复事件折线图显示异常问题。