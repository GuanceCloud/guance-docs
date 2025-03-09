# 导入一个查看器

---

<br />**POST /api/v1/viewer/\{viewer_uuid\}/import**

## 概述
导入一个查看器




## 路由参数

| 参数名        | 类型     | 必选   | 说明              |
|:-----------|:-------|:-----|:----------------|
| viewer_uuid | string | Y | 查看器UUID<br> |


## Body 请求参数

| 参数名        | 类型     | 必选   | 说明              |
|:-----------|:-------|:-----|:----------------|
| ownerType | string |  | 视图分类类型, 默认为 viewer<br>例子: viewer <br>允许为空: False <br> |
| sourceDashboardUUID | string |  | 源视图UUID<br>例子: dash-xxxxx <br>允许为空: False <br> |
| templateInfo | json |  | 视图模板<br>例子: {} <br>允许为空: False <br> |

## 参数补充说明





## 请求例子
```shell
curl 'https://openapi.<<< custom_key.brand_main_domain >>>/api/v1/viewer/dsbd_xxxx32/import' \
-H 'DF-API-KEY: <DF-API-KEY>' \
-H 'Content-Type: application/json;charset=UTF-8' \
--data-raw '{"templateInfo":{"dashboardBindSet":[],"dashboardExtend":{"analysisField":"message","charts":[null,{"extend":{"fixedTime":"","settings":{"alias":[],"chartType":"line","colors":[],"compareColors":{"dayCompare":"rgba(11,11,12,0.5)","hourCompare":"#0B0B0C","monthCompare":"rgba(11,11,12,0.12)","weekCompare":"rgba(11,11,12,0.3)"},"compareColorsDark":{"dayCompare":"rgba(213,217,226,0.5)","hourCompare":"#D5D9E2","monthCompare":"rgba(213,217,226,0.12)","weekCompare":"rgba(213,217,226,0.25)"},"compareColorsLight":{"dayCompare":"rgba(11,11,12,0.5)","hourCompare":"#0B0B0C","monthCompare":"rgba(11,11,12,0.12)","weekCompare":"rgba(11,11,12,0.3)"},"compareType":[],"density":"medium","fixedTime":"","isPercent":false,"isTimeInterval":true,"legendPostion":"none","legendValues":"","levels":[],"onlyShowGroupName":false,"openCompare":false,"openStack":false,"showFieldMapping":false,"showLine":false,"showTitle":true,"stackType":"time","timeInterval":"auto","titleDesc":"","units":[],"xAxisShowType":"time","yAxixMaxVal":null,"yAxixMinVal":null}},"isQuery":true,"name":"新建图表","queries":[{"color":"","datasource":"dataflux","name":"","qtype":"dql","query":{"alias":"","code":"A","dataSource":"","field":"","fieldFunc":"","fill":null,"filters":[],"funcList":[],"groupBy":[],"groupByTime":"","indexFilter":"","namespace":"tracing","q":"","queryFuncs":[],"type":"simple"},"type":"sequence","unit":""}],"type":"sequence"},null],"filters":[],"index":"tracing","quickFilter":{"columns":[]},"rumAppId":"","rumType":"","selectedIndex":"default","source":"","table":{"columns":[]}},"dashboardMapping":[],"dashboardOwnerType":"viewer","dashboardType":"CUSTOM","iconSet":{},"main":{"charts":[],"groups":[],"type":"template","vars":[]},"summary":"","tagInfo":[],"tags":[],"thumbnail":"","title":"11"}}' \
--compressed 
```




## 响应
```shell
{
    "code": 200,
    "content": {
        "chartGroupPos": [],
        "chartPos": [],
        "createAt": 1677661673,
        "createdWay": "import",
        "creator": "wsak_xxxxx",
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
        "id": 712,
        "isPublic": 1,
        "mapping": [],
        "name": "modify_viewer",
        "ownerType": "viewer",
        "status": 0,
        "tagInfo": [],
        "type": "CUSTOM",
        "updateAt": 1677662433,
        "updator": "acnt_xxxx32",
        "uuid": "dsbd_xxxx32",
        "workspaceUUID": "wksp_xxxx32"
    },
    "errorCode": "",
    "message": "",
    "success": true,
    "traceId": "TRACE-A3F3DEE5-B0D3-4028-A377-8EB8A078DCA9"
} 
```




