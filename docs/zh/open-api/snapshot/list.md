# 获取快照列表

---

<br />**GET /api/v1/snapshots/list**

## 概述
获取当前工作空间的快照列表




## Query 请求参数

| 参数名        | 类型     | 必选   | 说明              |
|:-----------|:-------|:-----|:----------------|
| type | string |  | 类型筛选<br>允许为空: False <br> |
| search | string |  | 搜索快照名<br>允许为空: False <br> |
| pageIndex | integer |  | 页码<br>允许为空: False <br>例子: 1 <br>$minValue: 1 <br> |
| pageSize | integer |  | 每页返回数量<br>允许为空: False <br>例子: 10 <br>$minValue: 1 <br>$maxValue: 100 <br> |

## 参数补充说明


*数据说明*

**1. 快照类型 说明**

|key|说明|
|---|----|
|logging|日志查看器|
|keyevent|事件查看器|
|tracing|链路查看器|
|object|基础设施看器|
|dialing_task|云拨测查看器|
|security|安全巡检查看器|
|rum|用户访问监测查看器|
|measurement|指标查看器|
|scene_dashboard|场景视图|
|dashboard|用户自定义视图|




## 请求例子
```shell
curl 'https://openapi.<<< custom_key.brand_main_domain >>>/api/v1/snapshots/list?pageIndex=1&pageSize=2' \
-H 'DF-API-KEY: <DF-API-KEY>' \
--compressed 
```




## 响应
```shell
{
    "code": 200,
    "content": [
        {
            "accountUUID": "acnt_xxxx32",
            "content": {
                "routeName": "Log",
                "routeParams": {
                    "source": "others"
                },
                "routeQuery": {
                    "tags": "{\\\"source\\\":[\\\"python_ddtrace_log_ee\\\"]}",
                    "time": "1629713566000,1629714466999"
                }
            },
            "createAt": 1629714466,
            "creator": "acnt_xxxx32",
            "deleteAt": -1,
            "id": 435,
            "name": "fa",
            "status": 0,
            "type": "logging",
            "updateAt": 1629714466,
            "updator": "acnt_xxxx32",
            "uuid": "snap_xxxx32",
            "workspaceUUID": "wksp_xxxx32"
        }
    ],
    "errorCode": "",
    "message": "",
    "pageInfo": {
        "count": 1,
        "pageIndex": 1,
        "pageSize": 3,
        "totalCount": 1
    },
    "success": true,
    "traceId": "TRACE-EF64E702-8660-4D45-94B9-F058FCB00E17"
} 
```




