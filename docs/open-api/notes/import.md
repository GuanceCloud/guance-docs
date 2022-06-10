# 导入一个笔记

<br />**post /api/v1/notes/\{notes_uuid\}/import**

## 概述
将`notes_uuid`指定的笔记导出为模版结构。可根据条件设置导出模版中的笔记名称




## 路由参数

| 参数名        | 类型     | 必选   | 说明              |
|:-----------|:-------|:-----|:----------------|
| notes_uuid | string | Y | 笔记UUID<br> |


## Body 请求参数

| 参数名        | 类型     | 必选   | 说明              |
|:-----------|:-------|:-----|:----------------|
| templateInfo | json |  | 笔记模版<br>例子: {} <br>允许为空: False <br> |

## 参数补充说明





## 请求例子
```shell
curl '<Endpoint>/api/v1/notes/notes_4f843212aaca4c9eabb3c43ab569dbe0/import' \
-H 'DF-API-KEY: <DF-API-KEY>' \
-H 'Content-Type: application/json;charset=UTF-8' \
--data-raw '{"templateInfo": {"main": {"charts": [{"extend": {}, "name": "", "queries": [{"query": {"content": "## 观测云\n云时代的系统可观测平台\n### 临时笔记\n支持在 Markdown 文档中插入实时图表进行数据分析，结合锁定时间，定位指定时间的数据情况，快速创建数据报表、分析报告"}}], "type": "text"}, {"extend": {"fixedTime": null, "settings": {"chartType": "line", "colors": [], "compareTitle": "", "compareType": "", "density": "medium", "fixedTime": "", "isPercent": false, "isTimeInterval": true, "levels": [], "openCompare": false, "openStack": false, "showFieldMapping": false, "showLine": false, "showTitle": true, "stackType": "time", "timeInterval": "default", "titleDesc": "", "units": [], "xAxisShowType": "time"}}, "name": "新建图表", "queries": [{"color": "", "datasource": "dataflux", "name": "", "qtype": "dql", "query": {"alias": "", "code": "A", "dataSource": "datakit", "field": "cpu_usage", "fieldFunc": "last", "fieldType": "float", "fill": null, "filters": [], "funcList": [], "groupBy": [], "groupByTime": "", "namespace": "metric", "q": "M::`datakit`:(LAST(`cpu_usage`)) ", "queryFuncs": [], "type": "simple"}, "type": "sequence", "unit": ""}], "type": "sequence"}]}}}' \
--compressed \
--insecure
```




## 响应
```python
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




