# 修改工作空间

---

<br />**POST /api/v1/workspace/modify**

## 概述
修改当前API Key所属的工作空间信息




## Body 请求参数

| 参数名        | 类型     | 必选   | 说明              |
|:-----------|:-------|:-----|:----------------|
| name | string |  | 名称<br>例子: supper_workspace <br>允许为空: False <br>最大长度: 256 <br> |
| desc | string |  | 备注<br>例子: ccc <br>允许为空: False <br>允许为空字符串: True <br> |

## 参数补充说明





## 请求例子
```shell
curl 'https://openapi.<<< custom_key.brand_main_domain >>>/api/v1/workspace/modify' \
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
        "createAt": 1676979022,
        "creator": "mact_xxxx32",
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
        "dbUUID": "ifdb_xxxx32",
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
        "updateAt": 1677670046.184892,
        "updator": "wsak_xxxxx",
        "uuid": "wksp_xxxx32",
        "versionType": "pay"
    },
    "errorCode": "",
    "message": "",
    "success": true,
    "traceId": "TRACE-99A84810-9380-4FDC-B9CC-18A6B19B2A7A"
} 
```




