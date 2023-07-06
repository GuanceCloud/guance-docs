# Share a Snapshot

---

<br />**post /api/v1/snapshots/\{snapshot_uuid\}/share**

## Overview
Generate a sharing link for the specified snapshot from `snapshot_uuid`.




## Routing Parameters

| Parameter Name        | Type     | Required   | Description              |
|:-----------|:-------|:-----|:----------------|
| snapshot_uuid | string | Y | snapshot UUID<br> |


## Query Request Parameter

| Parameter Name        | Type     | Required   | Description              |
|:-----------|:-------|:-----|:----------------|
| hiddenTopBar | boolean |  | Whether to hide sidebar, default to false.<br>Allow null: False <br> |

## Supplementary Description of Parameters







## Response
```shell
{
    "code": 200,
    "content": {
        "shortUrl": "https://t.guance.com/HdPsQ",
        "token": "shared.eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJ3c191dWlkIjoid2tzcF8yZGM0MzFkNjY5MzcxMWViOGZmOTdhZWVlMDRiNTRhZiIsInNoYXJlX2NvbmZpZ191dWlkIjoic2hhcmVfMjk4YjJiOTBmMzk0NDkwOTg2ZmI2NmMyYjg3ZDJmODMiLCJleHBpcmF0aW9uQXQiOjE2NDI3NTExMjIsInJlc291cmNlVHlwZSI6InNuYXBzaG90In0.zjNAaVdtflGsZ46i1r9Q3hVHHfLhXRFUyp6wgWIIuoI"
    },
    "errorCode": "",
    "message": "",
    "success": true,
    "traceId": "TRACE-582B86B2-12C4-4A5D-9B26-83A5D527A994"
} 
```




