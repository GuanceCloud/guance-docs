# 新建映射规则

---

<br />**POST /api/v1/saml/mapping/field/add**

## 概述
添加一个SAML映射




## Body 请求参数

| 参数名        | 类型     | 必选   | 说明              |
|:-----------|:-------|:-----|:----------------|
| ssoUUID | string | Y | sso配置UUID<br>例子: sso_xxx <br>允许为空: False <br>最大长度: 48 <br> |
| sourceField | string | Y | 源字段<br>例子: sourceField <br>允许为空: False <br> |
| sourceValue | string | Y | 源字段值<br>例子:  <br>允许为空: False <br> |
| targetValues | array | Y | 目标字段值（目前默认为 角色的UUID 值列表）<br>例子: readOnly <br> |

## 参数补充说明





## 请求例子
```shell
curl 'https://openapi.guance.com/api/v1/saml/mapping/field/add' \
  -H 'DF-API-KEY: <DF-API-KEY>' \
  -H 'Content-Type: application/json;charset=UTF-8' \
  --data-raw '{"ssoUUID":"sso_xxxx32","sourceField":"sd1","sourceValue":"sd1_value1","targetValues":["general"]}' \
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
    "traceId": "TRACE-640BC199-EE6B-417C-8F43-A1AAFCBD287B"
} 
```




