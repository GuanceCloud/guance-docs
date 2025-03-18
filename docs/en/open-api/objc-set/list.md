# [Object Classification Configuration] List

---

<br />**GET /api/v1/objc_cfg/list**

## Overview
Retrieve a list of object classification configurations. The current API does not support pagination.

## Query Request Parameters

| Parameter Name        | Type     | Required | Description              |
|:---------------------|:---------|:---------|:-------------------------|
| targetWorkspaceUUIDs  | commaArray | No       | Authorized workspaces, multiple workspaces separated by commas.<br>Allow empty: False <br>Allow empty string: False <br> |
| objcGroupUUID         | string   | No       | Business group UUID<br>Allow empty: False <br>Example: objcg_xxxx <br>Allow empty string: True <br>Maximum length: 64 <br> |
| sourceType            | string   | Yes      | Source type<br>Allow empty: False <br>Example: custom_object <br>Options: ['object', 'custom_object'] <br> |
| search                | string   | No       | Search object classification name<br>Allow empty: False <br>Example: xxx <br> |
| timeRange             | string   | No       | Time range<br>Example: [1734402721237, 1734575521237] <br>Allow empty: False <br> |

## Additional Parameter Notes

## Request Example
```shell
curl 'https://openapi.<<< custom_key.brand_main_domain >>>/api/v1/objc_cfg/list?sourceType=custom_object&timeRange=[1734573756731]' \
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