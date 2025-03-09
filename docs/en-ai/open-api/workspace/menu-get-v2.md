# Feature Menu Acquisition (new, supports secondary menus)

---

<br />**GET /api/v1/workspace/menu_v2/get**

## Overview
Retrieve the current workspace feature menu



## Additional Parameter Explanation




## Request Example
```shell
curl 'https://openapi.guance.com/api/v1/workspace/menu_v2/get' \
-H 'Content-Type: application/json;charset=UTF-8' \
-H 'DF-API-KEY: <DF-API-KEY>' \
```




## Response
```shell
{
    "code": 200,
    "content": {
        "config": [
            {
                "key": "Scene",
                "value": 1
            },
            {
                "key": "Events",
                "value": 1
            },
            {
                "key": "Incident",
                "value": 0
            },
            {
                "key": "Objectadmin",
                "value": 0
            },
            {
                "key": "Metrics Query",
                "value": 1
            },
            {
                "key": "LogIndi",
                "value": 1
            },
            {
                "key": "Tracing",
                "value": 1
            },
            {
                "key": "RUM",
                "value": 1
            },
            {
                "key": "Dial Testing",
                "value": 1
            },
            {
                "key": "Security Check",
                "value": 1
            },
            {
                "key": "GitLabCI",
                "value": 1
            },
            {
                "key": "Monitor",
                "value": 1
            },
            {
                "key": "Integration",
                "value": 1
            },
            {
                "key": "Workspace",
                "value": 1
            },
            {
                "key": "Billing",
                "value": 1
            }
        ],
        "createAt": 1697627382,
        "creator": "acnt_xxxx32",
        "deleteAt": -1,
        "id": 763,
        "keyCode": "WsMenuCfg",
        "status": 0,
        "updateAt": 1697627382,
        "updator": "acnt_xxxx32",
        "uuid": "ctcf_xxxx32",
        "workspaceUUID": "wksp_xxxx20"
    },
    "errorCode": "",
    "message": "",
    "success": true,
    "traceId": "13205984800302747785"
} 
```