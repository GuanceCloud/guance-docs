# 【Service List】Delete

---

<br />**POST /api/v1/service_manage/delete**

## Overview
Delete Service List configuration



## Body Request Parameters

| Parameter Name    | Type   | Required | Description              |
|:--------------|:-----|:------|:----------------|
| serviceUUIDs | array | Y | Service List<br>Example: ['ss', 'yy'] <br>Can be empty: False <br> |

## Additional Parameter Notes



## Request Example
```shell
curl 'https://openapi.<<< custom_key.brand_main_domain >>>/api/v1/service_manage/delete' \
  -H 'Content-Type: application/json' \
  -H 'DF-API-KEY: <DF-API-KEY>' \
  --data-binary '{"serviceUUIDs":["sman_xxxx32", "sman_xxxx32"]}' \
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
    "traceId": "TRACE-83ED9066-842A-41E4-B693-5B8C98BD4FEC"
} 
```