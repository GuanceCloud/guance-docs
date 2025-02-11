# Sharded Upload Event Initialization

---

<br />**POST /api/v1/rum_sourcemap/multipart_upload_init**

## Overview
This is the first step in the operation of uploading a compressed sourcemap file (sharded upload). It initializes a sharded upload event. The subsequent sharded uploads and file merging will use the event identifier ID (`uploadId`). For more details, refer to: [SourceMap Sharded Upload Associated Interface Usage Instructions](../../../studio-backend/sourcemap-multipart-upload-init/)

## Body Request Parameters

| Parameter Name | Type   | Required | Description |
|:--------------|:-------|:---------|:------------|
| needCover     | boolean|          | Whether to forcibly overwrite an existing file. Default is `false`, meaning no overwrite.<br>Can be null: False <br> |
| appId         | string | Y        | `appId`<br>Can be null: False <br> |
| version       | string |          | Version<br>Can be null: False <br>Can be an empty string: True <br> |
| env           | string |          | Environment<br>Can be null: False <br>Can be an empty string: True <br> |

## Additional Parameter Notes

Note 1: Only one sourcemap with the same `version` and `env` can exist under the same application. You can overwrite an existing sourcemap using the `needCover` parameter. If not overwritten, `uploadId` will return as an empty string.

## Request Example
```shell
curl 'https://openapi.guance.com/api/v1/rum_sourcemap/multipart_upload_init' \
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