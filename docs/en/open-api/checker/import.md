# Import One/More Monitors

---

<br />**post /api/v1/monitor/check/import**

## Overview
Import one/more monitor configurations.




## Body Request Parameter

| Parameter Name        | Type     | Required   | Description              |
|:-----------|:-------|:-----|:----------------|
| checkers | array | Y | Rule configuration list<br>Allow null: False <br> |
| uChoose | string |  | User selection action<br>Allow null: False <br>Optional value: ['rewrite', 'skip'] <br> |

## Supplementary Description of Parameters


**For monitor template configuration, see "Monitor Export Interface"**.




## Request Example
```shell
curl 'https://openapi.guance.com/api/v1/monitor/check/import' \
-H 'DF-API-KEY: <DF-API-KEY>' \
-H 'Content-Type: application/json;charset=UTF-8' \
--data-raw '{"checkers": [{"extend": {"funcName": "", "noDataInterval": null, "querylist": [{"datasource": "dataflux", "qtype": "dql", "query": {"alias": "", "code": "Result", "dataSource": "aliyun_acs_rds_dashboard", "field": "IOPSUsage_Average", "fieldFunc": "last", "fieldType": "float", "funcList": [], "groupBy": ["instanceId"], "groupByTime": "", "namespace": "metric", "q": "M::`aliyun_acs_rds_dashboard`:(LAST(`IOPSUsage_Average`))  BY `instanceId`", "type": "simple"}, "uuid": "7d4f9ff1-5f7f-4cdb-85c2-9b8f0dd8ceed"}], "recoverNeedPeriodCount": 1, "rules": [{"conditionLogic": "and", "conditions": [{"alias": "Result", "operands": ["90"], "operator": ">="}], "status": "critical"}, {"conditionLogic": "and", "conditions": [{"alias": "Result", "operands": ["80", "90"], "operator": "between"}], "status": "error"}, {"conditionLogic": "and", "conditions": [{"alias": "Result", "operands": [], "operator": ">="}], "status": "warning"}]}, "is_disable": false, "jsonScript": {"checkerOpt": {"rules": [{"conditionLogic": "and", "conditions": [{"alias": "Result", "operands": ["90"], "operator": ">="}], "status": "critical"}, {"conditionLogic": "and", "conditions": [{"alias": "Result", "operands": ["80", "90"], "operator": "between"}], "status": "error"}]}, "every": "1m", "groupBy": ["instanceId"], "interval": 300, "message": ">等级：{{df_status}}  \n>实例：{{instanceId}}  \n>内容：RDS Mysql IOPS 使用率为 {{ Result |  to_fixed(2) }}%  \n>建议：登录阿里云控制台查看 RDS 是否有异常", "name": "阿里云 RDS Mysql IOPS 使用率过高", "noDataInterval": 0, "recoverNeedPeriodCount": 1, "targets": [{"alias": "Result", "dql": "M::`aliyun_acs_rds_dashboard`:(LAST(`IOPSUsage_Average`))  BY `instanceId`"}], "title": "阿里云 RDS Mysql 实例 ID 为 {{instanceId}} IOPS 使用率过高", "type": "simpleCheck"}, "monitorName": "BmUgtnAV"}, {"extend": {"funcName": "", "noDataInterval": null, "querylist": [{"datasource": "dataflux", "qtype": "dql", "query": {"alias": "", "code": "Result", "dataSource": "df_celery", "field": "events_total", "fieldFunc": "last", "fieldType": "float", "funcList": [], "groupBy": ["worker"], "groupByTime": "", "namespace": "metric", "q": "M::`df_celery`:(LAST(`events_total`)) BY `worker`", "type": "simple"}, "uuid": "1fae3947-1f0b-4b9b-8b30-654546d15cde"}], "recoverNeedPeriodCount": null, "rules": [{"conditionLogic": "and", "conditions": [{"alias": "Result", "operands": ["50"], "operator": ">="}], "status": "critical"}, {"conditionLogic": "and", "conditions": [{"alias": "Result", "operands": ["30"], "operator": ">="}], "status": "error"}, {"conditionLogic": "and", "conditions": [{"alias": "Result", "operands": [], "operator": ">="}], "status": "warning"}]}, "is_disable": false, "jsonScript": {"checkerOpt": {"rules": [{"conditionLogic": "and", "conditions": [{"alias": "Result", "operands": ["50"], "operator": ">="}], "status": "critical"}, {"conditionLogic": "and", "conditions": [{"alias": "Result", "operands": ["30"], "operator": ">="}], "status": "error"}]}, "every": "1m", "groupBy": ["worker"], "interval": 300, "message": "超过{{ Result }}", "name": "测试用的", "noDataInterval": 0, "recoverNeedPeriodCount": 0, "targets": [{"alias": "Result", "dql": "M::`df_celery`:(LAST(`events_total`)) BY `worker`"}], "title": "df_celery触发", "type": "simpleCheck"}, "monitorName": "BmUgtnAV"}], "uChoose": "skip"}' \
--compressed \
--insecure
```




## Response
```shell
{
    "code": 200,
    "content": {
        "rule": [
            {
                "createAt": 1642581539.6646779,
                "creator": "wsak_9c2d4d998d9548949ce05680552254af",
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
                    "message": ">等级：{{df_status}}  \n>实例：{{instanceId}}  \n>内容：RDS Mysql 每秒慢查询数为 {{ Result }}%  \n>建议：登录阿里云控制台查看 RDS 是否有异常",
                    "name": "阿里云 RDS Mysql 每秒慢查询数过高",
                    "noDataInterval": 0,
                    "recoverNeedPeriodCount": 1,
                    "targets": [
                        {
                            "alias": "Result",
                            "dql": "M::`aliyun_acs_rds_dashboard`:(LAST(`MySQL_SlowQueries_Average`))  BY `instanceId`"
                        }
                    ],
                    "title": "阿里云 RDS Mysql 实例 ID 为 {{instanceId}} 每秒慢查询数过高",
                    "type": "simpleCheck"
                },
                "monitorUUID": "monitor_84cbb7c18f964771b8153fbca1013615",
                "status": 0,
                "type": "trigger",
                "updateAt": 1642581539.6647239,
                "updator": "",
                "uuid": "rul_f630a344df6c44a0a6f61b22752c6cd9",
                "workspaceUUID": "wksp_2dc431d6693711eb8ff97aeee04b54af"
            }
        ]
    },
    "errorCode": "",
    "message": "",
    "success": true,
    "traceId": "TRACE-8A8119CE-4EFA-4278-B3EF-33F29EDB38CE"
} 
```




