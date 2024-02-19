# 创建一个监控器

---

<br />**POST /api/v1/checker/add**

## 概述
创建一个监控器




## Body 请求参数

| 参数名        | 类型     | 必选   | 说明              |
|:-----------|:-------|:-----|:----------------|
| type | string |  | 监控器类型, 默认trigger, trigger:普通监控器, (outer_event_checker:普通监控器中的外部事件检测), smartMonitor 为智能监控<br>允许为空: False <br>例子: smartMonitor <br> |
| extend | json |  | 额外信息<br>允许为空: True <br> |
| monitorUUID | string | Y | 分组id<br>允许为空: True <br> |
| dashboardUUID | string |  | 关联仪表板id<br>允许为空: False <br> |
| jsonScript | json |  | 规则配置<br>允许为空: False <br> |
| jsonScript.type | string | Y | 检查方法类型<br>例子: simpleCheck <br>允许为空: False <br> |
| jsonScript.name | string | Y | 检查项名字<br>例子: 自定义检查项AA <br>允许为空: False <br> |
| jsonScript.title | string | Y | 生成event的标题<br>例子: 监控器: `{{monitor_name}}` 检查器:`{{monitor_checker_name}}` 触发值:`{{M1}}` <br>允许为空: False <br> |
| jsonScript.message | string | Y | event内容<br>例子: status: {{status}}, title:`{{title}}` <br>允许为空: False <br> |
| jsonScript.every | string |  | 检查频率<br>例子: 1m <br>允许为空: False <br> |
| jsonScript.interval | integer |  | 查询区间，即一次查询的时间范围时差<br>例子: 60 <br>允许为空: False <br> |
| jsonScript.range | integer |  | 针对高级检测,突变检测的range参数,单位s<br>例子: 3600 <br>允许为空: False <br> |
| jsonScript.range_2 | integer |  | 针对高级检测,突变检测的range_2参数,单位s,特殊说明 (-1代表环比,  0代表使用 periodBefore字段)<br>例子: 600 <br>允许为空: False <br> |
| jsonScript.periodBefore | integer |  | 针对高级检测,突变检测的(昨日/一小时前)参数,单位s<br>例子: 600 <br>允许为空: False <br> |
| jsonScript.recoverNeedPeriodCount | integer |  | 指定异常在几个检查周期之后生成恢复事件<br>例子: 60 <br>允许为空: False <br> |
| jsonScript.noDataInterval | integer |  | 多长时间内无数据则产生无数据事件<br>例子: 60 <br>允许为空: False <br> |
| jsonScript.checkFuncs | array |  | 检查函数信息列表<br>例子: [{'funcId': 'xxx', 'kwargs': {}}] <br>允许为空: False <br> |
| jsonScript.groupBy | array |  | 触发维度<br>例子: ['性别'] <br>允许为空: False <br> |
| jsonScript.targets | array |  | 检查目标<br>例子: [{'dql': 'M::`士兵信息`:(AVG(`潜力值`))  [::auto] by `性别`', 'alias': 'M1'}] <br>允许为空: False <br> |
| jsonScript.checkerOpt | json |  | 检查条件设置<br>允许为空: False <br> |
| jsonScript.checkerOpt.rules | array |  | 触发条件列表<br>例子: [{'status': 'warning', 'conditions': [{'operands': [60], 'operator': '>', 'alias': 'M1'}], 'conditionLogic': 'and'}] <br>允许为空: False <br> |
| jsonScript.checkerOpt.infoEvent | boolean |  | 是否在持续正常时产生info事,默认false<br>例子: True <br> |
| jsonScript.checkerOpt.diffMode | string |  | 高级检测中突变检测的,差值模式,枚举值, value, percent<br>例子: value <br>可选值: ['value', 'percent'] <br> |
| jsonScript.checkerOpt.direction | string |  | 高级检测中突变检测,区间检测的触发条件方向<br>例子: up <br>可选值: ['up', 'down', 'both'] <br> |
| jsonScript.checkerOpt.eps | float |  | 距离参数，取值范围：0 ~ 3.0<br>例子: 0.5 <br> |
| jsonScript.checkerOpt.threshold | json |  | 高级检测中突变检测的触发前提条件设置<br>允许为空: False <br> |
| jsonScript.checkerOpt.threshold.status | boolean | Y | 高级检测中突变检测, 触发前提条件是否开启,<br>例子: True <br> |
| jsonScript.checkerOpt.threshold.operator | string | Y | 高级检测中突变检测, 触发前提条件操作符<br>例子:  <br> |
| jsonScript.checkerOpt.threshold.value | float | Y | 高级检测中突变检测, 触发前提条件检测值<br>例子: 90 <br>允许为空: True <br> |
| jsonScript.channels | array |  | 频道UUID列表<br>例子: ['名称1', '名称2'] <br>允许为空: False <br> |
| jsonScript.atAccounts | array |  | 正常检测下被@的账号UUID列表<br>例子: ['xx1', 'xx2'] <br>允许为空: False <br> |
| jsonScript.atNoDataAccounts | array |  | 无数据情况下被@的账号UUID列表<br>例子: ['xx1', 'xx2'] <br>允许为空: False <br> |
| jsonScript.subUri | string |  | 表示Webhook地址的地址后缀<br>例子: datakit/push <br>允许为空: False <br> |
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


