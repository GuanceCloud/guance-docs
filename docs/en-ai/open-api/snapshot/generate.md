# Create a Snapshot

---

<br />**POST /api/v1/snapshots/create**

## Overview
Create a snapshot



## Body Request Parameters

| Parameter Name        | Type     | Required   | Description              |
|:------------------|:-------|:-----|:----------------|
| name | string | Y | Snapshot name<br>Allow null: False <br> |
| type | string | Y | Type of snapshot<br>Allow null: False <br> |
| content | json | Y | User configuration data<br>Allow null: False <br> |
| isForce | boolean |  | Force overwrite if the same name exists<br>Allow null: False <br> |

## Additional Parameter Descriptions


*1. Request parameter description*

| Parameter Name                | Type  | Required  | Description          |
|-----------------------|----------|----|------------------------|
|name             |string|Y| Snapshot name|
|type   |String     |Y| Type of snapshot, Log Explorer: Log|
|content   |dict     |Y| Snapshot content configuration |
|isForce |boolean     |N| Whether to force overwrite if the same name exists|

--------------

*2. content parameter description*

| Parameter Name                | Type  | Description          |
|-----------------------|----------|------------------------|
|routeParams.source             |string| Log Explorer: all|
|routeName   |string     | Route name, Log Explorer: Log|
|routeQuery.w   |string     | Query workspace |
|routeQuery.workspaceUUID   |string     | Multi-workspace query ID, not passing this parameter defaults to the current workspace |
|routeQuery.time   |string     | Query time, example1: "15m", example2: "1730697199573,1730698099573"|
|routeQuery.query   |string     | Explorer query statement|
|routeQuery.cols   |string     | Explorer display columns|
|routeQuery.viewType   |string     | Explorer display mode. List mode view, or analysis mode analyze|
|routeQuery.index   |string     | Log query index|
|routeQuery.snapshotName   |string     | Snapshot name|

Example of the content field:
```json
{
  "routeParams": {
    "source": "all"
  },
  "routeName": "Log",
  "routeQuery": {
    "w": "wksp_4b57c7bab38e4a2d9630f675dc20015d",
    "time": "1730697199573,1730698099573",
    "query": "host:izbp152ke14timzud0du15z",
    "workspaceUUID": "wksp_4b57c7bab38e4a2d9630f675dc20015d,wksp_ed134a6485c8484dbd0e58ce9a9c6115",
    "cols": "time,message,app_id",
    "viewType": "view",
    "index": "default,keyongxing,match_index",
    "snapshotName": "test2"
  }
}
```
--------------




## Request Example
```shell
curl 'https://openapi.guance.com/api/v1/snapshots/create' \
-H 'DF-API-KEY: <DF-API-KEY>' \
-H 'Content-Type: application/json;charset=UTF-8' \
--data-raw '{"name":"jj_test1","type":"Log","content":{"routeParams":{"source":"all"},"routeName":"Log","routeQuery":{"w":"wksp_4b57c7bab38e4a2d9630f675dc20015d","time":"45m","query":"host:izbp152ke14timzud0du15z","cols":"time,message,app_id","viewType":"view","index":"default,keyongxing","snapshotName":"jj_test1"}}}' \
--compressed
```




## Response
```shell
{
    "code": 200,
    "content": {
        "accountUUID": "wsak_45d8e5f33d544a41848802d1c4cb17c5",
        "content": {
            "routeName": "Log",
            "routeParams": {
                "source": "all"
            },
            "routeQuery": {
                "cols": "time,message,app_id",
                "index": "default,keyongxing",
                "query": "host:izbp152ke14timzud0du15z",
                "snapshotName": "jj_test11",
                "time": "45m",
                "viewType": "view",
                "w": "wksp_4b57c7bab38e4a2d9630f675dc20015d"
            }
        },
        "createAt": 1730715753,
        "creator": "wsak_45d8e5f33d544a41848802d1c4cb17c5",
        "declaration": {
            "asd": "aa,bb,cc,1,True",
            "asdasd": "dawdawd",
            "business": "aaa",
            "dd": "dd",
            "fawf": "afawf",
            "organization": "64fe7b4062f74d0007b46676"
        },
        "deleteAt": -1,
        "id": null,
        "isHidden": 0,
        "isPublic": 1,
        "name": "jj_test11",
        "rules": {
            "roles": [
                "wsAdmin"
            ],
            "rules": {
                "rum": [
                    {
                        "rule_info": {
                            "rule": "",
                            "sources": [
                                "wksp_4b57c7bab38e4a2d9630f675dc20015d:dcl_test_2",
                                "wksp_4b57c7bab38e4a2d9630f675dc20015d:322242342342",
                                "wksp_4b57c7bab38e4a2d9630f675dc20015d:23"
                            ]
                        },
                        "rule_uuid": "lqrl_fc28066143434d66b57a02f79334208d"
                    }
                ]
            },
            "sensitiveDataMaskRules": {
                "backup_log": {},
                "billing": {},
                "custom_object": {},
                "custom_object_history": {},
                "keyevent": {},
                "logging": {},
                "metric": {},
                "network": {},
                "object": {},
                "object_history": {},
                "profiling": {},
                "rum": {},
                "security": {},
                "tracing": {},
                "unrecovered_event": {}
            }
        },
        "status": 0,
        "type": "Log",
        "updateAt": null,
        "updator": null,
        "uuid": "snap_4831741647084ef2bcee5fa3c7e19342",
        "workspaceUUID": "wksp_4b57c7bab38e4a2d9630f675dc20015d"
    },
    "errorCode": "",
    "message": "",
    "success": true,
    "traceId": "TRACE-52822E10-1F3C-499D-B54B-2F5BFCCD5C45"
} 
```