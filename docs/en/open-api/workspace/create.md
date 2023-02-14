# Workspace-Create

---

<br />**post /api/v1/workspace/create**

## Overview
Create a workspace.




## Body Request Parameter

| Parameter Name        | Type     | Required   | Description              |
|:-----------|:-------|:-----|:----------------|
| name | string | Y | name<br>Example: supper_workspace <br>Allow null: False <br>Maximum length: 256 <br> |
| desc | string |  | description<br>Example: Workspace description <br>Allow null: True <br>Allow empty strings: True <br> |
| needCreateAk | boolean |  | whether to create workspace AK<br>Example: True <br>Allow null: False <br> |
| akName | string |  | Workspace AK name<br>Example: True <br>Allow null: False <br> |

## Supplementary Description of Parameters


*data description.*

- Request Parameter Description

| Parameter Name           | type | Description                                                 |
| ---------------- | ---- | ---------------------------------------------------- |
| name       | string | new space name |
| desc             | string | new space description                                                 |
| needCreateAk       | boolean  | whether to create API KEY in the new space     |
| akName            | string  | name of API KEY                                         |

------

- Response Parameter Description

| Parameter Name           | type | Description                                                 |
| ---------------- | ---- | ---------------------------------------------------- |
| akInfo       | dict | API KEY information for new space |
| ownerInfo             | dict | Owner information of new space                                                 |
| wsInfo    | dict | Spatially related information                  |

------




## Request Example
```shell
curl 'https://openapi.guance.com/api/v1/workspace/create' \
-H 'Accept: application/json, text/plain, */*' \
-H 'Content-Type: application/json;charset=UTF-8' \
-H 'DF-API-KEY: <DF-API-KEY>' \
--data-raw '{"name":"ws_create_test","desc":"test","needCreateAk":true,"akName":"test_ak"}' \
--compressed
--insecure
```




## Response
```shell
{
    "code": 200,
    "content": {
        "accountInfo": [
            "acnt_6f2fd4c0766d11ebb56ef2b2c21faf74"
        ],
        "akInfo": {
            "keyId": "wsak_fb0d6f7f2a3447b8871ad9119e4faac5",
            "keySk": "RTkIO2q1WdHLzt8achfAXiZPvl0KrJu4",
            "name": "test_ak"
        },
        "makeResourceExceptionCode": "",
        "ownerInfo": {
            "accountUUID": "acnt_6f2fd4c0766d11ebb56ef2b2c21faf74",
            "email": "88@qq.com",
            "name": "测试"
        },
        "wsInfo": {
            "billingState": "free",
            "cliToken": "wkcli_3b8cd17e24f84c5fa1bfdefc27f492f5",
            "createAt": 1672802266,
            "creator": "wsak_60b430adbf1440ad991a4647e9ef411a",
            "dashboardUUID": null,
            "datastore": {
                "backup_log": "es",
                "custom_object": "es",
                "keyevent": "es",
                "logging": "es",
                "metric": "influxdb",
                "network": "es",
                "object": "es",
                "object_history": "es",
                "rum": "es",
                "security": "es",
                "tracing": "es"
            },
            "dbUUID": "ifdb_683a9d68ce8042289a0fb51eeb85d43f",
            "deleteAt": -1,
            "desc": "test",
            "durationSet": {
                "apm": "7d",
                "backup_log": "7d",
                "keyevent": "7d",
                "logging": "7d",
                "network": "1d",
                "rp": "7d"
            },
            "enablePublicDataway": 1,
            "esIndexMerged": 1,
            "esIndexSettings": {},
            "esInstanceUUID": "es_1f32b130567411ec9cfbacde48001122",
            "exterId": "",
            "id": null,
            "isLocked": 0,
            "isOpenLogMultipleIndex": false,
            "lockAt": -1,
            "loggingCutSize": 10240,
            "makeResourceExceptionCode": "",
            "name": "ws_create_test",
            "rpName": "rp1",
            "status": 0,
            "supportJsonMessage": 1,
            "token": "tkn_609ab0912a3f4e08b6d60184454ca59c",
            "updateAt": 1672802266,
            "updator": "wsak_60b430adbf1440ad991a4647e9ef411a",
            "uuid": "wksp_320a93deda9a47549ffb95ce26fc6bb4",
            "versionType": "free"
        }
    },
    "errorCode": "",
    "message": "",
    "success": true,
    "traceId": "TRACE-89835D3F-C614-46AD-A1B8-83CC686DDA7F"
} 
```




