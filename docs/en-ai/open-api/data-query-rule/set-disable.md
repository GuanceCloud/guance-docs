# Disable/Enable Data Access Rules

---

<br />**POST /api/v1/data_query_rule/set_disable**

## Overview
Disable data access rules



## Body Request Parameters

| Parameter Name        | Type     | Required | Description              |
|:---------------------|:---------|:---------|:-------------------------|
| queryRuleUuids | array | Y | UUID of the data access rule<br>Allow null: False <br> |
| isDisable | boolean | Y | Set enable status<br>Allow null: False <br> |

## Additional Parameter Notes




## Request Example
```shell
curl 'https://openapi.guance.com/api/v1/data_query_rule/set_disable' \
-H 'Accept: application/json, text/plain, */*' \
-H 'Content-Type: application/json;charset=UTF-8' \
-H 'DF-API-KEY: <DF-API-KEY>' \
--data-raw '{"queryRuleUuids":["lqrl_dfe6330883ef4311afae5d380e2294a1","lqrl_36199bc9fe8e4c9a982919584ed55dae","lqrl_65eb5f5188a647928e1df9de9db00a7d"],"isDisable":true}' \
--compressed
```




## Response
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