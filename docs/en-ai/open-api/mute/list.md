# Get Mute Rule List

---

<br />**GET /api/v1/monitor/mute/list**

## Overview
Get a paginated list of mute rules


## Query Request Parameters

| Parameter Name        | Type     | Required   | Description              |
|:------------------|:-------|:-----|:----------------|
| search | string | No | Search rule name<br>Can be empty: False <br> |
| workStatus | commaArray | No | Filter parameter, status connected by commas (,)  Pending activation: pending_activation, Active: active, Expired: expired<br>Can be empty: False <br> |
| isEnable | commaArray | No | Filter parameter, 1 represents enabled, 0 represents disabled<br>Can be empty: False <br> |
| type | commaArray | No | Filter parameter, custom/checker/alertPolicy/tag, multiple parameters connected by commas (,) <br>Can be empty: False <br> |
| updator | commaArray | No | Filter parameter, UUID of the updater, connected by commas (,) <br>Can be empty: False <br> |
| creator | commaArray | No | Filter parameter, UUID of the creator, connected by commas (,) <br>Can be empty: False <br> |
| pageIndex | integer | No | Page number<br>Can be empty: False <br>Example: 1 <br>$minValue: 1 <br> |
| pageSize | integer | No | Number of items per page<br>Can be empty: False <br>Example: 10 <br>$minValue: 1 <br>$maxValue: 100 <br> |

## Additional Parameter Notes



## Request Example
```shell
curl 'https://openapi.guance.com/api/v1/monitor/mute/list?pageIndex=1&pageSize=2' \
-H 'DF-API-KEY: <DF-API-KEY>' \
--compressed 
```



## Response
```shell
{
    "code": 200,
    "content": [
        {
            "createAt": 1642572752,
            "creator": "wsak_xxxxx",
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
            "end": 1642576351,
            "id": 383,
            "notifyMessage": "",
            "notifyTargets": [],
            "notifyTime": -1,
            "start": 1642572751,
            "status": 0,
            "tags": [
                {
                    "host": "testname"
                }
            ],
            "type": "host",
            "updateAt": 1642572752,
            "updator": "wsak_xxxxx",
            "updatorInfo": {
                "uuid": "xx",
                "status": 0,
                "username": "xx",
                "name": "xx",
                "iconUrl": "",
                "email": "xx",
                "acntWsNickname": "xx"
            },
            "uuid": "mute_xxx890",
            "workspaceUUID": "wksp_xxx4af"
        }
    ],
    "errorCode": "",
    "message": "",
    "pageInfo": {
        "count": 1,
        "pageIndex": 1,
        "pageSize": 2,
        "totalCount": 1
    },
    "success": true,
    "traceId": "TRACE-AB73EEDD-3873-4EBD-A424-722022770AD5"
} 
```