# 获取仪表板列表

---

<br />**GET /api/v1/dashboards/list**

## 概述
获取仪表板列表，默认按照更新时间降序排列




## Query 请求参数

| 参数名        | 类型     | 必选   | 说明              |
|:-----------|:-------|:-----|:----------------|
| search | string |  | 根据名称搜索<br>允许为空: False <br> |
| tagNames | json |  | 用于筛选的标签name<br>允许为空: False <br>例子: [] <br> |
| pageIndex | integer |  | 页码<br>允许为空: False <br>例子: 10 <br>$minValue: 1 <br> |
| pageSize | integer |  | 每页返回数量<br>允许为空: False <br>例子: 10 <br>$minValue: 1 <br>$maxValue: 100 <br> |

## 参数补充说明





## 请求例子
```shell
curl 'https://openapi.guance.com/api/v1/dashboards/list?pageIndex=1&pageSize=10' \
-H 'DF-API-KEY: <DF-API-KEY>' \
--compressed 
```




## 响应
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




