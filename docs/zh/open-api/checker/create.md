# 创建一个监控器

---

<br />**POST /api/v1/checker/add**

## 概述
创建一个监控器




## Body 请求参数

| 参数名        | 类型     | 必选   | 说明              |
|:-----------|:-------|:-----|:----------------|
| type | string |  | 监控器类型, 默认trigger, trigger:普通监控器, (outer_event_checker:普通监控器中的外部事件监控器), smartMonitor 为智能监控<br>允许为空: False <br>例子: smartMonitor <br> |
| extend | json |  | 额外信息<br>允许为空: True <br> |
| monitorUUID | string |  | 分组id<br>允许为空: True <br>允许为空字符串: True <br> |
| alertPolicyUUIDs | array |  | 告警策略UUID<br>允许为空: False <br> |
| dashboardUUID | string |  | 关联仪表板id<br>允许为空: False <br> |
| tags | array |  | 用于筛选的标签名称<br>允许为空: False <br>例子: ['xx', 'yy'] <br> |
| secret | string |  | Webhook地址的中段唯一标识secret(一般取随机uuid, 确保工作空间内唯一)<br>允许为空: False <br>例子: secret_xxxxx <br> |
| jsonScript | json |  | 规则配置<br>允许为空: False <br> |
| jsonScript.type | string | Y | 检查方法类型<br>例子: simpleCheck <br>允许为空: False <br> |
| jsonScript.windowDql | string |  | window dql<br>允许为空: False <br> |
| jsonScript.title | string | Y | 生成event的标题<br>例子: 监视器: `{{monitor_name}}` 检查器:`{{monitor_checker_name}}` 触发值:`{{M1}}` <br>允许为空: False <br>允许为空字符串: True <br>最大长度: 256 <br> |
| jsonScript.message | string |  | event内容<br>例子: status: {{status}}, title:`{{title}}` <br>允许为空: False <br>允许为空字符串: True <br> |
| jsonScript.recoverTitle | string |  | 输出恢复事件标题模板<br>例子: 监视器: `{{monitor_name}}` 检查器:`{{monitor_checker_name}}` 触发值:`{{M1}}` <br>允许为空: False <br>允许为空字符串: True <br> |
| jsonScript.recoverMessage | string |  | 输出恢复事件信息模板<br>例子: status: {{status}}, title:`{{title}}` <br>允许为空: False <br>允许为空字符串: True <br> |
| jsonScript.noDataTitle | string |  | 输出无数据事件标题模板<br>例子: 监视器: `{{monitor_name}}` 检查器:`{{monitor_checker_name}}` 触发值:`{{M1}}` <br>允许为空: False <br>允许为空字符串: True <br> |
| jsonScript.noDataMessage | string |  | 输出无数据事件信息模板<br>例子: status: {{status}}, title:`{{title}}` <br>允许为空: False <br>允许为空字符串: True <br> |
| jsonScript.noDataRecoverTitle | string |  | 输出无数据恢复上传事件标题模板<br>例子: 监视器: `{{monitor_name}}` 检查器:`{{monitor_checker_name}}` 触发值:`{{M1}}` <br>允许为空: False <br>允许为空字符串: True <br> |
| jsonScript.noDataRecoverMessage | string |  | 输出无数据恢复上传事件信息模板<br>例子: status: {{status}}, title:`{{title}}` <br>允许为空: False <br>允许为空字符串: True <br> |
| jsonScript.every | string |  | 检查频率<br>例子: 1m <br>允许为空: False <br> |
| jsonScript.customCrontab | string |  | 自定义检测频率<br>例子: 0 */12 * * * <br>允许为空: False <br> |
| jsonScript.interval | integer |  | 查询区间，即一次查询的时间范围时差<br>例子: 60 <br>允许为空: False <br> |
| jsonScript.range | integer |  | 针对高级检测,突变检测的range参数,单位s<br>例子: 3600 <br>允许为空: False <br> |
| jsonScript.range_2 | integer |  | 针对高级检测,突变检测的range_2参数,单位s,特殊说明 (-1代表环比,  0代表使用 periodBefore字段)<br>例子: 600 <br>允许为空: False <br> |
| jsonScript.periodBefore | integer |  | 针对高级检测,突变检测的(昨日/一小时前)参数,单位s<br>例子: 600 <br>允许为空: False <br> |
| jsonScript.recoverNeedPeriodCount | integer |  | 指定异常在几个检查周期之后生成恢复事件,如果 检测频率为 自定义customCrontab, 该字段表示为时间长度, 单位s, 否则,表示几个检测频率<br>例子: 60 <br>允许为空: False <br> |
| jsonScript.noDataInterval | integer |  | 多长时间内无数据则产生无数据事件<br>例子: 60 <br>允许为空: False <br> |
| jsonScript.noDataAction | string |  | 无数据处理操作<br>允许为空: False <br>可选值: ['none', 'checkAs0', 'noDataEvent', 'criticalEvent', 'errorEvent', 'warningEvent', 'okEvent', 'noData', 'recover'] <br> |
| jsonScript.checkFuncs | array |  | 检查函数信息列表<br>例子: [{'funcId': 'xxx', 'kwargs': {}}] <br>允许为空: False <br> |
| jsonScript.groupBy | array |  | 触发维度<br>例子: ['性别'] <br>允许为空: False <br> |
| jsonScript.targets | array |  | 检查目标<br>例子: [{'dql': 'M::`士兵信息`:(AVG(`潜力值`))  [::auto] by `性别`', 'alias': 'M1'}] <br>允许为空: False <br> |
| jsonScript.checkerOpt | json |  | 检查条件设置<br>允许为空: False <br> |
| jsonScript.checkerOpt.rules | array |  | 触发条件列表<br>例子: [{'status': 'warning', 'conditions': [{'operands': [60], 'operator': '>', 'alias': 'M1'}], 'conditionLogic': 'and', 'matchTimes': 10}] <br>允许为空: False <br> |
| jsonScript.checkerOpt.openMatchTimes | boolean |  | 开启连续触发判断, 默认 关闭false<br>例子: True <br> |
| jsonScript.checkerOpt.infoEvent | boolean |  | 是否在持续正常时产生info事,默认false<br>例子: True <br> |
| jsonScript.checkerOpt.diffMode | string |  | 高级检测中突变检测的,差值模式,枚举值, value, percent<br>例子: value <br>可选值: ['value', 'percent'] <br> |
| jsonScript.checkerOpt.direction | string |  | 高级检测中突变检测,区间检测的触发条件方向<br>例子: up <br>可选值: ['up', 'down', 'both'] <br> |
| jsonScript.checkerOpt.eps | float |  | 距离参数，取值范围：0 ~ 3.0<br>例子: 0.5 <br> |
| jsonScript.checkerOpt.threshold | json |  | 突变检测的触发前提条件设置<br>允许为空: False <br> |
| jsonScript.checkerOpt.threshold.status | boolean | Y | 突变检测, 触发前提条件是否开启,<br>例子: True <br> |
| jsonScript.checkerOpt.threshold.operator | string | Y | 突变检测, 触发前提条件操作符<br>例子:  <br> |
| jsonScript.checkerOpt.threshold.value | float | Y | 突变检测, 触发前提条件检测值<br>例子: 90 <br>允许为空: True <br> |
| jsonScript.checkerOpt.combineExpr | string |  | 组合监控, 组合方式<br>例子: A && B <br>允许为空字符串: False <br> |
| jsonScript.checkerOpt.ignoreNodata | boolean |  | 组合监控, 是否忽略无数据结果（true 表示需要忽略）,<br>例子: True <br> |
| jsonScript.checkerOpt.confidenceInterval | integer |  | 区间检测V2新增参数, 置信区间范围取值1-100,<br>例子: 10 <br> |
| jsonScript.channels | array |  | 频道UUID列表<br>例子: ['名称1', '名称2'] <br>允许为空: False <br> |
| jsonScript.atAccounts | array |  | 正常检测下被@的账号UUID列表<br>例子: ['xx1', 'xx2'] <br>允许为空: False <br> |
| jsonScript.atNoDataAccounts | array |  | 无数据情况下被@的账号UUID列表<br>例子: ['xx1', 'xx2'] <br>允许为空: False <br> |
| jsonScript.subUri | string |  | 表示Webhook地址的地址后缀(根据用户业务侧需求可选设置，无特殊限制)<br>例子: datakit/push <br>允许为空: False <br> |
| jsonScript.disableCheckEndTime | boolean |  | 是否禁用结束时间限制, https://confluence.jiagouyun.com/pages/viewpage.action?pageId=177405958<br>例子: True <br>允许为空: False <br> |

