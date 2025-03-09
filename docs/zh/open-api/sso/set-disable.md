# 开启/禁用 SAML 映射

---

<br />**POST /api/v1/saml/mapping/set_disable**

## 概述
开启/禁用 saml 映射规则




## Body 请求参数

| 参数名        | 类型     | 必选   | 说明              |
|:-----------|:-------|:-----|:----------------|
| ssoUUID | string | Y | 身份提供商, SSO配置UUID<br>例子: sso_xxxx <br> |
| isDisable | boolean | Y | 设置启用状态<br>例子: True <br>允许为空: False <br> |

## 参数补充说明





## 请求例子
```shell
curl 'https://openapi.<<< custom_key.brand_main_domain >>>/api/v1/saml/mapping/set_disable' \
-H 'Content-Type: application/json;charset=UTF-8' \
-H 'DF-API-KEY: <DF-API-KEY>' \
--data-raw '{"ssoUUID":"sso_xxxx32","isDisable":false}' \
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
    "traceId": "14207722438760120475"
} 
```




