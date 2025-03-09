# 删除

---

<br />**POST /api/v1/data_mask_rule/delete**

## 概述




## Body 请求参数

| 参数名        | 类型     | 必选   | 说明              |
|:-----------|:-------|:-----|:----------------|
| dataMaskRuleUUIDs | array | Y | 敏感数据脱敏规则uuid列表<br>允许为空: False <br> |

## 参数补充说明





## 请求例子
```shell
curl 'https://openapi.<<< custom_key.brand_main_domain >>>/api/v1/data_mask_rule/delete' \
-H 'Content-Type: application/json' \
-H 'DF-API-KEY: <DF-API-KEY>' \
--data-raw $'{"dataMaskRuleUUIDs": ["wdmk_xxx"]}'
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
    "traceId": "TRACE-F1E87701-EE20-4064-8CA8-7B14D27C4DC6"
} 
```




