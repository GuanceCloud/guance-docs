# Get Checker List

---

<br />**GET /api/v1/checker/list**

## Overview
Paginate and list the checker items


## Query Request Parameters

| Parameter Name        | Type     | Required   | Description              |
|:-------------------|:-------|:-----|:----------------|
| type | string | No | List checkers, pass `smartMonitor` for intelligent monitoring.<br>Allow null: False <br>Allow empty string: False <br>Optional values: ['smartMonitor'] <br> |
| monitorUUID | commaArray | No | Monitor group UUID<br>Allow null: False <br> |
| alertPolicyUUID | commaArray | No | Alert policy UUID<br>Allow null: False <br> |
| checkerUUID | commaArray | No | Checker UUID list<br>Allow null: False <br> |
| sloUUID | string | No | SLO's UUID<br>Allow null: False <br> |
| search | string | No | Search rule name<br>Allow null: False <br> |
| pageIndex | integer | No | Page number<br>Allow null: False <br>Example: 1 <br>$minValue: 1 <br> |
| pageSize | integer | No | Number of results per page<br>Allow null: False <br>Example: 10 <br>$minValue: 1 <br>$maxValue: 100 <br> |

## Additional Parameter Notes



## Request Example
```shell
curl 'https://openapi.guance.com/api/v1/checker/list?pageIndex=1&pageSize=2' \
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
                "message": ">等级：{df_status}  \n>实例：{instanceId}  \n>内容：RDS Mysql 磁盘使用率为 {{ Result |  to_fixed(2) }}%  \n>建议：登录阿里云控制台查看 RDS 是否有异常",
                "name": "AliCloud RDS Mysql Disk Usage Too High",
                "noDataInterval": 0,
                "recoverNeedPeriodCount": 1,
                "targets": [
                    {
                        "alias": "Result",
                        "dql": "M::`aliyun_acs_rds_dashboard`:(LAST(`DiskUsage_Average`))  BY `instanceId`"
                    }
                ],
                "title": "AliCloud RDS Mysql Instance ID {instanceId} Disk Usage Too High",
                "type": "simpleCheck"
            },
            "monitorName": "AliCloud RDS Mysql Monitoring Database",
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

### Translation Notes:
- "观测云" is translated as "Guance".
- "监控器" is translated as "checker".
- Specific terms like "智能监控" are translated according to the provided dictionary.