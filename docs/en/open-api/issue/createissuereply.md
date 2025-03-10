# Create Issue Reply

---

<br />**POST /api/v1/issue/reply/create**

## Overview




## Body Request Parameters

| Parameter Name        | Type     | Required   | Description              |
|:---------------------|:---------|:-----------|:-------------------------|
| issueUUID            | string   | Y          | UUID of the issue to reply to<br>Example: issueUUID <br>Nullable: False <br> |
| attachmentUuids      | array    |            | List of UUIDs for uploaded attachments<br>Example: [] <br>Nullable: True <br> |
| content              | string   |            | Reply content<br>Example: answer_xxx <br>Nullable: True <br>Empty string allowed: True <br>$maxCustomLength: 65535 <br> |
| extend               | json     | Y          | Additional extension information, defaults to {} if empty<br>Example: {} <br>Nullable: True <br> |

## Additional Parameter Explanation


**Basic Parameter Explanation**

| Parameter Name      | Parameter Type | Required | Parameter Description |
|:--------------------|:---------------|:---------|:----------------------|
| issueUUID           | string         | Y        | UUID of the issue to reply to                |
| attachmentUuids     | array          | N        | List of UUIDs for attachments of the issue, must be uploaded via /api/v1/attachment/upload interface        |
| content             | string         | N        | Content of the reply                      |
| attachmentUuids     | array          | N        | List of UUIDs for uploaded attachments               |
| extend              | json           | Y        | Extension fields, default to {}                  |


**Explanation of Extend Field**

**In update scenarios, channels and channelUUIDs are used to associate with default and additional channels. If an empty array `[]` is passed, it will only exist in the default channel of the workspace**

| Parameter Name | Parameter Type | Required | Parameter Description |
|:--------------:|:--------------:|:--------:|:---------------------:|
| channels       | array          | N        | List of resources where the issue should be delivered |
| members        | array          | N        | List of notification target members for the issue notification |
| extra          | json           | N        | Information related to the creator of the reply, used for front-end display |

Example of extend field:
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
            "creator": {
                "name": "xxx",
                "email": "xxx@qq.com",
            }
            }
}
```



## Request Example
```shell
curl 'https://openapi.<<< custom_key.brand_main_domain >>>/api/v1/issue/reply/create' \
-H 'DF-API-KEY: <DF-API-KEY>' \
-H 'Content-Type: application/json;charset=UTF-8' \
--data-raw '{"issueUUID":"issue_xxxx32","content":"aaa","attachmentUuids":[],"extend":{"members":[],"channels":[],"linkList":[]}}'\
--compressed
```



## Response
```shell
{
    "code": 200,
    "content": {
        "content": "aaa",
        "createAt": 1690810887,
        "creator": "acnt_xxxx32",
        "deleteAt": -1,
        "extend": {
            "channels": [],
            "linkList": [],
            "members": []
        },
        "id": null,
        "issueUUID": "issue_xxxx32",
        "status": 0,
        "type": "reply",
        "updateAt": 1690810887,
        "updator": "acnt_xxxx32",
        "uuid": "repim_xxxx32",
        "workspaceUUID": "wksp_xxxx32"
    },
    "errorCode": "",
    "message": "",
    "success": true,
    "traceId": "10459577100278308134"
} 
```