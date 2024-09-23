# 获取告警策略列表

---

<br />**GET /api/v1/alert_policy/list**

## 概述
分页获取告警策略列表




## Query 请求参数

| 参数名        | 类型     | 必选   | 说明              |
|:-----------|:-------|:-----|:----------------|
| search | string |  | 搜索告警策略名称<br>允许为空: True <br> |
| pageIndex | integer |  | 页码<br>允许为空: False <br>例子: 1 <br>$minValue: 1 <br> |
| pageSize | integer |  | 每页返回数量<br>允许为空: False <br>例子: 10 <br>$minValue: 1 <br>$maxValue: 100 <br> |

## 参数补充说明





## 请求例子
```shell
curl 'https://openapi.guance.com/api/v1/alert_policy/list?pageIndex=1&pageSize=10' \
-H 'DF-API-KEY: <DF-API-KEY>' \
--compressed
```




## 响应
```shell
{
    "code": 200,
    "content": {
        "data": [
            {
                "alertOpt": {
                    "aggFields": [
                        "df_monitor_checker_id"
                    ],
                    "aggInterval": 120,
                    "alertTarget": [
                        {
                            "targets": [
                                {
                                    "status": "warning",
                                    "to": [
                                        "notify_xxx99e"
                                    ]
                                }
                            ]
                        }
                    ],
                    "silentTimeout": 21600
                },
                "createAt": 1706152082,
                "creator": "xx",
                "creatorInfo": {
                    "uuid": "xx",
                    "status": 0,
                    "username": "xx",
                    "name": "xx",
                    "iconUrl": "",
                    "email": "xx",
                    "acntWsNickname": "xx"
                },
                "deleteAt": -1,
                "id": 4100,
                "name": "jj_modify",
                "refCountInfo": {},
                "ruleCount": 0,
                "ruleTimezone": "Asia/Shanghai",
                "score": 0,
                "status": 0,
                "updateAt": 1706152340,
                "updator": "xx",
                "updatorInfo": {
                    "uuid": "xx",
                    "status": 0,
                    "username": "xx",
                    "name": "xx",
                    "iconUrl": "",
                    "email": "xx",
                    "acntWsNickname": "xx"
                },
                "uuid": "altpl_xxxc11",
                "workspaceUUID": "wksp_xxxa4b"
            }
        ],
        "declaration": {}
    },
    "errorCode": "",
    "message": "",
    "pageInfo": {
        "count": 1,
        "pageIndex": 1,
        "pageSize": 10,
        "totalCount": 1
    },
    "success": true,
    "traceId": "TRACE-6E1F1053-C2FF-4FAD-95FC-3108AFB9BD51"
} 
```




