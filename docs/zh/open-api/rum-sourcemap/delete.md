# 删除 SourceMap

---

<br />**POST /api/v1/rum_sourcemap/delete**

## 概述
删除指定应用下已存在的 sourcemap




## Body 请求参数

| 参数名        | 类型     | 必选   | 说明              |
|:-----------|:-------|:-----|:----------------|
| appId | string | Y | appId<br>允许为空: False <br> |
| version | string |  | 版本<br>允许为空: False <br>允许为空字符串: True <br> |
| env | string |  | 环境<br>允许为空: False <br>允许为空字符串: True <br> |

## 参数补充说明





## 请求例子
```shell
curl 'https://openapi.<<< custom_key.brand_main_domain >>>/api/v1/rum_sourcemap/delete' \
-H 'Content-Type: application/json' \
-H 'DF-API-KEY: <DF-API-KEY>' \
--data-raw $'{\n "appId": "app_demo",\n "version": "1.0.2",\n "env": "daily"\n}' \
--compressed
```




## 响应
```shell
{
    "code": 200,
    "content": true,
    "errorCode": "",
    "message": "",
    "success": true,
    "traceId": "TRACE-50B4B62F-9593-4C4D-9E8D-DBAB3FB31489"
} 
```




