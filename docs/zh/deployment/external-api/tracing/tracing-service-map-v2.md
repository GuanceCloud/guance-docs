# 【链路追踪】service map （有拓扑关系和统计数据）

---

<br />**GET /api/v1/tracing/service_map_v2**

## 概述




## Query 请求参数

| 参数名        | 类型     | 必选   | 说明              |
|:-----------|:-------|:-----|:----------------|
| workspaceUUID | string | Y | 空间ID<br> |
| start | integer | Y | 开始时间, 单位 ms<br> |
| end | integer | Y | 结束时间, 单位 ms<br> |
| search | string |  | 服务名过滤<br> |
| filters | string |  | tag 过滤 跟 搜索 跟es querydata 接口一致<br> |
| isServiceSub | boolean |  | 是否为service_sub<br> |
| serviceMapList | boolean |  | 是否列出服务拓扑调用关系列表<br> |

## 参数补充说明

filters 示例如下:
```json
{
    "tags": [
        {
            "name": "__tags.__isError.keyword",
            "value": [
                "true"
            ],
            "operation": "=",
            "condition": "and"
        },
        {
            "condition": "and",
            "name": "__tags.__serviceName",
            "operation": "=~",
            "value": [
                ".*04.*"
            ]
        }
    ]
}
```






## 响应
```shell
 
```




