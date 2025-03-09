# Disable a Smart Security Check

---

<br />**POST /api/v1/self_built_checker/disable**

## Overview
Disable a user-defined security check based on `checker_uuid`



## Body Request Parameters

| Parameter Name | Type   | Required | Description                                      |
|:--------------|:-------|:---------|:-------------------------------------------------|
| ruleUUIDs     | array  |          | UUID of the user-defined security check<br>Example: rul_xxxxx <br>Can be empty: False <br> |
| refKey        | string |          | Associated key of the user-defined security check<br>Example: xxx <br>Can be empty: False <br> |

## Additional Parameter Notes



## Request Example
```shell
curl 'https://openapi.guance.com/api/v1/self_built_checker/disable' \
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
    "traceId": "TRACE-1969B4EA-18AE-4D23-AAC7-3FC6586493EB"
} 
```