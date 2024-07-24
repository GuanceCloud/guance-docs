# 导入一个仪表板

---

<br />**POST /api/v1/dashboards/\{dashboard_uuid\}/import**

## 概述
根据`templateInfo`内容重置`dashboard_uuid`对应的仪表板内容，操作完成之后视图UUID比变，视图内的图表，视图变量等将重建。此时原视图内的分享资源将失效;
`templateInfo`内容可与【导出仪表板接口】响应结果中`content`字段内容保持一致




## 路由参数

| 参数名        | 类型     | 必选   | 说明              |
|:-----------|:-------|:-----|:----------------|
| dashboard_uuid | string | Y | 视图UUID<br> |


## Body 请求参数

| 参数名        | 类型     | 必选   | 说明              |
|:-----------|:-------|:-----|:----------------|
| templateInfo | json |  | 视图模板<br>例子: {} <br>允许为空: False <br> |
| specifyDashboardUUID | string |  | 指定新建仪表板的uuid, 必须以`dsbd_custom_`为前缀后接 32 位长度的小写字母数字<br>例子: dsbd_custom_a70974b902424baea1ddeead2db87278 <br>允许为空: False <br>允许空字符串: False <br>$matchRegExp: ^dsbd_custom_[a-z0-9]{32}$ <br> |

## 参数补充说明





## 请求例子
```shell
curl 'https://openapi.guance.com/api/v1/dashboards/dsbd_f3859af942c3466cb50b7f6d83f72a8e/import' \
-H 'DF-API-KEY: <DF-API-KEY>' \
-H 'Content-Type: application/json;charset=UTF-8' \
--data-raw '{"templateInfo": {"dashboardBindSet": [], "dashboardExtend": {}, "dashboardMapping": [], "dashboardOwnerType": "node", "dashboardType": "CUSTOM", "iconSet": {}, "main": {"charts": [{"extend": {"fixedTime": "", "settings": {"chartType": "line", "colors": [], "compareTitle": "", "compareType": "", "currentChartType": "sequence", "density": "medium", "fixedTime": "", "isPercent": false, "isTimeInterval": true, "levels": [], "openCompare": false, "openStack": false, "showFieldMapping": false, "showLine": false, "showTitle": true, "stackType": "time", "timeInterval": "default", "titleDesc": "", "units": [{"key": "max(worker_queue_count)", "name": "max(worker_queue_count)", "unit": "1414", "units": ["custom", "1414"]}], "xAxisShowType": "time"}}, "group": {"name": null}, "name": "web用户登录数", "pos": {"h": 12, "i": "chrt_cc01a0943fc642d080784eab44f26d58", "w": 12, "x": 0, "y": 0}, "queries": [{"color": "", "datasource": "dataflux", "name": "", "qtype": "dql", "query": {"alias": "", "code": "A", "dataSource": "df_studio", "field": "worker_queue_count", "fieldFunc": "max", "fieldType": "float", "fill": null, "fillNum": 0, "filters": [], "funcList": [], "groupBy": ["queue"], "groupByTime": "", "namespace": "metric", "q": "M::`df_studio`:(MAX(`worker_queue_count`)) BY `queue`", "queryFuncs": [], "type": "simple"}, "type": "sequence", "unit": ""}], "type": "sequence"}, {"extend": {"fixedTime": "", "settings": {"chartType": "line", "colors": [], "compareTitle": "", "compareType": "", "currentChartType": "sequence", "density": "medium", "fixedTime": "", "isPercent": false, "isTimeInterval": true, "levels": [], "openCompare": false, "openStack": false, "showFieldMapping": false, "showLine": false, "showTitle": true, "stackType": "time", "timeInterval": "default", "titleDesc": "", "units": [], "xAxisShowType": "time"}}, "group": {"name": null}, "name": "mobile用户登录数", "pos": {"h": 12, "i": "chrt_539f27aa578b4aa6b5b1cc61e85de913", "w": 12, "x": 12, "y": 0}, "queries": [{"color": "", "datasource": "dataflux", "name": "", "qtype": "dql", "query": {"alias": "", "code": "A", "dataSource": "df_studio", "field": "mobile_total_logged_user_count", "fieldFunc": "sum", "fieldType": "float", "fill": null, "fillNum": 0, "filters": [], "funcList": [], "groupBy": [], "groupByTime": "", "namespace": "metric", "q": "M::`df_studio`:(SUM(`mobile_total_logged_user_count`)) ", "queryFuncs": [], "type": "simple"}, "type": "sequence", "unit": ""}], "type": "sequence"}, {"extend": {"fixedTime": "", "settings": {"chartType": "line", "colors": [], "compareTitle": "", "compareType": "", "currentChartType": "sequence", "density": "medium", "fixedTime": "", "isPercent": false, "isTimeInterval": true, "levels": [], "openCompare": false, "openStack": false, "showFieldMapping": false, "showLine": false, "showTitle": true, "stackType": "time", "timeInterval": "default", "titleDesc": "", "units": [], "xAxisShowType": "time"}}, "group": {"name": null}, "name": "celery任务等待数", "pos": {"h": 11, "i": "chrt_d1277f1a7fb04511ad80567fc65dfdbc", "w": 12, "x": 0, "y": 12}, "queries": [{"color": "", "datasource": "dataflux", "name": "", "qtype": "dql", "query": {"alias": "", "code": "A", "dataSource": "df_studio", "field": "worker_queue_count", "fieldFunc": "sum", "fieldType": "float", "fill": null, "filters": [], "funcList": [], "groupBy": ["queue"], "groupByTime": "", "namespace": "metric", "q": "M::`df_studio`:(SUM(`worker_queue_count`))  BY `queue`", "queryFuncs": [], "type": "simple"}, "type": "sequence", "unit": ""}], "type": "sequence"}, {"extend": {"fixedTime": "", "settings": {"chartType": "line", "colors": [], "compareTitle": "", "compareType": "", "density": "medium", "fixedTime": "", "isPercent": false, "isTimeInterval": true, "levels": [], "openCompare": false, "openStack": false, "showFieldMapping": false, "showLine": false, "showTitle": true, "stackType": "time", "timeInterval": "auto", "titleDesc": "", "units": [], "xAxisShowType": "time"}}, "group": {"name": null}, "name": "新建图表", "pos": {"h": 10, "i": "chrt_f98ff660585e4c97bdd813ce03b6c527", "w": 8, "x": 12, "y": 12}, "queries": [{"color": "", "datasource": "dataflux", "name": "", "qtype": "dql", "query": {"alias": "", "code": "A", "dataSource": "df_studio", "field": "api_request_count", "fieldFunc": "min", "fieldType": "float", "fill": null, "filters": [], "funcList": [], "groupBy": ["api_path"], "groupByTime": "", "namespace": "metric", "q": "M::`df_studio`:(MIN(`api_request_count`))  BY `api_path`", "queryFuncs": [], "type": "simple"}, "type": "sequence", "unit": ""}], "type": "sequence"}, {"extend": {"fixedTime": "", "settings": {"bar": {"direction": "horizontal", "xAxisShowType": "groupBy"}, "chartType": "bar", "color": "", "colors": [], "fixedTime": "", "isTimeInterval": false, "levels": [], "openCompare": false, "showFieldMapping": false, "showTableHead": true, "showTitle": true, "showTopSize": true, "table": {"queryMode": "toGroupColumn"}, "tableSortMetricName": "", "tableSortType": "top", "timeInterval": "default", "titleDesc": "", "topSize": 10, "units": []}}, "group": {"name": null}, "name": "新建图表", "pos": {"h": 10, "i": "chrt_c27f0185bfca4cbb84261974b1e2bf2f", "w": 8, "x": 0, "y": 23}, "queries": [{"color": "", "datasource": "dataflux", "name": "", "qtype": "dql", "query": {"alias": "", "code": "A", "dataSource": "df_studio", "field": "api_request_count", "fieldFunc": "last", "fieldType": "float", "fill": null, "filters": [], "funcList": ["last", "top:10"], "groupBy": ["api_path"], "groupByTime": "", "namespace": "metric", "q": "M::`df_studio`:(LAST(`api_request_count`))  BY `api_path`", "queryFuncs": [], "type": "simple"}, "type": "toplist", "unit": ""}], "type": "toplist"}, {"extend": {"fixedTime": "", "settings": {"chartType": "line", "colors": [], "compareTitle": "", "compareType": "", "density": "medium", "fixedTime": "", "isPercent": false, "isTimeInterval": true, "levels": [], "openCompare": false, "openStack": false, "showFieldMapping": false, "showLine": false, "showTitle": true, "stackType": "time", "timeInterval": "auto", "titleDesc": "", "units": [], "xAxisShowType": "time"}}, "group": {"name": null}, "name": "新建图表", "pos": {"h": 10, "i": "chrt_f11b0935b6af491882f04a08b729a9e4", "w": 8, "x": 13, "y": 22}, "queries": [{"color": "", "datasource": "dataflux", "name": "", "qtype": "dql", "query": {"alias": "", "code": "A", "dataSource": "df_studio", "field": "api_request_count", "fieldFunc": "last", "fieldType": "float", "fill": null, "filters": [], "funcList": [], "groupBy": ["api_path"], "groupByTime": "", "namespace": "metric", "q": "M::`df_studio`:(LAST(`api_request_count`)) BY `api_path`", "queryFuncs": [], "type": "simple"}, "type": "sequence", "unit": ""}], "type": "sequence"}], "groups": [], "type": "template", "vars": []}, "summary": "", "tagInfo": [], "tags": [], "thumbnail": "", "title": "aaabbb"}}' \
--compressed 
```




