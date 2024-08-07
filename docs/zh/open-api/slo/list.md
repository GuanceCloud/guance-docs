# 列出工作空间下 SLO

---

<br />**GET /api/v1/slo/list**

## 概述




## Query 请求参数

| 参数名        | 类型     | 必选   | 说明              |
|:-----------|:-------|:-----|:----------------|
| refSli | string |  | 指定 SLI UUID，返回包含该 SLI 的 SLO<br>允许为空: True <br> |
| search | string |  | SLO 名称<br>允许为空: True <br> |
| pageIndex | integer |  | 页码<br>允许为空: False <br>例子: 1 <br>$minValue: 1 <br> |
| pageSize | integer |  | 每页返回数量<br>允许为空: False <br>例子: 10 <br>$minValue: 1 <br>$maxValue: 10000 <br> |

## 参数补充说明





## 请求例子
```shell
curl 'https://openapi.guance.com/api/v1/slo/list?pageIndex=1&pageSize=2' \
-H 'Content-Type: application/json' \
-H 'DF-API-KEY: <DF-API-KEY>' \
```




## 响应
```shell
{
    "code": 200,
    "content": {
        "data": [
            {
                "alertPolicyInfos": [
                    {
                        "name": "lwc SLO 转告警策略测试",
                        "uuid": "altpl_xxxx"
                    }
                ],
                "config": {
                    "checkRange": 604800,
                    "describe": "LWC测试OpenAPI",
                    "goal": 90.0,
                    "interval": "10m",
                    "minGoal": 60.0,
                    "sli_infos": [
                        {
                            "id": "rul_9eb74xxxxx",
                            "name": "whytest-反馈问题验证",
                            "status": 2
                        },
                        {
                            "id": "rul_7a88xxxxx",
                            "name": "lml-tes",
                            "status": 0
                        }
                    ]
                },
                "createAt": 1722913524,
                "creator": "wsak_a2d55c91bxxxxx",
                "deleteAt": -1,
                "id": 4901,
                "name": "LWC-Test-2024-08-06-002",
                "score": 0,
                "status": 0,
                "tagInfo": [],
                "type": "slo",
                "updateAt": -1,
                "updator": "",
                "uuid": "monitor_5ebbxxxxxx",
                "workspaceUUID": "wksp_4b57c7babxxxxxx"
            },
            {
                "alertPolicyInfos": [],
                "config": {
                    "checkRange": 604800,
                    "describe": "",
                    "goal": 99.0,
                    "interval": "5m",
                    "minGoal": 90.0,
                    "sli_infos": [
                        {
                            "id": "rul_7a88xxxxx",
                            "name": "lml-tes",
                            "status": 0
                        }
                    ]
                },
                "createAt": 1722913303,
                "creator": "acnt_35be770xxxxxx",
                "deleteAt": -1,
                "id": 4899,
                "name": "lml-test3",
                "score": 0,
                "status": 0,
                "tagInfo": [],
                "type": "slo",
                "updateAt": 1722913478,
                "updator": "acnt_35be770xxxxxx",
                "uuid": "monitor_7d0662bexxxxx",
                "workspaceUUID": "wksp_4b57c7babxxxxxx"
            }
        ],
        "declaration": {
            "asd": "aa,bb,cc,1,True",
            "asdasd": "dawdawd",
            "business": "aaa",
            "fawf": "afawf",
            "organization": "xxxxxx"
        }
    },
    "errorCode": "",
    "message": "",
    "pageInfo": {
        "count": 2,
        "pageIndex": 1,
        "pageSize": 2,
        "totalCount": 43
    },
    "success": true,
    "traceId": "10111844508613776745"
} 
```




