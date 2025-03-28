# 获取单个数据转发规则

---

<br />**GET /api/v1/log_backup_cfg/\{cfg_uuid\}/get**

## 概述
获取单个数据转发规则




## 路由参数

| 参数名        | 类型     | 必选   | 说明              |
|:-----------|:-------|:-----|:----------------|
| cfg_uuid | string | Y | 转发规则的 uuid<br> |


## 参数补充说明

**响应主体结构说明**

|  参数名                |   type  |          说明          |
|-----------------------|----------|------------------------|
|accessCfg         |dict |  第三方存储配置信息 |
|name         |string |  转发规则名称 |
|uuid             |string |  转发规则的唯一uuid |
|status         |string |  转发规则状态, 0:启用中, 2:禁用中 |
|dataType         |string |  数据类型 |
|conditions         |string |  dql格式的过滤条件 |
|storeType         |string |  存储类型 |
|externalResourceAccessCfgUUID         |string |  外部资源访问配置UUID |
|workspaceUUID             |string |  转发规则所在的空间UUID |




## 请求例子
```shell
curl 'https://openapi.<<< custom_key.brand_main_domain >>>/api/v1/log_backup_cfg/lgbp_xxxx32/get' \
-H 'DF-API-KEY: <DF-API-KEY>' \
--compressed
```




## 响应
```shell
{
    "code": 200,
    "content": {
        "accessCfg": {
            "bucket": "sdafdasf",
            "cloudAccountId": "f000ee4d7327428da2f53a081e7109bd",
            "dataType": "logging",
            "provider": "huawei",
            "region": "cn-north-4",
            "storeType": "obs"
        },
        "conditions": "",
        "createAt": 1697543205,
        "creator": "acnt_xxxx32",
        "dataType": "logging",
        "deleteAt": -1,
        "extend": {
            "filterLogic": "and",
            "filters": []
        },
        "externalResourceAccessCfgUUID": "erac_xxxx32",
        "id": 684,
        "name": "ssfda***",
        "status": 0,
        "storeType": "obs",
        "syncExtensionField": false,
        "taskErrorCode": "NoSuchBucket",
        "taskStatusCode": 404,
        "updateAt": 1697610912,
        "updator": "acnt_xxxx32",
        "uuid": "lgbp_xxxx32",
        "workspaceUUID": "wksp_xxxx32"
    },
    "errorCode": "",
    "message": "",
    "success": true,
    "traceId": "TRACE-EC139239-C9D7-4A7C-A548-20F97358DF24"
} 
```




