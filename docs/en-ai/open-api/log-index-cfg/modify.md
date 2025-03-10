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
| extend | json |  | Custom data from frontend<br>Can be empty: True <br> |
| duration | string |  | Data retention period<br>Can be empty: False <br>Example: 7d <br> |
| setting | json |  | Configuration information<br>Can be empty: False <br> |
| setting.hot_retention | int |  | Volcengine storage, standard storage - hot data<br>Can be empty: False <br> |
| setting.cold_retention | int |  | Volcengine storage, infrequent storage - cold data<br>Can be empty: False <br> |
| setting.archive_retention | int |  | Volcengine storage, archive storage - archived data<br>Can be empty: False <br> |

## Additional Parameter Notes



## Request Example
```shell
curl 'https://openapi.<<< custom_key.brand_main_domain >>>/api/v1/log_index_cfg/lgim_xxxx32/modify' \
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