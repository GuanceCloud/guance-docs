# 【服务清单】列出

---

<br />**GET /api/v1/service_manage/list**

## 概述
列出服务清单信息




## Query 请求参数

| 参数名        | 类型     | 必选   | 说明              |
|:-----------|:-------|:-----|:----------------|
| search | string |  | 搜索服务名<br>例子: mysql <br>允许为空: False <br> |
| originStr | string |  | 原始字符串传1, 结构化数据传0, 默认为1<br>允许为空: False <br> |
| filter | string |  | 过滤条件<br>例子: total <br>允许为空: False <br>可选值: ['total', 'favorite', 'myCreate', 'oftenBrowse'] <br> |
| createType | commaArray |  | 创建类型<br>例子: openapi,manual,automatic <br>允许为空: False <br> |
| serviceType | commaArray |  | 服务类型<br>例子: web,custom <br>允许为空: False <br> |
| teamUUID | commaArray |  | 团队UUID<br>例子: group_x,group_y <br>允许为空: False <br> |
| pageIndex | integer |  | 页码<br>允许为空: False <br>例子: 1 <br>$minValue: 1 <br> |
| pageSize | integer |  | 每页返回数量<br>允许为空: False <br>例子: 10 <br>$minValue: 1 <br>$maxValue: 100 <br> |

## 参数补充说明


**请求主体结构说明**

|  参数名        |   type  | 必选  |          说明          |
|---------------|----------|----|------------------------|
| search    |  string  |  N | 搜索服务名 |
| originStr |  string  |  N | 是否需要返回的 serviceCatelog 为原始字符串, 1为是, 0为否. 默认为1|
| filter    |  string  |  N | 过滤条件 |
| createType|  string  |  N | 过滤服务创建类型,以','间隔, manual,openapi,automatic|
| serviceType|  string  |  N | 过滤服务的类型,以','间隔, app,framework,cache,message_queue,custom,db,web |
| teamUUID    |  string  |  N | 过滤团队,以','间隔 |
| pageIndex |  string  |  N | 分页页码 |
| pageSize  |  string  |  N | 每页返回数量 |


**响应主体结构说明**

|  参数名                |   type  |          说明          |
|-----------------------|----------|------------------------|
|serviceCatelog         |string,dict |  服务清单的原始字符串或者结构化数据 |
|service         |string |  服务名称 |
|type         |string |  服务类型 |
|dfStatus         |string |  服务状态 |
|creatorInfo             |dict |  服务清单的创建者信息 |
|updatorInfo             |dict |  服务清单的更新者信息 |




## 请求例子
```shell
curl 'https://openapi.guance.com/api/v1/service_manage/list?originStr=0' \
  -H 'Content-Type: application/json' \
  -H 'DF-API-KEY: <DF-API-KEY>' \
  --compressed
```




## 响应
```shell
{
    "automaticFoundTime": "1693807201",
    "data": [
        {
            "uuid": "sman_eb3e3c7acaef4d53acab866b83410edb",
            "createAt": 1693798688,
            "updateAt": 1693805504,
            "creatorInfo": {
                "username": "wsak_470962cc97584f6a8b09d6c43db10752",
                "name": "阿里云监控数据源",
                "iconUrl": "",
                "email": "wsak_470962cc97584f6a8b09d6c43db10752",
                "acntWsNickname": ""
            },
            "colour": "#40C922",
            "updatorInfo": {
                "username": "wsak_470962cc97584f6a8b09d6c43db10752",
                "name": "阿里云监控数据源",
                "iconUrl": "",
                "email": "wsak_470962cc97584f6a8b09d6c43db10752",
                "acntWsNickname": ""
            },
            "dfStatus": "ok",
            "isFavorite": false,
            "createType": "openapi",
            "service": "test_02",
            "type": "db",
            "serviceCatelog": {
                "Team": {
                    "service": "test_02",
                    "type": "db",
                    "team": "group_a8caea614b2644549557b476cf2d946c",
                    "colour": "#40C922",
                    "oncall": [
                        {
                            "name": "guanceyun",
                            "type": "email",
                            "emails": [
                                "test1@guance.com",
                                "test3@guance.com"
                            ]
                        },
                        {
                            "name": "zhuyun",
                            "type": "mobile",
                            "mobiles": [
                                "17621725786",
                                "17621724231"
                            ]
                        },
                        {
                            "name": "test",
                            "type": "slack",
                            "slack": "#test"
                        }
                    ]
                },
                "Repos": [
                    {
                        "link": "https://www.guance.com",
                        "name": "guance",
                        "provider": "guanceyun"
                    },
                    {
                        "link": "https://func.guance.com",
                        "name": "func",
                        "provider": "guanceyun"
                    }
                ],
                "Docs": [
                    {
                        "link": "https://www.docs.guance.com",
                        "name": "guance",
                        "provider": "guanceyun"
                    },
                    {
                        "link": "https://func.guance.com/doc",
                        "name": "func",
                        "provider": "guanceyun"
                    }
                ],
                "Related": {
                    "AppId": "a138bcb0_47ef_11ee_9d75_31ea50b9d85a",
                    "Tags": [
                        "test"
                    ],
                    "DashboardUUIDs": [
                        "dsbd_b7ded4391b5e497ba7112d81a922d14d"
                    ]
                }
            }
        },
        {
            "uuid": "sman_cb24ea0f1c694db08bfa6ee8afb05914",
            "createAt": 1693728357,
            "updateAt": 1693728357,
            "creatorInfo": {
                "username": "test@jiagouyun.com",
                "name": "test",
                "iconUrl": "",
                "email": "test@jiagouyun.com",
                "acntWsNickname": ""
            },
            "colour": "",
            "updatorInfo": {
                "username": "test@jiagouyun.com",
                "name": "test",
                "iconUrl": "",
                "email": "test@jiagouyun.com",
                "acntWsNickname": ""
            },
            "dfStatus": "ok",
            "isFavorite": false,
            "createType": "manual",
            "service": "test-lml3",
            "type": "custom",
            "serviceCatelog": {
                "Team": {
                    "service": "test-lml3",
                    "type": "custom",
                    "colour": "",
                    "team": "",
                    "oncall": []
                },
                "Related": {
                    "Tags": []
                }
            }
        }
    ],
    "pageInfo": {
        "pageIndex": 1,
        "pageSize": 50,
        "count": 2,
        "totalCount": 2
    }
} 
```



