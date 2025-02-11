# Delete Custom Notification Dates for Alert Policies

---

<br />**POST /api/v1/notice/date/delete**

## Overview
Delete custom notification dates for alert policies



## Body Request Parameters

| Parameter Name        | Type     | Required   | Description              |
|:-------------------|:-------|:-----|:----------------|
| noticeDatesUUIDs | array | Y | UUID of the custom notification dates for alert policies<br>Allow null: False <br> |
| skipRefCheck | boolean |  | Whether to skip (alert policy) relationship checks, default is False, which means checks will be performed,<br>Allow null: False <br> |

## Additional Parameter Notes



## Request Example
```shell
curl 'https://openapi.guance.com/api/v1/notice/date/delete' \
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