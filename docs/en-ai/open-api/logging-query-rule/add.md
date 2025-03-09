# Create a Single Data Access Rule

---

<br />**POST /api/v1/logging_query_rule/add**

## Overview
Create a single data access rule



## Body Request Parameters

| Parameter Name        | Type     | Required   | Description              |
|:------------------|:-------|:-----|:----------------|
| name | string |  | Name (Added in iteration on 2024-09-04, default name: creator_creation time)<br>Allow null: False <br>Allow empty string: False <br>Maximum length: 64 <br> |
| desc | string |  | Description (Added in iteration on 2024-09-04)<br>Example: Description1 <br>Allow null: False <br>Allow empty string: True <br>Maximum length: 256 <br> |
| indexes | array | Y | Index UUIDs, ["*"] indicates all<br>Example: ['*'] <br>Allow null: False <br> |
| roleUUIDs | array | Y | List of roles<br>Example: [] <br>Allow null: False <br> |
| conditions | string | Y | Filtering conditions<br>Example: search <br>Allow null: False <br> |
| extend | json |  | Custom extension fields for the frontend<br>Example: xxx <br>Allow null: False <br> |
| logic | string | Y | Logical field<br>Example: or <br>Allow null: False <br> |
| maskFields | string |  | Masking fields, multiple fields separated by commas<br>Example: message,host <br>Allow null: False <br>Allow empty string: True <br> |
| reExprs | array |  | Regular expressions<br>Example: [{'name': 'jjj', 'reExpr': 'ss', 'enable': 0}, {'name': 'lll', 'reExpr': 'ss', 'enable': 1}] <br>Allow null: False <br> |

## Additional Parameter Explanation

Data description.*

*1. Role Authorization Access Explanation*
1. Specified roles can only query data within the specified query range.
2. If a user has multiple roles and some of these roles are not included in this rule's role list, then this data access rule will not apply to the user, meaning it does not restrict the query range.
3. Multiple log data access rules within a workspace have an "or" logical relationship.

*2. Request Parameter Explanation*

| Parameter Name                | Type  | Required  | Description          |
|-----------------------|----------|----|------------------------|
| name             |string|Y| Name|
| desc   |String     |N| Description|
| indexes |array     |Y| Log index information; if the index is from another workspace (which must be authorized), use WorkspaceUUID:IndexUUID, e.g., ["wksp_111:lgim_222", "wksp_333:lgim_444"]|
| roleUUIDs         |array     |Y| List of role UUIDs|
| conditions         |string     |N| Actual filtering conditions used for data scope, e.g., "`device` IN ['PC'] and `session_has_replay` IN ['1']"|
| extend         |dict     |Y| Extension fields, storing structured content of conditions for frontend display, e.g., {"device": [ "PC"], "session_has_replay": [1]}|
| logic         |string     |N| Logical field, and/or, used to connect filtering conditions|
| maskFields         |string     |N| Masking fields, multiple fields separated by commas|
| reExprs         |array     |N| Regular expressions, e.g., [{"name":"1111","enable":true,"reExpr":"tkn_[\\da-z]*"},{"name":"liuyltest","enable":true,"reExpr":"test"}]|

--------------



## Request Example
```shell
curl 'https://openapi.guance.com/api/v1/logging_query_rule/add' \
-H 'Accept: application/json, text/plain, */*' \
-H 'Content-Type: application/json;charset=UTF-8' \
-H 'DF-API-KEY: <DF-API-KEY>' \
--data-raw $'{"name":"temp_test","desc":"test openapi","roleUUIDs":["general","role_3ac3042991c046f0b03452771012b268"],"indexes":["wksp_4b57c7bab38e4a2d9630f675dc20015d:lgim_f2a50518520b467a920103a19133fa8b","wksp_eee1a762ed954b7588e30d9bccb717d5:lgim_72143917855c48abae5d4fb1d2fb7a1f"],"extend":{"city":["Tafuna"]},"maskFields":"message","logic":"and","reExprs":[{"name":"Mask QQ email","reExpr":"[a-zA-Z0-9_]+@qq.com","enable":true}],"conditions":"`city` IN [\'Tafuna\']"}' \
--compressed
```



## Response
```shell
{
    "code": 200,
    "content": {
        "conditions": "`city` IN ['Tafuna']",
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
        "desc": "test openapi",
        "extend": {
            "city": [
                "Tafuna"
            ]
        },
        "id": null,
        "indexes": [
            "wksp_4b57c7bab38e4a2d9630f675dc20015d:lgim_f2a50518520b467a920103a19133fa8b",
            "wksp_eee1a762ed954b7588e30d9bccb717d5:lgim_72143917855c48abae5d4fb1d2fb7a1f"
        ],
        "logic": "and",
        "maskFields": "message",
        "name": "temp_test",
        "reExprs": [
            {
                "enable": true,
                "name": "Mask QQ email",
                "reExpr": "[a-zA-Z0-9_]+@qq.com"
            }
        ],
        "roleUUIDs": [
            "general",
            "role_3ac3042991c046f0b03452771012b268"
        ],
        "sources": [],
        "status": 0,
        "type": "logging",
        "updateAt": null,
        "updator": null,
        "uuid": "lqrl_9f1de1d1440f4af5917a534299d0ad09",
        "workspaceUUID": "wksp_4b57c7bab38e4a2d9630f675dc20015d"
    },
    "errorCode": "",
    "message": "",
    "success": true,
    "traceId": "TRACE-25C229E5-150F-4DF1-8576-DE17259B7A16"
} 
```