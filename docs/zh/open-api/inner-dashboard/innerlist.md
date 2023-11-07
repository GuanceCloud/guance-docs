# 获取用户视图列表

---

<br />**GET /api/v1/dashboard/inner_list**

## 概述




## Query 请求参数

| 参数名        | 类型     | 必选   | 说明              |
|:-----------|:-------|:-----|:----------------|
| search | string |  | 视图名称搜索<br>允许为空: False <br> |

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
curl 'https://openapi.guance.com/api/v1/dashboard/inner_list' \
-H 'DF-API-KEY: <DF-API-KEY>' \
--compressed
```




## 响应
```shell
{
    "code": 200,
    "content": {
        "data": [
            {
                "chartGroupPos": [],
                "chartPos": [],
                "createAt": 1698723059,
                "createdWay": "manual",
                "creator": "acnt_349ee5f70a89442fa94b4f754b5acbfe",
                "dashboardBindSet": [],
                "deleteAt": -1,
                "extend": {},
                "iconSet": {},
                "id": 4602,
                "innerTemplate": null,
                "isPublic": 1,
                "mapping": [],
                "name": "test2",
                "ownerType": "inner",
                "status": 0,
                "type": "CUSTOM",
                "updateAt": 1698723059,
                "updator": "acnt_349ee5f70a89442fa94b4f754b5acbfe",
                "uuid": "dsbd_39787c304c0b4b7b84045a7884166a3b",
                "workspaceUUID": "wksp_4b57c7bab38e4a2d9630f675dc20015d"
            },
            {
                "chartGroupPos": [],
                "chartPos": [
                    {
                        "chartUUID": "chrt_95b106d7e61a4a8489c408feb076a154",
                        "pos": {
                            "h": 8,
                            "w": 6,
                            "x": 0,
                            "y": 0
                        }
                    },
                    {
                        "chartUUID": "chrt_ebb3ce372aa04fab908d011698f2b397",
                        "pos": {
                            "h": 17,
                            "w": 12,
                            "x": 12,
                            "y": 16
                        }
                    },
                    {
                        "chartUUID": "chrt_ba9c2e72e3a84be2818c71917a4e22d4",
                        "pos": {
                            "h": 17,
                            "w": 12,
                            "x": 0,
                            "y": 16
                        }
                    },
                    {
                        "chartUUID": "chrt_f728133ec7634dc6ab52139184b1ce30",
                        "pos": {
                            "h": 16,
                            "w": 6,
                            "x": 6,
                            "y": 0
                        }
                    },
                    {
                        "chartUUID": "chrt_9de35a098ed74cc29dcb65399c3e9739",
                        "pos": {
                            "h": 16,
                            "w": 6,
                            "x": 12,
                            "y": 0
                        }
                    },
                    {
                        "chartUUID": "chrt_4fac6f35524e46628722c3e8d3d0b7dd",
                        "pos": {
                            "h": 29,
                            "w": 24,
                            "x": 0,
                            "y": 33
                        }
                    },
                    {
                        "chartUUID": "chrt_95466fd5417241e3826c5f1ed02b2fef",
                        "pos": {
                            "h": 16,
                            "w": 6,
                            "x": 18,
                            "y": 0
                        }
                    },
                    {
                        "chartUUID": "chrt_e702747430eb4fd8ab560de4cb078b86",
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
                "creator": "acnt_349ee5f70a89442fa94b4f754b5acbfe",
                "dashboardBindSet": [],
                "deleteAt": -1,
                "extend": {},
                "iconSet": {
                    "icon": "http://testing-static-res.dataflux.cn/dataflux-template/dashboard/zh/mysql_activity/icon.svg",
                    "url": "http://testing-static-res.dataflux.cn/dataflux-template/dashboard/zh/mysql_activity/mysql_activity.png"
                },
                "id": 4490,
                "innerTemplate": null,
                "isPublic": 1,
                "mapping": [],
                "name": "Mysql Activity 监控视图111111",
                "ownerType": "inner",
                "status": 0,
                "type": "CUSTOM",
                "updateAt": 1697626939,
                "updator": "acnt_349ee5f70a89442fa94b4f754b5acbfe",
                "uuid": "dsbd_2b394e38e6b84bf0ac6d124a29734f4d",
                "workspaceUUID": "wksp_4b57c7bab38e4a2d9630f675dc20015d"
            }
        ]
    },
    "errorCode": "",
    "message": "",
    "success": true,
    "traceId": "TRACE-90E8A4C6-D20C-4597-AC65-748991DC45F5"
} 
```




