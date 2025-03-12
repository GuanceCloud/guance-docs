# Enable a Smart Inspection

---

<br />**POST /api/v1/self_built_checker/enable**

## Overview
Enable a user-defined inspection based on `checker_uuid`



## Body Request Parameters

| Parameter Name | Type   | Required | Description                          |
|:--------------|:-------|:---------|:-------------------------------------|
| ruleUUIDs     | array  |          | UUID of the user-defined inspection <br>Example: rul_xxxxx <br>Allow null: False <br> |
| refKey        | string |          | Associated key of the user-defined inspection <br>Example: xxx <br>Allow null: False <br> |

## Additional Parameter Explanation



## Request Example
```shell
curl 'https://openapi.<<< custom_key.brand_main_domain >>>/api/v1/self_built_checker/enable' \
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
    "traceId": "TRACE-5191E0CC-076F-42D4-80C6-16A3FC9E0A09"
} 
```