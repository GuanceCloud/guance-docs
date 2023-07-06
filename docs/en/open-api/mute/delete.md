# Delete a Mute Rule

---

<br />**post /api/v1/monitor/mute/\{mute_uuid\}/delete**

## Overview
Delete a mute rule according to `mute_uuid`.




## Routing Parameters

| Parameter Name        | Type     | Required   | Description              |
|:-----------|:-------|:-----|:----------------|
| mute_uuid | string | Y | mute rule UUID<br> |


## Supplementary Description of Parameters





## Request Example
```shell
curl 'https://openapi.guance.com/api/v1/monitor/mute/None/delete' \
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
    "content": {},
    "errorCode": "",
    "message": "",
    "success": true,
    "traceId": "TRACE-0ABCD3FC-9441-4617-9301-A95299460890"
} 
```




