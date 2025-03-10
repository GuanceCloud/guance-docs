# Modify a Monitor

---

<br />**POST /api/v1/checker/\{rule_uuid\}/modify**

## Overview
Modify the specified monitor information based on `rule_uuid`



## Route Parameters

| Parameter Name        | Type     | Required   | Description              |
|:------------------|:-------|:-----|:----------------|
| rule_uuid | string | Y | ID of the check item<br> |


## Body Request Parameters

| Parameter Name        | Type     | Required   | Description              |
|:------------------|:-------|:-----|:----------------|
| extend | json |  | Additional information<br>Can be empty: True <br> |
| status | integer |  | Monitor status field, 0 for enabled state, 2 for disabled state, default is enabled state, (added in iteration on 2025-02-19)<br>Can be empty: False <br>Optional values: [0, 2] <br> |
| monitorUUID | string |  | Group ID<br>Can be empty: False <br>Can be an empty string: True <br> |
| alertPolicyUUIDs | array |  | Alert policy UUID<br>Can be empty: False <br> |
| dashboardUUID | string |  | Associated dashboard ID<br>Can be empty: False <br> |
| tags | array |  | Tag names used for filtering<br>Can be empty: False <br>Example: ['xx', 'yy'] <br> |
| secret | string |  | Unique identifier secret in the middle of the Webhook URL<br>Can be empty: False <br>Example: secret_xxxxx <br> |
| jsonScript | json |  | Rule configuration<br>Can be empty: False <br> |
| jsonScript.type | string | Y | Check method type<br>Example: simpleCheck <br>Can be empty: False <br> |
| jsonScript.windowDql | string |  | Window DQL<br>Can be empty: False <br> |
| jsonScript.title | string | Y | Title of the generated event<br>Example: Monitor: `{monitor_name}` Checker:`{monitor_checker_name}` Trigger value:`{M1}` <br>Can be empty: False <br>Can be an empty string: True <br>Maximum length: 256 <br> |
| jsonScript.message | string |  | Event content<br>Example: status: {status}, title:`{title}` <br>Can be empty: False <br>Can be an empty string: True <br> |
| jsonScript.recoverTitle | string |  | Output recovery event title template<br>Example: Monitor: `{monitor_name}` Checker:`{monitor_checker_name}` Trigger value:`{M1}` <br>Can be empty: False <br>Can be an empty string: True <br> |
| jsonScript.recoverMessage | string |  | Output recovery event message template<br>Example: status: {status}, title:`{title}` <br>Can be empty: False <br>Can be an empty string: True <br> |
| jsonScript.noDataTitle | string |  | Output no data event title template<br>Example: Monitor: `{monitor_name}` Checker:`{monitor_checker_name}` Trigger value:`{M1}` <br>Can be empty: False <br>Can be an empty string: True <br> |
| jsonScript.noDataMessage | string |  | Output no data event message template<br>Example: status: {status}, title:`{title}` <br>Can be empty: False <br>Can be an empty string: True <br> |
| jsonScript.openNotificationMessage | boolean |  | Whether to enable event notification content, default is not enabled (use event content as notification content)<br>Example: False <br>Can be empty: False <br> |
| jsonScript.notificationMessage | string |  | Event notification content<br>Example: Monitor: `{monitor_name}` Checker:`{monitor_checker_name}` Trigger value:`{M1}` <br>Can be empty: False <br>Can be an empty string: True <br> |
| jsonScript.openNoDataNotificationMessage | boolean |  | Whether to enable no data event notification content, default is not enabled (use no data event content as notification content)<br>Example: False <br>Can be empty: False <br> |
| jsonScript.noDataNotificationMessage | string |  | No data event notification content<br>Example: status: {status}, title:`{title}` <br>Can be empty: False <br>Can be an empty string: True <br> |
| jsonScript.noDataRecoverTitle | string |  | Output no data recovery event title template<br>Example: Monitor: `{monitor_name}` Checker:`{monitor_checker_name}` Trigger value:`{M1}` <br>Can be empty: False <br>Can be an empty string: True <br> |
| jsonScript.noDataRecoverMessage | string |  | Output no data recovery event message template<br>Example: status: {status}, title:`{title}` <br>Can be empty: False <br>Can be an empty string: True <br> |
| jsonScript.every | string |  | Check frequency<br>Example: 1m <br>Can be empty: False <br> |
| jsonScript.customCrontab | string |  | Custom check frequency<br>Example: 0 */12 * * * <br>Can be empty: False <br> |
| jsonScript.interval | integer |  | Query interval, i.e., the time range difference for one query<br>Example: 60 <br>Can be empty: False <br> |
| jsonScript.range | integer |  | Range parameter for advanced detection and anomaly detection, unit s<br>Example: 3600 <br>Can be empty: False <br> |
| jsonScript.range_2 | integer |  | Range_2 parameter for advanced detection and anomaly detection, unit s, special note (-1 represents year-over-year, 0 represents using periodBefore field)<br>Example: 600 <br>Can be empty: False <br> |
| jsonScript.periodBefore | integer |  | Yesterday/hour-ago parameter for advanced detection and anomaly detection, unit s<br>Example: 600 <br>Can be empty: False <br> |
| jsonScript.recoverNeedPeriodCount | integer |  | Specifies how many check cycles after an anomaly generates a recovery event. If the check frequency is custom crontab, this field indicates the time length, unit s; otherwise, it indicates the number of check cycles.<br>Example: 60 <br>Can be empty: False <br> |
| jsonScript.noDataInterval | integer |  | How long without data will generate a no data event<br>Example: 60 <br>Can be empty: False <br> |
| jsonScript.noDataAction | string |  | No data handling action<br>Can be empty: False <br>Optional values: ['none', 'checkAs0', 'noDataEvent', 'criticalEvent', 'errorEvent', 'warningEvent', 'okEvent', 'noData', 'recover'] <br> |
| jsonScript.checkFuncs | array |  | List of check function information<br>Example: [{'funcId': 'xxx', 'kwargs': {}}] <br>Can be empty: False <br> |
| jsonScript.groupBy | array |  | Trigger dimensions<br>Example: ['hospital'] <br>Can be empty: False <br> |
| jsonScript.targets | array |  | Check targets<br>Example: [{'dql': 'M::`soldier_info`:(AVG(`potential_value`))  [::auto] by `gender`', 'alias': 'M1'}] <br>Can be empty: False <br> |
| jsonScript.checkerOpt | json |  | Check condition settings<br>Can be empty: False <br> |
| jsonScript.checkerOpt.rules | array |  | List of trigger conditions<br>Example: [{'status': 'warning', 'conditions': [{'operands': [60], 'operator': '>', 'alias': 'M1'}], 'conditionLogic': 'and', 'matchTimes': 10}] <br>Can be empty: False <br> |
| jsonScript.checkerOpt.openMatchTimes | boolean |  | Enable continuous trigger judgment, default is off false<br>Example: True <br> |
| jsonScript.checkerOpt.infoEvent | boolean |  | Whether to generate info events when continuously normal, default is false<br>Example: True <br> |
| jsonScript.checkerOpt.diffMode | string |  | Difference mode for anomaly detection in advanced detection, enum value, value, percent<br>Example: value <br>Optional values: ['value', 'percent'] <br> |
| jsonScript.checkerOpt.direction | string |  | Trigger condition direction for anomaly detection and interval detection in advanced detection<br>Example: up <br>Optional values: ['up', 'down', 'both'] <br> |
| jsonScript.checkerOpt.eps | float |  | Distance parameter, range: 0 ~ 3.0<br>Example: 0.5 <br> |
| jsonScript.checkerOpt.threshold | json |  | Premise condition settings for anomaly detection<br>Can be empty: False <br> |
| jsonScript.checkerOpt.threshold.status | boolean | Y | Whether to enable premise condition for anomaly detection,<br>Example: True <br> |
| jsonScript.checkerOpt.threshold.operator | string | Y | Operator for premise condition of anomaly detection<br>Example:  <br> |
| jsonScript.checkerOpt.threshold.value | float | Y | Detection value for premise condition of anomaly detection<br>Example: 90 <br>Can be empty: True <br> |
| jsonScript.checkerOpt.combineExpr | string |  | Combination monitoring, combination method<br>Example: A && B <br>Cannot be an empty string: False <br> |
| jsonScript.checkerOpt.ignoreNodata | boolean |  | Combination monitoring, whether to ignore no data results (true means ignoring),<br>Example: True <br> |
| jsonScript.checkerOpt.confidenceInterval | integer |  | Interval detection V2 new parameter, confidence interval range 1-100,<br>Example: 10 <br> |
| jsonScript.channels | array |  | List of channel UUIDs<br>Example: ['name1', 'name2'] <br>Can be empty: False <br> |
| jsonScript.atAccounts | array |  | List of account UUIDs to be @ in normal detection<br>Example: ['xx1', 'xx2'] <br>Can be empty: False <br> |
| jsonScript.atNoDataAccounts | array |  | List of account UUIDs to be @ in no data case<br>Example: ['xx1', 'xx2'] <br>Can be empty: False <br> |
| jsonScript.subUri | string |  | Suffix of the Webhook URL<br>Example: datakit/push <br>Can be empty: False <br> |
| jsonScript.disableCheckEndTime | boolean |  | Whether to disable end time restriction<br>Example: True <br>Can be empty: False <br> |
| jsonScript.eventChartEnable | boolean |  | Whether to enable event chart, default is disabled (note that it only takes effect when the main storage engine logging is doris)<br>Example: False <br>Can be empty: False <br> |
| jsonScript.eventCharts | array |  | List of event charts<br>Example: True <br>Can be empty: False <br> |
| jsonScript.eventCharts[*] | None |  | <br> |
| jsonScript.eventCharts[*].dql | string |  | Query statement of the event chart<br>Example: M::`cpu`:(avg(`load5s`)) BY `host` <br>Can be empty: False <br> |
| openPermissionSet | boolean |  | Enable custom permission configuration, (default false: not enabled), if enabled, the operation permissions of this rule are based on permissionSet<br>Can be empty: False <br> |
| permissionSet | array |  | Operation permission configuration, can configure (role (except owner), member UUID, team UUID)<br>Example: ['wsAdmin', 'acnt_xxxx', 'group_yyyy'] <br>Can be empty: False <br> |

