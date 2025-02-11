# Create a Channel

---

<br />**POST /api/v1/channel/add**

## Overview




## Body Request Parameters

| Parameter Name        | Type     | Required | Description              |
|:-------------------|:-------|:-----|:----------------|
| name | string | Y | Channel name<br>Example: Channel 1 <br>Nullable: False <br>Maximum length: 256 <br> |
| description | string | N | Description of the channel<br>Example: CUSTOM <br>Nullable: False <br>Allows empty string: True <br>Maximum length: 256 <br> |
| notifyTarget | array | N | List of notification target UUIDs<br>Example: [] <br>Nullable: False <br> |
| notifyUpgradeCfg | json | N | Rule configuration<br>Nullable: False <br> |
| notifyUpgradeCfg.triggerTime | integer | Y | After how many seconds to trigger an upgrade notification, unit s<br>Example: simpleCheck <br>Nullable: False <br> |
| notifyUpgradeCfg.notifyTarget | array | Y | List of UUIDs for upgrade notification targets<br>Example: [] <br>Nullable: False <br> |

## Additional Parameter Notes





## Request Example
```shell
curl 'https://openapi.guance.com/api/v1/channel/add' \
-H 'DF-API-KEY: <DF-API-KEY>' \
-H 'Content-Type: application/json;charset=UTF-8' \
--data-raw '{"name":"aaada"}' \
--compressed
```




## Response
```shell
{
    "code": 200,
    "content": {
        "createAt": 1686396907,
        "creator": "acnt_xxxx32",
        "deleteAt": -1,
        "description": "",
        "id": null,
        "name": "aaaa",
        "notifyTarget": [],
        "status": 0,
        "updateAt": 1686396907,
        "updator": "acnt_xxxx32",
        "uuid": "chan_xxxx32",
        "workspaceUUID": "wksp_xxxx32"
    },
    "errorCode": "",
    "message": "",
    "success": true,
    "traceId": "8625720404757178607"
} 
```