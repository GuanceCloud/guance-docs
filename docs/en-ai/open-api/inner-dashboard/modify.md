# Modify a Single User View

---

<br />**POST /api/v1/dashboard/\{dashboard_uuid\}/modify**

## Overview
Modify a single user view


## Route Parameters

| Parameter Name        | Type     | Required | Description              |
|:-----------------|:-------|:-----|:----------------|
| dashboard_uuid | string | Y | View UUID<br> |


## Body Request Parameters

| Parameter Name        | Type     | Required | Description              |
|:-----------------|:-------|:-----|:----------------|
| name | string |  | View name<br>Example: Test View No.1 <br>Can be empty: False <br>Maximum length: 256 <br> |
| desc | string |  | Description<br>Example: Description 1 <br>Can be empty: False <br>Maximum length: 2048 <br> |
| identifier | string |  | Identifier ID -- Added on 2024.12.25<br>Example: xxxx <br>Can be empty: False <br>Can be an empty string: True <br>Maximum length: 128 <br> |
| dashboardBidding | json |  | Mapping, default is {}<br>Example: {} <br>Can be empty: False <br> |

## Additional Parameter Notes

**Request Body Structure Explanation**

| Parameter Name                | Type  | Description          |
|-----------------------|----------|------------------------|
|name         |string | View name |
|desc         |string | Description |
|identifier         |string | Identifier ID -- Added on 2024.12.25 |
|dashboardBidding         |dict | Dashboard binding information|

**Explanation of Built-in View Fields `dashboardBidding`**

Internal support for op values: in/wildcard

**Example of `dashboardBidding` Field:**
```
{
    "service": [
        {
            "value": [
                "*"
            ],
            "op": "in"
        }
    ],
    "app_id": [
        {
            "value": [
                "test0"
            ],
            "op": "wildcard"
        }
    ],
    "label": [
        {
            "value": [
                "Do Not Delete"
            ],
            "op": "in"
        }
    ]
}
```



## Request Example
```shell
curl 'https://openapi.guance.com/api/v1/dashboard/dsbd_xxxx32/modify' \
-H 'DF-API-KEY: <DF-API-KEY>' \
-H 'Accept: application/json, text/plain, */*' \
-H 'Accept-Language: en' \
-H 'Content-Type: application/json;charset=UTF-8' \
--data-raw '{"name":"Test Redis Monitoring View","dashboardBidding":{"app_id":[{"value":["cccc"],"op":"in"}]}}' \
--compressed
```



## Response
```json
{
    "code": 200,
    "content": {
        "chartGroupPos": [
            "chtg_xxxx32",
            "chtg_xxxx32",
            "chtg_xxxx32"
        ],
        "chartPos": [
            {
                "chartUUID": "chrt_xxxx32",
                "pos": {
                    "h": 8,
                    "i": "chrt_xxxx32",
                    "w": 8,
                    "x": 0,
                    "y": 2
                }
            },
            {
                "chartUUID": "chrt_xxxx32",
                "pos": {
                    "h": 8,
                    "i": "chrt_xxxx32",
                    "w": 6,
                    "x": 0,
                    "y": 12.5
                }
            },
            {
                "chartUUID": "chrt_xxxx32",
                "pos": {
                    "h": 8,
                    "i": "chrt_xxxx32",
                    "w": 8,
                    "x": 0,
                    "y": 23
                }
            },
            {
                "chartUUID": "chrt_xxxx32",
                "pos": {
                    "h": 8,
                    "i": "chrt_xxxx32",
                    "w": 6,
                    "x": 18,
                    "y": 12.5
                }
            },
            {
                "chartUUID": "chrt_xxxx32",
                "pos": {
                    "h": 8,
                    "i": "chrt_xxxx32",
                    "w": 8,
                    "x": 8,
                    "y": 2
                }
            },
            {
                "chartUUID": "chrt_xxxx32",
                "pos": {
                    "h": 8,
                    "i": "chrt_xxxx32",
                    "w": 8,
                    "x": 8,
                    "y": 23
                }
            },
            {
                "chartUUID": "chrt_xxxx32",
                "pos": {
                    "h": 8,
                    "i": "chrt_xxxx32",
                    "w": 8,
                    "x": 0,
                    "y": 31
                }
            },
            {
                "chartUUID": "chrt_xxxx32",
                "pos": {
                    "h": 8,
                    "i": "chrt_xxxx32",
                    "w": 8,
                    "x": 16,
                    "y": 23
                }
            },
            {
                "chartUUID": "chrt_xxxx32",
                "pos": {
                    "h": 8,
                    "i": "chrt_xxxx32",
                    "w": 6,
                    "x": 12,
                    "y": 12.5
                }
            },
            {
                "chartUUID": "chrt_xxxx32",
                "pos": {
                    "h": 8,
                    "i": "chrt_xxxx32",
                    "w": 8,
                    "x": 16,
                    "y": 31
                }
            },
            {
                "chartUUID": "chrt_xxxx32",
                "pos": {
                    "h": 8,
                    "i": "chrt_xxxx32",
                    "w": 6,
                    "x": 6,
                    "y": 12.5
                }
            },
            {
                "chartUUID": "chrt_xxxx32",
                "pos": {
                    "h": 8,
                    "i": "chrt_xxxx32",
                    "w": 8,
                    "x": 16,
                    "y": 2
                }
            },
            {
                "chartUUID": "chrt_xxxx32",
                "pos": {
                    "h": 8,
                    "i": "chrt_xxxx32",
                    "w": 8,
                    "x": 8,
                    "y": 31
                }
            }
        ],
        "createAt": 1698732345,
        "createdWay": "manual",
        "creator": "wsak_xxxxx",
        "dashboardBidding": {
            "app_id": [
                {
                    "op": "in",
                    "value": [
                        "cccc"
                    ]
                }
            ]
        },
        "dashboardBindSet": [],
        "deleteAt": -1,
        "extend": {},
        "iconSet": {
            "icon": "http://testing-static-res.dataflux.cn/dataflux-template/dashboard/en/aliyun_redis/icon.svg",
            "url": "http://testing-static-res.dataflux.cn/dataflux-template/dashboard/en/aliyun_redis/aliyun_redis.png"
        },
        "id": 4615,
        "isPublic": 1,
        "mapping": [],
        "name": "Test Redis Monitoring View",
        "old_name": "Test Redis Monitoring View",
        "ownerType": "inner",
        "status": 0,
        "tag_info": {
            "tagInfo": []
        },
        "type": "CUSTOM",
        "updateAt": 1698732854,
        "updator": "wsak_xxxxx",
        "updatorInfo": {
            "acntWsNickname": "",
            "email": "wsak_xxxxx",
            "iconUrl": "",
            "name": "a",
            "username": "xxx"
        },
        "uuid": "dsbd_xxxx32",
        "workspaceUUID": "wksp_xxxx32"
    },
    "errorCode": "",
    "message": "",
    "success": true,
    "traceId": "TRACE-CEA33BA0-68C7-499B-83D7-F59015192DBB"
} 
```