# Get Checker List

---

<br />**GET /api/v1/checker/list**

## Overview
Lists checkers in pages.

## Query Request Parameters

| Parameter Name        | Type     | Required   | Description              |
|:------------------|:-------|:-----|:----------------|
| type | string | No | Lists checkers, specify `smartMonitor` for intelligent monitoring.<br>Allow null: False <br>Allow empty string: False <br>Optional values: ['smartMonitor'] <br> |
| monitorUUID | commaArray | No | Monitor group UUID.<br>Allow null: False <br> |
| alertPolicyUUID | commaArray | No | Alert policy UUID.<br>Allow null: False <br> |
| checkerUUID | commaArray | No | Checker UUID list.<br>Allow null: False <br> |
| sloUUID | string | No | SLO UUID.<br>Allow null: False <br> |
| search | string | No | Search rule name.<br>Allow null: False <br> |
| pageIndex | integer | No | Page number.<br>Allow null: False <br>Example: 1 <br>$minValue: 1 <br> |
| pageSize | integer | No | Number of items per page.<br>Allow null: False <br>Example: 10 <br>$minValue: 1 <br>$maxValue: 100 <br> |

## Additional Parameter Notes

## Request Example
```shell
curl 'https://openapi.<<< custom_key.brand_main_domain >>>/api/v1/checker/list?pageIndex=1&pageSize=2' \
-H 'DF-API-KEY: <DF-API-KEY>' \
--compressed 
```

## Response
```shell
{
    "code": 200,
    "content": [
        {
            "createAt": 1642412816,
            "creator": "acnt_xxxx32",
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
                "message": ">Level: {df_status}  \n>Instance: {instanceId}  \n>Content: RDS Mysql disk usage is {{ Result |  to_fixed(2) }}%  \n>Suggestion: Log in to the Alibaba Cloud console to check if there are any anomalies with RDS",
                "name": "Alibaba Cloud RDS Mysql Disk Usage Too High",
                "noDataInterval": 0,
                "recoverNeedPeriodCount": 1,
                "targets": [
                    {
                        "alias": "Result",
                        "dql": "M::`aliyun_acs_rds_dashboard`:(LAST(`DiskUsage_Average`))  BY `instanceId`"
                    }
                ],
                "title": "Alibaba Cloud RDS Mysql Instance ID {instanceId} Disk Usage Too High",
                "type": "simpleCheck"
            },
            "monitorName": "Alibaba Cloud RDS Mysql Monitoring Database",
            "monitorUUID": "monitor_xxxx32",
            "status": 0,
            "type": "trigger",
            "updateAt": 1642412816,
            "updator": "",
            "uuid": "rul_xxxx32",
            "workspaceUUID": "wksp_xxxx32"
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