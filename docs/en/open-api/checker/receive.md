# [External Event Monitor] Event Reception

---

<br />**POST /api/v1/push-events/{secret}/{subUri}**

## Overview
Receives an external event and generates corresponding event data based on the event.
Note: When the `secret` and `subUri` information does not match the information recorded in the monitor, the event will be ignored.



## Route Parameters

| Parameter Name        | Type     | Required   | Description              |
|:-------------------|:-------|:-----|:----------------|
| secret | string | Y | External event monitor secret (corresponding to the `secret` field when creating a monitor; if this value does not match the monitor configuration, the event will be ignored)<br> |
| subUri | string | Y | External event monitor subUri (corresponding to the `jsonScript`.`subUri` field when creating a monitor; if this value does not match the monitor configuration, the event will be ignored)<br> |


## Body Request Parameters

| Parameter Name        | Type     | Required   | Description              |
|:-------------------|:-------|:-----|:----------------|
| event | json | Y | Event data<br>Can be empty: False <br> |
| extraData | json |  | Additional data that will ultimately be added to the df_meta.extra_data field of the event<br>Can be empty: False <br>$required: False <br> |

## Parameter Supplementary Notes

Parameter description:

**Body request parameter structure description**

| Parameter Name                | Parameter Type     | Mandatory    | Parameter Description  | 
|-----------------------|----------|----------|----------|
|event                  |   json       |   Yes        |   Event data |
|extra_data             |   json       |   No        |   Additional data that will ultimately be added to the df_meta.extra_data field of the event. Meets key:value format |

**Event request parameter structure description**

| Parameter Name                | Parameter Type     | Mandatory    | Parameter Description  | 
|-----------------------|----------|----------|----------|
|date           |   int     |   No        |   Event time (unit: seconds) |
|status           |   string     |   Yes        |   Event status, options: critical, error, warning, info, ok |
|title            |   string     |   No        |   Event title |
|message          |   string     |   No        |   Event content |
|dimension_tags   |   json       |   No        |   Dimension tags, such as: { "host": "WebServer" } |
|check_value      |   float      |   No        |   Check value |
|User-defined fields      |   str      |   No        |   User-defined fields from September 4, 2024, as top-level fields of events, and must meet restriction conditions |


**event.{User-defined fields} Restriction Conditions Description**

To avoid issues caused by reporting different types for the same field name, user-defined fields must meet the following restrictions:

1. Field values must be string type (such as: "abc", "123")  
2. Field names cannot start with underscores _ or df_  
3. Field names cannot duplicate dimension_tags decomposed field names or labels decomposed field names  
3. Field names cannot use the following reserved fields (it is recommended to prefix all custom fields with self-defined prefixes like ext_xxx, biz_xxx to distinguish):  
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