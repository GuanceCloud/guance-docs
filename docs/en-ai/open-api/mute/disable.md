# Disable a Mute Rule

---

<br />**POST /api/v1/monitor/mute/\{mute_uuid\}/disable**

## Overview
Disable a mute rule based on `mute_uuid`




## Route Parameters

| Parameter Name    | Type     | Required | Description              |
|:-------------|:-------|:-----|:----------------|
| mute_uuid | string | Y | Mute rule UUID<br> |


## Additional Parameter Notes





## Request Example
```shell
curl 'https://openapi.guance.com/api/v1/monitor/mute/mute_xxxx32/disable' \
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
    "traceId": "TRACE-1969B4EA-18AE-4D23-AAC7-3FC6586493EB"
} 
```