# 删除映射规则

---

<br />**GET /api/v1/saml/mapping/field/\{fdmp_uuid\}/delete**

## 概述
删除一个SAML映射




## 路由参数

| 参数名        | 类型     | 必选   | 说明              |
|:-----------|:-------|:-----|:----------------|
| fdmp_uuid | string | Y | 映射配置id<br> |


## 参数补充说明





## 请求例子
```shell
curl 'https://openapi.guance.com/api/v1/saml/mapping/field/fdmp_xxxx32/delete' \
-H 'DF-API-KEY: <DF-API-KEY>' \
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
    "traceId": "TRACE-32D15B98-F93C-4664-9C91-9295BFC26844"
} 
```




