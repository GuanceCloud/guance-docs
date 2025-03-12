# Bulk Delete SLO

---

<br />**POST /api/v1/slo/batch_delete**

## Overview




## Body Request Parameters

| Parameter Name | Type   | Required | Description              |
|:--------------|:-------|:--------|:-------------------------|
| sloUUIDs      | array  | Y       | List of SLO UUIDs<br>Allow empty: False <br> |

## Additional Parameter Explanation





## Request Example
```shell
curl 'https://openapi.<<< custom_key.brand_main_domain >>>/api/v1/slo/batch_delete' \
-H 'Content-Type: application/json' \
-H 'DF-API-KEY: <DF-API-KEY>' \
--data '{
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
    "traceId": "TRACE-DD059943-258A-4203-92FC-D4E207BF18ED"
} 
```