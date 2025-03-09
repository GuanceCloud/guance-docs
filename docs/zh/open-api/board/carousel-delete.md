# 删除仪表板轮播配置

---

<br />**POST /api/v1/dashboard/carousel/\{carousel_uuid\}/delete**

## 概述




## 路由参数

| 参数名        | 类型     | 必选   | 说明              |
|:-----------|:-------|:-----|:----------------|
| carousel_uuid | string | Y | 轮播仪表板UUID<br> |


## 参数补充说明





## 请求例子
```shell
curl 'https://openapi.<<< custom_key.brand_main_domain >>>/api/v1/dashboard/carousel/csel_xxxx32/delete' \
-H 'DF-API-KEY: <DF-API-KEY>' \
-H 'Accept-Language: zh' \
-H 'Content-Type: application/json;charset=UTF-8' \
-H 'Accept: application/json, text/plain, */*' \
--data-raw '{}' \
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
    "traceId": "TRACE-2AC4E9C9-E599-49C2-899E-8EAAF4C67E3F"
} 
```




