# Delete a Snapshot

---

<br />**POST /api/v1/snapshots/\{snapshot_uuid\}/delete**

## Overview
Delete the specified snapshot configuration based on `snapshot_uuid`



## Route Parameters

| Parameter Name    | Type   | Required | Description              |
|:-------------|:-----|:------|:----------------|
| snapshot_uuid | string | Y | Snapshot UUID<br> |


## Additional Parameter Notes



## Request Example
```shell
curl 'https://openapi.guance.com/api/v1/snapshots/snap_xxxx32/delete' \
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
    "traceId": "TRACE-478399EF-25DA-4B91-9543-FFAC521E77B1"
} 
```