## Parameter Supplemental Explanation



## Request Example
```shell
curl 'https://openapi.<<< custom_key.brand_main_domain >>>/api/v1/checker/rul_xxxxxx/modify' \
-H 'DF-API-KEY: <DF-API-KEY>' \
-H 'Content-Type: application/json;charset=UTF-8' \
--data-raw '{"extend":{"querylist":[{"datasource":"dataflux","qtype":"dql","query":{"code":"Result","type":"simple","namespace":"metric","dataSource":"ssh","field":"ssh_check","fieldType":"float","alias":"","fieldFunc":"count","groupByTime":"","groupBy":["host"],"q":"M::`ssh`:(count(`ssh_check`)) BY `host`","funcList":[]},"uuid":"aada629a-672e-46f9-9503-8fd61065c382"}],"funcName":"","rules":[{"conditionLogic":"and","conditions":[{"alias":"Result","operands":["90"],"operator":">="}],"status":"critical"},{"conditionLogic":"and","conditions":[{"alias":"Result","operands":["0"],"operator":">="}],"status":"error"}],"issueLevelUUID":"system_level_3","isNeedCreateIssue":false,"needRecoverIssue":false},"jsonScript":{"title":"Host {{ host }} SSH service abnormal","message":">Level: {status}  \n>Host: {host}  \n>Content: Host SSH status {{ Result |  to_fixed(2) }}%  \n>Suggestion: Check the status of the host SSH service","noDataTitle":"","noDataMessage":"","type":"simpleCheck","every":"1m","groupBy":["host"],"interval":300,"targets":[{"dql":"M::`ssh`:(count(`ssh_check`)) BY `host`","alias":"Result","qtype":"dql"}],"checkerOpt":{"rules":[{"conditionLogic":"and","conditions":[{"alias":"Result","operands":["90"],"operator":">="}],"status":"critical"},{"conditionLogic":"and","conditions":[{"alias":"Result","operands":["0"],"operator":">="}],"status":"error"}],"infoEvent":false},"recoverNeedPeriodCount":2,"channels":[],"atAccounts":[],"atNoDataAccounts":[],"disableCheckEndTime":false},"alertPolicyUUIDs":["altpl_xxxx32"],"tags":["Local test combined detection"]}' \
--compressed 
```




