# Get Snapshot List

---

<br />**get /api/v1/snapshots/list**

## Overview
Get a snapshot list of the current workspace.




## Query Request Parameter

| Parameter Name        | Type     | Required   | Description              |
|:-----------|:-------|:-----|:----------------|
| type | string |  | Type filter<br>Allow null: False <br> |
| search | string |  | Search for snapshot name<br>Allow null: False <br> |
| pageIndex | integer |  | Page number<br>Allow null: False <br>Example: 1 <br>$minValue: 1 <br> |
| pageSize | integer |  | Quantity returned per page<br>Allow null: False <br>Example: 10 <br>$minValue: 1 <br>$maxValue: 100 <br> |

## Supplementary Description of Parameters


*Data description*

**1. Type Description of Snapshot**

|key|Description|
|---|----|
|logging|Log explorer|
|keyevent|Event explorer|
|tracing|Link explorer|
|object|Infrastructure explorer|
|dialing_task|Cloud testing explorer|
|security|Scheck explorer|
|rum|APM explorer|
|measurement|Metrics explorer|
|scene_dashboard|Scene view|
|dashboard|User-defined view|




## Request Example
```shell
curl 'https://openapi.guance.com/api/v1/snapshots/list?pageIndex=1&pageSize=2' \
-H 'DF-API-KEY: <DF-API-KEY>' \
--compressed \
--insecure
```




## Response
```shell
{
    "code": 200,
    "content": [
        {
            "accountUUID": "acnt_d69cb12e694211eb8464ea24b4040175",
            "content": {
                "routeName": "Log",
                "routeParams": {
                    "source": "others"
                },
                "routeQuery": {
                    "tags": "{\\\"source\\\":[\\\"python_ddtrace_log_ee\\\"]}",
                    "time": "1629713566000,1629714466999"
                }
            },
            "createAt": 1629714466,
            "creator": "acnt_d69cb12e694211eb8464ea24b4040175",
            "deleteAt": -1,
            "id": 435,
            "name": "fa",
            "status": 0,
            "type": "logging",
            "updateAt": 1629714466,
            "updator": "acnt_d69cb12e694211eb8464ea24b4040175",
            "uuid": "snap_783467fbefc240ed8a33cfb964a78065",
            "workspaceUUID": "wksp_2dc431d6693711eb8ff97aeee04b54af"
        }
    ],
    "errorCode": "",
    "message": "",
    "pageInfo": {
        "count": 1,
        "pageIndex": 1,
        "pageSize": 3,
        "totalCount": 1
    },
    "success": true,
    "traceId": "TRACE-EF64E702-8660-4D45-94B9-F058FCB00E17"
} 
```