**2. **触发条件比较操作符说明(`checkerOpt`.`rules` 中的参数说明)**

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

--------------

**3.简单/日志/水位/突变/区间检查 `jsonScript.type` in （`simpleCheck`, `loggingCheck`, `waterLevelCheck`, `mutationsCheck`, `rangeCheck`, `securityCheck`）参数信息**

|  参数名        |   type  | 必选  |          说明          |
|---------------|----------|----|------------------------|
| name          |  string  |  Y | 规则名                  |
| title         |  string  |  Y | 事件标题                |
| message       |  string  |  Y | 事件内容                |
| name          |  string  |  Y | 规则名                  |
| type          |  string  |  Y | 规则类型   |
| every         |  string  |  Y | 检查频率, 单位是 (1m/1h/1d)  |
| interval      |  integer |  Y | 数据时间范围的时差，即time_range的时差, 单位：秒  |
| recoverNeedPeriodCount |  integer |  Y | 超过指定检查周期次数之后生成恢复事件 |
| noDataInterval|  integer | N |  多长时间内无数据则产生无数据事件
| targets       |  array   |  Y | 简单检查中的检查目标列表|
| targets[*].dql|  string  |  Y | DQL查询语句|
| targets[*].alias| string |  Y | 别名|
| checkerOpt    |  json    |  N | 检查配置,可选 |
| checkerOpt.rules|  array |  Y | 检查规则列表 |

--------------


**4.高级检查 `jsonScript.type` in （`seniorCheck`）参数信息**


