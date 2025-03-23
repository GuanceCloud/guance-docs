# Create Pipeline Rule

---

<br />**POST /api/v1/pipeline/add**

## Overview
Create a Pipeline

When the category type is profiling, the rule will only take effect if the field CentralPLServiceSwitch in the space configuration (returned by the /workspace/get interface) is true.



## Body Request Parameters

| Parameter Name        | Type     | Required   | Description              |
|:---------------------|:---------|:-----------|:------------------------|
| name | string | Y | Pipeline file name<br>Can be empty: False <br>Maximum length: 256 <br>$notSearchRegExp: [^a-zA-Z0-9_\u4e00-\u9fa5-]+ <br> |
| type | string | Y | Pipeline file type<br>Can be empty: False <br>Possible values: ['local', 'central'] <br> |
| source | array |  | Selected source list<br>Can be empty: False <br> |
| content | string | Y | Pipeline file content (base64 encoded)<br>Can be empty: False <br> |
| testData | string |  | Test data (base64 encoded)<br>Can be empty: False <br>Can be an empty string: True <br> |
| dataType | string |  | Data type line_protocol-line protocol format; json-JSON format; message-Message<br>Example: line_protocol <br>Can be empty: False <br>Can be an empty string: True <br>Possible values: ['line_protocol', 'json', 'message'] <br> |
| isForce | boolean |  | If default exists for the specific type, whether to replace it<br>Can be empty: False <br> |
| category | string | Y | Category<br>Can be empty: False <br>Can be an empty string: False <br>Possible values: ['logging', 'object', 'custom_object', 'network', 'tracing', 'rum', 'security', 'keyevent', 'metric', 'profiling', 'dialtesting', 'billing', 'keyevent'] <br> |
| asDefault | int |  | Whether to set this as the default pipeline for the type, 1 to set as default, 0 for not default<br>Can be empty: False <br> |
| enableByLogBackup | int |  | Enable Pipeline processing of forwarded data, 1 for enabled, 0 for disabled<br>Can be empty: False <br> |
| extend | json |  | Category<br>Can be empty: False <br> |
| extend.appID | array |  | appID<br>Can be empty: True <br> |
| extend.measurement | array |  | Source origin<br>Can be empty: True <br> |
| extend.loggingIndex | string |  | LOG index<br>Can be empty: True <br> |

## Supplementary Parameter Explanation



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