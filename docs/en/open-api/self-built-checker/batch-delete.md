# Bulk Delete Smart Security Checks

---

<br />**POST /api/v1/self_built_checker/batch_delete**

## Overview
Delete self-built security checks based on `checker_uuid`



## Body Request Parameters

| Parameter Name | Type   | Required | Description              |
|:--------------|:-------|:---------|:------------------------|
| ruleUUIDs     | array  |          | UUID of the self-built security check<br>Example: rul_xxxxx <br>Allow empty: False <br> |
| refKey        | string |          | Associated key of the self-built security check<br>Example: xxx <br>Allow empty: False <br> |

## Additional Parameter Notes




## Request Example
```shell
curl 'https://openapi.<<< custom_key.brand_main_domain >>>/api/v1/self_built_checker/batch_delete' \
-H 'DF-API-KEY: <DF-API-KEY>' \
-H 'Content-Type: application/json;charset=UTF-8' \
--data-raw '{"ruleUUIDs":["rul_xxxx32","rul_xxxx32"]}' \
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
    "traceId": "TRACE-0ABCD3FC-9441-4617-9301-A95299460890"
} 
```