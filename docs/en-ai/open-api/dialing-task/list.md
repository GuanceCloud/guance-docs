# Get Dial Testing Task List

---

<br />**GET /api/v1/dialing_task/list**

## Overview




## Query Request Parameters

| Parameter Name        | Type     | Required   | Description              |
|:---------------------|:---------|:----------|:------------------------|
| pageIndex | integer | Yes | Page number<br>Can be empty: False <br>Example: 1 <br>$minValue: 1 <br> |
| pageSize | integer | Yes | Number of items per page<br>Can be empty: False <br>Example: 10 <br>$minValue: 1 <br> |
| type | string | Yes | Type of dial testing<br>Can be empty: False <br>Options: ['http', 'browser', 'tcp', 'icmp', 'websocket'] <br> |
| search | string | Yes | Dial testing name<br>Can be empty: False <br> |
| dialingTypes | commaArray | Yes | Types of dial testing (http, browser, tcp, icmp, websocket)<br>Can be empty: False <br> |
| dialingStatus | commaArray | Yes | Status of dial testing (ok, stop)<br>Can be empty: False <br> |
| tagsUUID | commaArray | Yes | Tag UUIDs<br>Can be empty: False <br> |
| frequency | commaArray | Yes | Frequency of dial testing (1m, 5m, 15m, 30m, 1h, 6h, 12h, 24h)<br>Can be empty: False <br> |

## Additional Parameter Notes





## Request Example
```shell
curl 'https://openapi.<<< custom_key.brand_main_domain >>>/api/v1/dialing_task/list' \
-H 'DF-API-KEY: <DF-API-KEY>' \
-H 'Content-Type: application/json;charset=UTF-8' \
--compressed
```




## Response
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