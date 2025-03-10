# Get Index List

---

<br />**GET /api/v1/log_index_cfg/list**

## Overview
List index information


## Query Request Parameters

| Parameter Name        | Type     | Required   | Description              |
|:------------------|:-------|:-----|:----------------|
| targetWorkspaceUUID | string | No | Target workspace<br> |
| isBindCustomStore | boolean | No | Whether to bind custom storage<br> |
| queryType | commaArray | No | Storage query type<br> |

## Additional Parameter Notes

**Response Body Structure Description**

| Parameter Name                | Type  | Description          |
|-----------------------|----------|------------------------|
| isBindCustomStore         | int | 1: Index configuration bound to custom storage 0: Default |
| storeType         | string | Storage type, ('es': Elasticsearch storage, 'sls': SLS Logstore storage, 'opensearch': OpenSearch storage, 'beaver': Beaver storage) |



## Request Example
```shell
curl 'https://openapi.<<< custom_key.brand_main_domain >>>/api/v1/log_index_cfg/list' \
-H 'DF-API-KEY: <DF-API-KEY>' \
--compressed 
```




## Response
```shell
{
    "code": 200,
    "content": [
        {
            "conditions": "{  source in [ 'mysql' ] }",
            "createAt": 1677571213,
            "creator": "xx",
            "creatorInfo": {
                "uuid": "xx",
                "status": 0,
                "username": "xx",
                "name": "xx",
                "iconUrl": "",
                "email": "xx",
                "acntWsNickname": "xx"
            },
            "deleteAt": -1,
            "duration": "14d",
            "extend": {
                "filters": [
                    {
                        "condition": "and",
                        "name": "source",
                        "operation": "in",
                        "value": [
                            "mysql"
                        ]
                    }
                ]
            },
            "exterStoreName": "",
            "exterStoreProject": "",
            "externalResourceAccessCfgUUID": "",
            "id": 5,
            "isBindCustomStore": 0,
            "isPublicNetworkAccess": 0,
            "name": "no_1",
            "queryType": "logging",
            "region": "",
            "setting": {},
            "sortNo": 4,
            "status": 0,
            "storeType": "",
            "updateAt": 1677571213,
            "updator": "xx",
            "updatorInfo": {
                "uuid": "xx",
                "status": 0,
                "username": "xx",
                "name": "xx",
                "iconUrl": "",
                "email": "xx",
                "acntWsNickname": "xx"
            },
            "uuid": "lgim_xxxd2e",
            "workspaceUUID": "wksp_xxx115"
        },
        {
            "conditions": "{  source in [ 'df_diagnose' ] }",
            "createAt": 1677566168,
            "creator": "xx",
            "creatorInfo": {
                "uuid": "xx",
                "status": 0,
                "username": "xx",
                "name": "xx",
                "iconUrl": "",
                "email": "xx",
                "acntWsNickname": "xx"
            },
            "deleteAt": -1,
            "duration": "7d",
            "extend": {
                "filters": [
                    {
                        "condition": "and",
                        "name": "source",
                        "operation": "in",
                        "value": [
                            "df_diagnose"
                        ]
                    }
                ]
            },
            "exterStoreName": "",
            "exterStoreProject": "",
            "externalResourceAccessCfgUUID": "",
            "id": 4,
            "isBindCustomStore": 0,
            "isPublicNetworkAccess": 0,
            "name": "datakit",
            "queryType": "logging",
            "region": "",
            "setting": {},
            "sortNo": 3,
            "status": 0,
            "storeType": "",
            "updateAt": 1677566168,
            "updator": "xx",
            "updatorInfo": {
                "uuid": "xx",
                "status": 0,
                "username": "xx",
                "name": "xx",
                "iconUrl": "",
                "email": "xx",
                "acntWsNickname": "xx"
            },
            "uuid": "lgim_xxxe03",
            "workspaceUUID": "wksp_xxx115"
        },
        {
            "conditions": "",
            "createAt": 1677489543,
            "creator": "xx",
            "creatorInfo": {
                "uuid": "xx",
                "status": 0,
                "username": "xx",
                "name": "xx",
                "iconUrl": "",
                "email": "xx",
                "acntWsNickname": "xx"
            },
            "deleteAt": -1,
            "duration": "",
            "extend": {},
            "exterStoreName": "s",
            "exterStoreProject": "",
            "externalResourceAccessCfgUUID": "erac_xxx1ed",
            "id": 1,
            "isBindCustomStore": 1,
            "isPublicNetworkAccess": 1,
            "name": "s",
            "queryType": "logging",
            "region": "",
            "setting": {},
            "sortNo": 0,
            "status": 0,
            "storeType": "es",
            "updateAt": 1677489543,
            "updator": "xx",
            "updatorInfo": {
                "uuid": "xx",
                "status": 0,
                "username": "xx",
                "name": "xx",
                "iconUrl": "",
                "email": "xx",
                "acntWsNickname": "xx"
            },
            "uuid": "lgim_xxxdaf",
            "workspaceUUID": "wksp_xxx115"
        },
        {
            "conditions": "",
            "createAt": 1677665779,
            "creator": "xxx",
            "creatorInfo": {
                "uuid": "xx",
                "status": 0,
                "username": "xx",
                "name": "xx",
                "iconUrl": "",
                "email": "xx",
                "acntWsNickname": "xx"
            },
            "deleteAt": -1,
            "duration": "",
            "extend": {},
            "exterStoreName": "aa_uuid",
            "exterStoreProject": "",
            "externalResourceAccessCfgUUID": "erac_xxx8c5",
            "id": 12,
            "isBindCustomStore": 1,
            "isPublicNetworkAccess": 1,
            "name": "openapi_test",
            "queryType": "logging",
            "region": "",
            "setting": {},
            "sortNo": 0,
            "status": 0,
            "storeType": "es",
            "updateAt": 1677665779,
            "updator": "xx",
            "updatorInfo": {
                "uuid": "xx",
                "status": 0,
                "username": "xx",
                "name": "xx",
                "iconUrl": "",
                "email": "xx",
                "acntWsNickname": "xx"
            },
            "uuid": "lgim_xxx141",
            "workspaceUUID": "wksp_xxx115"
        },
        {
            "conditions": "",
            "duration": "14d",
            "extend": {},
            "isBindCustomStore": false,
            "name": "default",
            "queryType": "logging",
            "sortNo": -1,
            "uuid": "default",
            "workspaceUUID": "wksp_xxx115"
        }
    ],
    "errorCode": "",
    "message": "",
    "success": true,
    "traceId": "TRACE-2EB09DB4-7D3C-4DA5-9054-81856CC0589D"
} 
```