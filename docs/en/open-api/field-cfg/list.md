# Get Field Management List

---

<br />**GET /api/v1/field_cfg/list**

## Overview
Get the field management list, including both built-in and custom field configurations.

## Query Request Parameters

| Parameter Name   | Type     | Required | Description                                          |
|:-------------|:-------|:-----|:----------------------------------------------------|
| search       | string | No   | Search by field name<br>Can be empty: False <br>  |
| pageIndex    | integer| No   | Page number<br>Can be empty: False <br>Example: 10 <br>$minValue: 1 <br> |
| pageSize     | integer| No   | Number of items per page<br>Can be empty: False <br>Example: 10 <br>$minValue: 1 <br>$maxValue: 1000 <br> |

## Additional Parameter Notes

Data Description

- Relevant Response Field Descriptions

| Parameter Name | Type | Description                                                 |
| -------------- | ---- | ----------------------------------------------------------- |
| sysField      | string | Whether it is a built-in field, 1: Built-in, 0: Custom. Built-in fields do not support modification |

## Request Example
```shell
curl 'https://openapi.<<< custom_key.brand_main_domain >>>/api/v1/field_cfg/list?pageIndex=1&pageSize=5' \
-H 'DF-API-KEY: <DF-API-KEY>' \
--compressed
```

## Response
```shell
{"code":200,"content":{"data":[{"alias":"d","createAt":1735629346,"creator":"acnt_188a1642077c406bb23049a3d33f0d1a","creatorInfo":{"acntWsNickname":"","email":"jlpass@qq.com","iconUrl":"","mobile":"","name":"Jin Jin","status":0,"username":"jlpass@qq.com","uuid":"acnt_188a1642077c406bb23049a3d33f0d1a","wsAccountStatus":0},"desc":"","fieldSource":"","fieldType":"","name":"action_id","sysField":0,"unit":"","updateAt":-1,"updator":"","updatorInfo":{},"uuid":"field_e99a8428395e412f90754a090e23243f"},{"alias":"dd","createAt":1735624546,"creator":"acnt_188a1642077c406bb23049a3d33f0d1a","creatorInfo":{"acntWsNickname":"","email":"jlpass@qq.com","iconUrl":"","mobile":"","name":"Jin Jin","status":0,"username":"jlpass@qq.com","uuid":"acnt_188a1642077c406bb23049a3d33f0d1a","wsAccountStatus":0},"desc":"","fieldSource":"logging","fieldType":"","name":"sdd","sysField":0,"unit":"","updateAt":-1,"updator":"","updatorInfo":{},"uuid":"field_f9c3a77d0196425eb46b143aaec40aab"},{"alias":"as_load","createAt":1735628856,"creator":"wsak_73a0ad39c352477a9417f633670a0908","creatorInfo":{"acntWsNickname":"","email":"wsak_73a0ad39c352477a9417f633670a0908","iconUrl":"","mobile":"","name":"Jin Lei Test","status":0,"username":"Jin Lei Test","uuid":"wsak_73a0ad39c352477a9417f633670a0908","wsAccountStatus":0},"desc":"modify_test","fieldSource":"","fieldType":"int","name":"test_load","sysField":0,"unit":"custom/[\\"time\\",\\"ns\\"]","updateAt":1735635731,"updator":"wsak_73a0ad39c352477a9417f633670a0908","updatorInfo":{"acntWsNickname":"","email":"wsak_73a0ad39c352477a9417f633670a0908","iconUrl":"","mobile":"","name":"Jin Lei Test","status":0,"username":"Jin Lei Test","uuid":"wsak_73a0ad39c352477a9417f633670a0908","wsAccountStatus":0},"uuid":"field_0f95016f7254494da088d878ce586477"},{"alias":"Profiling File Size","createAt":1712750400,"creator":"sys","creatorInfo":{"email":"SYS","mobile":"","name":"SYS","status":0,"username":"SYS","uuid":"","wsAccountStatus":0},"desc":"Profiling File Size","fieldSource":"tracing","fieldType":"int","name":"__file_size","sysField":1,"unit":"b","updateAt":1735635601,"updator":"sys","updatorInfo":{"email":"SYS","mobile":"","name":"SYS","status":0,"username":"SYS","uuid":"","wsAccountStatus":0},"uuid":"field_50c1d87e2be3422d975e50fd5cdfc6b2"},{"alias":"Data Source/Category","createAt":1712750400,"creator":"sys","creatorInfo":{"email":"SYS","mobile":"","name":"SYS","status":0,"username":"SYS","uuid":"","wsAccountStatus":0},"desc":"Data Source/Category","fieldSource":"","fieldType":"string","name":"__source","sysField":1,"unit":"","updateAt":1735635601,"updator":"sys","updatorInfo":{"email":"SYS","mobile":"","name":"SYS","status":0,"username":"SYS","uuid":"","wsAccountStatus":0},"uuid":"field_aace43ce78764733a6c4ea81da19d68f"}],"declaration":{"business":"","organization":"default_private_organization"}},"errorCode":"","message":"","pageInfo":{"count":5,"pageIndex":1,"pageSize":5,"totalCount":424},"success":true,"traceId":"TRACE-867A8BDB-A853-4FDD-BE9E-8E528FCB9C35"} 
```