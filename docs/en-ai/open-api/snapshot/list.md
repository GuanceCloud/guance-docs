# Get Snapshot List

---

<br />**GET /api/v1/snapshots/list**

## Overview
Retrieve the snapshot list for the current workspace



## Query Request Parameters

| Parameter Name        | Type     | Required   | Description              |
|:---------------------|:---------|:-----------|:-------------------------|
| type | string | No | Type filter<br>Can be empty: False <br> |
| search | string | No | Search snapshot name<br>Can be empty: False <br> |
| pageIndex | integer | No | Page number<br>Can be empty: False <br>Example: 1 <br>$minValue: 1 <br> |
| pageSize | integer | No | Number of items per page<br>Can be empty: False <br>Example: 10 <br>$minValue: 1 <br>$maxValue: 100 <br> |

## Additional Parameter Explanation


*Data Explanation*

**1. Snapshot Type Explanation**

| Key | Description |
|-----|-------------|
| logging | Log Explorer |
| keyevent | Event Explorer |
| tracing | Trace Explorer |
| object | Infrastructure Explorer |
| dialing_task | Dial Testing Explorer |
| security | Security Check Explorer |
| rum | RUM PV Explorer |
| measurement | Metrics Explorer |
| scene_dashboard | Scene View |
| dashboard | User-defined View |



## Request Example
```shell
curl 'https://openapi.<<< custom_key.brand_main_domain >>>/api/v1/snapshots/list?pageIndex=1&pageSize=2' \
-H 'DF-API-KEY: <DF-API-KEY>' \
--compressed 
```



## Response
```shell
{
    "code": 200,
    "content": [
        {
            "accountUUID": "acnt_xxxx32",
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
            "creator": "acnt_xxxx32",
            "deleteAt": -1,
            "id": 435,
            "name": "fa",
            "status": 0,
            "type": "logging",
            "updateAt": 1629714466,
            "updator": "acnt_xxxx32",
            "uuid": "snap_xxxx32",
            "workspaceUUID": "wksp_xxxx32"
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