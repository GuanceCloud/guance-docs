# Create Pipeline Rule

---

<br />**POST /api/v1/pipeline/add**

## Overview
Create a Pipeline

When the category type is `profiling`, the rule will only take effect if the field `CentralPLServiceSwitch` (returned by the `/workspace/get` interface) in the workspace configuration is set to true.

## Body Request Parameters

| Parameter Name        | Type     | Required   | Description              |
|:-------------------|:-------|:-----|:----------------|
| name | string | Y | Pipeline file name<br>Nullable: False <br>Maximum Length: 256 <br>$notSearchRegExp: [^a-zA-Z0-9_\u4e00-\u9fa5-]+ <br> |
| type | string | Y | Pipeline file type<br>Nullable: False <br>Options: ['local', 'central'] <br> |
| source | array |  | Selected source list<br>Nullable: False <br> |
| content | string | Y | Pipeline file content (base64 encoded)<br>Nullable: False <br> |
| testData | string |  | Test data (base64 encoded)<br>Nullable: False <br>Allows empty string: True <br> |
| isForce | boolean |  | Whether to replace when a default of the specific type exists<br>Nullable: False <br> |
| category | string | Y | Category<br>Nullable: False <br>Allows empty string: False <br>Options: ['logging', 'object', 'custom_object', 'network', 'tracing', 'rum', 'security', 'keyevent', 'metric', 'profiling', 'dialtesting', 'billing'] <br> |
| asDefault | int |  | Whether to set this as the default pipeline for the type, 1 for default, 0 for non-default<br>Nullable: False <br> |
| extend | json |  | Extended information<br>Nullable: False <br> |
| extend.appID | array |  | App ID<br>Nullable: True <br> |
| extend.measurement | array |  | Source origin<br>Nullable: True <br> |
| extend.loggingIndex | string |  | Log index<br>Nullable: True <br> |

## Additional Parameter Notes

## Request Example
```shell
curl 'https://openapi.guance.com/api/v1/notes/create' \
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