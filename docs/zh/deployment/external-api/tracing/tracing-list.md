# 【链路追踪】apm 服务列表

---

<br />**GET /api/v1/tracing/list**

## 概述




## Query 请求参数

| 参数名        | 类型     | 必选   | 说明              |
|:-----------|:-------|:-----|:----------------|
| workspaceUUID | string | Y | 空间ID<br> |
| start | integer | Y | 时间 开始 单位 ms<br> |
| end | integer | Y | 时间 结束 单位 ms<br> |
| filters | json |  | tag 过滤 跟 搜索 跟es querydata 接口一致<br> |
| serviceTypes | array |  | 过滤服务类型列表<br> |
| order | string |  | 按资源名排序, 格式`[{key:desc/asc}]`<br> |
| pageIndex | integer |  | 页码<br>允许为空: False <br>例子: 10 <br>$minValue: 1 <br> |
| pageSize | integer |  | 每页返回数量<br>允许为空: False <br>例子: 10 <br>$minValue: 1 <br>$maxValue: 100 <br> |

## 参数补充说明







## 响应
```shell
 
```




