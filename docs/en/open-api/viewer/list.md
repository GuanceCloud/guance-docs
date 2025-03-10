# Get Explorer List

---

<br />**GET /api/v1/viewer/list**

## Overview
List all Explorers that meet the specified conditions


## Query Request Parameters

| Parameter Name | Type   | Required | Description                                                                 |
|:--------------|:-------|:---------|:----------------------------------------------------------------------------|
| sortKey       | string | No       | Sorting field, default is to sort by `updateAt`. If the current value does not exist, it will be sorted by default.<br>Can be empty: False <br>Can be an empty string: True <br>Optional values: ['name', 'updateAt'] <br> |
| sortMethod    | string | No       | Sorting method, default is to sort by `desc`<br>Can be empty: False <br>Can be an empty string: True <br>Optional values: ['desc', 'asc'] <br> |
| search        | string | No       | Search by Explorer name<br>Can be empty: False <br> |
| pageIndex     | integer| No       | Page number<br>Can be empty: False <br>Example: 10 <br>$minValue: 1 <br> |
| pageSize      | integer| No       | Number of items returned per page<br>Can be empty: False <br>Example: 10 <br>$minValue: 1 <br>$maxValue: 100 <br> |
| filter        | string | No       | Filtering condition<br>Can be empty: False <br>Optional values: ['total', 'favorite', 'import', 'myCreate', 'oftenBrowse', 'ofenBrowse', 'selfVisibleOnly'] <br> |
| tagNames      | json   | No       | Tag names used for filtering<br>Can be empty: False <br>Example: [] <br> |

## Additional Parameter Notes



## Request Example
```shell
curl 'https://openapi.<<< custom_key.brand_main_domain >>>/api/v1/viewer/list' \
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
            "chartPos": [],
            "createAt": 1677659952,
            "createdWay": "import",
            "creator": "acnt_xxxx32",
            "creatorInfo": {
                "email": "88@qq.com",
                "iconUrl": "",
                "name": "88 test",
                "username": "test"
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
                        "name": "Create Chart",
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
                "name": "88 test",
                "username": "test"
            },
            "uuid": "dsbd_xxxx32",
            "workspaceUUID": "wksp_xxxx32"
        }
    ]
} 
```