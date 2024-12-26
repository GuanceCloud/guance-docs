# 上传单个分片

---

<br />**POST /api/v1/rum_sourcemap/upload_part**

## 概述
sourcemap 压缩文件上传(分片上传)操作中的第二步操作。上传一个分片。
详情参考: [SourceMap分片上传关联接口使用说明](../../../studio-backend/sourcemap-multipart-upload-init/)




## 参数补充说明

注1：单片文件大小控制在 10MB 以内




## 请求例子
```shell
curl 'https://openapi.guance.com/api/v1/rum_sourcemap/upload_part' \
-H 'Content-Type: multipart/form-data' \
-H 'DF-API-KEY: <DF-API-KEY>' \
-F 'uploadId="65ef45944fac157005cb73de48e81f161Lfv5UOs"' \
-F 'chunkIndex="0"' \
-F 'files=@"/Users/someone/Downloads/browser-sdk.zip"'
```




## 响应
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




