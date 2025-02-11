# Modify Field Management

---

<br />**POST /api/v1/field_cfg/\{field_uuid\}/modify**

## Overview
Modify field management


## Route Parameters

| Parameter Name        | Type     | Required | Description              |
|:---------------------|:---------|:--------|:-------------------------|
| field_uuid           | string   | Y       | Field UUID               |


## Body Request Parameters

| Parameter Name        | Type     | Required | Description              |
|:---------------------|:---------|:--------|:-------------------------|
| name                 | string   | Y       | Field name, within the same field source (fieldSource), the field name cannot be repeated. <br>Allow null: False <br>Allow empty string: False <br>Maximum length: 256 <br> |
| alias                | string   | Y       | Field alias <br>Allow null: False <br>Allow empty string: False <br>Maximum length: 256 <br> |
| unit                 | string   |         | Unit information, when fieldType is string, the unit will be set to null <br>Allow null: False <br>Maximum length: 256 <br>Allow empty string: True <br> |
| fieldType            | string   |         | Field type <br>Example: time <br>Allow null: False <br>Allow empty string: True <br>Possible values: ['int', 'float', 'boolean', 'string', 'long'] <br> |
| fieldSource          | string   |         | Field source <br>Example: time <br>Allow null: False <br>Allow empty string: True <br>Possible values: ['logging', 'object', 'custom_object', 'keyevent', 'tracing', 'rum', 'security', 'network', 'billing'] <br> |
| desc                 | string   |         | Field description <br>Example: Hostname <br>Allow null: False <br>Allow empty string: True <br>Maximum length: 3000 <br> |
| coverInner           | boolean  |         | Whether to overwrite if the added field name is the same as a system built-in field, true for overwrite, false for not <br>Example: True <br>Allow null: False <br> |

## Additional Parameter Notes

Parameter notes: Refer to the new addition interface

```



## Request Example
```shell
curl 'https://openapi.guance.com/api/v1/field_cfg/field_0f95016f7254494da088d878ce586477/modify' \
-H 'DF-API-KEY: <DF-API-KEY>' \
-H 'Accept: application/json, text/plain, */*' \
-H 'Accept-Language: en' \
-H 'Content-Type: application/json;charset=UTF-8' \
--data-raw '{"name":"test_load","alias":"as_load","fieldType":"int","desc":"modify_test","fieldSource":"","unit":"custom/[\"time\",\"ns\"]","coverInner":false}' \
--compressed
```



## Response
```shell
{"code":200,"content":{"alias":"as_load","aliasEn":"","createAt":1735628856,"creator":"wsak_73a0ad39c352477a9417f633670a0908","declaration":{"business":"","organization":"default_private_organization"},"deleteAt":-1,"desc":"modify_test","descEn":"","fieldSource":"","fieldType":"int","id":1791,"name":"test_load","status":0,"sysField":0,"unit":"custom/[\\"time\\",\\"ns\\"]","updateAt":1735635730.899186,"updator":"wsak_73a0ad39c352477a9417f633670a0908","uuid":"field_0f95016f7254494da088d878ce586477","workspaceUUID":"wksp_05adf2282d0d47f8b79e70547e939617"},"errorCode":"","message":"","success":true,"traceId":"TRACE-D11D56A9-BC80-48D4-903C-550D248204BD"} 
```