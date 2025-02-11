# Modify an Explorer

---

<br />**POST /api/v1/viewer/\{viewer_uuid\}/modify**

## Overview
Modify an Explorer




## Route Parameters

| Parameter Name        | Type     | Required   | Description              |
|:---------------------|:---------|:-----------|:-------------------------|
| viewer_uuid           | string   | Y          | Explorer UUID            |


## Body Request Parameters

| Parameter Name        | Type     | Required   | Description              |
|:---------------------|:---------|:-----------|:-------------------------|
| name                  | string   |            | Explorer name<br>Example: Explorer 1 <br>Can be empty: False <br>Maximum length: 64 <br> |
| desc                  | string   |            | Description<br>Example: Description 1 <br>Can be empty: False <br>Can be an empty string: True <br>Maximum length: 2048 <br> |
| type                  | string   |            | Type, defaults to CUSTOM<br>Example: CUSTOM <br>Can be empty: False <br>Maximum length: 32 <br> |
| extend                | json     |            | Additional data for the Explorer, defaults to {}<br>Example: {} <br>Can be empty: False <br> |
| pathName              | string   |            | Explorer path name<br>Example: tracing__profile <br>Can be empty: False <br>Maximum length: 32 <br> |
| tagNames              | array    |            | Names of tags<br>Can be empty: False <br> |
| tagNames[*]           | string   |            | Tag name<br>Can be empty: False <br>Maximum length: 128 <br> |
| dashboardBindSet      | array    |            | Information about views bound to the Explorer<br>Example: [] <br>Can be empty: False <br>Can be an empty string: False <br> |

## Additional Parameter Notes



## Request Example
```shell
curl 'https://openapi.guance.com/api/v1/viewer/dsbd_xxxx32/modify' \
-H 'DF-API-KEY: <DF-API-KEY>' \
-H 'Content-Type: application/json;charset=UTF-8' \
--data-raw '{"name":"modify_viewer","tagNames":["APM"]}' \
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
        "dashboardBidding": {},
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
        "old_name": "add_viewer",
        "ownerType": "viewer",
        "status": 0,
        "tag_info": {
            "tagInfo": [
                {
                    "id": "tag_xxxx32",
                    "name": "APM"
                }
            ]
        },
        "type": "CUSTOM",
        "updateAt": 1677662058.377045,
        "updator": "wsak_xxxxx",
        "updatorInfo": {
            "email": "wsak_xxxxx",
            "iconUrl": "",
            "name": "Smart Inspection Test",
            "username": "xxxx"
        },
        "uuid": "dsbd_xxxx32",
        "workspaceUUID": "wksp_xxxx32"
    },
    "errorCode": "",
    "message": "",
    "success": true,
    "traceId": "TRACE-AECCF8D3-29D3-431E-AB68-046688C30035"
} 
```