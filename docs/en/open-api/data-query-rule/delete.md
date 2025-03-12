# Delete Data Access Rule

---

<br />**POST /api/v1/data_query_rule/delete**

## Overview
Delete data access rule


## Body Request Parameters

| Parameter Name        | Type     | Required | Description              |
|:---------------------|:---------|:---------|:------------------------|
| queryRuleUuids | array | Y | UUID of the data access rule<br>Allow null: False <br> |

## Additional Parameter Explanation



## Request Example
```shell
curl 'https://openapi.<<< custom_key.brand_main_domain >>>/api/v1/data_query_rule/delete' \
-H 'Accept: application/json, text/plain, */*' \
-H 'Content-Type: application/json;charset=UTF-8' \
-H 'DF-API-KEY: <DF-API-KEY>' \
--data-raw $'{"queryRuleUuids":["lqrl_xxxx32", "lqrl_xxxx32"]}' \
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
    "traceId": "TRACE-6FABDEAB-3FCE-4C12-B18C-9784636367B2"
} 
```