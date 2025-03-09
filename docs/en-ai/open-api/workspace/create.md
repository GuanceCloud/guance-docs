# Workspace - Create

---

<br />**POST /api/v1/workspace/create**

## Overview
Create a workspace.

Using an existing workspace API Key, create a new workspace.
The owner of the new workspace defaults to the owner of the space associated with the API Key used in this request.

## Body Request Parameters

| Parameter Name        | Type     | Required | Description              |
|:---------------------|:---------|:---------|:------------------------|
| name | string | Y | Name<br>Example: supper_workspace <br>Allow empty: False <br>Maximum length: 256 <br> |
| desc | string | N | Description<br>Example: Workspace description <br>Allow empty: True <br>Allow empty string: True <br> |
| menuStyle | string | N | Workspace menu style, Operations/Testing/Development<br>Example: Operations <br>Allow empty: False <br>Allow empty string: True <br> |
| needCreateAk | boolean | N | Whether to create a workspace AK<br>Example: True <br>Allow empty: False <br> |
| akName | string | N | Workspace AK name<br>Example: test_ak <br>Allow empty: False <br> |
| language | string | N | Workspace language<br>Allow empty: True <br>Allow empty string: True <br>Optional values: ['zh', 'en'] <br> |

## Additional Parameter Notes

Data description.*

- Request parameter explanation

| Parameter Name           | Type | Description                                                 |
| ------------------------ | ---- | ----------------------------------------------------------- |
| name       | string | Name of the new workspace |
| desc             | string | Description of the new workspace                                                 |
| needCreateAk       | boolean  | Whether to create an API KEY in the new workspace     |
| akName            | string  | Name of the API KEY                                         |

------

- Response parameter explanation

| Parameter Name           | Type | Description                                                 |
| ------------------------ | ---- | ----------------------------------------------------------- |
| akInfo       | dict | Information about the new workspace's API KEY |
| ownerInfo             | dict | Information about the owner of the new workspace                                                 |
| wsInfo    | dict | Information about the workspace                  |
| versionType    | string | Workspace version type                  |

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
            "acnt_xxxxxx"
        ],
        "akInfo": {
            "keyId": "wsak_xxxxxx",
            "keySk": "xxxxxxxxxxx",
            "name": "test_ak"
        },
        "makeResourceExceptionCode": "",
        "ownerInfo": {
            "accountUUID": "acnt_xxxxxxxxxx",
            "email": "xxxxx@qq.com",
            "name": "Test"
        },
        "wsInfo": {
            "billingState": "free",
            "createAt": 1672802266,
            "creator": "wsak_xxxxx",
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
            "dbUUID": "ifdb_xxxx32",
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
            "esInstanceUUID": "es_xxxx32",
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
            "updateAt": 1672802266,
            "updator": "wsak_xxxxx",
            "uuid": "wksp_xxxx32",
            "versionType": "Free Plan"
        }
    },
    "errorCode": "",
    "message": "",
    "success": true,
    "traceId": "TRACE-89835D3F-C614-46AD-A1B8-83CC686DDA7F"
} 
```