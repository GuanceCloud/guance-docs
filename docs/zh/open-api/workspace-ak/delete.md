# 删除一个Key

---

<br />**GET /api/v1/workspace/accesskey/\{ak_uuid\}/delete**

## 概述
删除一个Key




## 路由参数

| 参数名        | 类型     | 必选   | 说明              |
|:-----------|:-------|:-----|:----------------|
| ak_uuid | string | Y | ak 的 UUID<br> |


## 参数补充说明





## 请求例子
```shell
curl 'https://openapi.guance.com/api/v1/workspace/accesskey/wsak_xxxxx/delete' \
-H 'DF-API-KEY: <DF-API-KEY>' \
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
    "traceId": "TRACE-E4D82ACD-ABF7-4A6C-ABF2-2D75AF15B5F4"
} 
```




