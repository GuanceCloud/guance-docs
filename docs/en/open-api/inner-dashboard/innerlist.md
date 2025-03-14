# Get User View List

---

<br />**GET /api/v1/dashboard/inner_list**

## Overview




## Query Request Parameters

| Parameter Name        | Type     | Required | Description              |
|:------------------|:-------|:-----|:----------------|
| search | string | No | Search by view name<br>Can be empty: False <br> |

## Additional Parameter Explanation

**Response Body Structure Explanation**

| Parameter Name                | Type   | Description          |
|-----------------------|----------|------------------------|
| chartGroupPos         | list | Chart group position information |
| chartPos         | list | Chart position information |
| createdWay             | string | The creation method of this built-in view, manually created: manual, imported created: import |
| dashboardBindSet         | dict | Dashboard binding information |
| name         | string | Dashboard name |




## Request Example
```shell
curl 'https://openapi.<<< custom_key.brand_main_domain >>>/api/v1/dashboard/inner_list' \
-H 'DF-API-KEY: <DF-API-KEY>' \
--compressed
```




## Response
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
                "creator": "acnt_xxxx32",
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
                "updator": "acnt_xxxx32",
                "uuid": "dsbd_xxxx32",
                "workspaceUUID": "wksp_xxxx32"
            },
            {
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
                "name": "Mysql Activity Monitoring View 111111",
                "ownerType": "inner",
                "status": 0,
                "type": "CUSTOM",
                "updateAt": 1697626939,
                "updator": "acnt_xxxx32",
                "uuid": "dsbd_xxxx32",
                "workspaceUUID": "wksp_xxxx32"
            }
        ]
    },
    "errorCode": "",
    "message": "",
    "success": true,
    "traceId": "TRACE-90E8A4C6-D20C-4597-AC65-748991DC45F5"
} 
```