# Modify a Monitor

---

<br />**POST /api/v1/checker/\{rule_uuid\}/modify**

## Overview
Modify the specified monitor information based on `rule_uuid`



## Route Parameters

| Parameter Name        | Type     | Required   | Description              |
|:---------------------|:---------|:-----------|:-------------------------|
| rule_uuid             | string   | Y          | ID of the check item      |


## Body Request Parameters

| Parameter Name                  | Type     | Required   | Description              |
|:-------------------------------|:---------|:-----------|:-------------------------|
| extend                         | json     |            | Additional information    |
| monitorUUID                    | string   |            | Group ID                  |
| alertPolicyUUIDs               | array    |            | Alert policy UUID         |
| dashboardUUID                  | string   |            | Associated dashboard ID   |
| tags                           | array    |            | Tag names for filtering   |
| secret                         | string   |            | Unique identifier secret  |
| jsonScript                     | json     |            | Rule configuration        |
| jsonScript.type                | string   | Y          | Check method type         |
| jsonScript.windowDql           | string   |            | Window DQL                |
| jsonScript.title               | string   | Y          | Event title               |
| jsonScript.message             | string   |            | Event content             |
| jsonScript.recoverTitle        | string   |            | Recovery event title template |
| jsonScript.recoverMessage      | string   |            | Recovery event message template |
| jsonScript.noDataTitle         | string   |            | No data event title template |
| jsonScript.noDataMessage       | string   |            | No data event message template |
| jsonScript.openNotificationMessage | boolean |            | Whether to enable notification content, default is not enabled (use event content as notification content) |
| jsonScript.notificationMessage | string   |            | Notification content      |
| jsonScript.openNoDataNotificationMessage | boolean |            | Whether to enable no data event notification content, default is not enabled (use no data event content as notification content) |
| jsonScript.noDataNotificationMessage | string |            | No data event notification content |
| jsonScript.noDataRecoverTitle  | string   |            | No data recovery event title template |
| jsonScript.noDataRecoverMessage | string   |            | No data recovery event message template |
| jsonScript.every               | string   |            | Check frequency           |
| jsonScript.customCrontab       | string   |            | Custom check frequency    |
| jsonScript.interval            | integer  |            | Query interval            |
| jsonScript.range               | integer  |            | Range parameter for advanced checks, in seconds |
| jsonScript.range_2             | integer  |            | Range_2 parameter for advanced checks, in seconds (-1 for year-over-year, 0 for using periodBefore field) |
| jsonScript.periodBefore        | integer  |            | Period before parameter for advanced checks, in seconds |
| jsonScript.recoverNeedPeriodCount | integer |            | Number of check cycles after which a recovery event is generated. If customCrontab is used, this field represents time length in seconds; otherwise, it represents the number of check cycles. |
| jsonScript.noDataInterval      | integer  |            | Time interval with no data to generate a no data event |
| jsonScript.noDataAction        | string   |            | Action for handling no data |
| jsonScript.checkFuncs          | array    |            | List of check function information |
| jsonScript.groupBy             | array    |            | Trigger dimensions        |
| jsonScript.targets             | array    |            | Check targets             |
| jsonScript.checkerOpt          | json     |            | Check condition settings  |
| jsonScript.checkerOpt.rules    | array    |            | List of trigger conditions |
| jsonScript.checkerOpt.openMatchTimes | boolean |            | Enable consecutive trigger judgment, default is false |
| jsonScript.checkerOpt.infoEvent | boolean |            | Generate info events when continuously normal, default is false |
| jsonScript.checkerOpt.diffMode | string   |            | Difference mode for anomaly detection, enum values: value, percent |
| jsonScript.checkerOpt.direction | string |            | Direction of trigger conditions for anomaly and range detection |
| jsonScript.checkerOpt.eps      | float    |            | Distance parameter, range: 0 ~ 3.0 |
| jsonScript.checkerOpt.threshold | json    |            | Premise conditions for anomaly detection |
| jsonScript.checkerOpt.threshold.status | boolean | Y          | Whether premise conditions for anomaly detection are enabled |
| jsonScript.checkerOpt.threshold.operator | string | Y          | Operator for premise conditions of anomaly detection |
| jsonScript.checkerOpt.threshold.value | float | Y          | Detection value for premise conditions of anomaly detection |
| jsonScript.checkerOpt.combineExpr | string |            | Combination monitoring expression |
| jsonScript.checkerOpt.ignoreNodata | boolean |            | Whether to ignore no data results in combination monitoring |
| jsonScript.checkerOpt.confidenceInterval | integer |            | Confidence interval range for range detection V2, value between 1-100 |
| jsonScript.channels            | array    |            | List of channel UUIDs     |
| jsonScript.atAccounts          | array    |            | List of account UUIDs to be @'d under normal checks |
| jsonScript.atNoDataAccounts    | array    |            | List of account UUIDs to be @'d under no data conditions |
| jsonScript.subUri              | string   |            | Webhook address suffix    |
| jsonScript.disableCheckEndTime | boolean  |            | Whether to disable end time restriction |
| jsonScript.eventChartEnable    | boolean  |            | Whether to enable event charts (only effective when main storage engine logging is Doris) |
| jsonScript.eventCharts         | array    |            | List of event charts      |
| jsonScript.eventCharts[*].dql  | string   |            | Query statement for event charts |
| openPermissionSet              | boolean  |            | Enable custom permission configuration (default false: not enabled), if enabled, permissions for this rule will follow permissionSet |
| permissionSet                  | array    |            | Permission configuration, can configure (roles except owner, member UUID, team UUID) |

