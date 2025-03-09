# [External Event Monitor] Event Acceptance

---

<br />**POST /api/v1/push-events/\{secret\}/\{subUri\}**

## Overview
Accept an external event and generate corresponding event data based on the event.
Note: If the `secret` and `subUri` information does not match the information recorded in the monitor, this event will be ignored.



## Route Parameters

| Parameter Name | Type   | Required | Description |
|:--------------|:-------|:---------|:------------|
| secret        | string | Y        | External event monitor secret (corresponds to the `secret` field when creating a monitor; if this value does not match the monitor configuration, the event will be ignored) |
| subUri        | string | Y        | External event monitor subUri (corresponds to the `jsonScript`.`subUri` field when creating a monitor; if this value does not match the monitor configuration, the event will be ignored) |


## Body Request Parameters

| Parameter Name | Type | Required | Description |
|:--------------|:-----|:---------|:------------|
| event         | json | Y        | Event data <br> Allow null: False <br> |
| extraData     | json |          | Additional data that will ultimately be added to the `df_meta.extra_data` field of the event <br> Allow null: False <br> $required: False <br> |

## Parameter Supplemental Explanation

Parameter explanation:

**Body request parameter structure explanation**

| Parameter Name            | Parameter Type | Required | Parameter Description |
|---------------------------|----------------|----------|-----------------------|
| event                     | json           | Yes      | Event data            |
| extra_data                | json           | No       | Additional data that will ultimately be added to the `df_meta.extra_data` field of the event. It should follow the key:value format |

**Event request parameter structure explanation**

| Parameter Name           | Parameter Type | Required | Parameter Description |
|--------------------------|----------------|----------|-----------------------|
| date                     | int            | No       | Event time (unit: seconds) |
| status                   | string         | Yes      | Event status, options: critical, error, warning, info, ok |
| title                    | string         | No       | Event title           |
| message                  | string         | No       | Event content         |
| dimension_tags           | json           | No       | Dimension tags, e.g., { "host": "WebServer" } |
| check_value              | float          | No       | Check value           |
| user-defined-field       | str            | No       | User-defined fields as top-level fields of the event, and must meet restriction conditions |

**event.{user-defined-field} Restriction Conditions**

To avoid issues caused by reporting different types for the same field name, user-defined fields must meet the following restrictions:

1. Field values must be string type (e.g., "abc", "123")
2. Field names cannot start with an underscore `_` or `df_`
3. Field names cannot conflict with `dimension_tags` decomposed field names or `labels` decomposed field names
4. Field names cannot use the following reserved fields (it is recommended that all custom fields start with a self-defined prefix, such as `ext_xxx`, `biz_xxx`, etc., for differentiation):
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
curl 'https://openapi.guance.com/api/v1/push-events/<secret>/<subUri>' \
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