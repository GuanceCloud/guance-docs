# Get a Single Data Access Rule

---

<br />**GET /api/v1/logging_query_rule/{logging_query_rule_uuid}/get**

## Overview
Retrieve a single data access rule


## Route Parameters

| Parameter Name            | Type   | Required | Description              |
|:---------------------|:------|:-------|:----------------|
| logging_query_rule_uuid | string | Yes  | Data access rule UUID<br> |


## Additional Parameter Notes



## Request Example
```shell
curl 'https://openapi.guance.com/api/v1/logging_query_rule/lqrl_xxxx32/get' \
-H 'DF-API-KEY: <DF-API-KEY>' \
--compressed
```


## Response
```shell
{
    "code": 200,
    "content": {
        "conditions": "`source` IN ['http_dial_testing']",
        "createAt": 1730529443,
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
        "desc": "test openapi modify",
        "extend": {
            "source": [
                "http_dial_testing"
            ]
        },
        "id": 348,
        "indexWsInfo": {
            "wksp_4b57c7bab38e4a2d9630f675dc20015d:lgim_f2a50518520b467a920103a19133fa8b": {
                "indexInfo": {
                    "name": "keyongxing",
                    "status": 0
                },
                "wsInfo": {
                    "name": "[Doris] Development and Testing Shared",
                    "status": 0
                }
            }
        },
        "indexes": [
            "wksp_4b57c7bab38e4a2d9630f675dc20015d:lgim_f2a50518520b467a920103a19133fa8b"
        ],
        "logic": "and",
        "maskFields": "host,message",
        "name": "temp_test",
        "reExprs": [
            {
                "enable": true,
                "name": "Mask QQ Email Addresses",
                "reExpr": "[a-zA-Z0-9_]+@qq.com"
            }
        ],
        "relRoleInfos": [
            {
                "name": "Standard",
                "status": 0,
                "uuid": "general"
            }
        ],
        "roleUUIDs": [
            "general"
        ],
        "sources": [],
        "status": 0,
        "type": "logging",
        "updateAt": 1730529851,
        "updator": "wsak_cd83804176e24ac18a8a683260ab0746",
        "uuid": "lqrl_9f1de1d1440f4af5917a534299d0ad09",
        "workspaceUUID": "wksp_4b57c7bab38e4a2d9630f675dc20015d"
    },
    "errorCode": "",
    "message": "",
    "success": true,
    "traceId": "TRACE-A88B73EE-C5EC-472F-8F2C-4755A9335A2D"
} 
```