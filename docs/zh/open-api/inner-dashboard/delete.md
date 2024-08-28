# 删除单个用户视图

---

<br />**GET /api/v1/dashboard/\{dashboard_uuid\}/delete**

## 概述
删除单个用户视图




## 路由参数

| 参数名        | 类型     | 必选   | 说明              |
|:-----------|:-------|:-----|:----------------|
| dashboard_uuid | string | Y | 视图ID<br> |


## 参数补充说明





## 请求例子
```shell
curl 'https://openapi.guance.com/api/v1/dashboard/dsbd_xxxx32/delete' \
-H 'DF-API-KEY: <DF-API-KEY>' \
--compressed
```




## 响应
```shell
{
    "code": 200,
    "content": [
        "test_Redis 监控视图"
    ],
    "errorCode": "",
    "message": "",
    "success": true,
    "traceId": "TRACE-480D2477-13C7-4EF8-BDFC-FBAED98BD213"
} 
```




