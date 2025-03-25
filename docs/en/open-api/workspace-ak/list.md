# Get Key List

---

<br />**GET /api/v1/workspace/accesskey/list**

## Overview
Get Key List




## Query Request Parameters

| Parameter Name        | Type     | Required   | Description              |
|:---------------------|:---------|:-----------|:------------------------|
| search | string |  | Search by name<br>Example: supper_workspace <br>Can be empty: False <br> |

## Additional Parameter Notes





## Request Example
```shell
curl 'https://openapi.<<< custom_key.brand_main_domain >>>/api/v1/workspace/accesskey/list' \
-H 'DF-API-KEY: <DF-API-KEY>' \
--compressed
```




## Response
```shell
{
    "code": 200,
    "content": [
        {
            "createAt": 1677808718,
            "creator": "acnt_xxxx32",
            "creatorInfo": {
                "email": "xxx@<<< custom_key.brand_main_domain >>>",
                "iconUrl": "",
                "name": "88 Test",
                "username": "Test"
            },
            "deleteAt": -1,
            "id": 4,
            "name": "test",
            "sk": "xxx",
            "status": 0,
            "updateAt": 1677808718,
            "updator": "acnt_xxxx32",
            "uuid": "xxx",
            "workspaceUUID": "wksp_xxxx32"
        }
    ],
    "errorCode": "",
    "message": "",
    "success": true,
    "traceId": "TRACE-B73F5F23-046C-4A84-8B33-D028C92994C4"
} 
```




<!-- Note: This section is preserved as it was in the original content -->