# Modify Channel Information

---

<br />**POST /api/v1/channel/\{channel_uuid\}/modify**

## Overview




## Route Parameters

| Parameter Name        | Type     | Required   | Description              |
|:-------------------|:-------|:-----|:----------------|
| channel_uuid | string | Y | Channel UUID<br> |


## Body Request Parameters

| Parameter Name        | Type     | Required   | Description              |
|:-------------------|:-------|:-----|:----------------|
| name | string |  | Channel name<br>Example: Channel 1 <br>Can be empty: False <br>Maximum length: 256 <br> |
| description | string |  | Channel description<br>Example: CUSTOM <br>Can be empty: False <br>Can be an empty string: True <br>Maximum length: 256 <br> |
| notifyTarget | array |  | List of notification target UUIDs<br>Example: [] <br>Can be empty: False <br> |
| notifyUpgradeCfg | json |  | Rule configuration<br>Can be empty: False <br> |
| notifyUpgradeCfg.triggerTime | integer | Y | After how many seconds to trigger upgrade notification, unit is seconds<br>Example: simpleCheck <br>Can be empty: False <br> |
| notifyUpgradeCfg.notifyTarget | array | Y | List of upgrade notification target UUIDs<br>Example: [] <br>Can be empty: False <br> |

## Additional Parameter Notes





## Request Example
```shell
curl 'https://openapi.guance.com/api/v1/channel/chan_xxxx32/modify' \
-H 'DF-API-KEY: <DF-API-KEY>' \
-H 'Content-Type: application/json;charset=UTF-8' \
--data-raw '{"description":"dasdgahjsdgashjgdhajsgdasjhgdhjasgdajhsgzxvchv @sadddddd","notifyTarget":["notify_xxxx32"]}' \
--compressed
```




## Response
```shell
{
    "code": 200,
    "content": {
        "createAt": 1680257540,
        "creator": "acnt_xxxx32",
        "deleteAt": 1681968404,
        "description": "dasdgahjsdgashjgdhajsgdasjhgdhjasgdajhsgzxvchv @sadddddd",
        "id": 33,
        "name": "default",
        "notifyTarget": [
            "notify_xxxx32"
        ],
        "status": 0,
        "updateAt": 1686397319.9216194,
        "updator": "acnt_xxxx32",
        "uuid": "chan_xxxx32",
        "workspaceUUID": "wksp_xxxx32"
    },
    "errorCode": "",
    "message": "",
    "success": true,
    "traceId": "14871204483417928076"
} 
```