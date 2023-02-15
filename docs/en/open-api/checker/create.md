# Create a monitor

---

<br />**post /api/v1/monitor/check/create**

## Overview
Create a monitor.




## Body Request Parameter

| Parameter Name        | Type     | Required   | Description              |
|:-----------|:-------|:-----|:----------------|
| extend | json |  | Additional information<br>Allow null: True <br> |
| monitorUUID | string | Y | Packet id<br>Allow null: True <br> |
| dashboardUUID | string |  | Associated dashboard id<br>Allow null: False <br> |
| jsonScript | json |  | Rule configuration<br>Allow null: False <br> |
| jsonScript.type | string | Y | Check method type<br>Example: simpleCheck <br>Allow null: False <br> |
| jsonScript.name | string | Y | Check item name<br>Example: Custom check item AA <br>Allow null: False <br> |
| jsonScript.title | string | Y | Generate the title of the event<br>Example: Monitor: `{{monitor_name}}`; Checker:`{{monitor_checker_name}}`; Trigger value:`{{M1}}` <br>Allow null: False <br> |
| jsonScript.message | string | Y | event content<br>Example: status: {{status}}, title:`{{title}}` <br>Allow null: False <br> |
| jsonScript.every | string |  | Frequency of inspection<br>Example: 1m <br>Allow null: False <br> |
| jsonScript.interval | integer |  | Query interval, that is, the time range time difference of a query<br>Example: 60 <br>Allow null: False <br> |
| jsonScript.recoverNeedPeriodCount | integer |  | Specify that an exception generates a recovery event after several inspection cycles<br>Example: 60 <br>Allow null: False <br> |
| jsonScript.noDataInterval | integer |  | The time no data leading to no data event<br>Example: 60 <br>Allow null: False <br> |
| jsonScript.checkFuncs | array |  | Check the list of function information<br>Example: [{'funcId': 'xxx', 'kwargs': {}}] <br>Allow null: False <br> |
| jsonScript.groupBy | array |  | Trigger dimension<br>Example: ['gender'] <br>Allow null: False <br> |
| jsonScript.targets | array |  | Check target<br>Example: [{'dql': 'M::`soldier information`:(AVG(`potential value`))  [::auto] by `gender`', 'alias': 'M1'}] <br>Allow null: False <br> |
| jsonScript.checkerOpt | json |  | Check condition settings<br>Allow null: False <br> |
| jsonScript.checkerOpt.rules | array |  | Trigger condition list<br>Example: [{'status': 'warning', 'conditions': [{'operands': [60], 'operator': '>', 'alias': 'M1'}], 'conditionLogic': 'and'}] <br>Allow null: False <br> |

## Supplementary Description of Parameters


*Data Description.*

*jsonScript Parameter Description*

**1. Check Type `jsonScript.type` Description**

|key|Description|
|---|----|
|simpleCheck| Simple check|
|seniorCheck| Advanced check|
|loggingCheck| Log check|
|mutationsCheck| Mutation check|
|waterLevelCheck| Water level check|
|rangeCheck| Interval check|
|securityCheck| Scheck|
|apmCheck| APM check|
|rumCheck| RUM check|
|processCheck| Process check|
|cloudDialCheck| Cloud dialing test anomaly check|


