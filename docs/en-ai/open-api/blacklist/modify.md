# Modify a Blacklist

---

<br />**POST /api/v1/blacklist/\{blist_uuid\}/modify**

## Overview
Modify an existing blacklist


## Route Parameters

| Parameter Name        | Type     | Required   | Description              |
|:-------------------|:-------|:-----|:----------------|
| blist_uuid | string | Y | Blacklist rule UUID<br>Allow null: False <br> |


## Body Request Parameters

| Parameter Name        | Type     | Required   | Description              |
|:-------------------|:-------|:-----|:----------------|
| name | string | Y | Name (Added in iteration on 2024-11-27)<br>Allow null: False <br>Allow empty string: False <br>Maximum length: 50 <br> |
| desc | string |  | Description (Added in iteration on 2024-11-27)<br>Example: Description1 <br>Allow null: False <br>Allow empty string: True <br>Maximum length: 256 <br> |
| type | string | Y | Blacklist type, enumerated values include ('object', 'custom_object', 'logging', 'keyevent', 'tracing', 'rum', 'network', 'security', 'profiling', 'metric')<br>Allow null: False <br> |
| source | string |  | Data source, when all sources are included, this field is re(`.*`)<br>Allow null: True <br>Allow empty string: False <br>Maximum character length: 128 <br> |
| sources | array |  | Data sources, used for multiple sources (when all sources are included, use the source field re(`.*`))<br>Allow null: True <br> |
| filters | array |  | Filter conditions<br>Allow null: True <br> |

## Additional Parameter Notes



## Request Example
```shell
curl 'https://openapi.guance.com/api/v1/blacklist/blist_xxxx32/modify' \
-H 'DF-API-KEY: <DF-API-KEY>' \
-H 'Content-Type: application/json;charset=UTF-8' \
--data-raw '{"name":"Rule 1","desc":"","type":"logging","source":"kodo-log","filters":[{"name":"hostname","value":["127.0.0.1"],"operation":"in","condition":"and"}]}' \
--compressed
```




## Response
```shell
{
    "code": 200,
    "content": {
        "conditions": "{ source =  'kodo-log'  and ( hostname in [ '127.0.0.1' ] )}",
        "createAt": 1677653414,
        "creator": "acnt_xxxx32",
        "deleteAt": -1,
        "desc": "",
        "filters": [
            {
                "condition": "and",
                "name": "hostname",
                "operation": "in",
                "value": [
                    "127.0.0.1"
                ]
            }
        ],
        "id": 24,
        "name": "Rule 1",
        "source": "kodo-log",
        "status": 0,
        "type": "logging",
        "updateAt": 1678029845.282458,
        "updator": "xxxx",
        "uuid": "blist_xxxx32",
        "workspaceUUID": "wksp_xxxx32"
    },
    "errorCode": "",
    "message": "",
    "success": true,
    "traceId": "TRACE-BC365EB4-B4BA-4194-B0BB-B1AC8FA29804"
} 
```