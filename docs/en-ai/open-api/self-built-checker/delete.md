# Delete a Smart Inspection

---

<br />**POST /api/v1/self_built_checker/delete**

## Overview
Delete a user-defined inspection based on `checker_uuid`



## Body Request Parameters

| Parameter Name | Type   | Required | Description                                      |
|:--------------|:-------|:---------|:-------------------------------------------------|
| ruleUUID      | string | Yes      | UUID of the user-defined inspection <br>Example: rul_xxxxx <br>Allow null: False <br> |
| refKey        | string | Yes      | Associated key of the user-defined inspection <br>Example: xxx <br>Allow null: False <br> |

## Additional Parameter Notes



## Request Example
```shell
curl 'https://openapi.guance.com/api/v1/self_built_checker/delete' \
-H 'DF-API-KEY: <DF-API-KEY>' \
-H 'Content-Type: application/json;charset=UTF-8' \
--data-raw '{"ruleUUID":"rule_xxx"}' \
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