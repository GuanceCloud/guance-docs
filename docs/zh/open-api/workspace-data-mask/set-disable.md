# 启用/禁用

---

<br />**POST /api/v1/data_mask_rule/set_disable**

## 概述




## Body 请求参数

| 参数名        | 类型     | 必选   | 说明              |
|:-----------|:-------|:-----|:----------------|
| isDisable | boolean | Y | 设置启用状态<br>允许为空: False <br> |
| dataMaskRuleUUIDs | array | Y | 敏感数据脱敏规则uuid列表<br>允许为空: False <br> |

## 参数补充说明





## 请求例子
```shell
curl 'https://openapi.guance.com/api/v1/data_mask_rule/set_disable' \
-H 'Content-Type: application/json' \
-H 'DF-API-KEY: <DF-API-KEY>' \
--data-raw $'{"isDisable": false,"dataMaskRuleUUIDs": ["wdmk_xxx"]}'
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
    "traceId": "TRACE-953C271A-768B-4123-9B7C-3DC552B1B621"
} 
```




