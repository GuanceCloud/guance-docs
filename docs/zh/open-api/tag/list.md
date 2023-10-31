# 获取全局标签列表

---

<br />**GET /api/v1/tag/list**

## 概述
获取全局标签列表




## Query 请求参数

| 参数名        | 类型     | 必选   | 说明              |
|:-----------|:-------|:-----|:----------------|
| search | string |  | tag名称搜索<br>允许为空: False <br> |
| filter | string |  | 过滤条件<br>允许为空: False <br>可选值: ['BoardRefTagObject', 'ViewerRefTagObject', 'CheckerRefTagObject'] <br> |
| pageIndex | integer |  | 页码<br>允许为空: False <br>例子: 10 <br>$minValue: 1 <br> |
| pageSize | integer |  | 每页返回数量<br>允许为空: False <br>例子: 10 <br>$minValue: 1 <br>$maxValue: 10000 <br> |

## 参数补充说明





## 请求例子
```shell
curl 'https://openapi.guance.com/api/v1/tag/list?pageIndex=1&pageSize=2' \
-H 'DF-API-KEY: <DF-API-KEY>' \
--compressed
```




## 响应
```shell
{
    "code": 200,
    "content": [
        {
            "colour": "style_key3",
            "description": "temp_test",
            "id": "tag_1e2950a080c949039285a5edfce12cd4",
            "name": "test_ha"
        },
        {
            "colour": "default",
            "description": "",
            "id": "tag_8576f3cb07c1449f8b7a9dc6146300dd",
            "name": "ssssooooo"
        }
    ],
    "errorCode": "",
    "message": "",
    "pageInfo": {
        "count": 2,
        "pageIndex": 1,
        "pageSize": 2,
        "totalCount": 101
    },
    "success": true,
    "traceId": "TRACE-F2F9D0F5-FEF4-4C37-AB9E-B901CD0E5931"
} 
```




