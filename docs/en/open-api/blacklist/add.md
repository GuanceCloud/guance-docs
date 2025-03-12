# Create a Blacklist

---

<br />**POST /api/v1/blacklist/add**

## Overview
Create a blacklist



## Route Parameters

| Parameter Name        | Type     | Required   | Description              |
|:-------------------|:-------|:-----|:----------------|
| name | string | Y | Name (Added in iteration on 2024-11-27)<br>Allow null: False <br>Allow empty string: False <br>Maximum length: 50 <br> |
| desc | string | Y | Description (Added in iteration on 2024-11-27)<br>Example: Description1 <br>Allow null: False <br>Allow empty string: True <br>Maximum length: 256 <br> |
| type | string | Y | Blacklist type, enumerated values are ('object', 'custom_object', 'logging', 'keyevent', 'tracing', 'rum', 'network', 'security', 'profiling', 'metric')<br>Allow null: False <br> |
| source | string | Y | Data source, when all sources are used, `source` is re(`.*`)<br>Allow null: True <br>Allow empty string: False <br>Max character length: 128 <br> |
| sources | array | Y | Data source, use this field for multiple sources, not all sources (use `source` field re(`.*`) for all sources)<br>Allow null: True <br> |
| filters | array | Y | Filtering conditions<br>Allow null: True <br> |


## Additional Parameter Notes

--------------
**1. Request Body Field Descriptions**

| Parameter Name        | Type  | Required  | Description          |
|---------------|----------|----|------------------------|
| name    | string  | Y | Name (Added in iteration on 2024-11-27) |
| desc    | string  | N | Description (Added in iteration on 2024-11-27) |
| type    | string  | Y | Enumerated values ('object', 'custom_object', 'logging', 'keyevent', 'tracing', 'rum', 'network', 'security', 'profiling', 'metric') |
| source  | string  | N | Data source, all sources, at this time `source` is re(`.*`) |
| sources  | array  | N | Data source, field added in the iteration on 2024-10-16, supports multiple source selections. When the source is not all sources, this field can be used, `sources` has priority over the `source` field |
| filter    | array  | N | Filtering conditions |

**2. Source Field Description**

When generating filtering conditions for the blacklist, the key of the `source` field will be replaced based on the `type`

| Type        | Key corresponding to the `source` field when generating filtering conditions |
|---------------|----------|
| object    | class  |
| logging    | source  |
| custom_object    | class  |
| keyevent    | source  |
| tracing    | service  |
| rum    | app_id  |
| network    | source  |
| security    | category  |
| profiling    | service  |
| metric    | measurement  |


**3. Filters Array Element Field Descriptions**

| Parameter Name        | Type  | Required  | Description          |
|---------------|----------|----|------------------------|
| name    | string  | N | Filter condition name |
| operation | string  | N | Operation such as in, not_in, match, not_match |
| condition    | string  | N | DQL formatted filtering condition |
| values    | array  | N | Specific query condition values |

**4. Operation Description**
Refer to Line Protocol Filters [<<< homepage >>>/datakit/datakit-filter/](<<< homepage >>>/datakit/datakit-filter/)

| Key | Description |
|---|----|
| in | Specified field is in the list |
| not_in | Specified field is not in the list |
| match | Regular expression match |
| not_match | Regular expression does not match |

**Filters Example**
```json
[
    {
        "name": "host",
        "value": [
            "host1", "host2"
        ],
        "operation": "in",
        "condition": "and"
    },
    {
        "name": "status",
        "value": [
            "a*"
        ],
        "operation": "match",
        "condition": "and"
    }
]
```



## Request Example
```shell
curl 'https://openapi.<<< custom_key.brand_main_domain >>>/api/v1/blacklist/add' \
-H 'DF-API-KEY: <DF-API-KEY>' \
-H 'Content-Type: application/json;charset=UTF-8' \
--data-raw '{"name":"Rule1","desc":"","type":"logging","source":"kodo-log","filters":[{"name":"host","value":["127.0.0.1"],"operation":"in","condition":"and"}]}' \
--compressed
```




## Response
```json
{
    "code": 200,
    "content": {
        "conditions": "{ source =  'kodo-log'  and ( host in [ '127.0.0.1' ] )}",
        "createAt": 1678029404,
        "creator": "xxxx",
        "deleteAt": -1,
        "desc": "",
        "filters": [
            {
                "condition": "and",
                "name": "host",
                "operation": "in",
                "value": [
                    "127.0.0.1"
                ]
            }
        ],
        "id": null,
        "name": "Rule1",
        "source": "kodo-log",
        "status": 0,
        "type": "logging",
        "updateAt": 1678029404,
        "updator": "xxxx",
        "uuid": "blist_xxxx32",
        "workspaceUUID": "wksp_xxxx32"
    },
    "errorCode": "",
    "message": "",
    "success": true,
    "traceId": "TRACE-1C3DFE84-E7AD-4956-B363-8BB7EB3CD5A4"
} 
```