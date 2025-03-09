# Import a Dashboard

---

<br />**POST /api/v1/dashboards/\{dashboard_uuid\}/import**

## Overview
Reset the content of the dashboard corresponding to `dashboard_uuid` based on the content of `templateInfo`. After the operation is completed, the UUID of the view will change, and charts and view variables within the view will be rebuilt. At this point, the shared resources within the original view will become invalid. The content of `templateInfo` can match the `content` field in the response result of the [Export Dashboard API].

## Route Parameters

| Parameter Name        | Type     | Required | Description              |
|:---------------------|:---------|:---------|:-------------------------|
| dashboard_uuid        | string   | Y        | View UUID                |

## Body Request Parameters

| Parameter Name        | Type     | Required | Description              |
|:---------------------|:---------|:---------|:-------------------------|
| templateInfo          | json     |          | View template<br>Example: {} <br>Can be empty: False <br> |
| specifyDashboardUUID  | string   |          | Specify the UUID for the new dashboard, which must start with `dsbd_custom_` followed by 32 lowercase letters or digits.<br>Example: dsbd_custom_xxxx32 <br>Can be empty: False <br>Can be an empty string: False <br>$matchRegExp: ^dsbd_custom_[a-z0-9]{32}$ <br> |

## Additional Parameter Notes