## 响应
```shell
{
    "code": 200,
    "content": {
        "chartGroupPos": [],
        "chartPos": [
            {
                "chartUUID": "chrt_f697685475ee43b0993a0ed5c5572a9b",
                "pos": {
                    "h": 12,
                    "i": "chrt_cc01a0943fc642d080784eab44f26d58",
                    "w": 12,
                    "x": 0,
                    "y": 0
                }
            },
            {
                "chartUUID": "chrt_ca7419b0ad294a7983b247d5d9f8efd5",
                "pos": {
                    "h": 12,
                    "i": "chrt_539f27aa578b4aa6b5b1cc61e85de913",
                    "w": 12,
                    "x": 12,
                    "y": 0
                }
            }
        ],
        "createAt": 1641523675,
        "createdWay": "import",
        "creator": "acnt_b7c7e774766611ebb1435a810562cdd6",
        "dashboardBindSet": [],
        "deleteAt": -1,
        "extend": {},
        "iconSet": {},
        "id": 2384,
        "mapping": [],
        "name": "pjy-demo",
        "ownerType": "node",
        "status": 0,
        "tagInfo": [],
        "type": "CUSTOM",
        "updateAt": 1642666541,
        "updator": "wsak_xxxxx",
        "uuid": "dsbd_f3859af942c3466cb50b7f6d83f72a8e",
        "workspaceUUID": "wksp_2dc431d6693711eb8ff97aeee04b54af"
    },
    "errorCode": "",
    "message": "",
    "success": true,
    "traceId": "TRACE-8BEC6672-D79C-407B-80FC-6AD717DFFA6E"
} 
```