## 参数补充说明


*数据说明.*

*jsonScript 参数说明*

**1. 检查类型`jsonScript.type` 说明**

|key|说明|
|---|----|
|simpleCheck| 阈值检测|
|seniorMutationsCheck| 突变检测|
|seniorRangeCheck| 区间检测|
|seniorRangeV2Check| 区间检测V2|
|outlierCheck| 离群检测|
|loggingCheck| 日志检测|
|processCheck| 进程异常检测|
|objectSurvivalCheck| 基础设施存活检测|
|objectSurvivalV2Check| 基础设施存活检测V2, 只支持doris空间|
|apmCheck| 应用性能指标检测|
|rumCheck| 用户访问指标检测|
|securityCheck| 安全巡检异常检测|
|cloudDialCheck| 可用性数据检测|
|networkCheck| 网络数据检测|
|OuterEventChecker| 外部事件检测|
|smartHostCheck| 智能监控, 主机智能检测|
|smartLogCheck| 智能监控, 日志智能检测|
|smartApmCheck| 智能监控, 应用智能检测|
|smartRumCheck| 智能监控, 用户访问智能检测|
|combinedCheck| 组合监控|

**2. 已下线的检查类型`jsonScript.type` 说明**

|key|说明|
|---|----|
|seniorCheck| 高级检查,已下线|
|mutationsCheck| 突变检查,已下线, 更新为 seniorMutationsCheck|
|waterLevelCheck| 水位检查,已下线|
|rangeCheck| 区间检查,已下线, 更新为 seniorRangeCheck|


