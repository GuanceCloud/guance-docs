# Enable/Disable Checker

---

<br />**POST /api/v1/checker/set_disable**

## Overview
Enable or disable a checker



## Body Request Parameters

| Parameter Name | Type   | Required | Description                                      |
|:--------------|:-------|:--------|:-------------------------------------------------|
| isDisable    | boolean | Y       | Set the enable status<br>Can be null: False <br> |
| ruleUUIDs    | array  | Y       | List of UUIDs for the check items<br>Can be null: False <br> |

## Additional Parameter Notes




## Request Example
```shell
curl 'https://openapi.guance.com/api/v1/checker/set_disable' \
-H 'DF-API-KEY: <DF-API-KEY>' \
-H 'Content-Type: application/json;charset=UTF-8' \
--data-raw '{"ruleUUIDs":["rul_xxxx32"],"isDisable":true}' \
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
    "traceId": "TRACE-68A1C512-21C2-48F9-A12A-C70EE3722C5C"
} 
```