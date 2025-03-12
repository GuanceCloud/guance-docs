# 删除 SAML SSO 登录配置

---

<br />**GET /api/v1/sso/saml_delete/\{sso_uuid\}**

## 概述
删除一个SAML SSO 登录配置




## 路由参数

| 参数名        | 类型     | 必选   | 说明              |
|:-----------|:-------|:-----|:----------------|
| sso_uuid | string | Y | sso配置项id<br> |


## 参数补充说明





## 请求例子
```shell
curl 'https://openapi.<<< custom_key.brand_main_domain >>>/api/v1/sso/saml_delete/sso_xxxx32' \
-H 'DF-API-KEY: <DF-API-KEY>' \
--compressed 
```




## 响应
```shell
{
    "code": 200,
    "content": {
        "name": ""
    },
    "errorCode": "",
    "message": "",
    "success": true,
    "traceId": "TRACE-8D7EC84A-D42B-483C-9273-427A9033BB3F"
} 
```




