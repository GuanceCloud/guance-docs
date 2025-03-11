# Modify Issue

---

<br />**POST /api/v1/issue/\{issue_uuid\}/modify**

## Overview




## Route Parameters

| Parameter Name        | Type     | Required   | Description              |
|:-------------------|:-------|:-----|:----------------|
| issue_uuid | string | Y | Issue UUID<br> |


## Body Request Parameters

| Parameter Name        | Type     | Required   | Description              |
|:-------------------|:-------|:-----|:----------------|
| name | string |  | Title name<br>Example: name <br>Can be empty: False <br>$maxCustomLength: 256 <br> |
| level | string |  | Level, corresponding to the level configuration UUID<br>Example: level <br>Can be empty: False <br>Can be an empty string: True <br> |
| description | string |  | Description<br>Example: description <br>Can be empty: False <br> |
| statusType | integer |  | Status of the issue<br>Example: statusType <br>Can be empty: False <br>Possible values: [10, 15, 20, 25, 30] <br> |
| extend | json | Y | Additional extended information, defaults to {} if no content<br>Example: {} <br>Can be empty: True <br> |
| attachmentUuids | array |  | List of attachment UUIDs<br>Example: [] <br>Can be empty: True <br> |

## Additional Parameter Notes


**Basic Parameter Explanation**

| Parameter Name      | Parameter Type | Required | Parameter Description                   |
|:---------------:|:--------:|:--------:|:-------------------------------------------:|
|      name       |  string  |    N     | Title name of the issue                |
|      level      | string  |    N    | Issue level corresponding to the configuration level UUID        |
|      statusType      | integer  |    N     | Issue status, 10: Open, 15: Working, 20: Resolved, 25: Closed, 30: Pending     |
|   description    |  string  |    N     | Description information of the issue                |
| attachmentUuids |  array   |    N     | List of attachment UUIDs, must first be uploaded via the /api/v1/attachment/upload endpoint          |
|     extend      |   json   |    N    | Extended fields, default is {}                  |

**Level Field Explanation**
The level can be either a system-defined level or a custom level (configurable in the configuration management)

|     Level      | Value | Parameter Description                   |
|:---------------:|:--------:|:-------------------------------------------:|
|      P0       |  system_level_0  |      Pass level: system_level_0, indicating system level P0               |
|      P1       |  system_level_1  |      Pass level: system_level_1, indicating system level P1               |
|      P2       |  system_level_2  |      Pass level: system_level_2, indicating system level P2               |
|      P3       |  system_level_3  |      Pass level: system_level_3, indicating system level P3               |
|      xxx      |  issl_yyyyy      |      Pass level: issl_yyyyy, indicating custom level xxx            |


**Extended Field `extend` Explanation**

| Parameter Name  | Parameter Type | Required | Parameter Description         |
|:--------:|:--------:|:--------:|:-----------------------:|
| channels |  array   |    N     | Resources list expected for issue delivery, marked with # in the description content |
| linkList |  array   |    N     | Add links to the issue |
| members  |     array     |     N     | Notification target members expected for issue notifications, marked with @ in the description content |
| manager |  array   |    N     | User account UUID, email, team UUID |
| extra  |     json     |     N     | Information about the updater/responsible person's email and name, used for front-end display |

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
    "manager": [
        "acnt_xxxxx",
        "111@qq.com",
        "group_xxx",
        "222@qq.com"
    ],
    "linkList": [
        {
            "name": "Resolve",
            "link": "https://sd.com",
        }
    ],
    "extra":{
              "updator": {
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
curl 'https://openapi.<<< custom_key.brand_main_domain >>>/api/v1/issue/issue_xxxx32/modify' \
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