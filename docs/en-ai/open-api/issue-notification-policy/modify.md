# Modify Notification Policy

---

<br />**POST /api/v1/issue/notification_policy/\{issue_notification_policy_uuid\}/modify**

## Overview
Modify a notification policy.

## Route Parameters

| Parameter Name              | Type   | Required | Description               |
|:------------------------|:------|:-------|:-------------------------|
| notification_schedule_uuid | string | Y      | Schedule UUID            |

## Body Request Parameters

| Parameter Name              | Type   | Required | Description                                                                                       |
|:------------------------|:------|:-------|:---------------------------------------------------------------------------------------------|
| name                   | string | Y      | Notification policy name <br>Allow empty: False <br>Maximum length: 256 <br>Allow empty string: False <br> |
| notificationScheduleUUIDs | array |        | List of notification schedule UUIDs <br>Example: ['nsche_xxx', 'nsche_yyy'] <br>Allow empty: False <br> |
| extend                 | json  |        | Extended information, including notification scope and upgrade configuration <br>Allow empty: False <br> |
| extend.notifyTypes     | array |        | Notification types <br>Example: ['issue.add', 'issue.modify', 'issueUpgrade.noManager', 'issueUpgrade.processTimeout', 'issueReply.add', 'issueReply.modify', 'issueReply.delete', 'dailySummary'] <br>Allow empty: False <br> |
| extend.upgradeCfg      | json  |        | Upgrade configuration <br>Example: {'noManager': {'duration': 600}, 'processTimeout': {'duration': 600}} <br>Allow empty: False <br> |

## Additional Parameter Notes

Refer to the documentation for creating a new notification policy.

## Request Example
```shell
curl 'https://openapi.guance.com/api/v1/notification_policy/inpy_c79b26b3f6a540888f1773317093c0bd/modify' \
-H 'DF-API-KEY: <DF-API-KEY>' \
-H 'Content-Type: application/json;charset=UTF-8' \
--data-raw '{"name":"api_modify test","notificationScheduleUUIDs":["nsche_a15990d7e6ec4514842dbee74e26a1cf"],"extend":{"notifyTypes":["issueUpgrade.noManager","issueReply.add"],"upgradeCfg":{"noManager":{"duration":1200},"processTimeout":{}}}}' \
--compressed
```

## Response
```json
{
    "code": 200,
    "content": {
        "createAt": 1735801143,
        "creator": "wsak_f2ba9858f4414655be39efc882b120dd",
        "declaration": {},
        "deleteAt": -1,
        "extend": {
            "notifyTypes": [
                "issueUpgrade.noManager",
                "issueReply.add"
            ],
            "upgradeCfg": {
                "noManager": {
                    "duration": 1200
                },
                "processTimeout": {}
            }
        },
        "id": 60,
        "name": "api_modify test",
        "notificationScheduleUUIDs": [
            "nsche_a15990d7e6ec4514842dbee74e26a1cf"
        ],
        "status": 0,
        "updateAt": 1735801453.487606,
        "updator": "wsak_f2ba9858f4414655be39efc882b120dd",
        "uuid": "inpy_c79b26b3f6a540888f1773317093c0bd",
        "workspaceUUID": "wksp_798c5e0f589e4992994196832f64b6ba"
    },
    "errorCode": "",
    "message": "",
    "success": true,
    "traceId": "TRACE-6303A3CB-0AA0-47B9-8A31-6ABC12DE8499"
} 
```