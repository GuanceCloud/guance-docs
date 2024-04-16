# 修改单个索引配置

---

<br />**POST /api/v1/log_index_cfg/\{cfg_uuid\}/modify**

## 概述
修改单个默认存储索引配置




## 路由参数

| 参数名        | 类型     | 必选   | 说明              |
|:-----------|:-------|:-----|:----------------|
| cfg_uuid | string | Y | 配置uuid<br> |


## Body 请求参数

| 参数名        | 类型     | 必选   | 说明              |
|:-----------|:-------|:-----|:----------------|
| extend | json |  | 前端自定义数据<br>允许为空: True <br> |
| duration | string |  | 数据保留时长<br>允许为空: False <br> |

## 参数补充说明





## 请求例子
```shell
curl 'https://openapi.guance.com/api/v1/log_index_cfg/lgim_6351251e2103441abb96a0b43bdabc02/modify' \
-H 'Accept: application/json, text/plain, */*' \
-H 'Accept-Language: zh' \
-H 'Content-Type: application/json;charset=UTF-8' \
-H 'DF-API-KEY: <DF-API-KEY>' \
--data-raw '{"duration":"7d","extend":{"filters":[{"condition":"and","name":"host","operation":"in","value":["guance"]}]}}' \
--compressed
```




## 响应
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
        "uuid": "lgim_e5ef2a328d084732a6bbcbac33fc2d67",
        "workspaceUUID": "wksp_ed134a6485c8484dbd0e58ce9a9c6115"
    },
    "errorCode": "",
    "message": "",
    "success": true,
    "traceId": "TRACE-09F7E56D-1DE5-48C9-A77A-108A53462A75"
} 
```




