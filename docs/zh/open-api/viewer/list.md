# 获取查看器列表

---

<br />**GET /api/v1/viewer/list**

## 概述
列出所有符合条件的查看器




## Query 请求参数

| 参数名        | 类型     | 必选   | 说明              |
|:-----------|:-------|:-----|:----------------|
| sortKey | string |  | 排序字段, 默认按照 updateAt 排序， 如果不存在当前值时，按照默认排序<br>允许为空: False <br>允许为空字符串: True <br>可选值: ['name', 'updateAt'] <br> |
| sortMethod | string |  | 排序方法, 默认按照 desc 排序<br>允许为空: False <br>允许为空字符串: True <br>可选值: ['desc', 'asc'] <br> |
| search | string |  | 查看器名称搜索<br>允许为空: False <br> |
| pageIndex | integer |  | 页码<br>允许为空: False <br>例子: 10 <br>$minValue: 1 <br> |
| pageSize | integer |  | 每页返回数量<br>允许为空: False <br>例子: 10 <br>$minValue: 1 <br>$maxValue: 100 <br> |
| filter | string |  | 过滤条件<br>允许为空: False <br>可选值: ['total', 'favorite', 'import', 'myCreate', 'oftenBrowse', 'ofenBrowse', 'selfVisibleOnly'] <br> |
| tagNames | json |  | 用于筛选的标签name<br>允许为空: False <br>例子: [] <br> |

## 参数补充说明





## 请求例子
```shell
curl 'https://openapi.guance.com/api/v1/viewer/list' \
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
            "chartPos": [],
            "createAt": 1677659952,
            "createdWay": "import",
            "creator": "acnt_xxxx32",
            "creatorInfo": {
                "email": "88@qq.com",
                "iconUrl": "",
                "name": "88测试",
                "username": "测试"
            },
            "dashboardBindSet": [],
            "deleteAt": -1,
            "extend": {
                "analysisField": "message",
                "charts": [
                    null,
                    {
                        "extend": {
                            "fixedTime": "",
                            "settings": {
                                "alias": [],
                                "chartType": "line",
                                "colors": [],
                                "compareColors": {
                                    "dayCompare": "rgba(11,11,12,0.5)",
                                    "hourCompare": "#0B0B0C",
                                    "monthCompare": "rgba(11,11,12,0.12)",
                                    "weekCompare": "rgba(11,11,12,0.3)"
                                },
                                "compareColorsDark": {
                                    "dayCompare": "rgba(213,217,226,0.5)",
                                    "hourCompare": "#D5D9E2",
                                    "monthCompare": "rgba(213,217,226,0.12)",
                                    "weekCompare": "rgba(213,217,226,0.25)"
                                },
                                "compareColorsLight": {
                                    "dayCompare": "rgba(11,11,12,0.5)",
                                    "hourCompare": "#0B0B0C",
                                    "monthCompare": "rgba(11,11,12,0.12)",
                                    "weekCompare": "rgba(11,11,12,0.3)"
                                },
                                "compareType": [],
                                "density": "medium",
                                "fixedTime": "",
                                "isPercent": false,
                                "isTimeInterval": true,
                                "legendPostion": "none",
                                "legendValues": "",
                                "levels": [],
                                "onlyShowGroupName": false,
                                "openCompare": false,
                                "openStack": false,
                                "showFieldMapping": false,
                                "showLine": false,
                                "showTitle": true,
                                "stackType": "time",
                                "timeInterval": "auto",
                                "titleDesc": "",
                                "units": [],
                                "xAxisShowType": "time",
                                "yAxixMaxVal": null,
                                "yAxixMinVal": null
                            }
                        },
                        "isQuery": true,
                        "name": "新建图表",
                        "queries": [
                            {
                                "color": "",
                                "datasource": "dataflux",
                                "name": "",
                                "qtype": "dql",
                                "query": {
                                    "alias": "",
                                    "code": "A",
                                    "dataSource": "",
                                    "field": "",
                                    "fieldFunc": "",
                                    "fill": null,
                                    "filters": [],
                                    "funcList": [],
                                    "groupBy": [],
                                    "groupByTime": "",
                                    "indexFilter": "",
                                    "namespace": "tracing",
                                    "q": "",
                                    "queryFuncs": [],
                                    "type": "simple"
                                },
                                "type": "sequence",
                                "unit": ""
                            }
                        ],
                        "type": "sequence"
                    },
                    null
                ],
                "filters": [],
                "index": "tracing",
                "quickFilter": {
                    "columns": []
                },
                "rumAppId": "",
                "rumType": "",
                "selectedIndex": "default",
                "source": "",
                "table": {
                    "columns": []
                }
            },
            "iconSet": {},
            "id": 711,
            "isFavorite": false,
            "isPublic": 1,
            "mapping": [],
            "name": "11",
            "ownerType": "viewer",
            "status": 0,
            "tag_info": {
                "tagInfo": []
            },
            "type": "CUSTOM",
            "updateAt": 1677662452,
            "updator": "acnt_xxxx32",
            "updatorInfo": {
                "email": "88@qq.com",
                "iconUrl": "",
                "name": "88测试",
                "username": "测试"
            },
            "uuid": "dsbd_xxxx32",
            "workspaceUUID": "wksp_xxxx32"
        }
    ]
} 
```




