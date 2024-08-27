# 导出一个查看器

---

<br />**GET /api/v1/viewer/\{viewer_uuid\}/export**

## 概述
将`viewer_uuid`指定的查看器导出为模板结构




## 路由参数

| 参数名        | 类型     | 必选   | 说明              |
|:-----------|:-------|:-----|:----------------|
| viewer_uuid | string | Y | 查看器UUID<br> |


## 参数补充说明





## 请求例子
```shell
curl 'https://openapi.guance.com/api/v1/viewer/dsbd_xxxx32/export' \
-H 'DF-API-KEY: <DF-API-KEY>' \
--compressed 
```




## 响应
```shell
{
    "code": 200,
    "content": {
        "dashboardBindSet": [],
        "dashboardExtend": {
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
        "dashboardMapping": [],
        "dashboardOwnerType": "viewer",
        "dashboardType": "CUSTOM",
        "iconSet": {},
        "main": {
            "charts": [],
            "groups": [],
            "type": "template",
            "vars": []
        },
        "summary": "",
        "tagInfo": [
            {
                "id": "tag_xxxx32",
                "name": "应用性能"
            }
        ],
        "tags": [],
        "thumbnail": "",
        "title": "modify_viewer"
    },
    "errorCode": "",
    "message": "",
    "success": true,
    "traceId": "TRACE-4457FED3-911C-4AA8-A7C7-9AE6B0463DC8"
} 
```




