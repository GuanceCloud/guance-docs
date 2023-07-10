# 获取绑定的索引列表

---

<br />**GET /api/v1/log_index_cfg/list**

## 概述
列出索引信息




## Query 请求参数

| 参数名        | 类型     | 必选   | 说明              |
|:-----------|:-------|:-----|:----------------|
| targetWorkspaceUUID | string |  | 目标工作空间<br> |
| isBindCustomStore | boolean |  | 是否绑定自定义存储<br> |
| queryType | commaArray |  | 存储查询类型<br> |

## 参数补充说明





## 请求例子
```shell
curl 'https://openapi.guance.com/api/v1/log_index_cfg/list' \
-H 'DF-API-KEY: <DF-API-KEY>' \
--compressed 
```




## 响应
```shell
{
    "code": 200,
    "content": [
        {
            "conditions": "{  source in [ 'mysql' ] }",
            "createAt": 1677571213,
            "creator": "acnt_e85847e7fe894ea9938dd29c22bc1f9b",
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
            "updator": "acnt_e85847e7fe894ea9938dd29c22bc1f9b",
            "uuid": "lgim_4a5bff2aa04c4cfdbfa75895e0ca5d2e",
            "workspaceUUID": "wksp_ed134a6485c8484dbd0e58ce9a9c6115"
        },
        {
            "conditions": "{  source in [ 'df_diagnose' ] }",
            "createAt": 1677566168,
            "creator": "acnt_7df07453091748b08f5ea2514f6a22f2",
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
            "updator": "acnt_7df07453091748b08f5ea2514f6a22f2",
            "uuid": "lgim_cb0c5c8e408846ab80facf226b93ee03",
            "workspaceUUID": "wksp_ed134a6485c8484dbd0e58ce9a9c6115"
        },
        {
            "conditions": "",
            "createAt": 1677489543,
            "creator": "acnt_349ee5f70a89442fa94b4f754b5acbfe",
            "deleteAt": -1,
            "duration": "",
            "extend": {},
            "exterStoreName": "s",
            "exterStoreProject": "",
            "externalResourceAccessCfgUUID": "erac_c70e86d8d52849e2af05fe60fcf1d1ed",
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
            "updator": "acnt_349ee5f70a89442fa94b4f754b5acbfe",
            "uuid": "lgim_21c3c9ed091046398e9b4a53a62fddaf",
            "workspaceUUID": "wksp_ed134a6485c8484dbd0e58ce9a9c6115"
        },
        {
            "conditions": "",
            "createAt": 1677665779,
            "creator": "wsak_ecdec9f27d6c482a997c218b2fb351a0",
            "deleteAt": -1,
            "duration": "",
            "extend": {},
            "exterStoreName": "aa_uuid",
            "exterStoreProject": "",
            "externalResourceAccessCfgUUID": "erac_155b376bfdaf4c529e8567bb818058c5",
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
            "updator": "wsak_ecdec9f27d6c482a997c218b2fb351a0",
            "uuid": "lgim_1145381480dd4a4f95bccdb1f0889141",
            "workspaceUUID": "wksp_ed134a6485c8484dbd0e58ce9a9c6115"
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
            "workspaceUUID": "wksp_ed134a6485c8484dbd0e58ce9a9c6115"
        }
    ],
    "errorCode": "",
    "message": "",
    "success": true,
    "traceId": "TRACE-2EB09DB4-7D3C-4DA5-9054-81856CC0589D"
} 
```




