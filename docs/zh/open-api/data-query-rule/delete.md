# 删除数据访问规则

---

<br />**POST /api/v1/data_query_rule/delete**

## 概述
删除数据访问规则




## Body 请求参数

| 参数名        | 类型     | 必选   | 说明              |
|:-----------|:-------|:-----|:----------------|
| queryRuleUuids | array | Y | 数据访问规则的UUID<br>允许为空: False <br> |

## 参数补充说明





## 请求例子
```shell
curl 'https://openapi.guance.com/api/v1/data_query_rule/delete' \
-H 'Accept: application/json, text/plain, */*' \
-H 'Content-Type: application/json;charset=UTF-8' \
-H 'DF-API-KEY: <DF-API-KEY>' \
--data-raw $'{"queryRuleUuids":["lqrl_xxxx32", "lqrl_xxxx32"]}' \
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
    "traceId": "TRACE-6FABDEAB-3FCE-4C12-B18C-9784636367B2"
} 
```




