# 【聚合生成指标】禁用/启用

---

<br />**POST /api/v1/aggs_to_metric/set_disable**

## 概述
生成指标规则启用/禁用




## Body 请求参数

| 参数名        | 类型     | 必选   | 说明              |
|:-----------|:-------|:-----|:----------------|
| isDisable | boolean | Y | 设置启用状态<br>允许为空: False <br> |
| ruleUUIDs | array | Y | 聚合生成指标的UUID列表<br>允许为空: False <br> |

## 参数补充说明





## 请求例子
```shell
curl 'https://openapi.guance.com/api/v1/aggs_to_metric/set_disable' \
-H 'DF-API-KEY: <DF-API-KEY>' \
-H 'Content-Type: application/json;charset=UTF-8' \
--data-raw '{"isDisable":false,"ruleUUIDs":["rul_xxxx"]}' \
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
    "traceId": "14686566169126699349"
} 
```




