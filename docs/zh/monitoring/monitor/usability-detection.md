# 可用性数据检测
---

用于监控工作空间内的可用性监测数据。您可以设定一个时间段内拨测任务产生的指定数据量的阈值范围，一旦数据量达到这些阈值，系统就会触发告警。此外，您还可以自定义告警等级，使得在指定数据量达到不同的阈值范围时，能够触发相应等级的告警事件。


## 应用场景

支持监控基于 `HTTP`、`TCP`、`ICMP`、`WEBSOCKET`、多步拨测产生的数据量。例如监控生产环境部署 URL 不可用。

## 检测配置

![](../img/5.monitor_5.png)

### 检测频率

即检测规则的执行频率；默认选中 5 分钟。

### 检测区间

即检测指标查询的时间范围。受检测频率影响，可选检测区间会有不同。

| 检测频率 | 检测区间（下拉可选项） |
| --- | --- |
| 1m | 1m/5m/15m/30m/1h/3h |
| 5m | 5m/15m/30m/1h/3h |
| 15m | 15m/30m/1h/3h/6h |
| 30m | 30m/1h/3h/6h |
| 1h | 1h/3h/6h/12h/24h |
| 6h | 6h/12h/24h |
| 12h | 12h/24h |
| 24h | 24h |

3）**检测指标**：设置检测数据的指标，支持设置当前工作空间内全部/单个拨测任务产生的指定数据的数据量为检测指标。

:material-numeric-1-circle-outline: 拨测指标：

| 字段 | 描述 |
| --- | --- |
| 拨测类型 | 包含 `HTTP`、`TCP`、`ICMP`、`WEBSOCKET` 四种拨测类型。   |
| 拨测地址 | 支持对当前工作空间内可用性监测的全部或单个拨测任务进行监控。 |
| 指标 | 支持基于指标维度进行检测，包含平均响应时间、P50 响应时间、P75 响应时间、P90 响应时间、P99 响应时间、可用率、错误请求数、请求数和可用率。 |
| 维度 | 配置数据里对应的字符串类型（`keyword`）字段都可以作为检测维度进行选择，目前检测维度最多支持选择三个字段。通过多个检测维度的字段组合，可以确定一个确定的检测对象，<<< custom_key.brand_name >>>会判断某个检测对象对应的统计指标是否满足触发条件的阈值，若满足条件则产生事件。<br />*例如：选择检测维度 `host` 与 `host_ip`，则检测对象可以为 `{host: host1, host_ip: 127.0.0.1}`。* |
| 筛选 | 基于指标标签对检测指标的数据进行筛选，从而限定检测的数据范围。可添加一个或多个标签筛选、模糊匹配和模糊不匹配的筛选条件。 |

:material-numeric-2-circle-outline: 数量统计

您可基于四种不同的拨测类型，通过关键词搜索或标签过滤的方式，对拨测任务进行查询统计。

除简单查询外，也可使用表达式查询方式。

### 触发条件

设置告警级别的触发条件：您可任意配置紧急、重要、警告、正常的其中一种触发条件。

配置触发条件及严重程度，当查询结果为多个值时，任一值满足触发条件则产生事件。

> 更多详情，可参考 [事件等级说明](event-level-description.md)。   



若**开启连续触发判断**，可配置连续多次判断触发条件生效后，再次触发生成事件。最大上限 10 次。




???+ abstract "告警级别"

	1. **告警级别紧急（红色）、重要（橙色）、警告（黄色）**：基于配置条件判断运算符。
  

	2. **告警级别正常（绿色）**：基于配置检测次数，说明如下：

	- 每执行一次检测任务即为 1 次检测，如【检测频率 = 5 分钟】，则 1 次检测= 5 分钟；    
	- 可以自定义检测次数，如【检测频率 = 5 分钟】，则 3 次检测 = 15 分钟。   

	| 级别 | 描述 |
	| --- | --- |
	| 正常 | 检测规则生效后，产生紧急、重要、警告异常事件后，在配置的自定义检测次数内，数据检测结果恢复正常，则产生恢复告警事件。<br/> :warning: 恢复告警事件不受[告警沉默](../alert-setting.md)限制。若未设置恢复告警事件检测次数，则告警事件不会恢复，且一直会出现在[**事件 > 未恢复事件列表**](../../events/event-explorer/unrecovered-events.md)中。|
	

### 数据断档

针对数据断档状态，可配置七种策略。

1. 联动检测区间时间范围，判断检测指标最近分钟数的查询结果，**不触发事件**；

2. 联动检测区间时间范围，判断检测指标最近分钟数的查询结果，**查询结果视为 0**；此时查询结果将重新与上方**触发条件**中配置的阈值做比较，从而判断是否触发异常事件。

3. 自定义填充检测区间值，**触发数据断档事件、触发紧急事件、触发重要事件、触发警告事件及触发恢复事件**；选择该类配置策略，自定义数据断档时间配置建议 **>= 检测区间时间间隔**，若配置时间 <= 检测区间时间间隔，可能存在同时满足数据断档和异常情况，此情况下仅会应用数据断档处理结果。


### 信息生成

开启此选项后，将未匹配到以上触发条件的检测结果生成 “信息” 事件写入。


**注意**：若同时配置触发条件、数据断档、信息生成时，按照如下优先级判断触发：数据断档 > 触发条件 > 信息事件生成。

