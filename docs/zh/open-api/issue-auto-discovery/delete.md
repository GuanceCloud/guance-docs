# 删除自动发现配置

---

<br />**POST /api/v1/issue_auto_discovery/\{cfg_uuid\}/delete**

## 概述




## 路由参数

| 参数名        | 类型     | 必选   | 说明              |
|:-----------|:-------|:-----|:----------------|
| cfg_uuid | string | Y | Issue 自动发现配置UUID<br> |


## 参数补充说明





## 请求例子
```shell
curl 'https://openapi.<<< custom_key.brand_main_domain >>>/api/v1/issue_auto_discovery/iatdc_xxxxxx/delete' \
-H 'Content-Type: application/json' \
-H 'DF-API-KEY: <DF-API-KEY>' \
--insecure
```




## 响应
```shell
{
    "code": 200,
    "content": true,
    "errorCode": "",
    "message": "",
    "success": true,
    "traceId": "17964357676421089304"
} 
```




