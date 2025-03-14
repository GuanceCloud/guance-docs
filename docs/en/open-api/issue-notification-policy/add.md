# Add Notification Policy

---

<br />**POST /api/v1/issue/notification_policy/add**

## Overview
Create a new notification policy



## Body Request Parameters

| Parameter Name        | Type     | Required   | Description              |
|:-------------------|:-------|:-----|:----------------|
| name | string | Y | Notification policy name<br>Allow null: False <br>Maximum length: 256 <br>Allow empty string: False <br> |
| notificationScheduleUUIDs | array |  | List of notification schedule UUIDs<br>Example: ['nsche_xxx', 'nsche_yyy'] <br>Allow null: False <br> |
| extend | json |  | Extended information, including notification scope and upgrade configuration<br>Allow null: False <br> |
| extend.notifyTypes | array |  | Notification types<br>Example: ['issue.add', 'issue.modify', 'issueUpgrade.noManager', 'issueUpgrade.processTimeout', 'issueReply.add', 'issueReply.modify', 'issueReply.delete', 'dailySummary'] <br>Allow null: False <br> |
| extend.upgradeCfg | json |  | Upgrade configuration<br>Allow null: False <br> |

## Additional Parameter Explanation


**1. Request Parameter Description**

| Parameter Name                | Type  | Required  | Description          |
|-----------------------|----------|----|------------------------|
|name                   |String|Required| Name|
|notificationScheduleUUIDs                   |Array|Required| Associated schedule list|
|extend                   |Json|| Extended information|

--------------

**2. Parameter Description within `extend`**

| Parameter Name                | Type  | Required  | Description          |
|-----------------------|----------|----|------------------------|
|notifyTypes                   |Array|| Notification trigger types, options: "issue.add", "issue.modify", "issueUpgrade.noManager", "issueUpgrade.processTimeout", "issueReply.add", "issueReply.modify", "issueReply.delete", "dailySummary" |
|upgradeCfg                   |Json|| Upgrade time configuration when upgrade notifications exist|

--------------

**3. Parameter Description within `extend.upgradeCfg`**

| Parameter Name                | Type  | Required  | Description          |
|-----------------------|----------|----|------------------------|
|noManager                   |Json|| Configure this field when "issueUpgrade.noManager" is enabled in extend.notifyTypes|
|processTimeout                   |json|| Configure this field when "issueUpgrade.processTimeout" is enabled in extend.notifyTypes|
|openProcessTimeout                   |Json|| Configure this field when "issueUpgrade.processTimeout" is enabled in extend.notifyTypes, added in iteration on 2025-02-19|

**3.1 Internal Structure of `noManager`, `processTimeout`, and `openProcessTimeout` within `extend.upgradeCfg`**

| Parameter Name                | Type  | Required  | Description          |
|-----------------------|----------|----|------------------------|
|duration                   |integer|| Trigger interval, unit: seconds|
|notifyType                 |string|| Notification type, single: once, cyclic: cycle, default is single, added in iteration on 2025-02-19|
|cycleDuration              |integer|| Notification frequency for cyclic notifications, unit: seconds, added in iteration on 2025-02-19|
|cycleTimes                 |integer|| Number of notifications for cyclic notifications, range: 1-30, added in iteration on 2025-02-19|

Note: When "issueUpgrade.processTimeout" is enabled in extend.notifyTypes, both processTimeout and openProcessTimeout within extend.upgradeCfg can be configured simultaneously.

**Example of `extend.upgradeCfg` fields:**
```json
{
    "noManager": {
        "duration": 600
    },
    "processTimeout": {
        "duration": 600,
        "cycleDuration": 600,
        "notifyType": "cycle",
        "cycleTimes": 10
    },
    "openProcessTimeout": {
        "duration": 600,
        "notifyType": "once"
    }
}
```

--------------

## Request Example
```shell
curl 'https://openapi.<<< custom_key.brand_main_domain >>>/api/v1/issue/notification_policy/add' \
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