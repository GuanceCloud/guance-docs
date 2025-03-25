# Modify a Single Data Access Rule

---

<br />**POST /api/v1/logging_query_rule/{logging_query_rule_uuid}/modify**

## Overview
Modify a single data access rule




## Route Parameters

| Parameter Name        | Type     | Required   | Description              |
|:-------------------|:-------|:-----|:----------------|
| logging_query_rule_uuid | string | Y | Rule's UUID<br> |


## Body Request Parameters

| Parameter Name        | Type     | Required   | Description              |
|:-------------------|:-------|:-----|:----------------|
| name | string |  | Name (Added in iteration on 2024-09-04, default name: Creator_Creation Time)<br>Can be empty: False <br>Can be an empty string: False <br>Maximum length: 64 <br> |
| desc | string |  | Description (Added in iteration on 2024-09-04)<br>Example: Description1 <br>Can be empty: False <br>Can be an empty string: True <br>Maximum length: 256 <br> |
| indexes | array | Y | Index UUIDs, ["*"] means all<br>Example: ['*'] <br>Can be empty: False <br> |
| roleUUIDs | array | Y | List of roles<br>Example: [] <br>Can be empty: False <br> |
| conditions | string | Y | Filtering search<br>Example: search <br>Can be empty: False <br> |
| extend | json |  | Custom<br>Example: xxx <br>Can be empty: False <br> |
| logic | string |  | Logical field<br>Example: or <br>Can be empty: False <br> |
| maskFields | string |  | Masking fields, multiple fields separated by commas<br>Example: message,host <br>Can be empty: False <br>Can be an empty string: True <br> |
| reExprs | array |  | Regular expressions<br>Example: [{'name': 'jjj', 'reExpr': 'ss', 'enable': 0}, {'name': 'lll', 'reExpr': 'ss', 'enable': 1}] <br>Can be empty: False <br> |

## Additional Parameter Notes

Data notes.*

*1. Role Authorization Access Notes*
1. The specified role can only query data within the specified query scope.
2. If a user has multiple roles and one of these roles is not included in this rule, then this data access rule will not apply to that user, meaning there will be no restriction on the query scope.
3. The logical relationship between multiple log data access rules in a workspace is "or".

*2. Request Parameter Notes*

| Parameter Name                | Type  | Required  | Description          |
|-----------------------|----------|----|------------------------|
| name             | string | Y | Name |
| desc   | String     | N | Description |
| indexes | array     | Y | Log index information; for indexes outside the current workspace (authorization must be granted), use Workspace UUID:Index UUID, e.g., ["wksp_111:lgim_222", "wksp_333:lgim_444"] |
| roleUUIDs         | array     | Y | List of role UUIDs |
| conditions         | string     | N | Actual filtering conditions for the data range, e.g., "`device` IN ['PC'] and `session_has_replay` IN ['1']" |
| extend         | dict     | Y | Extended fields, stores the structured content of conditions for display on the front-end page, e.g., {"device": [ "PC"], "session_has_replay": [1]} |
| logic         | string     | N | Logical field, and/or, used to connect filtering conditions |
| maskFields         | string     | N | Masking fields, multiple fields separated by commas |
| reExprs         | array     | N | Regular expressions, e.g., [{"name":"1111","enable":true,"reExpr":"tkn_[\\da-z]*"},{"name":"liuyltest","enable":true,"reExpr":"test"}] |

--------------




## Request Example
```shell
curl 'https://openapi.<<< custom_key.brand_main_domain >>>/api/v1/logging_query_rule/lqrl_xxx/modify' \
-H 'Accept: application/json, text/plain, */*' \
-H 'Content-Type: application/json;charset=UTF-8' \
-H 'DF-API-KEY: <DF-API-KEY>' \
--data-raw $'{"name":"temp_test","desc":"test openapi modify","roleUUIDs":["general"],"indexes":["wksp_4b57c7bab38e4a2d9630f675dc20015d:lgim_f2a50518520b467a920103a19133fa8b"],"extend":{"source":["http_dial_testing"]},"maskFields":"host,message","logic":"and","conditions":"`source` IN [\'http_dial_testing\']","reExprs":[{"name":"对qq邮箱进行脱敏","enable":true,"reExpr":"[a-zA-Z0-9_]+@<<< custom_key.brand_main_domain >>>"}]}' \
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
                "name": "对qq邮箱进行脱敏",
                "reExpr": "[a-zA-Z0-9_]+@<<< custom_key.brand_main_domain >>>"
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