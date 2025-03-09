# Cancel a Sharded Upload Event

---

<br />**POST /api/v1/rum_sourcemap/upload_cancel**

## Overview
This is an optional third step in the SourceMap compressed file upload (sharded upload) operation. It cancels an already uploaded shard. This is generally used for resuming interrupted uploads or re-uploading shards.
For more details, refer to: [SourceMap Sharded Upload Associated Interface Usage Instructions](../../../studio-backend/sourcemap-multipart-upload-init/)




## Body Request Parameters

| Parameter Name | Type   | Required | Description              |
|:-----------|:-------|:-----|:----------------|
| uploadId | string | Y | Shard upload event ID<br>Can be empty: False <br> |

## Additional Parameter Notes



## Request Example
```shell
curl 'https://openapi.guance.com/api/v1/rum_sourcemap/upload_cancel' \
-H 'Content-Type: application/json' \
-H 'DF-API-KEY: <DF-API-KEY>' \
--data-raw $'{\n  "uploadId": "65ef45944fac157005cb73de48e81f161Lfv5UOs"\n}' \
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
    "traceId": "TRACE-3277AFBD-99D0-4532-ACE0-3ED677CC5E1E"
} 
```