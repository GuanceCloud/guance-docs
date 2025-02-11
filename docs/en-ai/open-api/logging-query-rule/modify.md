# Modify a Single Data Access Rule

---

<br />**POST /api/v1/logging_query_rule/\{logging_query_rule_uuid\}/modify**

## Overview
Modify a single data access rule



## Route Parameters

| Parameter Name        | Type     | Required   | Description              |
|:---------------------|:---------|:-----------|:-------------------------|
| logging_query_rule_uuid | string | Y | UUID of the rule<br> |


## Body Request Parameters

| Parameter Name        | Type     | Required   | Description              |
|:---------------------|:---------|:-----------|:-------------------------|
| name | string |  | Name (added in iteration on 2024-09-04, default name, creator_creation time)<br>Can be null: False <br>Can be empty string: False <br>Maximum length: 64 <br> |
| desc | string |  | Description (added in iteration on 2024-09-04)<br>Example: Description1 <br>Can be null: False <br>Can be empty string: True <br>Maximum length: 256 <br> |
| indexes | array | Y | Index UUIDs, ["*"] indicates all<br>Example: ['*'] <br>Can be null: False <br> |
| roleUUIDs | array | Y | List of roles<br>Example: [] <br>Can be null: False <br> |
| conditions | string | Y | Filtering criteria<br>Example: search <br>Can be null: False <br> |
| extend | json |  | Custom fields<br>Example: xxx <br>Can be null: False <br> |
| logic | string |  | Logical field<br>Example: or <br>Can be null: False <br> |
| maskFields | string |  | Masked fields, multiple fields separated by commas<br>Example: message,host <br>Can be null: False <br>Can be empty string: True <br> |
| reExprs | array |  | Regular expressions<br>Example: [{'name': 'jjj', 'reExpr': 'ss', 'enable': 0}, {'name': 'lll', 'reExpr': 'ss', 'enable': 1}] <br>Can be null: False <br> |

## Additional Parameter Explanation

Data explanation.*

*1. Role Authorization Access Explanation*
1. Specified roles can only query data within the specified query range.
2. If a user has multiple roles and some roles are not included in this rule's role list, then this data access rule will not apply to the user, meaning it does not restrict the query scope.
3. Multiple log data access rules within a workspace have an "or" relationship.

*2. Request Parameter Explanation*

| Parameter Name                | Type  | Required  | Description          |
|-------------------------------|-------|-----------|----------------------|
| name             | string | Y | Name |
| desc   | string     | N | Description |
| indexes | array     | Y | Log index information, if the index is from another workspace (must be authorized), use WorkspaceUUID:IndexUUID, e.g., ["wksp_111:lgim_222", "wksp_333:lgim_444"] |
| roleUUIDs         | array     | Y | List of role UUIDs |
| conditions         | string     | N | Actual filtering conditions used for data range, e.g., "`device` IN ['PC'] and `session_has_replay` IN ['1']" |
| extend         | dict     | Y | Extended fields, containing structured content of conditions for frontend display, e.g., {"device": ["PC"], "session_has_replay": [1]} |
| logic         | string     | N | Logical field, and/or, used to connect filtering conditions |
| maskFields         | string     | N | Masked fields, multiple fields separated by commas |
| reExprs         | array     | N | Regular expressions, e.g., [{"name":"1111","enable":true,"reExpr":"tkn_[\\da-z]*"},{"name":"liuyltest","enable":true,"reExpr":"test"}] |

--------------



## Request Example
```shell
curl 'https://openapi.guance.com/api/v1/logging_query_rule/lqrl_xxx/modify' \
-H 'Accept: application/json, text/plain, */*' \
-H 'Content-Type: application/json;charset=UTF-8' \
-H 'DF-API-KEY: <DF-API-KEY>' \
--data-raw $'{"name":"temp_test","desc":"test openapi modify","roleUUIDs":["general"],"indexes":["wksp_4b57c7bab38e4a2d9630f675dc20015d:lgim_f2a50518520b467a920103a19133fa8b"],"extend":{"source":["http_dial_testing"]},"maskFields":"host,message","logic":"and","conditions":"`source` IN [\'http_dial_testing\']","reExprs":[{"name":"Mask QQ email addresses","enable":true,"reExpr":"[a-zA-Z0-9_]+@qq.com"}]}' \
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
        "indexes": [
            "wksp_4b57c7bab38e4a2d9630f675dc20015d:lgim_f2a50518520b467a920103a19133fa8b"
        ],
        "logic": "and",
        "maskFields": "host,message",
        "name": "temp_test",
        "reExprs": [
            {
                "enable": true,
                "name": "Mask QQ email addresses",
                "reExpr": "[a-zA-Z0-9_]+@qq.com"
            }
        ],
        "roleUUIDs": [
            "general"
        ],
        "sources": [],
        "status": 0,
        "type": "logging",
        "updateAt": 1730529850.881453,
        "updator": "wsak_cd83804176e24ac18a8a683260ab0746",
        "uuid": "lqrl_9f1de1d1440f4af5917a534299d0ad09",
        "workspaceUUID": "wksp_4b57c7bab38e4a2d9630f675dc20015d"
    },
    "errorCode": "",
    "message": "",
    "success": true,
    "traceId": "TRACE-BA54F258-15AD-4752-88C9-CA2B96070625"
} 
```