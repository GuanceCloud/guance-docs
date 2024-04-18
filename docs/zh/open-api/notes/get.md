# 获取一个笔记

---

<br />**GET /api/v1/notes/\{notes_uuid\}/get**

## 概述
获取笔记详情




## 路由参数

| 参数名        | 类型     | 必选   | 说明              |
|:-----------|:-------|:-----|:----------------|
| notes_uuid | string | Y | 笔记UUID<br> |


## 参数补充说明





## 请求例子
```shell
curl 'https://openapi.guance.com/api/v1/notes/notes_7f074ca6505543e39020826d84ad6687/get' \
-H 'DF-API-KEY: <DF-API-KEY>' \
--compressed 
```




## 响应
```shell
{
    "code": 200,
    "content": {
        "charts": [
            {
                "chartGroupUUID": "",
                "createAt": 1677652479,
                "creator": "acnt_349ee5f70a89442fa94b4f754b5acbfe",
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
                "updator": "acnt_349ee5f70a89442fa94b4f754b5acbfe",
                "uuid": "chrt_2f5ed3d1f82f47aca57e2bd6a1dc7179",
                "workspaceUUID": "wksp_ed134a6485c8484dbd0e58ce9a9c6115"
            },
            {
                "chartGroupUUID": "",
                "createAt": 1677652487,
                "creator": "acnt_349ee5f70a89442fa94b4f754b5acbfe",
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
                "name": "新建图表",
                "queries": [
                    {
                        "color": "",
                        "datasource": "dataflux",
                        "name": "",
                        "qtype": "dql",
                        "query": {
                            "funcList": [],
                            "q": "M::slo:(SUM(`slo_cost`)) { `slo_id` = 'monitor_88fdeb353ec148b0af63a74a4d75bccf' }",
                            "slo": {
                                "goal": 99.99,
                                "id": "monitor_88fdeb353ec148b0af63a74a4d75bccf",
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
                "updator": "acnt_349ee5f70a89442fa94b4f754b5acbfe",
                "uuid": "chrt_4e078c1343b0448889909335faab9b99",
                "workspaceUUID": "wksp_ed134a6485c8484dbd0e58ce9a9c6115"
            }
        ],
        "createAt": 1677656782,
        "creator": "wsak_xxxxx",
        "creatorInfo": {
            "email": "wsak_xxxxx",
            "iconUrl": "",
            "name": "智能巡检测试",
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
            "name": "智能巡检测试",
            "username": "wsak_xxxxx"
        },
        "uuid": "notes_7f074ca6505543e39020826d84ad6687",
        "workspaceUUID": "wksp_ed134a6485c8484dbd0e58ce9a9c6115"
    },
    "errorCode": "",
    "message": "",
    "success": true,
    "traceId": "TRACE-27C559AB-E46A-49F9-A676-497713E9E090"
} 
```




