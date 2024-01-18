# 导出一个/多个监控器

---

<br />**POST /api/v1/checker/export**

## 概述
根据指定的检查器UUID列表导出一个/多个监控器配置




## Body 请求参数

| 参数名        | 类型     | 必选   | 说明              |
|:-----------|:-------|:-----|:----------------|
| checkers | array | Y | checker_uuid数组<br>允许为空: False <br> |

## 参数补充说明





## 请求例子
```shell
curl 'https://openapi.guance.com/api/v1/checker/export' \
-H 'DF-API-KEY: <DF-API-KEY>' \
-H 'Content-Type: application/json;charset=UTF-8' \
--data-raw '{"checkers": ["rul_f61a4470adf34d6789184979dab61147", "rul_6b1427d9c3a8430fbcd691b79381cbe9"]}' \
--compressed 
```




## 响应
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
                "monitorName": "阿里云 RDS Mysql 检测库"
            }
        ]
    },
    "errorCode": "",
    "message": "",
    "success": true,
    "traceId": "TRACE-80D11C67-BFB0-4040-8670-0237C9E0AA0E"
} 
```




