# Issue Level List

---

<br />**GET /api/v1/issue-level/list**

## Overview

This API lists the default issue levels of the workspace and any custom levels defined within the workspace (excluding globally configured levels set via the management console).

## Additional Parameter Notes

The interface lists the default issue levels of the workspace along with any custom levels defined within it (does not include globally configured levels set via the management console).

## Request Example
```shell
curl 'https://openapi.guance.com/api/v1/issue-level/list' \
-H 'DF-API-KEY: <DF-API-KEY>' \
--compressed
```

## Response
```shell
{
    "code": 200,
    "content": [
        {
            "color": "#E94444",
            "description": "Default level configuration",
            "isDefault": true,
            "name": "P0",
            "uuid": "system_level_0"
        },
        {
            "color": "#FF7931",
            "description": "Default level configuration",
            "isDefault": true,
            "name": "P1",
            "uuid": "system_level_1"
        },
        {
            "color": "#FFB44A",
            "description": "Default level configuration",
            "isDefault": true,
            "name": "P2",
            "uuid": "system_level_2"
        },
        {
            "color": "#C9C9C9",
            "description": "Default level configuration",
            "isDefault": true,
            "name": "P3",
            "uuid": "system_level_3"
        },
        {
            "color": "#E94444",
            "createAt": 1694593524,
            "creator": "acnt_xxxx32",
            "deleteAt": -1,
            "description": "Custom level description 2",
            "extend": {},
            "id": 3,
            "isDefault": false,
            "name": "custom-1",
            "status": 0,
            "updateAt": 1694593524,
            "updator": "acnt_xxxx32",
            "uuid": "issl_xxxx32",
            "workspaceUUID": "wksp_xxxx32"
        }
    ],
    "errorCode": "",
    "message": "",
    "success": true,
    "traceId": "TRACE-2FDDC63E-17AE-41ED-AE63-D2DF2E7BCD51"
} 
```