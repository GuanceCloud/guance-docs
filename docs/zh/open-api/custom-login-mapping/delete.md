# 【自定义映射规则】删除一个映射配置

---

<br />**POST /api/v1/login_mapping/field/\{lgmp_uuid\}/delete**

## 概述




## 路由参数

| 参数名        | 类型     | 必选   | 说明              |
|:-----------|:-------|:-----|:----------------|
| lgmp_uuid | string | Y | 映射配置id<br> |


## 参数补充说明





## 请求例子
```shell
curl 'https://openapi.<<< custom_key.brand_main_domain >>>/api/v1/login_mapping/field/lgmp_xxxx32/delete' \
  -H 'Content-Type: application/json;charset=UTF-8' \
  -H 'DF-API-KEY: <DF-API-KEY>' \
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
    "traceId": "16237433115105300199"
} 
```




