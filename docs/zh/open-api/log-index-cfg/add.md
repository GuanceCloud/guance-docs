# 新建单个索引配置

---

<br />**POST /api/v1/log_index_cfg/add**

## 概述
修改单个默认存储索引配置




## Body 请求参数

| 参数名        | 类型     | 必选   | 说明              |
|:-----------|:-------|:-----|:----------------|
| name | string | Y | 索引名字<br>例子: xxx <br>允许为空: False <br>最大长度: 256 <br> |
| extend | json |  | 前端自定义数据<br>允许为空: True <br> |
| duration | string |  | 数据保留时长<br>允许为空: False <br> |

## 参数补充说明





## 请求例子
```shell
curl 'https://openapi.guance.com/api/v1/log_index_cfg/add' \
-H 'Accept: application/json, text/plain, */*' \
-H 'Accept-Language: zh' \
-H 'Content-Type: application/json;charset=UTF-8' \
-H 'DF-API-KEY: <DF-API-KEY>' \
--data-raw '{"name": "test_index", "duration":"14d","extend":{"filters":[{"condition":"and","name":"host","operation":"in","value":["custom_host1"]}]}}' \
--compressed
```




## 响应
```shell
{
    "code": 200,
    "content": {
        "conditions": "{  `host` in [ 'custom_host1' ] }",
        "createAt": 1698751853,
        "creator": "wsak_72b16919b18c411496b6dd06fc9ccc72",
        "deleteAt": -1,
        "duration": "14d",
        "extend": {
            "filters": [
                {
                    "condition": "and",
                    "name": "host",
                    "operation": "in",
                    "value": [
                        "custom_host1"
                    ]
                }
            ]
        },
        "exterStoreName": "",
        "exterStoreProject": "",
        "externalResourceAccessCfgUUID": "",
        "id": null,
        "isBindCustomStore": 0,
        "isPublicNetworkAccess": 0,
        "name": "test_index",
        "queryType": "logging",
        "region": "",
        "setting": {},
        "sortNo": 3,
        "status": 0,
        "storeType": "",
        "updateAt": 1698751853,
        "updator": "wsak_72b16919b18c411496b6dd06fc9ccc72",
        "uuid": "lgim_e5ef2a328d084732a6bbcbac33fc2d67",
        "workspaceUUID": "wksp_ed134a6485c8484dbd0e58ce9a9c6115"
    },
    "errorCode": "",
    "message": "",
    "success": true,
    "traceId": "TRACE-600346C3-6C89-4391-9CA3-2152D10149D8"
} 
```




