# Delete an Intelligent Inspection

---

<br />**post /api/v1/self_built_checker/delete**

## Overview
Delete an intelligent inspection according to `checker_uuid`.




## Body Request Parameter

| Parameter Name        | Type     | Required   | Description              |
|:-----------|:-------|:-----|:----------------|
| ruleUUID | string |  | Self-built UUID for intelligent inspection<br>Example: rul_xxxxx <br>Allow null: False <br> |
| refKey | string |  | Association key of intelligent inspection<br>Example: xxx <br>Allow null: False <br> |

## Supplementary Description of Parameters





## Request Example
```shell
curl 'https://openapi.guance.com/api/v1/self_built_checker/rul_d0736e059fd74d859cdcdce102687378/delete' \
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
    "traceId": "TRACE-0ABCD3FC-9441-4617-9301-A95299460890"
} 
```