## Response
```shell
{
    "code": 200,
    "content": {
        "createAt": 1710827935,
        "createdWay": "manual",
        "creator": "acnt_xxxx32",
        "crontabInfo": {
            "crontab": "*/1 * * * *",
            "id": "cron-pwiThsuE9gtQ"
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
            "issueLevelUUID": "system_level_3",
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
        "id": 1118,
        "isLocked": 0,
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
            "message": ">Level: {status}  \n>Host: {host}  \n>Content: Host SSH status {{ Result |  to_fixed(2) }}%  \n>Suggestion: Check the status of the host SSH service",
            "name": "Host {{ host }} SSH service abnormal",
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
            "title": "Host {{ host }} SSH service abnormal",
            "type": "simpleCheck"
        },
        "monitorUUID": "monitor_xxxx32",
        "refKey": "",
        "secret": "",
        "status": 0,
        "tagInfo": [
            {
                "id": "tag_xxxx32",
                "name": "Local test combined detection"
            }
        ],
        "type": "trigger",
        "updateAt": 1710831784,
        "updator": "wsak_xxxxx",
        "uuid": "rul_xxxx32",
        "workspaceUUID": "wksp_xxxx32"
    },
    "errorCode": "",
    "message": "",
    "success": true,
    "traceId": "TRACE-FF2C1DA3-1EE2-4802-A857-D37BCFB0C562"
} 
```