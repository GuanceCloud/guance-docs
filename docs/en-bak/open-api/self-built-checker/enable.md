# Enable an Intelligent Inspection

---

<br />**post /api/v1/self_built_checker/enable**

## Overview
Enable an intelligent inspection according to `checker_uuid`.




## Body Request Parameter

| Parameter Name        | Type     | Required   | Description              |
|:-----------|:-------|:-----|:----------------|
| ruleUUID | string |  | UUID of intelligent inspection <br>Example: rul_xxxxx <br>Allow null: False <br> |
| refKey | string |  | Association key of intelligent inspection<br>Example: xxx <br>Allow null: False <br> |

## Supplementary Description of Parameters





## Request Example
```shell
curl 'https://openapi.guance.com/api/v1/self_built_checker/rul_d0736e059fd74d859cdcdce102687378/enable' \
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
    "traceId": "TRACE-5191E0CC-076F-42D4-80C6-16A3FC9E0A09"
} 
```




