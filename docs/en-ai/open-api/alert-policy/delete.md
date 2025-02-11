# Delete an Alert Policy

---

<br />**POST /api/v1/alert_policy/delete**

## Overview
Delete an alert policy


## Body Request Parameters

| Parameter Name        | Type     | Required | Description              |
|:---------------------|:---------|:---------|:-------------------------|
| alertPolicyUUIDs     | array    | Y        | Alert policy UUIDs<br>Allow null: False <br> |

## Additional Parameter Notes



## Request Example
```shell
curl 'https://openapi.guance.com/api/v1/alert_policy/delete' \
-H 'DF-API-KEY: <DF-API-KEY>' \
-H 'Content-Type: application/json;charset=UTF-8' \
--data-raw '{"alertPolicyUUIDs": ["altpl_xxxx32"]}' \
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
    "traceId": "TRACE-D077F825-E7DE-4332-9368-549A0CD7D288"
} 
```