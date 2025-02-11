# Get an Explorer

---

<br />**GET /api/v1/viewer/\{viewer_uuid\}/get**

## Overview
Retrieve details of an Explorer



## Route Parameters

| Parameter Name    | Type   | Required | Description              |
|:--------------|:-----|:-------|:----------------|
| viewer_uuid | string | Y | Explorer UUID<br> |


## Additional Parameter Notes





## Request Example
```shell
curl 'https://openapi.guance.com/api/v1/viewer/dsbd_xxxx32/get' \
-H 'DF-API-KEY: <DF-API-KEY>' \
--compressed 
```




## Response
```shell
{
    "code": 200,
    "content": {
        "chartGroupPos": [],
        "chartPos": [],
        "createAt": 1677661673,
        "createdWay": "manual",
        "creator": "wsak_xxxxx",
        "dashboardBindSet": [],
        "deleteAt": -1,
        "extend": {
            "analysisField": "message",
            "charts": [
                null,
                null,
                null
            ],
            "filters": [],
            "index": "tracing",
            "quickFilter": {
                "columns": []
            },
            "rumAppId": "",
            "rumType": "",
            "selectedIndex": "default",
            "source": "",
            "table": {
                "columns": []
            }
        },
        "iconSet": {},
        "id": 712,
        "isPublic": 1,
        "mapping": [],
        "name": "modify_viewer",
        "ownerType": "viewer",
        "status": 0,
        "tag_info": {
            "dsbd_xxxx32": [
                {
                    "id": "tag_xxxx32",
                    "name": "APM"
                }
            ]
        },
        "type": "CUSTOM",
        "updateAt": 1677662058,
        "updator": "wsak_xxxxx",
        "uuid": "dsbd_xxxx32",
        "workspaceUUID": "wksp_xxxx32"
    },
    "errorCode": "",
    "message": "",
    "success": true,
    "traceId": "TRACE-6AC65A44-636E-4E32-8F52-78F528958218"
} 
```