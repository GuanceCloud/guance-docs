# Get Single User View

---

<br />**GET /api/v1/dashboard/\{dashboard_uuid\}/get**

## Overview



## Route Parameters

| Parameter Name        | Type     | Required | Description              |
|:-------------------|:-------|:-----|:----------------|
| dashboard_uuid | string | Y | View UUID<br> |


## Additional Parameter Notes

**Response Body Structure Description**

| Parameter Name                | Type  | Description          |
|-----------------------|----------|------------------------|
| chartGroupPos         | list | Chart group position information |
| chartPos         | list | Chart position information |
| createdWay             | string | Built-in view creation method, manually created: manual, created by import: import |
| dashboardBidding         | dict | Dashboard binding information |
| name         | string | Dashboard name |



## Request Example
```shell
curl 'https://openapi.<<< custom_key.brand_main_domain >>>/api/v1/dashboard/dsbd_xxxx32/get' \
-H 'DF-API-KEY: <DF-API-KEY>' \
--compressed
```



## Response
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
        "name": "Mysql Activity Monitoring View 111111",
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