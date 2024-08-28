# 删除角色

---

<br />**POST /api/v1/role/\{role_uuid\}/delete**

## 概述
删除角色




## 路由参数

| 参数名        | 类型     | 必选   | 说明              |
|:-----------|:-------|:-----|:----------------|
| role_uuid | string | Y | 角色UUID<br> |


## 参数补充说明





## 请求例子
```shell
curl 'https://openapi.guance.com/api/v1/role/role_xxxx32/delete' \
-H 'Content-Type: application/json;charset=UTF-8' \
-H 'DF-API-KEY: <DF-API-KEY>' \
--data-raw '{}' \
--compressed
```




## 响应
```shell
{
    "code": 200,
    "content": {},
    "errorCode": "",
    "message": "",
    "success": true,
    "traceId": "TRACE-77A06A58-BAA1-4880-8005-9987B28B8A7E"
} 
```




