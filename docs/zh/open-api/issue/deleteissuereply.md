# Issue-回复 删除

---

<br />**DELETE /api/v1/issue/reply/\{reply_uuid\}/delete**

## 概述




## 路由参数

| 参数名        | 类型     | 必选   | 说明              |
|:-----------|:-------|:-----|:----------------|
| reply_uuid | string | Y | reply_uuid<br> |


## 参数补充说明





## 请求例子
```shell
curl 'https://openapi.guance.com/api/v1/issue/reply/repim_73265eb9e69449de8d0b98e3b789a174/delete' \
-X 'DELETE' \
-H 'DF-API-KEY: <DF-API-KEY>' \
-H 'Content-Type: application/json;charset=UTF-8' \
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
    "traceId": "14221792535104901781"
} 
```




