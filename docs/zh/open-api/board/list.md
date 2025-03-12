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
curl 'https://openapi.<<< custom_key.brand_main_domain >>>/api/v1/dashboards/list?pageIndex=1&pageSize=10' \
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




