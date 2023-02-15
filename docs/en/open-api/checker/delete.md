# Delete One/More Monitors

---

<br />**post /api/v1/monitor/check/delete**

## Overview
Delete one/more monitors.




## Body Request Parameter

| Parameter Name        | Type     | Required   | Description              |
|:-----------|:-------|:-----|:----------------|
| ruleUUIDs | array | Y | The check's UUID list<br>Allowed null: False <br> |

## Supplementary Description of Parameters





## Request Example
``shell
curl 'https://openapi.guance.com/api/v1/monitor/check/delete' \
-H 'DF-API-KEY: <DF-API-KEY>' \
-H 'Content-Type: application/json;charset=UTF-8' \
--data-raw '{"ruleUUIDs": ["rul_692741d674ac4aea9980979721591b35", "rul_79f1adceb3c8418d943f38767d05f981"]}' \
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
    "traceId": "TRACE-F010835F-BD10-429A-974C-8CFED4A76F0D"
} 
```




