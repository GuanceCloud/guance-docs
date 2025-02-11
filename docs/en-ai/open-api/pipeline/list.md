# Get Pipeline List

---

<br />**GET /api/v1/pipeline/list**

## Overview
Get the list of Pipelines



## Query Request Parameters

| Parameter Name | Type   | Required | Description              |
|:-----------|:-------|:-----|:----------------|
| search | string | No  | File name (source value)<br>Can be empty: False <br> |
| type | string | No  | Pipeline file type<br>Can be empty: False <br>Possible values: ['local', 'central'] <br> |
| categories | commaArray | No  | Category list, separated by commas<br>Can be empty: False <br> |

## Additional Parameter Notes




## Request Example
```shell
curl 'https://openapi.guance.com/api/v1/pipeline/list' \
-H 'DF-API-KEY: <DF-API-KEY>' \
--compressed
```




## Response
```shell
{
    "code": 200,
    "content": {
        "data": [
            {
                "asDefault": 0,
                "category": "logging",
                "createAt": 1706152082,
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
                "name": "openapi_test",
                "status": 0,
                "updateAt": 1678026470,
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
                "uuid": "pl_xxx607"
            },
            {
                "asDefault": 0,
                "category": "logging",
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
                "name": "eee",
                "status": 0,
                "updateAt": 1677814027,
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
                "uuid": "pl_xxx8f1"
            },
            {
                "asDefault": 0,
                "category": "logging",
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
                "name": "JMauto_logging1",
                "status": 0,
                "updateAt": 1677640634,
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
                "uuid": "pl_xxx07f"
            },
            {
                "asDefault": 0,
                "category": "logging",
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
                "name": "1",
                "status": 0,
                "updateAt": 1677637485,
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
                "uuid": "pl_xxx96f"
            },
            {
                "asDefault": 0,
                "category": "logging",
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
                "name": "kodolog",
                "status": 2,
                "updateAt": 1677636474,
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
                "uuid": "pl_xxx877"
            }
        ]
    },
    "errorCode": "",
    "message": "",
    "success": true,
    "traceId": "TRACE-ABDC1CCF-BC78-4463-8276-2F14225B1A6B"
} 
```