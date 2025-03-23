# Modify Issue-Reply

---

<br />**POST /api/v1/issue/reply/\{reply_uuid\}/modify**

## Overview




## Route Parameters

| Parameter Name        | Type     | Required   | Description              |
|:---------------------|:---------|:-----------|:------------------------|
| reply_uuid           | string   | Y          | reply_uuid<br>         |


## Body Request Parameters

| Parameter Name        | Type     | Required   | Description              |
|:---------------------|:---------|:-----------|:------------------------|
| issueUUID            | string   | Y          | UUID of the issue<br>Example: issueUUID <br>Can be empty: False <br> |
| attachmentUuids      | array    |            | List of reply attachment UUIDs<br>Example: [] <br>Can be empty: True <br> |
| content              | string   |            | Reply content<br>Example: answer_xxx <br>Can be empty: True <br>Can be an empty string: True <br> |
| extend               | json     | Y          | Additional extension information, defaults to {} if no content is provided<br>Example: {} <br>Can be empty: True <br> |

## Supplementary Parameter Explanation


**Basic Parameter Description**

| Parameter Name       | Parameter Type | Required | Parameter Description                  |
|:--------------------:|:--------------:|:---------:|:--------------------------------------:|
| issueUUID           | string         | Y         | UUID corresponding to the reply issue  |
| attachmentUuids      | array          | N         | List of UUIDs for attachments related to the reply issue; must be uploaded via the /api/v1/attachment/upload interface first |
| content             | string         | N         | Content of the reply                   |
| extend              | json           | Y         | Extension fields, default value is {}  |


**Explanation of the Extend Field**

**In update scenarios, channels and channelUUIDs will be associated by default with both the default channels and any appended channels. If an empty array `[]` is passed, the issue will only exist in the default space channel.**

| Parameter Name | Parameter Type | Required | Parameter Description                  |
|:-------------:|:--------------:|:---------:|:--------------------------------------:|
| channels      | array          | N         | List of resources where the issue should be delivered |
| members       | array          | N         | Members of notification targets expected for the issue |
| extra         | json           | N         | Information related to the updater, used for front-end display |

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
                  "email": "xxx@<<< custom_key.brand_main_domain >>>",
                }
            }
}
```



## Request Example
```shell
curl 'https://openapi.<<< custom_key.brand_main_domain >>>/api/v1/issue/reply/repim_xxxx32/modify' \
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