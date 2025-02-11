# Get Blacklist

---

<br />**GET /api/v1/blacklist/list**

## Overview
Retrieve the blacklist.

## Query Request Parameters

| Parameter Name        | Type     | Required   | Description              |
|:-------------------|:-------|:-----|:----------------|
| type | string | Y | Blacklist type. For querying log blacklists, set `type` to `logging`. To query all blacklists under management submenus, set `type` to `all`.<br>Can be empty: False <br>Example: logging/all <br> |
| search | string | N | Search term<br>Can be empty: False <br> |
| pageIndex | integer | N | Page number<br>Can be empty: False <br>Example: 1 <br>$minValue: 1 <br> |
| pageSize | integer | N | Number of items per page<br>Can be empty: False <br>Example: 10 <br>$minValue: 1 <br> |

## Additional Parameter Notes

## Request Example
```shell
curl 'https://openapi.guance.com/api/v1/blacklist/list?type=all&pageIndex=1&pageSize=20' \
-H 'DF-API-KEY: <DF-API-KEY>' \
--compressed
```

## Response
```shell
{
    "code": 200,
    "content": [
        {
            "conditions": "{ source =  'kodo-log'  and ( host in [ '127.0.0.1' ] )}",
            "createAt": 1678029404,
            "creator": "xxx",
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
            "filters": [
                {
                    "condition": "and",
                    "name": "host",
                    "operation": "in",
                    "value": [
                        "127.0.0.1"
                    ]
                }
            ],
            "id": 59,
            "source": "kodo-log",
            "status": 0,
            "type": "logging",
            "updateAt": 1678029404,
            "updator": "xxx",
            "updatorInfo": {
                "uuid": "xx",
                "status": 0,
                "username": "xx",
                "name": "xx",
                "iconUrl": "",
                "email": "xx",
                "acntWsNickname": "xx"
            },
            "uuid": "blist_xxx481",
            "workspaceUUID": "wksp_xxx115"
        },
        {
            "conditions": "{ source =  'kodo-log'  and ( name in [ 'a' ] )}",
            "createAt": 1677653414,
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
            "filters": [
                {
                    "condition": "and",
                    "name": "name",
                    "operation": "in",
                    "value": [
                        "a"
                    ]
                }
            ],
            "id": 24,
            "source": "kodo-log",
            "status": 0,
            "type": "logging",
            "updateAt": 1678027698,
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
            "uuid": "blist_xxxd36",
            "workspaceUUID": "wksp_xxx115"
        },
        {
            "conditions": "{ source =  'datakit'  and ( status in [ 'ok' ,  'info' ]  and  host in [ 'cc-testing-cluster-001' ]  and  message in [ 'kodo' ] )}",
            "createAt": 1677565045,
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
            "filters": [
                {
                    "condition": "and",
                    "name": "status",
                    "operation": "in",
                    "value": [
                        "ok",
                        "info"
                    ]
                },
                {
                    "condition": "and",
                    "name": "host",
                    "operation": "in",
                    "value": [
                        "cc-testing-cluster-001"
                    ]
                },
                {
                    "condition": "and",
                    "name": "message",
                    "operation": "in",
                    "value": [
                        "kodo"
                    ]
                }
            ],
            "id": 16,
            "source": "datakit",
            "status": 0,
            "type": "logging",
            "updateAt": 1677565045,
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
            "uuid": "blist_xxx6b5",
            "workspaceUUID": "wksp_xxx115"
        }
    ],
    "errorCode": "",
    "message": "",
    "pageInfo": {
        "count": 3,
        "pageIndex": 1,
        "pageSize": 20,
        "totalCount": 3
    },
    "success": true,
    "traceId": "TRACE-E7DF5A1A-0B7F-47F7-815E-F73AB4F2F8CF"
} 
```