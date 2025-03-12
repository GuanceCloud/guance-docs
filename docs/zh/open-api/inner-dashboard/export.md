# 导出单个用户视图

---

<br />**GET /api/v1/dashboard/\{dashboard_uuid\}/export**

## 概述
导出单个用户视图




## 路由参数

| 参数名        | 类型     | 必选   | 说明              |
|:-----------|:-------|:-----|:----------------|
| dashboard_uuid | string | Y | 视图UUID<br> |


## Query 请求参数

| 参数名        | 类型     | 必选   | 说明              |
|:-----------|:-------|:-----|:----------------|
| title | string |  | 模板名字<br>允许为空: False <br> |

## 参数补充说明

**响应主体结构说明**

|  参数名                |   type  |          说明          |
|-----------------------|----------|------------------------|
|chartGroupPos         |list |  图表组的位置信息 |
|chartPos         |list |  图表位置信息 |
|createdWay             |string |  该内置视图创建方式, 手动创建:manual,导入创建:import |
|dashboardBidding         |dict |   仪表板绑定的信息|
|name         |string |  仪表板名称 |




## 请求例子
```shell
curl 'https://openapi.<<< custom_key.brand_main_domain >>>/api/v1/dashboard/dsbd_xxxx32/export' \
-H 'DF-API-KEY: <DF-API-KEY>' \
--compressed
```




