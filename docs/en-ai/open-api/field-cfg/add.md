# Add Field Management

---

<br />**POST /api/v1/field_cfg/add**

## Overview
Create a new field management configuration



## Body Request Parameters

| Parameter Name        | Type     | Required   | Description              |
|:------------------|:-------|:-----|:----------------|
| name | string | Y | Field name, within the same field source (fieldSource), the field name must be unique<br>Allow null: False <br>Allow empty string: False <br>Maximum length: 256 <br> |
| alias | string | Y | Field alias<br>Allow null: False <br>Allow empty string: False <br>Maximum length: 256 <br> |
| unit | string |  | Unit information, when fieldType is string, the unit will be set to null<br>Allow null: False <br>Maximum length: 256 <br>Allow empty string: True <br> |
| fieldType | string |  | Field type<br>Example: time <br>Allow null: False <br>Allow empty string: True <br>Possible values: ['int', 'float', 'boolean', 'string', 'long'] <br> |
| fieldSource | string |  | Field source<br>Example: time <br>Allow null: False <br>Allow empty string: True <br>Possible values: ['logging', 'object', 'custom_object', 'keyevent', 'tracing', 'rum', 'security', 'network', 'billing'] <br> |
| desc | string |  | Field description<br>Example: Hostname <br>Allow null: False <br>Allow empty string: True <br>Maximum length: 3000 <br> |
| coverInner | boolean |  | Whether to overwrite system internal fields if the added field name conflicts with an existing internal field, true for overwrite, false for not overwriting<br>Example: True <br>Allow null: False <br> |

## Additional Parameter Notes


**1. Request Parameter Explanation**

| Parameter Name                | Type  | Required  | Description          |
|-----------------------|----------|----|------------------------|
|name                   |String|Required| Field name, within the same field source (fieldSource), the field name must be unique|
|alias                   |String|Required| Field alias|
|desc                   |String|| Description|
|unit                   |String|| Unit information, when fieldType is string, the unit will be set to null|
|fieldType                   |String|| Field type|
|fieldSource                   |String|| Field source, use empty string for generic types|
|coverInner                   |String|| Whether to overwrite system internal fields if the added field name conflicts with an existing internal field, true for overwrite, false for not overwriting|

For adding unit information, refer to [Unit Description](../../../studio-backend/unit/)

--------------

**2. Response Parameter Explanation**

When the content returned by this API is `need_confirm`, it indicates that there already exists a built-in field with the same source and name.
      <br/>
If you wish to continue creating, you need to specify `coverInner` as true, which will hide the existing internal field.

--------------

**3. Usage Instructions for Field Management**

3.1. Field management provides field descriptions for queries.
                  <br/>
When performing certain function queries, if you need to return field descriptions, specify `fieldTagDescNeeded` (at the same level as `queries`) as true.
            <br/>
The `series` returned will include a `value_desc` field (at the same level as `values` and `columns`).

| Function                | Field Source/fieldSource  |
|-----------------------|----------|
|SHOW_TAG_KEY       |  ""  |
|SHOW_OBJECT_HISTORY_FIELD       |  "object"  |
|SHOW_BACKUP_LOG_FIELD       |  "logging"  |
|SHOW_PROFILING_FIELD       |  "tracing"  |
|SHOW_OBJECT_FIELD       |  "object"  |
|SHOW_LOGGING_FIELD       |  "logging"  |
|SHOW_EVENT_FIELD       |  "keyevent"  |
|SHOW_TRACING_FIELD       |  "tracing"  |
|SHOW_RUM_FIELD       |  "rum"  |
|SHOW_CUSTOM_OBJECT_FIELD       |  "custom_object"  |
|SHOW_CUSTOM_OBJECT_HISTORY_FIELD       |  "custom_object"  |
|SHOW_NETWORK_FIELD       |  "network"  |
|SHOW_SECURITY_FIELD       |  "security"  |
|SHOW_UNRECOVERED_EVENT_FIELD       |  "keyevent"  |
|SHOW_TRACING_METRIC_FIELD       |  "tracing"  |
|SHOW_RUM_METRIC_FIELD       |  "rum"  |
|SHOW_NETWORK_METRIC_FIELD       |  "network"  |

Note: The field description for `SHOW_FIELD_KEY` uses custom metric configurations and the `measurements-meta.json` from datakit.

3.2. Field management provides unit information for queries.

For DQL query unit loading (`units` are added to the series in the `query_data` results):
                  <br/>
When querying `Metrics` data, the loaded unit information is from custom metric fields, overriding the official metric fields (`measurements-meta.json`)
                  <br/>
When querying `non-Metrics` data, the loaded unit information is defined in field management
                  <br/>

3.3. Query function explanations when field management provides unit information

During DQL queries, if the used function is not within the configured `unitWhiteFuncs` functions, units will not be added, e.g., `count`
                        <br/>
`unitWhiteFuncs` contains two types of functions: `normal` and `special`. When using `special` functions, units will have a fixed suffix `/s`, unit = {"unit": unit, "suffix": "/s"}
                        <br/>
The `unitWhiteFuncs` functions are explained as follows:
```yaml
unitWhiteFuncs:
  normal:
    - avg
    - bottom
    - top
    - difference
    - non_negative_difference
    - distinct
    - first
    - last
    - max
    - min
    - percentile
    - sum
    - median
    - mode
    - spread
    - moving_average
    - abs
    - cumsum
    - moving_average
    - series_sum
    - round
    - window
  special:
    - derivative
    - non_negative_derivative
    - rate
    - irate
```

**4. Field Name Priority Explanation**

4.1. Custom fields take precedence over built-in fields
                  <br/>
4.2. Fields with specific sources (fieldSource) take precedence over generic source fields

--------------

## Request Example
```shell
curl 'https://openapi.guance.com/api/v1/field_cfg/add' \
-H 'DF-API-KEY: <DF-API-KEY>' \
-H 'Accept: application/json, text/plain, */*' \
-H 'Accept-Language: en' \
-H 'Content-Type: application/json;charset=UTF-8' \
--data-raw '{"name":"test_load","alias":"as_load","fieldType":"float","desc":"temp","fieldSource":"","unit":"","coverInner":false}' \
--compressed
```




## Response
```shell
{
    "code": 200,
    "content": {
        "alias": "as_load",
        "aliasEn": "",
        "createAt": 1735628856,
        "creator": "wsak_xxx",
        "declaration": {
            "business": "",
            "organization": "default_private_organization"
        },
        "deleteAt": -1,
        "desc": "temp",
        "descEn": "",
        "fieldSource": "",
        "fieldType": "float",
        "id": 1791,
        "name": "test_load",
        "status": 0,
        "sysField": 0,
        "unit": "",
        "updateAt": -1,
        "updator": "",
        "uuid": "field_0f95016f7254494da088d878ce586477",
        "workspaceUUID": "wksp_05adf2282d0d47f8b79e70547e939617"
    },
    "errorCode": "",
    "message": "",
    "success": true,
    "traceId": "TRACE-5E004BC0-E1E0-459A-8843-6FECBF0353DF"
} 
```