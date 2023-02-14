# Get a List of Members

---

<br />**get /api/v1/workspace/members/list**

## Overview
List all members in the current workspace.




## Query Request Parameter

| Parameter Name        | Type     | Required   | Description              |
|:-----------|:-------|:-----|:----------------|
| search | string |  | Search by name/mailbox<br>Example: supper_workspace <br>Allow null: False <br> |
| pageIndex | integer |  | Page number<br>Allow null: False <br>Example: 10 <br>$minValue: 1 <br> |
| pageSize | integer |  | Quantity returned per page<br>Allow null: False <br>Example: 10 <br>$minValue: 1 <br>$maxValue: 100 <br> |

## Supplementary Description of Parameters





## Request Example
```shell
curl 'https://openapi.guance.com/api/v1/workspace/members/list?pageIndex=1&pageSize=2' \
-H 'DF-API-KEY: <DF-API-KEY>' \
--compressed \
--insecure
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
                "user_icon": "acnt_6f2fd4c0766d11ebb56ef2b2c21faf74.png"
            },
            "exterId": "acnt-gtxSK4UrogwM3N2guGNGim",
            "id": 19,
            "mobile": "",
            "name": "测试",
            "nameSpace": "",
            "role": "owner",
            "status": 0,
            "updateAt": 1614149795,
            "updator": "external",
            "userIconUrl": "http://static.cloudcare.cn:10561/icon/acnt_6f2fd4c0766d11ebb56ef2b2c21faf74.png",
            "userType": "common",
            "username": "88@qq.com",
            "uuid": "acnt_6f2fd4c0766d11ebb56ef2b2c21faf74",
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




