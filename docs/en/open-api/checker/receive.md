# [External Event Monitor] Event Acceptance

---

<br />**POST /api/v1/push-events/{secret}/{subUri}**

## Overview
Accept an external event and generate corresponding event data based on the event.
Note: When the `secret` and `subUri` information does not match the information recorded in the monitor, this event will be ignored.

## Route Parameters

| Parameter Name | Type   | Required | Description |
|:--------------|:-------|:--------|:----------------|
| secret        | string | Y       | External event monitor secret (corresponds to the `secret` field when creating a monitor; if this value does not match the monitor configuration, the event will be ignored)<br> |
| subUri        | string | Y       | External event monitor subUri (corresponds to the `jsonScript.subUri` field when creating a monitor; if this value does not match the monitor configuration, the event will be ignored)<br> |

## Body Request Parameters

| Parameter Name | Type   | Required | Description |
|:--------------|:-------|:--------|:----------------|
| event         | json   | Y       | Event data<br>Allow empty: False <br> |
| extraData     | json   |         | Additional data that will eventually be added to the df_meta.extra_data field of the event<br>Allow empty: False <br>$required: False <br> |

## Parameter Supplemental Notes

### Body Request Parameter Structure Explanation

| Parameter Name      | Parameter Type | Required | Parameter Description |
|---------------------|----------------|----------|-----------------------|
| event               | json           | Yes      | Event data            |
| extra_data          | json           | No       | Additional data that will eventually be added to the df_meta.extra_data field of the event. Must follow key:value format |

### Event Request Parameter Structure Explanation

| Parameter Name       | Parameter Type | Required | Parameter Description |
|----------------------|----------------|----------|-----------------------|
| date                 | int            | No       | Event time (unit: seconds) |
| status               | string         | Yes      | Event status, options: critical, error, warning, info, ok |
| title                | string         | No       | Event title           |
| message              | string         | No       | Event content         |
| dimension_tags       | json           | No       | Dimension tags, e.g., { "host": "WebServer" } |
| check_value          | float          | No       | Detection value       |
| User-defined Field   | str            | No       | User-defined fields as top-level event fields, must meet restriction conditions |

### Restrictions for `event.{User-defined Field}`

To avoid issues caused by reporting different types for the same field name, user-defined fields must meet the following restrictions:

1. The field value must be of string type (e.g., "abc", "123")
2. The field name must not start with an underscore `_` or `df_`
3. The field name must not conflict with the decomposed field names of `dimension_tags` or `labels`
4. The field name must not use the following reserved fields (it is recommended to prefix all custom fields with your own prefix, such as `ext_xxx`, `biz_xxx`, etc., to distinguish them):
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