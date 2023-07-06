# Disable an Intelligent Inspection

---

<br />**post /api/v1/self_built_checker/disable**

## Overview
Disable an intelligent inspection according to `checker_uuid`.




## Body Request Parameter

| Parameter Name        | Type     | Required   | Description              |
|:-----------|:-------|:-----|:----------------|
| ruleUUID | string |  | UUID of intelligent inspection<br>Example: rul_xxxxx <br>Allow null: False <br> |
| refKey | string |  | Association key of intelligent inspection<br>Example: xxx <br>Allow null: False <br> |

## Supplementary Description of Parameters





## Request Example
```shell
curl 'https://openapi.guance.com/self_built_checker/rul_71e719ee94f84d65a3fa68fb3054a815/disable' \
-H 'DF-API-KEY: <DF-API-KEY>' \
-H 'Content-Type: application/json;charset=UTF-8' \
--data-raw 'null' \
--compressed \
--insecure
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




