# Issue Modification

---

<br />**POST /api/v1/issue/{issue_uuid}/modify**

## Overview

## Route Parameters

| Parameter Name | Type   | Required | Description          |
|:--------------|:-------|:---------|:---------------------|
| issue_uuid    | string | Y        | Issue UUID           |

## Body Request Parameters

| Parameter Name  | Type   | Required | Description                                  |
|:---------------|:-------|:---------|:---------------------------------------------|
| name           | string | N        | Title name <br> Example: name <br> Allow empty: False <br> $maxCustomLength: 256 |
| level          | string | N        | Level, corresponding to the level configuration UUID <br> Example: level <br> Allow empty: False <br> Allow empty string: True |
| description    | string | N        | Description <br> Example: description <br> Allow empty: False |
| statusType     | integer| N        | Status of the issue <br> Example: statusType <br> Allow empty: False <br> Optional values: [10, 20, 30] |
| extend         | json   | Y        | Additional extended information, defaults to {} if no content <br> Example: {} <br> Allow empty: True |
| attachmentUuids| array  | N        | List of attachment UUIDs <br> Example: [] <br> Allow empty: True |

## Parameter Supplemental Explanation

**Basic Parameter Explanation**

| Parameter Name  | Parameter Type | Required | Parameter Description |
|:---------------:|:--------------:|:--------:|:----------------------|
| name            | string         | N        | Title name of the issue |
| level           | string         | N        | Issue level corresponding to the configuration level UUID |
| statusType      | integer        | N        | Issue status, 10: Open, 20: Resolved, 30: Pending |
| description     | string         | N        | Issue description information |
| attachmentUuids | array          | N        | List of attachment UUIDs, must be uploaded via the /api/v1/attachment/upload interface first |
| extend          | json           | N        | Extended fields, default to {} |

**Level Field Explanation**
The level can be a system-defined level or a custom level (configurable in Configuration Management).

| Level  | Value             | Parameter Description |
|:------:|:-----------------:|:---------------------:|
| P0     | system_level_0    | Pass level: system_level_0, indicates system level P0 |
| P1     | system_level_1    | Pass level: system_level_1, indicates system level P1 |
| P2     | system_level_2    | Pass level: system_level_2, indicates system level P2 |
| P3     | system_level_3    | Pass level: system_level_3, indicates system level P3 |
| xxx    | issl_yyyyy        | Pass level: issl_yyyyy, indicates custom level xxx |

**Extended Field "extend" Explanation**

| Parameter Name | Parameter Type | Required | Parameter Description |
|:--------------:|:--------------:|:--------:|:----------------------|
| channels       | array          | N        | Resource list expected for issue delivery in the description content |
| linkList       | array          | N        | Add issue links |
| members        | array          | N        | Notification target members expected to be notified in the description content |
| manager        | array          | N        | User account UUID, email, team UUID |
| extra          | json           | N        | Information about the updater/responsible person's email for frontend display |

Example of the "extend" field:
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
        "acnt_xxxxx",
        "111@qq.com",
        "group_xxx",
        "222@qq.com"
    ],
    "linkList": [
        {
            "name": "Resolve",
            "link": "https://sd.com"
        }
    ],
    "extra": {
              "updator": {
                  "name": "xxx",
                  "email": "xxx@qq.com"
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
curl 'https://openapi.guance.com/api/v1/issue/issue_xxxx32/modify' \
-H 'DF-API-KEY: <DF-API-KEY>' \
-H 'Content-Type: application/json;charset=UTF-8' \
--data-raw '{"statusType":20}'\
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