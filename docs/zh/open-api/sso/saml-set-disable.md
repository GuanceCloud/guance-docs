# 启用/禁用 SAML SSO 登录配置

---

<br />**POST /api/v1/sso/\{sso_uuid\}/set_disable**

## 概述
启用/禁用 SAML SSO 登录




## 路由参数

| 参数名        | 类型     | 必选   | 说明              |
|:-----------|:-------|:-----|:----------------|
| sso_uuid | string | Y | sso配置项id<br> |


## Body 请求参数

| 参数名        | 类型     | 必选   | 说明              |
|:-----------|:-------|:-----|:----------------|
| isDisable | boolean | Y | 设置启用状态<br>例子: True <br>允许为空: False <br> |

## 参数补充说明





## 请求例子
```shell
curl 'https://openapi.guance.com/api/v1/sso/sso_xxxx32/set_disable' \
-H 'Content-Type: application/json;charset=UTF-8' \
-H 'DF-API-KEY: <DF-API-KEY>' \
--data-raw '{"isDisable":true}' \
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
    "traceId": "16722427111925956503"
} 
```




