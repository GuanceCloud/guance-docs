# Modify Single Index Configuration

---

<br />**POST /api/v1/log_index_cfg/{cfg_uuid}/modify**

## Overview
Modify the configuration of a single default storage index



## Route Parameters

| Parameter Name        | Type     | Required   | Description              |
|:-------------------|:-------|:-----|:----------------|
| cfg_uuid | string | Y | Configuration UUID<br> |


## Body Request Parameters

| Parameter Name        | Type     | Required   | Description              |
|:-------------------|:-------|:-----|:----------------|
| extend | json |  | Custom data from frontend<br>Optional: True <br> |
| duration | string |  | Data retention duration<br>Optional: False <br>Example: 7d <br> |
| setting | json |  | Configuration information<br>Optional: False <br> |
| setting.hot_retention | int |  | Volc Engine Storage, Standard Storage - Hot Storage<br>Optional: False <br> |
| setting.cold_retention | int |  | Volc Engine Storage, Infrequent Access Storage - Cold Data<br>Optional: False <br> |
| setting.archive_retention | int |  | Volc Engine Storage, Archive Storage - Archived Data<br>Optional: False <br> |

## Additional Parameter Notes



## Request Example
```shell
curl 'https://openapi.guance.com/api/v1/log_index_cfg/lgim_xxxx32/modify' \
-H 'Accept: application/json, text/plain, */*' \
-H 'Accept-Language: en' \
-H 'Content-Type: application/json;charset=UTF-8' \
-H 'DF-API-KEY: <DF-API-KEY>' \
--data-raw '{"duration":"7d","extend":{"filters":[{"condition":"and","name":"host","operation":"in","value":["guance"]}]}}' \
--compressed
```




## Response
```shell
{
    "code": 200,
    "content": {
        "conditions": "{  `host` in [ 'guance' ] }",
        "createAt": 1698751853,
        "creator": "xxx",
        "deleteAt": -1,
        "duration": "7d",
        "extend": {
            "filters": [
                {
                    "condition": "and",
                    "name": "host",
                    "operation": "in",
                    "value": [
                        "guance"
                    ]
                }
            ]
        },
        "exterStoreName": "",
        "exterStoreProject": "",
        "externalResourceAccessCfgUUID": "",
        "id": 1376,
        "isBindCustomStore": 0,
        "isPublicNetworkAccess": 0,
        "name": "test_index",
        "queryType": "logging",
        "region": "",
        "setting": {},
        "sortNo": 3,
        "status": 0,
        "storeType": "",
        "updateAt": 1698752013.27368,
        "updator": "xx",
        "uuid": "lgim_xxxx32",
        "workspaceUUID": "wksp_xxxx32"
    },
    "errorCode": "",
    "message": "",
    "success": true,
    "traceId": "TRACE-09F7E56D-1DE5-48C9-A77A-108A53462A75"
} 
```