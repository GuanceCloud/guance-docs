# Upload a Single Shard

---

<br />**POST /api/v1/rum_sourcemap/upload_part**

## Overview
This is the second step in the operation of uploading a compressed SourceMap file (shard upload). It involves uploading a single shard.
For more details, refer to: [SourceMap Shard Upload Related Interface Usage Instructions](../../../studio-backend/sourcemap-multipart-upload-init/)




## Additional Parameter Notes

Note 1: The size of a single shard file should be controlled within 10MB.




## Request Example
```shell
curl 'https://openapi.guance.com/api/v1/rum_sourcemap/upload_part' \
-H 'Content-Type: multipart/form-data' \
-H 'DF-API-KEY: <DF-API-KEY>' \
-F 'uploadId="65ef45944fac157005cb73de48e81f161Lfv5UOs"' \
-F 'chunkIndex="0"' \
-F 'files=@"/Users/someone/Downloads/browser-sdk.zip"'
```




## Response
```shell
{
    "code": 200,
    "content": {
        "chunkIndex": "0",
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
    "traceId": "TRACE-17F98E26-C0AD-4D2B-99AA-BE5AD243B867"
} 
```