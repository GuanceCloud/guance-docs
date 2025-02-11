# New

---

<br />**POST /api/v1/data_mask_rule/add**

## Overview




## Body Request Parameters

| Parameter Name | Type   | Required | Description |
|:--------------|:-------|:--------|:------------|
| name          | string | Y       | Rule name<br>Allow null: False <br>Maximum length: 128 <br>Allow empty string: False <br> |
| type          | string | Y       | Data type<br>Example: logging <br>Allow null: True <br>Possible values: ['logging', 'metric', 'object', 'custom_object', 'keyevent', 'tracing', 'rum', 'security', 'network', 'profiling', 'billing'] <br> |
| field         | string | Y       | Field name<br>Allow null: False <br>Maximum length: 128 <br>Allow empty string: False <br> |
| reExpr        | string | Y       | Regular expression<br>Allow null: False <br>Maximum length: 5000 <br>Allow empty string: False <br> |
| roleUUIDs     | array  | Y       | Which roles in the workspace this rule applies to for data masking<br>Example: ['xxx', 'xxx'] <br>Allow null: False <br> |

## Additional Parameter Notes





## Request Example
```shell
curl 'https://openapi.guance.com/api/v1/data_mask_rule/add' \
-H 'Content-Type: application/json' \
-H 'DF-API-KEY: <DF-API-KEY>' \
--data-raw '{"name":"lwcTest","type":"logging","reExpr":"\\b(?:[0-9A-Fa-f]{2}[:-]){5}(?:[0-9A-Fa-f]{2})\\b","roleUUIDs":["readOnly"],"field":"message"}' \
--compressed
```




## Response
```shell
{
    "code": 200,
    "content": {
        "workspaceUUID": "wksp_xxxx",
        "name": "lwcTest",
        "type": "logging",
        "field": "message",
        "reExpr": "\\b(?:[0-9A-Fa-f]{2}[:-]){5}(?:[0-9A-Fa-f]{2})\\b",
        "roleUUIDs": [
            "readOnly"
        ],
        "id": 153,
        "uuid": "wdmk_xxx",
        "status": 0,
        "creator": "acnt_xxxx",
        "updator": "acnt_xxxx",
        "createAt": 1718107343,
        "deleteAt": -1,
        "updateAt": 1718107343
    },
    "errorCode": "",
    "message": "",
    "success": true,
    "traceId": "TRACE-953C271A-768B-4123-9B7C-D13B621C552B"
} 
```