# Issue-Reply Modification

---

<br />**POST /api/v1/issue/reply/\{reply_uuid\}/modify**

## Overview

## Route Parameters

| Parameter Name        | Type     | Required   | Description              |
|:---------------------|:---------|:-----------|:-------------------------|
| reply_uuid           | string   | Y          | The UUID of the reply    |

## Body Request Parameters

| Parameter Name        | Type     | Required   | Description              |
|:---------------------|:---------|:-----------|:-------------------------|
| issueUUID            | string   | Y          | The UUID of the issue to be replied to. Example: issueUUID. Not nullable. |
| attachmentUuids      | array    | N          | List of UUIDs for uploaded attachments. Example: []. Nullable. |
| content              | string   | N          | Content of the reply. Example: answer_xxx. Nullable and can be an empty string. |
| extend               | json     | Y          | Additional extension information, defaults to {}. Example: {}. Nullable. |

## Parameter Details

### Basic Parameter Explanation

| Parameter Name       | Parameter Type | Required | Parameter Description                  |
|:--------------------:|:--------------:|:--------:|:---------------------------------------|
| issueUUID            | string         | Y        | The UUID of the issue being replied to |
| attachmentUuids      | array          | N        | List of UUIDs for attachments of the issue, must be uploaded via the /api/v1/attachment/upload interface |
| content              | string         | N        | Content of the reply                   |
| extend               | json           | Y        | Extension fields, default is {}        |

### Explanation of the Extend Field

In update scenarios, `channels` and `channelUUIDs` will be associated with the default channels and any additional channels specified. If `[]` is passed, it will only exist in the default channel of the workspace.

| Parameter Name | Parameter Type | Required | Parameter Description                  |
|:--------------:|:--------------:|:--------:|:---------------------------------------|
| channels       | array          | N        | List of resources where the issue should be delivered |
| members        | array          | N        | List of notification target members for the issue |
| extra          | json           | N        | Information related to the updater, used for frontend display |

Example of the `extend` field:
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
    "extra": {
                "updator": {
                  "name": "yyy",
                  "email": "yyy@qq.com",
                }
            }
}
```

## Request Example
```shell
curl 'https://openapi.guance.com/api/v1/issue/reply/repim_xxxx32/modify' \
-H 'DF-API-KEY: <DF-API-KEY>' \
-H 'Content-Type: application/json;charset=UTF-8' \
--data-raw '{"issueUUID":"issue_xxxx32","content":"aaaaas","attachmentUuids":[],"extend":{"channels":[],"linkList":[],"members":[],"text":"aaaaas"}}'\
--compressed
```

## Response
```shell
{
    "code": 200,
    "content": {
        "content": "aaaaas",
        "createAt": 1690810887,
        "creator": "acnt_xxxx32",
        "deleteAt": -1,
        "extend": {
            "channels": [],
            "linkList": [],
            "members": [],
            "text": "aaaaas"
        },
        "id": 319430,
        "issueUUID": "issue_xxxx32",
        "status": 0,
        "type": "reply",
        "updateAt": 1690811215,
        "updator": "acnt_xxxx32",
        "uuid": "repim_xxxx32",
        "workspaceUUID": "wksp_xxxx32"
    },
    "errorCode": "",
    "message": "",
    "success": true,
    "traceId": "13131178623027797701"
} 
```