|  参数名        |   type  | 必选  |          说明          |
|---------------|----------|----|------------------------|
| name          |  string  |  Y | 规则名                  |
| title         |  string  |  Y | 事件标题                |
| message       |  string  |  Y | 事件内容                |
| type          |  string  |  Y | 规则类型  |
| every         |  string  |  Y | 检查频率, 单位是 (1m/1h/1d)  |
| checkFuncs    |  array   |  Y | 高级检查函数列表, 注意它有且仅有一个元素|
| checkFuncs[#].funcId |  string    |  Y | 函数ID, 可通过`【外部函数】列出`接口获取 funcTags=`monitorType|custom`的自定义检查函数列表|
| checkFuncs[#].kwargs |  json    |  N | 该高级函数所需的参数数据 |

--------------

**5.突变检查 seniorMutationsCheck 参数说明**

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

**6. 字段 disableCheckEndTime 说明**
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




## 请求例子
```shell
curl 'https://openapi.guance.com/api/v1/checker/add' \
-H 'DF-API-KEY: <DF-API-KEY>' \
-H 'Content-Type: application/json;charset=UTF-8' \
--data-raw '{"extend": {"querylist": [{"datasource": "dataflux", "qtype": "dql", "uuid": "60ede817-567d-4d74-ad53-09b1165755b3", "query": {"code": "Result", "type": "simple", "namespace": "metric", "dataSource": "aliyun-bss-sync", "field": "EffectiveCashCoupons", "fieldType": "integer", "alias": "", "fieldFunc": "last", "groupByTime": "", "groupBy": ["account"], "q": "M::`aliyun-bss-sync`:(LAST(`EffectiveCashCoupons`)) BY `account`", "funcList": []}}], "funcName": "", "rules": [{"status": "critical", "conditions": [{"alias": "Result", "operator": "&gt;=", "operands": ["7"]}], "conditionLogic": "and"}, {"status": "error", "conditions": [{"alias": "Result", "operator": "&gt;=", "operands": ["6"]}], "conditionLogic": "and"}, {"status": "warning", "conditions": [{"alias": "Result", "operator": "&gt;=", "operands": ["5"]}], "conditionLogic": "and"}], "noDataInterval": 4, "recoverNeedPeriodCount": 3}, "jsonScript": {"name": "ee", "title": "hhhh", "message": "adfsgdsad", "type": "simpleCheck", "every": "1m", "groupBy": ["account"], "interval": 300, "targets": [{"dql": "M::`aliyun-bss-sync`:(LAST(`EffectiveCashCoupons`)) BY `account`", "alias": "Result"}], "checkerOpt": {"rules": [{"status": "critical", "conditions": [{"alias": "Result", "operator": ">=", "operands": ["7"]}], "conditionLogic": "and"}, {"status": "error", "conditions": [{"alias": "Result", "operator": ">=", "operands": ["6"]}], "conditionLogic": "and"}, {"status": "warning", "conditions": [{"alias": "Result", "operator": ">=", "operands": ["5"]}], "conditionLogic": "and"}]}, "noDataInterval": 4, "recoverNeedPeriodCount": 3}, "monitorUUID": "monitor_3f5e5d2108f74e07b8fb1e7459aae2b8"}' \
--compressed 
```




## 响应
```shell
{
    "code": 200,
    "content": {
        "createAt": 1642580905.1799061,
        "creator": "wsak_9c2d4d998d9548949ce05680552254af",
        "crontabInfo": {
            "crontab": "*/1 * * * *",
            "id": "cron-uJAoM0hVAAQz"
        },
        "deleteAt": -1,
        "extend": {
            "funcName": "",
            "noDataInterval": 4,
            "querylist": [
                {
                    "datasource": "dataflux",
                    "qtype": "dql",
                    "query": {
                        "alias": "",
                        "code": "Result",
                        "dataSource": "acs_ecs_dashboard",
                        "field": "CPUUtilization_Average",
                        "fieldFunc": "last",
                        "fieldType": "float",
                        "funcList": [],
                        "groupBy": [
                            "account"
                        ],
                        "groupByTime": "",
                        "namespace": "metric",
                        "q": "M::`acs_ecs_dashboard`:(LAST(`CPUUtilization_Average`)) [::300s] BY `account`",
                        "type": "simple"
                    },
                    "uuid": "84d07b21-d881-43cc-be73-eccd52c81216"
                }
            ],
            "recoverNeedPeriodCount": 4,
            "rules": [
                {
                    "checkCount": 5,
                    "conditionLogic": "and",
                    "direction": "up",
                    "periodNum": 5,
                    "status": "critical",
                    "strength": 3
                },
                {
                    "checkCount": 5,
                    "conditionLogic": "and",
                    "direction": "up",
                    "periodNum": 5,
                    "status": "error",
                    "strength": 3
                },
                {
                    "checkCount": 5,
                    "conditionLogic": "and",
                    "direction": "up",
                    "periodNum": 5,
                    "status": "warning",
                    "strength": 3
                }
            ]
        },
        "id": null,
        "jsonScript": {
            "checkerOpt": {
                "rules": [
                    {
                        "checkCount": 5,
                        "conditionLogic": "and",
                        "direction": "up",
                        "periodNum": 5,
                        "status": "critical",
                        "strength": 3
                    },
                    {
                        "checkCount": 5,
                        "conditionLogic": "and",
                        "direction": "up",
                        "periodNum": 5,
                        "status": "error",
                        "strength": 3
                    },
                    {
                        "checkCount": 5,
                        "conditionLogic": "and",
                        "direction": "up",
                        "periodNum": 5,
                        "status": "warning",
                        "strength": 3
                    }
                ]
            },
            "every": "1m",
            "groupBy": [
                "account"
            ],
            "interval": 300,
            "message": "ooopen",
            "name": "opentest-han",
            "noDataInterval": 4,
            "recoverNeedPeriodCount": 4,
            "targets": [
                {
                    "alias": "Result",
                    "dql": "M::`acs_ecs_dashboard`:(LAST(`CPUUtilization_Average`)) [::300s] BY `account`"
                }
            ],
            "title": "ooooo",
            "type": "mutationsCheck"
        },
        "monitorName": "神神道道所",
        "monitorUUID": "monitor_8a71b5488b8c42cfa8f407cbb91d6898",
        "status": 0,
        "type": "trigger",
        "updateAt": 1642580905.1799622,
        "updator": "",
        "uuid": "rul_d09dbe87b4fd42ac98717518cc6416ef",
        "workspaceUUID": "wksp_2dc431d6693711eb8ff97aeee04b54af"
    },
    "errorCode": "",
    "message": "",
    "success": true,
    "traceId": "TRACE-6D77BEDB-3798-4A4A-84E0-E9B27FC47E3F"
} 
```




