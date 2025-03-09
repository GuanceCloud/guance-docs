# Disable/Enable an SLO

---

<br />**POST /api/v1/slo/{slo_uuid}/set_disable**

## Overview




## Route Parameters

| Parameter Name | Type   | Required | Description             |
|:--------------|:-------|:---------|:------------------------|
| slo_uuid      | string | Y        | UUID of a specific SLO  |


## Body Request Parameters

| Parameter Name | Type    | Required | Description                                                                                   |
|:--------------|:--------|:---------|:-----------------------------------------------------------------------------------------------|
| isDisable     | boolean | Y        | Enable/disable, false: enable, true: disable<br>Allow null: False <br> |

## Additional Parameter Notes





## Request Example
```shell
curl 'https://openapi.guance.com/api/v1/slo/monitor_xxxx32/set_disable' \
-H 'Content-Type: application/json' \
-H 'DF-API-KEY: <DF-API-KEY>' \
--data '{
  "isDisable": false
}'
```




## Response
```shell
{
    "code": 200,
    "content": [
        "slo-test8"
    ],
    "errorCode": "",
    "message": "",
    "success": true,
    "traceId": "TRACE-219C5FF9-00E7-4072-9233-0D9FB49F9A10"
} 
```