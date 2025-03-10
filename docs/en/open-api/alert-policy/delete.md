# Delete an Alert Strategy

---

<br />**POST /api/v1/alert_policy/delete**

## Overview
Delete an alert strategy


## Body Request Parameters

| Parameter Name        | Type     | Required   | Description              |
|:-------------------|:-------|:-----|:----------------|
| alertPolicyUUIDs | array | Y | Alert strategy UUIDs<br>Allow null: False <br> |

## Additional Parameter Notes



## Request Example
```shell
curl 'https://openapi.<<< custom_key.brand_main_domain >>>/api/v1/alert_policy/delete' \
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