# 【Custom Mapping Rules】Batch Delete Mapping Configurations

---

<br />**POST /api/v1/login_mapping/field/batch_delete**

## Overview




## Body Request Parameters

| Parameter Name | Type   | Required | Description              |
|:--------------|:-------|:---------|:-------------------------|
| lgmpUUIDs     | array  | Y        | List of mapping configuration UUIDs<br>Example: ['fdmp_xxx1', 'fdmp_xxx2'] <br> |

## Additional Parameter Notes





## Request Example
```shell
curl 'https://openapi.guance.com/api/v1/login_mapping/field/batch_delete' \
  -H 'Content-Type: application/json;charset=UTF-8' \
  -H 'DF-API-KEY: <DF-API-KEY>' \
  --data-raw '{"lgmpUUIDs": ["lgmp_xxxx32"]}' \
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
    "traceId": "16237433115105312000"
} 
```