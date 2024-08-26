# 获取当前工作空间信息

---

<br />**GET /api/v1/workspace/get**

## 概述
获取当前API Key所属的工作空间信息




## 参数补充说明





## 请求例子
```shell
curl 'https://openapi.guance.com/api/v1/workspace/get' \
-H 'DF-API-KEY: <DF-API-KEY>' \
--compressed 
```




## 响应
```shell
{
    "code": 200,
    "content": {
        "AutomataServerRegionType": "cn",
        "IssueGlobalOpenStatus": true,
        "billingState": "normal",
        "bossStation": "CN",
        "cliToken": "wkcli_xxxxx",
        "createAt": 1695179876,
        "creator": "external",
        "dashboardUUID": null,
        "datastore": {
            "backup_log": "doris",
            "custom_object": "doris",
            "keyevent": "doris",
            "logging": "doris",
            "metric": "guancedb",
            "network": "doris",
            "object": "doris",
            "object_history": "doris",
            "profiling": "doris",
            "rum": "doris",
            "security": "doris",
            "tracing": "doris"
        },
        "dbUUID": "ifdb_xxx",
        "declaration": {
            "asd": "aa,bb,cc,1,True",
            "business": "销售部",
            "organization": "64fe7b406xxxx"
        },
        "deleteAt": -1,
        "desc": "请勿做数据删除操作",
        "durationSet": {
            "backup_log": "180d",
            "keyevent": "14d",
            "logging": "30d",
            "network": "2d",
            "profiling": "7d",
            "rp": "7d",
            "rum": "3d",
            "security": "180d",
            "tracing": "3d"
        },
        "enableMFA": false,
        "enablePublicDataway": 1,
        "esIndexMerged": 0,
        "esIndexSettings": {
            "apm": {
                "hot_retention": 2,
                "number_of_replicas": 1,
                "number_of_shards": 1,
                "openAdvancedConfig": 0,
                "rollover_max_size": 30
            },
            "backup_log": {
                "hot_retention": 0,
                "number_of_replicas": 1,
                "number_of_shards": 1,
                "openAdvancedConfig": 0,
                "rollover_max_size": 30
            },
            "keyevent": {
                "hot_retention": 1,
                "number_of_replicas": 1,
                "number_of_shards": 1,
                "openAdvancedConfig": 0,
                "rollover_max_size": 30
            },
            "logging": {
                "hot_retention": 6,
                "number_of_replicas": 1,
                "number_of_shards": 1,
                "openAdvancedConfig": 0,
                "rollover_max_size": 30
            },
            "network": {
                "hot_retention": 23,
                "number_of_replicas": 1,
                "number_of_shards": 1,
                "openAdvancedConfig": 0,
                "rollover_max_size": 30
            },
            "tracing": {
                "hot_retention": 48,
                "number_of_replicas": 1,
                "number_of_shards": 1,
                "openAdvancedConfig": 0,
                "rollover_max_size": 30
            }
        },
        "esInstanceUUID": "es_nCyRaJjUeWR6uDoris",
        "expensiveCfg": {},
        "exterId": "",
        "faviconUrl": "https://testing-static-res.dataflux.cn/logo/wksp_4b57c7bab38e4a2d9630f675dc20015d_favicon.ico",
        "id": 2928,
        "indexDashboardInfo": {},
        "inviteAudit": 0,
        "isLocked": 0,
        "isOpenCustomMappingRule": 1,
        "isOpenLogMultipleIndex": 1,
        "language": "en",
        "lastDqlDataCheckTime": {
            "ci": true,
            "cloudDial": true,
            "containers": true,
            "events": true,
            "host_processes": true,
            "logging": true,
            "network": true,
            "object": true,
            "profile": true,
            "security": true,
            "tracing": true
        },
        "leftWildcard": true,
        "lockAt": -1,
        "logMultipleIndexCount": 8,
        "loggingCutSize": 10240,
        "logoUrl": "https://testing-static-res.dataflux.cn/logo/xxxxxxxx_logo.png",
        "makeResourceExceptionCode": "",
        "memberCount": "79",
        "menuStyle": "",
        "name": "【Doris】开发测试一起用_",
        "note": "",
        "noviceGuide": true,
        "rpName": "rp1",
        "rumDataWayToken": "",
        "status": 0,
        "supportJsonMessage": 1,
        "tenantId": 2928,
        "timezone": "",
        "token": "tkn_xxxxx",
        "updateAt": 1724244707,
        "updator": "acnt_xxxx",
        "uuid": "wksp_xxxxx",
        "versionType": "pay"
    },
    "errorCode": "",
    "message": "",
    "success": true,
    "traceId": "2956247345653191101"
} 
```




