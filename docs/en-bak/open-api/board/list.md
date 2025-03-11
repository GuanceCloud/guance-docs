# Get a List of Dashboards

---

<br />**get /api/v1/dashboards/list**

## Overview
Get a list of dashboards, arranged by default in descending order of update time.




## Query Request Parameter

| Parameter Name        | Type     | Required   | Description              |
|:-----------|:-------|:-----|:----------------|
| search | string |  | Search by name<br>Allow null: False <br> |
| tagNames | json |  | Tag name for filtering<br>Allow null: False <br>Example: [] <br> |
| pageIndex | integer |  | Page number<br>Allow null: False <br>Example: 10 <br>$minValue: 1 <br> |
| pageSize | integer |  | Quantity returned per page<br>Allow null: False <br>Example: 10 <br>$minValue: 1 <br>$maxValue: 100 <br> |

## Supplementary Description of Parameters





## Request Example
```shell
curl 'https://openapi.guance.com/api/v1/dashboards/list?pageIndex=1&pageSize=10' \
-H 'DF-API-KEY: <DF-API-KEY>' \
--compressed \
--insecure
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
                    "chartUUID": "chrt_1cbdbf10c1494c80b36b91b4e0e1ab90",
                    "pos": {
                        "h": 11,
                        "i": "chrt_2e650ef84b1a4eb389011fd95f7db11e",
                        "w": 11,
                        "x": 0,
                        "y": 0
                    }
                }
            ],
            "createAt": 1642587228,
            "createdWay": "import",
            "creator": "acnt_5fc5bb139e474911b6d3d300863f0c8b",
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
                        "id": "tag_07a3a85d01474c1585add18bfb1b5cde",
                        "name": "openapi"
                    },
                    {
                        "id": "tag_977d40b3f40c4d3f8e90956698b57c48",
                        "name": "test"
                    }
                ]
            },
            "type": "CUSTOM",
            "updateAt": 1642587228,
            "updator": "acnt_5fc5bb139e474911b6d3d300863f0c8b",
            "updatorInfo": {
                "iconUrl": "http://static.cloudcare.cn:10561/icon/acnt_5fc5bb139e474911b6d3d300863f0c8b.png",
                "name": "66",
                "username": "66@qq.com"
            },
            "uuid": "dsbd_541083cc19ec4d27ad597839a0477a97",
            "workspaceUUID": "wksp_c4201f4ef30c4a86b01a998e7544f822"
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




