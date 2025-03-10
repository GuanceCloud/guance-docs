# Create Field Management

---

<br />**POST /api/v1/field_cfg/add**

## Overview
Create field management



## Body Request Parameters

| Parameter Name        | Type     | Required   | Description              |
|:-------------------|:-------|:-----|:----------------|
| name | string | Y | Field name, within the same field source (fieldSource), field names cannot be duplicated<br>Allow null: False <br>Allow empty string: False <br>Maximum length: 256 <br> |
| alias | string | Y | Field alias<br>Allow null: False <br>Allow empty string: False <br>Maximum length: 256 <br> |
| unit | string |  | Unit information, when fieldType is string, the unit will be set to null<br>Allow null: False <br>Maximum length: 256 <br>Allow empty string: True <br> |
| fieldType | string |  | Field type<br>Example: time <br>Allow null: False <br>Allow empty string: True <br>Possible values: ['int', 'float', 'boolean', 'string', 'long'] <br> |
| fieldSource | string |  | Field source<br>Example: time <br>Allow null: False <br>Allow empty string: True <br>Possible values: ['logging', 'object', 'custom_object', 'keyevent', 'tracing', 'rum', 'security', 'network', 'billing'] <br> |
| desc | string |  | Field description<br>Example: Hostname <br>Allow null: False <br>Allow empty string: True <br>Maximum length: 3000 <br> |
| coverInner | boolean |  | Whether to overwrite system-built-in fields with the same name as the added field name, true for overwrite, false for not overwrite<br>Example: True <br>Allow null: False <br> |

## Additional Parameter Explanation


**1. Request Parameter Explanation**

| Parameter Name                | Type  | Required  | Description          |
|-----------------------|----------|----|------------------------|
|name                   |String|Required| Field name, within the same field source (fieldSource), field names cannot be duplicated|
|alias                   |String|Required| Field alias|
|desc                   |String|| Description|
|unit                   |String|| Unit information, when fieldType is string, the unit will be set to null|
|fieldType                   |String|| Field type|
|fieldSource                   |String|| Field source, generic types use an empty string|
|coverInner                   |String|| Whether to overwrite system-built-in fields with the same name as the added field name, true for overwrite, false for not overwrite|

For adding unit information, refer to [Unit Description](../../../studio-backend/unit/)

--------------

**2. Response Parameter Explanation**

When the returned content of this interface is need_confirm, it indicates that there already exists a built-in field with the same source and name.
      <br/>
If you wish to continue creating, you must specify coverInner as true, and the existing built-in field with the same name will be hidden.

--------------

**3. Usage Instructions for Field Management**

3.1. Field management provides field descriptions for field queries.
                  <br/>
When performing the following function queries, if you need to return field descriptions, you should specify fieldTagDescNeeded (at the same level as queries) as true.
            <br/>
The series in the response will add a value_desc field (at the same level as values and columns).

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

Note: The field description for SHOW_FIELD_KEY uses custom metric configuration and datakit side measurements-meta.json

3.2. Field management provides unit information for queries

dql query unit loading (adding units to the series in the query_data result):
                  <br/>
When querying Metrics data, the loaded unit information is from custom metric fields, overriding official metric fields (measurements-meta.json)
                  <br/>
When querying non-Metrics data, the loaded unit information is defined in field management
                  <br/>

3.3. Query function explanation when field management provides unit information

During dql queries, if the used function is not within the configured unitWhiteFuncs functions, no unit is added, for example: count
                        <br/>
unitWhiteFuncs contains two types of functions: normal and special. When using special functions, a fixed suffix "/s" is added to the unit, unit = {"unit": unit, "suffix": "/s"}
                        <br/>
unitWhiteFuncs function explanation:
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
4.2. Fields with specific sources (fieldSource) take precedence over generic field sources

--------------




## Request Example
```shell
curl 'https://openapi.<<< custom_key.brand_main_domain >>>/api/v1/field_cfg/add' \
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