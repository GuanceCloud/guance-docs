# Import a Note

---

<br />**POST /api/v1/notes/{notes_uuid}/import**

## Overview
Export the note specified by `notes_uuid` as a template structure. The note name in the exported template can be set based on conditions.


## Route Parameters

| Parameter Name        | Type     | Required   | Description              |
|:---------------------|:---------|:-----------|:-------------------------|
| notes_uuid           | string   | Y          | Note UUID                |


## Body Request Parameters

| Parameter Name        | Type     | Required   | Description              |
|:---------------------|:---------|:-----------|:-------------------------|
| templateInfo         | json     |            | Note template<br>Example: {} <br>Can be empty: False <br> |

## Additional Parameter Notes



## Request Example
```shell
curl 'https://openapi.<<< custom_key.brand_main_domain >>>/api/v1/notes/notes_xxxx32/import' \
-H 'DF-API-KEY: <DF-API-KEY>' \
-H 'Content-Type: application/json;charset=UTF-8' \
--data-raw '{"templateInfo": {"main": {"charts": [{"extend": {}, "name": "", "queries": [{"query": {"content": "## <<< custom_key.brand_name >>>\nA system observability platform for the cloud era\n### Temporary Note\nSupports inserting real-time charts into Markdown documents for data analysis, combined with locked time to locate specific time data, quickly creating data reports and analysis reports"}}], "type": "text"}, {"extend": {"fixedTime": null, "settings": {"chartType": "line", "colors": [], "compareTitle": "", "compareType": "", "density": "medium", "fixedTime": "", "isPercent": false, "isTimeInterval": true, "levels": [], "openCompare": false, "openStack": false, "showFieldMapping": false, "showLine": false, "showTitle": true, "stackType": "time", "timeInterval": "default", "titleDesc": "", "units": [], "xAxisShowType": "time"}}, "name": "Create Chart", "queries": [{"color": "", "datasource": "dataflux", "name": "", "qtype": "dql", "query": {"alias": "", "code": "A", "dataSource": "datakit", "field": "cpu_usage", "fieldFunc": "last", "fieldType": "float", "fill": null, "filters": [], "funcList": [], "groupBy": [], "groupByTime": "", "namespace": "metric", "q": "M::`datakit`:(LAST(`cpu_usage`)) ", "queryFuncs": [], "type": "simple"}, "type": "sequence", "unit": ""}], "type": "sequence"}]}}}' \
--compressed 
```


## Response
```shell
{
    "code": 200,
    "content": {
        "createAt": 1642588739,
        "creator": "acnt_xxxx32",
        "deleteAt": -1,
        "id": 185,
        "name": "My Note",
        "pos": [],
        "status": 0,
        "updateAt": 1642588739,
        "updator": "acnt_xxxx32",
        "uuid": "notes_xxxx32",
        "workspaceUUID": "wksp_xxxx32"
    },
    "errorCode": "",
    "message": "",
    "success": true,
    "traceId": "TRACE-63D3E8C7-D34F-40D8-B969-CED589F51AB2"
} 
```