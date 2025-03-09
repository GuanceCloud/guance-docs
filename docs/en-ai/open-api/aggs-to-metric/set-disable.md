# Disable/Enable Aggregated Metrics Generation Rules

---

<br />**POST /api/v1/aggs_to_metric/set_disable**

## Overview
Enable or disable aggregated metrics generation rules.

## Body Request Parameters

| Parameter Name | Type   | Required | Description                                                                 |
|:--------------|:-------|:--------|:---------------------------------------------------------------------------|
| isDisable     | boolean| Yes    | Set the enable status<br>Can be null: False <br>                            |
| ruleUUIDs     | array  | Yes    | List of UUIDs for aggregated metrics generation rules<br>Can be null: False <br> |

## Additional Parameter Notes

## Request Example
```shell
curl 'https://openapi.guance.com/api/v1/aggs_to_metric/set_disable' \
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