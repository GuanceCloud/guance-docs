# 导入一个/多个监控器

---

<br />**POST /api/v1/checker/import**

## 概述
导入一个/多个监控器配置




## Body 请求参数

| 参数名        | 类型     | 必选   | 说明              |
|:-----------|:-------|:-----|:----------------|
| checkers | array | Y | 规则配置列表<br>允许为空: False <br> |
| type | string |  | 智能监控导入传参 smartMonitor, 默认 为普通监控器 trigger<br>允许为空: False <br>允许为空字符串: False <br>可选值: ['smartMonitor', 'trigger'] <br> |
| skipRepeatNameCheck | boolean |  | 是否跳过重名检测, false进行重名检测, true为跳过重名检测<br>例子: False <br>允许为空: False <br> |
| skipRepeatNameCreate | boolean |  | true同名跳过创建, 不同名的直接创建, false创建所有导入信息<br>例子: False <br>允许为空: False <br> |

## 参数补充说明


** 监控器模板配置，参见【监控器导出接口】**


*相关参数说明.*
返回结果content中存在repeat_name,表示存在同名,添加参数skipRepeatNameCreate选择跳过或同名创建

| 参数名 | type| 必传 | 说明|
| :---- | :-- | :--- | :------- |
| checker   | array | 必传 | 规则配置列表|
| skipRepeatNameCheck   | boolean | 必传 | 是否跳过重名检测, 如不跳过（false）：同名检测不通过则返回同名监控器名称列表 |
| skipRepeatNameCreate  | boolean | 必传 | 同名是否跳过创建，如不跳过（false）：则会创建相同名称的监控器|




## 请求例子
```shell
curl 'https://openapi.<<< custom_key.brand_main_domain >>>/api/v1/checker/import' \
-H 'DF-API-KEY: <DF-API-KEY>' \
-H 'Content-Type: application/json;charset=UTF-8' \
--data-raw '{"checkers":[{"extend":{"funcName":"","isNeedCreateIssue":false,"issueLevelUUID":"","needRecoverIssue":false,"querylist":[{"datasource":"dataflux","qtype":"dql","query":{"alias":"","code":"Result","dataSource":"ssh","field":"ssh_check","fieldFunc":"count","fieldType":"float","funcList":[],"groupBy":["host"],"groupByTime":"","namespace":"metric","q":"M::`ssh`:(count(`ssh_check`)) BY `host`","type":"simple"},"uuid":"aada629a-672e-46f9-9503-8fd61065c382"}],"rules":[{"conditionLogic":"and","conditions":[{"alias":"Result","operands":["90"],"operator":">="}],"status":"critical"},{"conditionLogic":"and","conditions":[{"alias":"Result","operands":["0"],"operator":">="}],"status":"error"}]},"is_disable":false,"jsonScript":{"atAccounts":[],"atNoDataAccounts":[],"channels":[],"checkerOpt":{"infoEvent":false,"rules":[{"conditionLogic":"and","conditions":[{"alias":"Result","operands":["90"],"operator":">="}],"status":"critical"},{"conditionLogic":"and","conditions":[{"alias":"Result","operands":["0"],"operator":">="}],"status":"error"}]},"disableCheckEndTime":false,"every":"1m","groupBy":["host"],"interval":300,"message":">等级：{{status}}  \n>主机：{{host}}  \n>内容：主机 SSH 状态 {{ Result |  to_fixed(2) }}%  \n>建议：检查主机 SSH 服务状态","noDataMessage":"","noDataTitle":"","recoverNeedPeriodCount":2,"targets":[{"alias":"Result","dql":"M::`ssh`:(count(`ssh_check`)) BY `host`","qtype":"dql"}],"title":"主机 {{ host }} SSH 服务异常","type":"simpleCheck"},"monitorName":"default","secret":"","tagInfo":[],"type":"trigger"}]}' \
--compressed 
```




## 响应
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




