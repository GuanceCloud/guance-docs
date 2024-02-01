# 上传单个分片

---

<br />**POST /api/v1/rum_sourcemap/upload_part**

## 概述




## 参数补充说明


注：单片文件大小控制在 10MB 以内

**关联接口**

- multipart_upload_init 分片上传事件初始化
- part_list 列出一个分片上传事件所对应的已上传的分片列表
- part_meage 合并各分片生成文件
- upload_cancel 取消一个分片上传事件




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




