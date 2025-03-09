# Merge Shards to Generate File

---

<br />**POST /api/v1/rum_sourcemap/part_merge**

## Overview
This is the fifth step in the operation of uploading a compressed SourceMap file (uploading in shards). It involves merging the uploaded shards into a single compressed SourceMap file. For more details, refer to: [SourceMap Shard Upload Interface Usage Instructions](../../../studio-backend/sourcemap-multipart-upload-init/)




## Body Request Parameters

| Parameter Name    | Type   | Required | Description              |
|:--------------|:-----|:-------|:----------------------|
| uploadId     | string | Y      | Shard upload event ID<br>Allow empty: False <br> |
| chunkIndexs  | array |        | List of shards<br>Allow empty: False <br>Allow empty strings: False <br> |

## Additional Parameter Notes



## Request Example
```shell
curl 'https://openapi.guance.com/api/v1/rum_sourcemap/part_merge' \
-H 'Content-Type: application/json' \
-H 'DF-API-KEY: <DF-API-KEY>' \
--data-raw $'{\n  "uploadId": "65ef45944fac157005cb73de48e81f161Lfv5UOs"\n}' \
--compressed
```




## Response
```shell
{
    "code": 200,
    "content": {},
    "errorCode": "",
    "message": "",
    "success": true,
    "traceId": "TRACE-4CC300F8-2407-42C3-B8D2-1C706CE38DF8"
} 
```