**2. **Trigger the Condition Comparison Operator Description (Parameter Description in `checkerOpt`.`rules`**

|  Parameter Name                |   Type  | Required  |          Description          |
|-----------------------|----------|----|------------------------|
|conditions             |Array[Dict]|Must| Condition|
|conditions[#].alias    |String     |Must| Detect the object alias, that is, the targets[#].alias|
|conditions[#].operator |String     |Must| Operator. = , > , < etc.|
|conditions[#].operands |Array[Any] |Must| An array of operands. (Operators like between, in, and so on require more than one operand)|
|conditionLogic         |string     |Must| Conditional intermediate logic: and, or|
|status                 |string     |Must| Output the status of the event when the condition is full. The value is the same as the status of the event.|
|direction    |string     | | Detection direction of "interval/water level/abrupt change parameter", with values of "up", "down", "both"|
|periodNum    |integer     | | "Interval/water level/abrupt change parameter" only detects the number of nearest data points|
|checkPercent    |integer     | |"Interval Parameter" Threshold Value of Abnormal Percentage: 1 ~ 100|
|checkCount    |integer     | | Number of continuous abnormal points of "water level/catastrophe parameter"|
|strength    |integer     | | Detection intensity of "water level/catastrophe parameter", with values of 1=weak, 2=medium and 3=strong|

--------------

**3.Simple/log/water Level/catastrophe/interval Check `jsonScript.type` in (`simpleCheck`, `loggingCheck`, `waterLevelCheck`, `mutationsCheck`, `rangeCheck`, `securityCheck`) Parameter Info**

|  Parameter Name        |   Type  | Required  |          Description          |
|---------------|----------|----|------------------------|
| name          |  string  |  Y | Rule name                  |
| title         |  string  |  Y | Event title                |
| message       |  string  |  Y | Event content                |
| name          |  string  |  Y | Rule name                  |
| type          |  string  |  Y | Rule type   |
| every         |  string  |  Y | Frequency of inspection in 1m/1h/1d  |
| interval      |  integer |  Y | The time difference of the data time range, that is, the time difference of time_range, in seconds. |
| recoverNeedPeriodCount |  integer |  Y | Generate a recovery event after the specified number of check cycles has exceeded. |
| noDataInterval|  integer | N |  The time data leading to no data event
| targets       |  array   |  Y | List of check targets in simple check|
| targets[*].dql|  string  |  Y | DQL query statement|
| targets[*].alias| string |  Y | Alias|
| checkerOpt    |  json    |  N | Check configuration, optional |
| checkerOpt.rules|  array |  Y | Check the rule list |

--------------


**4. Advanced Check `jsonScript.type` in (`seniorCheck`) Parameter Info**


|  Parameter Name        |   Type  | Required  |          Description          |
|---------------|----------|----|------------------------|
| name          |  string  |  Y | Rule name                  |
| title         |  string  |  Y | Event title                |
| message       |  string  |  Y | Event content                |
| type          |  string  |  Y | Rule type  |
| every         |  string  |  Y | Frequency of inspection in 1m/1h/1d |
| checkFuncs    |  array   |  Y | Check the list of functions at an advanced level, noting that it has and only has one element.|
| checkFuncs[#].funcId |  string    |  Y | Function ID to get a list of custom check functions for funcTags=`monitorType|custom` through the `outer func list` interface|
| checkFuncs[#].kwargs |  json    |  N | Parameter data required by this advanced function |

--------------




## Request Example
```shell
curl 'https://openapi.guance.com/api/v1/monitor/check/create' \
-H 'DF-API-KEY: <DF-API-KEY>' \
-H 'Content-Type: application/json;charset=UTF-8' \
--data-raw '{"extend": {"querylist": [{"datasource": "dataflux", "qtype": "dql", "uuid": "60ede817-567d-4d74-ad53-09b1165755b3", "query": {"code": "Result", "type": "simple", "namespace": "metric", "dataSource": "aliyun-bss-sync", "field": "EffectiveCashCoupons", "fieldType": "integer", "alias": "", "fieldFunc": "last", "groupByTime": "", "groupBy": ["account"], "q": "M::`aliyun-bss-sync`:(LAST(`EffectiveCashCoupons`)) BY `account`", "funcList": []}}], "funcName": "", "rules": [{"status": "critical", "conditions": [{"alias": "Result", "operator": "&gt;=", "operands": ["7"]}], "conditionLogic": "and"}, {"status": "error", "conditions": [{"alias": "Result", "operator": "&gt;=", "operands": ["6"]}], "conditionLogic": "and"}, {"status": "warning", "conditions": [{"alias": "Result", "operator": "&gt;=", "operands": ["5"]}], "conditionLogic": "and"}], "noDataInterval": 4, "recoverNeedPeriodCount": 3}, "jsonScript": {"name": "ee", "title": "hhhh", "message": "adfsgdsad", "type": "simpleCheck", "every": "1m", "groupBy": ["account"], "interval": 300, "targets": [{"dql": "M::`aliyun-bss-sync`:(LAST(`EffectiveCashCoupons`)) BY `account`", "alias": "Result"}], "checkerOpt": {"rules": [{"status": "critical", "conditions": [{"alias": "Result", "operator": ">=", "operands": ["7"]}], "conditionLogic": "and"}, {"status": "error", "conditions": [{"alias": "Result", "operator": ">=", "operands": ["6"]}], "conditionLogic": "and"}, {"status": "warning", "conditions": [{"alias": "Result", "operator": ">=", "operands": ["5"]}], "conditionLogic": "and"}]}, "noDataInterval": 4, "recoverNeedPeriodCount": 3}, "monitorUUID": "monitor_3f5e5d2108f74e07b8fb1e7459aae2b8"}' \
--compressed \
--insecure
```




## Response
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




