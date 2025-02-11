# Add RUM Configuration Information

---

<br />**POST /api/v1/rum_cfg/add**

## Overview




## Body Request Parameters

| Parameter Name        | Type     | Required | Description              |
|:---------------------|:---------|:---------|:------------------------|
| customIdentity | string | No | Custom identity (maximum 19 characters)<br>Allow null: False <br>Allow empty string: True <br>$maxCharacterLength: 19 <br> |
| appId | string | No | Custom appId (maximum 48 characters)<br>Allow null: False <br>Allow empty string: True <br>$maxCharacterLength: 48 <br> |
| dashboardUuids | array | No | Built-in view UUIDs<br>Allow null: False <br> |
| jsonContent | json | Yes | JSON formatted content<br>Allow null: False <br> |
| jsonContent.name | string | Yes | Application name<br>Allow null: False <br>Maximum length: 256 <br> |
| jsonContent.type | string | Yes | Application type<br>Allow null: False <br>Possible values: ['web', 'miniapp', 'android', 'ios', 'custom', 'reactnative'] <br> |
| jsonContent.extend | json | No | Additional settings (please inform if you need to add fields at the same level)<br>Allow null: False <br> |
| clientToken | string | No | Client token<br>Allow null: False <br>Allow empty string: True <br> |

## Additional Parameter Notes



## Request Example
```shell
curl 'https://openapi.guance.com/api/v1/rum_cfg/add' \
-H 'DF-API-KEY: <DF-API-KEY>' \
-H 'Content-Type: application/json;charset=UTF-8' \
--data-raw '{"appId":"fe52be60_2fac_11ee_8ee7_0ffb4a4ef591","jsonContent":{"name":"ass","type":"ios"},"clientToken":"xxx"}' \
--compressed
```




## Response
```shell
{
    "code": 200,
    "content": {
        "appId": "fe52be60_2fac_11ee_8ee7_0ffb4a4ef591",
        "createAt": 1690813059,
        "creator": "acnt_xxxx32",
        "deleteAt": -1,
        "id": null,
        "jsonContent": {
            "name": "ass",
            "type": "ios"
        },
        "status": 0,
        "updateAt": 1690813059,
        "updator": "acnt_xxxx32",
        "uuid": "fe52be60_2fac_11ee_8ee7_0ffb4a4ef591",
        "workspaceUUID": "wksp_xxxx32",
        "clientToken": "xxx"
    },
    "errorCode": "",
    "message": "",
    "success": true,
    "traceId": "5891899618838740754"
} 
```