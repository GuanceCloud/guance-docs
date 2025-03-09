# Create Issue

---

<br />**POST /api/v1/issue/add**

## Overview



## Body Request Parameters

| Parameter Name        | Type     | Required   | Description              |
|:---------------------|:---------|:-----------|:-------------------------|
| name                 | string   | Y          | Title name <br>Example: name <br>Allow empty: False <br>Maximum length: 256 <br> |
| level                | string   | Y          | Level, corresponding to the UUID of level configuration <br>Example: level <br>Allow empty: False <br>Allow empty string: True <br> |
| description          | string   | Y          | Description <br>Example: description <br>Allow empty: False <br> |
| attachmentUuids      | array    |            | List of attachment UUIDs <br>Example: [] <br>Allow empty: True <br> |
| extend               | json     | Y          | Additional extended information <br>Example: {} <br>Allow empty: True <br> |
| resourceType         | string   |            | Source type, not required if no scenario applies <br>Example: resourceType <br>Allow empty: False <br>Possible values: ['event', 'dashboard', 'viewer'] <br> |
| resourceUUID         | string   |            | Corresponding source UUIDs for docid, dashboardUUID, dashboardUUID <br>Example: resourceUuid <br>Allow empty: False <br>Allow empty string: True <br> |
| resource             | string   |            | Corresponding source name <br>Example: resource <br>Allow empty: False <br>Allow empty string: True <br> |
| channelUUIDs         | array    |            | UUIDs of channels for issue delivery and tracking <br>Example: [] <br>Allow empty: True <br> |

## Additional Parameter Explanations

**Basic Parameter Explanation**

| Parameter Name       | Parameter Type | Required | Parameter Description |
|:--------------------:|:--------------:|:--------:|:---------------------:|
| name                 | string         | N        | Issue title name      |
| level                | string         | N        | Issue level, corresponding to configured level UUID |
| statusType           | integer        | N        | Issue status, 10: Open, 15: Working, 20: Resolved, 25: Closed, 30: Pending |
| description          | string         | N        | Issue description     |
| attachmentUuids      | array          | N        | List of attachment UUIDs, must be uploaded first via /api/v1/attachment/upload interface |
| extend               | json           | N        | Extended fields, default is {} |
| resourceType         | string         | N        | event: Event, dashboard: Dashboard, viewer: Viewer (checker: Monitor, this type is auto-created) |
| resourceUUID         | string         | N        | UUID associated with the resource |
| resource             | string         | N        | Corresponding resource name |
| channelUUIDs         | array          | N        | Expected issue delivery resources list, defaults to default workspace default channel |

**Level Field Explanation**
Levels are divided into system levels and custom levels (configurable in configuration management)

| Level | Value | Parameter Description |
|:-----:|:-----:|:----------------------:|
| P0    | system_level_0 | Pass parameter level: system_level_0, indicating system level P0 |
| P1    | system_level_1 | Pass parameter level: system_level_1, indicating system level P1 |
| P2    | system_level_2 | Pass parameter level: system_level_2, indicating system level P2 |
| P3    | system_level_3 | Pass parameter level: system_level_3, indicating system level P3 |
| xxx   | issl_yyyyy     | Pass parameter level: issl_yyyyy, indicating custom level xxx |

**Issue Channel Explanation**
All issues are automatically categorized under the default channel (all). Associated channels for the issue include: default channel (all), channels, and channelUUIDs.

**Extended Field Extend Explanation**

| Parameter Name | Parameter Type | Required | Parameter Description |
|:--------------:|:--------------:|:--------:|:---------------------:|
| channels       | array          | N        | Channels expected for issue delivery, described in content with #: |
| linkList       | array          | N        | Add issue links        |
| members        | array          | N        | Notification target members for issue notifications, described in content with @: |
| manager        | array          | N        | User account UUID, email, team UUID |
| extra          | json           | N        | Information about the creator/responsible person, used for front-end display |

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
            "name": "Resolve",
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