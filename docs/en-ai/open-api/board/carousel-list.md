# Get Dashboard Carousel List

---

<br />**GET /api/v1/dashboard/carousel/list**

## Overview




## Query Request Parameters

| Parameter Name        | Type     | Required | Description              |
|:-------------------|:-------|:-----|:----------------|
| search | string | No | Search by carousel dashboard name<br>Allow null: False <br> |

## Additional Parameter Notes





## Request Example
```shell
curl 'https://openapi.guance.com/api/v1/dashboard/carousel/list' \
-H 'DF-API-KEY: <DF-API-KEY>' \
--compressed
```




## Response
```shell
{
    "code": 200,
    "content": [
        {
            "accountUUID": "wsak_xxxxx",
            "createAt": 1698663545,
            "creator": "wsak_xxxxx",
            "dashboardUUIDs": [
                "dsbd_xxxx32"
            ],
            "deleteAt": -1,
            "id": 30,
            "intervalTime": "30s",
            "name": "test2",
            "status": 0,
            "updateAt": 1698663545,
            "updator": "wsak_xxxxx",
            "uuid": "csel_xxxx32",
            "workspaceUUID": "wksp_xxxx32"
        },
        {
            "accountUUID": "wsak_xxxxx",
            "createAt": 1698663461,
            "creator": "wsak_xxxxx",
            "dashboardUUIDs": [
                "dsbd_xxxx32"
            ],
            "deleteAt": -1,
            "id": 29,
            "intervalTime": "30s",
            "name": "test1",
            "status": 0,
            "updateAt": 1698663461,
            "updator": "wsak_xxxxx",
            "uuid": "csel_xxxx32",
            "workspaceUUID": "wksp_xxxx32"
        }
    ],
    "errorCode": "",
    "message": "",
    "success": true,
    "traceId": "TRACE-BDD0B37E-13B9-48B8-90B2-C9281B8C866F"
} 
```