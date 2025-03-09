# Modify Pipeline Rule

---

<br />**POST /api/v1/pipeline/\{pl_uuid\}/modify**

## Overview
Modify a Pipeline

When the category type is `profiling`, the rule will only take effect if the field `CentralPLServiceSwitch` (returned by the `/workspace/get` interface) in the workspace configuration is `true`.

## Route Parameters

| Parameter Name | Type   | Required | Description               |
|:--------------|:-------|:---------|:--------------------------|
| pl_uuid       | string | Y        | ID of the Pipeline<br> |

## Body Request Parameters

| Parameter Name | Type   | Required | Description               |
|:--------------|:-------|:---------|:--------------------------|
| name          | string | Y        | Name of the Pipeline file, which is also its source type value<br>Allow empty: False <br>Maximum length: 256 <br>$notSearchRegExp: [^a-zA-Z0-9_\u4e00-\u9fa5-]+ <br> |
| type          | string | Y        | Type of the Pipeline file<br>Allow empty: False <br>Options: ['local', 'central'] <br> |
| source        | array  |          | Selected source list<br>Allow empty: False <br> |
| content       | string | Y        | Content of the pipeline file (base64 encoded)<br>Allow empty: False <br> |
| testData      | string |          | Test data (base64 encoded)<br>Allow empty: False <br>Allow empty string: True <br> |
| isForce       | boolean|          | Whether to replace when there exists a default for a specific type<br>Allow empty: False <br> |
| asDefault     | int    |          | Whether to set this as the default pipeline for this type, 1 for setting as default<br>Allow empty: False <br> |
| category      | string | Y        | Category<br>Allow empty: False <br>Allow empty string: False <br>Options: ['logging', 'object', 'custom_object', 'network', 'tracing', 'rum', 'security', 'keyevent', 'metric', 'profiling', 'dialtesting', 'billing'] <br> |
| extend        | json   |          | Category<br>Allow empty: False <br> |
| extend.appID  | array  |          | App ID<br>Allow empty: True <br> |
| extend.measurement | array |      | Source origin<br>Allow empty: True <br> |
| extend.loggingIndex | string |    | Log index<br>Allow empty: True <br> |

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
```shell
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