# Modify Pipeline Rule

---

<br />**POST /api/v1/pipeline/\{pl_uuid\}/modify**

## Overview
Modify a Pipeline

When the type category is profiling, the field `CentralPLServiceSwitch` (returned by the `/workspace/get` interface) in the workspace configuration must be true for this rule to take effect.

## Route Parameters

| Parameter Name | Type   | Required | Description                 |
|:--------------|:-------|:--------|:---------------------------|
| pl_uuid       | string | Y       | ID of the Pipeline          |

## Body Request Parameters

| Parameter Name     | Type   | Required | Description                                                                                                             |
|:------------------|:-------|:--------|:-----------------------------------------------------------------------------------------------------------------------|
| name              | string | Y       | Pipeline file name, also its source type value.<br>Allow null: False <br>Maximum length: 256 <br>$notSearchRegExp: [^a-zA-Z0-9_\u4e00-\u9fa5-]+ <br> |
| type              | string | Y       | Pipeline file type<br>Allow null: False <br>Possible values: ['local', 'central'] <br>                                                               |
| source            | array  |         | Selected source list<br>Allow null: False <br>                                                                                                       |
| content           | string | Y       | Content of the pipeline file (base64 encoded)<br>Allow null: False <br>                                                                               |
| testData          | string |         | Test data (base64 encoded)<br>Allow null: False <br>Allow empty string: True <br>                                                                    |
| isForce           | boolean|         | Whether to replace when specific types have defaults<br>Allow null: False <br>                                                                        |
| asDefault         | int    |         | Whether to set this as the default pipeline for the type, 1 means set as default<br>Allow null: False <br>                                            |
| category          | string | Y       | Category<br>Allow null: False <br>Allow empty string: False <br>Possible values: ['logging', 'object', 'custom_object', 'network', 'tracing', 'rum', 'security', 'keyevent', 'metric', 'profiling', 'dialtesting', 'billing'] <br> |
| extend            | json   |         | Extend information<br>Allow null: False <br>                                                                                                          |
| extend.appID      | array  |         | App ID<br>Allow null: True <br>                                                                                                                       |
| extend.measurement| array  |         | Source origin<br>Allow null: True <br>                                                                                                                 |
| extend.loggingIndex| string|         | Log index<br>Allow null: True <br>                                                                                                                    |

## Additional Parameter Notes

## Request Example
```shell
curl 'https://openapi.guance.com/api/v1/pipeline/pl_xxxx32/modify' \
-H 'DF-API-KEY: <DF-API-KEY>' \
-H 'Content-Type: application/json;charset=UTF-8' \
--data-raw '{"name":"test_modify","category":"logging","asDefault":0,"content":"YWRkX2tleShjaXR5LCAic2hhbmdoYWkiKQ==","testData":"W10=","source":["nsqlookupd"]}' \
--compressed
```

## Response
```json
{
    "code": 200,
    "content": {
        "asDefault": 0,
        "category": "logging",
        "content": "YWRkX2tleShjaXR5LCAic2hhbmdoYWkiKQ==\n",
        "createAt": 1678026470,
        "creator": "xxx",
        "deleteAt": -1,
        "extend": {},
        "id": 86,
        "isSysTemplate": 0,
        "name": "test_modify",
        "source": [],
        "status": 0,
        "testData": "W10=\n",
        "updateAt": 1678026808.95266,
        "updator": "xx",
        "uuid": "pl_xxxx32",
        "workspaceUUID": "wksp_xxxx32"
    },
    "errorCode": "",
    "message": "",
    "success": true,
    "traceId": "TRACE-1EA80DD4-EB2C-4A9B-A146-D00606CC50E0"
}
```