# Get a Note

---

<br />**GET /api/v1/notes/\{notes_uuid\}/get**

## Overview
Retrieve note details



## Route Parameters

| Parameter Name   | Type     | Required | Description              |
|:-------------|:-------|:-----|:----------------|
| notes_uuid | string | Y | Note UUID<br> |


## Additional Parameter Information





## Request Example
```shell
curl 'https://openapi.guance.com/api/v1/notes/notes_xxxx32/get' \
-H 'DF-API-KEY: <DF-API-KEY>' \
--compressed 
```




## Response
```shell
{
    "code": 200,
    "content": {
        "charts": [
            {
                "chartGroupUUID": "",
                "createAt": 1677652479,
                "creator": "acnt_xxxx32",
                "dashboardUUID": "",
                "deleteAt": -1,
                "extend": {
                    "fixedTime": "",
                    "settings": {
                        "alias": [],
                        "colors": [],
                        "direction": "vertical",
                        "fixedTime": "",
                        "isTimeInterval": false,
                        "levels": [],
                        "openCompare": false,
                        "openStack": false,
                        "showFieldMapping": false,
                        "showLine": false,
                        "showTitle": true,
                        "showTopSize": false,
                        "showTopWithMetric": "",
                        "stackContent": "group",
                        "stackType": "time",
                        "timeInterval": "default",
                        "titleDesc": "",
                        "topSize": 10,
                        "units": [],
                        "xAxisShowType": "groupBy"
                    }
                },
                "id": 3152,
                "isWorkspaceKeyIndicator": 0,
                "name": "New Chart",
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
                            "namespace": "metric",
                            "q": "",
                            "queryFuncs": [],
                            "type": "simple"
                        },
                        "type": "bar",
                        "unit": ""
                    }
                ],
                "status": 0,
                "type": "bar",
                "updateAt": 1677652479,
                "updator": "acnt_xxxx32",
                "uuid": "chrt_xxxx32",
                "workspaceUUID": "wksp_xxxx32"
            },
            {
                "chartGroupUUID": "",
                "createAt": 1677652487,
                "creator": "acnt_xxxx32",
                "dashboardUUID": "",
                "deleteAt": -1,
                "extend": {
                    "fixedTime": "",
                    "settings": {
                        "alias": [],
                        "colors": [],
                        "fixedTime": "",
                        "isTimeInterval": false,
                        "levels": [],
                        "showFieldMapping": false,
                        "showRemainingTime": true,
                        "showTitle": true,
                        "showYearlySLA": true,
                        "timeInterval": "default",
                        "titleDesc": "",
                        "units": []
                    }
                },
                "id": 3153,
                "isWorkspaceKeyIndicator": 0,
                "name": "New Chart",
                "queries": [
                    {
                        "color": "",
                        "datasource": "dataflux",
                        "name": "",
                        "qtype": "dql",
                        "query": {
                            "funcList": [],
                            "q": "M::slo:(SUM(`slo_cost`)) { `slo_id` = 'monitor_xxxx32' }",
                            "slo": {
                                "goal": 99.99,
                                "id": "monitor_xxxx32",
                                "minGoal": 95,
                                "name": "dav",
                                "workspaceUUID": ""
                            }
                        },
                        "type": "slo",
                        "unit": ""
                    }
                ],
                "status": 0,
                "type": "slo",
                "updateAt": 1677652487,
                "updator": "acnt_xxxx32",
                "uuid": "chrt_xxxx32",
                "workspaceUUID": "wksp_xxxx32"
            }
        ],
        "createAt": 1677656782,
        "creator": "wsak_xxxxx",
        "creatorInfo": {
            "email": "wsak_xxxxx",
            "iconUrl": "",
            "name": "Smart Inspection Test",
            "username": "wsak_xxxxx"
        },
        "deleteAt": -1,
        "extend": {
            "fixedTime": "15m"
        },
        "id": 45,
        "isPublic": 1,
        "name": "modify_openapi",
        "status": 0,
        "updateAt": 1677657052,
        "updator": "wsak_xxxxx",
        "updatorInfo": {
            "email": "wsak_xxxxx",
            "iconUrl": "",
            "name": "Smart Inspection Test",
            "username": "wsak_xxxxx"
        },
        "uuid": "notes_xxxx32",
        "workspaceUUID": "wksp_xxxx32"
    },
    "errorCode": "",
    "message": "",
    "success": true,
    "traceId": "TRACE-27C559AB-E46A-49F9-A676-497713E9E090"
} 
```