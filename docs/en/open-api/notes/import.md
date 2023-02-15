# Import a Note

---

<br />**post /api/v1/notes/\{notes_uuid\}/import**

## Overview
Export the notes specified by `notes_uuid` as a template structure. Note names in export templates can be set according to conditions.




## Routing Parameters

| Parameter Name        | Type     | Required   | Description              |
|:-----------|:-------|:-----|:----------------|
| notes_uuid | string | Y | Note UUID<br> |


## Body Request Parameter

| Parameter Name        | Type     | Required   | Description              |
|:-----------|:-------|:-----|:----------------|
| templateInfo | json |  | Note template<br>Example: {} <br>Allow null: False <br> |

## Supplementary Description of Parameters





## Request Example
```shell
curl 'https://openapi.guance.com/api/v1/notes/notes_4f843212aaca4c9eabb3c43ab569dbe0/import' \
-H 'DF-API-KEY: <DF-API-KEY>' \
-H 'Content-Type: application/json;charset=UTF-8' \
--data-raw '{"templateInfo": {"main": {"charts": [{"extend": {}, "name": "", "queries": [{"query": {"content": "## 观测云\n云时代的系统可观测平台\n### 临时笔记\n支持在 Markdown 文档中插入实时图表进行数据分析，结合锁定时间，定位指定时间的数据情况，快速创建数据报表、分析报告"}}], "type": "text"}, {"extend": {"fixedTime": null, "settings": {"chartType": "line", "colors": [], "compareTitle": "", "compareType": "", "density": "medium", "fixedTime": "", "isPercent": false, "isTimeInterval": true, "levels": [], "openCompare": false, "openStack": false, "showFieldMapping": false, "showLine": false, "showTitle": true, "stackType": "time", "timeInterval": "default", "titleDesc": "", "units": [], "xAxisShowType": "time"}}, "name": "新建图表", "queries": [{"color": "", "datasource": "dataflux", "name": "", "qtype": "dql", "query": {"alias": "", "code": "A", "dataSource": "datakit", "field": "cpu_usage", "fieldFunc": "last", "fieldType": "float", "fill": null, "filters": [], "funcList": [], "groupBy": [], "groupByTime": "", "namespace": "metric", "q": "M::`datakit`:(LAST(`cpu_usage`)) ", "queryFuncs": [], "type": "simple"}, "type": "sequence", "unit": ""}], "type": "sequence"}]}}}' \
--compressed \
--insecure
```




## Response
```shell
{
    "code": 200,
    "content": {
        "createAt": 1642588739,
        "creator": "acnt_5fc5bb139e474911b6d3d300863f0c8b",
        "deleteAt": -1,
        "id": 185,
        "name": "我的笔记",
        "pos": [],
        "status": 0,
        "updateAt": 1642588739,
        "updator": "acnt_5fc5bb139e474911b6d3d300863f0c8b",
        "uuid": "notes_35018053b8864ec190b3a6dbd5b44ab0",
        "workspaceUUID": "wksp_c4201f4ef30c4a86b01a998e7544f822"
    },
    "errorCode": "",
    "message": "",
    "success": true,
    "traceId": "TRACE-63D3E8C7-D34F-40D8-B969-CED589F51AB2"
} 
```




