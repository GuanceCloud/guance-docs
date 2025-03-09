# Import a Viewer

---

<br />**POST /api/v1/viewer/\{viewer_uuid\}/import**

## Overview
Import a viewer



## Route Parameters

| Parameter Name        | Type     | Required   | Description              |
|:---------------------|:---------|:-----------|:-------------------------|
| viewer_uuid           | string   | Y          | Viewer UUID              |


## Body Request Parameters

| Parameter Name        | Type     | Required   | Description              |
|:---------------------|:---------|:-----------|:-------------------------|
| ownerType             | string   |            | View classification type, defaults to viewer<br>Example: viewer <br>Can be empty: False <br> |
| sourceDashboardUUID   | string   |            | Source view UUID<br>Example: dash-xxxxx <br>Can be empty: False <br> |
| templateInfo          | json     |            | View template<br>Example: {} <br>Can be empty: False <br> |

## Additional Parameter Explanation



## Request Example
```shell
curl 'https://openapi.guance.com/api/v1/viewer/dsbd_xxxx32/import' \
-H 'DF-API-KEY: <DF-API-KEY>' \
-H 'Content-Type: application/json;charset=UTF-8' \
--data-raw '{"templateInfo":{"dashboardBindSet":[],"dashboardExtend":{"analysisField":"message","charts":[null,{"extend":{"fixedTime":"","settings":{"alias":[],"chartType":"line","colors":[],"compareColors":{"dayCompare":"rgba(11,11,12,0.5)","hourCompare":"#0B0B0C","monthCompare":"rgba(11,11,12,0.12)","weekCompare":"rgba(11,11,12,0.3)"},"compareColorsDark":{"dayCompare":"rgba(213,217,226,0.5)","hourCompare":"#D5D9E2","monthCompare":"rgba(213,217,226,0.12)","weekCompare":"rgba(213,217,226,0.25)"},"compareColorsLight":{"dayCompare":"rgba(11,11,12,0.5)","hourCompare":"#0B0B0C","monthCompare":"rgba(11,11,12,0.12)","weekCompare":"rgba(11,11,12,0.3)"},"compareType":[],"density":"medium","fixedTime":"","isPercent":false,"isTimeInterval":true,"legendPostion":"none","legendValues":"","levels":[],"onlyShowGroupName":false,"openCompare":false,"openStack":false,"showFieldMapping":false,"showLine":false,"showTitle":true,"stackType":"time","timeInterval":"auto","titleDesc":"","units":[],"xAxisShowType":"time","yAxixMaxVal":null,"yAxixMinVal":null}},"isQuery":true,"name":"Create Chart","queries":[{"color":"","datasource":"dataflux","name":"","qtype":"dql","query":{"alias":"","code":"A","dataSource":"","field":"","fieldFunc":"","fill":null,"filters":[],"funcList":[],"groupBy":[],"groupByTime":"","indexFilter":"","namespace":"tracing","q":"","queryFuncs":[],"type":"simple"},"type":"sequence","unit":""}],"type":"sequence"},null],"filters":[],"index":"tracing","quickFilter":{"columns":[]},"rumAppId":"","rumType":"","selectedIndex":"default","source":"","table":{"columns":[]}},"dashboardMapping":[],"dashboardOwnerType":"viewer","dashboardType":"CUSTOM","iconSet":{},"main":{"charts":[],"groups":[],"type":"template","vars":[]},"summary":"","tagInfo":[],"tags":[],"thumbnail":"","title":"11"}}' \
--compressed 
```




## Response
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