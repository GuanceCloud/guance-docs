# Create Pipeline Rule

---

<br />**POST /api/v1/pipeline/add**

## Overview
Create a Pipeline

When the category type is profiling, the space configuration field CentralPLServiceSwitch (returned by the /workspace/get interface) must be true for this rule to take effect.

## Body Request Parameters

| Parameter Name        | Type     | Required   | Description              |
|:------------------|:-------|:-----|:----------------|
| name | string | Y | Pipeline file name<br>Allow null: False <br>Maximum length: 256 <br>$notSearchRegExp: [^a-zA-Z0-9_\u4e00-\u9fa5-]+ <br> |
| type | string | Y | Pipeline file type<br>Allow null: False <br>Optional values: ['local', 'central'] <br> |
| source | array |  | Selected source list<br>Allow null: False <br> |
| content | string | Y | Pipeline file content (base64 encoded)<br>Allow null: False <br> |
| testData | string |  | Test data (base64 encoded)<br>Allow null: False <br>Allow empty string: True <br> |
| isForce | boolean |  | When default exists for specific types, whether to replace it<br>Allow null: False <br> |
| category | string | Y | Category<br>Allow null: False <br>Allow empty string: False <br>Optional values: ['logging', 'object', 'custom_object', 'network', 'tracing', 'rum', 'security', 'keyevent', 'metric', 'profiling', 'dialtesting', 'billing'] <br> |
| asDefault | int |  | Whether to set this as the default pipeline for its type, 1 for default, 0 for non-default<br>Allow null: False <br> |
| extend | json |  | Category<br>Allow null: False <br> |
| extend.appID | array |  | App ID<br>Allow null: True <br> |
| extend.measurement | array |  | Source origin<br>Allow null: True <br> |
| extend.loggingIndex | string |  | Log index<br>Allow null: True <br> |

## Additional Parameter Notes

## Request Example
```shell
curl 'https://openapi.<<< custom_key.brand_main_domain >>>/api/v1/notes/create' \
-H 'DF-API-KEY: <DF-API-KEY>' \
-H 'Content-Type: application/json;charset=UTF-8' \
--data-raw '{"name":"openapi_test","category":"logging","asDefault":0,"content":"YWRkX2tleShjaXR5LCAic2hhbmdoYWkiKQ==","testData":"W10=","source":["nsqlookupd"]}' \
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
        "creator": "xxxx",
        "deleteAt": -1,
        "extend": {},
        "id": null,
        "isSysTemplate": null,
        "name": "openapi_test",
        "status": 0,
        "testData": "W10=\n",
        "updateAt": 1678026470,
        "updator": "xxxx",
        "uuid": "pl_xxxx32",
        "workspaceUUID": "wksp_xxxx32"
    },
    "errorCode": "",
    "message": "",
    "success": true,
    "traceId": "TRACE-74509B6F-DE3D-4905-AC9F-4FD96ED78EC3"
} 
```