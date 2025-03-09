# Modify a Single Data Access Rule

---

<br />**POST /api/v1/data_query_rule/\{query_rule_uuid\}/modify**

## Overview
Modify a single data access rule




## Route Parameters

| Parameter Name        | Type     | Required   | Description              |
|:----------------|:-------|:-----|:----------------|
| query_rule_uuid | string | Y | UUID of the rule<br> |


## Body Request Parameters

| Parameter Name        | Type     | Required   | Description              |
|:----------------|:-------|:-----|:----------------|
| name | string | Y | Name<br>Allow null: False <br>Allow empty string: False <br>Maximum length: 64 <br> |
| desc | string | N | Description<br>Example: Description1 <br>Allow null: False <br>Allow empty string: True <br>Maximum length: 256 <br> |
| indexes | array | N | Log type, this field is required, index UUIDs, ["*"] indicates all<br>Example: ['*'] <br>Allow null: False <br> |
| sources | array | N | Resource UUIDs, ["*"] indicates all<br>Example: ['appid_96357a78f84041d28b5d7aaa6201a424'] <br>Allow null: False <br> |
| roleUUIDs | array | Y | List of role UUIDs<br>Example: [] <br>Allow null: False <br> |
| conditions | string | N | Filter conditions<br>Example: search <br>Allow null: False <br>Allow empty string: True <br> |
| extend | json | N | Custom fields<br>Example: xxx <br>Allow null: False <br> |
| logic | string | N | Logical operator<br>Example: or <br>Allow null: False <br> |
| maskFields | string | N | Sensitive fields, multiple fields separated by commas<br>Example: message,host <br>Allow null: False <br>Allow empty string: True <br> |
| reExprs | array | N | Regular expressions<br>Example: [{'name': 'AA', 'reExpr': 'ss', 'enable': 0}, {'name': 'BB', 'reExpr': '.*', 'enable': 1}] <br>Allow null: False <br> |

## Additional Parameter Notes


*1. Request Parameter Explanation*

| Parameter Name                | Type  | Required  | Description          |
|-----------------------|----------|----|------------------------|
|name             |string|Y| Name|
|desc   |String     |N| Description|
|indexes |array     |Y| Required when type is logging, if it's an authorized index from another workspace (authorization must be granted), use WorkspaceUUID:IndexUUID, e.g., ["wksp_111:lgim_222", "wksp_333:lgim_444"]|
|sources |array     |Y| Required when type is not logging, for RUM it is a list of application appIds, for tracing it is a list of service names, for metrics it is a list of Mearsurement |
|roleUUIDs         |array     |Y| List of role UUIDs|
|conditions         |string     |N| Actual filter conditions used for data scope, e.g., "`device` IN ['PC'] and `session_has_replay` IN ['1']"|
|extend         |dict     |Y| Extended fields to store structured content of conditions for frontend display, e.g., {"device": [ "PC"], "session_has_replay": [1]}|
|logic         |string     |N| Logical operator, and/or, used to connect filter conditions|
|maskFields         |string     |N| Sensitive fields, multiple fields separated by commas|
|reExprs         |array     |N| Regular expressions, e.g., [{"name":"1111","enable":true,"reExpr":"tkn_[\\da-z]*"},{"name":"liuyltest","enable":true,"reExpr":"test"}]|

--------------




## Request Example
```shell
curl 'https://openapi.guance.com/api/v1/data_query_rule/lqrl_xxx/modify' \
-H 'Accept: application/json, text/plain, */*' \
-H 'Content-Type: application/json;charset=UTF-8' \
-H 'DF-API-KEY: <DF-API-KEY>' \
--data-raw $'{"name":"rum test","desc":"","roleUUIDs":["role_a1e8215c25474f0bb3809f2d56749ed9","role_aa49795a5a5a4753a2a6350ab57f9497"],"indexes":[],"sources":["a2727170_7b1a_11ef_9de6_855cb2bccffb"],"extend":{"env":["front"],"province":["jiangsu"]},"maskFields":"source","logic":"and","conditions":"`env` IN [\'front\'] and `province` IN [\'jiangsu\']","reExprs":[{"name":"liuyl","reExpr":".*","enable":true}]}' \
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
        "roleUUIDs": [
            "role_a1e8215c25474f0bb3809f2d56749ed9",
            "role_aa49795a5a5a4753a2a6350ab57f9497"
        ],
        "sources": [
            "a2727170_7b1a_11ef_9de6_855cb2bccffb"
        ],
        "status": 0,
        "type": "rum",
        "updateAt": 1730532375.5740402,
        "updator": "wsak_cd83804176e24ac18a8a683260ab0746",
        "uuid": "lqrl_dfe6330883ef4311afae5d380e2294a1",
        "workspaceUUID": "wksp_4b57c7bab38e4a2d9630f675dc20015d"
    },
    "errorCode": "",
    "message": "",
    "success": true,
    "traceId": "TRACE-289325B8-AA1E-4AE3-BDB8-D1BE195FB8A8"
} 
```