# 【Object Classification Configuration】List

---

<br />**GET /api/v1/objc_cfg/list**

## Overview
Retrieve the list of object classification configurations. This API does not support pagination.

## Query Request Parameters

| Parameter Name           | Type        | Required | Description                                                                 |
|:---------------------|:----------|:-------|:---------------------------------------------------------------------------|
| targetWorkspaceUUIDs  | commaArray | No    | Authorized workspaces, multiple workspaces separated by commas.<br>Can be empty: False <br>Can be an empty string: False <br> |
| objcGroupUUID         | string     | No    | Business group UUID<br>Can be empty: False <br>Example: objcg_xxxx <br>Can be an empty string: True <br>Maximum length: 64 <br> |
| sourceType            | string     | Yes   | Source type<br>Can be empty: False <br>Example: custom_object <br>Optional values: ['object', 'custom_object'] <br> |
| search                | string     | No    | Search object classification name<br>Can be empty: False <br>Example: xxx <br> |
| timeRange             | string     | No    | Time range<br>Example: [1734402721237, 1734575521237] <br>Can be empty: False <br> |

## Additional Parameter Notes



## Request Example
```shell
curl 'https://openapi.guance.com/api/v1/objc_cfg/list?sourceType=custom_object&timeRange=[1734573756731]' \
-H 'DF-API-KEY: <DF-API-KEY>' \
--compressed
```



## Response
```shell
{
    "code": 200,
    "content": [
        {
            "uuid": "objc_xxxx",
            "name": "test",
            "alias": "",
            "fields": [
                {
                    "name": "name1"
                },
                {
                    "name": "name2"
                }
            ],
            "filters": [],
            "tableColumns": [],
            "tableDetailViews": [
                {
                    "keys": {},
                    "title": "demo",
                    "required": true,
                    "viewName": "NtpQ Monitoring View",
                    "viewType": "dashboard",
                    "timerange": "default"
                }
            ],
            "iconSet": {},
            "objcGroupUUID": "objcg_xxxx",
            "objcGroupInfo": {
                "workspaceUUID": "wksp_xxx",
                "name": "eeee",
                "id": 86,
                "uuid": "objcg_xxxx",
                "status": 0,
                "creator": "acnt_xxxx",
                "updator": "",
                "createAt": 1734512088,
                "deleteAt": -1,
                "updateAt": -1
            }
        }
    ],
    "errorCode": "",
    "message": "",
    "success": true,
    "traceId": "868484794797253491"
} 
```