# Export One or Multiple Checkers

---

<br />**POST /api/v1/checker/export**

## Overview
Export the configuration of one or multiple checkers based on the specified checker UUID list.

## Body Request Parameters

| Parameter Name | Type   | Required | Description              |
|:--------------|:-------|:---------|:-------------------------|
| checkers      | array  | Y        | Array of checker_uuids<br>Allow empty: False <br> |

## Additional Parameter Notes

**Related API: Import One or Multiple Checkers**

The `checkers` parameter in the import checkers API is the content of `content.checkers` returned by the successful export of checkers.


## Request Example
```shell
curl 'https://openapi.<<< custom_key.brand_main_domain >>>/api/v1/checker/export' \
-H 'DF-API-KEY: <DF-API-KEY>' \
-H 'Content-Type: application/json;charset=UTF-8' \
--data-raw '{"checkers": ["rul_xxxx32", "rul_xxxx32"]}' \
--compressed 
```


## Response
```shell
{
    "code": 200,
    "content": {
        "checkers": [
            {
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
                "is_disable": false,
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
                    "message": ">Level: {df_status}  \n>Instance: {instanceId}  \n>Content: RDS Mysql slow queries per second is {{ Result }}%  \n>Suggestion: Log in to Alibaba Cloud console to check if there are any abnormalities with RDS",
                    "name": "Alibaba Cloud RDS Mysql Slow Queries per Second Too High",
                    "noDataInterval": 0,
                    "recoverNeedPeriodCount": 1,
                    "targets": [
                        {
                            "alias": "Result",
                            "dql": "M::`aliyun_acs_rds_dashboard`:(LAST(`MySQL_SlowQueries_Average`))  BY `instanceId`"
                        }
                    ],
                    "title": "Alibaba Cloud RDS Mysql Instance ID {instanceId} Slow Queries per Second Too High",
                    "type": "simpleCheck"
                },
                "monitorName": "Alibaba Cloud RDS Mysql Monitoring Database"
            }
        ]
    },
    "errorCode": "",
    "message": "",
    "success": true,
    "traceId": "TRACE-80D11C67-BFB0-4040-8670-0237C9E0AA0E"
} 
```