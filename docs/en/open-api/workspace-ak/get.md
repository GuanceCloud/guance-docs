# Get a Key

---

<br />**GET /api/v1/workspace/accesskey/{ak_uuid}/get**

## Overview
Get a Key




## Route Parameters

| Parameter Name        | Type     | Required   | Description              |
|:-----------------|:-------|:-----|:----------------|
| ak_uuid | string | Y | UUID of the access key<br> |


## Additional Parameter Notes





## Request Example
```shell
curl 'https://openapi.<<< custom_key.brand_main_domain >>>/api/v1/workspace/accesskey/wsak_xxxxx/get' \
-H 'DF-API-KEY: <DF-API-KEY>' \
--compressed
```




## Response
```shell
{
    "code": 200,
    "content": {
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
        "sk": "xxxx",
        "status": 0,
        "updateAt": 1677808718,
        "updator": "acnt_xxxx32",
        "uuid": "wsak_xxxxx",
        "workspaceUUID": "wksp_xxxx32"
    },
    "errorCode": "",
    "message": "",
    "success": true,
    "traceId": "TRACE-652BF56F-67F6-4A08-AF35-2BDFDCF12D89"
} 
```