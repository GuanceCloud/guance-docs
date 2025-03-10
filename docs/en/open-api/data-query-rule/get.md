# Get a Single Data Access Rule

---

<br />**GET /api/v1/data_query_rule/\{query_rule_uuid\}/get**

## Overview
Retrieve a single data access rule


## Route Parameters

| Parameter Name        | Type     | Required   | Description              |
|:---------------------|:---------|:----------|:-------------------------|
| query_rule_uuid       | string   | Y         | Data access rule UUID    |


## Additional Parameter Notes



## Request Example
```shell
curl 'https://openapi.<<< custom_key.brand_main_domain >>>/api/v1/data_query_rule/lqrl_xxxx32/get' \
-H 'DF-API-KEY: <DF-API-KEY>' \
--compressed
```


## Response
```shell
{
    "code": 200,
    "content": {
        "conditions": "`env` IN ['front'] and `province` IN ['jiangsu']",
        "createAt": 1730532068,
        "creator": "wsak_cd83804176e24ac18a8a683260ab0746",
        "declaration": {
            "asd": "aa,bb,cc,1,True",
            "asdasd": "dawdawd",
            "business": "aaa",
            "dd": "dd",
            "fawf": "afawf",
            "organization": "64fe7b4062f74d0007b46676"
        },
        "deleteAt": -1,
        "desc": "",
        "extend": {
            "env": [
                "front"
            ],
            "province": [
                "jiangsu"
            ]
        },
        "id": 351,
        "indexes": [],
        "logic": "and",
        "maskFields": "source",
        "name": "rum test",
        "reExprs": [
            {
                "enable": true,
                "name": "liuyl",
                "reExpr": ".*"
            }
        ],
        "relRoleInfos": [
            {
                "name": "gary-test-1016",
                "status": 0,
                "uuid": "role_a1e8215c25474f0bb3809f2d56749ed9"
            },
            {
                "name": "Shortcut Custom Filter",
                "status": 0,
                "uuid": "role_aa49795a5a5a4753a2a6350ab57f9497"
            }
        ],
        "roleUUIDs": [
            "role_a1e8215c25474f0bb3809f2d56749ed9",
            "role_aa49795a5a5a4753a2a6350ab57f9497"
        ],
        "sources": [
            "a2727170_7b1a_11ef_9de6_855cb2bccffb"
        ],
        "sourcesWsInfo": {
            "a2727170_7b1a_11ef_9de6_855cb2bccffb": {
                "sourcesInfo": {
                    "name": "New Application-hd",
                    "status": 0,
                    "type": "web"
                },
                "wsInfo": {
                    "name": "[Doris] Development and Testing Together_",
                    "status": 0
                }
            }
        },
        "status": 0,
        "type": "rum",
        "updateAt": 1730532376,
        "updator": "wsak_cd83804176e24ac18a8a683260ab0746",
        "uuid": "lqrl_dfe6330883ef4311afae5d380e2294a1",
        "workspaceUUID": "wksp_4b57c7bab38e4a2d9630f675dc20015d"
    },
    "errorCode": "",
    "message": "",
    "success": true,
    "traceId": "TRACE-D3CCFB8F-DFA2-42B5-B704-4BD8ACFFC12F"
} 
```