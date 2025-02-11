# Batch Disable/Enable SLO

---

<br />**POST /api/v1/slo/batch_set_disable**

## Overview




## Body Request Parameters

| Parameter Name | Type   | Required | Description              |
|:--------------|:-------|:---------|:-------------------------|
| isDisable     | boolean| Y        | Enable/disable, false: enable, true: disable<br>Allow null: False <br> |
| sloUUIDs      | array  | Y        | List of SLO UUIDs<br>Allow null: False <br> |

## Additional Parameter Notes





## Request Example
```shell
curl 'https://openapi.guance.com/api/v1/slo/batch_set_disable' \
-H 'Content-Type: application/json' \
-H 'DF-API-KEY: <DF-API-KEY>' \
--data '{
  "isDisable": false,
  "sloUUIDs": [
    "monitor_xxxx32",
    "monitor_xxxx32"
  ]
}'
```




## Response
```shell
{
    "code": 200,
    "content": [
        "slo_1",
        "slo_2"
    ],
    "errorCode": "",
    "message": "",
    "success": true,
    "traceId": "TRACE-EBF6D62D-E134-494C-B664-85B3AF0AE7ED"
} 
```