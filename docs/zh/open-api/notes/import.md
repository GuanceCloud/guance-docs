# 导入一个笔记

---

<br />**POST /api/v1/notes/\{notes_uuid\}/import**

## 概述
将`notes_uuid`指定的笔记导出为模板结构。可根据条件设置导出模板中的笔记名称




## 路由参数

| 参数名        | 类型     | 必选   | 说明              |
|:-----------|:-------|:-----|:----------------|
| notes_uuid | string | Y | 笔记UUID<br> |


## Body 请求参数

| 参数名        | 类型     | 必选   | 说明              |
|:-----------|:-------|:-----|:----------------|
| templateInfo | json |  | 笔记模板<br>例子: {} <br>允许为空: False <br> |

## 参数补充说明





## 请求例子
```shell
curl 'https://openapi.<<< custom_key.brand_main_domain >>>/api/v1/notes/notes_xxxx32/import' \
-H 'DF-API-KEY: <DF-API-KEY>' \
-H 'Content-Type: application/json;charset=UTF-8' \
--data-raw '{"templateInfo": {"main": {"charts": [{"extend": {}, "name": "", "queries": [{"query": {"content": "## <<< custom_key.brand_name >>>\n云时代的系统可观测平台\n### 临时笔记\n支持在 Markdown 文档中插入实时图表进行数据分析，结合锁定时间，定位指定时间的数据情况，快速创建数据报表、分析报告"}}], "type": "text"}, {"extend": {"fixedTime": null, "settings": {"chartType": "line", "colors": [], "compareTitle": "", "compareType": "", "density": "medium", "fixedTime": "", "isPercent": false, "isTimeInterval": true, "levels": [], "openCompare": false, "openStack": false, "showFieldMapping": false, "showLine": false, "showTitle": true, "stackType": "time", "timeInterval": "default", "titleDesc": "", "units": [], "xAxisShowType": "time"}}, "name": "新建图表", "queries": [{"color": "", "datasource": "dataflux", "name": "", "qtype": "dql", "query": {"alias": "", "code": "A", "dataSource": "datakit", "field": "cpu_usage", "fieldFunc": "last", "fieldType": "float", "fill": null, "filters": [], "funcList": [], "groupBy": [], "groupByTime": "", "namespace": "metric", "q": "M::`datakit`:(LAST(`cpu_usage`)) ", "queryFuncs": [], "type": "simple"}, "type": "sequence", "unit": ""}], "type": "sequence"}]}}}' \
--compressed 
```




## 响应
```shell
{
    "code": 200,
    "content": {
        "createAt": 1642588739,
        "creator": "acnt_xxxx32",
        "deleteAt": -1,
        "id": 185,
        "name": "我的笔记",
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




