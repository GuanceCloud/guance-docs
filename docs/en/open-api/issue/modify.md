# Modify Issue

---

<br />**POST /api/v1/issue/\{issue_uuid\}/modify**

## Overview




## Route Parameters

| Parameter Name        | Type     | Required   | Description              |
|:-------------------|:-------|:-----|:----------------|
| issue_uuid | string | Y | issueUUID<br> |


## Body Request Parameters

| Parameter Name        | Type     | Required   | Description              |
|:-------------------|:-------|:-----|:----------------|
| name | string |  | Title name<br>Example: name <br>Can be empty: False <br>$maxCustomLength: 256 <br> |
| level | string |  | Level, corresponding to level configuration uuid<br>Example: level <br>Can be empty: False <br>Can be an empty string: True <br> |
| description | string |  | Description<br>Example: description <br>Can be empty: False <br> |
| statusType | integer |  | Status of the issue<br>Example: statusType <br>Can be empty: False <br>Possible values: [10, 15, 20, 25, 30] <br> |
| extend | json | Y | Additional extension information, default is {} if no content<br>Example: {} <br>Can be empty: True <br> |
| attachmentUuids | array |  | List of attachment upload uuids<br>Example: [] <br>Can be empty: True <br> |

## Additional Parameter Explanations


**Basic Parameter Explanation**

|     Parameter Name      | Parameter Type | Mandatory |                  Parameter Description                   |
|:---------------:|:--------:|:--------:|:-------------------------------------------:|
|      name       |  string  |    N     |                Issue title name                |
|      level      | string  |    N    |        Issue level corresponding to configuration level uuid        |
|      statusType      | integer  |    N     |        Issue status, 10: Open, 15: Working, 20: Resolved, 25: Closed, 30: Pending     |
|   decription    |  string  |    N     |                Issue description information                |
| attachmentUuids |  array   |    N     |              List of attachment upload uuids, must first be uploaded through the /api/v1/attachment/upload interface          |
|     extend      |   json   |    N    |                  Extension fields, default send {}                  |

**Level Field Explanation**
Level is divided into system levels/custom levels (can be configured in Configuration Management)

|     Level      | Value |                  Parameter Description                   |
|:---------------:|:--------:|:-------------------------------------------:|
|      P0       |  system_level_0  |      Send parameter level: system_level_0, represents system level P0               |
|      P1       |  system_level_1  |      Send parameter level: system_level_1, represents system level P1               |
|      P2       |  system_level_2  |      Send parameter level: system_level_2, represents system level P2               |
|      P3       |  system_level_3  |      Send parameter level: system_level_3, represents system level P3               |
|      xxx      |  issl_yyyyy      |      Send parameter level: issl_yyyyy, represents custom level xxx            |


**Extension Field Extend Explanation**

|  Parameter Name  | Parameter Type | Mandatory |        Parameter Description         |
|:--------:|:--------:|:--------:|:-----------------------:|
| channels |  array   |    N     | Description content with # : Expected list of resources for issue delivery, |
| linkList |  array   |    N     | Add issue links |
| members  |     array     |     N     |       Description content with @ expected notification target members for issue notification    |
| manager |  array   |    N     |              User account uuid, email, team uuid        |
| extra  |     json     |     N     |      Updater/responsible person's email corresponding name information for issue, used for front-end reflection    |

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
        "acnt_xxxxx",
        "xxx@<<< custom_key.brand_main_domain >>>",
        "group_xxx",
        "xxx@<<< custom_key.brand_main_domain >>>"
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
                  "email": "xxx@<<< custom_key.brand_main_domain >>>",
              },
              "managerInfos": {
                  "xxx@<<< custom_key.brand_main_domain >>>": {"name": "111"},
                  "xxx@<<< custom_key.brand_main_domain >>>": {"name": "222"}
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
            "email": "xxx@<<< custom_key.brand_main_domain >>>",
            "iconUrl": "",
            "name": "wanglei-testing",
            "username": "xxx@<<< custom_key.brand_main_domain >>>"
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
            "email": "xxx@<<< custom_key.brand_main_domain >>>",
            "iconUrl": "",
            "name": "wanglei-testing",
            "username": "xxx@<<< custom_key.brand_main_domain >>>"
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