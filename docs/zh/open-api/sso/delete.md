# 删除一个SAML映射

---

<br />**get /api/v1/saml/mapping/field/\{fdmp_uuid\}/delete**

## 概述
删除一个SAML映射




## 路由参数

| 参数名        | 类型     | 必选   | 说明              |
|:-----------|:-------|:-----|:----------------|
| sso_uuid | string | Y | sso配置项id<br> |


## 参数补充说明





## 请求例子
```shell
curl 'https://openapi.guance.com/api/v1/saml/mapping/field/fdmp_2f8f0085af2641928e8388da7d1318f5/delete' \
-H 'DF-API-KEY: <DF-API-KEY>' \
--compressed \
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
    "traceId": "TRACE-32D15B98-F93C-4664-9C91-9295BFC26844"
} 
```




