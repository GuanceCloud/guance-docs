# 创建一个监控器

---

<br />**post /api/v1/monitor/check/create**

## 概述
创建一个监控器




## Body 请求参数

| 参数名        | 类型     | 必选   | 说明              |
|:-----------|:-------|:-----|:----------------|
| extend | json |  | 额外信息<br>允许为空: True <br> |
| monitorUUID | string | Y | 分组id<br>允许为空: True <br> |
| dashboardUUID | string |  | 关联仪表板id<br>允许为空: False <br> |
| jsonScript | json |  | 规则配置<br>允许为空: False <br> |
| jsonScript.type | string | Y | 检查方法类型<br>例子: simpleCheck <br>允许为空: False <br> |
| jsonScript.name | string | Y | 检查项名字<br>例子: 自定义检查项AA <br>允许为空: False <br> |
| jsonScript.title | string | Y | 生成event的标题<br>例子: 监视器: `{{monitor_name}}` 检查器:`{{monitor_checker_name}}` 触发值:`{{M1}}` <br>允许为空: False <br> |
| jsonScript.message | string | Y | event内容<br>例子: status: {{status}}, title:`{{title}}` <br>允许为空: False <br> |
| jsonScript.every | string |  | 检查频率<br>例子: 1m <br>允许为空: False <br> |
| jsonScript.interval | integer |  | 查询区间，即一次查询的时间范围时差<br>例子: 60 <br>允许为空: False <br> |
| jsonScript.recoverNeedPeriodCount | integer |  | 指定异常在几个检查周期之后生成恢复事件<br>例子: 60 <br>允许为空: False <br> |
| jsonScript.noDataPeriodCount | integer |  | 几个检查周期内无数据则产生无数据事件<br>例子: 60 <br>允许为空: False <br> |
| jsonScript.checkFuncs | array |  | 检查函数信息列表<br>例子: [{'funcId': 'xxx', 'kwargs': {}}] <br>允许为空: False <br> |
| jsonScript.groupBy | array |  | 触发维度<br>例子: ['性别'] <br>允许为空: False <br> |
| jsonScript.targets | array |  | 检查目标<br>例子: [{'dql': 'M::`士兵信息`:(AVG(`潜力值`))  [::auto] by `性别`', 'alias': 'M1'}] <br>允许为空: False <br> |
| jsonScript.checkerOpt | json |  | 检查条件设置<br>允许为空: False <br> |
| jsonScript.checkerOpt.rules | array |  | 触发条件列表<br>例子: [{'status': 'warning', 'conditions': [{'operands': [60], 'operator': '>', 'alias': 'M1'}], 'conditionLogic': 'and'}] <br>允许为空: False <br> |

## 参数补充说明


*数据说明.*

*jsonScript 参数说明*

**1. 检查类型`jsonScript.type` 说明**

|key|说明|
|---|----|
|simpleCheck| 简单检查|
|seniorCheck| 高级检查|
|loggingCheck| 日志检查|
|mutationsCheck| 突变检查|
|waterLevelCheck| 水位检查|
|rangeCheck| 区间检查|
|securityCheck| 安全巡检|
|apmCheck| APM检查|
|rumCheck| RUM检查|
|processCheck| 进程检查|
|cloudDialCheck| 云拨测异常检查|


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
| noDataPeriodCount|  integer | N |  几个检查周期内无数据则产生无数据事件
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




## 请求例子
```shell
curl '<Endpoint>/api/v1/monitor/check/create' \
-H 'DF-API-KEY: <DF-API-KEY>' \
-H 'Content-Type: application/json;charset=UTF-8' \
--data-raw '{"extend": {"querylist": [{"datasource": "dataflux", "qtype": "dql", "uuid": "60ede817-567d-4d74-ad53-09b1165755b3", "query": {"code": "Result", "type": "simple", "namespace": "metric", "dataSource": "aliyun-bss-sync", "field": "EffectiveCashCoupons", "fieldType": "integer", "alias": "", "fieldFunc": "last", "groupByTime": "", "groupBy": ["account"], "q": "M::`aliyun-bss-sync`:(LAST(`EffectiveCashCoupons`)) BY `account`", "funcList": []}}], "funcName": "", "rules": [{"status": "critical", "conditions": [{"alias": "Result", "operator": "&gt;=", "operands": ["7"]}], "conditionLogic": "and"}, {"status": "error", "conditions": [{"alias": "Result", "operator": "&gt;=", "operands": ["6"]}], "conditionLogic": "and"}, {"status": "warning", "conditions": [{"alias": "Result", "operator": "&gt;=", "operands": ["5"]}], "conditionLogic": "and"}], "noDataPeriodCount": 4, "recoverNeedPeriodCount": 3}, "jsonScript": {"name": "ee", "title": "hhhh", "message": "adfsgdsad", "type": "simpleCheck", "every": "1m", "groupBy": ["account"], "interval": 300, "targets": [{"dql": "M::`aliyun-bss-sync`:(LAST(`EffectiveCashCoupons`)) BY `account`", "alias": "Result"}], "checkerOpt": {"rules": [{"status": "critical", "conditions": [{"alias": "Result", "operator": ">=", "operands": ["7"]}], "conditionLogic": "and"}, {"status": "error", "conditions": [{"alias": "Result", "operator": ">=", "operands": ["6"]}], "conditionLogic": "and"}, {"status": "warning", "conditions": [{"alias": "Result", "operator": ">=", "operands": ["5"]}], "conditionLogic": "and"}]}, "noDataPeriodCount": 4, "recoverNeedPeriodCount": 3}, "monitorUUID": "monitor_3f5e5d2108f74e07b8fb1e7459aae2b8"}' \
--compressed \
--insecure
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
            "noDataPeriodCount": 4,
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
            "noDataPeriodCount": 4,
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




