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
curl 'https://openapi.guance.com/api/v1/slo/list' \
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
                "alertOpt": {
                    "alertTarget": [
                        {
                            "status": [
                                "critical",
                                "error",
                                "warning"
                            ],
                            "to": [
                                "notify_fbfb8b0920c34837ac3d3c24017004a0"
                            ]
                        }
                    ],
                    "silentTimeout": 3600
                },
                "config": {
                    "checkRange": 604800,
                    "describe": "1",
                    "goal": 90.0,
                    "interval": "5m",
                    "minGoal": 60.0,
                    "sli_infos": [
                        {
                            "id": "rul_c74d7ca2d1334cae997e1fa17fd1e6ee",
                            "name": "突变-带触发前提条件 检测值 result: {{Result}}",
                            "status": 0
                        }
                    ]
                },
                "createAt": 1706357265,
                "creator": "acnt_349ee5f70a89442fa94b4f754b5acbfe",
                "deleteAt": -1,
                "id": 4184,
                "name": "slo-demo",
                "score": 0,
                "status": 0,
                "type": "slo",
                "updateAt": 1706357265,
                "updator": "acnt_349ee5f70a89442fa94b4f754b5acbfe",
                "uuid": "monitor_9c8874be22a74c35b88c9cc9c01181cb",
                "workspaceUUID": "wksp_4b57c7bab38e4a2d9630f675dc20015d"
            },
            {
                "alertOpt": {
                    "alertTarget": [
                        {
                            "status": [
                                "critical",
                                "error",
                                "warning"
                            ],
                            "to": [
                                "notify_70377542c47c455f8fe2791c2f32a3f7"
                            ]
                        }
                    ],
                    "silentTimeout": 3600
                },
                "config": {
                    "checkRange": 604800,
                    "describe": "",
                    "goal": 90.0,
                    "interval": "5m",
                    "minGoal": 80.0,
                    "sli_infos": [
                        {
                            "id": "rul_27ec98d3251d485c8656059e619d926b",
                            "name": "20240118",
                            "status": 2
                        }
                    ]
                },
                "createAt": 1706166301,
                "creator": "acnt_27f0489732c344beb2d5b3078bbe3dc0",
                "deleteAt": -1,
                "id": 4178,
                "name": "slo-demo2",
                "score": 0,
                "status": 2,
                "type": "slo",
                "updateAt": 1706176602,
                "updator": "acnt_349ee5f70a89442fa94b4f754b5acbfe",
                "uuid": "monitor_aa01439d20b9447e9874e5882966df01",
                "workspaceUUID": "wksp_4b57c7bab38e4a2d9630f675dc20015d"
            }
        ],
        "declaration": {
            "b": [
                "asfawfgajfasfafgafwba",
                "asfgahjfaf"
            ],
            "business": "aaa",
            "organization": "6540c09e4243b300077a9675"
        }
    },
    "errorCode": "",
    "message": "",
    "pageInfo": {
        "count": 2,
        "pageIndex": 1,
        "pageSize": 100,
        "totalCount": 2
    },
    "success": true,
    "traceId": "TRACE-7990B78C-6F35-4A99-AF41-4BCD9AFBDF9D"
} 
```




