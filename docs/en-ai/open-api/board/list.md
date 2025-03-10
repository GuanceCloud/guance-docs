# Get Dashboard List

---

<br />**GET /api/v1/dashboards/list**

## Overview
Retrieve the list of dashboards, sorted by update time in descending order by default


## Query Request Parameters

| Parameter Name | Type   | Required | Description                          |
|:--------------|:-------|:---------|:-------------------------------------|
| search        | string |          | Search by name<br>Allow empty: False <br> |
| tagNames      | json   |          | Tag names for filtering<br>Allow empty: False <br>Example: [] <br> |
| pageIndex     | integer|          | Page number<br>Allow empty: False <br>Example: 10 <br>$minValue: 1 <br> |
| pageSize      | integer|          | Number of items per page<br>Allow empty: False <br>Example: 10 <br>$minValue: 1 <br>$maxValue: 100 <br> |

## Additional Parameter Notes



## Request Example
```shell
curl 'https://openapi.<<< custom_key.brand_main_domain >>>/api/v1/dashboards/list?pageIndex=1&pageSize=10' \
-H 'DF-API-KEY: <DF-API-KEY>' \
--compressed 
```



## Response
```shell
{
    "code": 200,
    "content": [
        {
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
            "isFavorite": false,
            "mapping": [],
            "name": "openapi",
            "ownerType": "node",
            "status": 0,
            "tag_info": {
                "sceneInfo": [],
                "tagInfo": [
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
            "updateAt": 1642587228,
            "updator": "acnt_xxxx32",
            "updatorInfo": {
                "iconUrl": "http://static.cloudcare.cn:10561/icon/acnt_xxxx32.png",
                "name": "66",
                "username": "66@qq.com"
            },
            "uuid": "dsbd_xxxx32",
            "workspaceUUID": "wksp_xxxx32"
        }
    ],
    "errorCode": "",
    "message": "",
    "pageInfo": {
        "count": 1,
        "pageIndex": 1,
        "pageSize": 50,
        "totalCount": 1
    },
    "success": true,
    "traceId": "TRACE-26483481-16C2-4B24-ACAF-E743AADE2663"
} 
```