## Request Example
```shell
curl 'https://openapi.guance.com/api/v1/dashboards/dsbd_xxxx32/import' \
-H 'DF-API-KEY: <DF-API-KEY>' \
-H 'Content-Type: application/json;charset=UTF-8' \
--data-raw '{"templateInfo": {"dashboardBindSet": [], "dashboardExtend": {}, "dashboardMapping": [], "dashboardOwnerType": "node", "dashboardType": "CUSTOM", "iconSet": {}, "main": {"charts": [{"extend": {"fixedTime": "", "settings": {"chartType": "line", "colors": [], "compareTitle": "", "compareType": "", "currentChartType": "sequence", "density": "medium", "fixedTime": "", "isPercent": false, "isTimeInterval": true, "levels": [], "openCompare": false, "openStack": false, "showFieldMapping": false, "showLine": false, "showTitle": true, "stackType": "time", "timeInterval": "default", "titleDesc": "", "units": [{"key": "max(worker_queue_count)", "name": "max(worker_queue_count)", "unit": "1414", "units": ["custom", "1414"]}], "xAxisShowType": "time"}}, "group": {"name": null}, "name": "Web User Login Count", "pos": {"h": 12, "i": "chrt_xxxx32", "w": 12, "x": 0, "y": 0}, "queries": [{"color": "", "datasource": "dataflux", "name": "", "qtype": "dql", "query": {"alias": "", "code": "A", "dataSource": "df_studio", "field": "worker_queue_count", "fieldFunc": "max", "fieldType": "float", "fill": null, "fillNum": 0, "filters": [], "funcList": [], "groupBy": ["queue"], "groupByTime": "", "namespace": "metric", "q": "M::`df_studio`:(MAX(`worker_queue_count`)) BY `queue`", "queryFuncs": [], "type": "simple"}, "type": "sequence", "unit": ""}], "type": "sequence"}, {"extend": {"fixedTime": "", "settings": {"chartType": "line", "colors": [], "compareTitle": "", "compareType": "", "currentChartType": "sequence", "density": "medium", "fixedTime": "", "isPercent": false, "isTimeInterval": true, "levels": [], "openCompare": false, "openStack": false, "showFieldMapping": false, "showLine": false, "showTitle": true, "stackType": "time", "timeInterval": "default", "titleDesc": "", "units": [], "xAxisShowType": "time"}}, "group": {"name": null}, "name": "Mobile User Login Count", "pos": {"h": 12, "i": "chrt_xxxx32", "w": 12, "x": 12, "y": 0}, "queries": [{"color": "", "datasource": "dataflux", "name": "", "qtype": "dql", "query": {"alias": "", "code": "A", "dataSource": "df_studio", "field": "mobile_total_logged_user_count", "fieldFunc": "sum", "fieldType": "float", "fill": null, "fillNum": 0, "filters": [], "funcList": [], "groupBy": [], "groupByTime": "", "namespace": "metric", "q": "M::`df_studio`:(SUM(`mobile_total_logged_user_count`)) ", "queryFuncs": [], "type": "simple"}, "type": "sequence", "unit": ""}], "type": "sequence"}, {"extend": {"fixedTime": "", "settings": {"chartType": "line", "colors": [], "compareTitle": "", "compareType": "", "currentChartType": "sequence", "density": "medium", "fixedTime": "", "isPercent": false, "isTimeInterval": true, "levels": [], "openCompare": false, "openStack": false, "showFieldMapping": false, "showLine": false, "showTitle": true, "stackType": "time", "timeInterval": "default", "titleDesc": "", "units": [], "xAxisShowType": "time"}}, "group": {"name": null}, "name": "Celery Task Wait Count", "pos": {"h": 11, "i": "chrt_xxxx32", "w": 12, "x": 0, "y": 12}, "queries": [{"color": "", "datasource": "dataflux", "name": "", "qtype": "dql", "query": {"alias": "", "code": "A", "dataSource": "df_studio", "field": "worker_queue_count", "fieldFunc": "sum", "fieldType": "float", "fill": null, "filters": [], "funcList": [], "groupBy": ["queue"], "groupByTime": "", "namespace": "metric", "q": "M::`df_studio`:(SUM(`worker_queue_count`))  BY `queue`", "queryFuncs": [], "type": "simple"}, "type": "sequence", "unit": ""}], "type": "sequence"}, {"extend": {"fixedTime": "", "settings": {"chartType": "line", "colors": [], "compareTitle": "", "compareType": "", "density": "medium", "fixedTime": "", "isPercent": false, "isTimeInterval": true, "levels": [], "openCompare": false, "openStack": false, "showFieldMapping": false, "showLine": false, "showTitle": true, "stackType": "time", "timeInterval": "auto", "titleDesc": "", "units": [], "xAxisShowType": "time"}}, "group": {"name": null}, "name": "New Chart", "pos": {"h": 10, "i": "chrt_xxxx32", "w": 8, "x": 12, "y": 12}, "queries": [{"color": "", "datasource": "dataflux", "name": "", "qtype": "dql", "query": {"alias": "", "code": "A", "dataSource": "df_studio", "field": "api_request_count", "fieldFunc": "min", "fieldType": "float", "fill": null, "filters": [], "funcList": [], "groupBy": ["api_path"], "groupByTime": "", "namespace": "metric", "q": "M::`df_studio`:(MIN(`api_request_count`))  BY `api_path`", "queryFuncs": [], "type": "simple"}, "type": "sequence", "unit": ""}], "type": "sequence"}, {"extend": {"fixedTime": "", "settings": {"bar": {"direction": "horizontal", "xAxisShowType": "groupBy"}, "chartType": "bar", "color": "", "colors": [], "fixedTime": "", "isTimeInterval": false, "levels": [], "openCompare": false, "showFieldMapping": false, "showTableHead": true, "showTitle": true, "showTopSize": true, "table": {"queryMode": "toGroupColumn"}, "tableSortMetricName": "", "tableSortType": "top", "timeInterval": "default", "titleDesc": "", "topSize": 10, "units": []}}, "group": {"name": null}, "name": "New Chart", "pos": {"h": 10, "i": "chrt_xxxx32", "w": 8, "x": 0, "y": 23}, "queries": [{"color": "", "datasource": "dataflux", "name": "", "qtype": "dql", "query": {"alias": "", "code": "A", "dataSource": "df_studio", "field": "api_request_count", "fieldFunc": "last", "fieldType": "float", "fill": null, "filters": [], "funcList": ["last", "top:10"], "groupBy": ["api_path"], "groupByTime": "", "namespace": "metric", "q": "M::`df_studio`:(LAST(`api_request_count`))  BY `api_path`", "queryFuncs": [], "type": "simple"}, "type": "toplist", "unit": ""}], "type": "toplist"}, {"extend": {"fixedTime": "", "settings": {"chartType": "line", "colors": [], "compareTitle": "", "compareType": "", "density": "medium", "fixedTime": "", "isPercent": false, "isTimeInterval": true, "levels": [], "openCompare": false, "openStack": false, "showFieldMapping": false, "showLine": false, "showTitle": true, "stackType": "time", "timeInterval": "auto", "titleDesc": "", "units": [], "xAxisShowType": "time"}}, "group": {"name": null}, "name": "New Chart", "pos": {"h": 10, "i": "chrt_xxxx32", "w": 8, "x": 13, "y": 22}, "queries": [{"color": "", "datasource": "dataflux", "name": "", "qtype": "dql", "query": {"alias": "", "code": "A", "dataSource": "df_studio", "field": "api_request_count", "fieldFunc": "last", "fieldType": "float", "fill": null, "filters": [], "funcList": [], "groupBy": ["api_path"], "groupByTime": "", "namespace": "metric", "q": "M::`df_studio`:(LAST(`api_request_count`)) BY `api_path`", "queryFuncs": [], "type": "simple"}, "type": "sequence", "unit": ""}], "type": "sequence"}], "groups": [], "type": "template", "vars": []}, "summary": "", "tagInfo": [], "tags": [], "thumbnail": "", "title": "aaabbb"}}' \
--compressed 
```

## Response
```shell
{
    "code": 200,
    "content": {
        "chartGroupPos": [],
        "chartPos": [
            {
                "chartUUID": "chrt_xxxx32",
                "pos": {
                    "h": 12,
                    "i": "chrt_xxxx32",
                    "w": 12,
                    "x": 0,
                    "y": 0
                }
            },
            {
                "chartUUID": "chrt_xxxx32",
                "pos": {
                    "h": 12,
                    "i": "chrt_xxxx32",
                    "w": 12,
                    "x": 12,
                    "y": 0
                }
            }
        ],
        "createAt": 1641523675,
        "createdWay": "import",
        "creator": "acnt_xxxx32",
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
        "uuid": "dsbd_xxxx32",
        "workspaceUUID": "wksp_xxxx32"
    },
    "errorCode": "",
    "message": "",
    "success": true,
    "traceId": "TRACE-8BEC6672-D79C-407B-80FC-6AD717DFFA6E"
}
```