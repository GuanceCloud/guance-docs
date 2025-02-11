# Get Channel List

---

<br />**GET /api/v1/channel/quick_list**

## Overview




## Additional Parameter Notes





## Request Example
```shell
curl 'https://openapi.guance.com/api/v1/channel/quick_list' \
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
            "createAt": 1680767371,
            "creator": "acnt_xxxx32",
            "deleteAt": 1680767373,
            "description": "Channel description information, plus random number: `20230406T1549314fPYn0`",
            "id": 38,
            "name": "test channel_20230406T1549314fPYn0",
            "notifyTarget": [],
            "status": 0,
            "subscribeType": "",
            "updateAt": 1681357025,
            "updator": "acnt_xxxx32",
            "uuid": "chan_xxxx32",
            "workspaceUUID": "wksp_xxxx32"
        }
    ],
    "errorCode": "",
    "message": "",
    "success": true,
    "traceId": "9262677406670495822"
} 
```