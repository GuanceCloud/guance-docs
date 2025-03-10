# Initialize Multipart Upload Event

---

<br />**POST /api/v1/rum_sourcemap/multipart_upload_init**

## Overview
The first step in the operation of uploading a compressed SourceMap file (multipart upload). This initializes a multipart upload event. The subsequent multipart uploads and file merging will use this event identifier (uploadId).
For more details, refer to: [SourceMap Multipart Upload Interface Usage Instructions](../../../studio-backend/sourcemap-multipart-upload-init/)




## Body Request Parameters

| Parameter Name | Type   | Required | Description              |
|:-----------|:-------|:-----|:----------------|
| needCover | boolean | No | Whether to forcibly overwrite an existing file. Default is false, meaning no overwrite.<br>Allow null: False <br> |
| appId | string | Yes | appId<br>Allow null: False <br> |
| version | string | No | Version<br>Allow null: False <br>Allow empty string: True <br> |
| env | string | No | Environment<br>Allow null: False <br>Allow empty string: True <br> |

## Additional Parameter Notes

Note 1: Only one SourceMap with the same `version` and `env` can exist under the same application. You can overwrite an existing SourceMap using the `needCover` parameter.
If not overwritten, `uploadId` will be returned as an empty string.




## Request Example
```shell
curl 'https://openapi.<<< custom_key.brand_main_domain >>>/api/v1/rum_sourcemap/multipart_upload_init' \
-H 'Content-Type: application/json' \
-H 'DF-API-KEY: <DF-API-KEY>' \
--data-raw $'{\n  "needCover": true,\n  "appId": "app_demo",\n "version": "1.0.2",\n "env": "daily"\n}' \
--compressed
```




## Response
```shell
{
    "code": 200,
    "content": {
        "declaration": {
            "b": [
                "asfawfgajfasfafgafwba",
                "asfgahjfaf"
            ],
            "business": "aaa",
            "organization": "6540c09e4243b300077a9675"
        },
        "existsOldTask": false,
        "existsSameFile": false,
        "uploadId": "65ef45944fac157005cb73de48e81f161Lfv5UOs"
    },
    "errorCode": "",
    "message": "",
    "success": true,
    "traceId": "TRACE-6985B262-8F52-4AA0-9CE4-9277CE199DC3"
} 
```