# Disable a Mute Rule

---

<br />**post /api/v1/monitor/mute/\{mute_uuid\}/disable**

## Overview
Disable a mute rule according to `mute_uuid`.




## Routing Parameters

| Parameter Name        | Type     | Required   | Description              |
|:-----------|:-------|:-----|:----------------|
| mute_uuid | string | Y | mute rule UUID<br> |


## Supplementary Description of Parameters





## Request Example
```shell
curl 'https://openapi.guance.com/api/v1/monitor/mute/mute_71e719ee94f84d65a3fa68fb3054a815/disable' \
-H 'DF-API-KEY: <DF-API-KEY>' \
-H 'Content-Type: application/json;charset=UTF-8' \
--data-raw 'null' \
--compressed \
--insecure
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




