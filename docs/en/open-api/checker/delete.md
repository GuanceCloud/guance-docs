# Delete One or Multiple Monitors

---

<br />**POST /api/v1/checker/delete**

## Overview
Delete one or multiple monitors


## Body Request Parameters

| Parameter Name | Type   | Required | Description              |
|:-----------|:-------|:-----|:----------------|
| ruleUUIDs | array | Y | List of UUIDs for the monitors<br>Allow null: False <br> |

## Additional Parameter Notes



## Request Example
```shell
curl 'https://openapi.<<< custom_key.brand_main_domain >>>/api/v1/checker/delete' \
-H 'DF-API-KEY: <DF-API-KEY>' \
-H 'Content-Type: application/json;charset=UTF-8' \
--data-raw '{"ruleUUIDs": ["rul_xxxx32", "rul_xxxx32"]}' \
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
    "traceId": "TRACE-F010835F-BD10-429A-974C-8CFED4A76F0D"
} 
```