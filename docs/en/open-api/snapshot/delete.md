# Delete a Snapshot

---

<br />**post /api/v1/snapshots/\{snapshot_uuid\}/delete**

## Overview
Delete the specified snapshot configuration according to `snapshot_uuid`.




## Routing Parameters

| Parameter Name        | Type     | Required   | Description              |
|:-----------|:-------|:-----|:----------------|
| snapshot_uuid | string | Y | 快照UUID<br> |


## Supplementary Description of Parameters





## Request Example
```shell
curl 'https://openapi.guance.com/api/v1/snapshots/snap_f21905829a2946a7a22dc5e2b9280b26/delete' \
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
    "traceId": "TRACE-478399EF-25DA-4B91-9543-FFAC521E77B1"
} 
```




