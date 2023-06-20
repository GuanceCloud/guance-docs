# 添加一个SAML映射

---

<br />**POST /api/v1/saml/mapping/field/add**

## 概述
添加一个SAML映射




## Body 请求参数

| 参数名        | 类型     | 必选   | 说明              |
|:-----------|:-------|:-----|:----------------|
| sourceField | string | Y | 源字段<br>例子: sourceField <br>允许为空: False <br> |
| sourceValue | string | Y | 源字段值<br>例子:  <br>允许为空: False <br> |
| targetValue | string | Y | 目标字段值（目前默认为 角色的UUID 值）<br>例子: readOnly <br> |

## 参数补充说明





## 请求例子
```shell
curl 'https://openapi.guance.com/api/v1/saml/mapping/field/add' \
  -H 'DF-API-KEY: <DF-API-KEY>' \
  -H 'Content-Type: application/json;charset=UTF-8' \
  --data-raw '{"sourceField": "jin","sourceValue": "lei","targetValue": "wsAdmin"}' \
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
    "traceId": "TRACE-640BC199-EE6B-417C-8F43-A1AAFCBD287B"
} 
```




