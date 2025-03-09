# 列出应用下所有 SourceMap

---

<br />**GET /api/v1/rum_sourcemap/list**

## 概述
列出指定应用下已存在的所有 sourcemap 信息




## Query 请求参数

| 参数名        | 类型     | 必选   | 说明              |
|:-----------|:-------|:-----|:----------------|
| appId | string | Y | appId<br>允许为空: False <br> |

## 参数补充说明





## 请求例子
```shell
curl 'https://openapi.<<< custom_key.brand_main_domain >>>/api/v1/rum_sourcemap/list?appId=app_demo' \
-H 'Content-Type: application/json' \
-H 'DF-API-KEY: <DF-API-KEY>'
```




## 响应
```shell
{
    "code": 200,
    "content": [
        {
            "createAt": 1706586319,
            "declaration": {
                "b": [
                    "asfawfgajfasfafgafwba",
                    "asfgahjfaf"
                ],
                "business": "aaa",
                "organization": "6540c09e4243b300077a9675"
            },
            "env": "daily",
            "version": "1.0.2"
        }
    ],
    "errorCode": "",
    "message": "",
    "success": true,
    "traceId": "TRACE-8AED1B4C-CEB1-4C2A-B585-358B4DBE4C54"
} 
```




