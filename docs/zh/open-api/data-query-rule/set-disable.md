# 禁用/启用数据访问规则

---

<br />**POST /api/v1/data_query_rule/set_disable**

## 概述
删除数据访问规则




## Body 请求参数

| 参数名        | 类型     | 必选   | 说明              |
|:-----------|:-------|:-----|:----------------|
| queryRuleUuids | array | Y | 数据访问规则的UUID<br>允许为空: False <br> |
| isDisable | boolean | Y | 设置启用状态<br>允许为空: False <br> |

## 参数补充说明





## 请求例子
```shell
curl 'https://openapi.guance.com/api/v1/data_query_rule/set_disable' \
-H 'Accept: application/json, text/plain, */*' \
-H 'Content-Type: application/json;charset=UTF-8' \
-H 'DF-API-KEY: <DF-API-KEY>' \
--data-raw '{"queryRuleUuids":["lqrl_dfe6330883ef4311afae5d380e2294a1","lqrl_36199bc9fe8e4c9a982919584ed55dae","lqrl_65eb5f5188a647928e1df9de9db00a7d"],"isDisable":true}' \
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
    "traceId": "TRACE-0249FC84-AD38-43B2-B498-0CC22CB6008E"
} 
```




