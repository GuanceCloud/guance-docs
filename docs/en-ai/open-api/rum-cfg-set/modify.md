# Modify RUM Configuration

---

<br />**POST /api/v1/rum_cfg/{appid}/modify**

## Overview




## Route Parameters

| Parameter Name        | Type     | Required   | Description              |
|:-------------------|:-------|:-------|:----------------|
| appid | string | Y | appId<br> |


## Body Request Parameters

| Parameter Name        | Type     | Required   | Description              |
|:-------------------|:-------|:-------|:----------------|
| newAppId | string |  | New AppId<br>Allow null: False <br>Allow empty string: True <br>$maxCharacterLength: 48 <br> |
| dashboardUuids | array |  | Built-in view UUIDs<br>Allow null: False <br> |
| jsonContent | json |  | JSON formatted content<br> |
| jsonContent.name | string |  | Application name<br>Allow null: False <br>Maximum length: 256 <br> |
| jsonContent.type | string |  | Application type, not modifiable for existing business scenarios<br>Allow null: False <br>Options: ['web', 'miniapp', 'android', 'ios', 'custom', 'reactnative'] <br> |
| jsonContent.extend | json |  | Other settings (please inform if additional fields are needed)<br>Allow null: False <br> |
| clientToken | string |  | clientToken<br>Allow null: False <br>Allow empty string: True <br> |

## Additional Parameter Notes





## Request Example
```shell
curl 'https://openapi.guance.com/api/v1/rum_cfg/fe52be60_xxx_0ffb4a4ef591/modify' \
-H 'DF-API-KEY: <DF-API-KEY>' \
-H 'Content-Type: application/json;charset=UTF-8' \
--data-raw '{"newAppId":"fe52be60_xxx_0ffb4a4ef591","jsonContent":{"name":"assddd"}, "clientToken":"xxx"}' \
--compressed
```




## Response
```shell
{
    "code": 200,
    "content": {
        "appId": "fe52be60_xxx0ffb4a4ef591",
        "createAt": 1690813059,
        "creator": "acnt_xxxx32",
        "deleteAt": -1,
        "id": 1137,
        "jsonContent": {
            "name": "assddd",
            "type": "ios"
        },
        "status": 0,
        "updateAt": 1690813174.8154745,
        "updator": "acnt_xxxx32",
        "uuid": "fe52be60_xxx8ee7_0ffb4a4ef591",
        "workspaceUUID": "wksp_xxxx32",
        "clientToken": "xxx"
    },
    "errorCode": "",
    "message": "",
    "success": true,
    "traceId": "6253921915388520691"
} 
```