## Additional Parameter Notes



## Request Example
```shell
curl 'https://openapi.guance.com/api/v1/checker/rul_xxxxxx/modify' \
-H 'DF-API-KEY: <DF-API-KEY>' \
-H 'Content-Type: application/json;charset=UTF-8' \
--data-raw '{"extend":{"querylist":[{"datasource":"dataflux","qtype":"dql","query":{"code":"Result","type":"simple","namespace":"metric","dataSource":"ssh","field":"ssh_check","fieldType":"float","alias":"","fieldFunc":"count","groupByTime":"","groupBy":["host"],"q":"M::`ssh`:(count(`ssh_check`)) BY `host`","funcList":[]},"uuid":"aada629a-672e-46f9-9503-8fd61065c382"}],"funcName":"","rules":[{"conditionLogic":"and","conditions":[{"alias":"Result","operands":["90"],"operator":">="}],"status":"critical"},{"conditionLogic":"and","conditions":[{"alias":"Result","operands":["0"],"operator":">="}],"status":"error"}],"issueLevelUUID":"system_level_3","isNeedCreateIssue":false,"needRecoverIssue":false},"jsonScript":{"title":"Host {{ host }} SSH Service Anomaly","message":">Severity: {status}  \n>Host: {host}  \n>Content: Host SSH status {{ Result |  to_fixed(2) }}%  \n>Suggestion: Check the host SSH service status","noDataTitle":"","noDataMessage":"","type":"simpleCheck","every":"1m","groupBy":["host"],"interval":300,"targets":[{"dql":"M::`ssh`:(count(`ssh_check`)) BY `host`","alias":"Result","qtype":"dql"}],"checkerOpt":{"rules":[{"conditionLogic":"and","conditions":[{"alias":"Result","operands":["90"],"operator":">="}],"status":"critical"},{"conditionLogic":"and","conditions":[{"alias":"Result","operands":["0"],"operator":">="}],"status":"error"}],"infoEvent":false},"recoverNeedPeriodCount":2,"channels":[],"atAccounts":[],"atNoDataAccounts":[],"disableCheckEndTime":false},"alertPolicyUUIDs":["altpl_xxxx32"],"tags":["Local Test Combined Check"]}' \
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
            "message": ">Severity: {status}  \n>Host: {host}  \n>Content: Host SSH status {{ Result |  to_fixed(2) }}%  \n>Suggestion: Check the host SSH service status",
            "name": "Host {{ host }} SSH Service Anomaly",
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
            "title": "Host {{ host }} SSH Service Anomaly",
            "type": "simpleCheck"
        },
        "monitorUUID": "monitor_xxxx32",
        "refKey": "",
        "secret": "",
        "status": 0,
        "tagInfo": [
            {
                "id": "tag_xxxx32",
                "name": "Local Test Combined Check"
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