# Get Notes List

---

<br />**GET /api/v1/notes/list**

## Overview
List all notes that meet the conditions. The current interface does not support pagination.




## Query Request Parameters

| Parameter Name        | Type     | Required   | Description              |
|:-------------------|:-------|:-------|:--------------------|
| search | string |  | Notes name search<br>Can be empty: False <br> |

## Additional Parameter Notes

Parameter description:




## Request Example
```shell
curl 'https://openapi.<<< custom_key.brand_main_domain >>>/api/v1/notes/list' \
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
                "createAt": 1642588739,
                "creator": "acnt_xxxx32",
                "creatorInfo": {
                    "iconUrl": "http://static.cloudcare.cn:10561/icon/acnt_xxxx32.png",
                    "name": "66",
                    "username": "xxx@<<< custom_key.brand_main_domain >>>"
                },
                "deleteAt": -1,
                "id": 185,
                "isFavourited": false,
                "name": "My Notes",
                "pos": [
                    {
                        "chartUUID": "chrt_xxxx32"
                    }
                ],
                "status": 0,
                "updateAt": 1642588739,
                "updator": "acnt_xxxx32",
                "updatorInfo": {
                    "iconUrl": "http://static.cloudcare.cn:10561/icon/acnt_xxxx32.png",
                    "name": "66",
                    "username": "xxx@<<< custom_key.brand_main_domain >>>"
                },
                "uuid": "notes_xxxx32",
                "workspaceUUID": "wksp_xxxx32"
            }
        ]
    },
    "errorCode": "",
    "message": "",
    "success": true,
    "traceId": "TRACE-123ADCD7-95F0-4EDC-A27A-649885FAF9CD"
} 
```