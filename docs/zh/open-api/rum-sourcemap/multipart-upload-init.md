# 分片上传事件初始化

---

<br />**POST /api/v1/rum_sourcemap/multipart_upload_init**

## 概述




## Body 请求参数

| 参数名        | 类型     | 必选   | 说明              |
|:-----------|:-------|:-----|:----------------|
| needCover | boolean |  | 是否强制覆盖已存在的文件, 默认为 false，即不覆盖<br>允许为空: False <br> |
| appId | string | Y | appId<br>允许为空: False <br> |
| version | string |  | 版本<br>允许为空: False <br>允许为空字符串: True <br> |
| env | string |  | 环境<br>允许为空: False <br>允许为空字符串: True <br> |

## 参数补充说明

注：同一个应用下只能存在一个相同 `version`、`env` 的 sourcemap，您可以通过 `needCover` 参数覆盖已存在的 sourcemap。
如果不覆盖，返回 `uploadId` 为空字符串




## 请求例子
```shell
curl 'https://openapi.guance.com/api/v1/rum_sourcemap/multipart_upload_init' \
-H 'Content-Type: application/json' \
-H 'DF-API-KEY: <DF-API-KEY>' \
--data-raw $'{\n  "needCover": true,\n  "appId": "app_demo",\n "version": "1.0.2",\n "env": "daily"\n}' \
--compressed
```




## 响应
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




