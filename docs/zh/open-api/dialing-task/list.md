# 获取拨测任务列表

---

<br />**GET /api/v1/dialing_task/list**

## 概述




## Query 请求参数

| 参数名        | 类型     | 必选   | 说明              |
|:-----------|:-------|:-----|:----------------|
| pageIndex | integer |  | 页码<br>允许为空: False <br>例子: 1 <br>$minValue: 1 <br> |
| pageSize | integer |  | 每页返回数量<br>允许为空: False <br>例子: 10 <br>$minValue: 1 <br> |
| type | string |  | 拨测的类型<br>允许为空: False <br>可选值: ['http', 'browser', 'tcp', 'icmp', 'websocket'] <br> |
| search | string |  | 拨测名称<br>允许为空: False <br> |
| dialingTypes | commaArray |  | 拨测类型(http, browser, tcp, icmp, websocket)<br>允许为空: False <br> |
| dialingStatus | commaArray |  | 拨测状态(ok, stop)<br>允许为空: False <br> |
| tagsUUID | commaArray |  | 标签UUID<br>允许为空: False <br> |
| frequency | commaArray |  | 拨测频率(1m, 5m, 15m, 30m, 1h, 6h, 12h, 24h)<br>允许为空: False <br> |

## 参数补充说明





## 请求例子
```shell
curl 'https://openapi.<<< custom_key.brand_main_domain >>>/api/v1/dialing_task/list' \
-H 'DF-API-KEY: <DF-API-KEY>' \
-H 'Content-Type: application/json;charset=UTF-8' \
--compressed
```




## 响应
```shell
{
    "code": 200,
    "content": [
        {
            "createAt": 1677723540,
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
            "id": 19,
            "regions": [
                "reg_xxx9v0"
            ],
            "status": 0,
            "tagInfo": [],
            "task": {
                "advance_options": {
                    "auth": {
                        "password": "",
                        "username": ""
                    },
                    "request_options": {
                        "headers": {},
                        "timeout": ""
                    }
                },
                "frequency": "1m",
                "message": "test123",
                "name": "WEBSOCKET",
                "status": "ok",
                "success_when": [
                    {
                        "response_time": [
                            {
                                "target": "3ms"
                            }
                        ]
                    }
                ],
                "success_when_logic": "and",
                "url": "ws://172.16.5.9:8080/echo"
            },
            "type": "websocket",
            "updateAt": 1686035083,
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
            "uuid": "dial_xxx2b5",
            "workspaceUUID": "wksp_xxx115"
        }
    ],
    "errorCode": "",
    "message": "",
    "pageInfo": {
        "count": 9,
        "pageIndex": 1,
        "pageSize": 100,
        "totalCount": 9
    },
    "success": true,
    "traceId": "TRACE-4415E8E2-99A2-41CC-BBB2-5AB5AE9CFE1F"
} 
```




