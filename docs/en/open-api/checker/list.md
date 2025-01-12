# Get a List of Monitors

---

<br />**get /api/v1/monitor/check/list**

## Overview
List monitors in pages.




## Query Request Parameter

| Parameter Name        | Type     | Required   | Description              |
|:-----------|:-------|:-----|:----------------|
| monitorUUID | commaArray |  | Monitor UUID<br>Allow null: False <br> |
| checkerUUID | commaArray |  | Check item UUID list<br>Allow null: False <br> |
| sloUUID | string |  | SLO的UUID<br>Allow null: False <br> |
| search | string |  | Search rule name<br>Allow null: False <br> |
| pageIndex | integer |  | Page number<br>Allow null: False <br>Example: 1 <br>$minValue: 1 <br> |
| pageSize | integer |  | Quantity returned per page<br>Allow null: False <br>Example: 10 <br>$minValue: 1 <br>$maxValue: 100 <br> |

## Supplementary Description of Parameters





## Request Example
```shell
curl 'https://openapi.guance.com/api/v1/monitor/check/list?pageIndex=1&pageSize=2' \
-H 'DF-API-KEY: <DF-API-KEY>' \
--compressed \
--insecure
```




## Response
```shell
{
    "code": 200,
    "content": [
        {
            "createAt": 1642412816,
            "creator": "acnt_a5d6130c19524a6b9fe91d421eaf8603",
            "crontabInfo": {
                "crontab": "*/1 * * * *",
                "id": "cron-h0vvCCHAQMij"
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
                            "field": "DiskUsage_Average",
                            "fieldFunc": "last",
                            "fieldType": "float",
                            "funcList": [],
                            "groupBy": [
                                "instanceId"
                            ],
                            "groupByTime": "",
                            "namespace": "metric",
                            "q": "M::`aliyun_acs_rds_dashboard`:(LAST(`DiskUsage_Average`))  BY `instanceId`",
                            "type": "simple"
                        },
                        "uuid": "4bea6e00-317f-4cb8-9c3b-64bc3fd70d73"
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
                                    "80",
                                    "90"
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
            "id": 4216,
            "isSLI": false,
            "jsonScript": {
                "checkerOpt": {
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
                                        "80",
                                        "90"
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
                "message": ">等级：{{df_status}}  \n>实例：{{instanceId}}  \n>内容：RDS Mysql 磁盘使用率为 {{ Result |  to_fixed(2) }}%  \n>建议：登录阿里云控制台查看 RDS 是否有异常",
                "name": "阿里云 RDS Mysql 磁盘使用率过高",
                "noDataInterval": 0,
                "recoverNeedPeriodCount": 1,
                "targets": [
                    {
                        "alias": "Result",
                        "dql": "M::`aliyun_acs_rds_dashboard`:(LAST(`DiskUsage_Average`))  BY `instanceId`"
                    }
                ],
                "title": "阿里云 RDS Mysql 实例 ID 为 {{instanceId}} 磁盘使用率过高",
                "type": "simpleCheck"
            },
            "monitorName": "阿里云 RDS Mysql 检测库",
            "monitorUUID": "monitor_84cbb7c18f964771b8153fbca1013615",
            "status": 0,
            "type": "trigger",
            "updateAt": 1642412816,
            "updator": "",
            "uuid": "rul_f9f6fbbf41844671b7e5c37791c8cca4",
            "workspaceUUID": "wksp_2dc431d6693711eb8ff97aeee04b54af"
        }
    ],
    "errorCode": "",
    "message": "",
    "pageInfo": {
        "count": 1,
        "pageIndex": 2,
        "pageSize": 1,
        "totalCount": 42
    },
    "success": true,
    "traceId": "TRACE-F9E5478C-D157-4CD0-883D-2B2E7AE5A50F"
} 
```




