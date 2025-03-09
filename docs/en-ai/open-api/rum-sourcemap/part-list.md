# List the Uploaded Parts Corresponding to a Sharded Upload Event

---

<br />**POST /api/v1/rum_sourcemap/part_list**

## Overview
This is an optional fourth step in the sourcemap compressed file upload (sharded upload) operation. It lists the parts that have already been uploaded. This is generally used for resuming interrupted uploads or checking shards.
For more details, refer to: [SourceMap Sharded Upload Related Interface Usage Instructions](../../../studio-backend/sourcemap-multipart-upload-init/)




## Body Request Parameters

| Parameter Name | Type   | Required | Description              |
|:--------------|:-------|:---------|:------------------------|
| uploadId      | string | Y        | Sharded upload event ID<br>Allow null: False <br> |

## Additional Parameter Notes





## Request Example
```shell
curl 'https://openapi.guance.com/api/v1/rum_sourcemap/part_list' \
-H 'Content-Type: application/json' \
-H 'DF-API-KEY: <DF-API-KEY>' \
--data-raw $'{\n  "uploadId": "65ef45944fac157005cb73de48e81f161Lfv5UOs"\n}' \
--compressed
```




## Response
```shell
{
    "code": 200,
    "content": {
        "chunkIndexs": [
            1
        ],
        "declaration": {
            "b": [
                "asfawfgajfasfafgafwba",
                "asfgahjfaf"
            ],
            "business": "aaa",
            "organization": "6540c09e4243b300077a9675"
        },
        "uploadId": "65ef45944fac157005cb73de48e81f161Lfv5UOs"
    },
    "errorCode": "",
    "message": "",
    "success": true,
    "traceId": "TRACE-8A543B50-9DFF-4C29-9D01-69892F5372BD"
} 
```