# Delete Notification Policy

---

<br />**POST /api/v1/issue/notification_policy/delete**

## Overview




## Body Request Parameters

| Parameter Name        | Type     | Required   | Description              |
|:---------------------|:---------|:-----------|:-------------------------|
| issueNotificationPolicyUUIDs | array | Y | List of notification policy UUIDs<br>Allow null: False <br> |

## Additional Parameter Notes





## Request Example
```shell
curl 'https://openapi.<<< custom_key.brand_main_domain >>>/api/v1/issue/notification_policy/delete' \
-H 'DF-API-KEY: <DF-API-KEY>' \
-H 'Content-Type: application/json;charset=UTF-8' \
--data-raw '{"issueNotificationPolicyUUIDs": ["inpy_087e604e96ba4738859d2fd8861e7df4", "inpy_c79b26b3f6a540888f1773317093c0bd"]}' \
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