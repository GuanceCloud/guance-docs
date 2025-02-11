# Issue Creation

---

<br />**POST /api/v1/issue/add**

## Overview



## Body Request Parameters

| Parameter Name        | Type     | Required   | Description              |
|:---------------------|:---------|:-----------|:-------------------------|
| name                 | string   | Y          | Title name<br>Example: name <br>Allow null: False <br>Maximum length: 256 <br> |
| level                | string   | Y          | Level, corresponding to the UUID of the level configuration<br>Example: level <br>Allow null: False <br>Allow empty string: True <br> |
| description          | string   | Y          | Description<br>Example: description <br>Allow null: False <br> |
| attachmentUuids      | array    |            | List of attachment upload UUIDs<br>Example: [] <br>Allow null: True <br> |
| extend               | json     | Y          | Additional extended information<br>Example: {} <br>Allow null: True <br> |
| resourceType         | string   |            | Source type, not required if no scenario<br>Example: resourceType <br>Allow null: False <br>Possible values: ['event', 'dashboard', 'Explorer'] <br> |
| resourceUUID         | string   |            | Corresponding source UUID for docid, dashboardUUID, or dashboardUUID<br>Example: resourceUuid <br>Allow null: False <br>Allow empty string: True <br> |
| resource             | string   |            | Corresponding source name<br>Example: resource <br>Allow null: False <br>Allow empty string: True <br> |
| channelUUIDs         | array    |            | UUIDs of issue delivery tracking channels<br>Example: [] <br>Allow null: True <br> |

## Additional Parameter Explanation

**Basic Parameter Explanation**

| Parameter Name | Parameter Type | Required | Parameter Description |
|:---------------:|:--------------:|:--------:|:---------------------:|
| name            | string         | N        | Issue title name      |
| level           | string         | N        | Issue level, corresponding to the UUID of the level configuration |
| statusType      | integer        | N        | Issue status, 10: Open, 20: Resolved, 30: Pending |
| description     | string         | N        | Issue description     |
| attachmentUuids | array          | N        | List of attachment upload UUIDs, must be uploaded first via /api/v1/attachment/upload interface |
| extend          | json           | N        | Extended fields, default is {} |
| resourceType    | string         | N        | event:Event, dashboard:Dashboard, Explorer:Explorer (checker:Monitor, this type is automatically created) |
| resourceUUID    | string         | N        | UUID associated with the resource |
| resource        | string         | N        | Corresponding resource name |
| channelUUIDs    | array          | N        | List of resources where the issue is expected to be delivered, defaults to the default workspace and default channel |

**Level Field Explanation**
The level can be system-defined or custom (configurable in configuration management)

| Level | Value | Parameter Description |
|:------:|:-----:|:---------------------:|
| P0     | system_level_0 | Pass parameter level: system_level_0, indicating system level P0 |
| P1     | system_level_1 | Pass parameter level: system_level_1, indicating system level P1 |
| P2     | system_level_2 | Pass parameter level: system_level_2, indicating system level P2 |
| P3     | system_level_3 | Pass parameter level: system_level_3, indicating system level P3 |
| xxx    | issl_yyyyy    | Pass parameter level: issl_yyyyy, indicating custom level xxx |

**Issue Channel Explanation, all issues are automatically categorized under the default channel (All)**
Channels associated with the issue include: Default channel (All), channels, and channelUUIDs

**Extend Field Explanation**

| Parameter Name | Parameter Type | Required | Parameter Description |
|:--------------:|:--------------:|:--------:|:---------------------:|
| channels       | array          | N        | Expected issue delivery resource list described in the content using #: |
| linkList       | array          | N        | Add issue links |
| members        | array          | N        | Notification target members for issue notifications described in the content using @ |
| manager        | array          | N        | User account UUID, email, team UUID |
| extra          | json           | N        | Information about the creator/responsible person of the issue, used for front-end display |

Extend field example:
```json
{
    "members": [
        {
            "type": "@",
            "uuid": "acnt_xxxx32",
            "exists": true
        }
    ],
    "channels": [
        {
            "type": "#",
            "uuid": "chan_xxxx32",
            "exists": true
        }
    ],
    "manager": [
        "acnt_xxxx32",
        "abc@11.com",
        "group_xxx"
    ],
    "linkList": [
        {
            "name": "Solution",
            "link": "https://sd.com",
        }
    ],
    "extra": {
            "creator": {
                "name": "xxx",
                "email": "xxx@qq.com",
            },
            "managerInfos": {
                "111@qq.com": {"name": "111"},
                "222@qq.com": {"name": "222"}
            }
        }
}
```

## Request Example
```shell
curl 'https://openapi.guance.com/api/v1/issue/add' \
-H 'DF-API-KEY: <DF-API-KEY>' \
-H 'Content-Type: application/json;charset=UTF-8' \
--data-raw '{"name":"dcacscsc","level":"system_level_2","description":"<span>cdscascas</span>","extend":{"channels":[{"type":"#","uuid":"chan_xxxx32"}],"view_isuue_url":"/exceptions/exceptionsTracking?leftActiveKey=ExceptionsTracking&activeName=ExceptionsTracking&w=wksp_xxxx32&classic=exceptions_tracing&issueName=SYS&activeChannel=%7BdefaultChannelUUID%7D&sourceType=exceptions_tracing&__docid=%7BissueUUID%7D"},"attachmentUuids":[]}'\
--compressed
```

## Response
```shell
{
    "code": 200,
    "content": {
        "createAt": 1686398344,
        "creator": "acnt_xxxx32",
        "creatorInfo": {
            "acntWsNickname": "",
            "email": "1061379682@qq.com",
            "iconUrl": "",
            "name": "wanglei-testing",
            "username": "1061379682@qq.com"
        },
        "deleteAt": -1,
        "description": "",
        "extend": {
            "channels": [
                {
                    "exists": true,
                    "type": "#",
                    "uuid": "chan_xxxx32"
                }
            ],
            "view_isuue_url": ""
        },
        "id": 47402,
        "level": "system_level_2",
        "name": "dcacscsc",
        "resource": "",
        "resourceType": "",
        "resourceUUID": "",
        "status": 0,
        "statusType": 20,
        "subIdentify": "",
        "updateAt": 1686400483,
        "updator": "acnt_xxxx32",
        "updatorInfo": {
            "acntWsNickname": "",
            "email": "1061379682@qq.com",
            "iconUrl": "",
            "name": "wanglei-testing",
            "username": "1061379682@qq.com"
        },
        "uuid": "issue_xxxx32",
        "workspaceUUID": "wksp_xxxx32"
    },
    "errorCode": "",
    "message": "",
    "success": true,
    "traceId": "1744405827768254151"
} 
```