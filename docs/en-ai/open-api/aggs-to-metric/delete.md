# 【Aggregation to Metrics】Delete

---

<br />**POST /api/v1/aggs_to_metric/delete**

## Overview
Enable/Disable Aggregation to Metrics rules


## Body Request Parameters

| Parameter Name | Type   | Required | Description                                |
|:--------------|:-------|:---------|:-------------------------------------------|
| ruleUUIDs     | array  | Y        | List of UUIDs for Aggregation to Metrics<br>Allow null: False <br> |

## Additional Parameter Notes



## Request Example
```shell
curl 'https://openapi.guance.com/api/v1/aggs_to_metric/delete' \
-H 'DF-API-KEY: <DF-API-KEY>' \
-H 'Content-Type: application/json;charset=UTF-8' \
--data-raw '{"ruleUUIDs":["rul_xxxx"]}' \
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