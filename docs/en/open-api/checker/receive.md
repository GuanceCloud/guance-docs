# [External Event Monitor] Event Acceptance

---

<br />**POST /api/v1/push-events/{secret}/{subUri}**

## Overview
Accepts an external event and generates corresponding event data based on the event.
Note: When the `secret` and `subUri` information does not match the information recorded in the monitor, this event will be ignored.



## Route Parameters

| Parameter Name        | Type     | Required   | Description              |
|:-------------------|:-------|:-----|:----------------|
| secret | string | Y | External event monitor secret (corresponding to the `secret` field when creating a monitor; if this value does not match the monitor configuration, the event will be ignored)<br> |
| subUri | string | Y | External event monitor subUri (corresponding to the `jsonScript`.`subUri` field when creating a monitor; if this value does not match the monitor configuration, the event will be ignored)<br> |


## Body Request Parameters

| Parameter Name        | Type     | Required   | Description              |
|:-------------------|:-------|:-----|:----------------|
| event | json | Y | Event data<br>Can be empty: False <br> |
| extraData | json |  | Extra data that will eventually be added to the df_meta.extra_data field of the event<br>Can be empty: False <br>$required: False <br> |

## Parameter Supplemental Notes

Parameter notes:

**Structure description of the body request parameters**

| Parameter Name                | Parameter Type     | Mandatory    | Parameter Description  | 
|-----------------------|----------|----------|----------|
|event                  |   json       |   Yes        |   Event data |
|extra_data             |   json       |   No        |   Extra data that will eventually be added to the df_meta.extra_data field of the event. Must conform to key:value format. |

**Structure description of the event request parameters**

| Parameter Name                | Parameter Type     | Mandatory    | Parameter Description  | 
|-----------------------|----------|----------|----------|
|date           |   int     |   No        |   Event time (unit: seconds) |
|status           |   string     |   Yes        |   Event status, options: critical, error, warning, info, ok |
|title            |   string     |   No        |   Event title |
|message          |   string     |   No        |   Event content |
|dimension_tags   |   json       |   No        |   Dimension tags, e.g.: { "host": "WebServer" } |
|check_value      |   float      |   No        |   Check value |
|User-defined fields      |   str      |   No        |   User-defined fields as top-level event fields and must meet restriction conditions starting from 2024-09-04 |


**Restriction Conditions for event.{User-defined fields}**

To avoid issues caused by reporting fields of different types with the same name, user-defined fields must meet the following restrictions:

1. Field values must be of string type (e.g., "abc", "123")  
2. Field names must not start with underscore _ or df_  
3. Field names must not conflict with the decomposed field names of dimension_tags or labels  
3. Field names must not use the following reserved fields (it is recommended that all custom fields start with a self-defined prefix such as ext_xxx, biz_xxx to distinguish them):  
    - date  
    - status  
    - source  
    - title  
    - message  
    - dimension_tags  
    - check_value  
    - time  
    - time_us  
    - timestamp  
    - workspace_uuid  
    - workspace_name  
    - extra_data  
    - create_time  



## Request Example
```shell
curl 'https://openapi.<<< custom_key.brand_main_domain >>>/api/v1/push-events/<secret>/<subUri>' \
  -H 'DF-API-KEY:  <DF-API-KEY>' \
  -H 'Content-Type: application/json;charset=UTF-8' \
  --data-raw '{"event":{"status":"warning","title":"External Event Monitor Test 1","message":"Hello, this is the message from the external event monitor","dimension_tags":{"heros":"caiwenji"},"check_value":20},"extraData":{"name":"xxxxxxxx"}}' \
  --compressed
```




## Response
```shell
{
    "code": 200,
    "content": {
        "data": {},
        "error": 200,
        "message": "",
        "ok": true,
        "reqCost": 458,
        "reqTime": "2023-10-19T07:26:30.743Z",
        "respTime": "2023-10-19T07:26:31.201Z",
        "traceId": "7390361544936022329"
    },
    "errorCode": "",
    "message": "",
    "success": true,
    "traceId": "7390361544936022329"
} 
```