**3. **触发条件比较操作符说明(`checkerOpt`.`rules` 中的参数说明)**

|  参数名                |   type  | 必选  |          说明          |
|-----------------------|----------|----|------------------------|
|conditions             |Array[Dict]|必须| 条件|
|conditions[#].alias    |String     |必须| 检测对象别名，即上述 targets[#].alias|
|conditions[#].operator |String     |必须| 操作符。 = , > , < 等|
|conditions[#].operands |Array[Any] |必须| 操作数数组。（ between , in 等操作符需要多个操作数）|
|conditionLogic         |string     |必须| 条件中间逻辑。 and , or|
|status                 |string     |必须| 满⾜条件时，输出 event 的 status 。取值与 event 的 status 相同|
|direction    |string     | | 【区间/水位/突变参数】检测方向，取值："up", "down", "both"|
|periodNum    |integer     | | 【区间/水位/突变参数】只检测最近的数据点数量|
|checkPercent    |integer     | |【区间参数】 异常百分比阈值，取值：1 ~ 100|
|checkCount    |integer     | | 【水位/突变参数】连续异常点数量|
|strength    |integer     | | 【水位/突变参数】检测强度，取值：1=弱，2=中，3=强|
|matchTimes    |integer     | | 开启连续触发配置的(checkerOpt.openMatchTimes) 连续触发配置的次数 [1,10]|

--------------

**4.简单/日志/水位/突变/区间检查 `jsonScript.type` in （`simpleCheck`, `loggingCheck`, `waterLevelCheck`, `mutationsCheck`, `rangeCheck`, `securityCheck`）参数信息**

|  参数名        |   type  | 必选  |          说明          |
|---------------|----------|----|------------------------|
| title         |  string  |  Y | 输出故障事件标题模板      |
| message       |  string  |  N | 输出故障事件信息模板      |
| recoverTitle  |  string  |  N | 输出恢复事件标题模板      |
| recoverMessage |  string  |  N | 输出恢复事件信息模板     |
| noDataTitle   |  string  |  N | 输出无数据事件标题模板     |
| noDataMessage |  string  |  N | 输出无数据事件信息模板     |
| noDataRecoverTitle |  string  |  N | 输出无数据恢复上传事件标题模板 |
| noDataRecoverMessage |  string  |  N | 输出无数据恢复上传事件信息模板 |
| name          |  string  |  Y | 规则名     |
| type          |  string  |  Y | 规则类型   |
| every         |  string  |  Y | 检查频率, 单位是 (1m/1h/1d)  |
| customCrontab         |  string  |  N | 自定义检查频率的crontab  |
| interval      |  integer |  Y | 数据时间范围的时差，即time_range的时差, 单位：秒  |
| recoverNeedPeriodCount |  integer |  Y | 超过指定检查周期次数之后生成恢复事件,如果 检测频率为 自定义customCrontab, 该字段表示为时间长度, 单位s, 否则,表示几个检测频率 |
| noDataInterval|  integer | N |  多长时间内无数据则产生无数据事件
| noDataAction|  string | N |  无数据处理操作
| targets       |  array   |  Y | 简单检查中的检查目标列表|
| targets[*].dql|  string  |  Y | DQL查询语句|
| targets[*].alias| string |  Y | 别名|
| targets[*].monitorCheckerId| string |  Y | 组合监控, 监控器 ID（rul_xxxxx）|
| checkerOpt    |  json    |  N | 检查配置,可选 |
| checkerOpt.rules|  array |  Y | 检查规则列表 |
| checkerOpt.openMatchTimes|  boolean |  N | 是否开启连续触发判断, 默认 关闭false |


--------------

**5.`jsonScript.noDataAction`参数信息 **

|  参数名        |   说明  |
|---------------|----------|
| none          |  无动作（即与[关闭无数据相关处理]相同）  |
| checkAs0      |  查询结果视为0                       |
| noDataEvent   |  触发恢复事件(noData)                |
| criticalEvent |  触发紧急事件(crtical)               |
| errorEvent    |  触发重要事件(error)                 |
| warningEvent  |  触发警告事件(warning)               |
| okEvent       |  触发恢复事件(ok)                    |
| noData        |  产生无数据事件, 该参数于 2024-04-10 日下架,  其功能逻辑等同于`noDataEvent`，可直接替换为`noDataEvent`  |
| recover       |  触发恢复事件, 该参数于 2024-04-10 日下架,  其功能逻辑等同于`okEvent`，可直接替换为`okEvent`  |

--------------

**6. 高级检查 `jsonScript.type` in （`seniorCheck`）参数信息**

|  参数名        |   type  | 必选  |          说明          |
|---------------|----------|----|------------------------|
| title         |  string  |  Y | 输出故障事件标题模板      |
| message       |  string  |  N | 输出故障事件信息模板      |
| recoverTitle  |  string  |  N | 输出恢复事件标题模板      |
| recoverMessage |  string  |  N | 输出恢复事件信息模板     |
| noDataTitle   |  string  |  N | 输出无数据事件标题模板     |
| noDataMessage |  string  |  N | 输出无数据事件信息模板     |
| noDataRecoverTitle |  string  |  N | 输出无数据恢复上传事件标题模板 |
| noDataRecoverMessage |  string  |  N | 输出无数据恢复上传事件信息模板 |
| type          |  string  |  Y | 规则类型  |
| every         |  string  |  Y | 检查频率, 单位是 (1m/1h/1d)  |
| customCrontab         |  string  |  N |自定义检查频率的crontab  |
| checkFuncs    |  array   |  Y | 高级检查函数列表, 注意它有且仅有一个元素|
| checkFuncs[#].funcId |  string    |  Y | 函数ID, 可通过`【外部函数】列出`接口获取 funcTags=`monitorType|custom`的自定义检查函数列表|
| checkFuncs[#].kwargs |  json    |  N | 该高级函数所需的参数数据 |

--------------

**7. 突变检查 seniorMutationsCheck 参数说明**

|  参数名        |   type  | 必选  |          说明          |
|---------------|----------|----|------------------------|
| jsonScript.range          |  integer  |  N | 检测指标的 Result 时间段1                  |
| jsonScript.range_2         |  integer  |  N | 检测指标的 Result 时间段2, 特殊说明: (-1代表环比,  0代表使用 periodBefore字段)           |
| jsonScript.periodBefore         |  integer  |  N | jsonScript.range_2 为 0 时, 该字段表示(昨日/一小时前)      |
| jsonScript.checkerOpt.diffMode        |  string  |  N | 突变检测的,差值模式( 差值: value, 差值百分比: percent  |
| jsonScript.checkerOpt.threshold.status        |  boolean  |  N | 突变检测的触发前提条件设置, 开启/关闭  |
| jsonScript.checkerOpt.threshold.operator        |  string  |  N | 突变检测的触发前提条件设置, 操作符  |
| jsonScript.checkerOpt.threshold.value        |  float  |  N | 突变检测的触发前提条件设置, 检测值 |

--------------

**8. 组合监控 相关字段 参数说明**

|  参数名        |   type  | 必选  |          说明          |
|---------------|----------|----|------------------------|
| jsonScript.checkerOpt.combineExpr        |  string  |  Y | 组合方式，如：A && B  |
| jsonScript.checkerOpt.ignoreNodata        |  boolean  |  N | 是否忽略无数据结果（true 表示需要忽略）  |

--------------

**9. 外部事件检测`jsonScript.type` in （`OuterEventChecker`） 相关字段 参数说明**

|  参数名        |   type  | 必选  |          说明          |
|---------------|----------|----|------------------------|
| secret        |  string  |  Y | 一个任意长度的随机字符串,工作空间内唯一, 用于识别事件所属监控器。  |
| jsonScript.subUri        |  string  |   | 表示Webhook地址的地址后缀(根据用户业务侧需求可选设置，无特殊限制)  |

--------------

**10. 字段 disableCheckEndTime 说明**

上报数据观测云对其处理逻辑包含 追加写入、更新覆盖 两种模式，根据这两种数据的特性，监控需要做检测的区别对待。此区别对应范围包含监控器、智能监控、智能巡检所有模块。
所有覆盖更新机制的数据类型配置监控器检测时，为了避免因为监控器执行 delay 1 分钟导致更新模式的数据在固定的时间范围内有逃逸现象，此类监控器类型的检测区间不指定结束时间。
涉及监控器类型：阈值检测、突变检测、区间检测、离群检测、进程异常检测、基础设施存活检测、用户访问指标检测（个别指标，详见下面表格）

| 数据类型 | Namespace | 写入模式 |
| ---- | ---- | ---- |
| 指标 | M | 追加 |
| 事件 | E | 追加 |
| 未恢复事件 | UE | 覆盖 |
| 基础设施-对象 | O | 覆盖 |
| 基础设施-自定义对象 | CO | 覆盖 |
| 基础设施-对象历史 | OH | 追加 |
| 基础设施-自定义对象历史 | COH | 追加 |
| 日志 / 可用性监测 / CI 可视化 | L | 追加 |
| 应用性能监测-链路 | T | 追加 |
| 应用性能监测-Profile | P | 追加 |
| 用户访问监测-Session | R::session | 覆盖 |
| 用户访问监测-View | R::view | 覆盖 |
| 用户访问监测-Resource | R::resource | 追加 |
| 用户访问监测-Long Task | R::long_task | 追加 |
| 用户访问监测-Action | R::action | 追加 |
| 用户访问监测-Error | R::error | 追加 |
| 安全巡检 | S |  |

所有 写入模式为 覆盖 的 需要指定 disableCheckEndTime 为 true

--------------

**11. 区间检测V2版本 相关参数字段说明**

|  参数名        |   type  | 必选  |          说明          |
|---------------|----------|----|------------------------|
| jsonScript.checkerOpt.confidenceInterval        |  integer  |  Y | 置信区间范围，取值为1-100%  |

--------------




## 请求例子
```shell
curl 'https://openapi.guance.com/api/v1/checker/add' \
-H 'DF-API-KEY: <DF-API-KEY>' \
-H 'Content-Type: application/json;charset=UTF-8' \
--data-raw '{"extend":{"funcName":"","isNeedCreateIssue":false,"issueLevelUUID":"","needRecoverIssue":false,"querylist":[{"datasource":"dataflux","qtype":"dql","query":{"alias":"","code":"Result","dataSource":"ssh","field":"ssh_check","fieldFunc":"count","fieldType":"float","funcList":[],"groupBy":["host"],"groupByTime":"","namespace":"metric","q":"M::`ssh`:(count(`ssh_check`)) BY `host`","type":"simple"},"uuid":"aada629a-672e-46f9-9503-8fd61065c382"}],"rules":[{"conditionLogic":"and","conditions":[{"alias":"Result","operands":["90"],"operator":">="}],"status":"critical"},{"conditionLogic":"and","conditions":[{"alias":"Result","operands":["0"],"operator":">="}],"status":"error"}]},"jsonScript":{"atAccounts":[],"atNoDataAccounts":[],"channels":[],"checkerOpt":{"infoEvent":false,"rules":[{"conditionLogic":"and","conditions":[{"alias":"Result","operands":["90"],"operator":">="}],"status":"critical"},{"conditionLogic":"and","conditions":[{"alias":"Result","operands":["0"],"operator":">="}],"status":"error"}]},"disableCheckEndTime":false,"every":"1m","groupBy":["host"],"interval":300,"message":">等级：{{status}}  \n>主机：{{host}}  \n>内容：主机 SSH 状态 {{ Result |  to_fixed(2) }}%  \n>建议：检查主机 SSH 服务状态","noDataMessage":"","noDataTitle":"","recoverNeedPeriodCount":2,"targets":[{"alias":"Result","dql":"M::`ssh`:(count(`ssh_check`)) BY `host`","qtype":"dql"}],"title":"主机 {{ host }} SSH 服务异常-添加告警策略","type":"simpleCheck"},"alertPolicyUUIDs":["altpl_cb3f68c1562940e3991c4af73e5c96b9","altpl_43e1fc4988af4b04a38e98906a5225db"]}' \
--compressed 
```




## 响应
```shell
{
    "code": 200,
    "content": {
        "alertPolicyUUIDs": [
            "altpl_cb3f68c1562940e3991c4af73e5c96b9",
            "altpl_43e1fc4988af4b04a38e98906a5225db"
        ],
        "createAt": 1710831393,
        "createdWay": "manual",
        "creator": "wsak_xxxx",
        "crontabInfo": {
            "crontab": "*/1 * * * *",
            "id": "cron-2n8ZyrMWKXB8"
        },
        "declaration": {
            "b": [
                "asfawfgajfasfafgafwba",
                "asfgahjfaf"
            ],
            "business": "aaa",
            "organization": "64fe7b4062f74d0007b46676"
        },
        "deleteAt": -1,
        "extend": {
            "funcName": "",
            "isNeedCreateIssue": false,
            "issueLevelUUID": "",
            "needRecoverIssue": false,
            "querylist": [
                {
                    "datasource": "dataflux",
                    "qtype": "dql",
                    "query": {
                        "alias": "",
                        "code": "Result",
                        "dataSource": "ssh",
                        "field": "ssh_check",
                        "fieldFunc": "count",
                        "fieldType": "float",
                        "funcList": [],
                        "groupBy": [
                            "host"
                        ],
                        "groupByTime": "",
                        "namespace": "metric",
                        "q": "M::`ssh`:(count(`ssh_check`)) BY `host`",
                        "type": "simple"
                    },
                    "uuid": "aada629a-672e-46f9-9503-8fd61065c382"
                }
            ],
            "rules": [
                {
                    "conditionLogic": "and",
                    "conditions": [
                        {
                            "alias": "Result",
                            "operands": [
                                "90"
                            ],
                            "operator": ">="
                        }
                    ],
                    "status": "critical"
                },
                {
                    "conditionLogic": "and",
                    "conditions": [
                        {
                            "alias": "Result",
                            "operands": [
                                "0"
                            ],
                            "operator": ">="
                        }
                    ],
                    "status": "error"
                }
            ]
        },
        "id": null,
        "isLocked": false,
        "jsonScript": {
            "atAccounts": [],
            "atNoDataAccounts": [],
            "channels": [],
            "checkerOpt": {
                "infoEvent": false,
                "rules": [
                    {
                        "conditionLogic": "and",
                        "conditions": [
                            {
                                "alias": "Result",
                                "operands": [
                                    "90"
                                ],
                                "operator": ">="
                            }
                        ],
                        "status": "critical"
                    },
                    {
                        "conditionLogic": "and",
                        "conditions": [
                            {
                                "alias": "Result",
                                "operands": [
                                    "0"
                                ],
                                "operator": ">="
                            }
                        ],
                        "status": "error"
                    }
                ]
            },
            "disableCheckEndTime": false,
            "every": "1m",
            "groupBy": [
                "host"
            ],
            "interval": 300,
            "message": ">等级：{{status}}  \n>主机：{{host}}  \n>内容：主机 SSH 状态 {{ Result |  to_fixed(2) }}%  \n>建议：检查主机 SSH 服务状态",
            "name": "主机 {{ host }} SSH 服务异常-添加告警策略",
            "noDataMessage": "",
            "noDataTitle": "",
            "recoverNeedPeriodCount": 2,
            "targets": [
                {
                    "alias": "Result",
                    "dql": "M::`ssh`:(count(`ssh_check`)) BY `host`",
                    "qtype": "dql"
                }
            ],
            "title": "主机 {{ host }} SSH 服务异常-添加告警策略",
            "type": "simpleCheck"
        },
        "monitorName": "default",
        "monitorUUID": "monitor_f83dd203f3c24fe7b605e0eb09852a63",
        "refKey": "",
        "secret": "",
        "status": 0,
        "tagInfo": [],
        "type": "trigger",
        "updateAt": null,
        "updator": null,
        "uuid": "rul_3143c7cee6724b01852737bfbcf96403",
        "workspaceUUID": "wksp_4b57c7bab38e4a2d9630f675dc20015d"
    },
    "errorCode": "",
    "message": "",
    "success": true,
    "traceId": "TRACE-014A6CF1-E9D8-4EA7-9527-D3C39CC3A94A"
} 
```




