# Enable a Mute Rule

---

<br />**POST /api/v1/monitor/mute/\{mute_uuid\}/enable**

## Overview
Enable a mute rule based on the `mute_uuid`




## Route Parameters

| Parameter Name    | Type     | Required | Description              |
|:-------------|:-------|:-----|:----------------|
| mute_uuid | string | Y | Mute rule UUID<br> |


## Additional Parameter Notes





## Request Example
```shell
curl 'https://openapi.<<< custom_key.brand_main_domain >>>/api/v1/monitor/mute/mute_xxxx32/enable' \
-H 'DF-API-KEY: <DF-API-KEY>' \
-H 'Content-Type: application/json;charset=UTF-8' \
--data-raw 'null' \
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
    "traceId": "TRACE-5191E0CC-076F-42D4-80C6-16A3FC9E0A09"
} 
```