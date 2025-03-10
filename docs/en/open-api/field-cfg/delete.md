# Delete Field Management

---

<br />**POST /api/v1/field_cfg/delete**

## Overview
Delete field management

## Body Request Parameters

| Parameter Name | Type   | Required | Description                              |
|:--------------|:-------|:---------|:-----------------------------------------|
| objUUIDs      | array  | Y        | List of UUIDs for the fields<br>Allow null: False <br> |

## Additional Parameter Notes


## Request Example
```shell
curl 'https://openapi.<<< custom_key.brand_main_domain >>>/api/v1/field_cfg/delete' \
-H 'DF-API-KEY: <DF-API-KEY>' \
-H 'Accept: application/json, text/plain, */*' \
-H 'Accept-Language: en' \
-H 'Content-Type: application/json;charset=UTF-8' \
--data-raw '{"objUUIDs":["field_e99a8428395e412f90754a090e23243f", "field_f9c3a77d0196425eb46b143aaec40aab"]}' \
--compressed
```

## Response
```shell
{
    "code": 200,
    "content": true,
    "errorCode": "",
    "message": "",
    "success": true,
    "traceId": "TRACE-98CE1D22-B5ED-4186-A940-A50718572B36"
} 
```