# Export a Viewer

---

<br />**GET /api/v1/viewer/\{viewer_uuid\}/export**

## Overview
Export the viewer specified by `viewer_uuid` as a template structure


## Route Parameters

| Parameter Name     | Type   | Required | Description              |
|:-----------------|:------|:-------|:-------------------------|
| viewer_uuid      | string| Y     | Viewer UUID<br>          |


## Additional Parameter Notes



## Request Example
```shell
curl 'https://openapi.<<< custom_key.brand_main_domain >>>/api/v1/viewer/dsbd_xxxx32/export' \
-H 'DF-API-KEY: <DF-API-KEY>' \
--compressed 
```



## Response
```shell
{
    "code": 200,
    "content": {
        "dashboardBindSet": [],
        "dashboardExtend": {
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
        "dashboardMapping": [],
        "dashboardOwnerType": "viewer",
        "dashboardType": "CUSTOM",
        "iconSet": {},
        "main": {
            "charts": [],
            "groups": [],
            "type": "template",
            "vars": []
        },
        "summary": "",
        "tagInfo": [
            {
                "id": "tag_xxxx32",
                "name": "APM"
            }
        ],
        "tags": [],
        "thumbnail": "",
        "title": "modify_viewer"
    },
    "errorCode": "",
    "message": "",
    "success": true,
    "traceId": "TRACE-4457FED3-911C-4AA8-A7C7-9AE6B0463DC8"
} 
```