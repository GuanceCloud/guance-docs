# Export a Dashboard

---

<br />**GET /api/v1/dashboards/\{dashboard_uuid\}/export**

## Overview
Export the specified dashboard as a view template structure based on the `dashboard_uuid`.

## Route Parameters

| Parameter Name       | Type   | Required | Description              |
|:-------------------|:------|:-------|:-------------------------|
| dashboard_uuid     | string | Y      | View UUID                |

## Additional Parameter Notes

## Request Example
```shell
curl 'https://openapi.<<< custom_key.brand_main_domain >>>/api/v1/dashboards/dsbd_xxxx32/export' \
-H 'DF-API-KEY: <DF-API-KEY>' \
--compressed 
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
                        "i": "chrt_xxxx32",
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
                "id": "tag_xxxx32",
                "name": "openapi"
            },
            {
                "id": "tag_xxxx32",
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