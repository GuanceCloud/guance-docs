# 获取单个索引/绑定索引配置

---

<br />**GET /api/v1/log_index_cfg/\{cfg_uuid\}/get**

## 概述
获取一个绑定索引




## 路由参数

| 参数名        | 类型     | 必选   | 说明              |
|:-----------|:-------|:-----|:----------------|
| cfg_uuid | string | Y | 日志索引配置的 uuid<br> |


## Query 请求参数

| 参数名        | 类型     | 必选   | 说明              |
|:-----------|:-------|:-----|:----------------|
| isShowAccessCfg | boolean |  | 是否显示accessCfg<br> |
| isShowFields | boolean |  | 是否显示 fields 列表<br> |

## 参数补充说明

**响应主体结构说明**

|  参数名                |   type  |          说明          |
|-----------------------|----------|------------------------|
|isBindCustomStore         |int |  1:绑定自定义存储的索引配置 0: 默认|
|storeType         |string |  存储类型, ('es': Elasticsearch存储 , 'sls': SLS Logstore存储, 'opensearch': OpenSearch存储, 'beaver':日志易存储) |
|fields         |array |  字段映射配置 |
|accessCfg         |array |  自定义存储索引权限配置项 |




## 请求例子
```shell
curl 'https://openapi.guance.com/api/v1/log_index_cfg/lgim_1145381480dd4a4f95bccdb1f0889141/get' \
-H 'DF-API-KEY: <DF-API-KEY>' \
--compressed
```




## 响应
```shell
{
    "code": 200,
    "content": {
        "conditions": "",
        "createAt": 1677665779,
        "creator": "xxx",
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
        "regionInfo": {},
        "setting": {},
        "sortNo": 0,
        "status": 0,
        "storeType": "es",
        "updateAt": 1677665779,
        "updator": "xxx",
        "uuid": "lgim_1145381480dd4a4f95bccdb1f0889141",
        "workspaceUUID": "wksp_ed134a6485c8484dbd0e58ce9a9c6115"
    },
    "errorCode": "",
    "message": "",
    "success": true,
    "traceId": "TRACE-82BF8659-CD28-409B-833B-97AA4758ACA1"
} 
```




