# 列出一个分片上传事件所对应的已上传的分片列表

---

<br />**POST /api/v1/rum_sourcemap/part_list**

## 概述
sourcemap 压缩文件上传(分片上传)操作中的第四步可选操作。列出已上传的分片列表。一般用于断点续传或者分片检查。
详情参考: [SourceMap分片上传关联接口使用说明](../../../studio-backend/sourcemap-multipart-upload-init/)




## Body 请求参数

| 参数名        | 类型     | 必选   | 说明              |
|:-----------|:-------|:-----|:----------------|
| uploadId | string | Y | 分片上传事件Id<br>允许为空: False <br> |

## 参数补充说明

注：[SourceMap分片上传关联接口使用说明](../../../studio-backend/sourcemap-multipart-upload-init/)




## 请求例子
```shell
curl 'https://openapi.guance.com/api/v1/rum_sourcemap/part_list' \
-H 'Content-Type: application/json' \
-H 'DF-API-KEY: <DF-API-KEY>' \
--data-raw $'{\n  "uploadId": "65ef45944fac157005cb73de48e81f161Lfv5UOs"\n}' \
--compressed
```




## 响应
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




