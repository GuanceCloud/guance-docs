# 获取监控器列表

---

<br />**GET /api/v1/checker/list**

## 概述
分页列出监控器列表




## Query 请求参数

| 参数名        | 类型     | 必选   | 说明              |
|:-----------|:-------|:-----|:----------------|
| type | string |  | 列出监控器,列出智能监控传参为 smartMonitor<br>允许为空: False <br>允许为空字符串: False <br>可选值: ['smartMonitor'] <br> |
| monitorUUID | commaArray |  | 监视器分组UUID<br>允许为空: False <br> |
| alertPolicyUUID | commaArray |  | 告警策略UUID<br>允许为空: False <br> |
| checkerUUID | commaArray |  | 检查项UUID列表<br>允许为空: False <br> |
| sloUUID | string |  | SLO的UUID<br>允许为空: False <br> |
| search | string |  | 搜索规则名<br>允许为空: False <br> |
| pageIndex | integer |  | 页码<br>允许为空: False <br>例子: 1 <br>$minValue: 1 <br> |
| pageSize | integer |  | 每页返回数量<br>允许为空: False <br>例子: 10 <br>$minValue: 1 <br>$maxValue: 100 <br> |

## 参数补充说明





## 请求例子
```shell
curl 'https://openapi.<<< custom_key.brand_main_domain >>>/api/v1/checker/list?pageIndex=1&pageSize=2' \
-H 'DF-API-KEY: <DF-API-KEY>' \
--compressed 
```




## 响应
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




