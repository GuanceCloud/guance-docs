# Get Data Access Rule List

---

<br />**GET /api/v1/logging_query_rule/list**

## Overview
List data access rules



## Query Request Parameters

| Parameter Name        | Type     | Required   | Description              |
|:-------------------|:-------|:---------|:------------------------|
| pageSize | integer | No | Number of items per page<br>Can be empty: False <br>Example: 10 <br> |
| pageIndex | integer | No | Page number<br>Can be empty: False <br>Example: 10 <br> |

## Additional Parameter Notes



## Request Example
```shell
curl 'https://openapi.<<< custom_key.brand_main_domain >>>/api/v1/logging_query_rule/list?pageIndex=1&pageSize=5' \
-H 'DF-API-KEY: <DF-API-KEY>' \
--compressed
```




## Response
```shell
{
    "code": 200,
    "content": [
        {
            "conditions": "`host` = wildcard('cvsdbvjk')",
            "createAt": 1695293435,
            "creator": "acnt_xxxx32",
            "deleteAt": -1,
            "extend": {
                "*host": [
                    "cvsdbvjk"
                ]
            },
            "id": 127,
            "indexes": [
                "default"
            ],
            "logic": "and",
            "memberCount": 29,
            "roleUUIDs": [
                "general"
            ],
            "status": 0,
            "updateAt": 1695293435,
            "updator": "acnt_xxxx32",
            "uuid": "lqrl_xxxx32",
            "workspaceUUID": "wksp_xxxx32"
        },
        {
            "conditions": "`app_id` IN ['cccc'] and `_dd` IN ['{\\\"sdk_name\\\":\\\"df_web_logs_sdk\\\",\\\"sdk_version\\\":\\\"2.0.19\\\"}']",
            "createAt": 1695092601,
            "creator": "acnt_xxxx32",
            "deleteAt": -1,
            "extend": {
                "_dd": [
                    "{\\\"sdk_name\\\":\\\"df_web_logs_sdk\\\",\\\"sdk_version\\\":\\\"2.0.19\\\"}"
                ],
                "app_id": [
                    "cccc"
                ]
            },
            "id": 126,
            "indexes": [
                "default"
            ],
            "logic": "and",
            "memberCount": 24,
            "roleUUIDs": [
                "readOnly"
            ],
            "status": 0,
            "updateAt": 1695092601,
            "updator": "acnt_xxxx32",
            "uuid": "lqrl_xxxx32",
            "workspaceUUID": "wksp_xxxx32"
        },
        {
            "conditions": " `browser` IN ['Chrome']  or  `client_ip` IN ['10.113.1.22']  or  `browser_version_major` NOT IN ['116'] ",
            "createAt": 1695091745,
            "creator": "acnt_xxxx32",
            "deleteAt": -1,
            "extend": {
                "-browser_version_major": [
                    "116"
                ],
                "browser": [
                    "Chrome"
                ],
                "client_ip": [
                    "10.113.1.22"
                ]
            },
            "id": 125,
            "indexes": [
                "default"
            ],
            "logic": "or",
            "memberCount": 24,
            "roleUUIDs": [
                "readOnly"
            ],
            "status": 0,
            "updateAt": 1695092025,
            "updator": "acnt_xxxx32",
            "uuid": "lqrl_xxxx32",
            "workspaceUUID": "wksp_xxxx32"
        },
        {
            "conditions": "`client_ip` IN ['10.113.1.22']",
            "createAt": 1695091650,
            "creator": "acnt_xxxx32",
            "deleteAt": -1,
            "extend": {
                "client_ip": [
                    "10.113.1.22"
                ]
            },
            "id": 124,
            "indexes": [
                "default"
            ],
            "logic": "or",
            "memberCount": 29,
            "roleUUIDs": [
                "general"
            ],
            "status": 0,
            "updateAt": 1695091650,
            "updator": "acnt_xxxx32",
            "uuid": "lqrl_xxxx32",
            "workspaceUUID": "wksp_xxxx32"
        },
        {
            "conditions": "`ip` IN ['172.16.5.9']",
            "createAt": 1693807151,
            "creator": "acnt_xxxx32",
            "deleteAt": -1,
            "extend": {
                "ip": [
                    "172.16.5.9"
                ]
            },
            "id": 113,
            "indexes": [
                "default"
            ],
            "logic": "and",
            "memberCount": 7,
            "roleUUIDs": [
                "role_xxxx32"
            ],
            "status": 0,
            "updateAt": 1693807151,
            "updator": "acnt_xxxx32",
            "uuid": "lqrl_xxxx32",
            "workspaceUUID": "wksp_xxxx32"
        }
    ],
    "errorCode": "",
    "message": "",
    "pageInfo": {
        "count": 5,
        "pageIndex": 1,
        "pageSize": 5,
        "totalCount": 59
    },
    "success": true,
    "traceId": "TRACE-78EEAF86-190D-4ADE-BA43-75962106F329"
} 
```