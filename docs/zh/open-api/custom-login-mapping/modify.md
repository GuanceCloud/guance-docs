# 【自定义映射规则】修改一个映射配置

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
| sourceField | string | Y | 源字段<br>例子: sourceField <br>允许为空: False <br>最大长度: 256 <br> |
| sourceValue | string | Y | 源字段值<br>例子:  <br>允许为空: False <br>最大长度: 256 <br> |
| targetValues | array | Y | 目标字段值（目前默认为 角色的UUID 值列表）<br>例子: ['readOnly'] <br> |

## 参数补充说明





## 请求例子
```shell
curl 'https://openapi.<<< custom_key.brand_main_domain >>>/api/v1/login_mapping/field/lgmp_xxxx32/modify' \
  -H 'Content-Type: application/json;charset=UTF-8' \
  -H 'DF-API-KEY: <DF-API-KEY>' \
  --data-raw '{"sourceField":"name","sourceValue":"lisa-new","targetValues":["wsAdmin"]}' \
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
    "traceId": "16410390460963313112"
} 
```




