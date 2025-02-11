# Get Member List

---

<br />**GET /api/v1/workspace/members/list**

## Overview
List all members in the current workspace



## Query Request Parameters

| Parameter Name | Type   | Required | Description                                                                 |
|:--------------|:-------|:---------|:----------------------------------------------------------------------------|
| search        | string |          | Search by name/email<br>Example: supper_workspace <br>Allow empty: False <br> |
| pageIndex     | integer|          | Page number<br>Allow empty: False <br>Example: 10 <br>$minValue: 1 <br>      |
| pageSize      | integer|          | Number of items per page<br>Allow empty: False <br>Example: 10 <br>$minValue: 1 <br>$maxValue: 100 <br> |

## Additional Parameter Notes



## Request Example
```shell
curl 'https://openapi.guance.com/api/v1/workspace/members/list?pageIndex=1&pageSize=2' \
-H 'DF-API-KEY: <DF-API-KEY>' \
--compressed 
```



## Response
```shell
{
    "code": 200,
    "content": [
        {
            "createAt": 1614149795,
            "creator": "extend",
            "deleteAt": -1,
            "email": "88@qq.com",
            "extend": {
                "user_icon": "acnt_xxxx32.png"
            },
            "exterId": "acnt-gtxSK4UrogwM3N2guGNGim",
            "id": 19,
            "mobile": "",
            "name": "Test",
            "nameSpace": "",
            "role": "owner",
            "status": 0,
            "updateAt": 1614149795,
            "updator": "external",
            "userIconUrl": "http://static.cloudcare.cn:10561/icon/acnt_xxxx32.png",
            "userType": "common",
            "username": "88@qq.com",
            "uuid": "acnt_xxxx32",
            "waitAudit": 0
        }
    ],
    "errorCode": "",
    "message": "",
    "pageInfo": {
        "count": 1,
        "pageIndex": 1,
        "pageSize": 3,
        "totalCount": 1
    },
    "success": true,
    "traceId": "TRACE-DA203788-B799-4BE2-9AB4-552047E01EED"
} 
```