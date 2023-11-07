# 删除数据访问规则

---

<br />**POST /api/v1/logging_query_rule/delete**

## 概述
删除数据访问规则




## Body 请求参数

| 参数名        | 类型     | 必选   | 说明              |
|:-----------|:-------|:-----|:----------------|
| loggingQueryRuleUuids | array | Y | 日志数据访问规则的uuid列表<br>允许为空: False <br> |

## 参数补充说明





## 请求例子
```shell
curl 'https://openapi.guance.com/api/v1/logging_query_rule/delete' \
-H 'Accept: application/json, text/plain, */*' \
-H 'Content-Type: application/json;charset=UTF-8' \
-H 'DF-API-KEY: <DF-API-KEY>' \
--data-raw $'{"loggingQueryRuleUuids":["lqrl_6215235e83dd47b0972e03ca0fd315c2", "lqrl_d88d355edba04bf3bbaf760eeb697454"]}' \
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




