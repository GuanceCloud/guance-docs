# List Custom Notification Dates for Alert Strategies

---

<br />**GET /api/v1/notice/date/list**

## Overview
List custom notification dates for alert strategies


## Query Request Parameters

| Parameter Name | Type   | Required | Description                                      |
|:--------------|:-------|:--------|:------------------------------------------------|
| search        | string |         | Search configuration name of custom notification dates <br>Allow empty: True <br> |
| pageIndex     | integer|         | Page number <br>Allow empty: False <br>Example: 1 <br>$minValue: 1 <br> |
| pageSize      | integer|         | Number of items per page <br>Allow empty: False <br>Example: 10 <br>$minValue: 1 <br>$maxValue: 10000 <br> |

## Additional Parameter Notes



## Request Example
```shell
curl 'https://openapi.<<< custom_key.brand_main_domain >>>/api/v1/notice/date/list?pageIndex=1&pageSize=10' \
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
                "createAt": 1705567043,
                "creator": "xx",
                "dates": [
                    "2024/01/01",
                    "2024/05/01"
                ],
                "deleteAt": -1,
                "id": 5,
                "name": "test001",
                "status": 0,
                "updateAt": 1705567043,
                "updator": "xxx",
                "uuid": "ndate_xxxx32",
                "workspaceUUID": "wksp_xxxx32"
            },
            {
                "createAt": 1705566710,
                "creator": "xxx",
                "dates": [
                    "2025.01.01",
                    "2025.10.01"
                ],
                "deleteAt": -1,
                "id": 4,
                "name": "test002",
                "status": 0,
                "updateAt": 1705567170,
                "updator": "xx",
                "uuid": "ndate_xxxx32",
                "workspaceUUID": "wksp_xxxx32"
            },
            {
                "createAt": 1705560344,
                "creator": "acnt_xxxx32",
                "dates": [
                    "2025-03-04",
                    "2026.04.09"
                ],
                "deleteAt": -1,
                "id": 1,
                "name": "jinlei_03",
                "status": 0,
                "updateAt": 1705562459,
                "updator": "acnt_xxxx32",
                "uuid": "ndate_xxxx32",
                "workspaceUUID": "wksp_xxxx32"
            }
        ],
        "declaration": {
            "asd": [
                "afaw"
            ],
            "asdasd": [
                "dawdawd"
            ],
            "business": "aaa",
            "fawf": [
                "afawf"
            ],
            "organization": "6540c09e4243b300077a9675"
        }
    },
    "errorCode": "",
    "message": "",
    "pageInfo": {
        "count": 3,
        "pageIndex": 1,
        "pageSize": 20,
        "totalCount": 3
    },
    "success": true,
    "traceId": "TRACE-545F2180-3696-4EED-A8B1-9EF909A47510"
} 
```