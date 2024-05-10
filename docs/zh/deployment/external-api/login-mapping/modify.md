# 【Login Mapping】修改一个映射配置

---

<br />**POST /api/v1/login_mapping/field/\{lgmp_uuid\}/modify**

## 概述




## 路由参数

| 参数名        | 类型     | 必选   | 说明              |
|:-----------|:-------|:-----|:----------------|
| lgmp_uuid | string | Y | 映射配置id<br> |


## Body 请求参数

| 参数名        | 类型     | 必选   | 说明              |
|:-----------|:-------|:-----|:----------------|
| workspaceUUID | string |  | 工作空间UUID<br>例子: 工作空间UUID <br>允许为空: False <br> |
| sourceField | string | Y | 源字段<br>例子: sourceField <br>允许为空: False <br>最大长度: 40 <br> |
| sourceValue | string | Y | 源字段值<br>例子:  <br>允许为空: False <br>最大长度: 40 <br> |
| targetValues | array | Y | 目标字段值（目前默认为 角色的UUID 值）<br>例子: ['readOnly'] <br> |

## 参数补充说明





## 请求例子
```shell
curl 'https://openapi.guance.com/api/v1/login_mapping/field/lgmp_xxxxx/modify' \
  -X 'POST' \
  -H 'Content-Type: application/json' \
  -H 'X-Df-Access-Key: <AK key>' \
  -H 'X-Df-Nonce: <随机字符>' \
  -H 'X-Df-Signature: <签名>' \
  -H 'X-Df-Timestamp: <时间戳>' \
  --data-raw $'{ "workspaceUUID": "wksp_xxxx", "sourceField": "email2", "sourceValue": "xxx@qq.com", "targetValues": ["readOnly" ]}'

```




## 响应
```shell
{
    "code": 200,
    "content": true,
    "errorCode": "",
    "message": "",
    "success": true,
    "traceId": "TRACE-FC3488AA-3452-4031-9BDA-3CD710025D66"
} 
```




