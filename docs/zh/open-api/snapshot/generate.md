# 创建一个快照

---

<br />**POST /api/v1/snapshots/create**

## 概述
创建一个快照




## Body 请求参数

| 参数名        | 类型     | 必选   | 说明              |
|:-----------|:-------|:-----|:----------------|
| name | string | Y | 快照名称<br>允许为空: False <br> |
| type | string | Y | 快照的种类<br>允许为空: False <br> |
| content | json | Y | 用户配置数据<br>允许为空: False <br> |
| isForce | boolean |  | 同名时强制覆盖<br>允许为空: False <br> |

## 参数补充说明


*1. 请求参数说明*

|  参数名                |   type  | 必选  |          说明          |
|-----------------------|----------|----|------------------------|
|name             |string|Y| 快照名称|
|type   |String     |Y| 快照类型, 日志查看器: Log|
|content   |dict     |Y| 快照内容配置 |
|isForce |boolean     |N| 存在同名时候是否强制覆盖|

--------------

*2. content参数说明*

|  参数名                |   type  |          说明          |
|-----------------------|----------|------------------------|
|routeParams.source             |string| 日志查看器: all|
|routeName   |string     | 路由名称, 日志查看器: Log|
|routeQuery.w   |string     | 查询的空间 |
|routeQuery.workspaceUUID   |string     | 多空间查询的空间ID，不传该参数, 默认本空间 |
|routeQuery.time   |string     | 查询的时间, 示列1: "15m", 示列2: "1730697199573,1730698099573"|
|routeQuery.query   |string     | 查看器查询语句|
|routeQuery.cols   |string     | 查看器显示列|
|routeQuery.viewType   |string     | 查看器显示模式。列表模式view，或者分析模式 analyze|
|routeQuery.index   |string     | 日志查询的索引|
|routeQuery.snapshotName   |string     | 快照名称|

content 字段示列
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




## 请求例子
```shell
curl 'https://openapi.guance.com/api/v1/snapshots/create' \
-H 'DF-API-KEY: <DF-API-KEY>' \
-H 'Content-Type: application/json;charset=UTF-8' \
--data-raw '{"name":"jj_test1","type":"Log","content":{"routeParams":{"source":"all"},"routeName":"Log","routeQuery":{"w":"wksp_4b57c7bab38e4a2d9630f675dc20015d","time":"45m","query":"host:izbp152ke14timzud0du15z","cols":"time,message,app_id","viewType":"view","index":"default,keyongxing","snapshotName":"jj_test1"}}}' \
--compressed
```




## 响应
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




