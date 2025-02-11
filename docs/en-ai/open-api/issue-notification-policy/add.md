# Add Notification Policy

---

<br />**POST /api/v1/issue/notification_policy/add**

## Overview
Create a new notification policy



## Body Request Parameters

| Parameter Name        | Type     | Required   | Description              |
|:-------------------|:-------|:-----|:----------------|
| name | string | Y | Notification policy name<br>Nullable: False <br>Maximum length: 256 <br>Empty string allowed: False <br> |
| notificationScheduleUUIDs | array |  | List of notification schedule UUIDs<br>Example: ['nsche_xxx', 'nsche_yyy'] <br>Nullable: False <br> |
| extend | json |  | Extended information, including notification scope and escalation configuration<br>Nullable: False <br> |
| extend.notifyTypes | array |  | Notification types<br>Example: ['issue.add', 'issue.modify', 'issueUpgrade.noManager', 'issueUpgrade.processTimeout', 'issueReply.add', 'issueReply.modify', 'issueReply.delete', 'dailySummary'] <br>Nullable: False <br> |
| extend.upgradeCfg | json |  | Escalation configuration<br>Example: {'noManager': {'duration': 600}, 'processTimeout': {'duration': 600}} <br>Nullable: False <br> |

## Additional Parameter Explanations


**1. Request Parameter Explanation**

| Parameter Name                | Type  | Required  | Description          |
|-----------------------|----------|----|------------------------|
|name                   |String|Yes| Name|
|notificationScheduleUUIDs                   |Array|Yes| Associated schedule list|
|extend                   |Json|| Extended information|

--------------

**2. Parameter Explanation in `extend`**

| Parameter Name                | Type  | Required  | Description          |
|-----------------------|----------|----|------------------------|
|notifyTypes                   |Array|| Notification trigger types, options: "issue.add", "issue.modify", "issueUpgrade.noManager", "issueUpgrade.processTimeout", "issueReply.add", "issueReply.modify", "issueReply.delete", "dailySummary" |
|upgradeCfg                   |Json|| Escalation time configuration for notification types that have escalation notifications, example: {"noManager":{"duration":600},"processTimeout":{"duration":600}}|




## Request Example
```shell
curl 'https://openapi.guance.com/api/v1/issue/notification_policy/add' \
-H 'DF-API-KEY: <DF-API-KEY>' \
-H 'Content-Type: application/json;charset=UTF-8' \
--data-raw '{"name":"api_add test","notificationScheduleUUIDs":["nsche_a15990d7e6ec4514842dbee74e26a1cf"],"extend":{"notifyTypes":["issue.add","issue.modify","issueUpgrade.noManager","issueReply.add","issueReply.modify"],"upgradeCfg":{"noManager":{"duration":1200},"processTimeout":{}}}}' \
--compressed
```




## Response
```shell
{
    "code": 200,
    "content": {
        "createAt": 1735801143,
        "creator": "wsak_f2ba9858f4414655be39efc882b120dd",
        "declaration": {},
        "deleteAt": -1,
        "extend": {
            "notifyTypes": [
                "issue.add",
                "issue.modify",
                "issueUpgrade.noManager",
                "issueReply.add",
                "issueReply.modify"
            ],
            "upgradeCfg": {
                "noManager": {
                    "duration": 1200
                },
                "processTimeout": {}
            }
        },
        "id": null,
        "name": "api_add test",
        "notificationScheduleUUIDs": [
            "nsche_a15990d7e6ec4514842dbee74e26a1cf"
        ],
        "status": 0,
        "updateAt": null,
        "updator": null,
        "uuid": "inpy_c79b26b3f6a540888f1773317093c0bd",
        "workspaceUUID": "wksp_798c5e0f589e4992994196832f64b6ba"
    },
    "errorCode": "",
    "message": "",
    "success": true,
    "traceId": "TRACE-844F87BE-34E5-4C96-B2AC-65A2433011BC"
} 
```