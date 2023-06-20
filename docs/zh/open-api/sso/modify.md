# 修改一个SAML映射

---

<br />**POST /api/v1/saml/mapping/field/\{fdmp_uuid\}/modify**

## 概述
修改一个SAML映射




## 路由参数

| 参数名        | 类型     | 必选   | 说明              |
|:-----------|:-------|:-----|:----------------|
| fdmp_uuid | string | Y | 映射配置id<br> |


## Body 请求参数

| 参数名        | 类型     | 必选   | 说明              |
|:-----------|:-------|:-----|:----------------|
| sourceField | string | Y | 源字段<br>例子: sourceField <br>允许为空: False <br> |
| sourceValue | string | Y | 源字段值<br>例子:  <br>允许为空: False <br> |
| targetValue | string | Y | 目标字段值（目前默认为 角色的UUID 值）<br>例子: readOnly <br> |

## 参数补充说明





## 请求例子
```shell
curl 'https://openapi.guance.com/api/v1/saml/mapping/field/fdmp_2f8f0085af2641928e8388da7d1318f5/modify' \
-H 'DF-API-KEY: <DF-API-KEY>' \
-H 'Content-Type: application/json;charset=UTF-8' \
--data-raw '{"sourceField": "AAAAA","sourceValue": "lei","targetValue": "wsAdmin"}' \
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




