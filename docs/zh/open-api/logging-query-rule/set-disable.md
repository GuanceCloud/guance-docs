# 修改单个数据访问规则

---

<br />**POST /api/v1/logging_query_rule/set_disable**

## 概述
禁用 数据访问规则




## Body 请求参数

| 参数名        | 类型     | 必选   | 说明              |
|:-----------|:-------|:-----|:----------------|
| loggingQueryRuleUuids | array | Y | 数据访问规则的UUID<br>允许为空: False <br> |
| isDisable | boolean | Y | 设置启用状态<br>允许为空: False <br> |

## 参数补充说明





## 请求例子
```shell
curl 'https://openapi.<<< custom_key.brand_main_domain >>>/api/v1/logging_query_rule/set_disable' \
-H 'Accept: application/json, text/plain, */*' \
-H 'Content-Type: application/json;charset=UTF-8' \
-H 'DF-API-KEY: <DF-API-KEY>' \
--data-raw '{"loggingQueryRuleUuids":["lqrl_9f1de1d1440f4af5917a534299d0ad09","lqrl_81bc72d7b58b4764accf773564dfce6a"],"isDisable":true}' \
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
    "traceId": "TRACE-6DB30C38-B58B-47D1-8C73-F487619F641F"
} 
```




