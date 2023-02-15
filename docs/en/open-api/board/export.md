# Export a Dashboard

---

<br />**get /api/v1/dashboards/\{dashboard_uuid\}/export**

## Overview
Export the specified dashboard as a view template structure based on `dashboard_uuid`.




## Routing Parameters

| Parameter Name        | Type     | Required   | Description              |
|:-----------|:-------|:-----|:----------------|
| dashboard_uuid | string | Y | View UUID<br> |


## Supplementary Description of Parameters





## Request Example
```shell
curl 'https://openapi.guance.com/api/v1/dashboards/dsbd_88b11831870a4446894034668043eb89/export' \
-H 'DF-API-KEY: <DF-API-KEY>' \
--compressed \
--insecure
```




## Response
```shell
{
    "code": 200,
    "content": {
        "dashboardBindSet": [],
        "dashboardExtend": {},
        "dashboardMapping": [],
        "dashboardOwnerType": "node",
        "dashboardType": "CUSTOM",
        "iconSet": {},
        "main": {
            "charts": [
                {
                    "extend": {
                        "fixedTime": "",
                        "settings": {
                            "chartType": "line",
                            "colors": [],
                            "compareTitle": "",
                            "compareType": "",
                            "density": "medium",
                            "fixedTime": "",
                            "isPercent": false,
                            "isTimeInterval": true,
                            "levels": [],
                            "openCompare": false,
                            "openStack": false,
                            "showFieldMapping": false,
                            "showLine": false,
                            "showTitle": true,
                            "stackType": "time",
                            "timeInterval": "auto",
                            "titleDesc": "",
                            "units": [],
                            "xAxisShowType": "time"
                        }
                    },
                    "group": {
                        "name": null
                    },
                    "name": "cpu_idle",
                    "pos": {
                        "h": 11,
                        "i": "chrt_2e650ef84b1a4eb389011fd95f7db11e",
                        "w": 11,
                        "x": 0,
                        "y": 0
                    },
                    "queries": [
                        {
                            "color": "",
                            "datasource": "dataflux",
                            "name": "",
                            "qtype": "dql",
                            "query": {
                                "alias": "",
                                "code": "A",
                                "dataSource": "cpu",
                                "field": "usage_idle",
                                "fieldFunc": "last",
                                "fieldType": "float",
                                "fill": null,
                                "filters": [],
                                "funcList": [],
                                "groupBy": [],
                                "groupByTime": "",
                                "namespace": "metric",
                                "q": "M::`cpu`:(LAST(`usage_idle`))",
                                "queryFuncs": [],
                                "type": "simple"
                            },
                            "type": "sequence",
                            "unit": ""
                        }
                    ],
                    "type": "sequence"
                }
            ],
            "groups": [],
            "type": "template",
            "vars": []
        },
        "summary": "",
        "tagInfo": [
            {
                "id": "tag_07a3a85d01474c1585add18bfb1b5cde",
                "name": "openapi"
            },
            {
                "id": "tag_977d40b3f40c4d3f8e90956698b57c48",
                "name": "test"
            }
        ],
        "tags": [],
        "thumbnail": "",
        "title": "testt"
    },
    "errorCode": "",
    "message": "",
    "success": true,
    "traceId": "TRACE-B8114512-09F0-49F3-BC4E-6723FF37613D"
} 
```




