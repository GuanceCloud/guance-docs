# Create a Channel

---

<br />**POST /api/v1/channel/add**

## Overview




## Body Request Parameters

| Parameter Name        | Type     | Required   | Description              |
|:---------------------|:---------|:----------|:------------------------|
| name | string | Y | Channel name<br>Example: Channel 1 <br>Allow null: False <br>Maximum length: 256 <br> |
| description | string | N | Channel description<br>Example: CUSTOM <br>Allow null: False <br>Allow empty string: True <br>Maximum length: 256 <br> |
| notifyTarget | array | N | List of notification target UUIDs<br>Example: [] <br>Allow null: False <br> |
| notifyUpgradeCfg | json | N | Rule configuration<br>Allow null: False <br> |
| notifyUpgradeCfg.triggerTime | integer | Y | After how many seconds to trigger an upgrade notification, unit is seconds<br>Example: simpleCheck <br>Allow null: False <br> |
| notifyUpgradeCfg.notifyTarget | array | Y | List of upgrade notification target UUIDs<br>Example: [] <br>Allow null: False <br> |

## Additional Parameter Notes





## Request Example
```shell
curl 'https://openapi.<<< custom_key.brand_main_domain >>>/api/v1/channel/add' \
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