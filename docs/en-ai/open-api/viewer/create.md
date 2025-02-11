# Create an Explorer

---

<br />**POST /api/v1/viewer/add**

## Overview
Create an Explorer



## Body Request Parameters

| Parameter Name        | Type     | Required   | Description              |
|:-------------------|:-------|:-------|:----------------|
| ownerType | string |  | View classification type, defaults to Explorer<br>Example: Explorer <br>Can be empty: False <br> |
| templateUUID | string |  | View template UUID<br>Can be empty: False <br>Can be empty string: True <br>Maximum length: 128 <br> |
| sourceDashboardUUID | string |  | Source view ID<br>Can be empty: False <br>Can be empty string: True <br>Maximum length: 128 <br> |
| name | string | Y | Explorer name<br>Can be empty: False <br>Maximum length: 64 <br> |
| desc | string |  | Description<br>Example: Description1 <br>Can be empty: False <br>Can be empty string: True <br>Maximum length: 2048 <br> |
| type | string |  | Type, defaults to CUSTOM<br>Example: CUSTOM <br>Can be empty: False <br>Maximum length: 32 <br> |
| extend | json |  | Additional data for the Explorer, defaults to {}<br>Example: {} <br>Can be empty: False <br> |
| templateInfos | json |  | Custom template data<br>Example: {} <br>Can be empty: False <br>Can be empty string: False <br> |
| isImport | boolean |  | Whether it is an imported Explorer<br>Can be empty: False <br> |
| tagNames | array |  | Tag names<br>Can be empty: False <br> |
| tagNames[*] | string |  | Tag name<br>Can be empty: False <br>Maximum length: 128 <br> |

## Additional Parameter Notes



## Request Example
```shell
curl 'https://openapi.guance.com/api/v1/viewer/add' \
-H 'DF-API-KEY: <DF-API-KEY>' \
-H 'Content-Type: application/json;charset=UTF-8' \
--data-raw '{"name":"add_viewer","templateInfos":{},"isImport":false,"tagNames":[],"extend":{"index":"tracing"}}' \
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
            "index": "tracing"
        },
        "iconSet": {},
        "id": null,
        "isPublic": 1,
        "mapping": [],
        "name": "add_viewer",
        "ownerType": "viewer",
        "status": 0,
        "tag_info": [
            {
                "id": "tag_xxxx32",
                "name": "Function"
            },
            {
                "id": "tag_xxxx32",
                "name": "Host"
            },
            {
                "id": "tag_xxxx32",
                "name": "Profile"
            },
            {
                "id": "tag_xxxx32",
                "name": "data"
            },
            {
                "id": "tag_xxxx32",
                "name": "ok"
            },
            {
                "id": "tag_xxxx32",
                "name": "ui"
            },
            {
                "id": "tag_xxxx32",
                "name": "Personal"
            },
            {
                "id": "tag_xxxx32",
                "name": "For"
            },
            {
                "id": "tag_xxxx32",
                "name": "Built-in"
            },
            {
                "id": "tag_xxxx32",
                "name": "Security Check"
            },
            {
                "id": "tag_xxxx32",
                "name": "APM"
            },
            {
                "id": "tag_xxxx32",
                "name": "Logs"
            },
            {
                "id": "tag_xxxx32",
                "name": "User Analysis"
            },
            {
                "id": "tag_xxxx32",
                "name": "Ali"
            },
            {
                "id": "tag_xxxx32",
                "name": "Alibaba Cloud Monitoring"
            }
        ],
        "type": "CUSTOM",
        "updateAt": 1677661673,
        "updator": "wsak_xxxxx",
        "uuid": "dsbd_xxxx32",
        "workspaceUUID": "wksp_xxxx32"
    },
    "errorCode": "",
    "message": "",
    "success": true,
    "traceId": "TRACE-7EB1D391-C7BA-47BA-A535-DEE932554366"
} 
```