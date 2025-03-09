# 获取一个仪表板

---

<br />**GET /api/v1/dashboards/\{dashboard_uuid\}/get**

## 概述
根据`dashboard_uuid`获取指定的仪表板信息




## 路由参数

| 参数名        | 类型     | 必选   | 说明              |
|:-----------|:-------|:-----|:----------------|
| dashboard_uuid | string | Y | 视图UUID<br> |


## 参数补充说明





## 请求例子
```shell
curl 'https://openapi.<<< custom_key.brand_main_domain >>>/api/v1/dashboards/dsbd_xxxx32/get' \
-H 'DF-API-KEY: <DF-API-KEY>' \
--compressed 
```




## 响应
```shell
{
    "code": 200,
    "content": {
        "chartGroupPos": [],
        "chartPos": [
            {
                "chartUUID": "chrt_xxxx32",
                "pos": {
                    "h": 11,
                    "i": "chrt_xxxx32",
                    "w": 11,
                    "x": 0,
                    "y": 0
                }
            }
        ],
        "createAt": 1642587228,
        "createdWay": "import",
        "creator": "acnt_xxxx32",
        "dashboardBindSet": [],
        "deleteAt": -1,
        "extend": {},
        "iconSet": {},
        "id": 2494,
        "mapping": [],
        "name": "testt",
        "ownerType": "node",
        "status": 0,
        "tag_info": {
            "dsbd_xxxx32": [
                {
                    "id": "tag_xxxx32",
                    "name": "openapi"
                },
                {
                    "id": "tag_xxxx32",
                    "name": "test"
                }
            ]
        },
        "type": "CUSTOM",
        "updateAt": 1642587908,
        "updator": "wsak_xxxxx",
        "uuid": "dsbd_xxxx32",
        "workspaceUUID": "wksp_xxxx32"
    },
    "errorCode": "",
    "message": "",
    "success": true,
    "traceId": "TRACE-B4C47390-FA67-4FD8-851C-342C3C97F957"
} 
```




