# Modify Workspace

---

<br />**POST /api/v1/workspace/modify**

## Overview
Modify the information of the workspace associated with the current API Key



## Body Request Parameters

| Parameter Name | Type   | Required | Description                                      |
|:--------------|:-------|:---------|:-------------------------------------------------|
| name          | string |          | Name<br>Example: supper_workspace <br>Nullable: False <br>Maximum Length: 256 <br> |
| desc          | string |          | Notes<br>Example: ccc <br>Nullable: False <br>Empty String Allowed: True <br> |

## Additional Parameter Information



## Request Example
```shell
curl 'https://openapi.guance.com/api/v1/workspace/modify' \
-H 'Accept: application/json, text/plain, */*' \
-H 'Content-Type: application/json;charset=UTF-8' \
-H 'DF-API-KEY: <DF-API-KEY>' \
--data-raw '{"name":"ws_test","desc":"test"}' \
--compressed
--insecure
```



## Response
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
        "language": "en",
        "leftExpensiveQuery": true,
        "loggingCutSize": 10240,
        "makeResourceExceptionCode": "",
        "name": "Development and Testing Together 22",
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