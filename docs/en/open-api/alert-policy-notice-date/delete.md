# Delete Custom Notification Dates for Alert Strategies

---

<br />**POST /api/v1/notice/date/delete**

## Overview
Delete custom notification dates for alert strategies



## Body Request Parameters

| Parameter Name        | Type     | Required   | Description              |
|:-------------------|:-------|:-----|:----------------|
| noticeDatesUUIDs | array | Y | UUID of the custom notification dates for alert strategies<br>Allow null: False <br> |
| skipRefCheck | boolean |  | Whether to skip (alert strategy) relationship checks, default is False, which means checks are performed,<br>Allow null: False <br> |

## Additional Parameter Explanation



## Request Example
```shell
curl 'https://openapi.<<< custom_key.brand_main_domain >>>/api/v1/notice/date/delete' \
-H 'DF-API-KEY: <DF-API-KEY>' \
-H 'Content-Type: application/json;charset=UTF-8' \
--data-raw '{"noticeDatesUUIDs": ["ndate_xxxx32", "ndate_xxxx32", "ndate_xxxx32"]}' \
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
    "traceId": "TRACE-E5C523B2-8CF1-4A37-A587-33C21C74DB26"
} 
```