# Create a single data access rule

---

<br />**POST /api/v1/logging_query_rule/add**

## Overview
Create a single data access rule




## Body Request Parameters

| Parameter Name        | Type     | Required   | Description              |
|:-------------------|:-------|:-----|:----------------|
| name | string |  | Name (Added in the iteration on 2024-09-04, default name, Creator_Creation Time)<br>Can be empty: False <br>Can be an empty string: False <br>Maximum length: 64 <br> |
| desc | string |  | Description (Added in the iteration on 2024-09-04)<br>Example: Description1 <br>Can be empty: False <br>Can be an empty string: True <br>Maximum length: 256 <br> |
| indexes | array | Y | Index uuids, ["*"] means all<br>Example: ['*'] <br>Can be empty: False <br> |
| roleUUIDs | array | Y | List of roles<br>Example: [] <br>Can be empty: False <br> |
| conditions | string | Y | Filtering search<br>Example: search <br>Can be empty: False <br> |
| extend | json |  | Custom extension fields defined by frontend<br>Example: xxx <br>Can be empty: False <br> |
| logic | string | Y | Logic field<br>Example: or <br>Can be empty: False <br> |
| maskFields | string |  | Masking fields, multiple fields separated by commas<br>Example: message,host <br>Can be empty: False <br>Can be an empty string: True <br> |
| reExprs | array |  | Regular expressions<br>Example: [{'name': 'jjj', 'reExpr': 'ss', 'enable': 0}, {'name': 'lll', 'reExpr': 'ss', 'enable': 1}] <br>Can be empty: False <br> |

## Additional Parameter Notes

Data description.*

*1. Role authorization access notes*
1. The specified roles can only query data within the specified query range.
2. If a user has multiple roles and one of these roles is not included in the roles of this rule, then this data access rule will not apply to this user, i.e., there will be no restriction on the query scope.
3. The logical relationship between multiple log data access rules in a workspace is "or".

*2. Request parameter descriptions*

| Parameter Name                |   type  | Required  |          Description          |
|-----------------------|----------|----|------------------------|
|name             |string|Y| Name|
|desc   |String     |N| Description|
|indexes |array     |Y| Log index information, if it's an authorized index outside the current workspace (must pass workspace authorization), use Workspace UUID:Index UUID, e.g.: ["wksp_111:lgim_222", "wksp_333:lgim_444"]|
|roleUUIDs         |array     |Y| List of role UUIDs|
|conditions         |string     |N| Actual filtering conditions for the data range used, example: "`device` IN ['PC'] and `session_has_replay` IN ['1']"|
|extend         |dict     |Y| Extended fields, storing the structural content of conditions for display on the frontend page, example: {"device": [ "PC"], "session_has_replay": [1]}|
|logic         |string     |N| Logical field, and/or, used to connect filtering conditions|
|maskFields         |string     |N| Masked fields, multiple fields separated by commas|
|reExprs         |array     |N| Regular expressions, example: [{"name":"1111","enable":true,"reExpr":"tkn_[\\da-z]*"},{"name":"liuyltest","enable":true,"reExpr":"test"}]|

--------------

## Request Example
```shell
curl 'https://openapi.<<< custom_key.brand_main_domain >>>/api/v1/logging_query_rule/add' \
-H 'Accept: application/json, text/plain, */*' \
-H 'Content-Type: application/json;charset=UTF-8' \
-H 'DF-API-KEY: <DF-API-KEY>' \
--data-raw $'{"name":"temp_test","desc":"test openapi","roleUUIDs":["general","role_3ac3042991c046f0b03452771012b268"],"indexes":["wksp_4b57c7bab38e4a2d9630f675dc20015d:lgim_f2a50518520b467a920103a19133fa8b","wksp_eee1a762ed954b7588e30d9bccb717d5:lgim_72143917855c48abae5d4fb1d2fb7a1f"],"extend":{"city":["Tafuna"]},"maskFields":"message","logic":"and","reExprs":[{"name":"Mask qq email","reExpr":"[a-zA-Z0-9_]+@<<< custom_key.brand_main_domain >>>","enable":true}],"conditions":"`city` IN [\'Tafuna\']"}' \
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
                "name": "Mask qq email",
                "reExpr": "[a-zA-Z0-9_]+@<<< custom_key.brand_main_domain >>>"
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