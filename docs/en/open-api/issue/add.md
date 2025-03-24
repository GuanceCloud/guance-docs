# Create Issues

---

<br />**POST /api/v1/issue/add**

## Overview




## Body Request Parameters

| Parameter Name        | Type     | Required   | Description              |
|:-------------------|:-------|:-----|:----------------|
| name | string | Y | Title name<br>Example: name <br>Allow empty: False <br>Maximum length: 256 <br> |
| level | string | Y | Level, corresponding to the level configuration UUID<br>Example: level <br>Allow empty: False <br>Allow empty string: True <br> |
| description | string | Y | Description<br>Example: description <br>Allow empty: False <br> |
| attachmentUuids | array |  | List of uploaded attachments UUIDs<br>Example: [] <br>Allow empty: True <br> |
| extend | json | Y | Additional extended information<br>Example: {} <br>Allow empty: True <br> |
| resourceType | string |  | Source type, no need to pass if there is no scenario<br>Example: resourceType <br>Allow empty: False <br>Possible values: ['event', 'dashboard', 'viewer'] <br> |
| resourceUUID | string |  | Corresponding source UUID respectively docid, dashboardUUID, dashboardUUID<br>Example: resourceUuid <br>Allow empty: False <br>Allow empty string: True <br> |
| resource | string |  | Corresponding source name brought in from the source<br>Example: resource <br>Allow empty: False <br>Allow empty string: True <br> |
| channelUUIDs | array |  | Issue delivery tracking channel UUIDs<br>Example: [] <br>Allow empty: True <br> |

## Supplementary Parameter Explanation


**Basic Parameter Description**

|     Parameter Name      | Parameter Type | Required |                  Parameter Description                   |
|:---------------:|:--------:|:--------:|:-------------------------------------------:|
|      name       |  string  |    N     |                Issue title name                |
|      level      | string  |    N    |        Issue level corresponding to the configured level UUID        |
|      statusType      | integer  |    N     |        Issue status, 10: Open, 15: Working, 20: Resolved, 25: Closed, 30: Pending        |
|   decription    |  string  |    N     |                Issue description information                |
| attachmentUuids |  array   |    N     |              Uploaded attachment list UUID, needs to be uploaded first through the /api/v1/attachment/upload interface          |
|     extend      |   json   |    N    |                  Extended field, default pass {}                  |
|  resourceType   |  string  |    N     | event: Event, dashboard: Dashboard, viewer: Viewer (checker: Monitor, this type is automatically created) |
|  resourceUUID   |  string  |    N     |     Resource associated UUID     |
|    resource     |  string  |    N     |                Corresponding resource name                 |
|  channelUUIDs   |  array   |    N     |           Expected issue delivery resource list, default delivery default space default channel  |

**Level Field Description**
Level is divided into system levels/custom levels (can be configured in Configuration Management)

|     Level      | Value |                  Parameter Description                   |
|:---------------:|:--------:|:-------------------------------------------:|
|      P0       |  system_level_0  |      Pass parameter level: system_level_0, indicating system level P0               |
|      P1       |  system_level_1  |      Pass parameter level: system_level_1, indicating system level P1               |
|      P2       |  system_level_2  |      Pass parameter level: system_level_2, indicating system level P2               |
|      P3       |  system_level_3  |      Pass parameter level: system_level_3, indicating system level P3               |
|      xxx      |  issl_yyyyy      |      Pass parameter level: issl_yyyyy, indicating custom level xxx            |


**Issue Channel Description, all issues will automatically be categorized under the default channel (All)**
The channels associated with the issue are: Default channel (All), channels and channelUUIDs

**Extended Field Extend Description**

|  Parameter Name  | Parameter Type | Required |        Parameter Description         |
|:--------:|:--------:|:--------:|:-----------------------:|
| channels |  array   |    N     | Description content's #: Expected issue delivery resource list, |
| linkList |  array   |    N     | Add issue links |
| members  |     array     |     N     |       Description content's @: Expected notification target members for the issue    |
| manager |  array   |    N     |              User account UUID, email, team UUID        |
| extra  |     json     |     N     |      Information about the creator/responsible person for the issue, used for front-end display    |

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
        "xxx@<<< custom_key.brand_main_domain >>>",
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
curl 'https://openapi.<<< custom_key.brand_main_domain >>>/api/v1/issue/add' \
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