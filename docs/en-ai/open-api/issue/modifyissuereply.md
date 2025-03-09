# Issue Reply Modification

---

<br />**POST /api/v1/issue/reply/{reply_uuid}/modify**

## Overview




## Route Parameters

| Parameter Name        | Type     | Required   | Description              |
|:-------------------|:-------|:-----|:----------------|
| reply_uuid | string | Y | reply_uuid<br> |


## Body Request Parameters

| Parameter Name        | Type     | Required   | Description              |
|:-------------------|:-------|:-----|:----------------|
| issueUUID | string | Y | UUID of the issue<br>Example: issueUUID <br>Can be empty: False <br> |
| attachmentUuids | array |  | List of UUIDs for uploaded attachments<br>Example: [] <br>Can be empty: True <br> |
| content | string |  | Content of the reply<br>Example: answer_xxx <br>Can be empty: True <br>Can be an empty string: True <br> |
| extend | json | Y | Additional extended information, defaults to {} if no content<br>Example: {} <br>Can be empty: True <br> |

## Parameter Explanation


**Basic Parameter Explanation**

| Parameter Name      | Parameter Type | Required | Parameter Description                   |
|:---------------:|:--------:|:--------:|:-------------------------------------------:|
| issueUUID       | string  | Y     | UUID corresponding to the issue being replied to                |
| attachmentUuids      | array  | N     | List of UUIDs for attachments related to the issue, must be uploaded via the /api/v1/attachment/upload interface             |
| content    | string  | N     | Content of the reply                      |
| extend      | json   | Y     | Extended fields, default is {}                  |


**Explanation of the extend Field**

**In update scenarios, channels and channelUUIDs are used to associate with the default channels and additional channels. If [] is passed, it will only exist in the default space channel by default.**

| Parameter Name  | Parameter Type | Required | Parameter Description         |
|:--------:|:--------:|:--------:|:-----------------------:|
| channels | array   | N     | List of resources where the issue should be delivered |
| members  | array     | N     | Members to notify for the issue    |
| extra  | json     | N     | Information about the updater, used for frontend display |

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