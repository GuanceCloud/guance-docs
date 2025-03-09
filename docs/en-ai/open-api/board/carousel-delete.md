# Delete Dashboard Carousel Configuration

---

<br />**POST /api/v1/dashboard/carousel/\{carousel_uuid\}/delete**

## Overview




## Route Parameters

| Parameter Name    | Type   | Required | Description              |
|:-------------|:-----|:------|:----------------|
| carousel_uuid | string | Y | Carousel dashboard UUID<br> |


## Additional Parameter Notes





## Request Example
```shell
curl 'https://openapi.guance.com/api/v1/dashboard/carousel/csel_xxxx32/delete' \
-H 'DF-API-KEY: <DF-API-KEY>' \
-H 'Accept-Language: en' \
-H 'Content-Type: application/json;charset=UTF-8' \
-H 'Accept: application/json, text/plain, */*' \
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
    "traceId": "TRACE-2AC4E9C9-E599-49C2-899E-8EAAF4C67E3F"
} 
```