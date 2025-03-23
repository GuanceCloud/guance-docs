# Get member list

---

<br />**GET /api/v1/workspace/members/list**

## Overview
List all members in the current workspace




## Query request parameters

| Parameter name        | Type     | Required   | Description              |
|:-------------------|:-------|:-----|:----------------|
| search | string |  | Search by name/email<br>Example: supper_workspace <br>Can be empty: False <br> |
| pageIndex | integer |  | Page number<br>Can be empty: False <br>Example: 10 <br>$minValue: 1 <br> |
| pageSize | integer |  | Number of returns per page<br>Can be empty: False <br>Example: 10 <br>$minValue: 1 <br>$maxValue: 100 <br> |

## Additional parameter notes





## Request example
```shell
curl 'https://openapi.<<< custom_key.brand_main_domain >>>/api/v1/workspace/members/list?pageIndex=1&pageSize=2' \
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
            "email": "xxx@<<< custom_key.brand_main_domain >>>",
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
            "username": "xxx@<<< custom_key.brand_main_domain >>>",
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