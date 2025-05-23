# 合并各分片生成文件

---

<br />**POST /api/v1/rum_sourcemap/part_merge**

## 概述
sourcemap 压缩文件上传(分片上传)操作中的第五步操作。合并已上传分片，将分片合并为 sourcemap 压缩文件。
详情参考: [SourceMap分片上传关联接口使用说明](../../../studio-backend/sourcemap-multipart-upload-init/)




## Body 请求参数

| 参数名        | 类型     | 必选   | 说明              |
|:-----------|:-------|:-----|:----------------|
| uploadId | string | Y | 分片上传事件Id<br>允许为空: False <br> |
| chunkIndexs | array |  | 分片列表<br>允许为空: False <br>允许为空字符串: False <br> |

## 参数补充说明





## 请求例子
```shell
curl 'https://openapi.<<< custom_key.brand_main_domain >>>/api/v1/rum_sourcemap/part_merge' \
-H 'Content-Type: application/json' \
-H 'DF-API-KEY: <DF-API-KEY>' \
--data-raw $'{\n  "uploadId": "65ef45944fac157005cb73de48e81f161Lfv5UOs"\n}' \
--compressed
```




## 响应
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




