# [Frontend Accounts] List

---

<br />**GET /api/v1/account/list**

## Overview



## Query Request Parameters

| Parameter Name | Type   | Required | Description |
|:--------------|:-------|:---------|:------------|
| search        | string |          | Username, email<br>Can be empty: False <br> |
| pageIndex     | integer|          | Page number<br>Can be empty: False <br>Example: 10 <br>$minValue: 1 <br> |
| pageSize      | integer|          | Number of items per page<br>Can be empty: False <br>Example: 10 <br>$minValue: 1 <br>$maxValue: 100 <br> |

## Additional Parameter Notes



## Request Example
```shell
curl '<Endpoint>/api/v1/account/list?pageIndex=1&pageSize=5' \
  -H 'Content-Type: application/json' \
  -H 'X-Df-Access-Key: <AK key>' \
  -H 'X-Df-Nonce: <random characters>' \
  -H 'X-Df-Signature: <signature>' \
  -H 'X-Df-Timestamp: <timestamp>'
```



## Response
```shell
{
    "code": 200,
    "content": {
        "data": [
            {
                "attributes": {},
                "canaryPublic": false,
                "createAt": 1715135066,
                "creator": "extend",
                "deleteAt": -1,
                "email": "xxxxx@qq.com",
                "enableMFA": false,
                "extend": {
                    "lastLoginTime": 1715135086
                },
                "exterId": "acnt-yf5o9juQBxTeTcADbroE8",
                "id": 3023,
                "isUsed": 1,
                "language": "en",
                "mfaSecret": "*********************",
                "mobile": "15435364656",
                "name": "xxxxx",
                "nameSpace": "",
                "status": 0,
                "statusPageSubs": 0,
                "timezone": "",
                "tokenHoldTime": 604800,
                "tokenMaxValidDuration": 2592000,
                "updateAt": 1715135066,
                "updator": "extend",
                "username": "xxxxx",
                "uuid": "acnt_a95702ad60d04209b3ba42650e75c8a8",
                "wsInfo": [
                    {
                        "name": "xxxxx's workspace",
                        "roles": [
                            {
                                "name": "Owner",
                                "uuid": "owner",
                                "workspaceUUID": ""
                            }
                        ],
                        "uuid": "wksp_920085d222ba48798136dbf2f4bef209"
                    }
                ]
            }
        ],
        "pageInfo": {
            "count": 5,
            "pageIndex": 1,
            "pageSize": 5,
            "totalCount": 2838
        }
    },
    "errorCode": "",
    "message": "",
    "success": true,
    "traceId": "TRACE-33D7337F-869A-4300-9350-31142D36919B"
} 
```