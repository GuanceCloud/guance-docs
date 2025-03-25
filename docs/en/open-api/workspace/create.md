# Workspace - Create

---

<br />**POST /api/v1/workspace/create**

## Overview
Create a workspace.

Use an existing workspace API Key to create a new workspace.
The owner of the new workspace will default to the owner of the space associated with this request's API Key.




## Body Request Parameters

| Parameter Name        | Type     | Required   | Description              |
|:---------------------|:---------|:----------|:-----------------------|
| name | string | Y | Name<br>Example: supper_workspace <br>Allow empty: False <br>Maximum length: 256 <br> |
| desc | string |  | Description<br>Example: Workspace description <br>Allow empty: True <br>Allow empty string: True <br> |
| menuStyle | string |  | Workspace menu bar style, Operations/Testing/Development<br>Example: Operations <br>Allow empty: False <br>Allow empty string: True <br> |
| needCreateAk | boolean |  | Whether to create a workspace AK<br>Example: True <br>Allow empty: False <br> |
| akName | string |  | Workspace AK name<br>Example: True <br>Allow empty: False <br> |
| language | string |  | Workspace language<br>Allow empty: True <br>Allow empty string: True <br>Optional values: ['zh', 'en'] <br> |

## Supplementary Parameter Explanation


Data explanation.*

- Request parameter explanation

| Parameter Name           | type | Description                                                 |
| ------------------------ | ---- | ---------------------------------------------------------- |
| name       | string | Name of the new space |
| desc             | string | Description of the new space                                                |
| needCreateAk       | boolean  | Whether to create an API KEY in the new space     |
| akName            | string  | Name of the API KEY                                       |

------

- Response parameter explanation

| Parameter Name           | type | Description                                                 |
| ------------------------ | ---- | ---------------------------------------------------------- |
| akInfo       | dict | Information about the API KEY of the new space |
| ownerInfo             | dict | Information about the owner of the new space                                               |
| wsInfo    | dict | Relevant information about the space                  |
| versionType    | string | Space version type                  |

------




## Request Example
```shell
curl 'https://openapi.<<< custom_key.brand_main_domain >>>/api/v1/workspace/create' \
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
            "email": "xxx@<<< custom_key.brand_main_domain >>>",
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
            "versionType": "free"
        }
    },
    "errorCode": "",
    "message": "",
    "success": true,
    "traceId": "TRACE-89835D3F-C614-46AD-A1B8-83CC686DDA7F"
} 
```