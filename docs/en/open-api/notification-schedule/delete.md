# Delete Schedule

---

<br />**POST /api/v1/notification_schedule/delete**

## Overview




## Body Request Parameters

| Parameter Name        | Type     | Required | Description              |
|:---------------------|:--------|:--------|:-------------------------|
| notificationScheduleUUIDs | array | Y | List of schedule UUIDs<br>Allow null: False <br> |

## Additional Parameter Notes





## Request Example
```shell
curl 'https://openapi.<<< custom_key.brand_main_domain >>>/api/v1/notification_schedule/delete' \
-H 'DF-API-KEY: <DF-API-KEY>' \
-H 'Content-Type: application/json;charset=UTF-8' \
--data-raw '{"notificationScheduleUUIDs": ["nsche_6c18b90a5900413f960114058fce4d4c", "nsche_3512c1f4d176433484676225b547ef7a"]}' \
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
    "traceId": "16589049060728401150"
} 
```