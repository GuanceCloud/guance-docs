# Import One or Multiple Monitors

---

<br />**POST /api/v1/checker/import**

## Overview
Import configuration for one or multiple monitors


## Body Request Parameters

| Parameter Name        | Type     | Required   | Description              |
|:---------------------|:---------|:-----------|:-------------------------|
| checkers             | array    | Y          | List of rule configurations <br> Can be empty: False <br> |
| type                 | string   |            | For smart monitoring import, use `smartMonitor`; default is regular monitor `trigger` <br> Can be empty: False <br> Can be an empty string: False <br> Allowed values: ['smartMonitor', 'trigger'] <br> |
| skipRepeatNameCheck  | boolean  |            | Whether to skip duplicate name checks; `false` performs duplicate name checks, `true` skips duplicate name checks <br> Example: False <br> Can be empty: False <br> |
| skipRepeatNameCreate | boolean  |            | `true` skips creation for duplicates, creates only non-duplicates; `false` creates all imported information <br> Example: False <br> Can be empty: False <br> |

## Additional Parameter Explanation

**Refer to the [Checker Export Interface] for monitor template configurations.**

*Explanation of relevant parameters.*
If `repeat_name` exists in the response content, it indicates a duplicate name. Use the `skipRepeatNameCreate` parameter to choose whether to skip or create duplicates.

| Parameter Name         | Type | Required | Description |
| :-------------------- | :--- | :------- | :---------- |
| checker               | array | Required | List of rule configurations |
| skipRepeatNameCheck   | boolean | Required | Whether to skip duplicate name checks; if not skipped (`false`): returns a list of duplicate monitor names on failure |
| skipRepeatNameCreate  | boolean | Required | Whether to skip creation for duplicates; if not skipped (`false`): creates monitors with duplicate names |

## Request Example
```shell
curl 'https://openapi.<<< custom_key.brand_main_domain >>>/api/v1/checker/import' \
-H 'DF-API-KEY: <DF-API-KEY>' \
-H 'Content-Type: application/json;charset=UTF-8' \
--data-raw '{"checkers":[{"extend":{"funcName":"","isNeedCreateIssue":false,"issueLevelUUID":"","needRecoverIssue":false,"querylist":[{"datasource":"dataflux","qtype":"dql","query":{"alias":"","code":"Result","dataSource":"ssh","field":"ssh_check","fieldFunc":"count","fieldType":"float","funcList":[],"groupBy":["host"],"groupByTime":"","namespace":"metric","q":"M::`ssh`:(count(`ssh_check`)) BY `host`","type":"simple"},"uuid":"aada629a-672e-46f9-9503-8fd61065c382"}],"rules":[{"conditionLogic":"and","conditions":[{"alias":"Result","operands":["90"],"operator":">="}],"status":"critical"},{"conditionLogic":"and","conditions":[{"alias":"Result","operands":["0"],"operator":">="}],"status":"error"}]},"is_disable":false,"jsonScript":{"atAccounts":[],"atNoDataAccounts":[],"channels":[],"checkerOpt":{"infoEvent":false,"rules":[{"conditionLogic":"and","conditions":[{"alias":"Result","operands":["90"],"operator":">="}],"status":"critical"},{"conditionLogic":"and","conditions":[{"alias":"Result","operands":["0"],"operator":">="}],"status":"error"}]},"disableCheckEndTime":false,"every":"1m","groupBy":["host"],"interval":300,"message":">等级：{status}  \n>主机：{host}  \n>内容：主机 SSH 状态 {{ Result |  to_fixed(2) }}%  \n>建议：检查主机 SSH 服务状态","noDataMessage":"","noDataTitle":"","recoverNeedPeriodCount":2,"targets":[{"alias":"Result","dql":"M::`ssh`:(count(`ssh_check`)) BY `host`","qtype":"dql"}],"title":"主机 {{ host }} SSH 服务异常","type":"simpleCheck"},"monitorName":"default","secret":"","tagInfo":[],"type":"trigger"}]}' \
--compressed 
```

## Response
```shell
{
    "code": 200,
    "content": {
        "rule": [
            {
                "createAt": 1642581539.6646779,
                "creator": "wsak_xxxxx",
                "crontabInfo": {
                    "crontab": "*/1 * * * *",
                    "id": "cron-ABxzYMCHK2kj"
                },
                "deleteAt": -1,
                "extend": {
                    "funcName": "",
                    "noDataInterval": null,
                    "querylist": [
                        {
                            "datasource": "dataflux",
                            "qtype": "dql",
                            "query": {
                                "alias": "",
                                "code": "Result",
                                "dataSource": "aliyun_acs_rds_dashboard",
                                "field": "MySQL_SlowQueries_Average",
                                "fieldFunc": "last",
                                "fieldType": "float",
                                "funcList": [],
                                "groupBy": [
                                    "instanceId"
                                ],
                                "groupByTime": "",
                                "namespace": "metric",
                                "q": "M::`aliyun_acs_rds_dashboard`:(LAST(`MySQL_SlowQueries_Average`))  BY `instanceId`",
                                "type": "simple"
                            },
                            "uuid": "b7f8af85-0b3b-452c-b4d9-4f2cd175a4d4"
                        }
                    ],
                    "recoverNeedPeriodCount": 1,
                    "rules": [
                        {
                            "conditionLogic": "and",
                            "conditions": [
                                {
                                    "alias": "Result",
                                    "operands": [
                                        "10"
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
                                        "5",
                                        "10"
                                    ],
                                    "operator": "between"
                                }
                            ],
                            "status": "error"
                        },
                        {
                            "conditionLogic": "and",
                            "conditions": [
                                {
                                    "alias": "Result",
                                    "operands": [],
                                    "operator": ">="
                                }
                            ],
                            "status": "warning"
                        }
                    ]
                },
                "id": null,
                "jsonScript": {
                    "checkerOpt": {
                        "rules": [
                            {
                                "conditionLogic": "and",
                                "conditions": [
                                    {
                                        "alias": "Result",
                                        "operands": [
                                            "10"
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
                                            "5",
                                            "10"
                                        ],
                                        "operator": "between"
                                    }
                                ],
                                "status": "error"
                            }
                        ]
                    },
                    "every": "1m",
                    "groupBy": [
                        "instanceId"
                    ],
                    "interval": 300,
                    "message": ">等级：{df_status}  \n>实例：{instanceId}  \n>内容：RDS Mysql 每秒慢查询数为 {{ Result }}%  \n>建议：登录阿里云控制台查看 RDS 是否有异常",
                    "name": "Alibaba Cloud RDS Mysql 每秒慢查询数过高",
                    "noDataInterval": 0,
                    "recoverNeedPeriodCount": 1,
                    "targets": [
                        {
                            "alias": "Result",
                            "dql": "M::`aliyun_acs_rds_dashboard`:(LAST(`MySQL_SlowQueries_Average`))  BY `instanceId`"
                        }
                    ],
                    "title": "Alibaba Cloud RDS Mysql 实例 ID 为 {instanceId} 每秒慢查询数过高",
                    "type": "simpleCheck"
                },
                "monitorUUID": "monitor_xxxx32",
                "status": 0,
                "type": "trigger",
                "updateAt": 1642581539.6647239,
                "updator": "",
                "uuid": "rul_xxxx32",
                "workspaceUUID": "wksp_xxxx32"
            }
        ]
    },
    "errorCode": "",
    "message": "",
    "success": true,
    "traceId": "TRACE-8A8119CE-4EFA-4278-B3EF-33F29EDB38CE"
}
```