# 获取单个用户视图

---

<br />**GET /api/v1/dashboard/\{dashboard_uuid\}/get**

## 概述




## 路由参数

| 参数名        | 类型     | 必选   | 说明              |
|:-----------|:-------|:-----|:----------------|
| dashboard_uuid | string | Y | 视图UUID<br> |


## 参数补充说明

**响应主体结构说明**

|  参数名                |   type  |          说明          |
|-----------------------|----------|------------------------|
|chartGroupPos         |list |  图表组的位置信息 |
|chartPos         |list |  图表位置信息 |
|createdWay             |string |  该内置视图创建方式, 手动创建:manual,导入创建:import |
|dashboardBidding         |dict |   仪表板绑定的信息|
|name         |string |  仪表板名称 |




## 请求例子
```shell
curl 'https://openapi.<<< custom_key.brand_main_domain >>>/api/v1/dashboard/dsbd_xxxx32/get' \
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
                    "h": 8,
                    "w": 6,
                    "x": 0,
                    "y": 0
                }
            },
            {
                "chartUUID": "chrt_xxxx32",
                "pos": {
                    "h": 17,
                    "w": 12,
                    "x": 12,
                    "y": 16
                }
            },
            {
                "chartUUID": "chrt_xxxx32",
                "pos": {
                    "h": 17,
                    "w": 12,
                    "x": 0,
                    "y": 16
                }
            },
            {
                "chartUUID": "chrt_xxxx32",
                "pos": {
                    "h": 16,
                    "w": 6,
                    "x": 6,
                    "y": 0
                }
            },
            {
                "chartUUID": "chrt_xxxx32",
                "pos": {
                    "h": 16,
                    "w": 6,
                    "x": 12,
                    "y": 0
                }
            },
            {
                "chartUUID": "chrt_xxxx32",
                "pos": {
                    "h": 29,
                    "w": 24,
                    "x": 0,
                    "y": 33
                }
            },
            {
                "chartUUID": "chrt_xxxx32",
                "pos": {
                    "h": 16,
                    "w": 6,
                    "x": 18,
                    "y": 0
                }
            },
            {
                "chartUUID": "chrt_xxxx32",
                "pos": {
                    "h": 8,
                    "w": 6,
                    "x": 0,
                    "y": 8
                }
            }
        ],
        "createAt": 1695633499,
        "createdWay": "manual",
        "creator": "acnt_xxxx32",
        "dashboardBidding": {
            "container_name": [
                {
                    "op": "in",
                    "value": [
                        "worker-0"
                    ]
                }
            ],
            "host": [
                {
                    "op": "in",
                    "value": [
                        "izbp152ke14timzud0du15z"
                    ]
                }
            ]
        },
        "dashboardBindSet": [],
        "deleteAt": -1,
        "extend": {},
        "iconSet": {
            "icon": "http://testing-static-res.dataflux.cn/dataflux-template/dashboard/zh/mysql_activity/icon.svg",
            "url": "http://testing-static-res.dataflux.cn/dataflux-template/dashboard/zh/mysql_activity/mysql_activity.png"
        },
        "id": 4490,
        "isPublic": 1,
        "mapping": [],
        "name": "Mysql Activity 监控视图111111",
        "ownerType": "inner",
        "status": 0,
        "tag_info": {},
        "type": "CUSTOM",
        "updateAt": 1697626939,
        "updator": "acnt_xxxx32",
        "uuid": "dsbd_xxxx32",
        "workspaceUUID": "wksp_xxxx32"
    },
    "errorCode": "",
    "message": "",
    "success": true,
    "traceId": "TRACE-45F426E9-FB47-46E9-A231-534835ECEDCB"
} 
```




