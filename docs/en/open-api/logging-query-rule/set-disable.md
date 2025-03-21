# Modify a Single Data Access Rule

---

<br />**POST /api/v1/logging_query_rule/set_disable**

## Overview
Disable a data access rule



## Body Request Parameters

| Parameter Name        | Type     | Required   | Description              |
|:---------------------|:---------|:-----------|:-------------------------|
| loggingQueryRuleUuids | array    | Y          | UUID of the data access rule<br>Allow null: False <br> |
| isDisable            | boolean  | Y          | Set the enable status<br>Allow null: False <br> |

## Additional Parameter Explanation



## Request Example
```shell
curl 'https://openapi.<<< custom_key.brand_main_domain >>>/api/v1/logging_query_rule/set_disable' \
-H 'Accept: application/json, text/plain, */*' \
-H 'Content-Type: application/json;charset=UTF-8' \
-H 'DF-API-KEY: <DF-API-KEY>' \
--data-raw '{"loggingQueryRuleUuids":["lqrl_9f1de1d1440f4af5917a534299d0ad09","lqrl_81bc72d7b58b4764accf773564dfce6a"],"isDisable":true}' \
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
    "traceId": "TRACE-6DB30C38-B58B-47D1-8C73-F487619F641F"
} 
```