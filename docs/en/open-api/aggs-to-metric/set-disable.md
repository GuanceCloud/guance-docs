# Disable/Enable Aggregation Generated Metrics

---

<br />**POST /api/v1/aggs_to_metric/set_disable**

## Overview
Enable or disable aggregation generated metrics rules


## Body Request Parameters

| Parameter Name | Type    | Required | Description              |
|:--------------|:-------|:--------|:-------------------------|
| isDisable     | boolean | Y       | Set the enable status<br>Allow null: False <br> |
| ruleUUIDs     | array  | Y       | List of UUIDs for aggregation generated metrics<br>Allow null: False <br> |

## Additional Parameter Notes



## Request Example
```shell
curl 'https://openapi.<<< custom_key.brand_main_domain >>>/api/v1/aggs_to_metric/set_disable' \
-H 'DF-API-KEY: <DF-API-KEY>' \
-H 'Content-Type: application/json;charset=UTF-8' \
--data-raw '{"isDisable":false,"ruleUUIDs":["rul_xxxx"]}' \
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
    "traceId": "14686566169126699349"
} 
```