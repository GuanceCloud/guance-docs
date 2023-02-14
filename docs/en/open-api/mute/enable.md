# Enable a Mute Rule

---

<br />**post /api/v1/monitor/mute/\{mute_uuid\}/enable**

## Overview
Enable a mute rule according to `mute_uuid`.




## Routing Parameters

| Parameter Name        | Type     | Required   | Description              |
|:-----------|:-------|:-----|:----------------|
| mute_uuid | string | Y | mute rule UUID<br> |


## Supplementary Description of Parameters





## Request Example
```shell
curl 'https://openapi.guance.com/api/v1/monitor/mute/mute_d0736e059fd74d859cdcdce102687378/enable' \
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
    "traceId": "TRACE-5191E0CC-076F-42D4-80C6-16A3FC9E0A09"
} 
```




