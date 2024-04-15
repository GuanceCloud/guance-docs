# 获取一个查看器

---

<br />**GET /api/v1/viewer/\{viewer_uuid\}/get**

## 概述
获取查看器详情




## 路由参数

| 参数名        | 类型     | 必选   | 说明              |
|:-----------|:-------|:-----|:----------------|
| viewer_uuid | string | Y | 查看器UUID<br> |


## 参数补充说明





## 请求例子
```shell
curl 'https://openapi.guance.com/api/v1/viewer/dsbd_e493a3c17d3c456bb1febfcbbe4148d2/get' \
-H 'DF-API-KEY: <DF-API-KEY>' \
--compressed 
```




## 响应
```shell
{
    "code": 200,
    "content": {
        "chartGroupPos": [],
        "chartPos": [],
        "createAt": 1677661673,
        "createdWay": "manual",
        "creator": "wsak_xxxxx",
        "dashboardBindSet": [],
        "deleteAt": -1,
        "extend": {
            "analysisField": "message",
            "charts": [
                null,
                null,
                null
            ],
            "filters": [],
            "index": "tracing",
            "quickFilter": {
                "columns": []
            },
            "rumAppId": "",
            "rumType": "",
            "selectedIndex": "default",
            "source": "",
            "table": {
                "columns": []
            }
        },
        "iconSet": {},
        "id": 712,
        "isPublic": 1,
        "mapping": [],
        "name": "modify_viewer",
        "ownerType": "viewer",
        "status": 0,
        "tag_info": {
            "dsbd_e493a3c17d3c456bb1febfcbbe4148d2": [
                {
                    "id": "tag_740834b7b7e94d1dbe1e764ee78039a3",
                    "name": "应用性能"
                }
            ]
        },
        "type": "CUSTOM",
        "updateAt": 1677662058,
        "updator": "wsak_xxxxx",
        "uuid": "dsbd_e493a3c17d3c456bb1febfcbbe4148d2",
        "workspaceUUID": "wksp_ed134a6485c8484dbd0e58ce9a9c6115"
    },
    "errorCode": "",
    "message": "",
    "success": true,
    "traceId": "TRACE-6AC65A44-636E-4E32-8F52-78F528958218"
} 
```




