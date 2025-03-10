# Delete an Alarm Policy

---

<br />**post /api/v1/monitor/group/\{monitor_uuid\}/delete**

## Overview
Delete the specified alarm policy according to `monitor_uuid` and transfer the checker under this packet to default packet.




## Routing Parameters

| Parameter Name        | Type     | Required   | Description              |
|:-----------|:-------|:-----|:----------------|
| monitor_uuid | string | Y | Alarm policy UUID<br> |


## Supplementary Description of Parameters





## Request Example
```shell
curl 'https://openapi.guance.com/api/v1/monitor/group/monitor_70a7e8549ea54bbeaeb9e4eaec52bad2/delete' \
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
    "content": {
        "monitor_84cbb7c18f964771b8153fbca1013615": "修改后的名称"
    },
    "errorCode": "",
    "message": "",
    "success": true,
    "traceId": "TRACE-7ED823AD-60ED-40BD-ABDB-8D7F3F400B9F"
} 
```




