# 【Custom Mapping Rules】Delete a Mapping Configuration

---

<br />**POST /api/v1/login_mapping/field/\{lgmp_uuid\}/delete**

## Overview




## Route Parameters

| Parameter Name | Type   | Required | Description              |
|:-----------|:-------|:-----|:----------------|
| lgmp_uuid | string | Y | Mapping configuration ID<br> |


## Additional Parameter Notes





## Request Example
```shell
curl 'https://openapi.guance.com/api/v1/login_mapping/field/lgmp_xxxx32/delete' \
  -H 'Content-Type: application/json;charset=UTF-8' \
  -H 'DF-API-KEY: <DF-API-KEY>' \
  --data-raw '{}' \
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
    "traceId": "16237433115105300199"
} 
```