## 响应
```shell
{
    "code": 200,
    "content": {
        "dashboardBindSet": [],
        "dashboardExtend": {},
        "dashboardMapping": [],
        "dashboardOwnerType": "inner",
        "dashboardType": "CUSTOM",
        "iconSet": {
            "icon": "http://testing-static-res.dataflux.cn/dataflux-template/dashboard/zh/mysql_activity/icon.svg",
            "url": "http://testing-static-res.dataflux.cn/dataflux-template/dashboard/zh/mysql_activity/mysql_activity.png"
        },
        "main": {
            "charts": [
                {
                    "extend": {
                        "fixedTime": "",
                        "isRefresh": false,
                        "settings": {
                            "alias": [],
                            "bgColor": "",
                            "colors": [],
                            "compareTitle": "",
                            "compareType": "",
                            "currentChartType": "singlestat",
                            "downsample": "last",
                            "fixedTime": "",
                            "fontColor": "",
                            "isTimeInterval": false,
                            "levels": [],
                            "lineColor": "#3AB8FF",
                            "mappings": [],
                            "openCompare": false,
                            "precision": "2",
                            "showFieldMapping": false,
                            "showLine": false,
                            "showLineAxis": false,
                            "showTitle": true,
                            "timeInterval": "default",
                            "titleDesc": "",
                            "units": []
                        }
                    },
                    "group": {
                        "name": null
                    },
                    "name": "正在执行的SQL",
                    "pos": {
                        "h": 8,
                        "w": 6,
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
                                "dataSource": "mysql_dbm_activity",
                                "field": "*",
                                "fieldFunc": "count",
                                "fieldType": "",
                                "fill": "",
                                "filters": [
                                    {
                                        "id": "f2c11510-334a-11ed-988f-912dd8df7487",
                                        "logic": "and",
                                        "name": "host",
                                        "op": "=",
                                        "type": "keyword",
                                        "value": "#{host}"
                                    }
                                ],
                                "funcList": [],
                                "groupBy": [
                                    "query_signature"
                                ],
                                "groupByTime": "",
                                "namespace": "logging",
                                "q": "SERIES_SUM(\\\"L::`mysql_dbm_activity`:(COUNT(`*`)) { `host` = '#{host}' } BY `query_signature`\\\")",
                                "queryFuncs": [
                                    {
                                        "args": [],
                                        "name": "series_sum"
                                    }
                                ],
                                "search": "",
                                "type": "simple"
                            },
                            "type": "singlestat",
                            "unit": ""
                        }
                    ],
                    "type": "singlestat"
                },
                {
                    "extend": {
                        "fixedTime": "",
                        "isRefresh": false,
                        "settings": {
                            "alias": [],
                            "bar": {
                                "direction": "horizontal",
                                "xAxisShowType": "groupBy"
                            },
                            "chartType": "bar",
                            "color": "",
                            "colors": [],
                            "currentChartType": "toplist",
                            "fixedTime": "",
                            "isTimeInterval": false,
                            "levels": [],
                            "openCompare": false,
                            "showFieldMapping": false,
                            "showTableHead": true,
                            "showTitle": true,
                            "showTopSize": true,
                            "table": {
                                "queryMode": "toGroupColumn"
                            },
                            "tableSortMetricName": "",
                            "tableSortType": "top",
                            "timeInterval": "default",
                            "titleDesc": "",
                            "topSize": 10,
                            "units": []
                        }
                    },
                    "group": {
                        "name": null
                    },
                    "name": "Processing SQL分布",
                    "pos": {
                        "h": 17,
                        "w": 12,
                        "x": 12,
                        "y": 16
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
                                "dataSource": "mysql_dbm_activity",
                                "field": "*",
                                "fieldFunc": "count",
                                "fieldType": "",
                                "fill": "",
                                "filters": [
                                    {
                                        "id": "77936be0-334a-11ed-988f-912dd8df7487",
                                        "logic": "and",
                                        "name": "host",
                                        "op": "=",
                                        "type": "keyword",
                                        "value": "#{host}"
                                    }
                                ],
                                "funcList": [
                                    "last",
                                    "top:10"
                                ],
                                "groupBy": [
                                    "processlist_db"
                                ],
                                "groupByTime": "",
                                "namespace": "logging",
                                "q": "L::`mysql_dbm_activity`:(COUNT(`*`)) { `host` = '#{host}' } BY `processlist_db`",
                                "queryFuncs": [],
                                "search": "",
                                "type": "simple"
                            },
                            "type": "toplist",
                            "unit": ""
                        }
                    ],
                    "type": "toplist"
                },
                {
                    "extend": {
                        "fixedTime": "",
                        "isRefresh": false,
                        "settings": {
                            "alias": [],
                            "chartType": "areaLine",
                            "colors": [],
                            "compareTitle": "",
                            "compareType": "",
                            "currentChartType": "sequence",
                            "density": "medium",
                            "fixedTime": "",
                            "isPercent": false,
                            "isTimeInterval": true,
                            "legendPostion": "bottom",
                            "legendValues": [
                                "sum"
                            ],
                            "levels": [],
                            "openCompare": false,
                            "openStack": false,
                            "showFieldMapping": false,
                            "showLine": false,
                            "showTitle": true,
                            "stackType": "time",
                            "timeInterval": "default",
                            "titleDesc": "",
                            "units": [],
                            "xAxisShowType": "time"
                        }
                    },
                    "group": {
                        "name": null
                    },
                    "name": "Process by db",
                    "pos": {
                        "h": 17,
                        "w": 12,
                        "x": 0,
                        "y": 16
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
                                "dataSource": "mysql_dbm_activity",
                                "field": "processlist_command",
                                "fieldFunc": "count",
                                "fieldType": "keyword",
                                "fill": "",
                                "filters": [
                                    {
                                        "id": "21d04280-336a-11ed-a6f0-d37c49910681",
                                        "logic": "and",
                                        "name": "host",
                                        "op": "=",
                                        "type": "keyword",
                                        "value": "#{host}"
                                    }
                                ],
                                "funcList": [],
                                "groupBy": [
                                    "processlist_db"
                                ],
                                "groupByTime": "",
                                "namespace": "logging",
                                "q": "L::`mysql_dbm_activity`:(COUNT(`processlist_command`)) { `host` = '#{host}' } BY `processlist_db`",
                                "queryFuncs": [],
                                "search": "",
                                "type": "simple"
                            },
                            "type": "sequence",
                            "unit": ""
                        }
                    ],
                    "type": "sequence"
                },
                {
                    "extend": {
                        "fixedTime": "",
                        "isRefresh": false,
                        "links": [
                            {
                                "open": "newWin",
                                "show": true,
                                "type": "logging",
                                "url": "/logIndi/log/all?time=#{TR}&query=#{T}"
                            },
                            {
                                "open": "newWin",
                                "show": true,
                                "type": "container",
                                "url": "/objectadmin/docker_containers?routerTabActive=ObjectadminDocker&time=#{TR}&query=#{T}"
                            },
                            {
                                "open": "newWin",
                                "show": true,
                                "type": "processes",
                                "url": "/objectadmin/host_processes?routerTabActive=ObjectadminProcesses&time=#{TR}&query=#{T}"
                            },
                            {
                                "open": "newWin",
                                "show": true,
                                "type": "tracing",
                                "url": "/tracing/link/all?time=#{TR}&query=#{T}"
                            }
                        ],
                        "settings": {
                            "alias": [],
                            "changeWorkspace": false,
                            "chartCombineDefaultColor": "#F56610",
                            "chartType": "pie",
                            "colors": [],
                            "currentChartType": "pie",
                            "enableCombine": true,
                            "fixedTime": "",
                            "globalUnit": [],
                            "isTimeInterval": false,
                            "legendPostion": "bottom",
                            "levels": [],
                            "onlyShowGroupName": false,
                            "openThousandsSeparator": true,
                            "otherColor": "#F56610",
                            "precision": "2",
                            "showFieldMapping": false,
                            "showTitle": true,
                            "timeInterval": "default",
                            "titleDesc": "",
                            "unitType": "global",
                            "units": []
                        }
                    },
                    "group": {
                        "name": null
                    },
                    "name": "事件类型分布",
                    "pos": {
                        "h": 16,
                        "w": 6,
                        "x": 6,
                        "y": 0
                    },
                    "queries": [
                        {
                            "color": "",
                            "datasource": "dataflux",
                            "name": "",
                            "qtype": "dql",
                            "query": {
                                "alias": "统计数量",
                                "code": "A",
                                "dataSource": "mysql_dbm_activity",
                                "field": "*",
                                "fieldFunc": "count",
                                "fieldType": "keyword",
                                "fill": "",
                                "filters": [
                                    {
                                        "id": "29fa8fb0-336a-11ed-a6f0-d37c49910681",
                                        "logic": "and",
                                        "name": "host",
                                        "op": "=",
                                        "type": "keyword",
                                        "value": "#{host}"
                                    }
                                ],
                                "funcList": [],
                                "groupBy": [
                                    "wait_event",
                                    "processlist_host"
                                ],
                                "groupByTime": "",
                                "indexFilter": "default",
                                "namespace": "logging",
                                "q": "L::`mysql_dbm_activity`:(COUNT(`*`) AS `统计数量`) { `index` = 'default' and  `host` = '#{host}'  } BY `wait_event`, `processlist_host`",
                                "queryFuncs": [],
                                "search": "",
                                "type": "simple"
                            },
                            "type": "pie",
                            "unit": ""
                        }
                    ],
                    "type": "pie"
                },
                {
                    "extend": {
                        "fixedTime": "",
                        "isRefresh": false,
                        "settings": {
                            "alias": [],
                            "chartType": "doughnut",
                            "colors": [],
                            "currentChartType": "pie",
                            "fixedTime": "",
                            "isTimeInterval": false,
                            "legendPostion": "bottom",
                            "levels": [],
                            "showFieldMapping": false,
                            "showTitle": true,
                            "timeInterval": "default",
                            "titleDesc": "",
                            "units": []
                        }
                    },
                    "group": {
                        "name": null
                    },
                    "name": "事件状态分布",
                    "pos": {
                        "h": 16,
                        "w": 6,
                        "x": 12,
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
                                "dataSource": "mysql_dbm_activity",
                                "field": "wait_event",
                                "fieldFunc": "count",
                                "fieldType": "keyword",
                                "fill": "",
                                "filters": [
                                    {
                                        "id": "3336c210-336a-11ed-a6f0-d37c49910681",
                                        "logic": "and",
                                        "name": "host",
                                        "op": "=",
                                        "type": "keyword",
                                        "value": "#{host}"
                                    }
                                ],
                                "funcList": [
                                    "last"
                                ],
                                "groupBy": [
                                    "processlist_state",
                                    "processlist_host"
                                ],
                                "groupByTime": "",
                                "namespace": "logging",
                                "q": "L::`mysql_dbm_activity`:(COUNT(`wait_event`)) { `host` = '#{host}' } BY `processlist_state`, `processlist_host`",
                                "queryFuncs": [],
                                "search": "",
                                "type": "simple"
                            },
                            "type": "pie",
                            "unit": ""
                        }
                    ],
                    "type": "pie"
                },
                {
                    "extend": {
                        "fixedTime": "",
                        "isRefresh": false,
                        "settings": {
                            "alias": [],
                            "colors": [],
                            "currentChartType": "table",
                            "fixedTime": "",
                            "isTimeInterval": false,
                            "levels": [],
                            "pageSize": 0,
                            "queryMode": "toGroupColumn",
                            "showFieldMapping": false,
                            "showTitle": true,
                            "timeInterval": "default",
                            "titleDesc": "",
                            "units": [
                                {
                                    "key": "锁时间",
                                    "name": "锁时间",
                                    "unit": "",
                                    "units": [
                                        "time",
                                        "ns"
                                    ]
                                },
                                {
                                    "key": "事件执行时间",
                                    "name": "事件执行时间",
                                    "unit": "",
                                    "units": [
                                        "time",
                                        "ns"
                                    ]
                                }
                            ],
                            "valColorMappings": [],
                            "valMappings": []
                        }
                    },
                    "group": {
                        "name": null
                    },
                    "name": "事件 TOP 100",
                    "pos": {
                        "h": 29,
                        "w": 24,
                        "x": 0,
                        "y": 33
                    },
                    "queries": [
                        {
                            "color": "",
                            "datasource": "dataflux",
                            "disabled": false,
                            "name": "",
                            "qtype": "dql",
                            "query": {
                                "alias": "DB Host",
                                "code": "A",
                                "dataSource": "mysql_dbm_activity",
                                "field": "server",
                                "fieldFunc": "count",
                                "fieldType": "keyword",
                                "fill": "",
                                "filters": [
                                    {
                                        "id": "1b8f6f70-3362-11ed-a6f0-d37c49910681",
                                        "logic": "and",
                                        "name": "host",
                                        "op": "=",
                                        "type": "keyword",
                                        "value": "#{host}"
                                    }
                                ],
                                "funcList": [
                                    "last",
                                    "top:100"
                                ],
                                "groupBy": [
                                    "processlist_id",
                                    "processlist_user"
                                ],
                                "groupByTime": "",
                                "indexFilter": "default",
                                "namespace": "logging",
                                "q": "L::`mysql_dbm_activity`:(COUNT(`server`) AS `DB Host`) { `index` = 'default' and  `host` = '#{host}'  } BY `processlist_id`, `processlist_user`",
                                "queryFuncs": [],
                                "search": "",
                                "type": "simple"
                            },
                            "type": "table",
                            "unit": ""
                        },
                        {
                            "color": "",
                            "datasource": "dataflux",
                            "name": "",
                            "qtype": "dql",
                            "query": {
                                "alias": "SQL",
                                "code": "B",
                                "dataSource": "mysql_dbm_activity",
                                "field": "sql_text",
                                "fieldFunc": "count",
                                "fieldType": "keyword",
                                "fill": "",
                                "filters": [
                                    {
                                        "id": "1b8f6f70-3362-11ed-a6f0-d37c49910681",
                                        "logic": "and",
                                        "name": "host",
                                        "op": "=",
                                        "type": "keyword",
                                        "value": "#{host}"
                                    }
                                ],
                                "funcList": [
                                    "last"
                                ],
                                "groupBy": [
                                    "processlist_id",
                                    "processlist_user"
                                ],
                                "groupByTime": "",
                                "indexFilter": "default",
                                "namespace": "logging",
                                "q": "L::`mysql_dbm_activity`:(COUNT(`sql_text`) AS `SQL`) { `index` = 'default' and  `host` = '#{host}'  } BY `processlist_id`, `processlist_user`",
                                "queryFuncs": [],
                                "search": "",
                                "type": "simple"
                            },
                            "type": "table",
                            "unit": ""
                        },
                        {
                            "color": "",
                            "datasource": "dataflux",
                            "disabled": false,
                            "name": "",
                            "qtype": "dql",
                            "query": {
                                "alias": "Process Host",
                                "code": "G",
                                "dataSource": "mysql_dbm_activity",
                                "field": "processlist_host",
                                "fieldFunc": "count",
                                "fieldType": "keyword",
                                "fill": "",
                                "filters": [
                                    {
                                        "id": "1b8f6f70-3362-11ed-a6f0-d37c49910681",
                                        "logic": "and",
                                        "name": "host",
                                        "op": "=",
                                        "type": "keyword",
                                        "value": "#{host}"
                                    }
                                ],
                                "funcList": [
                                    "last"
                                ],
                                "groupBy": [
                                    "processlist_id",
                                    "processlist_user"
                                ],
                                "groupByTime": "",
                                "indexFilter": "default",
                                "namespace": "logging",
                                "q": "L::`mysql_dbm_activity`:(COUNT(`processlist_host`) AS `Process Host`) { `index` = 'default' and  `host` = '#{host}'  } BY `processlist_id`, `processlist_user`",
                                "queryFuncs": [],
                                "search": "",
                                "type": "simple"
                            },
                            "type": "table",
                            "unit": ""
                        },
                        {
                            "color": "",
                            "datasource": "dataflux",
                            "name": "",
                            "qtype": "dql",
                            "query": {
                                "alias": "Command Type",
                                "code": "C",
                                "dataSource": "mysql_dbm_activity",
                                "field": "processlist_command",
                                "fieldFunc": "count",
                                "fieldType": "keyword",
                                "fill": "",
                                "filters": [
                                    {
                                        "id": "1b8f6f70-3362-11ed-a6f0-d37c49910681",
                                        "logic": "and",
                                        "name": "host",
                                        "op": "=",
                                        "type": "keyword",
                                        "value": "#{host}"
                                    }
                                ],
                                "funcList": [
                                    "last"
                                ],
                                "groupBy": [
                                    "processlist_id",
                                    "processlist_user"
                                ],
                                "groupByTime": "",
                                "indexFilter": "default",
                                "namespace": "logging",
                                "q": "L::`mysql_dbm_activity`:(COUNT(`processlist_command`) AS `Command Type`) { `index` = 'default' and  `host` = '#{host}'  } BY `processlist_id`, `processlist_user`",
                                "queryFuncs": [],
                                "search": "",
                                "type": "simple"
                            },
                            "type": "table",
                            "unit": ""
                        },
                        {
                            "color": "",
                            "datasource": "dataflux",
                            "name": "",
                            "qtype": "dql",
                            "query": {
                                "alias": "Command State",
                                "code": "D",
                                "dataSource": "mysql_dbm_activity",
                                "field": "processlist_state",
                                "fieldFunc": "count",
                                "fieldType": "keyword",
                                "fill": "",
                                "filters": [
                                    {
                                        "id": "1b8f6f70-3362-11ed-a6f0-d37c49910681",
                                        "logic": "and",
                                        "name": "host",
                                        "op": "=",
                                        "type": "keyword",
                                        "value": "#{host}"
                                    }
                                ],
                                "funcList": [
                                    "last"
                                ],
                                "groupBy": [
                                    "processlist_id",
                                    "processlist_user"
                                ],
                                "groupByTime": "",
                                "indexFilter": "default",
                                "namespace": "logging",
                                "q": "L::`mysql_dbm_activity`:(COUNT(`processlist_state`) AS `Command State`) { `index` = 'default' and  `host` = '#{host}'  } BY `processlist_id`, `processlist_user`",
                                "queryFuncs": [],
                                "search": "",
                                "type": "simple"
                            },
                            "type": "table",
                            "unit": ""
                        },
                        {
                            "color": "",
                            "datasource": "dataflux",
                            "name": "",
                            "qtype": "dql",
                            "query": {
                                "alias": "schema",
                                "code": "E",
                                "dataSource": "mysql_dbm_activity",
                                "field": "current_schema",
                                "fieldFunc": "count",
                                "fieldType": "keyword",
                                "fill": "",
                                "filters": [
                                    {
                                        "id": "1b8f6f70-3362-11ed-a6f0-d37c49910681",
                                        "logic": "and",
                                        "name": "host",
                                        "op": "=",
                                        "type": "keyword",
                                        "value": "#{host}"
                                    }
                                ],
                                "funcList": [
                                    "last"
                                ],
                                "groupBy": [
                                    "processlist_id",
                                    "processlist_user"
                                ],
                                "groupByTime": "",
                                "indexFilter": "default",
                                "namespace": "logging",
                                "q": "L::`mysql_dbm_activity`:(COUNT(`current_schema`) AS `schema`) { `index` = 'default' and  `host` = '#{host}'  } BY `processlist_id`, `processlist_user`",
                                "queryFuncs": [],
                                "search": "",
                                "type": "simple"
                            },
                            "type": "table",
                            "unit": ""
                        },
                        {
                            "color": "",
                            "datasource": "dataflux",
                            "name": "",
                            "qtype": "dql",
                            "query": {
                                "alias": "锁时间",
                                "code": "F",
                                "dataSource": "mysql_dbm_activity",
                                "field": "lock_time",
                                "fieldFunc": "avg",
                                "fieldType": "long",
                                "fill": "",
                                "filters": [
                                    {
                                        "id": "1b8f6f70-3362-11ed-a6f0-d37c49910681",
                                        "logic": "and",
                                        "name": "host",
                                        "op": "=",
                                        "type": "keyword",
                                        "value": "#{host}"
                                    }
                                ],
                                "funcList": [
                                    "last"
                                ],
                                "groupBy": [
                                    "processlist_id",
                                    "processlist_user"
                                ],
                                "groupByTime": "",
                                "indexFilter": "default",
                                "namespace": "logging",
                                "q": "L::`mysql_dbm_activity`:(AVG(`lock_time`) AS `锁时间`) { `index` = 'default' and  `host` = '#{host}'  } BY `processlist_id`, `processlist_user`",
                                "queryFuncs": [],
                                "search": "",
                                "type": "simple"
                            },
                            "type": "table",
                            "unit": ""
                        },
                        {
                            "color": "",
                            "datasource": "dataflux",
                            "name": "",
                            "qtype": "dql",
                            "query": {
                                "alias": "事件执行时间",
                                "code": "H",
                                "dataSource": "mysql_dbm_activity",
                                "field": "event_timer_wait",
                                "fieldFunc": "avg",
                                "fieldType": "long",
                                "fill": "",
                                "filters": [
                                    {
                                        "id": "1b8f6f70-3362-11ed-a6f0-d37c49910681",
                                        "logic": "and",
                                        "name": "host",
                                        "op": "=",
                                        "type": "keyword",
                                        "value": "#{host}"
                                    }
                                ],
                                "funcList": [
                                    "last"
                                ],
                                "groupBy": [
                                    "processlist_id",
                                    "processlist_user"
                                ],
                                "groupByTime": "",
                                "indexFilter": "default",
                                "namespace": "logging",
                                "q": "L::`mysql_dbm_activity`:(AVG(`event_timer_wait`) AS `事件执行时间`) { `index` = 'default' and  `host` = '#{host}'  } BY `processlist_id`, `processlist_user`",
                                "queryFuncs": [],
                                "search": "",
                                "type": "simple"
                            },
                            "type": "table",
                            "unit": ""
                        }
                    ],
                    "type": "table"
                },
                {
                    "extend": {
                        "fixedTime": "",
                        "isRefresh": false,
                        "settings": {
                            "alias": [],
                            "chartType": "doughnut",
                            "colors": [],
                            "currentChartType": "pie",
                            "fixedTime": "",
                            "isTimeInterval": false,
                            "legendPostion": "bottom",
                            "levels": [],
                            "showFieldMapping": false,
                            "showTitle": true,
                            "timeInterval": "default",
                            "titleDesc": "",
                            "units": []
                        }
                    },
                    "group": {
                        "name": null
                    },
                    "name": "事件 Command type 分布",
                    "pos": {
                        "h": 16,
                        "w": 6,
                        "x": 18,
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
                                "dataSource": "mysql_dbm_activity",
                                "field": "*",
                                "fieldFunc": "count",
                                "fieldType": "",
                                "fill": "",
                                "filters": [
                                    {
                                        "id": "3dbd9ce0-336a-11ed-a6f0-d37c49910681",
                                        "logic": "and",
                                        "name": "host",
                                        "op": "=",
                                        "type": "keyword",
                                        "value": "#{host}"
                                    }
                                ],
                                "funcList": [
                                    "last"
                                ],
                                "groupBy": [
                                    "processlist_command",
                                    "host"
                                ],
                                "groupByTime": "",
                                "namespace": "logging",
                                "q": "L::`mysql_dbm_activity`:(COUNT(`*`)) { `host` = '#{host}' } BY `processlist_command`, `host`",
                                "queryFuncs": [],
                                "search": "",
                                "type": "simple"
                            },
                            "type": "pie",
                            "unit": ""
                        }
                    ],
                    "type": "pie"
                },
                {
                    "extend": {
                        "fixedTime": "",
                        "isRefresh": true,
                        "settings": {
                            "alias": [],
                            "bgColor": "",
                            "colors": [],
                            "compareTitle": "",
                            "compareType": "",
                            "currentChartType": "singlestat",
                            "downsample": "last",
                            "fixedTime": "",
                            "fontColor": "",
                            "isTimeInterval": false,
                            "levels": [],
                            "lineColor": "#3AB8FF",
                            "mappings": [],
                            "openCompare": false,
                            "precision": "2",
                            "showFieldMapping": false,
                            "showLine": false,
                            "showLineAxis": false,
                            "showTitle": true,
                            "timeInterval": "default",
                            "titleDesc": "",
                            "units": [
                                {
                                    "key": "max(event_timer_wait)",
                                    "name": "max(event_timer_wait)",
                                    "unit": "",
                                    "units": [
                                        "time",
                                        "ns"
                                    ]
                                }
                            ]
                        }
                    },
                    "group": {
                        "name": null
                    },
                    "name": "事件最大执行时间",
                    "pos": {
                        "h": 8,
                        "w": 6,
                        "x": 0,
                        "y": 8
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
                                "dataSource": "mysql_dbm_activity",
                                "field": "event_timer_wait",
                                "fieldFunc": "max",
                                "fieldType": "long",
                                "fill": null,
                                "fillNum": null,
                                "filters": [
                                    {
                                        "id": "9a5b29b0-33e0-11ed-a6f0-d37c49910681",
                                        "logic": "and",
                                        "name": "host",
                                        "op": "=",
                                        "value": "#{host}"
                                    }
                                ],
                                "funcList": [],
                                "groupBy": [],
                                "groupByTime": "",
                                "namespace": "logging",
                                "q": "L::`mysql_dbm_activity`:(MAX(`event_timer_wait`)) { `host` = '#{host}' }",
                                "queryFuncs": [],
                                "type": "simple",
                                "withLabels": []
                            },
                            "type": "singlestat",
                            "unit": ""
                        }
                    ],
                    "type": "singlestat"
                }
            ],
            "groups": [],
            "type": "template",
            "vars": [
                {
                    "code": "host",
                    "datasource": "dataflux",
                    "definition": {
                        "defaultVal": {
                            "label": "*",
                            "value": "re(`.*`)"
                        },
                        "field": "",
                        "metric": "",
                        "object": "",
                        "tag": "",
                        "value": "show_tag_value(from=['mysql'],keyin=['host'])"
                    },
                    "hide": 0,
                    "isHiddenAsterisk": 0,
                    "name": "host",
                    "seq": 0,
                    "type": "QUERY",
                    "valueSort": "default"
                }
            ]
        },
        "summary": "",
        "tagInfo": [],
        "thumbnail": "",
        "title": "Mysql Activity 监控视图111111"
    },
    "errorCode": "",
    "message": "",
    "success": true,
    "traceId": "TRACE-A35365F3-6744-4C2B-8817-AAFDD8D55758"
} 
```




