# Get the list of monitors

---

<br />**GET /api/v1/checker/list**

## Overview
List the monitors with pagination




## Query Request Parameters

| Parameter Name        | Type     | Required   | Description              |
|:---------------------|:---------|:-----------|:------------------------|
| type | string |  | List monitors, pass 'smartMonitor' for listing intelligent monitoring <br>Can be empty: False <br>Can be an empty string: False <br>Optional values: ['smartMonitor'] <br> |
| monitorUUID | commaArray |  | Monitor group UUID <br>Can be empty: False <br> |
| alertPolicyUUID | commaArray |  | Alert strategy UUID <br>Can be empty: False <br> |
| checkerStatus | commaArray |  | Monitor status, 0 means enabled, 2 means disabled (default query both enabled/disabled 0,2) <br>Example: 0 <br>Can be empty: False <br> |
| checkerUUID | commaArray |  | Checker UUID list <br>Can be empty: False <br> |
| sloUUID | string |  | SLO UUID <br>Can be empty: False <br> |
| search | string |  | Search rule name <br>Can be empty: False <br> |
| pageIndex | integer |  | Page number <br>Can be empty: False <br>Example: 1 <br>$minValue: 1 <br> |
| pageSize | integer |  | Number of items returned per page <br>Can be empty: False <br>Example: 10 <br>$minValue: 1 <br>$maxValue: 100 <br> |

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
                "message": ">Level: {df_status}  \n>Instance: {instanceId}  \n>Content: The disk usage rate of RDS Mysql is {{ Result |  to_fixed(2) }}%  \n>Suggestion: Log in to the Alibaba Cloud console and check if there are any exceptions in RDS",
                "name": "The disk usage rate of Alibaba Cloud RDS Mysql is too high",
                "noDataInterval": 0,
                "recoverNeedPeriodCount": 1,
                "targets": [
                    {
                        "alias": "Result",
                        "dql": "M::`aliyun_acs_rds_dashboard`:(LAST(`DiskUsage_Average`))  BY `instanceId`"
                    }
                ],
                "title": "The disk usage rate of the Alibaba Cloud RDS Mysql instance ID {instanceId} is too high",
                "type": "simpleCheck"
            },
            "monitorName": "Alibaba Cloud RDS Mysql detection library",
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