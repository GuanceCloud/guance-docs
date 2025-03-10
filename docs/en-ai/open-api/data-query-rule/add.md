# Create a Single Data Access Rule

---

<br />**POST /api/v1/data_query_rule/add**

## Overview
Create a single data access rule




## Body Request Parameters

| Parameter Name        | Type     | Required   | Description              |
|:---------------------|:---------|:----------|:------------------------|
| name | string | Y | Name<br>Allow empty: False <br>Allow empty string: False <br>Maximum length: 64 <br> |
| desc | string | N | Description<br>Example: Description1 <br>Allow empty: False <br>Allow empty string: True <br>Maximum length: 256 <br> |
| type | string | Y | Type<br>Allow empty: True <br>Optional values: ['logging', 'rum', 'tracing', 'metric'] <br> |
| indexes | array | Y | Log type, this field is required, index UUID, ["*"] indicates all<br>Example: ['*'] <br>Allow empty: False <br> |
| sources | array | Y | Resource UUID, ["*"] indicates all<br>Example: ['appid_96357a78f84041d28b5d7aaa6201a424'] <br>Allow empty: False <br> |
| roleUUIDs | array | Y | List of roles<br>Example: [] <br>Allow empty: False <br> |
| conditions | string | N | Filter condition<br>Example: search <br>Allow empty: False <br>Allow empty string: True <br> |
| extend | json | Y | Extended fields<br>Example: xxx <br>Allow empty: False <br> |
| logic | string | N | Logical field<br>Example: or <br>Allow empty: False <br> |
| maskFields | string | N | Masked fields, multiple fields separated by commas<br>Example: message,host <br>Allow empty: False <br>Allow empty string: True <br> |
| reExprs | array | N | Regular expressions<br>Example: [{'name': 'jjj', 'reExpr': '*', 'enable': 0}, {'name': 'lll', 'reExpr': '*', 'enable': 1}] <br>Allow empty: False <br> |

## Additional Parameter Notes

Data description.*

*1. Role Authorization Access Notes*
1. Specified roles can only query data within the specified query range.
2. If a user has multiple roles and some of these roles are not included in the rule's role list, this data access rule will not apply to the user, meaning it does not restrict the query range.
3. Multiple log data access rules within a workspace have an "or" logical relationship.

*2. Request Parameter Notes*

| Parameter Name                | Type  | Required  | Description          |
|-------------------------------|-------|-----------|----------------------|
| name                          | string | Y         | Name                 |
| desc                          | string | N         | Description          |
| type                          | string | Y         | Type (logging, rum, tracing, metric) |
| indexes                       | array  | Y         | Required when type is logging. For non-workspace indices (which must be authorized by workspace), use workspaceUUID:indexUUID, e.g., ["wksp_111:lgim_222", "wksp_333:lgim_444"] |
| sources                       | array  | Y         | Required when type is not logging. When type is rum, it is a list of app IDs; when type is tracing, it is a list of service names; when type is metric, it is a list of Mearsurement |
| roleUUIDs                     | array  | Y         | List of role UUIDs   |
| conditions                    | string | N         | Actual filter conditions used for the data range, e.g., "`device` IN ['PC'] and `session_has_replay` IN ['1']" |
| extend                        | dict   | Y         | Extended fields, storing the structure content of conditions for frontend display, e.g., {"device": ["PC"], "session_has_replay": [1]} |
| logic                         | string | N         | Logical field, and/or, used to connect filter conditions |
| maskFields                    | string | N         | Masked fields, multiple fields separated by commas |
| reExprs                       | array  | N         | Regular expressions, e.g., [{"name":"1111","enable":true,"reExpr":"tkn_[\\da-z]*"},{"name":"liuyltest","enable":true,"reExpr":"test"}] |

--------------




## Request Example
```shell
curl 'https://openapi.<<< custom_key.brand_main_domain >>>/api/v1/data_query_rule/add' \
-H 'Accept: application/json, text/plain, */*' \
-H 'Content-Type: application/json;charset=UTF-8' \
-H 'DF-API-KEY: <DF-API-KEY>' \
--data-raw $'{"name":"rum test","desc":"","roleUUIDs":["role_a1e8215c25474f0bb3809f2d56749ed9"],"indexes":[],"sources":["*"],"extend":{"env":["front"]},"maskFields":"*","logic":"and","type":"rum","reExprs":[{"name":"IPv4 Address Scan","reExpr":"\\\\b((25[0-5]|(2[0-4]|1?[0-9])?[0-9])\\\\.){3}(25[0-5]|(2[0-4]|1?[0-9])?[0-9])\\\\b","enable":true}],"conditions":"`env` IN [\'front\']"}' \
--compressed
```




## Response
```shell
{
    "code": 200,
    "content": {
        "conditions": "`env` IN ['front']",
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
            ]
        },
        "id": null,
        "indexes": [],
        "logic": "and",
        "maskFields": "*",
        "name": "rum test",
        "reExprs": [
            {
                "enable": true,
                "name": "IPv4 Address Scan",
                "reExpr": "\\b((25[0-5]|(2[0-4]|1?[0-9])?[0-9])\\.){3}(25[0-5]|(2[0-4]|1?[0-9])?[0-9])\\b"
            }
        ],
        "roleUUIDs": [
            "role_a1e8215c25474f0bb3809f2d56749ed9"
        ],
        "sources": [
            "*"
        ],
        "status": 0,
        "type": "rum",
        "updateAt": null,
        "updator": null,
        "uuid": "lqrl_dfe6330883ef4311afae5d380e2294a1",
        "workspaceUUID": "wksp_4b57c7bab38e4a2d9630f675dc20015d"
    },
    "errorCode": "",
    "message": "",
    "success": true,
    "traceId": "TRACE-EF351570-B1E0-4263-87DC-85EE7E9345C5"
} 
```