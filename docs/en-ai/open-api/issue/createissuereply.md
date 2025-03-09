# Create Issue-Reply

---

<br />**POST /api/v1/issue/reply/create**

## Overview




## Body Request Parameters

| Parameter Name        | Type     | Required   | Description              |
|:---------------------|:---------|:----------|:------------------------|
| issueUUID | string | Y | UUID of the issue to reply to<br>Example: issueUUID <br>Can be empty: False <br> |
| attachmentUuids | array | N | List of UUIDs for uploaded attachments<br>Example: [] <br>Can be empty: True <br> |
| content | string | N | Reply content<br>Example: answer_xxx <br>Can be empty: True <br>Can be an empty string: True <br>$maxCustomLength: 65535 <br> |
| extend | json | Y | Additional extended information, defaults to {} if no content<br>Example: {} <br>Can be empty: True <br> |

## Supplementary Parameter Explanation


**Basic Parameter Description**

| Parameter Name      | Parameter Type | Required | Parameter Description                   |
|:--------------------|:---------------|:---------|:---------------------------------------|
| issueUUID           | string         | Y        | UUID of the issue to reply to                |
| attachmentUuids     | array          | N        | List of UUIDs for uploaded attachments, must first be uploaded via the /api/v1/attachment/upload interface        |
| content             | string         | N        | Content of the reply                      |
| attachmentUuids     | array          | N        | List of UUIDs for uploaded attachments               |
| extend              | json           | Y        | Extended fields, default is {}                  |


**Explanation of the extend Field**

**In update scenarios, channels and channelUUIDs will be associated with the default channels and additional channels by default. If an empty array `[]` is passed, it will only exist in the default workspace channel.**

| Parameter Name | Parameter Type | Required | Parameter Description         |
|:--------------:|:--------------:|:--------:|:-----------------------------:|
| channels       | array          | N        | List of resources where the issue should be delivered |
| members        | array          | N        | Members to notify for the issue notification    |
| extra          | json           | N        | Information related to the creator of the reply, used for frontend display    |

Example of the extend field:
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
curl 'https://openapi.guance.com/api/v1/issue/reply/create' \
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