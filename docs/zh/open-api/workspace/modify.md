# 修改工作空间

---

<br />**POST /api/v1/workspace/modify**

## 概述
修改当前API Key所属的工作空间信息




## Body 请求参数

| 参数名        | 类型     | 必选   | 说明              |
|:-----------|:-------|:-----|:----------------|
| name | string |  | 名称<br>例子: supper_workspace <br>允许为空: False <br>最大长度: 256 <br> |
| desc | string |  | 备注<br>例子: ccc <br>允许为空: False <br>允许空字符串: True <br> |

## 参数补充说明





## 请求例子
```shell
curl 'https://openapi.guance.com/api/v1/workspace/modify' \
-H 'Accept: application/json, text/plain, */*' \
-H 'Content-Type: application/json;charset=UTF-8' \
-H 'DF-API-KEY: <DF-API-KEY>' \
--data-raw '{"name":"ws_test","desc":"test"}' \
--compressed
--insecure
```




## 响应
```shell
{
    "code": 200,
    "content": {
        "billingState": "normal",
        "cliToken": "wkcli_6fbbb9037b9b428e9ce3376ae99e11f4",
        "createAt": 1676979022,
        "creator": "mact_738b7d961dfa464da4deb7b69f1bbca6",
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
        "dbUUID": "ifdb_c448231fe67e4e4cb6994377840a126c",
        "deleteAt": -1,
        "desc": "",
        "durationSet": {
            "apm": "14d",
            "backup_log": "180d",
            "keyevent": "14d",
            "logging": "14d",
            "network": "2d",
            "rp": "30d"
        },
        "enablePublicDataway": 1,
        "esIndexMerged": 1,
        "esIndexSettings": {},
        "esInstanceUUID": "es_nCyRaJjUeWR6uRquxnCRs9ZV",
        "exterId": "",
        "id": 2,
        "isLocked": 0,
        "isOpenLogMultipleIndex": 1,
        "language": "zh",
        "leftExpensiveQuery": true,
        "loggingCutSize": 10240,
        "makeResourceExceptionCode": "",
        "name": "开发测试一起用22",
        "rpName": "rp1",
        "status": 0,
        "supportJsonMessage": 1,
        "token": "tkn_7ca9b1139db64fa6ac34801145a9cb6e",
        "updateAt": 1677670046.184892,
        "updator": "wsak_ecdec9f27d6c482a997c218b2fb351a0",
        "uuid": "wksp_ed134a6485c8484dbd0e58ce9a9c6115",
        "versionType": "pay"
    },
    "errorCode": "",
    "message": "",
    "success": true,
    "traceId": "TRACE-99A84810-9380-4FDC-B9CC-18A6B19B2A7A"
} 
```




