# Get a Dashboard

---

<br />**GET /api/v1/dashboards/\{dashboard_uuid\}/get**

## Overview
Retrieve the specified dashboard information based on `dashboard_uuid`



## Route Parameters

| Parameter Name        | Type     | Required | Description              |
|:-------------------|:-------|:-----|:----------------|
| dashboard_uuid | string | Y | View UUID<br> |


## Additional Parameter Notes



## Request Example
```shell
curl 'https://openapi.<<< custom_key.brand_main_domain >>>/api/v1/dashboards/dsbd_xxxx32/get' \
-H 'DF-API-KEY: <DF-API-KEY>' \
--compressed 
```



## Response
```shell
{
    "code": 200,
    "content": {
        "chartGroupPos": [],
        "chartPos": [
            {
                "chartUUID": "chrt_xxxx32",
                "pos": {
                    "h": 11,
                    "i": "chrt_xxxx32",
                    "w": 11,
                    "x": 0,
                    "y": 0
                }
            }
        ],
        "createAt": 1642587228,
        "createdWay": "import",
        "creator": "acnt_xxxx32",
        "dashboardBindSet": [],
        "deleteAt": -1,
        "extend": {},
        "iconSet": {},
        "id": 2494,
        "mapping": [],
        "name": "testt",
        "ownerType": "node",
        "status": 0,
        "tag_info": {
            "dsbd_xxxx32": [
                {
                    "id": "tag_xxxx32",
                    "name": "openapi"
                },
                {
                    "id": "tag_xxxx32",
                    "name": "test"
                }
            ]
        },
        "type": "CUSTOM",
        "updateAt": 1642587908,
        "updator": "wsak_xxxxx",
        "uuid": "dsbd_xxxx32",
        "workspaceUUID": "wksp_xxxx32"
    },
    "errorCode": "",
    "message": "",
    "success": true,
    "traceId": "TRACE-B4C47390-FA67-4FD8-851C-342C3C97F957"
} 
```